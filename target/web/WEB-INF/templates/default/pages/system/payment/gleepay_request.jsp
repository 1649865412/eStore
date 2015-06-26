<%@page import="com.cartmatic.estore.common.helper.ConfigUtil"%>
<%@page import="com.cartmatic.estore.common.model.system.Store"%>
<%@page import="com.cartmatic.estore.system.util.TranslateService"%>
<%@page import="com.cartmatic.estore.common.util.DateUtil"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%
	Store store=ConfigUtil.getInstance().getStore();
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	String postUrl = (String)paymentMethod.getConfigData().get("postUrl");
    //5key值[必填]
    String signkey = (String)paymentMethod.getConfigData().get("signkey"); //"12345678"测试用md5key
    //商户ID[必填]
    String MerNo = (String)paymentMethod.getConfigData().get("merNo"); //"1002"测试用商户号
	String gatewayNo = (String)paymentMethod.getConfigData().get("gatewayNo"); //"1002"测试用商户号
    //订单号[必填] (商户自己产生：要求不重复)
    String BillNo =salesOrder.getOrderNo();
    String Currency = "USD";
    String Amount;  //支付金额[必填]
    java.text.DecimalFormat df=new java.text.DecimalFormat("0.00");
    Amount =  df.format(salesOrder.getShouldPay());
    //返回数据给商户的地址 [必填](商户自己填写):::注意请在测试前将该地址告诉我方人员;否则测试通不过
    //String ReturnURL = "http://www.eluxuryoutlets.com/system/payment/gp_response.html";
    String ReturnURL = store.getSiteUrl()+"/system/payment/gp_response.html";
    //String ReturnURL = "http://www.handbagsmaster.net/system/payment/gleepay_response.html";
	String signInfo = TranslateService.sha256Encode(MerNo + gatewayNo+ BillNo + Currency + Amount + ReturnURL + signkey).toUpperCase();
%>
<html>
<head>
<title>Connect To gleepay Payment Gateway</title>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
</head>
<body>
<form id="paymentGatewayForm" name="paymentGatewayForm" target="_blank" action="<%=postUrl%>" method="post" onsubmit="fnTB_Show();return true;">
<c:if test="${empty isError or isError!='true'}">
	<div class="clew-message">
		<div class="clew-top"><fmt:message key="account.news.message"/></div>
		<div class="clew-content">
			<div class="text" style="text-align:center;width:100%;background:#fff;">
					<img alt="information"	src="${resPath}/images/msg_smile.gif" align="middle"/>
					<div class="clear"></div>
					Thank you for your order ${salesOrder.orderNo }. Click SUMBIT and you will be directed to the payment gateway. The amount is <system:CurrencyForRate value="${salesOrder.shouldPay }" />.
			</div>
			<br/>
			<input type="submit" value="submit" class="box-btn">
		</div>
	</div>
</c:if>
	<input type="hidden" name="merNo" value="<%=MerNo%>" /> 
	<input type="hidden" name="gatewayNo" value="<%=gatewayNo%>" /> 
	<input type="hidden" name="orderNo" value="<%=BillNo%>" /> 
	<input type="hidden" name="orderCurrency" value="<%=Currency%>" /> 
	<input type="hidden" name="orderAmount" value="<%=Amount%>" /> 
	<input type="hidden" name="signInfo" value="<%=signInfo%>" /> 
	<input type="hidden" name="returnUrl" value="<%=ReturnURL%>" /> 
	<input type="hidden" name="firstName" value="${salesOrder.orderAddress.firstname}" /> 
	<input type="hidden" name="lastName" value="${salesOrder.orderAddress.lastname}" /> 
	<input type="hidden" name="email" value="${salesOrder.customerEmail}" /> 
	<input type="hidden" name="phone" value="${salesOrder.orderAddress.phoneNumber}" /> 
	<input type="hidden" name="country" value="<system:countryCode countryName="${salesOrder.orderAddress.country}"/>" />
	<input type="hidden" name="state" value="${salesOrder.orderAddress.state}" /> 
	<input type="hidden" name="zip" value="${salesOrder.orderAddress.postalcode}" /> 
	<input type="hidden" name="address" value="${salesOrder.orderAddress.address1}${emptySpace}${salesOrder.orderAddress.address2}" /> 
	<input type="hidden" name="city" value="${salesOrder.orderAddress.city}" />
	<input type="hidden" name="storeCode" value="${salesOrder.store.code}">
</form>
<script type="text/javascript">
	function fnTB_Show(){
		setTimeout(function(){
			$('#payResultBox').fadeIn();$('#payResultBoxBG').show();
		},1000);
	}
</script>
<div id="payResultBoxBG" class="top-layer" style="display: none;"></div>
<div id="payResultBox"  class="replica-pay" style="display: none;">
      <h2>
          Please complete your payment process in the new tab!
      </h2>
      <br /><br />
      <p>
          Don’t close this window before your payment process completed.
      </p>			
      <div>
          <br/>
          Payment Result:
          <input type="button" value="Payment Success" onclick="window.location.href='${ctxPath}/myaccount/order/${salesOrder.id}.html'" class="box-btn"/>
          <input type="button" value="Payment Failed" onclick="window.location.href='${ctxPath}/checkout/goToPay.html?doAction=selectOnlinePayment&orderNo=${salesOrder.orderNo}'" class="box-btn"  />
      </div>
      <div style="text-align: right;">
          <br />
          -->
          <a style="text-decoration: underline;" href="${ctxPath}/checkout/goToPay.html?doAction=selectOnlinePayment&orderNo=${salesOrder.orderNo}">Choose another payment method.</a>
      </div>
</div>
		<%--注意前台下单只有一个运输项,因此只取第一个运输项的数据，注意数字产品调整--%>
<cartmatic:collectionToList var="orderShipmentList" itmes="${salesOrder.orderShipments}"></cartmatic:collectionToList>
<c:if test="${appConfig.store.isTrackOrder and not empty salesOrder}">
		<cartmatic:collectionToList var="orderShipmentList" itmes="${salesOrder.orderShipments}"></cartmatic:collectionToList>
		<c:set var="ga_trackeer" scope="request">
		<%--Order ID,Affiliation,Total,Tax,Shipping,City,State,Country--%>
		_gaq.push(['_addTrans',"${salesOrder.orderNo}", "${salesOrder.customerTitle}${emptySpace}${salesOrder.customerFirstname}",  "${orderShipmentList[0].total}",  "0", "${orderShipmentList[0].shippingCost}", "${orderShipmentList[0].orderAddress.city}", "${orderShipmentList[0].orderAddress.state}", "${orderShipmentList[0].orderAddress.country}"]);
		<c:forEach items="${orderShipmentList[0].orderSkus}" var="os_item" >
		<%-- Order ID,SKU,Product Name,Category,Price,Quantity, --%>
		 _gaq.push(['_addItem', "${salesOrder.orderNo}","${os_item.productSkuCode}","${os_item.productName}","N/A","${empty os_item.discountPrice?os_item.price:os_item.discountPrice}","${os_item.quantity}"]);
		</c:forEach>
		_gaq.push(['_trackTrans']);			
		</c:set>
</c:if>
</body>
</html>
