<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="/error.jsp"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setAttribute(com.opensymphony.module.sitemesh.RequestConstants.DECORATOR, "selecter");


    String ReturnURL;   //返回数据给商户的地址 [必填](商户自己填写):::注意请在测试前将该地址告诉我方人员;否则测试通不过
    String pageUrl="http://www.handbagsmaster.net/system/payment/95epay_response.html";
    ReturnURL = pageUrl;
    String md5src;  //加密字符串
	//md5src = MerNo + BillNo + Currency + Amount + Language + ReturnURL + MD5key;
   // System.out.println("加密字符串为：");
   // System.out.println(md5src);


    //String MD5info; //MD5加密后的字符串[必填]
    //MD5info =com.probiz.estore.system.util.TranslateService.md5TranslateUpperCase(md5src);

    String Remark;  //备注信息[选填]
    Remark =  "";;

%>

<html>
	<head>
	<title>Connect To 95epay Payment Gateway</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="Pragma" content="no-cache" />
<link href="http://www.eluxuryoutlets.com/styles/global.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			window.onload=function(){
				document.forms["paymentGatewayForm"].submit();
			}
		</script> 		
	</head>
	<body>
		<form id="paymentGatewayForm" name="paymentGatewayForm" action="https://security.ssltrustpay.com/sslpayment" method="post">
	<input type="hidden" name="MerNo" value="${param.MerNo}">
	<input type="hidden" name="Currency" value="${param.Currency}">
	<input type="hidden" name="BillNo" value="${param.BillNo}">
	<input type="hidden" name="Amount" value="${param.Amount}">
	<input type="hidden" name="OrderDate" value="${param.OrderDate}">
	<input type="hidden" name="OrderTime" value="${param.OrderTime}">
	<input type="hidden" name="OrderDesc" value="${param.OrderDesc}">
	<input type="hidden" name="OrderURL" value="">
	<input type="hidden" name="ReturnURL" value="<%=ReturnURL%>">
	<input type="hidden" name="Language" value="${param.Language}">
	<input type="hidden" name="MD5info" value="${param.MD5info}">
	<input type="hidden" name="Remark" value="${param.Remark}">
	<input type="hidden" name="firstName" value="${param.firstName}">
	<input type="hidden" name="lastName" value="${param.lastName}">
	<input type="hidden" name="email" value="${param.email}">
	<input type="hidden" name="phone" value="${param.phone}">
	<input type="hidden" name="zipCode" value="${param.zipCode}">
	<input type="hidden" name="address" value="${param.address}">
	<input type="hidden" name="city" value="${param.city}">
	<input type="hidden" name="state" value="${param.state}">
	<%--收货人信息--%>
	<input name="DeliveryFirstName" type="hidden" class="input" value="${param.DeliveryFirstName}">
	<input name="DeliveryLastName"  type="hidden" class="input" value="${param.DeliveryLastName}">
	<input name="DeliveryEmail"     type="hidden" class="input" value="${param.DeliveryEmail}">
	<input name="DeliveryPhone"     type="hidden" class="input" value="${param.DeliveryPhone}">
	<input name="DeliveryZipCode"   type="hidden" class="input" value="${param.DeliveryZipCode}">
	<input name="DeliveryAddress"   type="hidden" class="input" value="${param.DeliveryAddress}">
	<input name="DeliveryCity"      type="hidden" class="input" value="${param.DeliveryCity}">
	<input name="DeliveryState"     type="hidden" class="input" value="${param.DeliveryState}">
	<input name="DeliveryCountry"   type="hidden" class="input" value="${param.DeliveryCountry}">
	<input name="products"   type="hidden" value="${param.products}">
		
</form>
		</body>
</html>