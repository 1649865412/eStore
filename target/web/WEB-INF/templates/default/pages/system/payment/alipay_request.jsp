<%@page import="com.cartmatic.estore.common.model.order.SalesOrder,
com.cartmatic.estore.common.model.system.Store,
com.cartmatic.estore.common.helper.ConfigUtil,
com.cartmatic.estore.common.model.system.PaymentMethod,
java.text.DecimalFormat,
java.text.SimpleDateFormat"%>
<%@ page import="com.alipay.config.*"%>
<%@ page import="com.alipay.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<HTML>
<HEAD>
<%@ page import="com.cartmatic.estore.common.model.order.SalesOrder,
				org.springframework.web.context.support.WebApplicationContextUtils"
				contentType="text/html; charset=UTF-8"
				errorPage="/error.jsp"
 %>
 <%
		Store store = ConfigUtil.getInstance().getStore();
		SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
		PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
		
		HashMap paramMap=paymentMethod.getConfigData();
		
		DecimalFormat df=new java.text.DecimalFormat("0.00");


		////////////////////////////////////请求参数//////////////////////////////////////

		//支付类型
		String payment_type = "1";
		//必填，不能修改
		//服务器异步通知页面路径
		String notify_url = store.getSiteUrl()+"/system/payment/alipay_response.html";
		//需http://格式的完整路径，不能加?id=123这类自定义参数
		//页面跳转同步通知页面路径
		String return_url = store.getSiteUrl()+"/system/payment/alipay_response.html";
		//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
		//卖家支付宝帐户
		String seller_email = paramMap.get("merchant").toString();
		AlipayConfig.key = paramMap.get("key").toString();
		AlipayConfig.partner = paramMap.get("partnerId").toString();
		//必填
		//商户订单号
		String out_trade_no = salesOrder.getOrderNo();
		//商户网站订单系统中唯一订单号，必填
		//订单名称
		String subject = store.getName()+"订单:" +salesOrder.getOrderNo();
		//必填
		//付款金额
		String total_fee = df.format(salesOrder.getShouldPay().doubleValue());
		//必填
		//订单描述
		String body = store.getName()+"订单:" +salesOrder.getOrderNo();
		//商品展示地址
		String show_url = store.getSiteUrl()+"/myaccount/order/list.html";
		//需以http://开头的完整路径，例如：http://www.xxx.com/myorder.html
		//防钓鱼时间戳
		String anti_phishing_key = "";
		//若要使用请调用类文件submit中的query_timestamp函数
		//客户端的IP地址
		String exter_invoke_ip = "";
		//非局域网的外网IP地址，如：221.0.0.1
		
		
		//////////////////////////////////////////////////////////////////////////////////
		
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "create_direct_pay_by_user");
        sParaTemp.put("partner", AlipayConfig.partner);
        sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("payment_type", payment_type);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("return_url", return_url);
		sParaTemp.put("seller_email", seller_email);
		sParaTemp.put("out_trade_no", out_trade_no);
		sParaTemp.put("subject", subject);
		sParaTemp.put("total_fee", total_fee);
		sParaTemp.put("body", body);
		sParaTemp.put("show_url", show_url);
		sParaTemp.put("anti_phishing_key", anti_phishing_key);
		sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
		
		//建立请求
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp,"get","确认");
		out.println(sHtmlText);
	%>
<%@ include file="./include/inc_common_request_js.jspf" %>
</HEAD>
<BODY>
	 <%@ include file="./include/payOrderTips.jspf" %>
</BODY>
</HTML>


