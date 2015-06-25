<%@ include file="/common/taglibs.jsp"%>
<%@page import="com.opensymphony.module.sitemesh.RequestConstants"%>
<%
request.setAttribute(RequestConstants.DECORATOR,"selecter");
%>
<html>
<head>
<title></title>
<link href="${ctxPath}/styles/global.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="clew-message">
	<div class="clew-top">
		<fmt:message key="account.news.message" />
	</div>
	<div class="clew-content">
		<div class="text"
			style="text-align: center; width: 100%; background: #fff;">
			<img alt="information" src="${resPath}/images/msg_smile.gif"
				align="middle" />
			<div class="clear"></div>
			Thank you for your order! Transferring to the payment gateway... ...
			<br />
			<b>Please wait!</b>
		</div>
	</div>
</div>
</body>
</html>