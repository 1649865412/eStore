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

	String returnURL=request.getScheme()+"://" + request.getHeader("host") 
					+ request.getContextPath()+"/system/payment/checkout2_response.html";
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
		<form action="https://www.2checkout.com/2co/buyer/purchase" method="POST" name="paymentGatewayForm">
		    <input type="hidden" name="sid" value="${paymentMethod.configData.vendorId}">
			<input type="hidden" name="total" value="<%=df.format(salesOrder.getTotal()) %>">
			<input type="hidden" name="cart_order_id" value="<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="return_url" value="<%=returnURL %>">
			<input type="hidden" name="ship_name" value="<%=salesOrder.getShippingFirstname()+salesOrder.getShippingLastname() %>">
			<input type="hidden" name="ship_street_address" value="<%=salesOrder.getShippingAddress() %>">
			<input type="hidden" name="ship_city" value="<%=salesOrder.getShippingCity() %>">
			<input type="hidden" name="ship_state" value="<%=salesOrder.getShippingState() %>">
			<input type="hidden" name="ship_zip" value="<%=salesOrder.getShippingZip() %>">		
			<input type="hidden" name="ship_country" value="<%=salesOrder.getShippingCountry() %>">
			<input type="hidden" name="fixed" value="Y">
			<c:if test="${paymentMethod.configData.testModel=='Y'}">
				<input type="hidden" name="demo" value="Y">
			</c:if>
		</form>
		
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>