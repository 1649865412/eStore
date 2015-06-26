<%--
所以目录没有指定显示模板的,统一由这页面显示（列表目录的产品）
--%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<title>New Arrivals at ${appConfig.store.name}</title>
	</head>
	<body>
        <content tag="heading">New Arrivals</content>
		<div class="clear"></div>
       <jsp:include flush="true" page="/sales/recommendedProduct.html">
            <jsp:param name="typeName" value="new_arrival" />
            <jsp:param name="firstResult" value="0" />
            <jsp:param name="maxResults" value="50" />
            <jsp:param name="template" value="sales/recommendProducts" />
            <jsp:param name="doAction" value="defaultAction" />
            <jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
        </jsp:include>
	</body>
</html>