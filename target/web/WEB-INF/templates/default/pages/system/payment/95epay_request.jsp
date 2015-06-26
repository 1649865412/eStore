<%@page import="com.cartmatic.estore.common.helper.ConfigUtil"%>
<%@page import="com.cartmatic.estore.common.model.system.Store"%>
<%@page import="com.cartmatic.estore.system.util.TranslateService"%>
<%@page import="com.cartmatic.estore.common.util.DateUtil"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%
	Store store=ConfigUtil.getInstance().getStore();
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
    java.text.DecimalFormat df=new java.text.DecimalFormat("0.00");
    Amount =  df.format(salesOrder.getShouldPay());

    String OrderDate;  //订单日期:[选填](当前日期：格式：yyyy/mm/dd)
	OrderDate=DateUtil.getDate(salesOrder.getCreateTime(),"yyyy/mm/dd");

    String OrderTime; //订单时间[选填]（格式：hh:mm:ss）	
	OrderTime=DateUtil.getDate(salesOrder.getCreateTime(),"hh:mm:ss");

    String OrderDesc; //订单描述[选填]
    OrderDesc="";

    String Language;    //支付语言[必填] en:代表英文;cn：中文 
    Language = "en";
	
	String OrderURL;//订单地址 [选填]
    OrderURL="http://www.yourwebserver.com/Order.jsp";
    OrderURL="";

    String ReturnURL;   //返回数据给商户的地址 [必填](商户自己填写):::注意请在测试前将该地址告诉我方人员;否则测试通不过
    //String pageUrl="http://www.eluxuryoutlets.com/system/payment/95epay_response.html";
    String pageUrl=store.getSiteUrl()+"/system/payment/95epay_response.html";
    ReturnURL = pageUrl;
    String md5src;  //加密字符串
	md5src = MerNo + BillNo + Currency + Amount + Language + ReturnURL + MD5key;
   // System.out.println("加密字符串为：");
   // System.out.println(md5src);


    String MD5info; //MD5加密后的字符串[必填]
    MD5info =TranslateService.md5TranslateUpperCase(md5src);

    String Remark;  //备注信息[选填]
    Remark =  "";;

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
<form id="paymentGatewayForm" name="paymentGatewayForm" action="https://payment.95epay.com/sslpayment" method="post">
	<input type="hidden" name="MerNo" value="<%=MerNo%>">
	<input type="hidden" name="Currency" value="<%=Currency%>">
	<input type="hidden" name="BillNo" value="<%=BillNo%>">
	<input type="hidden" name="Amount" value="<%=Amount%>">
	<input type="hidden" name="OrderDate" value="<%=OrderDate%>">
	<input type="hidden" name="OrderTime" value="<%=OrderTime%>">
	<input type="hidden" name="OrderDesc" value="<%=OrderDesc%>">
	<input type="hidden" name="OrderURL" value="<%=OrderURL%>">
	<input type="hidden" name="ReturnURL" value="<%=ReturnURL%>">
	<input type="hidden" name="Language" value="<%=Language%>">
	<input type="hidden" name="MD5info" value="<%=MD5info%>">
	<input type="hidden" name="Remark" value="<%=Remark%>">
	<input type="hidden" name="firstName" value="${salesOrder.orderAddress.firstname}">
	<input type="hidden" name="lastName" value="${salesOrder.orderAddress.lastname}">
	<input type="hidden" name="email" value="${salesOrder.customerEmail}">
	<input type="hidden" name="phone" value="${salesOrder.orderAddress.phoneNumber}">
	<input type="hidden" name="zipCode" value="${salesOrder.orderAddress.postalcode}">
	<input type="hidden" name="address" value="${salesOrder.orderAddress.address1}${emptySpace}${salesOrder.orderAddress.address2}">
	<input type="hidden" name="city" value="${salesOrder.orderAddress.city}">
	<input type="hidden" name="state" value="${salesOrder.orderAddress.state}">
	<%--收货人信息--%>
	<c:forEach var="_orderShipment" items="${salesOrder.orderShipments}" end="1">
	<input name="DeliveryFirstName" type="hidden" class="input" value="${_orderShipment.orderAddress.firstname}">
	<input name="DeliveryLastName"  type="hidden" class="input" value="${_orderShipment.orderAddress.lastname}">
	<input name="DeliveryEmail"     type="hidden" class="input" value="${salesOrder.customerEmail}">
	<input name="DeliveryPhone"     type="hidden" class="input" value="${_orderShipment.orderAddress.phoneNumber}">
	<input name="DeliveryZipCode"   type="hidden" class="input" value="${_orderShipment.orderAddress.postalcode}">
	<input name="DeliveryAddress"   type="hidden" class="input" value="${_orderShipment.orderAddress.address1}">
	<input name="DeliveryCity"      type="hidden" class="input" value="${_orderShipment.orderAddress.city}">
	<input name="DeliveryState"     type="hidden" class="input" value="${_orderShipment.orderAddress.state}">
	<input name="DeliveryCountry"   type="hidden" class="input" value="${_orderShipment.orderAddress.country}">
	<input name="products"   type="hidden" value="<c:forEach var="_orderSku" items="${_orderShipment.orderSkus}">Sami Quilted Shoulder Bag ${_orderSku.productSkuCode},</c:forEach>">
	</c:forEach>
	
</form>
</body>
</html>
