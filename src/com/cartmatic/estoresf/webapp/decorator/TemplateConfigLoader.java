package com.cartmatic.estoresf.webapp.decorator;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;
import org.xml.sax.SAXException;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.core.util.ContextUtil;
import com.opensymphony.module.sitemesh.Decorator;
import com.opensymphony.module.sitemesh.mapper.DefaultDecorator;
import com.opensymphony.module.sitemesh.mapper.PathMapper;

public class TemplateConfigLoader
{
	//private File configFile = null;
	//private String configFileName = null;
	private static final String default_code = "default";
	private Map<String,Map<String,Decorator>> storeDecorators = new HashMap<String,Map<String,Decorator>>();
	private Map<String,PathMapper> storePathMapper = new HashMap<String,PathMapper>();
	private Collection<String> storeCodes = ConfigUtil.getInstance().getAllStoreCodes();
	
	//private 
	//private Map decorators = null;
	//private PathMapper pathMapper = null;
	
	/**
	 * Override default behavior of element.getAttribute (returns the empty
	 * string) to return null.
	 */
	private static String getAttribute(Element element, String name) 
	{
		if (element != null && element.getAttribute(name) != null && element.getAttribute(name).trim() != "")
		{
			return element.getAttribute(name).trim();
		}
		else
		{
			return null;
		}
	}

	/**
	 * With a given parent XML Element, find the text contents of the child
	 * element with supplied name.
	 */
	private static String getContainedText(Node parent, String childTagName) 
	{
		try
		{
			Node tag = ((Element) parent).getElementsByTagName(childTagName).item(0);
			String text = ((Text) tag.getFirstChild()).getData();
			return text;
		}
		catch (Exception e)
		{
			return null;
		}
	}

	/** Create new ConfigLoader using supplied filename and config. */
	public TemplateConfigLoader() throws ServletException
	{
		loadConfig();
	}

	/** Retrieve Decorator based on name specified in configuration file. */
	public Decorator getDecoratorByName(String name, String code) throws ServletException {
		Map<String,Decorator> dec = storeDecorators.get(code);
		if (dec == null)
		{
			dec = storeDecorators.get(default_code);
		}
		return dec.get(name);
	}

	/** Get name of Decorator mapped to given path. */
	public String getMappedName(String path, String code) throws ServletException {
		PathMapper mapper = storePathMapper.get(code);
		if (mapper == null)
			mapper = storePathMapper.get(default_code);
		return mapper.get(path);
	}

	/** Load configuration from file. */
	private synchronized void loadConfig() throws ServletException {
		// 修改说明：令到配置文件decorator.xml可以在模板的目录下，如/WEB-INF/templates/default/decorators/decorator.xml；
		//忽略sitemesh.xml里面的路径(configFileName)
		
		for (String code:storeCodes)
		{
			String configFileName = "/WEB-INF/templates/"+ code +"/decorators/decorators.xml";
			if (!ContextUtil.getInstance().isFileExists(configFileName))
			{
				continue;
			}
			File configFile = new File(ContextUtil.getServletContext().getRealPath(configFileName));
			try
			{
				// Build a document from the file
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				Document document = null;
				if (configFile != null && configFile.canRead())
				{
					document = builder.parse(configFile);
				}
				else
				{
					document = builder.parse(ContextUtil.getServletContext().getResourceAsStream(configFileName));
				}

				// Parse the configuration document
				parseConfig(document, code);
			}
			catch (ParserConfigurationException e)
			{
				throw new ServletException("Could not get XML parser", e);
			}
			catch (IOException e)
			{
				throw new ServletException("Could not read the config file: " + configFileName, e);
			}
			catch (SAXException e)
			{
				throw new ServletException("Could not parse the config file: " + configFileName, e);
			}
			catch (IllegalArgumentException e)
			{
				throw new ServletException("Could not find the config file: " + configFileName, e);
			}
		}
		
	}

