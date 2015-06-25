<%
	//Descripion: eWAY.Shared Payment Response Page
	//CreateTime:2006-07-31
	/**
		# approved
		#  'ewayTrxnStatus' => 'True',
		#  'ewayTrxnNumber' => '',
		#  'ewayTrxnReference' => '9999999',
		#  'eWAYoption1' => '',
		#  'eWAYoption2' => '',
		#  'eWAYoption3' => 'TRUE',
		#  'eWAYresponseCode' => '08',
		#  'eWAYresponseText' => 'TRANSACTION APPROVED',
		#  'ewayReturnAmount' => '$132.00',
		#  'eWAYAuthCode' => '002644',
	=================================================
		# fail
		# eWAYoption1 Value:080
		# eWAYReturnAmount Value:$0.33
		# ewayTrxnNumber Value:080
		# eWAYAuthCode Value:''
		# eWAYoption2 Value:''
		# ewayTrxnStatus Value:False
		# ewayTrxnReference Value:9999999
		# eWAYoption3 Value:FALSE
		# eWAYresponseText Value:CARD NOT VALID      
		# eWAYresponseCode Value:31
	**/
%>
<%@ page contentType="text/html; charset=UTF-8" 
	import="com.cartmatic.estore.system.util.TranslateService,
	org.springframework.web.context.WebApplicationContext,
	org.springframework.web.context.support.WebApplicationContextUtils"
	errorPage="/error.jsp"
%>	
<%
	String succFlag="0";
	
	String ewayTrxnStatus=request.getParameter("ewayTrxnStatus");
	String orderNo=request.getParameter("eWAYoption1");
	
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("eway_share");
	
	if(request.getMethod().equalsIgnoreCase("POST")&&ewayTrxnStatus!=null){
		if("TRUE".equalsIgnoreCase(ewayTrxnStatus)){
			succFlag="1";
		}
	}
	request.setAttribute("flowNo",request.getParameter("ewayTrxnReference"));
	request.setAttribute("orderNo",orderNo);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	
	String e_amount=request.getParameter("eWAYReturnAmount");
	
	if(e_amount!=null){
		request.setAttribute("amount",e_amount.substring(1,e_amount.length()));
	}
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>
