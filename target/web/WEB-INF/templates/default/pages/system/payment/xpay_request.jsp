<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page
	import="java.util.*,java.text.*,com.cartmatic.estore.common.model.order.SalesOrder,
	com.cartmatic.estore.system.util.TranslateService,"
	errorPage="/error.jsp"	
%>
<%
	request.setCharacterEncoding("gb2312");
	
	SalesOrder salesOrder = (SalesOrder) request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	HashMap paramMap = paymentMethod.getConfigData();
	DecimalFormat df=new DecimalFormat("0.00");
	
	String tid=paramMap.get("tid").toString();
	String payKey=paramMap.get("payKey").toString();
	
	String prc=df.format(salesOrder.getShouldPay());
	
	String merchantCallbackURL = request.getScheme()+"://"+request.getHeader("host")+request.getContextPath()+"/system/payment/xpay_response.html";
	
	String requestUrl="http://pay.xpay.cn/pay.aspx";
	
	if(paramMap.get("testModel")!=null&&"Y".equals(paramMap.get("testModel"))){
		requestUrl="http://pay.xpay.cn/testpay.aspx";
		tid="86532211";
		payKey="Lk3fGJb/EAU=";
		prc="0.01";
	}
	
	String md="";
	//md=md5(key + ":" + prc +"," + bid +"," + tid+"," + card +","+ scard +"," +actioncode+"," +actionparameter+"," +" ver")
	StringBuffer originalText=new StringBuffer("");
	originalText.append(payKey)
	.append(":")
	.append(prc).append(",")
	.append(salesOrder.getOrderNo()).append(",")
	.append(tid).append(",")
	.append("bank").append(",")
	.append("").append(",")
	.append("sell").append(",")
	.append("").append(",")
	.append("2.0");
	md=TranslateService.md5Translate(originalText.toString());
	
%>
<html>
<head>
	<title><fmt:message key="system.payment.ddd"/></title>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
</head>
<body onload="document.forms['paymentGatewayForm'].submit();">
<form method="post" action="<%=requestUrl%>" name="paymentGatewayForm">
	<input type="hidden" name="tid" value="<%=tid%>">
	<input type="hidden" name="bid" value="<%=salesOrder.getOrderNo()%>">
	<input type="hidden" name="prc" value="<%=prc%>">
	<input type="hidden" name="card" value="bank">
	<input type="hidden" name="scard" value="">
	<input type="hidden" name="actioncode" value="sell">
	<input type="hidden" name="actionParameter" value="">
	<input type="hidden" name="ver" value="2.0">
	<input type="hidden" name="md" value="<%=md%>">
	<input type="hidden" name="url" value="<%=merchantCallbackURL %>">
	<input type="hidden" name="pdt" value="<%=salesOrder.getOrderNo()%>">
	<input type="hidden" name="type" value="">
	<input type="hidden" name="username" value="<%=salesOrder.getCustomerFirstName()+salesOrder.getCustomerLastname()%>">
	<input type="hidden" name="lang" value="gb2312">
	<input type="hidden" name="remark1 " value="<%=salesOrder.getNotes()%>">
	<input type=submit value="Pay Now">
</form>
<%@ include file="./include/payOrderTips.jspf" %></body>
</html>
