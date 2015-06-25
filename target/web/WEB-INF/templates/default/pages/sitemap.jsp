<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<html>
	<head>
		<title>Sitemap - ${appConfig.store.title}</title>
		<meta name="keywords" content="Sitemap - ${appConfig.store.keyWords}" />
		<meta name="description" content="Sitemap - ${appConfig.store.description}" />
		
		<title>Sitemap</title>
		<meta name="description" content="Site map" />
	</head>
	<body>
	<content tag="heading">Sitemap</content>
	<%-- 目录列表 --%>
	<h2><fmt:message key="sitemap.producttypelist" /></h2>
	<div class="dashed-line"></div>
	<product:showCategorys var="brand" displayLevel="1" displayCategoryId="${appConfig.store.catalog.categoryId}">
		<ul class="sitemap">
		<c:forEach items="${brand_categoryTreeItems}" var="brandCategory">
			<li class="title"><a href="${brandCategory.url}">${brandCategory.categoryName}</a></li>
			<c:forEach items="${brandCategory.categorys}" var="brandCategoryItem">
				<li><a href="<product:categoryUrl category="${brandCategoryItem}" />">${brandCategoryItem.categoryName}</a></li>
			</c:forEach>
		</c:forEach>
		</ul>
 	</product:showCategorys>
 </body>
 </html>