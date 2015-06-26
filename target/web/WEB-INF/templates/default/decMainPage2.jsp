<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title><decorator:title /></title>
		<%@ include file="./include/meta.jspf"%>
		<%@ include file="./include/styles2.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<%@ include file="./include/styles5.jspf"%>
		<%@ include file="./include/javascripts2.jspf"%>
		
		<decorator:head />
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
		<decorator:getProperty property="page.header" />
	
			<%-- ========== 头部开始 ==201404149点修订版========= --%>
		   <%@ include file="./include/header.jspf"%>
				<c:set var="isShowHiddenCategory" value="true"></c:set>
				
		
			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========== --%>
			 <div class="maincontent" id="maincontent">
				<decorator:body />
			</div>
			<%-- ========== 内容结束 ========= --%>
           
			<%-- ========== 底部开始 ========= --%>
				<%@ include file="./include/footer.jspf"%>
			
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>