<%@page import="com.cartmatic.estore.system.util.TranslateService"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="/error.jsp"%>
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	
    String MD5key; //MD5key值[必填]
    MD5key = (String)paymentMethod.getConfigData().get("md5key"); //"12345678"测试用md5key

    String MerNo;   //商户ID[必填]
    MerNo = (String)paymentMethod.getConfigData().get("merNo"); //"1002"测试用商户号

    String BillNo;  //订单号[必填] (商户自己产生：要求不重复)
    BillNo =salesOrder.getOrderNo();

    String Currency;    //币种[必填] 1:代表美金;2:欧元；4：英镑
    Currency = "1";

    String Amount;  //支付金额[必填]
    DecimalFormat df=new DecimalFormat("0.00");
    Amount =  df.format(salesOrder.getShouldPay());

    //String OrderDate;  //订单日期:[选填](当前日期：格式：yyyy/mm/dd)
	//OrderDate=DateUtil.getDate(salesOrder.getCreateTime(),"yyyy/mm/dd");

    //String OrderTime; //订单时间[选填]（格式：hh:mm:ss）	
	//OrderTime=DateUtil.getDate(salesOrder.getCreateTime(),"hh:mm:ss");

    //String OrderDesc; //订单描述[选填]
    //OrderDesc="";

    //String Language;    //支付语言[必填] en:代表英文;cn：中文 
    //Language = "en";
	
	

    String ReturnURL;   //返回数据给商户的地址 [必填](商户自己填写):::注意请在测试前将该地址告诉我方人员;否则测试通不过
    String pageUrl="http://www.handbagscraze.com/system/payment/realyPay_response.html";
    ReturnURL = pageUrl;
    String md5src;  //加密字符串
	md5src = MerNo + BillNo + Amount + MD5key;
   // System.out.println("加密字符串为：");
   // System.out.println(md5src);


    String MD5info; //MD5加密后的字符串[必填]
    MD5info =TranslateService.md5TranslateUpperCase(md5src);

    //String Remark;  //备注信息[选填]
    //Remark =  "";;

%>
<html>
<head>
<title>Connect To 95epay Payment Gateway</title>
<script type="text/javascript">
	window.onload=function(){
		document.getElementById("paymentGatewayForm").submit();
	}
</script>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
</head>
<body>
 <%@ include file="./include/payOrderTips.jspf" %>

<form id="paymentGatewayForm" name="paymentGatewayForm" action="http://www.handbagscraze.com/system/payment/realyPay_request2.html" method="post">

<input  name="BillNo" value="<%=BillNo%>" type="hidden"/>
<input  name="Amount" value="<%=Amount%>" type="hidden"/>
<input  name="MerNo" value="<%=MerNo%>" type="hidden"/>

<%--收货人信息--%>
	<c:forEach var="_orderShipment" items="${salesOrder.orderShipments}" end="1">
	<input id="customername" name="customername" value="${_orderShipment.orderAddress.firstname},${_orderShipment.orderAddress.lastname}" type="hidden"/>
	<input id="address" name="address" value="${_orderShipment.orderAddress.address1}" type="hidden"/>
	<input id="city" name="city" value="${_orderShipment.orderAddress.city}" type="hidden"/>
	<input id="state" name="state" value="${_orderShipment.orderAddress.state}" type="hidden"/>
	<input id="postcode" name="postcode" value="${_orderShipment.orderAddress.postalcode}" type="hidden"/>
	<input id="country" name="country" value="${_orderShipment.orderAddress.country}" type="hidden"/>	
	<input id="email" name="email" value="${salesOrder.customerEmail}" type="hidden"/>
	<input id="tel" name="tel" value="${_orderShipment.orderAddress.phoneNumber}" type="hidden"/>
	<input id="ShippingFee" name="ShippingFee" value="0.00" type="hidden"/>
	</c:forEach>	
<input id="billcustomername" name="billcustomername" value="${salesOrder.orderAddress.firstname},${salesOrder.orderAddress.lastname}" type="hidden"/>
<input id="billaddress" name="billaddress" value="${salesOrder.orderAddress.address1}${emptySpace}${salesOrder.orderAddress.address2}" type="hidden"/>
<input id="billcity" name="billcity" value="${salesOrder.orderAddress.city}" type="hidden"/>
<input id="billstate" name="billstate" value="${salesOrder.orderAddress.state}" type="hidden"/>
<input id="billpostcode" name="billpostcode" value="${salesOrder.orderAddress.postalcode}" type="hidden"/>
<input id="billcountry" name="billcountry" value="${salesOrder.orderAddress.country}" type="hidden"/>
<input id="billphone" name="billphone" value="${salesOrder.orderAddress.phoneNumber}" type="hidden"/>
<input id="currency" name="currency" value="USD" type="hidden"/>
<input id="BackUrl" name="BackUrl" value="<%=pageUrl%>" type="hidden"/>
<input id="returnUrl" name="returnUrl" value="<%=pageUrl%>" type="hidden"/>
<input id="verifyCode" name="verifyCode" value="<%=MD5info%>" type="hidden"/>
		
</form>
</body>
</html>
