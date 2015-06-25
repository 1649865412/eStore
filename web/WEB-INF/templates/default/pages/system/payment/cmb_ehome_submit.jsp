<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="com.cartmatic.estore.common.model.order.SalesOrder,
	com.cartmatic.estore.common.model.system.Store,
	com.cartmatic.estoresf.cmbehome.action.security.PfxSigner,
	com.cartmatic.estoresf.cmbehome.action.security.CertificateVerifier,
	com.cartmatic.estore.common.helper.ConfigUtil,
	com.cartmatic.estore.common.model.customer.Customer,
	com.cartmatic.estore.webapp.util.RequestContext,
	com.cartmatic.estore.common.model.system.PaymentMethod,
	java.text.DecimalFormat,java.text.SimpleDateFormat,
	com.cartmatic.estoresf.cmbehome.action.Request1001,
	com.cartmatic.estoresf.cmbehome.action.security.*,
	java.nio.charset.*,
	com.cartmatic.estoresf.cmbehome.action.help.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<%
    String submitUrl = request.getParameter("submitUrl");
	Request1001 valueData= new Request1001();
	valueData.setMallId(request.getParameter("MallId"));
	valueData.setSellerName(request.getParameter("SellerName"));
	valueData.setOrderNo(request.getParameter("OrderNo"));
	valueData.setPaymentNo(request.getParameter("PaymentNo"));
	valueData.setItemName(request.getParameter("ItemName"));
	valueData.setAmount(Integer.parseInt(request.getParameter("Amount")));
	valueData.setOrderDate(request.getParameter("OrderDate"));
	valueData.setUSRNBR(request.getParameter("USRNBR"));
	valueData.setToken(request.getParameter("Token"));
	valueData.setUsage(request.getParameter("Usage"));
	valueData.setRemark(request.getParameter("Remark"));
	valueData.setFontURL(request.getParameter("FontURL"));
	
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	
	PfxSigner signer = new PfxSigner(paymentMethod.getConfigData().get("keyStorePath"), 
			paymentMethod.getConfigData().get("keyPassword"));
	
	SignatureFactory.addSigner("signer", signer);
	
	CertificateVerifier verifier = new CertificateVerifier(
			paymentMethod.getConfigData().get("rootCertificatePath"));
	
	SignatureFactory.addVerifier("verifier", verifier);
	
	String jsonResult = GsonUtils.toJson(valueData);
	String data = Base64Utils.encode(jsonResult.getBytes(Charset.forName("UTF-8")));
	String signdata = SignatureFactory.getSigner().signature(jsonResult);
%>

<html>
	<head>
		<script type="text/javascript">
			window.onload=function(){
			     document.forms["paymentGatewayForm"].submit();
			}
		</script>
		<%@ include file="./include/inc_common_request_js.jspf"%>
	</head>

	<body>
		<div style="display: none;">
			<form name="form1" id="paymentGatewayForm" action="<%=submitUrl%>" method="POST">
			    <input type="data" name="data" value="<%=data%>" />
			    <input type="signdata" name="signdata" value="<%=signdata%>" />
				<input type="submit" value="提交" />
			</form>
		</div>
	<%@ include file="./include/payOrderTips.jspf" %>
	</body>
</html>