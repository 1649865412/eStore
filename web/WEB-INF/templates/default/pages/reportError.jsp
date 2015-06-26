<%@ page language="java" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/I18n.tld" prefix="i18n" %>

<%!private final static transient org.apache.commons.logging.Log logger = org.apache.commons.logging.LogFactory
            .getLog("reportError_jsp");

    %>

<% 
//TODO, a bug report form, and attach the stack trace in a hidden field with the bug report, and remove these code
String errorUrl = com.cartmatic.estore.webapp.util.RequestUtil.getErrorUrl(request);
if (errorUrl==null) {
	logger.warn("Error page cannot find javax.servlet.error.request_uri attribute");
	errorUrl=request.getRequestURL().toString();
} else {
	//acegi will throw NullPointerException when user click logout but session is already timeout.
	if (errorUrl.indexOf("j_acegi_logout")!=-1) {
		response.sendRedirect(request.getContextPath());
	}
}
logger.error("Error processing url:"+errorUrl);

Throwable ex = (Exception) request.getAttribute("exception");
if (ex==null) {
    logger.error("Probably an JSP compilation/runtime exception, check the debug info which may help identifying the error.");

	ex = (Exception)request.getAttribute("javax.servlet.error.exception");
	if (ex==null && exception != null) {
		ex = exception;
	}
} else {
    logger.error("Probably an exception caught by Spring MVC, check the debug info which may help identifying the error.");
}

if (ex!=null) {
    logger.error("Detailed JSP Exception:",ex);
}

if (logger.isInfoEnabled()) {
    logger
            .info("##########Start of debuging request and session data for url:"
                    + errorUrl);
    logger
            .info("!!!!!!!!!!Debuging request.getParameterNames()!!!!!!!!!!");
    java.util.Enumeration enumeration = request.getParameterNames();
    while (enumeration.hasMoreElements()) {
        String paramName = (String)enumeration.nextElement();
        logger.info("Request Parameter - " + paramName+ " : "+ request.getParameter(paramName));
    }

    logger
            .info("!!!!!!!!!!Debuging request.getAttributeNames()!!!!!!!!!!");
    enumeration = request.getAttributeNames();
    while (enumeration.hasMoreElements()) {
        String attrName = (String)enumeration.nextElement();
        if (!attrName.endsWith("exception")) {
        	logger.info("Request Attribute - " + attrName+ " : "+ request.getAttribute(attrName));
        }
    }

    logger
            .info("!!!!!!!!!!Debuging request.getHeaderNames()!!!!!!!!!!");
    enumeration = request.getHeaderNames();
    while (enumeration.hasMoreElements()) {
        String headerName = (String) enumeration.nextElement();
        logger.info("Request HeaderName - " + headerName + " : "
                + request.getHeader(headerName));
    }

    if (session != null) {
        logger
                .info("!!!!!!!!!!Debuging session.getAttributeNames()!!!!!!!!!!");
        enumeration = session.getAttributeNames();
        while (enumeration.hasMoreElements()) {
	        String attrName = (String)enumeration.nextElement();
    	    logger.info("Session Attribute - " + attrName+ " : "+ session.getAttribute(attrName));
        }
        logger
                .info("##########End of debuging request and session data for url:"
                        + errorUrl);
    }
}
%>
<title><i18n:msg expr="errorPage.title"/></title>

<h1><i18n:msg expr="errorPage.heading"/></h1>
<%@ include file="/common/messages.jsp" %>
<hr/>
<P><i18n:msg expr="errorPage.message" arg1="${appConfig.bugReportEmail}" /></P>
<a href="<c:url value="/"/>"><i18n:msg expr="menu.home"/>&#171;&#171;&#171; </a> <a href="#" onclick="history.back();return false"><i18n:msg expr="common.back"/>&#171;&#171;&#171; </a>

