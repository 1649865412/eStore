<%@tag import="com.cartmatic.estore.common.model.catalog.ProductSku"%>
<%@tag import="java.util.List"%>
<%@ tag pageEncoding="UTF-8"%>
<%@tag import="com.cartmatic.estore.common.helper.CatalogHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ attribute name="product" type="com.cartmatic.estore.common.model.catalog.Product"%>
<%@ attribute name="category" type="com.cartmatic.estore.common.model.catalog.Category" description="超连接 的产品目录"%>
<%@ attribute name="viewType" type="java.lang.Short" description=""%>
<c:choose>
	<c:when test="${viewType==1}">
		<product:productStat var="productStat" productId="${product.id}"></product:productStat>
		<c:choose>
			<c:when test="${productStat.reviewCount>0}">
				<c:forEach begin="0" end="4" var="index">
					<c:choose>
						<c:when test="${productStat.averageRate-index >= 1}"><span class="star"></span></c:when>
						<c:when test="${productStat.averageRate-index >= 0.5}"><span class="star-half"></span></c:when>
						<c:otherwise><span class="star-gray"></span></c:otherwise>
					</c:choose>
				</c:forEach>
				<span class="left">(${productStat.reviewCount})</span>
			</c:when>
		</c:choose>
	</c:when>
</c:choose>