<%@ page language="java" isErrorPage="true"%>
<%
	String sourceUrl = com.cartmatic.estore.webapp.util.RequestUtil.getErrorUrl(request);
	if (sourceUrl.indexOf("/system/payment/") != -1) {
	    logger.error("Error processing url:"+sourceUrl);
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
	 	response.sendRedirect(request.getContextPath()+"/paymentError.html");
} else {
%>
<%@ include file="/common/reportError.jsp"%>
<%}%>

