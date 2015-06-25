<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
	<head>
		<title><fmt:message key="checkout.checkoutFlow" />
		</title>
		<meta http-equiv="Pragma" content="no-cache" />
		<link href="${resPath}/styles/head_foot.css" rel="stylesheet" type="text/css" />
		<link href="${resPath}/styles/nav.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="${resPath }/styles/tabs.css" type="text/css" />
		<link href="${resPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
		<link href="${resPath }/styles/chart.css" rel="stylesheet" type="text/css" />
		<link href="${resPath }/styles/checkout.css" rel="stylesheet" type="text/css" />
		<link href="${resPath }/styles/pay.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript">
/*
			function doGotoPaymentGateway(){
				var paymentMethodId="";
				var pIds=document.getElementsByName("paymentMethodId");
				if(pIds!=null){
					for(var i=0;i<pIds.length;i++){
						if(pIds[i].checked){
							paymentMethodId=pIds[i].value;
							break;
						}
					}
				}
				if(paymentMethodId==""){
					alert("请选择支付方式");
					return false;
				}
				if(paymentMethodId!=""){	
					var protocol=$("#payProtocol_"+paymentMethodId);
					if(protocol.val()=="HTTPS")
					{
						var eStoreUrl="${appConfig.store.siteUrl}";	
						eStoreUrl=eStoreUrl.replace("http","https");
						$("#frmGotoPaymentGateway").attr("action", eStoreUrl + "/checkout/goToPay_ssl.html");						
					}
				}
				$("#goToPay_btn").attr("disabled","disabled");
			}
*/

  $(document).ready(function () {
	  $("#b1 #button_morebank").click(function(){
		  $("#more_bank").toggle();
	  });
	  $("#b2 #button_morecbank").click(function(){
		  $("#more_cbank").toggle();
	  });
  });
			  function doGotoPaymentGateway(){
				  var pm = $("input:radio[name='paymentMethodId']:checked").val();
				  if(pm == '' || pm == undefined){
					  alert("请选择支付银行！");
					  //return false;
				  }else{
					  $("#frmGotoPaymentGateway").submit();
				  }
			  }
		</script>
	</head>
	<body>
		<content tag="heading">> Select Payment Method.</content>
		<div class="content">
			<c:if test="${not empty error}">
				<h2>ERROR</h2> <fmt:message key="${error}"/>
			</c:if>
			<c:if test="${empty error}">
			<form name="frmGotoPaymentGateway" id="frmGotoPaymentGateway" action="${ctxPath}/checkout/goToPay.html" method="post" >
				<input type="hidden" name="orderNo" value="${orderNo}" />
				<input type="hidden" name="doAction" value="gotoPaymentGateway" />
				<div class="checkout-content">
					<c:if test="${not empty paymentMethodList}">
						<%@ include file="include/onlinePaymentMethod.jspf" %>
					</c:if>
				</div>
				<div class="blank10"></div>
				
				<%--<table width="900" border="0" cellspacing="0" cellpadding="0" align="center">
					<tr>
						<td align="center" style="padding-right:20px;color:#666;">
							<div id="payMsg" style="display: none;"></div>
							您将跳转银行支付界面或者第三方支付平台进行支付&nbsp;&nbsp;<input id="paySubmit" type="submit" class="box-btn" value=" 前往支付 "  style="width: 100px;height: 37px;"/>
						</td>
						<td align="right">  
						  <input id="cardTypChoose" type="button" class="box-btn" value="下一步" onclick="chooseCardTyp('','','');" style="display: none;width: 100px;height: 37px;"/>
						</td>
					</tr>
				</table>
				
				--%><div class="blank10"></div>
			</form>
			</c:if>
		</div>
		<c:if test="${salesOrder.shouldPay <= 0}">
		<script type="text/javascript">
			alert("You have paid this order ${salesOrder.orderNo} already.");
			window.location="${ctxPath}/orderTracking.html?orderNo=${salesOrder.orderNo}&email=${salesOrder.customerEmail}&doAction=anonymousOrderQuery";
		</script>
		</c:if>
		
		<%@ include file="./include/cardType.jsp"%>
		
		<script>
			// perform JavaScript after the document is scriptable.
			$(function() {
			    // setup ul.tabs to work as tabs for each div directly under div.panes
			    $("#product_tabs").tabs("div.boards > div.board");	
				
			});
		</script>
		
	</body>
</html>