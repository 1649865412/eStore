<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.hitrust.trustpay.client.b2c.*,
com.cartmatic.estore.common.model.order.SalesOrder,
com.cartmatic.estore.common.model.system.Store,
com.cartmatic.estore.common.helper.ConfigUtil,
com.cartmatic.estore.common.model.system.PaymentMethod,
java.text.DecimalFormat,
java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% response.setHeader("Cache-Control", "no-cache"); %>

<HTML>
<HEAD><TITLE>农行网上支付平台-支付结果接收</TITLE></HEAD>
<BODY>
	<CENTER>支付结果
		<br>
		<%
			Store store = ConfigUtil.getInstance().getStore();
			WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
			PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("abc");	
		
			String tABC = request.getParameter("ABC");
			System.out.println("tABC         = [" + tABC + "]<br>");
			
			//1、取得MSG参数，并利用此参数值生成支付结果对象
			PaymentResult tResult = new PaymentResult(request.getParameter("MSG"));
			
			String orderNo = "";
			String succFlag = "";
			String amount = "";
			String date = "";
			String errorMessage = "";
			
			//2、判断支付结果状态，进行后续操作
			if (tResult.isSuccess()) {
			  //3、支付成功
			  out.println("TrxType         = [" + tResult.getValue("TrxType"        ) + "]<br>");
			  out.println("OrderNo         = [" + tResult.getValue("OrderNo"        ) + "]<br>");
			  out.println("Amount          = [" + tResult.getValue("Amount"         ) + "]<br>");
			  out.println("BatchNo         = [" + tResult.getValue("BatchNo"        ) + "]<br>");
			  out.println("VoucherNo       = [" + tResult.getValue("VoucherNo"      ) + "]<br>");
			  out.println("HostDate        = [" + tResult.getValue("HostDate"       ) + "]<br>");
			  out.println("HostTime        = [" + tResult.getValue("HostTime"       ) + "]<br>");
			  out.println("MerchantRemarks = [" + tResult.getValue("MerchantRemarks") + "]<br>");
			  out.println("PayType         = [" + tResult.getValue("PayType"        ) + "]<br>");
			  out.println("NotifyType      = [" + tResult.getValue("NotifyType"     ) + "]<br>");
			  out.println("TrnxNo          = [" + tResult.getValue("iRspRef"        ) + "]<br>");
			  
			  orderNo = tResult.getValue("OrderNo");
			  amount = tResult.getValue("Amount");
			  succFlag="1";
			  date =  tResult.getValue("HostDate");
			}
			else {
			  //4、支付失败
			  out.println("ReturnCode   = [" + tResult.getReturnCode  () + "]<br>");
			  out.println("ErrorMessage = [" + tResult.getErrorMessage() + "]<br>");
			  succFlag = "-1";
			}
			StringBuffer originalText = new  StringBuffer(paymentMethod.getConfigData().get("merchantNo"));
			originalText.append("|");
			originalText.append(orderNo);
			originalText.append("|");
			originalText.append(date);
			originalText.append("|");
			originalText.append(succFlag);
			originalText.append("|");
			originalText.append(amount);
			
			request.setAttribute("orderNo",orderNo);
			request.setAttribute("successFlag",succFlag);
			request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
			request.setAttribute("amount",amount);
			request.setAttribute("errorMessage", originalText.toString());
		%>
		<a href='${ctxPath}'>回商户首页</a>
	</CENTER>

<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>

</BODY>
</HTML>

