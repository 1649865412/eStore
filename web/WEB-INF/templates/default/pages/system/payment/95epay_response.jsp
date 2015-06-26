<%@ page pageEncoding="UTF-8" errorPage="/error.jsp"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.system.util.TranslateService"%>
<%@page import="com.cartmatic.estore.system.service.PaymentMethodManager"%>
<%@page import="com.cartmatic.estore.system.util.PaymentUtil"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.apache.commons.logging.Log"%>
<%
WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("95epay");

    //字符编码
    request.setCharacterEncoding("UTF-8");
    String succFlag="0";
    
   	String BillNo = request.getParameter("BillNo");
    String Currency = request.getParameter("Currency");
    String Amount = request.getParameter("Amount");
    String Succeed = request.getParameter("Succeed");//支付状态:该值说明见于word说明文档[商户根据该值来修改数据库中相应订单的状态]
    String Result = request.getParameter("Result"); //支付结果信息：展示给顾客看的信息
	String Remark = request.getParameter("Remark");//商户备注
    String MD5info = request.getParameter("MD5info");
    String MD5key = (String)paymentMethod.getConfigData().get("md5key");//"12345678"测试用
    if (BillNo != null && Currency != null && Amount != null && Succeed != null & MD5key != null)
    {
    	String md5src = BillNo + Currency + Amount + Succeed + MD5key;
    	String md5str = TranslateService.md5TranslateUpperCase(md5src);
		if(md5str.equalsIgnoreCase(MD5info)){
			if(Succeed.equals("88")){
				succFlag="1";
			}else if(Succeed.equals("1")||Succeed.equals("9")||Succeed.equals("19")){
				succFlag="-1";
			}
		}
    }
	//*** RETURN
	String ReturnBillNo = request.getParameter("ReturnBillNo");	//商户网站订单号
    String ReturnCurrency = request.getParameter("ReturnCurrency");//交易币种
    String ReturnAmount = request.getParameter("ReturnAmount");		//以以上币种计价的金额
    String ReturnSucceed = request.getParameter("ReturnSucceed");//返回码: 1 :表示交易成功 ; 0: 表示交易失败
    String ReturnResult = request.getParameter("ReturnResult"); // success: 表示成功 ;   fail:表示失败
    String ReturnMD5info = request.getParameter("ReturnMD5info");
    if (ReturnBillNo != null && ReturnCurrency != null && ReturnAmount != null && ReturnSucceed != null)
    {
        BillNo = ReturnBillNo;
        Amount = ReturnAmount;
        
    	String ReturnMd5src = ReturnBillNo + ReturnCurrency + ReturnAmount + ReturnSucceed + MD5key;
    	String ReturnMd5sign = TranslateService.md5TranslateUpperCase(ReturnMd5src);
		if(ReturnMD5info.equals(ReturnMd5sign)){//签名匹配
			if(ReturnSucceed.equals("1")){//支付已成功
		    	succFlag="1";
			}
			else if(ReturnSucceed.equals("0")){//支付失败
			//请修改订单状态,或者其他操作
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