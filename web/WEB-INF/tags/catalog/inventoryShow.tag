<%@ tag pageEncoding="UTF-8"%>
<%@tag import="com.cartmatic.estore.core.util.ContextUtil"%>
<%@tag import="com.cartmatic.estore.common.service.InventoryService"%>
<%@tag import="com.cartmatic.estore.common.model.inventory.Inventory"%>
<%@tag import="com.cartmatic.estore.common.util.DateUtil"%>
<%@tag import="com.cartmatic.estore.core.util.I18nUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ attribute name="var" required="true" type="java.lang.String"%>
<%@ attribute name="productSku" required="true" type="com.cartmatic.estore.common.model.catalog.ProductSku"%>
<%@ attribute name="inventory" type="com.cartmatic.estore.common.model.inventory.Inventory"%>
<%
	if (inventory == null) {
		//获取sku的库存信息
		//InventoryService inventoryService = (InventoryService) ContextUtil.getSpringBeanById("inventoryService");
		//inventory = inventoryService.getInventoryBySku(productSku.getId());
		inventory=productSku.getInventory();
	}
	if (inventory != null) {
		String msg;
		if (inventory.getAvailableQuantity().intValue() > 0) {
			//当存在可售库存，直接显示相应的可售库存数量
			msg =inventory.getAvailableQuantity().toString();
		} else if (productSku.getProduct().getAvailabilityRule().intValue() == 2 && (productSku.getProduct().getPreOrBackOrderLimit().intValue() < 1 || inventory.getPreOrBackOrderedQty() < productSku.getProduct().getPreOrBackOrderLimit().intValue())) {
			//当销售规则是预订并且(不存在预订数限制或者已分配预订数少于最大预订数)，提示预计上市时间
			msg = I18nUtil.getInstance().getMessage("productDetail.inventory.preOrder", new Object[] { DateUtil.convertDateToString(productSku.getProduct().getExpectedReleaseDate()) });
		} else if (productSku.getProduct().getAvailabilityRule().intValue() == 3 && (productSku.getProduct().getPreOrBackOrderLimit().intValue() < 1 || inventory.getPreOrBackOrderedQty() < productSku.getProduct().getPreOrBackOrderLimit().intValue())) {
			//当销售规则是缺货销售并且(不存在预订数限制或者已分配预订数少于最大预订数)，提示预计到货时间
			if (inventory.getExpectedRestockDate() != null) {
				msg = I18nUtil.getInstance().getMessage("productDetail.inventory.backOrder", new Object[] { DateUtil.convertDateToString(inventory.getExpectedRestockDate()) });
			} else {
				msg = I18nUtil.getInstance().getMessage("productDetail.inventory.will.ship");
			}
		} else {
			//显示缺货，及提示预计到货时间
			if (inventory.getExpectedRestockDate() != null) {
				msg = I18nUtil.getInstance().getMessage("productDetail.inventory.outof.stock.will.ship", new Object[] { DateUtil.convertDateToString(inventory.getExpectedRestockDate()) });
			} else {
				msg = I18nUtil.getInstance().getMessage("productDetail.inventory.outof.stock");
			}
		}
		request.setAttribute(var, msg);
	}
%>