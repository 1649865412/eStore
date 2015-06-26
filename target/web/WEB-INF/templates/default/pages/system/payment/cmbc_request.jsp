<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder,
com.cartmatic.estore.common.model.system.Store,
com.cartmatic.estore.common.helper.ConfigUtil,
com.cartmatic.estore.common.model.system.PaymentMethod,
java.text.DecimalFormat,
java.text.SimpleDateFormat,
java.net.URLEncoder,
java.util.HashMap,
java.util.Iterator,
java.util.Map,
java.util.Map.Entry,
java.util.Set,
org.apache.commons.lang.StringUtils,
com.cmbc.SignHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%

	//民生银行支付请求
	
	String baseServiceUrl = "https://epay.cmbc.com.cn/ipad/service.html";
	
	Store store = ConfigUtil.getInstance().getStore();
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	String cardTyp = (String)request.getAttribute("cardTyp");
	DecimalFormat df=new java.text.DecimalFormat("0.00");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	//v_amount+v_moneytype+v_oid+v_mid+v_url+key
	//http://180.168.146.75:81/PGWPortal/RecvOrder.do
	//String submitUrl = paymentMethod.getConfigData().get("v_url");  	//https://epay.cmbc.com.cn/ipad/service.html
	
	String orderAmount = df.format(salesOrder.getShouldPay());
	String orderTime = sdf.format(salesOrder.getCreateTime());
	String ReturnURL = store.getSiteUrl()+"/system/payment/cmbc_response.html";
	String showUrl = store.getSiteUrl() + "/myaccount/order/list.html";
	
	//1. 参数准备
	String service = "create_direct_pay_by_user";
	String partner_id = paymentMethod.getConfigData().get("partner_id"); //商户机构号 1002201305272380
	String input_charset = "utf-8";
	String sign_type = "MD5";
	String out_trade_no = salesOrder.getOrderNo();
	String amount = df.format(salesOrder.getShouldPay());
	String payMethod = "bankPay";
	String seller_email = paymentMethod.getConfigData().get("seller_email"); //商户email cmbc188@163.com
	String subject =  "pay_online_" + out_trade_no  ;	//不能为空，否则报“商品名称格式不正确 ”
	String buyer_email = "";
	String body = "pay_body";// "四方街订单支付";	//不能为空，否则报“商品名称格式不正确 ”
	String show_url = store.getSiteUrl() + "/myaccount/order/list.html";
	String return_url = store.getSiteUrl()+"/system/payment/cmbc_response.html";
	String notify_url = store.getSiteUrl()+"/system/payment/cmbc_response.html";
	
	//请联系客户经理索要商户签约密钥key
	String key = paymentMethod.getConfigData().get("key");
	
	String sign = "";

	Map<String, String> map = new HashMap<String, String>();
	map.put("partner_id", partner_id);
	map.put("return_url", return_url);
	map.put("notify_url",notify_url);
	map.put("amount", amount);
	map.put("body", body);
	map.put("buyer_email", buyer_email);
	map.put("input_charset", input_charset);
	map.put("out_trade_no", out_trade_no);
	map.put("payMethod", payMethod);
	map.put("seller_email", seller_email);
	map.put("service", service);
	map.put("show_url", show_url);
	map.put("sign_type", sign_type);
	map.put("subject", subject);
	
	//2. 获得签名字符串
	if (StringUtils.isNotEmpty(key)) {
		sign = SignHelper.sign(map, key);
		map.put("sign", sign);
	}else{
		System.out.println("key不能为空");
		return;
	}
	
	System.out.println("签名结果为：" + sign);
	
	//3.生成支付serviceUrl
	Set entrySet = map.entrySet();
	Iterator it = entrySet.iterator();
	StringBuffer tailString = new StringBuffer();
	while(it.hasNext()){
		Entry<String, String> entry = (Entry<String, String>)it.next();
		tailString.append(entry.getKey());
		tailString.append("=");
		tailString.append(URLEncoder.encode(entry.getValue()));
		tailString.append("&");
	}
	
	tailString.deleteCharAt(tailString.length() - 1);//去掉最后一个&符号	
	String serviceUrl = baseServiceUrl + "?" + tailString.toString();
	System.out.println("支付服务URL:" + serviceUrl);

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

	<form name="paymentGatewayForm" action="<%=serviceUrl %>" method="post">
    </form>
    
	<%@ include file="./include/payOrderTips.jspf" %>
	
	</body>
</html>