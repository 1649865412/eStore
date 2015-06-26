<%@ tag import="com.cartmatic.estore.Constants"%><%@
	tag import="com.cartmatic.estore.common.helper.CatalogHelper"%><%@
	tag import="com.cartmatic.estore.common.model.catalog.Product"%><%@
	tag import="com.cartmatic.estore.common.model.catalog.Category"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
	taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%><%@ 
	taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%><%@ 
	taglib prefix="app" tagdir="/WEB-INF/tags/app"%><%@ 
	attribute name="product" type="com.cartmatic.estore.common.model.catalog.Product"%><%@ 
	attribute name="category" type="com.cartmatic.estore.common.model.catalog.Category" description="超连接 的产品目录"%><%@	
	attribute name="interceptLength" type="java.lang.Integer" description="截取长度"%>
<c:set scope="page" var="productName" value="${product.productName}"></c:set>
<c:choose>
	<c:when test="${empty interceptLength}">
		<a href="<product:productUrl product="${product}" category="${category}" />" title="<c:out value="${pageScope.productName}"/>">${pageScope.productName}</a>
	</c:when>
	<c:otherwise>
		<a href="<product:productUrl product="${product}" category="${category}" />" title="<c:out value="${pageScope.productName}"/>"><app:interceptString length="${interceptLength}" str="${pageScope.productName}"></app:interceptString></a>
	</c:otherwise>
</c:choose>