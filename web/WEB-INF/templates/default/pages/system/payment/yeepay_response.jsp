<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page
	import="java.util.Properties,java.text.DecimalFormat,
	com.cartmatic.estore.system.util.TranslateService,
	org.springframework.web.context.WebApplicationContext,
	org.springframework.web.context.support.WebApplicationContextUtils,
	com.cartmatic.estore.common.model.order.SalesOrder,
	com.cartmatic.estore.sales.service.SalesOrderManager,
	java.rmi.RemoteException,java.net.*,java.io.*"
	errorPage="/error.jsp"
	%>
<%
/**
	==============sample data from payment gateway===============
	<input type="hidden" Name="r2_TrxId" Value="7143289262542055"/>
	<input type="hidden" Name="r6_Order" Value="O070310006"/>
	<input type="hidden" Name="r5_Pid" Value="id"/>
	<input type="hidden" Name="r4_Cur" Value="RMB"/>
	<input type="hidden" Name="hmac" Value="630be72b018111d8e74a0f144f7457dd"/>
	<input type="hidden" Name="r9_BType" Value="1"/>
	<input type="hidden" Name="p1_MerId" Value="1001001"/>
	<input type="hidden" Name="r7_Uid" Value=""/>
	<input type="hidden" Name="r8_MP" Value=""/>
	<input type="hidden" Name="r0_Cmd" Value="Buy"/>
	<input type="hidden" Name="r3_Amt" Value="0.01"/>
	<input type="hidden" Name="r1_Code" Value="1"/>
**/
	//com.cartmatic.estore.system.util.PaymentUtil.writeReceiveDataToFile(request,"d:\\common.txt");
	
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("yeepay");

	String merchantId;
	String keyValue;
	String sCmd;
	String sErrorCode;
	String sTrxId;
	String amount;
	String cur;
	String productId;
	String orderId;
	String userId;
	String MP;
	String bType;
	String svrHmac;
	StringBuffer sbOld = new StringBuffer();
	String sNewString;
	
	if("Y".equals(paymentMethod.getConfigData().get("testModel").toString())){
		merchantId = "1001001";
		keyValue = "Key";
	}else{
		merchantId=paymentMethod.getConfigData().get("merchantId").toString();
		keyValue=paymentMethod.getConfigData().get("key").toString();
	}

	sCmd = request.getParameter("r0_Cmd");
	sErrorCode = request.getParameter("r1_Code");
	sTrxId = request.getParameter("r2_TrxId");
	amount = request.getParameter("r3_Amt");
	cur = request.getParameter("r4_Cur");
	productId = request.getParameter("r5_Pid");
	orderId = request.getParameter("r6_Order");
	userId = request.getParameter("r7_Uid");
	MP = request.getParameter("r8_MP");
	bType = request.getParameter("r9_BType");
	svrHmac = request.getParameter("hmac");

	sbOld.append(merchantId);
	sbOld.append(sCmd);
	sbOld.append(sErrorCode);
	sbOld.append(sTrxId);
	sbOld.append(amount);
	sbOld.append(cur);
	sbOld.append(productId);
	sbOld.append(orderId);
	sbOld.append(userId);
	sbOld.append(MP);
	sbOld.append(bType);

	sNewString = TranslateService.hmacMd5Transalte(sbOld.toString(),keyValue);
	
	String succFlag="0";
	String errorMessage="";
	if (sNewString.equals(svrHmac)) {
		if (sErrorCode.equals("1")) {
			SalesOrderManager salesOrderManager=(SalesOrderManager)webAppContext.getBean("salesOrderManager");
			SalesOrder salesOrder=salesOrderManager.getByOrderNo(orderId);
			DecimalFormat df=new DecimalFormat("0.00");
			String localAmount=df.format(salesOrder.getShouldPay());
			if("Y".equals(paymentMethod.getConfigData().get("testModel").toString())){
				localAmount="0.01";
			}
			if(localAmount.equals(amount)){
				//return success;
				succFlag="1";
				if (bType.equals("1")) {//page return
					errorMessage="page return success";
				} else if (bType.equals("2")) {//server return
					errorMessage="server return success";
				} else if (bType.equals("3")) {//telephone payment return.
					errorMessage="telephone payment return success";
				}
			}
		} else if (sErrorCode.equals("0")) {
			errorMessage="transation fail!";
		} else {
			errorMessage="transaction is unkown.";
		}
	} else {
		errorMessage="transation message is modified by others";
	}
		
	request.setAttribute("flowNo",sTrxId);
	request.setAttribute("errorMessage",errorMessage);
	request.setAttribute("orderNo",orderId);
	request.setAttribute("amount",amount);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>
