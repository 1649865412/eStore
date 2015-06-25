<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title><decorator:title /></title>
		<%@ include file="./include/meta.jspf"%>
		<meta http-equiv="Pragma" content="no-cache" />
		<%--<%@ include file="./include/styles.jspf"%>--%>
		
		<%--<link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />
		
		<%@ include file="./include/styles3.jspf"%>--%>
		
		<%@ include file="./include/javascripts.jspf"%>
		
		<link rel="icon" href="${resPath}/images/favicon.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="${resPath}/images/mindo.ico" type="image/x-icon" />
		
		<decorator:head />
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
		
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>	
			<%-- ========== 头部开始 ========= --%>
				<c:set var="isShowHiddenCategory" value="true"></c:set>
				<%@ include file="./include/header.jspf"%>
			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========= --%>
			<div class="lyt-maincontent">
				<%@ include file="/common/messages.jsp"%>  
				<decorator:body />
			</div>
			<%-- ========== 内容结束 ========= --%>
            <div class="blank10"></div>
			<%-- ========== 底部开始 ========= --%>
				<%@ include file="./include/footer.jspf"%>
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>