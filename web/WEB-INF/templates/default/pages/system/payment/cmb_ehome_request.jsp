<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/common/taglibs.jsp"%>

<%@page
	import="com.cartmatic.estore.common.model.order.SalesOrder,
	com.cartmatic.estore.common.model.system.Store,
	com.cartmatic.estore.common.helper.ConfigUtil,
	com.cartmatic.estore.common.model.customer.Customer,
	com.cartmatic.estore.webapp.util.RequestContext,
	com.cartmatic.estore.common.model.system.PaymentMethod,
	java.text.DecimalFormat,java.text.SimpleDateFormat,
	com.cartmatic.estoresf.cmbehome.action.help.*"%>
	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<script type="text/javascript">
function getCookie(name) {
	//alert("name");
	var prefix = name + "=" 
	var start = document.cookie.indexOf(prefix)
	if (start==-1) {
		return null;
	}
	start+=prefix.length;
	var end = document.cookie.indexOf(";", start) 
	if (end==-1) {
		end=document.cookie.length;
	}
	var cookieValue = document.cookie.substring(start, end);
	if (cookieValue) //把所有'"'去掉.
	{
		cookieValue = cookieValue.replace(/"/g,"");
		cookieValue =  decodeURI(cookieValue);
	}
		
	return unescape(cookieValue);
}
</script>
<%
	Store store = ConfigUtil.getInstance().getStore();
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	
	String submitUrl = paymentMethod.getConfigData().get("v_url");	
	String MallId =  paymentMethod.getConfigData().get("merchantNo");    //商户号
	String SellerName = "四方街";
	String OrderNo = salesOrder.getOrderNo().toString();
	String PaymentNo =salesOrder.getOrderNo().toString();
	String ItemName = "商品";
	int Amount =  salesOrder.getShouldPay().intValue()*100;  //订单金额
	String OrderDate = sdf.format(salesOrder.getCreateTime()); //订单时间	
	// USRNBR = "NW00003590";
    // Token = "0e0155e5-d467-4c27-b5a7-22972918cc61";

	String Usage ="买商品";
	String Remark = "买商品";
	String FontURL =  store.getSiteUrl()+"/system/payment/cmb_ehome_response.html";     //触发后返回的路径
%>

<html>
	<head>
		<script type="text/javascript">
			window.onload=function(){
				var token = getCookie("USERTOKEN");
				var user = getCookie("USERCEMHOMEUSER");
				//alert("token:"+token);
				//alert("user:"+user);
				document.getElementById('token').value=token;
				document.getElementById('user').value=user;
				getToken();
			}
			  //获取token
					function getToken() {
						//alert("getToken");
						$.post("/cmbeHome/getToken.html", {
							MallId : 10009,
							USRNBR : getCookie("USERCEMHOMEUSER"),
							paymentMethodId :<%=paymentMethod.getPaymentMethodId()%>
						}, function(result) {
							//alert("result:"+result);
							//alert("data"+result.data);
							document.getElementById('token').value=result.data;
							document.forms["paymentGatewayForm"].submit();
							}, "json");
					}
		</script>
	</head>
	<body>
		<div style="display: none;" >
			<form id="paymentGatewayForm" name="paymentGatewayForm"
				action="${ctxPath}/cmbeHome/submit.html" method="post">
				<br>
				商户号
				<input type="text" name="MallId" value="<%=MallId%>" />
				<br>
				操作类型
				<input type="text" name="OptType" value="1001" />
				<br>
				商城名称
				<input type="text" name="SellerName" value="四方街" />
				<br>
				订单号
				<input type="text" name="OrderNo" value="<%=OrderNo%>" />
				<br>
				支付流水号
				<input type="text" name="PaymentNo" value="<%=PaymentNo%>" />
				<br>
				商品名字
				<input type="text" name="ItemName" value="商品" />
				<br>
				金额
				<input type="text" name="Amount" value="<%=Amount%>" />
				<br>
				日期
				<input type="text" name="OrderDate" value="<%=OrderDate%>" />
				<br>
				USRNBR
				<input type="text" name="USRNBR" id="user" value="" />
				<br>
				Token
				<input type="text" name="Token" id="token" value="" />
				<br>
				资金用途
				<input type="text" name="Usage" value="买商品" />
				<br>
				备注
				<input type="text" name="Remark" value="备注买商品" />
				<br>
				商户返回URL
				<input type="text" name="FontURL" value="<%=FontURL%>" />
			             商户提交URL
				<input type="text" name="submitUrl" value="<%=submitUrl%>" />
				<input type="text" name="paymentMethodId" value="<%=paymentMethod.getPaymentMethodId()%>" />
				<br>
				<input type="submit" value="提交" />
			</form>
		</div>
	<%@ include file="./include/payOrderTips.jspf" %>
	</body>
</html>