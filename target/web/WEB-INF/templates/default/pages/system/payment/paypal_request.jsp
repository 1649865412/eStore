<%
    /* 
     Description:
     Paypal request form page
     request paramter rm:
     make the transation data post back ,this value is default 1,redirected to the return URL by the GET method, 
     and no transaction variables are sent.
     */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.HashMap,
	java.text.DecimalFormat,
	com.cartmatic.estore.common.model.order.SalesOrder,
	com.cartmatic.estore.common.model.system.PaymentMethod,
	com.cartmatic.estore.core.util.UrlUtil,
	org.springframework.web.context.support.WebApplicationContextUtils"%>
<%
    String baseURL = "https://www.eluxuryoutlets.com";
    String returnURL = baseURL + "/system/payment/paypal_response.html";
    String cancelURL = baseURL + "/myaccount/account.html";
    SalesOrder salesOrder = (SalesOrder) request.getAttribute("salesOrder");
    PaymentMethod paymentMethod = (PaymentMethod) request.getAttribute("paymentMethod");
    
    //检查是否测试模式
    String ppHost = "www.paypal.com";
    String testModel = paymentMethod.getConfigData().get("testModel").toString();
    if (testModel.equals("Y"))
    {
        ppHost = "www.sandbox.paypal.com";
    }
    String url = "https://"+ppHost+"/cgi-bin/webscr";
    //组建参数
    DecimalFormat df = new java.text.DecimalFormat("0.00");
    url = UrlUtil.appendParamToUrl(url, "amount", df.format(salesOrder.getShouldPay()));
    url = UrlUtil.appendParamToUrl(url, "item_name", "PursesMaMa Purchase#"+salesOrder.getOrderNo());
    url = UrlUtil.appendParamToUrl(url, "charset", "UTF-8");
    url = UrlUtil.appendParamToUrl(url, "cmd", "_xclick");
    url = UrlUtil.appendParamToUrl(url, "redirect_cmd", "_xclick");
    url = UrlUtil.appendParamToUrl(url, "custom", salesOrder.getOrderNo());
    url = UrlUtil.appendParamToUrl(url, "invoice", "Invoice#"+ salesOrder.getOrderNo());
    url = UrlUtil.appendParamToUrl(url, "rm", "2");
    url = UrlUtil.appendParamToUrl(url, "business", paymentMethod.getConfigData().get("business").toString());
    url = UrlUtil.appendParamToUrl(url, "currency_code", paymentMethod.getConfigData().get("currency_code").toString());
    url = UrlUtil.appendParamToUrl(url, "return", returnURL);
    url = UrlUtil.appendParamToUrl(url, "cancel_return", cancelURL);
    url = UrlUtil.appendParamToUrl(url, "notify_url", returnURL);
    url = UrlUtil.appendParamToUrl(url, "email", salesOrder.getCustomerEmail());
    url = UrlUtil.appendParamToUrl(url, "first_name", salesOrder.getOrderAddress().getFirstname());
    url = UrlUtil.appendParamToUrl(url, "last_name", salesOrder.getOrderAddress().getLastname());
    url = UrlUtil.appendParamToUrl(url, "address1", salesOrder.getOrderAddress().getAddress1());
    url = UrlUtil.appendParamToUrl(url, "address2", salesOrder.getOrderAddress().getAddress2());
    url = UrlUtil.appendParamToUrl(url, "city", salesOrder.getOrderAddress().getCity());
    url = UrlUtil.appendParamToUrl(url, "zip", salesOrder.getOrderAddress().getPostalcode());
    //url = UrlUtil.appendParamToUrl(url, "country", "US");
    url = UrlUtil.appendParamToUrl(url, "lc", "US");
    response.sendRedirect(url);
%>
<%-- 
<form name="paymentGatewayForm"
	action="https://<%=host%>/cgi-bin/webscr" method="post">
	<input type=hidden name="amount"
		value="<%=df.format(salesOrder.getShouldPay())%>">
	<input type=hidden name="item_name"
		value="Order(<%=salesOrder.getOrderNo()%>)">
	<input type=hidden name="charset" value="UTF-8">
	<input type=hidden name="cmd" value="_ext-enter">
	<input type=hidden name="redirect_cmd" value="_xclick">
	<input type=hidden name="custom" value="<%=salesOrder.getOrderNo()%>">
	<input type=hidden name="invoice"
		value="Invoice(<%=salesOrder.getOrderNo()%>)">
	<input type=hidden name="rm" value="2">
	<input type=hidden name="business"
		value="${paymentMethod.configData.business}">
	<input type=hidden name="currency_code"
		value="${paymentMethod.configData.currency_code}">
	<input type=hidden name="return" value="<%=returnURL%>">
	<input type=hidden name="cancel_return" value="<%=cancelURL%>">
	<input type=hidden name="notify_url" value="<%=returnURL%>">
	<!-- <input type=hidden name="image_url" value="https://www.eluxuryoutlets.com/images/layout/mall_logo.jpg"> -->
</form>
--%>