<%@ page language="java" isErrorPage="true"%>
<jsp:directive.page import="com.cartmatic.estore.common.helper.ConfigUtil" />
<jsp:directive.page import="com.cartmatic.estore.webapp.util.RequestUtil" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/I18n.tld" prefix="i18n"%>
<c:set var="ctxPath" value="${applicationScope.ctxPath}" scope="page" />
<%!private final static transient org.apache.commons.logging.Log logger = org.apache.commons.logging.LogFactory
			.getLog("403_jsp");%>
<%
	String errorUrl = RequestUtil.getErrorUrl(request);
	boolean isContent = (errorUrl.endsWith(".html") || errorUrl.endsWith(".jsp"));
	if (isContent || !ConfigUtil.getInstance().getIsDevMode()) {
		logger.warn(RequestUtil.getErrorInfoFromRequest(request, logger.isTraceEnabled()));
	}
	if (!isContent) {
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	} else {
    String adminEmail = ConfigUtil.getInstance().getBugReportEmail();
    request.setAttribute("adminEmail", adminEmail);
%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<HTML xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<title><i18n:msg key="403.title" />
			</title>
			<style type="text/css">
.button {
	border: solid #ababab 1px;
	font-size: 12px;
	color: #000;
	padding-top: 2px;
	padding-left: 2px;
	padding-bottom: 2px;
	padding-right: 2px;
	text-align: center;
}

.page {
	width: 693px;
	height: 312px;
	margin-top: 20px;
	margin-left: auto;
	margin-right: auto;
	background: center no-repeat url(${resPath}/images/error.gif);
}

.content {
	width: 360px;
	margin-top: 60px;
	margin-left: 288px !important;
	margin-left: 165px;
	float: left;
	color: #000;
	font-size: 12px;
	letter-spacing: 1px;
	float: left;
}

.mail {
	color: #2084dc
}

H1 {
	color: #000;
	font-size: 16px;
	text-align: center;
}

.div-button {
	width: 360px;
	margin-top: 60px;
	margin-left: 288px !important;
	margin-left: 205px;
	float: left;
}

.left {
	margin-left: 100px;
	float: left;
}

* html .left {
	margin-left: 0px;
	float: left;
}

*+html .left {
	margin-left: 35px;
	float: left;
}

.right {
	margin-left: 50px;
	float: left;
}
</style>
		</head>
		<body>
			<div class="page">
				<div class="content">
					<h1>
						<font color="red"> <i18n:msg key="403.title" /> </font>
					</h1>
					<p></p>
					<i18n:msg expr="403.message" arg1="${ctxPath}" arg2="${adminEmail}"/>
					<p>
						&nbsp;
					</p>
				</div>
				<div class="div-button">
					<div class="left">
						<input type="button" class="button"
							value="<i18n:msg key="button.return"/>"
							onclick="history.back(-1);" />
					</div>
					<div class="right">
						<input type="button" class="button"
							value="<i18n:msg key="button.logout"/>"
							onclick="document.location.href='${ctxPath}/j_acegi_logout';" />
					</div>
				</div>
			</div>
		</body>
	</HTML>

<%
}
%>
