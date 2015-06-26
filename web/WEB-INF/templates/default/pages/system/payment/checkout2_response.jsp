<%@page errorPage="/error.jsp" contentType="text/html; charset=UTF-8"%>
<%
	//parameter cart_order_id store the order number
	// when request to paymentgateway.	

	String cartOrderId=request.getParameter("cart_order_id");

	String succFlag="0";//is wrong data or is come from other unfriend source (eg vicious attack)

	String orderNo="";
	
	if(cartOrderId!=null){
		orderNo=request.getParameter("order_number");

		String total=request.getParameter("total");

		String demo=request.getParameter("demo");

		String processResult=request.getParameter("credit_card_processed");

		String key=request.getParameter("key");

		if(demo!=null && "Y".equalsIgnoreCase(demo)){
			orderNo="1";	
		}
		
		WebApplicationContext cxt=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
		PaymentMethodManager paymentMethodManager=(PaymentMethodManager)cxt.getBean("paymentMethodManager");
		PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("checkout2");
		//get this payment gateway configuration data to verify the data trueness
		
		String secretword=paymentMethod.getConfigData().get("secretword").toString();
		
		String vendorId=paymentMethod.getConfigData().get("vendorId").toString();
		
		//md5 ( secret word + vendor number + order number + total )
		String md5Key=TranslateService.md5Translate(secretword+vendorId+orderNo+total).toUpperCase();	
			
		if(md5Key.equals(key)){//data is really come from checkout2 server
			if(processResult.equalsIgnoreCase("Y")){//order has pay for successfully
				succFlag="1";
			}else if(processResult.equalsIgnoreCase("K")){//waiting for approval (Pending)
				succFlag="-1";
			}
		}

		request.setAttribute("orderNo",orderNo);
		request.setAttribute("successFlag",succFlag);
		request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
		request.setAttribute("amount",total);
	}
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>