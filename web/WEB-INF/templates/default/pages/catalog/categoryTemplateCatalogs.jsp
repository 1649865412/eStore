<%--
所以目录没有指定显示模板的,统一由这页面显示（列表目录的产品）
--%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<c:choose>
			<c:when test="${sc.pageNo>1}">
				<title>${category.categoryName} Page (${sc.pageNo})</title>
			</c:when>
			<c:otherwise>
				<attribute:attributeValue entity="${category}" attributeValueVar="categoryTitle" attributeCode="categoryTitle"></attribute:attributeValue>
				<title>${empty categoryTitle.attributeValue ? category.categoryName : categoryTitle.attributeValue}</title>
				<meta name="keywords" content="<c:out value="${category.metaKeyword}"/>" />
				<meta name="description" content="<c:out value="${category.metaDescription}"/>" />
			</c:otherwise>
		</c:choose>
	</head>
	<body>
		<content tag="heading"><product:navigatorBar navigatorCategorys="${navigatorCategorys}" /></content>
		<div class="category-description">
        	<h1>${category.categoryName}</h1>
			<c:if test="${not empty category.categoryDescription}">
            <div class="">${category.categoryDescription}</div>
			</c:if>
        </div>
		<div>
			<c:forEach items="${category.categorys}" var="categoryItem" varStatus="varStatus">
				<div class="category-product">
                    <a href="${categoryItem.url}" title="${categoryItem.categoryName}"><cartmatic:img url="${categoryItem.imageUrl}" mediaType="category" size="v" height="220" width="220" alt="${categoryItem.categoryName}" isLazyload="true"></cartmatic:img></a>
                    <a href="${categoryItem.url}" title="${categoryItem.categoryName}">${categoryItem.categoryName}</a>
				</div>
                <c:if test="${varStatus.count%3==0||varStatus.last}"><div class="blank24"></div></c:if>
			</c:forEach>
		</div>
		<div class="clear"></div>
		
	</body>
</html>