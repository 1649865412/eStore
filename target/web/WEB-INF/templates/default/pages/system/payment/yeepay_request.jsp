<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="java.util.*,java.text.*,
	com.cartmatic.estore.common.model.order.SalesOrder"
	errorPage="/error.jsp"
%>
<jsp:directive.page import="com.cartmatic.estore.system.util.TranslateService"/>
<%
	request.setCharacterEncoding("gb2312");
	
	SalesOrder salesOrder = (SalesOrder) request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	HashMap paramMap = paymentMethod.getConfigData();

	DecimalFormat df=new DecimalFormat("0.00");
	
	String merchantId;
	String keyValue;
	String nodeAuthorizationURL;
	String amount;
	String cur;

	String productDesc;
	String productCat;
	String productId;
	String messageType;
	String addressFlag;
	String orderId;
	String merchantCallbackURL;
	String sMctProperties;
	StringBuffer sbOld = new StringBuffer();
	String sNewString;
	
	//是否为测试模式下工作.
	if("Y".equals(paramMap.get("testModel"))){
		merchantId = "1001001";
		keyValue = "Key";
		amount="0.01";
	}else{
		merchantId=paramMap.get("merchantId").toString();
		keyValue=paramMap.get("key").toString();
		amount = df.format(salesOrder.getShouldPay().doubleValue());
	}
	
	nodeAuthorizationURL = "https://www.yeepay.com/app-merchant-proxy/node";

	
	cur = paramMap.get("currency").toString();
	productDesc = "current order:"+salesOrder.getOrderNo();
	
	productCat = "category";
	productId = "id";
	
	messageType = "Buy";
	addressFlag = "0";
	orderId = salesOrder.getOrderNo();

	merchantCallbackURL = request.getScheme()+"://"+request.getHeader("host")+request.getContextPath()+"/system/payment/yeepay_response.html";
	sMctProperties = "";

	sbOld.append(messageType);
	sbOld.append(merchantId);
	sbOld.append(orderId);
	sbOld.append(amount);
	sbOld.append(cur);
	sbOld.append(productId);
	sbOld.append(productCat);
	sbOld.append(productDesc);
	sbOld.append(merchantCallbackURL);
	sbOld.append(addressFlag);
	sbOld.append(sMctProperties);

	sNewString = TranslateService.hmacMd5Transalte(sbOld.toString(),keyValue);
%>
<html>
	<head>
		<title><fmt:message key="system.payment.yifu"/></title>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
	</head>
	<body onload="document.paymentGatewayForm.submit();">
		<form name="paymentGatewayForm" action="<%=nodeAuthorizationURL%>" method="post">
			<input type="hidden" name="p0_Cmd" value="<%=messageType%>">
			<input type="hidden" name="p1_MerId" value="<%=merchantId%>">
			<input type="hidden" name="p2_Order" value="<%=orderId%>">
			<input type="hidden" name="p3_Amt" value="<%=amount%>">
			<input type="hidden" name="p4_Cur" value="<%=cur%>">
			<input type="hidden" name="p5_Pid" value="<%=productId%>">
			<input type="hidden" name="p6_Pcat" value="<%=productCat%>">
			<input type="hidden" name="p7_Pdesc" value="<%=productDesc%>">
			<input type="hidden" name="p8_Url" value="<%=merchantCallbackURL%>">
			<input type="hidden" name="p9_SAF" value="<%=addressFlag%>">
			<input type="hidden" name="pa_MP" value="<%=sMctProperties%>">
			<input type="hidden" name="hmac" value="<%=sNewString%>">
		</form>
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>
