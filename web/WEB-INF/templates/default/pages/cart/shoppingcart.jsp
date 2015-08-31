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
	<link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
		<link href="${resPath}/styles/css/bootstrap.css" rel="stylesheet">
		<link href="${resPath}/styles/css/swiper.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/animate.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/index.css" rel="stylesheet">
        <link href="${resPath}/styles/css/car-list.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
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