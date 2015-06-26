<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.text.*,
				com.cartmatic.estore.common.model.order.SalesOrder"
				errorPage="/error.jsp"
 %>
<jsp:directive.page import="com.eitop.platform.tools.encrypt.xStrEncrypt"/>
<jsp:directive.page import="com.eitop.platform.tools.encrypt.MD5Digest"/>
<jsp:directive.page import="com.cartmatic.estore.system.util.PaymentUtil"/>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <%@ include file="./include/inc_common_request_js.jspf" %>
  </head>
  <%
  	request.setCharacterEncoding("UTF-8");
  	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	HashMap paramMap=paymentMethod.getConfigData();
	
	DecimalFormat df=new java.text.DecimalFormat("0.00");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	String M_ID=paymentMethod.getConfigData().get("Mer_Code").toString();
	String M_OrderID=salesOrder.getOrderNo();
	String MODate=sdf.format(salesOrder.getCreateTime());
	
	String MOAmount="0.00";
	
	//if in a test model then set the amount to 0.01;
	if("Y".equals(paramMap.get("testModel").toString())){
		MOAmount="0.01";
	}else{
		MOAmount=df.format(salesOrder.getShouldPay().doubleValue());
	}

	String M_URL=request.getScheme()+"://"+request.getHeader("host")+request.getContextPath()+"/system/payment/nps_out_response.html";
	
	String M_Language=(paramMap.get("M_Language")==null)? "1":paramMap.get("M_Language").toString();
	String MOCurrency=(paramMap.get("MOCurrency")==null)? "RBM":paramMap.get("MOCurrency").toString();
	
	String S_Name=getString(salesOrder.getCustomerFirstName())+getString(salesOrder.getCustomerLastname());
	String S_Address=getString(salesOrder.getCustomerAddress());
	String S_PostCode=getString(salesOrder.getCustomerZip());
	String S_Telephone=getString(salesOrder.getCustomerTelephone());
	String S_Email=getString(salesOrder.getCustomerEmail());
	
	String R_Name=getString(salesOrder.getShippingFirstname())+getString(salesOrder.getShippingLastname());
	String R_Address=getString(salesOrder.getShippingAddress());
	String R_PostCode=getString(salesOrder.getShippingZip());
	String R_Telephone=getString(salesOrder.getShippingTelephone());
	String R_Email=S_Email;
	
	String MOComment=getString(salesOrder.getNotes());

	String m_status="0";
	String m_info=M_ID + "|" + M_OrderID + "|" + MOAmount + "|" + MOCurrency + "|" + M_URL + "|" + M_Language;
	String s_info=S_Name + "|" + S_Address + "|"+ S_PostCode + "|" + S_Telephone + "|" + S_Email;
	String r_info=R_Name + "|" + R_Address + "|" + R_PostCode + "|" + R_Telephone + "|" + R_Email + "|"+ MOComment + "|" + m_status + "|" + MODate;
	
	String key=paramMap.get("Mer_Key").toString();//"mykey123456";
	String orderInfo=m_info + "|" + s_info + "|" + r_info;

	String orderMessage=xStrEncrypt.StrEncrypt(orderInfo, key);
	String digest=MD5Digest.encrypt(orderMessage+key);
  %>
  <body onload="document.paymentGatewayForm.submit();">
	 <form name="paymentGatewayForm" method="post" action="https://payment.nps.cn/ReceiveI18NMerchantOutcardAction.do">
		<input type="hidden" name="OrderMessage" value="<%=orderMessage%>">
		<input type="hidden" name="digest" value="<%=digest%>">
		<input type="hidden" name="M_ID" value="<%=M_ID%>">
	</form>
  <%@ include file="./include/payOrderTips.jspf" %></body>
</html>
<%!
	public String getString(String source){
		return "".equals(source)?null:source;
	}
%>