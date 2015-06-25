<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*,org.springframework.web.context.support.WebApplicationContextUtils,
			org.springframework.web.context.WebApplicationContext"
			 pageEncoding="UTF-8"
			 errorPage="/error.jsp"
%>
<%
		//data return from payment gateway
		/**		
		md5 encrypt 

		Name:[amount] Value:[0.10]
		Name:[Currency_type] Value:[RMB]
		Name:[ipsbillno] Value:[NT2006082900010541]
		Name:[signature] Value:[01ba83a2cfb1490af0a0d9cfbc3cad66]
		Name:[retencodetype] Value:[12]
		Name:[msg] Value:[Success]
		Name:[succ] Value:[Y]
		Name:[mercode] Value:[000015]
		Name:[billno] Value:[062]
		Name:[date] Value:[20060829]
		Name:[attach] Value:[4]
		**/

        //验证方式：
        //交易返回接口采用Md5验证(RetEncodeType=12)
       
        String billno = request.getParameter("billno");
        String currency_type = request.getParameter("Currency_type");
        String amount = request.getParameter("amount");
        String mydate = request.getParameter("date");
        String succ = request.getParameter("succ");
        String msg = request.getParameter("msg");
        String ipsbillno = request.getParameter("ipsbillno");
        String retEncodeType = request.getParameter("retencodetype");
        String signature = request.getParameter("signature");
		String paymentGatewayId=request.getParameter("attach");

		String Mer_Cert="";
 		
		WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
		PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
		PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("ips");
		Mer_Cert=paymentMethod.getConfigData().get("Mer_Cert").toString();
		
		String succFlag="0";

       if("Y".equalsIgnoreCase(succ)) 
		{
			String originalText=billno + amount + mydate +succ + ipsbillno + currency_type+Mer_Cert;
			//md5 明文：【订单编号】+【订单金额】+【订单日期】+【成功标志】+【IPS 订单编号】+【币种】+【商户内部证书】
			String signature2=com.cartmatic.estore.system.util.TranslateService.md5Translate(originalText);
			if(signature2.equals(signature))//TODO 订单金额及订单号比较
			{
				 succFlag="1";	
			}
		}	

		request.setAttribute("orderNo",billno);
		request.setAttribute("successFlag",succFlag);
		request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
		request.setAttribute("amount",amount);
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>