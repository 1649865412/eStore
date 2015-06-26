<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,java.text.*,
				com.cartmatic.estore.common.model.order.SalesOrder"
				errorPage="/error.jsp"
 %>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	paymentMethod.getId();
	java.util.HashMap paramMap=paymentMethod.getConfigData();
	java.text.DecimalFormat df=new java.text.DecimalFormat("0.00");

	//test server to server return method url 
//	String serverReturnUrl="http://61.144.61.134/payment/getDataFromGateway.jsp";	
	//return url which in test model
//	String returnUrl="http://61.144.61.134/payment/getDataFromGateway.jsp";
	
	//real return url in use
	String serverReturnUrl=request.getScheme()+"://" + request.getHeader("host") + request.getContextPath() + "/system/payment/ips_response.html?server=true";
	String returnUrl=request.getScheme()+"://" + request.getHeader("host") + request.getContextPath() + "/system/payment/ips_response.html";
		
	//Date Format
	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
	GregorianCalendar cal=new GregorianCalendar();
	
	String date=sdf.format(cal.getTime());
	//get md5 figure
	String signMD5="";

	String currencyType=paymentMethod.getConfigData().get("Currency_Type").toString();
	String retType=paymentMethod.getConfigData().get("RetType").toString();
	String Lang=paymentMethod.getConfigData().get("Lang").toString();

	//original text  【订单编号】+【订单金额】+【订单日期】+【币种】+【商户内部证书字符串】
	String originalText=salesOrder.getOrderNo() + df.format(salesOrder.getShouldPay()) + date + currencyType + paramMap.get("Mer_Cert") ;

	signMD5=com.cartmatic.estore.system.util.TranslateService.md5Translate(originalText);

	String host="";
	//test model?
	if(("Y").equals(paymentMethod.getConfigData().get("testModel"))){
		host="http://pay.ips.net.cn/ipayment.aspx";
	}else{
		host="https://pay.ips.com.cn/ipayment.aspx";
	}

%>
<html>
	<head>
		<script type="text/javascript">
			window.onload=function(){
				document.forms["paymentGatewayForm"].submit();
			}
		</script>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
	</head>
	<body>
		<form name="paymentGatewayForm" method="post" action="<%=host%>">
			<input type="hidden" name="Mer_Code" value="<%=paramMap.get("Mer_Code") %>">
			<input type="hidden" name="Billno"  value="<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="Currency_Type" value="<%=currencyType %>">
			<input type="hidden" name="Lang" value="${paymentMethod.configData.Lang}">
			<input type="hidden" name="Amount" value="<%=df.format(salesOrder.getShouldPay()) %>">
			<input type="hidden" name="Date" value="<%=date %>">
			<input type="hidden" name="Attach" value="<%=paymentMethod.getPaymentMethodId() %>">
			<input type="hidden" name="OrderEncodeType" value="2"><%-- Md5 encrypt --%>
			<input type="hidden" name="RetEncodeType" value="12"><%-- return MD5 encrypt --%>
			<input type="hidden" name="Merchanturl" value="<%=returnUrl %>">
			<input type="hidden" name="RetType" value="<%=retType %>"><%-- 1 user server return type 在真正的环境下，该类型的测试返回地址才能正确访问--%>
			<input type="hidden" name="ServerUrl" value="<%=serverReturnUrl %>">
			<input type="hidden" name="SignMD5" value="<%=signMD5%>">
		</form>
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>