package com.cartmatic.estoresf.webapp.decorator;

import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import com.cartmatic.estore.webapp.util.RequestContext;
import com.opensymphony.module.sitemesh.Config;
import com.opensymphony.module.sitemesh.Decorator;
import com.opensymphony.module.sitemesh.DecoratorMapper;
import com.opensymphony.module.sitemesh.Page;
import com.opensymphony.module.sitemesh.mapper.AbstractDecoratorMapper;

/**
 * 支持模板包的实现。主要的处理在TemplateSetConfigLoader里面。
 * <P>
 * 主要修改：主要在init方法内；使用定制的ConfigLoader来处理，并且其受Spring管理。提供Refresh功能。
 * <P>
 * 原理：Sitemesh.xml在decorator-mappers定义多个mapper，形成一个列表（运行时处理顺序与定义时的相反）并构成parent的关系；<BR/>
 * 大部分的Mapper的getDecorator方法最终都是调用parent.getNamedDecorator，而只有ConfigDecoratorMapper和FileDecoratorMapper
 * <BR/>有getNamedDecorator的实现，后者我们不用。所以也就是说所有的decorator的名称和路径都是在decorator.xml里面维护的，
 * <BR/>所以我们只要扩展ConfigDecoratorMapper加上动态的模板包支持即可，其他的Mapper也自动支持。
 * <P>
 * 
 * @author Ryan
 */
public class TemplateConfigDecoratorMapper extends AbstractDecoratorMapper 
{
	private TemplateConfigLoader configLoader = null;

	/**
	 * Retrieve {@link com.opensymphony.module.sitemesh.Decorator} based on
	 * 'pattern' tag.
	 */
	public Decorator getDecorator(HttpServletRequest request, Page page) {
		String thisPath = request.getServletPath();

		// getServletPath() returns null unless the mapping corresponds to a
		// servlet
		if (thisPath == null) {
			String requestURI = request.getRequestURI();
			if (request.getPathInfo() != null) {
				// strip the pathInfo from the requestURI
				thisPath = requestURI.substring(0, requestURI.indexOf(request
						.getPathInfo()));
			} else {
				thisPath = requestURI;
			}
		} else if ("".equals(thisPath)) {
			// in servlet 2.4, if a request is mapped to '/*', getServletPath
			// returns null (SIM-130)
			thisPath = request.getPathInfo();
		}

		String name = null;
		try {
			name = configLoader.getMappedName(thisPath, RequestContext.getCurrentStoreCode());
		} catch (ServletException e) {
			e.printStackTrace();
		}

		Decorator result = getNamedDecorator(request, name);
		return result == null ? super.getDecorator(request, page) : result;
	}

	/**
	 * Retrieve Decorator named in 'name' attribute. Checks the role if
	 * specified.
	 */
	public Decorator getNamedDecorator(HttpServletRequest request, String name) {
		Decorator result = null;
		try {
			result = configLoader.getDecoratorByName(name, RequestContext.getCurrentStoreCode());
		} catch (ServletException e) {
			e.printStackTrace();
		}

		if (result == null
				|| (result.getRole() != null && !request.isUserInRole(result
						.getRole()))) {
			// if the result is null or the user is not in the role
			return super.getNamedDecorator(request, name);
		} else {
			return result;
		}
	}

	/** Create new ConfigLoader using '/WEB-INF/decorators.xml' file. */
	public void init(Config config, Properties properties, DecoratorMapper parent) throws InstantiationException 
	{
		super.init(config, properties, parent);
		try
		{
			configLoader = new TemplateConfigLoader();
		}
		catch (ServletException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new InstantiationException(e.getMessage());			
		} 
	}
}

