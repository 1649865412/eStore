<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error.jsp"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder,
				java.math.BigDecimal,
				com.cartmatic.estore.system.payment.bill99.PemKeySign,
				com.cartmatic.estore.common.util.DateUtil,
				java.util.Date"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%@page import="java.text.DecimalFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%!private final static transient Log logger = LogFactory.getLog("com.cartmatic.estore.system.payment.bill99.99bill_response_jsp");%>
<html>
	<head>
		<script type="text/javascript">
			window.onload=function(){
				document.forms["paymentGatewayForm"].submit();
			}
		</script>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
	</head>
	<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	String billingCountry = null;
	if ("United States of America".equals(salesOrder.getOrderAddress().getCountry()))
	{
	    billingCountry = "US";
	}
	request.setAttribute("billingCountry",billingCountry);
	DecimalFormat df=new java.text.DecimalFormat("#");
	String shouldPay=df.format(salesOrder.getShouldPay().multiply(new BigDecimal(100)));
	request.setAttribute("shouldPay",shouldPay);
	String pageUrl=request.getScheme()+"://"+request.getHeader("host")+request.getContextPath()+"/system/payment/99bill_response.html?decorator=blank";
	//pageUrl="http://linkdigi.homeip.net:8080/eStore/system/payment/99bill_response.html?decorator=blank";
	request.setAttribute("pageUrl",pageUrl);	
	String orderTime=DateUtil.getDate(salesOrder.getCreateTime(),"yyyyMMddHHmmss");
	StringBuffer signMsg=new StringBuffer();	
	///--------------------
	signMsg=new StringBuffer(); 
	signMsg.append("inputCharset=1");
	signMsg.append("&bgUrl="+pageUrl);
	signMsg.append("&version=v1.0");
	signMsg.append("&language=2");
	signMsg.append("&signType=1");
	signMsg.append("&merchantAcctId="+paymentMethod.getConfigData().get("merchantAcctId"));
	signMsg.append("&termId="+paymentMethod.getConfigData().get("termId"));
	
	signMsg.append("&email="+salesOrder.getCustomerEmail());
	if (salesOrder.getOrderAddress().getPhoneNumber() != null && salesOrder.getOrderAddress().getPhoneNumber().length() > 0)
		signMsg.append("&phoneNumber="+salesOrder.getOrderAddress().getPhoneNumber());	
	if (salesOrder.getOrderAddress().getPostalcode() != null && salesOrder.getOrderAddress().getPostalcode().length() > 0)
		signMsg.append("&zipCode="+salesOrder.getOrderAddress().getPostalcode());
	//signMsg.append("&billingAddress="+salesOrder.getOrderAddress().getAddress1());
	//signMsg.append("&billingCity="+salesOrder.getOrderAddress().getCity());
	//signMsg.append("&billingState="+salesOrder.getOrderAddress().getState());
	//if (billingCountry != null)
	//	signMsg.append("&billingCountry=US");
	signMsg.append("&orderId="+salesOrder.getOrderNo());
	signMsg.append("&pricingCurrency=USD");
	signMsg.append("&pricingAmount="+shouldPay);
	//signMsg.append("&billingCurrency=USD");
	//signMsg.append("&billingAmount="+shouldPay);
	signMsg.append("&exchangeRateFlag=0");
	signMsg.append("&exchangeRateDirection=1");
	//signMsg.append("&exchangeRate=0");
	signMsg.append("&orderTime="+orderTime);
	//signMsg.append("&productName=");
	signMsg.append("&productNum=1");
	//signMsg.append("&productId=");
	//signMsg.append("&productDesc=");
	signMsg.append("&payType=20");
	//signMsg.append("&bankId=");
	signMsg.append("&redoFlag=0");
	//signMsg.append("&pid=");
	//signMsg.append("&ext1=");
	//signMsg.append("&ext2=");
	//signMsg.append("d d");		
	logger.debug("signMsg:"+signMsg);
	PemKeySign pemKeySign = new PemKeySign("conf/99billPemKey.pem",paymentMethod.getConfigData().get("merchantAcctId").toString(),paymentMethod.getConfigData().get("merchantAcctPassword").toString());
	String macSignMsg = pemKeySign.encrypt(signMsg.toString());
	logger.debug("macSignMsg:"+macSignMsg);
	%>
	<body>
		<form name="paymentGatewayForm" method="post" action="https://cpay.99bill.com/fgw/payment/purchase.htm">
			<input type="hidden" name="inputCharset" value="1">
			<input type="hidden" name="pageUrl" value="">
			<input type="hidden" name="bgUrl" value="${pageUrl}">
			<input type="hidden" name="version" value="v1.0">
			<input type="hidden" name="language" value="2">
			<input type="hidden" name="signType" value="1">
			<input type="hidden" name="merchantAcctId" value="${paymentMethod.configData.merchantAcctId}">			
			<input type="hidden" name="termId" value="${paymentMethod.configData.termId}">
			<input type="hidden" name="firstName" value="${salesOrder.orderAddress.firstname}">
			<input type="hidden" name="lastName" value="${salesOrder.orderAddress.lastname}">			
			<input type="hidden" name="issuingBank" value="">
			<input type="hidden" name="issuingCountry" value="">
			<input type="hidden" name="email" value="${salesOrder.customerEmail}">
			<input type="hidden" name="phoneNumber" value="${salesOrder.orderAddress.phoneNumber}">
			<input type="hidden" name="zipCode" value="${salesOrder.orderAddress.postalcode}">
			<input type="hidden" name="billingAddress" value="${salesOrder.orderAddress.address1}">
			<input type="hidden" name="billingCity" value="${salesOrder.orderAddress.city}">
			<input type="hidden" name="billingState" value="${salesOrder.orderAddress.state}">
			<input type="hidden" name="billingCountry" value="${billingCountry}">
			<input type="hidden" name="orderId" value="${salesOrder.orderNo}">
			<input type="hidden" name="pricingCurrency" value="USD">
			<input type="hidden" name="pricingAmount" value="${shouldPay}">
			<input type="hidden" name="billingCurrency" value="">
			<input type="hidden" name="billingAmount" value="">
			<input type="hidden" name="exchangeRateFlag" value="0">
			<input type="hidden" name="exchangeRateDirection" value="1">
			<input type="hidden" name="exchangeRate" value="">
			<input type="hidden" name="orderTime" value="<%=orderTime%>">
			<input type="hidden" name="productName" value="">
			<input type="hidden" name="productNum" value="1">			
			<input type="hidden" name="productId" value="">
			<input type="hidden" name="productDesc" value="">
			<input type="hidden" name="payType" value="20">
			<input type="hidden" name="bankId" value="">
			<input type="hidden" name="redoFlag" value="0">
			<input type="hidden" name="ext1" value="">
			<input type="hidden" name="ext2" value="">
			<input type="hidden" name="pid" value="">
			<input type="hidden" name="signMsg" value="<%=macSignMsg%>">
	    </form>
	    <%@ include file="./include/payOrderTips.jspf" %>
	    </body>
</html>