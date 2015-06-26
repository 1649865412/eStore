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
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	//v_amount+v_moneytype+v_oid+v_mid+v_url+key
	//http://180.168.146.75:81/PGWPortal/RecvOrder.do
	String submitUrl = paymentMethod.getConfigData().get("v_url");
	String merchantNo = paymentMethod.getConfigData().get("merchantNo");
	String orderAmount = df.format(salesOrder.getShouldPay());
	String orderTime = sdf.format(salesOrder.getCreateTime());
	String ReturnURL = store.getSiteUrl()+"/system/payment/boc_response.html";
	//orderNo|orderTime|curCode|orderAmount|merchantNo
	StringBuffer originalText = new  StringBuffer(salesOrder.getOrderNo());
	originalText.append("|");
	originalText.append(orderTime);
	originalText.append("|");
	originalText.append("001");
	originalText.append("|");
	originalText.append(orderAmount);
	originalText.append("|");
	originalText.append(merchantNo);
	
	//+"|"+df.format(salesOrder.getShouldPay())+paymentMethod.getConfigData().get("v_moneytype");
	//	originalText+=salesOrder.getOrderNo();
	//	originalText+=paymentMethod.getConfigData().get("v_mid");
	//	originalText+=paymentMethod.getConfigData().get("v_url");
		
	
	PKCS7Tool tool = PKCS7Tool.getSigner(paymentMethod.getConfigData().get("keyStorePath"), paymentMethod.getConfigData().get("keyStorePassword"), paymentMethod.getConfigData().get("keyPassword"));
	String signData = tool.sign(originalText.toString().getBytes());
	//System.out.println(originalText.toString());
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
		<FORM METHOD="POST" name="paymentGatewayForm" ACTION="<%=submitUrl%>">
<!--01.商户号-->
<INPUT TYPE="hidden" ID="merchantNo" NAME="merchantNo" VALUE="<%=merchantNo%>">
<!--02.支付类型-->
<INPUT TYPE="hidden" ID="payType" NAME="payType" VALUE="1">
<!--03.商户订单号-->
<INPUT TYPE="hidden" ID="orderNo" NAME="orderNo" VALUE="${salesOrder.orderNo}">
<!--04.订单币种-->
<INPUT TYPE="hidden" ID="curCode" NAME="curCode" VALUE="001">
<!--05.订单金额-->
<INPUT TYPE="hidden" ID="orderAmount" NAME="orderAmount" VALUE="<%=orderAmount%>">
<!--06.订单时间-->
<INPUT TYPE="hidden" ID="orderTime" NAME="orderTime" VALUE="<%=orderTime%>">
<!--07.订单说明-->
<INPUT TYPE="hidden" ID="orderNote" NAME="orderNote" VALUE="<%=store.getName()%>">
<!--08.商户接收通知URL-->
<INPUT TYPE="hidden" ID="orderUrl" NAME="orderUrl" VALUE="<%=ReturnURL%>">
<!--09.商户签名数据-->
<INPUT TYPE="hidden"  NAME="signData"  value="<%=signData%>"/>
		</FORM>
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>