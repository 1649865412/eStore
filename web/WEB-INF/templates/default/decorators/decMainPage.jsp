<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>四方街sifangstreet——全球新锐设计师品牌集合_原创新锐设计师品牌服饰、配饰、鞋履官方购物平台</title>
		<meta name="keywords" content="四方街，四方街网，设计师品牌集成店，原创品牌，都市时尚，女鞋，饰品，个性，定制，sifangstreet" />
		<meta name="description" content="四方街网sifangstreet是国内新锐设计师品牌网上购物商城，小众品牌，个性时尚，拒绝撞款，在线销售鞋履、首饰、包包、服装等多种设计师品牌商品。诚信、优质的服务，让您体验贴心的购物体验。" />
		<meta name="baidu-site-verification" content="EFpCG3K7AR" />
		<decorator:head />
	
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
		<decorator:getProperty property="page.header" />
	
			<%-- ========== 头部开始 ==2014041412点修订版========= --%>
		   <%@ include file="./include/headerNew.jspf"%>
				<c:set var="isShowHiddenCategory" value="true"></c:set>
				
		
			<%-- ========== 头部结束 ========= 
			--%><%-- ========== 内容开始 ========== --%>
			 <div class="maincontent" id="maincontent">
				<decorator:body />
			</div>
			<%-- ========== 内容结束 ========= --%>
           
			<%-- ========== 底部开始 ========= --%>
				<%@ include file="./include/footerNew.jspf"%>
			
			 <%-- ========== 底部结束 ========= 
	--%></body>
</html>