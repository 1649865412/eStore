<%@ page contentType="text/html; charset=UTF-8" 
	import="com.cartmatic.estore.system.util.TranslateService,
	org.springframework.web.context.WebApplicationContext,
	com.cartmatic.estore.system.service.PaymentHistoryManager,
	com.cartmatic.estore.common.model.system.PaymentHistory,
	com.cartmatic.estore.sales.service.SalesOrderManager,java.util.*,
	org.springframework.web.context.support.WebApplicationContextUtils"
	errorPage="/error.jsp"
%>
<%
	/**	
		data come from versign.
		#  'RESULT' => '12',
		#  'AUTHCODE' => '',
		#  'RESPMSG' => 'Declined',
		#  'AVSDATA' => 'N',
		#  'PNREF' => 'V63A28821903',
		#  'INVOICE' => '514',
		#  'CSCMATCH' => 'Y',
		===========================
		#  'RESULT' => '0',
		#  'AUTHCODE' => '081PNI',
		#  'RESPMSG' => 'Approved',
		#  'AVSDATA' => 'XXN',
		#  'PNREF' => 'V63A28822066',
		#  'CSCMATCH' => 'Y',
		#  'INVOICE' => '514',
	*/

	Map cvvMap=new LinkedHashMap();

	cvvMap.put("Y" , "The CSC value matches the data on file");
	cvvMap.put("N" , "The CSC value does not matches the data on file.");
	cvvMap.put("X" , "The cardholder's bank does not support this service");
	
	Map avsMap=new LinkedHashMap();

	avsMap.put("Y" , "Match");
	avsMap.put("N" , "No match");
	avsMap.put("X" , "Service unavailable or not completed");

	Map resultMap=new LinkedHashMap();
	
	resultMap.put("-1" , "Failed to connect to host");
	resultMap.put("-2", "Failed to resolve hostname");
	resultMap.put("-5" , "Failed to initialize SSL context");
	resultMap.put("-6" , "Parameter list format error: & in name");
	resultMap.put("-7" , "Parameter list format error: invalid [ ] name length clause");
	resultMap.put("-8" , "SSL failed to connect to host");
	resultMap.put("-9" , "SSL read failed");
	resultMap.put("-10" , "SSL write failed");
	resultMap.put("-11" , "Proxy authorization failed");
	resultMap.put("-12" , "Timeout waiting for response");
	resultMap.put("-13" , "Select failure");
	resultMap.put("-14" , "Too many connections");
	resultMap.put("-15" , "Failed to set socket options");
	resultMap.put("-20" , "Proxy read failed");
	resultMap.put("-21" , "Proxy write failed");
	resultMap.put("-22" , "Failed to initialize SSL certificate");
	resultMap.put("-23" , "Host address not specified");
	resultMap.put("-24" , "Invalid transaction type");
	resultMap.put("-25" , "Failed to create a socket");
	resultMap.put("-26" , "Failed to initialize socket layer");
	resultMap.put("-27" , "Parameter list format error: invalid [ ] name length clause");
	resultMap.put("-28" , "Parameter list format error: name");
	resultMap.put("-29" , "Failed to initialize SSL connection");
	resultMap.put("-30" , "Invalid timeout value");
	resultMap.put("-31" , "The certificate chain did not validate, no local certificate found");
	resultMap.put("-32" , "The certificate chain did not validate, common name did not match URL");
	resultMap.put("-99" , "Out of memory");
	resultMap.put("1" , "User authentication failed");
	resultMap.put("2" , "Invalid tender type. Your merchant bank account does not support the following credit card type that was submitted.");
	resultMap.put("3" , "Invalid transaction type. Transaction type is not appropriate for this transaction. For example, you cannot credit an authorization-only transaction.");
	resultMap.put("4" , "Invalid amount format");
	resultMap.put("5" , "Invalid merchant information. Processor does not recognize your merchant account information. Contact your bank account acquirer to resolve this problem.");
	resultMap.put("7" , "Field format error. Invalid information entered. See RESPMSG.");
	resultMap.put("8" , "Not a transaction server");
	resultMap.put("9" , "Too many parameters or invalid stream");
	resultMap.put("10" , "Too many line items");
	resultMap.put("11" , "Client time-out waiting for response");
	resultMap.put("12" , "Declined. Check the credit card number and transaction information to make sure they were entered correctly. If this does not resolve the problem, have the customer call the credit card issuer to resolve.");
	resultMap.put("13" , "Referral. Transaction was declined but could be approved with a verbal authorization from the bank that issued the card. Submit a manual Voice Authorization transaction and enter the verbal auth code.");
	resultMap.put("19" , "Original transaction ID not found. The transaction ID you entered for this transaction is not valid. See RESPMSG.");
	resultMap.put("20" , "Cannot find the customer reference number");
	resultMap.put("22" , "Invalid ABA number");
	resultMap.put("23" , "Invalid account number. Check credit card number and re-submit.");
	resultMap.put("24" , "Invalid expiration date. Check and re-submit.");
	resultMap.put("25" , "Invalid Host Mapping. Transaction type not mapped to this host");
	resultMap.put("26" , "Invalid vendor account");
	resultMap.put("27" , "Insufficient partner permissions");
	resultMap.put("28" , "Insufficient user permissions");
	resultMap.put("29" , "Invalid XML document. This could be caused by an unrecognized XML tag or a bad XML format that cannot be parsed by the system.");
	resultMap.put("30" , "Duplicate transaction");
	resultMap.put("31" , "Error in adding the recurring profile");
	resultMap.put("32" , "Error in modifying the recurring profile");
	resultMap.put("33" , "Error in canceling the recurring profile");
	resultMap.put("34" , "Error in forcing the recurring profile");
	resultMap.put("35" , "Error in reactivating the recurring profile");
	resultMap.put("36" , "OLTP Transaction failed");
	resultMap.put("50" , "Insufficient funds available in account");
	resultMap.put("99" , "General error. See RESPMSG.");
	resultMap.put("100" , "Transaction type not supported by host");
	resultMap.put("101" , "Time-out value too small");
	resultMap.put("102" , "Processor not available");
	resultMap.put("103" , "Error reading response from host");
	resultMap.put("104" , "Timeout waiting for processor response. Try your transaction again.");
	resultMap.put("105" , "Credit error. Make sure you have not already credited this transaction, or that this transaction ID is for a creditable transaction. (For example, you cannot credit an authorization.)");
	resultMap.put("106" , "Host not available");
	resultMap.put("107" , "Duplicate suppression time-out");
	resultMap.put("108" , "Void error. See RESPMSG. Make sure the transaction ID entered has not already been voided. If not, then look at the Transaction Detail screen for this transaction to see if it has settled. (The Batch field is set to a number greater than zero if the transaction has been settled). If the transaction has already settled, your only recourse is a reversal (credit a payment or submit a payment for a credit).");
	resultMap.put("109" , "Time-out waiting for host response");
	resultMap.put("111" , "Capture error. Only authorization transactions can be captured.");
	resultMap.put("112" , "Failed AVS check. Address and ZIP code do not match. An authorization may still exist on the cardholder's account.");
	resultMap.put("113" , "Cannot exceed sales cap. For ACH transactions only.");
	resultMap.put("113" , "Merchant sale total will exceed the cap with current transaction");
	resultMap.put("114" , "Card Security Code (CSC) Mismatch. An authorization may still exist on the cardholder's account.");
	resultMap.put("115" , "SysteresultMap.put(m busy, try again later");
	resultMap.put("116" , "VPS Internal error - Failed to lock terminal number");
	resultMap.put("117" , "Failed merchant rule check. An attempt was made to submit a transaction that failed to meet the security settings specified on the VeriSign Manager Security Settings page. See VeriSign Manager User's Guide.");
	resultMap.put("118" , "Invalid keywords found in string fields");
	resultMap.put("122" , "Merchant sale total will exceed the credit cap with current transaction. ACH transactions only.");
	resultMap.put("125" , "Fraud Protection Services Filter - Declined by filters");
	resultMap.put("126" , "Fraud Protection Services Filter - Flagged for review by filters");
	resultMap.put("127" , "Fraud Protection Services Filter - Not processed by filters");
	resultMap.put("128" , "Fraud Protection Services Filter - Declined by merchant after being flagged for review by filters");
	resultMap.put("1000" , "Generic host error. See RESPMSG. This is a generic message returned by your credit card processor. The message itself will contain more information describing the error.");
	resultMap.put("1001" , "Buyer Authentication Service unavailable");
	resultMap.put("1002" , "Buyer Authentication Service - Transaction timeout");
	resultMap.put("1003" , "Buyer Authentication Service - Invalid client version");
	resultMap.put("1004" , "Buyer Authentication Service - Invalid timeout value");
	resultMap.put("1011" , "Buyer Authentication Service unavailable");
	resultMap.put("1012" , "Buyer Authentication Service unavailable");
	resultMap.put("1013" , "Buyer Authentication Service unavailable");
	resultMap.put("1014" , "Buyer Authentication Service - Merchant is not enrolled for Buyer Authentication Service (3-D Secure). To enroll, log in to VeriSign Manager, click Security, and then click the Buyer Authentication Service banner on the page.");
	resultMap.put("1021" , "Buyer Authentication Service - Invalid card type");
	resultMap.put("1022" , "Buyer Authentication Service - Invalid or missing currency code");
	resultMap.put("1023" , "Buyer Authentication Service - Merchant has not activated buyer authentication for this card type");
	resultMap.put("1041" , "Buyer Authentication Service - Validate Authentication failed: missing or invalid PARES");
	resultMap.put("1042" , "Buyer Authentication Service - Validate Authentication failed: PARES format is invalid");
	resultMap.put("1043" , "Buyer Authentication Service - Validate Authentication failed: Cannot find successful Verify Enrollment");
	resultMap.put("1044" , "Buyer Authentication Service - Validate Authentication failed: Signature validation failed for PARES");
	resultMap.put("1045" , "Buyer Authentication Service - Validate Authentication failed: Mismatched or invalid amount in PARES");
	resultMap.put("1045" , "Buyer Authentication Service - Validate Authentication failed: Mismatched or invalid amount in PARES");
	resultMap.put("1046" , "Buyer Authentication Service - Validate Authentication failed: Mismatched or invalid acquirer in PARES");
	resultMap.put("1047" , "Buyer Authentication Service - Validate Authentication failed: Mismatched or invalid Merchant ID in PARES");
	resultMap.put("1048" , "Buyer Authentication Service - Validate Authentication failed: Mismatched or invalid card number in PARES");
	resultMap.put("1049" , "Buyer Authentication Service - Validate Authentication failed: Mismatched or invalid currency code in PARES");
	resultMap.put("1050" , "Buyer Authentication Service - Validate Authentication failed: Mismatched or invalid XID in PARES");
	resultMap.put("1051" , "Buyer Authentication Service - Validate Authentication failed: Mismatched or invalid order date in PARES");
	resultMap.put("1052" , "Buyer Authentication Service - Validate Authentication failed: This PARES was already validated for a previous Validate Authentication transaction");
	
	StringBuilder sb=new StringBuilder("");

	String result=request.getParameter("RESULT");
	String avs=request.getParameter("AVSDATA");
	String cvv=request.getParameter("CSCMATCH");
	String transactionId=request.getParameter("PNREF");
	String order_no=request.getParameter("USER1");
	String amount=request.getParameter("AMOUNT");
	
	WebApplicationContext cxt=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)cxt.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("verisign_link");

	//host ip,ensure the datas are come from versign server.
	//Versign USA Server IP:218.107.21.193
	//Versign AU Server IP: 216.113.188.202
	String hostIp=request.getRemoteAddr();

	String succFlag="0";
	//transation has success and has the result to return
	if(result!=null&&request.getMethod().equalsIgnoreCase("Post")&&request.getParameter("RESPMSG")!=null){
		if(result.equals("0")){//&&(hostIp.equals("218.107.21.193")||hostIp.equals("216.113.188.202"))){//success
			succFlag="1";
		}else{//error ,and add the error detail message.
			succFlag="0";
			sb.append("error:" + resultMap.get(result));
			sb.append(cvvMap.get(cvv));
			sb.append("AVS Street match: "+avsMap.get(avs.substring(0,1))+";");
			sb.append("AVS Zip match: "+avsMap.get(avs.substring(1,2))+"; ");
			sb.append("AVS OR Operation: " + avsMap.get(avs.substring(2,3)) + ";");
			request.setAttribute("errorMessage",sb.toString());
		}
	}
	request.setAttribute("amount",amount);
	request.setAttribute("orderNo",order_no);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>