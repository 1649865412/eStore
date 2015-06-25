<%@page language="java" isErrorPage="true" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/I18n.tld" prefix="i18n"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%!private final static transient org.apache.commons.logging.Log logger = org.apache.commons.logging.LogFactory.getLog("404_jsp");%>
<%
	String errorUrl = com.cartmatic.estore.webapp.util.RequestUtil.getErrorUrl(request);
	//boolean isContent = (errorUrl.endsWith(".html") || errorUrl.endsWith(".jsp") || errorUrl.endsWith("/"));
    boolean isMedia = (errorUrl.endsWith(".jpg") || errorUrl.endsWith(".gif") || errorUrl.endsWith(".png") || errorUrl.endsWith(".js") || errorUrl.endsWith(".css"));
    if (!isMedia)
    {
        logger.warn("Requested url not found: " + errorUrl+" Referrer: "+request.getHeader("REFERER"));
    }
    else{
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		return;
	}

	if (errorUrl==null) {
		logger.warn("Error page cannot find javax.servlet.error.request_uri attribute");
		errorUrl=request.getRequestURL().toString();
	} else {
		//acegi will throw NullPointerException when user click logout but session is already timeout.
		if (errorUrl.indexOf("j_acegi_logout")!=-1) {
			response.sendRedirect(request.getContextPath());
		}
	}
	logger.warn("Error processing url:"+errorUrl);
	Throwable ex = (Exception) request.getAttribute("exception");
	if (ex==null) {
	    logger.warn("Probably an JSP compilation/runtime exception, check the debug info which may help identifying the error.");
		ex = (Exception)request.getAttribute("javax.servlet.error.exception");
		if (ex==null && exception != null) {
			ex = exception;
		}
	} else {
	    logger.warn("Probably an exception caught by Spring MVC, check the debug info which may help identifying the error.");
	}
	if (ex!=null) {
	    logger.warn("Detailed JSP Exception:",ex);
	}
	if (logger.isInfoEnabled()) {
	    logger.info("##########Start of debuging request and session data for url:" + errorUrl);
	    logger.info("!!!!!!!!!!Debuging request.getParameterNames()!!!!!!!!!!");
	    java.util.Enumeration enumeration = request.getParameterNames();
	    while (enumeration.hasMoreElements()) {
	        String paramName = (String)enumeration.nextElement();
	        logger.info("Request Parameter - " + paramName+ " : "+ request.getParameter(paramName));
	    }

	    logger.info("!!!!!!!!!!Debuging request.getAttributeNames()!!!!!!!!!!");
	    enumeration = request.getAttributeNames();
	    while (enumeration.hasMoreElements()) {
	        String attrName = (String)enumeration.nextElement();
	        if (!attrName.endsWith("exception")) {
	        	logger.info("Request Attribute - " + attrName+ " : "+ request.getAttribute(attrName));
	        }
	    }

	    logger.info("!!!!!!!!!!Debuging request.getHeaderNames()!!!!!!!!!!");
	    enumeration = request.getHeaderNames();
	    while (enumeration.hasMoreElements()) {
	        String headerName = (String) enumeration.nextElement();
	        logger.info("Request HeaderName - " + headerName + " : "  + request.getHeader(headerName));
	    }
	    if (session != null) {
	        logger.info("!!!!!!!!!!Debuging session.getAttributeNames()!!!!!!!!!!");
	        enumeration = session.getAttributeNames();
	        while (enumeration.hasMoreElements()) {
		        String attrName = (String)enumeration.nextElement();
	    	    logger.info("Session Attribute - " + attrName+ " : "+ session.getAttribute(attrName));
	        }
	        logger.info("##########End of debuging request and session data for url:" + errorUrl);
	    }
	}	
	response.flushBuffer();
%>
<script type="text/javascript">
//document.location="${ctxPath}/404.html";
</script>