<%@ page import="java.util.*,java.text.*,
				com.cartmatic.estore.common.model.order.SalesOrder"
				errorPage="/error.jsp"
 %>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	DecimalFormat df=new java.text.DecimalFormat("0.00");
	String returnURL=request.getScheme()+"://"+ request.getHeader("host")+request.getContextPath()+"payment/nochex_response.html";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
		<form method="Post" name="paymentGatewayForm" action="https://www.nochex.com/nochex.dll/checkout">
			<input type="hidden" name="email" value="${paymentMethod.configData.account}">
			<input type="hidden" name="ordernumber" value="<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="amount" value="<%=df.format(salesOrder.getTotal()) %>">
			<input type="hidden" name="logo" value="${paymentMethod.configData.logoUrl}">
			<c:if test="${paymentMethod.configData.testModel=='Y'}">
				<input type="hidden" name="status" value="test">
			</c:if>
			<input type="hidden" name="returnurl" value="<%=returnURL%>?mode=complete&orderNo=<%=salesOrder.getOrderNo() %>">	
			<input type="hidden" name="responderurl" value="<%=returnURL%>?mode=responder&orderNo=<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="cancelurl" value="<%=returnURL%>?mode=cancel&orderNo=<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="description" value="Order No:<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="firstname" value="<%=salesOrder.getCustomerFirstName() %>">
		    <input type="hidden" name="lastname" value="<%=salesOrder.getCustomerLastname() %>">
		    <input type="hidden" name="firstline" value="<%=salesOrder.getCustomerAddress() %>">
		    <input type="hidden" name="town" value="<%=salesOrder.getCustomerCity() %>">
		    <input type="hidden" name="county" value="<%=salesOrder.getCustomerCountry() %>">
		    <input type="hidden" name="postcode" value="<%=salesOrder.getCustomerZip() %>">
		    <input type="hidden" name="email_address_sender" value="<%=salesOrder.getCustomerEmail() %>">
		</form> 
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>