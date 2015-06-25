<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%
String payResult = request.getParameter("payResult"); 
if ("11".equals(payResult))
{%>
<%@include file="include/failingPayment.jspf"%>
<%}
else
{%>
<HTML>
<HEAD>
<TITLE><fmt:message key="payment.finish.title"/></TITLE>
</HEAD>
<BODY>
	<div style="text-align: center">
		<div class="clew-message">
		<div class="clew-top"><fmt:message key="account.news.message"/></div>
			<div class="clew-content">
			<div class="text" style="width:100%;">
					<table border="0" align="center" width="100%">
						<tr>
							<td rowspan="2" width="60" valign="top"><IMG height="50" alt="finish" src="${resPath}/images/msg_ok.gif" width="50" align="middle"></td>
							<td></td>
						</tr>
						<tr>
							<td>
								<span style="color:green">
									Dear Valued Customer:<br/>
									Thank you for your payment! We will process your order now and ship out within the next 24-36 hours.<br/>
									Following is your order details,you can track its status at any time with order number.<br/>
									
									Order No.: ${param.orderId}<br/>
								</span>
							</td>
						</tr>	
					</table>
			</div>
		</div>
		</div>
	</div>
	<c:set var="ga_trackeer" scope="request">pageTracker._trackPageview("${ctxPath}/system/payment/paymentSuccessFinish");</c:set>
</BODY>
</HTML>
<%}%>