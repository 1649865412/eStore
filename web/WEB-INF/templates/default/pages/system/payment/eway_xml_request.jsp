
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%><%
	//Decription: eWAY.XML payment Gateway Request and Response Page
	//CreateTime: 2006-07-31
	//Author:chenshangxuan
%>
<%@ page import="java.util.*,java.text.*,com.cartmatic.estore.system.util.*,
				com.cartmatic.estore.common.model.order.SalesOrder" 
				contentType="text/html; charset=UTF-8"
				errorPage="/error.jsp"
%>
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
		
	HashMap paramMap=paymentMethod.getConfigData();
	DecimalFormat df=new java.text.DecimalFormat("0.00");
	
	String cardHoldersName="";
	String cardNumber="";
	String cardExpiryMonth="";
	String cardExpiryYear="";
	String cvv2="";
	String option3="";

	String requestUrl="";
	if(paymentMethod.getConfigData().get("testModel").equals("Y")){

		requestUrl="https://www.eway.com.au/gateway/xmltest/TestPage.asp";
		//this data only for test
		cardHoldersName="demo holders";

		cardNumber="4646464646464646";

		Calendar cal=Calendar.getInstance();

		DecimalFormat tempDf=new DecimalFormat("00");

		cardExpiryMonth=tempDf.format(cal.get(cal.MONTH)+2);

		cardExpiryYear=tempDf.format(cal.get(cal.YEAR)+1).substring(2);
		
		cvv2="1234";

		option3="TRUE";
		
	}else{
		requestUrl="https://www.eway.com.au/gateway/xmlpayment.asp";
		option3="FALSE";
		//TODO add the card data here
	}
	//construct the request data to payment gateway.
	StringBuilder sb=new StringBuilder("<ewaygateway>");
	sb.append("<ewayCustomerID>" + paymentMethod.getConfigData().get("customerId")+ "</ewayCustomerID>");
	sb.append("<ewayTotalAmount>"+df.format(salesOrder.getTotal().floatValue()*100.00)+"</ewayTotalAmount>");
	sb.append("<ewayCustomerFirstName>"+salesOrder.getCustomerFirstName()+"</ewayCustomerFirstName>");
	sb.append("<ewayCustomerLastName>" + salesOrder.getCustomerLastname() +"</ewayCustomerLastName>");
	sb.append("<ewayCustomerEmail>"+salesOrder.getCustomerEmail()+"</ewayCustomerEmail>");
	sb.append("<ewayCustomerAddress>"+salesOrder.getShippingAddress()+"</ewayCustomerAddress>" );
	sb.append("<ewayCustomerPostcode>"+ salesOrder.getShippingZip() + "</ewayCustomerPostcode>");
	sb.append("<ewayCustomerInvoiceDescription>Order No:" +salesOrder.getOrderNo()+ "</ewayCustomerInvoiceDescription>");
	sb.append("<ewayCustomerInvoiceRef>"+ salesOrder.getOrderNo()+"</ewayCustomerInvoiceRef>");
	sb.append("<ewayCardHoldersName>"+cardHoldersName+"</ewayCardHoldersName>");
	sb.append("<ewayCardNumber>" + cardNumber +"</ewayCardNumber>");
	sb.append("<ewayCardExpiryMonth>" + cardExpiryMonth +"</ewayCardExpiryMonth>");
	sb.append("<ewayCardExpiryYear>"+cardExpiryYear+"</ewayCardExpiryYear>");
	sb.append("<ewayTrxnNumber>"+salesOrder.getOrderNo()+"</ewayTrxnNumber>");
	sb.append("<ewayOption1></ewayOption1>");
	sb.append("<ewayOption2></ewayOption2>");
	sb.append("<ewayOption3>"+option3+"</ewayOption3>");
	sb.append("<ewayCVN>"+cvv2+"</ewayCVN>");
	sb.append("</ewaygateway>");

	String responseText="";
	responseText=PaymentUtil.submitDataFromHttpsUrl(requestUrl,sb.toString(),"text/xml");
	// parse the xml data to map data
	Map responseMap=PaymentUtil.getParseData(responseText);
	
	if(responseMap.get("ewayTrxnStatus").toString().trim().equalsIgnoreCase("True")){//trasatcion success
		//TODO update order status
	}else{
		//TODO fail
	}

%>