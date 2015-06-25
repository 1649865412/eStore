<%@ page pageEncoding="UTF-8" errorPage="/error.jsp"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.system.util.TranslateService"%>
<%@page import="com.cartmatic.estore.system.service.PaymentMethodManager"%>
<%@page import="com.cartmatic.estore.system.util.PaymentUtil"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@ include file="/common/taglibs.jsp"%>
<%
request.setAttribute(RequestConstants.DECORATOR,"selecter");
WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("95epay");

    //字符编码
    request.setCharacterEncoding("UTF-8");
    String succFlag="0";
    
   	String BillNo = request.getParameter("BillNo");
    String Currency = request.getParameter("Currency");
    String Amount = request.getParameter("Amount");
    String Succeed = request.getParameter("Succeed");//支付状态:该值说明见于word说明文档[商户根据该值来修改数据库中相应订单的状态]
    String Result = request.getParameter("Result"); //支付结果信息：展示给顾客看的信息
	String Remark = request.getParameter("Remark");//商户备注
    String MD5info = request.getParameter("MD5info");
    String MD5key = (String)paymentGateway.getConfigData().get("md5key");//"12345678"测试用
    if (BillNo != null && Currency != null && Amount != null && Succeed != null & MD5key != null)
    {
    	String md5src = BillNo + Currency + Amount + Succeed + MD5key;
    	String md5str = TranslateService.md5TranslateUpperCase(md5src);
		if(md5str.equalsIgnoreCase(MD5info)){
			if(Succeed.equals("88")){
				succFlag="1";
			}else if(Succeed.equals("1")||Succeed.equals("9")||Succeed.equals("19")){
				succFlag="-1";
			}
		}
    }
	//*** RETURN
	String ReturnBillNo = request.getParameter("ReturnBillNo");	//商户网站订单号
    String ReturnCurrency = request.getParameter("ReturnCurrency");//交易币种
    String ReturnAmount = request.getParameter("ReturnAmount");		//以以上币种计价的金额
    String ReturnSucceed = request.getParameter("ReturnSucceed");//返回码: 1 :表示交易成功 ; 0: 表示交易失败
    String ReturnResult = request.getParameter("ReturnResult"); // success: 表示成功 ;   fail:表示失败
    String ReturnMD5info = request.getParameter("ReturnMD5info");
    if (ReturnBillNo != null && ReturnCurrency != null && ReturnAmount != null && ReturnSucceed != null)
    {
        BillNo = ReturnBillNo;
        Amount = ReturnAmount;
        
    	String ReturnMd5src = ReturnBillNo + ReturnCurrency + ReturnAmount + ReturnSucceed + MD5key;
    	String ReturnMd5sign = TranslateService.md5TranslateUpperCase(ReturnMd5src);
		if(ReturnMD5info.equals(ReturnMd5sign)){//签名匹配
			if(ReturnSucceed.equals("1")){//支付已成功
		    	succFlag="1";
			}
			else if(ReturnSucceed.equals("0")){//支付失败
			//请修改订单状态,或者其他操作
			}
		}
    }
	request.setAttribute("orderNo",BillNo);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	request.setAttribute("amount",Amount);
	request.setAttribute("errorMessage",Result);
%>
<%@include file="./include/inc_common_response.jspf"%>

<html>
<head>
<title></title>
<link href="${ctxPath}/styles/global.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div style="text-align: center">
		<div class="clew-message">
			<div class="clew-top"><fmt:message key="account.news.message"/></div>
			<div class="clew-content"  style="margin:0px;padding:0px;">
			<div class="text" style="width:100%;padding-top:20px;">
<c:choose>
		<c:when test="${requestScope['successFlag']=='0'}">
			<table border="0" align="center" width="100%">
					<tr>
						<td valign="top">
							<div align="center"><IMG height="38" alt="failing" src="${resPath}/images/msg_error.gif" width="90"></div>
							<div class="blank10"></div>
						</td>
					</tr>
					<tr>
						<td style="padding-left:20px;color:#D45E34;font-size:12px;">
							<fmt:message key="payment.failing.tips"/>
							<br/>
							<a href="${ctxPath}/checkout/selectOnlinePayment.html?doAction=selectOnlinePayment&orderNo=${orderNo}" target="_top"/> 
							Click here to try again.</a>
						</td>
					</tr>	
				</table>
		</c:when>
		<c:when test="${requestScope['successFlag']=='-1'}">
			<table border="0" align="center" width="100%">
					<tr>
						<td rowspan="3" width="60" valign="top">
							<IMG height="50" alt="pending" src="${resPath}/images/msg_alert.gif" width="50" align="middle">
						<td></td>
					</tr>
					<tr>
						<td>
							<span>
								Your order number is:${orderNo}<br/>
								Amount:<system:CurrencyForRate value="${amount}" />
							</span>
							<div style="font: 0px/0px sans-serif;clear: both;display: block"> </div>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								<font color="green">
									Your Payment is being Processed! We will notify you of the final payment statement in 48 hours by an E-mail . Please check your mail carefully . 
									<a href="${ctxPath}/" target="_top">continue shopping...</a>
									
								</font>
							</span>
							<div style="font: 0px/0px sans-serif;clear: both;display: block"> </div>
						</td>
					</tr>	
				</table>
		</c:when>
		<c:otherwise>
			<table border="0" align="center" width="100%">
						<tr>
							<td rowspan="2" width="60" valign="top"><IMG height="50" alt="finish" src="${resPath}/images/msg_ok.gif" width="50" align="middle"></td>
							<td></td>
						</tr>
						<tr>
							<td>
								<c:set var="mainURL"><c:url value="/index.html"/></c:set>
								<span style="color:green">
									Dear Valued Customer:<br/>
									Thank you for your payment! We will process your order now and ship out within the next 24-36 hours.<br/>
									Following is your order details,you can track its status at any time with order number.<br/>
									Order No.: ${orderNo}<br/>
									Total: ${amount}<br/>
									<a href="${mainURL}" target="_top">continue shopping...</a><br/>
									if you have any questions or need help from one of our customer service reps, please  email us at ${appConfig.companyInfo.email}.<br/>	
									Thanks again for shopping at ${appConfig.store.name}!
								</span>
							</td>
						</tr>	
					</table>
		</c:otherwise>
	</c:choose>
			
			</div>
			</div>
		</div>
	</div>
	<br/>
</body>
</html>