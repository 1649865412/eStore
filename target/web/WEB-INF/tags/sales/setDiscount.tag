<%@ tag import="com.cartmatic.estore.common.service.PromoService"%><%@
	tag import="com.cartmatic.estore.core.util.ContextUtil"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
	attribute name="productSku" required="true" type="com.cartmatic.estore.common.model.catalog.ProductSku"%><%
{
	PromoService promoService=(PromoService)ContextUtil.getSpringBeanById("promoService");
	if(productSku!=null){
		promoService.appendPromoInfo(productSku);
	}
}
%>