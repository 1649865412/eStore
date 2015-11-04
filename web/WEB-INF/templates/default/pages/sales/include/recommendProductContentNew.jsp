<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>

		<c:forEach items="${productList}" var="product" varStatus="varStatus" >
		<li><a href="/product/${product.productId}.html"><img src="${ctxPath}/media/product/v/${product.defaultProductSku.image}" width="72" height="97"></a></li>
		</c:forEach>
