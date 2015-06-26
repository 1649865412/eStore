<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<title>${category.categoryName}</title>
		<meta name="keywords" content="${not empty category.metaKeyword?category.metaKeyword:category.categoryName}" />
		<meta name="description" content="${not empty category.metaDescription?category.metaDescription:category.categoryDescription}" />
	</head>
	<body>
		<content tag="heading"> <h1 class="selected">${category.categoryName}</h1></content>
		<ul class="more-list">
			<c:forEach items="${contentList}" var="content">
				<li><a href="<content:contentUrl content='${content}'/>">${content.contentTitle}</a></li>
			</c:forEach>
		</ul>
	</body>
</html>

