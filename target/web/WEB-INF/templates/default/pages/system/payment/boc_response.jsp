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
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("boc");
	
	//订单状态：0-未处理1-支付4-未明5-失败
	String orderStatus = request.getParameter("orderStatus");
	String payAmount = request.getParameter("payAmount");
	//String 
	//merchantNo|orderNo|orderSeq|cardTyp|payTime|orderStatus|payAmount
	StringBuffer originalText = new  StringBuffer(request.getParameter("merchantNo"));
	originalText.append("|");
	originalText.append(request.getParameter("orderNo"));
	originalText.append("|");
	originalText.append(request.getParameter("orderSeq"));
	originalText.append("|");
	originalText.append(request.getParameter("cardTyp"));
	originalText.append("|");
	originalText.append(request.getParameter("payTime"));
	originalText.append("|");
	originalText.append(orderStatus);
	originalText.append("|");
	originalText.append(payAmount);

	PKCS7Tool tool = PKCS7Tool.getVerifier(paymentMethod.getConfigData().get("rootCertificatePath"));
	String succFlag="0";
	try
	{
		tool.verify(request.getParameter("signData"),originalText.toString().getBytes(),null);
		if ("1".equals(orderStatus))
		{
			succFlag="1";
		}
		else
		{
			succFlag="-1";
		}
	}catch(Throwable e)
	{
		e.printStackTrace();
		succFlag="0";
	}
	//String signData = tool.sign(originalText.toString().getBytes());
	//System.out.println(originalText.toString());

request.setAttribute("orderNo",request.getParameter("orderNo"));
request.setAttribute("successFlag",succFlag);
request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
request.setAttribute("amount",payAmount);
request.setAttribute("errorMessage", originalText.toString());
	
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>
