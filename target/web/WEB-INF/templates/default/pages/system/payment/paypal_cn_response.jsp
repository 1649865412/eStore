<%
	//Paypal IPN Message
 %>
<%@ page language="java" import="com.cartmatic.estore.system.util.TranslateService,
								org.springframework.web.context.support.WebApplicationContextUtils,
								java.util.*,
								org.springframework.web.context.WebApplicationContext"
	contentType="text/html; charset=UTF-8"
	errorPage="/error.jsp"
%>
	<%
		response.setCharacterEncoding("UTF-8");
		String testModel=null;
		//store the order no in custom parameter when commit payment reuqest
		String orderNo=request.getParameter("custom");

		WebApplicationContext cxt=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
		PaymentMethodManager paymentMethodManager=(PaymentMethodManager)cxt.getBean("paymentMethodManager");
		PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("paypal_china");
		testModel=paymentMethod.getConfigData().get("testModel").toString();
		
		String host="";

		if(testModel==null||testModel.equals("N")){
			host="https://www.paypal.com:443/cgi-bin/webscr";
		}else{
			host="https://www.sandbox.paypal.com:443/cgi-bin/webscr";
		}
		
		String payment_status=request.getParameter("payment_status");

		String succFlag="0";

		if(payment_status!=null&&payment_status.equalsIgnoreCase("Completed")){
			Map dataMap=request.getParameterMap();
			Map sendData=new HashMap();
			Iterator i=dataMap.entrySet().iterator();
			while(i.hasNext()){
				Map.Entry en=(Map.Entry)i.next();
				sendData.put(en.getKey(),((String[])en.getValue())[0]);
			}			

			sendData.put("cmd","_notify-validate");
			
			String responseText=TranslateService.getResponseFromHttpsUrl(host,sendData);

			if(responseText.trim().equalsIgnoreCase("VERIFIED")){//the data come from paypal
					succFlag="1";
			}//else if(responseText.trim().equalsIgnoreCase("INVALID")){//Declined (invalid request)//}
		}else if("Pending".equals(payment_status)){//Queued
			succFlag="-1";
		}
  	
	request.setAttribute("orderNo",orderNo);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	request.setAttribute("amount",request.getParameter("mc_gross"));
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>