	/** Parse configuration from XML document. */
	private synchronized void parseConfig(Document document, String code) 
	{
		Element root = document.getDocumentElement();

		// get the default directory for the decorators
		// 改动说明：在defaultDir增加当前使用的模板包的路径（注意，不是session里面的，所以动态切换后会影响所有用户）
		// String defaultDir = ContextUtil.getInstance().getTsPath() +
		// "/decorators";
		String defaultDir = "/WEB-INF/templates/"+ code + getAttribute(root, "defaultdir");

		// Clear previous config
		//PathMapper pathMapper = new PathMapper();
		//Map decorators = new HashMap();

		// Get decorators
		NodeList decoratorNodes = root.getElementsByTagName("decorator");
		Element decoratorElement = null;

		for (int i = 0; i < decoratorNodes.getLength(); i++)
		{
			String name = null, page = null, uriPath = null, role = null;

			// get the current decorator element
			decoratorElement = (Element) decoratorNodes.item(i);

			if (getAttribute(decoratorElement, "name") != null)
			{
				// The new format is used
				name = getAttribute(decoratorElement, "name");
				page = getAttribute(decoratorElement, "page");
				uriPath = getAttribute(decoratorElement, "webapp");
				role = getAttribute(decoratorElement, "role");

				// Append the defaultDir
				if (page != null && page.length() > 0 && !page.startsWith("/"))
				{
					if (page.charAt(0) == '/')
						page = defaultDir + page;
					else
						page = defaultDir + '/' + page;
				}

				// The uriPath must begin with a slash
				if (uriPath != null && uriPath.length() > 0)
				{
					if (uriPath.charAt(0) != '/')
						uriPath = '/' + uriPath;
				}

				// Get all <pattern>...</pattern> and
				// <url-pattern>...</url-pattern> nodes and add a mapping
				populatePathMapper(decoratorElement.getElementsByTagName("pattern"), role, name, code);
				populatePathMapper(decoratorElement.getElementsByTagName("url-pattern"), role, name, code);
			}
			else
			{
				// NOTE: Deprecated format
				name = getContainedText(decoratorNodes.item(i), "decorator-name");
				page = getContainedText(decoratorNodes.item(i), "resource");
				// We have this here because the use of jsp-file is deprecated,
				// but we still want
				// it to work.
				if (page == null)
					page = getContainedText(decoratorNodes.item(i), "jsp-file");
			}

			Map<String,String> params = new HashMap<String,String>();

			NodeList paramNodes = decoratorElement.getElementsByTagName("init-param");
			for (int ii = 0; ii < paramNodes.getLength(); ii++)
			{
				String paramName = getContainedText(paramNodes.item(ii), "param-name");
				String paramValue = getContainedText(paramNodes.item(ii), "param-value");
				params.put(paramName, paramValue);
			}
			storeDecorator(new DefaultDecorator(name, page, uriPath, role, params), code);
		}

		// Get (deprecated format) decorator-mappings
		NodeList mappingNodes = root.getElementsByTagName("decorator-mapping");
		for (int i = 0; i < mappingNodes.getLength(); i++)
		{
			Element n = (Element) mappingNodes.item(i);
			String name = getContainedText(mappingNodes.item(i), "decorator-name");

			// Get all <url-pattern>...</url-pattern> nodes and add a mapping
			populatePathMapper(n.getElementsByTagName("url-pattern"), null, name, code);
		}
	}

	/**
	 * Extracts each URL pattern and adds it to the pathMapper map.
	 */
	private void populatePathMapper(NodeList patternNodes, String role, String name, String storeCode) {
		for (int j = 0; j < patternNodes.getLength(); j++)
		{
			Element p = (Element) patternNodes.item(j);
			Text patternText = (Text) p.getFirstChild();
			if (patternText != null)
			{
				String pattern = patternText.getData().trim();
				if (pattern != null)
				{
					PathMapper mapper = storePathMapper.get(storeCode);
					if (mapper == null)
					{
						mapper = new PathMapper();
						storePathMapper.put(storeCode, mapper);
					}
						
					if (role != null)
					{
						// concatenate name and role to allow more
						// than one decorator per role
						mapper.put(name + role, pattern);
					}
					else
					{
						mapper.put(name, pattern);
					}
				}
			}
		}
	}

	/** Store Decorator in Map */
	private void storeDecorator(Decorator d , String storeCode) {
		Map<String, Decorator> dec = storeDecorators.get(storeCode);
		if (dec == null)
		{
			dec = new HashMap<String, Decorator>();
			storeDecorators.put(storeCode, dec);
		}
		if (d.getRole() != null)
		{
			dec.put(d.getName() + d.getRole(), d);
		}
		else
		{
			dec.put(d.getName(), d);
		}
	}
	
	/** Check if configuration file has been updated, and if so, reload. */
	public synchronized void refresh() throws ServletException {
		loadConfig();
	}
}