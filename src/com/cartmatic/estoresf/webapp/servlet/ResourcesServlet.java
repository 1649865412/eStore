package com.cartmatic.estoresf.webapp.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.webapp.util.RequestContext;

public class ResourcesServlet extends HttpServlet implements Servlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//private static final String resources = "/resources";
	protected final transient Log logger = LogFactory.getLog(ResourcesServlet.class);

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public ResourcesServlet() {
		super();
	}

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest arg0,
	 * HttpServletResponse arg1)
	 */
	@Override
	protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		doPost(arg0, arg1);
		// TODO Auto-generated method stub
	}

	/*
	 * (non-Java-doc)
	 * 
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest arg0,
	 * HttpServletResponse arg1)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri=request.getRequestURI();
		File file=null;
		if(uri.startsWith("/sitemap")){
			file=readSitemapFile(request, response);
		}else{
			file=readResourceFile(request, response);
		}
		outPutFile(file, response);
	}
	
	private File readSitemapFile(HttpServletRequest request,HttpServletResponse response)  throws ServletException, IOException {
		File file;
		RequestContext.setCurrentHttpRequest(request);
		Store store=ConfigUtil.getInstance().getStore();
		String reqPath = URLDecoder.decode(request.getRequestURI(), Constants.DEFAULT_ENCODING);
		String path=ConfigUtil.getInstance().getAssetsPath()+"/sitemap/"+store.getCode();
		String filePath=null;
		if(reqPath.startsWith("/sitemap.xml")){
			 filePath = path+ reqPath;
		}else{
			 filePath = path+ reqPath.substring(reqPath.indexOf("/sitemap") + "/sitemap".length());
		}
		
		RequestContext.clearCurrentHttpRequest();
		// System.out.println("filePath:"+filePath);
		if (logger.isDebugEnabled())
		{
			logger.debug("filePath:" + filePath);
		}
		file = new File(filePath);
		return file;
	}

	private File readResourceFile(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		File file;
		RequestContext.setCurrentHttpRequest(request);
		
		String reqPath = URLDecoder.decode(request.getRequestURI(), Constants.DEFAULT_ENCODING);
		String filePath =   getServletContext().getRealPath(RequestContext.getCurrentTemplatePath() + reqPath);
		
		RequestContext.clearCurrentHttpRequest();
		// System.out.println("filePath:"+filePath);
		if (logger.isDebugEnabled())
		{
			logger.debug("filePath:" + filePath);
		}
		file = new File(filePath);
		if (!file.exists() || !file.isFile()) { // set file to default template.
			String defPath = getServletContext().getRealPath(RequestContext.getDefaultTemplatePath() + reqPath);
			file = new File(defPath);
		}
		return file;
	}
	
	private void outPutFile(File file,HttpServletResponse response)throws ServletException, IOException{
		FileInputStream in = null;
		try {
			if (!file.exists() || !file.isFile()) { // Must be a file
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
			in = new FileInputStream(file);
		} 
		catch (FileNotFoundException e) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		catch (SecurityException se) { // Be unavailable permanently
			//throw (new ServletException("Servlet lacks appropriate privileges."));
			response.setStatus(HttpServletResponse.SC_NOT_ACCEPTABLE);
			return;
		}

		String mimeType = getServletContext().getMimeType(file.getAbsolutePath());

		// response.setContentType("text/html");
		response.setContentType(mimeType);
		OutputStream out = response.getOutputStream();
		byte[] buf = new byte[1024];
		int count = 0;
		while ((count = in.read(buf)) >= 0)
		{
			out.write(buf, 0, count);
		}
		in.close();
		out.close();
	}
}