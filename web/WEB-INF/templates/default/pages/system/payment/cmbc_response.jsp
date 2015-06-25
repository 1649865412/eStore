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
<HEAD><TITLE>民生银行支付平台-支付结果接收</TITLE></HEAD>
<BODY>
	<CENTER>支付结果
	
		<br>
		<%
			Store store = ConfigUtil.getInstance().getStore();
			WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
			PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("cmbc");	
		
			String notify_type = request.getParameter("notify_type");
			
			String orderNo = request.getParameter("out_trade_no");
			String date = "";
			String isSuccess = "";
			
			//判断是return_url还是notify_url
			if(notify_type != null && notify_type.equals("TRADE_PAY")){
				date = request.getParameter("pay_date");
				isSuccess = request.getParameter("trade_status");
				if(isSuccess.equals("TRADE_FINISHED")){
					isSuccess = "T";
					request.setAttribute("paymentMethodCode",paymentMethod.getPaymentMethodCode());
				}
			}else{
				date = request.getParameter("process_date"); 
				isSuccess = request.getParameter("is_success");
			}
			
			String amount = request.getParameter("total_fee");
			
			String succFlag = "-1";
			
			if(isSuccess.equals("T")){
				succFlag = "1";
			}
			
			StringBuffer originalText = new  StringBuffer(paymentMethod.getConfigData().get("partner_id"));
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
			
			if(notify_type != null && notify_type.equals("TRADE_PAY")){
				System.out.println("ming sheng bank : " + originalText.toString());
			}
		%>
	</CENTER>

<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>

</BODY>
</HTML>

