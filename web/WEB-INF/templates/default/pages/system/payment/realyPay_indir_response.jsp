<%@ page pageEncoding="UTF-8" errorPage="/error.jsp"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.system.util.TranslateService"%>
<%@page import="com.cartmatic.estore.system.service.PaymentMethodManager"%>
<%@page import="com.cartmatic.estore.system.util.PaymentUtil"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%
WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("realyPay-indir");

    //字符编码
    request.setCharacterEncoding("UTF-8");
    String succFlag="0";
    
   	String BillNo = request.getParameter("order_sn");
    String Currency = request.getParameter("Currency");
    String Amount = request.getParameter("total");
    String Succeed = request.getParameter("verified");//支付状态:该值说明见于word说明文档[商户根据该值来修改数据库中相应订单的状态]
    String Result = request.getParameter("transactionid")+" "+Succeed; //支付结果信息
	//String siteid = request.getParameter("siteid");
    String MD5info = request.getParameter("verifyCode");
    String MD5key = (String)paymentMethod.getConfigData().get("md5key");//"12345678"测试用
    String MerNo = (String)paymentMethod.getConfigData().get("merNo"); //"1002"测试用商户号
    if (BillNo != null && Amount != null && Succeed != null & MD5key != null)
    {
    	String md5src = BillNo + MerNo + MD5key;
    	String md5str = TranslateService.md5TranslateUpperCase(md5src);
		if(md5str.equalsIgnoreCase(MD5info)){
			if(Succeed.equals("approved")){
				succFlag="1";
			}else if(Succeed.equals("pending")){
				succFlag="-1";
			}
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