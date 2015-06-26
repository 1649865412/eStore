
<%@tag import="com.cartmatic.estore.common.helper.CatalogHelper"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ attribute name="product" type="com.cartmatic.estore.common.model.catalog.Product"%>
<%@ attribute name="productSku" type="com.cartmatic.estore.common.model.catalog.ProductSku" description="产品详细页面不使用，主要是列表不希望动态改变数值"%>
<%@ attribute name="id" type="java.lang.String"%>
<%@ attribute name="buyCount" type="java.lang.Integer" description="购买数量，可以理解为默认值"%>
<%@ attribute name="onChange" type="java.lang.String"%>
<%--本tag只是输出显示数据，检查实际库存--%>
<%--objName用于记录控件的id，默认是quanity--%>
<c:set var="objName">
	<c:choose>
		<c:when test="${not empty id}">
		      ${id}
		  </c:when>
		<c:otherwise>quantity</c:otherwise>
	</c:choose>
</c:set>
<%--非变种产品时，控制最大购买量--%>
<%
if(productSku!=null||product.getProductKind().intValue()!=2){
	//非空productSku或者是非变种产品
	Integer minAndMaxQuantity[]=CatalogHelper.getInstance().getMinAndMaxQuantityToCart(productSku==null?product.getDefaultProductSku():productSku,buyCount);
	jspContext.setAttribute("first",minAndMaxQuantity[0]);
	jspContext.setAttribute("end",minAndMaxQuantity[1]); 
}else{
	jspContext.setAttribute("first",product.getMinOrderQuantity());
	jspContext.setAttribute("end",buyCount==null?(product.getMinOrderQuantity()+10):(buyCount+10));
}
%>
<select name="${objName}" id="${objName}" <c:if test="${not empty onChange}"> onchange="${onChange}"</c:if>>
<c:forEach begin="${first}" end="${end}" var="i">
	<option value="${i}" <c:if test="${i==buyCount}">selected="selected"</c:if>>${i}</option>
</c:forEach>
</select>