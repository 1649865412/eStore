<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="/error.jsp"%>
<%@ page import="com.cartmatic.estore.common.model.order.SalesOrder"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.DecimalFormat"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	HashMap paramMap=paymentMethod.getConfigData();
	
	DecimalFormat df=new java.text.DecimalFormat("0.00");

	String MD5key; //MD5key值
	MD5key = (String)paramMap.get("MD5key");

	String MerNo; //商户ID
	MerNo = (String)paramMap.get("MerNo");

	String BillNo; //订单编号
	BillNo = salesOrder.getOrderNo();

	String Currency; //币种
	Currency = "10";

	String Amount; //支付金额
	//[TODO] df.format(salesOrder.getShouldPay());
	Amount = df.format(salesOrder.getShouldPay());

	String Language; //支付语言
	Language = "2";

	String ReturnURL; //返回地址
	ReturnURL = request.getScheme()+"://"+request.getHeader("host")+request.getContextPath()+"/system/payment/ctopay_response.html";

	String md5src= MerNo + BillNo + Currency + Amount + Language + ReturnURL + MD5key;
	
	String MD5info; //MD5加密后的字符串
	MD5info =com.cartmatic.estore.system.util.TranslateService.md5Translate(md5src);

	String Remark; //备注信息
	Remark = "Pay the Order (" + BillNo + ")";
%>
<html>
<head>
<title>Connect To CTOPay Payment Gateway</title>

<script type="text/javascript">
	window.onload=function(){
		document.getElementById("paymentGatewayForm").submit();
	}
</script>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
</head>
<body>
 <%@ include file="./include/payOrderTips.jspf" %>
<form id="paymentGatewayForm" name="paymentGatewayForm" action="https://payment.ttopay.com/payment/Interface"
	method="post">
	<input type="hidden" name="MerNo" value="<%=MerNo%>">
	<input type="hidden" name="Currency" value="<%=Currency%>">
	<input type="hidden" name="BillNo" value="<%=BillNo%>">
	<input type="hidden" name="Amount" value="<%=Amount%>">
	<input type="hidden" name="ReturnURL" value="<%=ReturnURL%>" >
	<input type="hidden" name="Language" value="<%=Language%>">
	<input type="hidden" name="MD5info" value="<%=MD5info.toUpperCase()%>">
	<input type="hidden" name="Remark" value="<%=Remark%>">
</form>
</body>
</html>
