<%@tag import="com.cartmatic.estore.common.helper.CatalogHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ attribute name="product" type="com.cartmatic.estore.common.model.catalog.Product"%>
<%@ attribute name="productSku" type="com.cartmatic.estore.common.model.catalog.ProductSku" description="产品详细页面不使用，主要是列表不希望动态改变数值"%>
<%--本tag只是输出显示数据，检查实际库存--%>
<%--非变种产品时，控制最大购买量--%>
<%
if(product != null){//productSku!=null||product.getProductKind().intValue()!=2){
	//非空productSku或者是非变种产品
	Integer minAndMaxQuantity[]=CatalogHelper.getInstance().getMinAndMaxQuantityToCart(productSku==null?product.getDefaultProductSku():productSku);
	request.setAttribute("minOrderQuantity",minAndMaxQuantity[0]);
	request.setAttribute("maxOrderQuantity",minAndMaxQuantity[1]); 
}else{
	request.setAttribute("minOrderQuantity",product.getMinOrderQuantity());
//	request.setAttribute("maxOrderQuantity",buyCount==null?(product.getMinOrderQuantity()+10):(buyCount+10));
}
%>