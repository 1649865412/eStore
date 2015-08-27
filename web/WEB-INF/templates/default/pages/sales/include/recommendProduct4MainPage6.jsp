<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">
	<li data-img="img/authors/5d.jpg"><div><i></i><img src="${mediaPath}product/v/${productItem.defaultProductSku.image}" width="100%"></div></li>
</c:forEach>