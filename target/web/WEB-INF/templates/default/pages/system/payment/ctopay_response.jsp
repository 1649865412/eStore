<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.cartmatic.estore.system.service.PaymentMethodManager"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.system.util.TranslateService"%>
<%
    //字符编码
    String CharacterEncoding = "UTF-8";
    request.setCharacterEncoding(CharacterEncoding);

    String BillNo = request.getParameter("BillNo");
    String Currency = request.getParameter("Currency");
    String Amount = request.getParameter("Amount");
    String Succeed = request.getParameter("Succeed");
    String Result = request.getParameter("Result");
    String MD5info = request.getParameter("MD5info");
	
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("ctopay");
	
    String MD5key =(String)paymentMethod.getConfigData().get("MD5key");
    
    String md5src = BillNo + Currency + Amount + Succeed + MD5key;
    String md5str = TranslateService.md5Translate(md5src);
    
	
    String succFlag="0";//success flag.

	if(md5str.equalsIgnoreCase(MD5info)){//present the data is really come from ctopay payment gateway.
		if(Succeed.equalsIgnoreCase("1")){//present the order is pay for successfully
			succFlag="1";
		}
	}
	request.setAttribute("orderNo",BillNo);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	request.setAttribute("amount",Amount);
	request.setAttribute("errorMessage",Result);
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>