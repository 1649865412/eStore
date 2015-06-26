<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder,
com.cartmatic.estore.common.model.system.Store,
com.cartmatic.estore.common.helper.ConfigUtil,
com.cartmatic.estore.common.model.system.PaymentMethod,
java.text.DecimalFormat,
java.text.SimpleDateFormat,
com.bocnet.common.security.PKCS7Tool"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	Store store = ConfigUtil.getInstance().getStore();
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	String cardTyp = (String)request.getAttribute("cardTyp");
	DecimalFormat df=new java.text.DecimalFormat("0.00");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	//v_amount+v_moneytype+v_oid+v_mid+v_url+key
	//http://180.168.146.75:81/PGWPortal/RecvOrder.do
	String submitUrl = paymentMethod.getConfigData().get("v_url");
	String merchantNo = paymentMethod.getConfigData().get("merchantNo");
	String orderAmount = df.format(salesOrder.getShouldPay());
	String orderTime = sdf.format(salesOrder.getCreateTime());
	String ReturnURL = store.getSiteUrl()+"/system/payment/cmb_response.html";

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
		<!-- dev action :  https://netpay.cmbchina.com/netpayment/basehttp.dll?TestPrePayC2 -->
		<!-- product action :  https://netpay.cmbchina.com/netpayment/basehttp.dll?prepayc2 -->
		<div style="display: none;">
			<form id="paymentGatewayForm" name="paymentGatewayForm"  action="<%=submitUrl %>" method="post">
	            <br>地区  <input type="text" name="branchid" value="0020"/>
	            <br>商户号  <input type="text" name="cono" value="<%=merchantNo %>"/>
	            <br>日期  <input type="text" name="date" value="<%=orderTime %>"/>
	            <br>订单号 <input type="text" name="billno" value="${salesOrder.orderNo }"/>
	            <br>金额  <input type="text" name="amount" value="<%=orderAmount%>"/>
	            <br>商户参数  <input type="text" name="merchantPara" value="sifangstreet"/>
	            <br>商户URL  <input type="text" name="merchantUrl" value="<%=ReturnURL %>"/>
	            <br><input type="submit" value="提交"/>
	        </form>
        </div>
		
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>