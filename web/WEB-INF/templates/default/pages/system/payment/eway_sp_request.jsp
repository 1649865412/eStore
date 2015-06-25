
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%><%
	//Description: eWAY.Shared payment request Configuration 
	//CreateTime:2006-07-28
%>
<%@ page import="java.util.*,java.text.*,
				com.cartmatic.estore.common.model.order.SalesOrder"
				errorPage="/error.jsp"
 %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	Map paramMap=paymentMethod.getConfigData();
	DecimalFormat df=new java.text.DecimalFormat("0");
	String total=df.format(salesOrder.getShouldPay().floatValue()*100f);
	String returnURL=request.getScheme()+"://"+request.getHeader("host")+ request.getContextPath()
	+"/system/payment/eway_sp_response.html";
	
	String eWAYoption3="FALSE";
	if(paramMap!=null&&"Y".equals(paramMap.get("testModel"))){
		eWAYoption3="TRUE";
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
		<FORM name="paymentGatewayForm" action="https://www.eWAY.com.au/gateway/payment.asp" method="post">
			<input type="hidden" name="ewayCustomerID" value="${paymentMethod.configData.customerId}">
			<input type="hidden"  name="ewayTotalAmount" value="<%=total %>">
			<input type="hidden"  name="ewayTrxnNumber" value="<%=salesOrder.getOrderNo() %>">
			<input type="hidden"  name="ewayCustomerFirstName" value="<%=salesOrder.getCustomerFirstName()%>">
			<input type="hidden"  name="ewayCustomerLastName" value="<%=salesOrder.getCustomerLastname() %>">
			<input type="hidden"  name="ewayCustomerEmail" value="<%=salesOrder.getCustomerEmail() %>">
			<input type="hidden" name="ewayCustomerAddress" value="<%=salesOrder.getCustomerAddress() %>">
			<input type="hidden"  name="ewayCustomerPostcode" value="<%=salesOrder.getCustomerZip() %>">
			<input type="hidden" name="ewayCustomerInvoiceDescription" value="(Order NO:<%=salesOrder.getOrderNo()%>)">
			<input type="hidden" name="ewayCustomerInvoiceRef" value="<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="ewayURL" value="<%=returnURL %>">
			<input type="hidden"  name="eWAYoption1" value="<%=salesOrder.getOrderNo() %>">
			<input type="hidden"  name="eWAYoption3" value="<%=eWAYoption3%>">
			
		</FORM>
	<%@ include file="./include/payOrderTips.jspf" %></body>
<html>