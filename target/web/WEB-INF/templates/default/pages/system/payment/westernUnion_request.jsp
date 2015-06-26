<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
	</head>
	<body>
		<div class="union">
			<p>Thank you for your order <strong>${salesOrder.orderNo}</strong> with ${appConfig.store.name}. Your order total is <span><system:CurrencyForRate value="${salesOrder.shouldPay}" /></span>  <strong>USD</strong>, and you can have 10% discount for Western Union payment, so the amount you need to wire is <strong><system:CurrencyForRate value="${salesOrder.shouldPay*0.9}" /> USD</strong>.
			<br>
			<br>
			You can go to any Western Union location in your city to make payment by cash or credit/debit card. For more information, please visit <a href="http://www.westernunion.com/" target="_blank">www.westernunion.com.</a>
		</p>
		<p>
			<content:showContentItem contentCode="Western_Union_Info" var="Western_Union_Info"></content:showContentItem>
			${Western_Union_Info.contentBody}
		</p>
			<p>
				<strong>After your payment sent via Western Union, <a href="/checkout/transferRecord.html?orderNo=${salesOrder.orderNo}" style="color:#06AFDF; text-decoration:underline;">click here &gt;&gt;</a> to complete your order.</strong>
				<br/>
				We are going to process and ship your order within 24 - 36 hours after we get the above information.
			</p>
		</div>
	</body>
</html>