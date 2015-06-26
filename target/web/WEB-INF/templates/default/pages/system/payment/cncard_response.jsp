<%
	//作用：云网支付响应页
	//作者：csx
	//时间：2006-08-17
%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="/error.jsp"%>
<%
	/*
		sample data return from cncard payment
		---------------------------------------
		Name:[c_memo2] Value:[020]
		Name:[c_orderamount] Value:[0.10]
		Name:[c_succmark] Value:[Y]
		Name:[c_ymd] Value:[20060817]
		Name:[c_mid] Value:[1008433]
		Name:[c_moneytype] Value:[0]
		Name:[c_transnum] Value:[2546177]
		Name:[c_memo1] Value:[12]
		Name:[c_signstr] Value:[3566b9bb9a8166d03866dd845504c07b]
		Name:[c_paygate] Value:[1]
		Name:[c_order] Value:[020]
		Name:[c_cause] Value:[succ]
		----------------------------------------
	*/
	//md5 info 1008433 & 020 & 0.10 & 20060817 & 2546177 & Y & 0 & 12 & 020 & 2cuxhyfr9d
	//c_signstr = md5(c_mid & c_order & c_orderamount & c_ymd & c_transnum & c_succmark & c_moneytype & c_memo1 & c_memo2 & c_pass)

	String c_mid=request.getParameter("c_mid");
	String c_order=request.getParameter("c_order");
	String c_orderamount=request.getParameter("c_orderamount");
	String c_ymd=request.getParameter("c_ymd");
	String c_transnum=request.getParameter("c_transnum");
	String c_succmark=request.getParameter("c_succmark");
	String c_moneytype=request.getParameter("c_moneytype");
	String c_memo1=request.getParameter("c_memo1");
	String c_memo2=request.getParameter("c_memo2");
	
	String c_signstr1=request.getParameter("c_signstr");
	
	
	String c_pass="";

	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());

	//get the key of this payment gateway.

	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");

	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("cncard");

	c_pass=paymentMethod.getConfigData().get("c_pass").toString();

	String originalText=c_mid+c_order+c_orderamount+c_ymd+c_transnum+c_succmark+c_moneytype+c_memo1+c_memo2+c_pass;
	String c_signstr2=TranslateService.md5Translate(originalText);
	
	String succFlag="0";//success flag.

	if(c_signstr1.equals(c_signstr2)){//present the data is really come from cncard payment gateway.
		if(c_succmark.equalsIgnoreCase("Y")){//present the order is pay for successfully
			succFlag="1";
		}
	}
	request.setAttribute("orderNo",c_order);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	request.setAttribute("amount",c_orderamount);
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>