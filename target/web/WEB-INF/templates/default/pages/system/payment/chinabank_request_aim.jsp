<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinabank.gw.result.CBResult"%>
<%@page import="com.chinabank.moto.MOTOConstant"%>
<%@page import="com.chinabank.moto.MOTOService2"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder"%>
<%@page import="java.text.DecimalFormat"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Checkout</title>
		<style>
		.table-content-front {
			line-height: 20px;
			border-collapse: collapse;
			margin: 0 auto;
		}
		
		.table-content-front td {
			border: 1px solid #ccc;
			padding: 5px;
		}
		</style>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
	</head>
	<body>
		<%
			WebApplicationContext _webAppContext1 = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
			MOTOService2 MOTOService2 = (MOTOService2) _webAppContext1.getBean("moto");

			//读取来自网关的配置数据，该数据可以在后台的相应的网关进行配置
			SalesOrder salesOrder = (SalesOrder) request.getAttribute("salesOrder");
			PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
			DecimalFormat dcf = new DecimalFormat("0.00");

			
			//String x_currency_code=(String)paymentMethod.getConfigData().get("x_currency_code");

			//String MERCHANT = "1000";
			//String TERMINAL = "00000001";
			String MERCHANT = (String) paymentMethod.getConfigData().get(
					"v_mid");
			String TERMINAL = (String) paymentMethod.getConfigData().get(
					"v_terminal");
			String exchangerate = (String) paymentMethod.getConfigData().get(
					"v_exchangerate");
			String VERSION = "3.0(JAVA)";

			String x_amount_show = dcf.format(salesOrder.getShouldPay()
					.doubleValue());
			int x_amount = salesOrder.getShouldPay().multiply(
					new BigDecimal(100)).multiply(new BigDecimal(exchangerate))
					.intValue();
			//x_amount=1;

			Boolean isSuccess = false;

			if (request.getParameter("cmd") != null
					&& "true".equals(request.getParameter("cmd"))) {
				String time = new SimpleDateFormat("MMddhhmmss").format(new Date());
				String orderNoDate = salesOrder.getOrderNo() + "-" + time;
				System.err.println("orderNoDate:" + orderNoDate);
				//String card = "4380888900000000";
				//String cardexp = "0910";

				String card = request.getParameter("x_card_num");
				String cardexp = request.getParameter("x_exp_date");
				cardexp = cardexp.substring(2) + cardexp.substring(0, 2);
				System.err.println("cardexp:" + cardexp);
				int amount = x_amount;

				Map extend = new HashMap();
				extend.put(MOTOConstant.MOTO_KEY_EXTEND_NAME, request
				.getParameter("x_EXTEND_NAME"));
				extend.put(MOTOConstant.MOTO_KEY_EXTEND_IDCARD, "567657");
				if (null != request.getParameter("x_CVV2"))
					extend.put("cvv2", request.getParameter("x_CVV2"));

				//extend.put(MOTOConstant.MOTO_KEY_EXTEND_NAME, "test");
				//extend.put(MOTOConstant.MOTO_KEY_EXTEND_IDCARD, "567657");
				//extend.put("cvv2", "fdf");
				System.err.println(MERCHANT);
				System.err.println(TERMINAL);
				CBResult rs = null;
				try {
					rs = MOTOService2.consume(MERCHANT, TERMINAL, orderNoDate,
					card, cardexp, amount, new Date(), extend, VERSION);
				} catch (Exception e) {
					System.err.println(e);
					e.printStackTrace();
				}
				System.err.println(rs);
				System.err.println("rrrrrrrrrrrrrrrrrrrrrrrrr");
				System.err.println("交易号"
				+ rs.getValue(MOTOConstant.MOTO_KEY_OID));
				if (rs.getRtcode().equals("0")) {
					//实时交易成功，做相应的逻辑操作
					System.err.println("交易号"
					+ rs.getValue(MOTOConstant.MOTO_KEY_OID));
					System.err.println("银行："
					+ rs.getValue(MOTOConstant.MOTO_KEY_BANKNAME));
					System.err.println("卡类型"
					+ rs.getValue(MOTOConstant.MOTO_KEY_CARDNAME));
					System.err.println("授权号"
					+ rs.getValue(MOTOConstant.MOTO_KEY_AUTHID));
					request.setAttribute("successFlag", "1");
				} else if (rs.getRtcode().equals("1")) {
					//交易提交，正在处理中，处理结果稍后查询，做相应逻辑操作
					System.err.println("交易号"
					+ rs.getValue(MOTOConstant.MOTO_KEY_OID));
					System.err.println("银行："
					+ rs.getValue(MOTOConstant.MOTO_KEY_BANKNAME));
					System.err.println("卡类型"
					+ rs.getValue(MOTOConstant.MOTO_KEY_CARDNAME));
					request.setAttribute("successFlag", "-1");
				} else {
					/*
					Map map = rs.getMap();
					for(Iterator it = map.keySet().iterator(); it.hasNext();)
					{
					Object key = it.next();
					
					if(key.toString().equals(MOTOConstant.MOTO_SEARCH_RECCARD) && map.get(key) != null){
					String[][] r = (String[][])map.get(key);
					for(int i=0;i<r.length;i++){
					System.err.println("bank:"+r[i][0]+"--card:"+r[i][1]);
					}
					}else{
					Object value = map.get(key);
					System.err.println("key: " + key + " \tvalue: " + value);
					}
					}
					 */
					System.err.println("错误代码："
					+ rs.getValue(MOTOConstant.MOTO_KEY_ERROR));
					System.err.println("_error"
					+ new String(rs.getValue(
					MOTOConstant.MOTO_KEY_ERROR_CN).toString()
					.getBytes("UTF-8"), "GBK"));

					request.setAttribute("errorCode",
					MOTOConstant.MOTO_KEY_ERROR);
					request.setAttribute("errorMessage", rs
					.getValue(MOTOConstant.MOTO_KEY_ERROR_CN));
					request.setAttribute("successFlag", "0");
				}

				//request.setAttribute("appuserId",appUser.getAppuserId());
				request.setAttribute("orderNo", salesOrder.getOrderNo());
				request.setAttribute("amount", salesOrder.getTotal()
				.doubleValue());
				request.setAttribute("paymentMethodId", paymentMethod.getPaymentMethodId());
				String cardinfo = request.getParameter("x_EXTEND_NAME")+"|"+card+"|"+cardexp+"|";
		    	if(null != request.getParameter("x_CVV2"))
			  		cardinfo+=request.getParameter("x_CVV2");
		    	
		    	request.setAttribute("cardNumber",cardinfo);
		%>
		<%@include file="./include/finishPayResult.jspf"%>
		<%@include file="./include/inc_common_response.jspf"%>
		<%
		}
		%>
		<div class="blank24"></div>
		<div class="blank24"></div>
		<div class="blank24"></div>
		<div class="blank24"></div>
		<div class="blank24"></div>
		<form action="" method="post" id="ChinabankForm" name="ChinabankForm" onsubmit="return validNullForm()">
			<table cellpadding="0" cellspacing="0" align="center"
				class="table-content-front">
				<tr>
					<td align="right">
						<strong>Credit Card Type: </strong>
					</td>
					<td>
						Visa/MasterCard/American Express/Diners Club/JCB
					</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Cardholder`s Name:</strong>
					</td>
					<td>
						<input type="text" name="x_EXTEND_NAME" id="x_EXTEND_NAME"
							maxlength="40" size="20" class="box-input">
					</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Card Number:</strong>
					</td>
					<td>
						<input type="text" name="x_card_num" class="box-input" id="x_card_num"
							maxlength="16" size="20"
							onkeyup="value=value.replace(/[^\d]/g,'') "
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
					</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Expires:</strong>
					</td>
					<td>
						<input type="text" class="box-input" name="x_exp_date" id="x_exp_date" maxlength="4"
							size="6" onKeyUp="value=value.replace(/[^\d]/g,'') "
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
						(mmyy) *
					</td>
				</tr>
				<tr>
					<td align="right">
						<strong>CVV Code:</strong>
					</td>
					<td>
						<input type="text" class="box-input" name="x_CVV2" id="x_CVV2" maxlength="4"
							size="20">
					</td>
				</tr>
				<tr>
					<td align="right">
						<strong>Amount:</strong>
					</td>
					<td><%=x_amount_show%></td>
				</tr>
				<tr>
					<td colspan="2">
						<center>
							<input name="cmd" id="cmd" value="true" type="hidden" />
							<input name="doAction" id="doAction" value="gotoPaymentGateway"
								type="hidden" />
							<input name="orderNo" id="orderNo"
								value="<%=salesOrder.getOrderNo()%>" type="hidden" />
							<input name="paymentMethodId" id="paymentMethodId"
								value="${paymentMethod.paymentMethodId}" type="hidden" />
							<%--<a href="javascript:validNullForm();">
								<img src="${resPath}/images/btn/btn_pay.gif" systran="yes"
									border="0" align="absmiddle"
									alt="<fmt:message key='checkout.checkoutGotoPaymentGateway'/>" />
							</a>
							
							<input type="button" name="submits" id="submits" value="pay"
								onClick="validNullForm();" style="width: 50px; font-size: 14px;">
							 --%>
							<input type="image" name="submits" id="submits" value=""
								src="${resPath}/images/btn/btn_pay.gif">

						</center>
					</td>
				</tr>
			</table>
			<script type="text/javascript">
		  	function validNullForm(){
  			var x_card_num = document.getElementById("x_card_num");
  			var x_exp_date = document.getElementById("x_exp_date");
  			var x_EXTEND_NAME = document.getElementById("x_EXTEND_NAME");
  			
  			if(x_card_num.value==""){
  				alert("Card Number Is Null");
  				x_card_num.select();
  				return false;
  			}
  			if(x_exp_date.value==""){
  				alert("Expiration Date Is Null");
  				x_exp_date.select();
  				return false;
  			}
  			if(x_EXTEND_NAME.value==""){
  				alert("x_EXTEND_NAME Is Null");
  				x_EXTEND_NAME.select();
  				return false;
  			}
  			window.document.ChinabankForm.submit();  			
  		}
  		</script>
		</form>
		<div class="blank24"></div>
		<div class="blank24"></div>
		<div class="blank24"></div>
		<div class="blank24"></div>
		<div class="blank24"></div>		
	</body>
</html>
