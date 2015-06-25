<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<title>${category.categoryName}</title>
	</head>
	<body>
		<content tag="heading"> <h1 class="selected">${category.categoryName}</h1></content>
		<ul class="more-list">
			<c:forEach items="${contentList}" var="content">
			   <li>${content.contentTitle}</li>
			</c:forEach>
		</ul>
	</body>
</html>

