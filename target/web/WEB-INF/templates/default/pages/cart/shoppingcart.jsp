<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/cart"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<head>
	<title><fmt:message key="shoppingcart.yourShoppingcart" /></title>
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Cache-Control" content="no-store" />
	<link href="${resPath}/styles/head_foot.css" rel="stylesheet" type="text/css" />
	<link href="${resPath}/styles/nav.css" rel="stylesheet" type="text/css" />
	<link href="${resPath }/styles/main.css" rel="stylesheet" type="text/css"/>
	<link href="${resPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${resPath }/styles/chart.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form action="${ctxPath}/cart/shoppingcart.html" id="cart_form" method="post">  
<%@ include file="./include/buyNow.jspf"%>
<!-- cartUUID${shoppingcart.uuid}-->
<c:if test="${shoppingcart.buyNowItemsCount>0}">
</c:if>
<div class="blank24"></div>
<input type="hidden" value="" name="doAction" id="doAction"/>
<input type="hidden" value="" name="selected_sku" id="selected_sku"/>
<input type="hidden" value="" name="selected_itemId" id="selected_itemId"/>
<input type="hidden" value="${referer}" name="referer" />
</form>

<div class="blank10"></div>
</body>