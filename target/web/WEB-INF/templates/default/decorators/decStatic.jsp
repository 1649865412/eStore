<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title><decorator:title /></title>
		<%@ include file="./include/meta.jspf"%>
		<link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />
		<%@ include file="./include/styles.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<%@ include file="./include/javascripts.jspf"%>
		<decorator:head />
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
			<%-- ========== 头部开始 ========= --%>
				<%@ include file="./include/header.jspf"%>
			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========= --%>
			<div class="lyt-maincontent">
				<c:set var="pageNavigator"><decorator:getProperty property="page.heading" /></c:set>
				<c:if test="${not empty pageNavigator}">
				<div class="position-wrap">
					<%@ include file="include/navigatorBar.jspf"%>
				</div>
				</c:if>
				<decorator:body />
			</div>
			<%-- ========== 内容结束 ========= --%>
            <div class="blank10"></div>
			<%-- ========== 底部开始 ========= --%>
				<%@ include file="./include/footer.jspf"%>
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>
