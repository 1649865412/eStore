<%@ tag pageEncoding="UTF-8"%>
<%@tag import="com.cartmatic.estore.core.util.ContextUtil"%>
<%@tag import="com.cartmatic.estore.common.service.InventoryService"%>
<%@tag import="com.cartmatic.estore.common.model.inventory.Inventory"%>
<%@tag import="com.cartmatic.estore.common.util.DateUtil"%>
<%@tag import="com.cartmatic.estore.core.util.I18nUtil"%>
<%@tag import="com.cartmatic.estore.inventory.service.InventoryManager"%>
<%@tag import="com.cartmatic.estore.common.model.inventory.SkuInventoryVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ attribute name="buyCount" required="true" type="java.lang.Integer" description="购买了的数量"%>
<%@ attribute name="productSku" required="true" type="com.cartmatic.estore.common.model.catalog.ProductSku"%>
<%
String msg=null;
InventoryManager inventoryManager=(InventoryManager)ContextUtil.getSpringBeanById("inventoryManager");
SkuInventoryVO skuInventoryVO=inventoryManager.getSkuInventoryVO(productSku);
if(skuInventoryVO.getType().intValue()==4){
	msg=I18nUtil.getInstance().getMessage("productSku.inventory.in.stock");
}else if(skuInventoryVO.getType().intValue()==5||(skuInventoryVO.getType().intValue()==2&&skuInventoryVO.getAvailableToCartQty()>=buyCount)){
	if(skuInventoryVO.getExpectedRestockDate()==null){
		if(skuInventoryVO.getAvailabilityRule().intValue()==2){
			msg=I18nUtil.getInstance().getMessage("productSku.inventory.on.preOrder.noDate");
		}else{
			msg=I18nUtil.getInstance().getMessage("productSku.inventory.on.backOrder.noDate");
		}
	}else{
		if(skuInventoryVO.getAvailabilityRule().intValue()==2){
			msg=I18nUtil.getInstance().getMessage("productSku.inventory.on.preOrder",new Object[]{DateUtil.convertDateToString(skuInventoryVO.getExpectedRestockDate())});
		}else{
			msg=I18nUtil.getInstance().getMessage("productSku.inventory.on.backOrder",new Object[]{DateUtil.convertDateToString(skuInventoryVO.getExpectedRestockDate())});
		}
	}
}else if(skuInventoryVO.getType().intValue()==1&&skuInventoryVO.getAvailableQuantity()>=buyCount){
	msg=I18nUtil.getInstance().getMessage("productSku.inventory.in.stock");
}
if(msg==null){
	msg=I18nUtil.getInstance().getMessage("productSku.inventory.outof.stock");
}
out.print(msg);
%>