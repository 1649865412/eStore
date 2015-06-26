<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ attribute name="productSku" required="true" type="com.cartmatic.estore.common.model.catalog.ProductSku"%>
<%@ attribute name="style" type="java.lang.String"%>
<%@ attribute name="type" type="java.lang.String" description="显示类型  2为超链接"%>
<%--构造点击事件的处理funcion--%>
<c:set var="addToFHandler">
<c:choose>
	<c:when test="${not empty productSku}">
		<%--如果指定了sku,那么所有参数都是传入的--%>
		$cm.addToF('${productSku.productSkuCode}','',1);
	</c:when>
	<c:otherwise>
		<%--否则自行去页面取得所需参数--%>
		$cm.addToF($('#productSkuCode').val(),fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val());
	</c:otherwise>
</c:choose>
</c:set>
<c:choose>
	<c:when test="${not empty type&&type==2}">
		<a href="javascript:void(0);" onclick="${addToFHandler}return false;" title="<fmt:message key="product.addFavorite.hint" />"><fmt:message key="product.addFavorite.hint" /></a>
	</c:when>
	<c:otherwise>
		<input <c:if test="${not empty style}">style="${style}"</c:if> id="addToSaveForLater" name="addToSaveForLater" type="image" alt="Add To Favorite" src="${ctxPath}<fmt:message key="image.btn.addtofavorite"/>" align="absmiddle" border="0" systran="yes" onclick="${addToFHandler}return false;" />
	</c:otherwise>
</c:choose>