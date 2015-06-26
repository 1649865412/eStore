
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
/* 
		Description:
			request paramter rm:
			make the transation data post back ,this value is default 1,redirected to the return URL by the GET method, 
			and no transaction variables are sent.
*/
 %>
<HTML>
<HEAD>
<%@ page import="com.cartmatic.estore.common.model.order.SalesOrder,
				org.springframework.web.context.support.WebApplicationContextUtils"
				contentType="text/html; charset=UTF-8"
			pageEncoding="UTF-8"
			errorPage="/error.jsp"	
 %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/common/taglibs.jsp"%>
<TITLE><fmt:message key="system.payment.ss"/></TITLE>
	<script type="text/javascript">
		window.onload=function(){
			document.forms["paymentGatewayForm"].submit();
		}
	</script>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
</HEAD>
<BODY>
	<%
		String baseURL=request.getScheme()+"://" + request.getHeader("host")+request.getContextPath();

		String returnURL=baseURL+"/system/payment/paypal_cn_response.html";
				
		String cancelURL=baseURL+"/cart/shoppingcart.html";

		SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");

		PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");

		//java.util.HashMap paramMap=paymentMethod.getConfigData();

		java.text.DecimalFormat df=new java.text.DecimalFormat("0.00");

		String host="";

		String testModel=paymentMethod.getConfigData().get("testModel").toString();

		if(testModel.equals("Y")){
			host="www.sandbox.paypal.com";	
		}else{
			host="www.paypal.com/cn";
		}
	 %>
	<form name="paymentGatewayForm" action="https://<%=host %>/cgi-bin/webscr" method="post">
		<input type=hidden name="amount" value="<%=df.format(salesOrder.getShouldPay()) %>">
		<input type=hidden name="item_name" value="Order(<%=salesOrder.getOrderNo() %>)">
		<input type=hidden name="charset" value="gb2312">
		<input type=hidden name="cmd" value="_ext-enter">
		<input type=hidden name="redirect_cmd" value="_xclick">		
		<input type=hidden name="custom" value="<%=salesOrder.getOrderNo()%>">
		<input type=hidden name="invoice" value="Invoice No:<%=salesOrder.getOrderNo() %>">
		<input type=hidden name="rm" value="2">	
		<input type=hidden name="business" value="${paymentMethod.configData.business}">	
		<input type=hidden name="currency_code" value="${paymentMethod.configData.currency_code}">
		<input type=hidden name="return" value="<%=returnURL%>">
		<input type=hidden name="cancel_return" value="<%=cancelURL%>">
		<input type=hidden name="notify_url" value="<%=returnURL %>">
		<%-- 
		<input type=hidden name="image_url" value="${appConfig.store.siteUrl}${resPath}/images/layout/hm_logo.gif">
		--%>
	</form>
	<%@ include file="./include/payOrderTips.jspf" %>
</BODY>
</HTML>
