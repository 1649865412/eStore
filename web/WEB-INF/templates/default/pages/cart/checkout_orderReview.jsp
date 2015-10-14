<!DOCTYPE html>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>

		<!-- Bootstrap -->
		<%@ include file="../../decorators/include/styles7.jspf"%>
        <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
        <link href="${resPath}/styles/css/submit-order.css" rel="stylesheet">
        <link href="${resPath }/styles/pay.css" rel="stylesheet" type="text/css" />
        <style>
		.w-nav{
			border-bottom: 1px #000000 solid;
		}
		</style>

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    	<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>

	<body>
	 <script>
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
        <!--[if lt IE 8]>
       <p class="browserupgrade">你正在使用一个 <strong>过时的</strong> 浏览器. 请 <a href="http://browsehappy.com/">提高您的浏览器</a> 以提高您的经验.</p>
       <![endif]-->
		<!--登陆注册-->
		<%@ include file="../../decorators/include/headerNew.jspf"%>
        <!--end of 导航-->
        <form name="frmGotoPaymentGateway" id="frmGotoPaymentGateway" action="${ctxPath}/checkout/goToPay.html" method="post" >
		<c:choose>
			<c:when test="${salesOrder.isCod == 0}">
				<div class="w-submit-order">
		        	<div class="w-submit-order-hd">
		            	<div class="order-hd-tit">订单已生成</div>
		                <div class="order-hd-number">
		                	<p>订单号：<b>${salesOrder.orderNo}</b></p>
		                    <p><span>应付款：<system:CurrencyForRate value="${salesOrder.shouldPay}" /></span></p>
		                </div>
		                <div class="order-hd-ps">
		                	<p><span>请您尽快完成支付，以便我们尽快安排发货。</span></p>
		                    <p>请您在提交订单后的72小时内完成支付，否则订单将会自动取消。</p>
		                </div>
		            </div>
		            <div class="w-submit-order-bd">
		            	<div class="tabs-banks">
		                	<ul id="tabs" class="row">
		                    	<li><a href="#" name="#tab1">网银支付 | </a></li>
		                        <li><a href="#" name="#tab2">信用卡支付 | </a></li>
		                        <li><a href="#" name="#tab3">第三方平台支付</a></li>
		                    </ul>
		                    <div id="banks-contents">
		                    	<div id="tab1">
		                        	<div class="banks-list">
		                                <ul class="row">
		                                	<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'boc'}">
				                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }" >
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-boc" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                           	</label></li>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'abc'}">
				                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-abc" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                             	<%--
					                             	<div class="add_more_tab">0元抢Selvä面膜</div>
					                           	--%></label></li>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
				                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-cmb" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                             	<%--<div class="add_more_tab">折上再9折特价品除外</div>	--%>
					                             </label></li>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbc'}">
				                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
					                             	<span id="bank-cmbc" class="bank-logo"></span>	
					                             	<div class="add_more"></div>	                              
					                        </label></li>
					                             	 	
			                      			</c:if>
			                      		</c:forEach>
			                      		
			                          <li><input type="radio" name="paymentMethodId" id="inlineRadio2" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ccb" class="bank-logo"></span>
			                           </label></li>
		                                
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio6" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cib" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio7" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-icbc" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio8" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bcom" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio9" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hxb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio10" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio11" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-spdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio12" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-sdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio13" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-citic" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio14" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-post" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio15" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ceb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio16" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bob" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio17" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-pab" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio18" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cbhb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio19" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hzb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio20" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-srcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio21" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-shb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio22" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-wzcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio23" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-jsb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio24" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-nbcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio25" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gzns" class="bank-logo"></span>
			                           </label></li>
		                                </ul>
		                                <div class="more-banks"><a href="javascript:;" class="more-banks-btn">
		                                <i class="fa fa-plus"></i>更多银行</a><a href="javascript:;" class="go-pay" onclick="doGotoPaymentGateway();">立即支付</a></div>
		                            </div>
		                        </div>
		                        <div id="tab2">
		                        	<div class="banks-list">
		                                <ul class="row">
		                                	<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'boc'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
						                             	<span id="bank-boc" class="bank-logo"></span>
						                             	<div class="add_more"></div>
						                           	</label></li>
				                      			</c:if>
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'abc'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
						                             	<span id="bank-abc" class="bank-logo"></span>
						                             	<div class="add_more"></div>
						                           	</label></li>
				                      			</c:if>
				                      			
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
						                             	<span id="bank-cmb" class="bank-logo"></span>
						                             	<div class="add_more"></div>
						                           	</label></li>
				                      			</c:if>
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbc'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
						                             	<span id="bank-cmbc" class="bank-logo"></span>
						                             	<div class="add_more"></div>
						                           	</label></li>
				                      			</c:if>
				                      		</c:forEach>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio2" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ccb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio6" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cib" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio7" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-icbc" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio8" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bcom" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio9" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hxb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio10" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio11" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-spdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio12" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-sdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio13" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-citic" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio14" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-post" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio15" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ceb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio16" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bob" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio17" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-pab" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio18" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cbhb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio19" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hzb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio20" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-srcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio21" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-shb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio22" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-wzcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio23" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-jsb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio24" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-nbcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio25" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gzns" class="bank-logo"></span>
			                           </label></li>
		                                </ul>
		                                <div class="more-banks"><a href="javascript:;" class="more-banks-btn"><i class="fa fa-plus"></i>更多银行</a><a href="javascript:;" class="go-pay" onclick="doGotoPaymentGateway();">立即支付</a></div>
		                            </div>
		                        </div>
		                        <div id="tab3">
		                        	<div class="others-pay">
		                                <ul class="row">
		                                	<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'unionpay'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
						                             	<span id="pay-unionpay" class="pay-logo"></span>
						                           	</label></li>
				                      			</c:if>
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'alipay'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
						                             	<span id="pay-alipay" class="pay-logo"></span>
						                           	</label></li>
				                      			</c:if>
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }_c" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }_c">
						                             	<span id="pay-yiwangtong" class="pay-logo"></span>
						                           	</label></li>
				                      			</c:if>
				                      			
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbehome'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode}" value="${paymentMethod.id }"
					                      			title="需从招商银行企业e家那边登录跳转过来的用户才可正常支付">
						                           	<label title="需从招商银行企业e家那边登录跳转过来的用户才可正常支付"  class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode}">
						                             	<span id="pay-rengxingpay" class="pay-logo"></span>
						                           	</label></li>
				                      			</c:if>
				                      			
				                      		</c:forEach>
		                                </ul>
		                            </div>
		                            <div class="more-banks"><a href="javascript:;" class="go-pay" onclick="doGotoPaymentGateway();">立即支付</a></div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
			</c:when>
			
			<c:when test="${salesOrder.isCod == 1}">
					<div class="w-submit-order">
			        	<div class="w-submit-order-hd">
			            	<div class="order-hd-tit">订单已生成</div>
			                <div class="order-hd-number">
			                	<p>订单号：<b>${salesOrder.orderNo }</b></p>
			                    <p><span>应付款：<system:CurrencyForRate value="${salesOrder.shouldPay}" /></span></p>
			                </div>
			                <div class="order-hd-ps">
			                	<p><span>我们将尽快安排发货，请在收货时把应付金额交给快递人员代收。</span></p>
			                </div>
			            </div>
			        </div>
					
			</c:when>
			<c:otherwise>
				<div class="w-submit-order">
		        	<div class="w-submit-order-hd">
		            	<div class="order-hd-tit">订单已生成</div>
		                <div class="order-hd-number">
		                	<p>订单号：<b>${salesOrder.orderNo }</b></p>
		                    <p><span>应付款：￥${salesOrder.shouldPay}</span></p>
		                </div>
		                <ul>
		                	<li><span></span>请您尽快完成支付，以便我们尽快安排发货。</li>
		                    <li><span></span>请您在提交订单后的72小时内完成支付，否则订单将会自动取消。</li>
		                    <li><span></span>请在成功付款后，截取【成功支付页面】至我们的客服邮箱cs@sifangstreet.com</li>
		                    <li><span></span>我们客服人员将会第一时间为您核查到账情况，并安排发货，并会以邮件形式回复您结果，谢谢配合。</li>
		                    <li><span></span>在客服核查期间，系统依然会显示“待支付”，属于正常现象，请耐心等候邮件通知。</li>
		                </ul>
		            </div>
		            <div class="w-submit-order-bd">
		                <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                    <tr>
		                        <td>转账银行</td>
		                        <td>户名</td>
		                        <td>账号</td>
		                        <td>开户行</td>
		                    </tr>
		                    <tr>
			               <td class="bank_table"><span id="bank-boc" class="bank-logo"></span></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">678261846178</td>
			               <td class="align_left">中国银行股份有限公司广州东风东路支行</td>
			             </tr>
			              <tr>
			               <td class="bank_table"><span id="bank-ccb" class="bank-logo"></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">44001400115053006279</td>
			               <td class="align_left">中国建设银行广州东宝大厦支行</td>
			             </tr>
			              <tr>
			               <td class="bank_table"><span id="bank-cmb" class="bank-logo"></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">120908323010505</td>
			               <td class="align_left">招商银行股份有限公司广州锦城大厦支行</td>
			             </tr>
			              <tr>
			               <td class="bank_table"><span id="bank-abc" class="bank-logo"></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">44306001040009002</td>
			               <td class="align_left">中国农业银行东莞洪梅支行</td>
			             </tr>
			              <tr>
			               <td class="bank_table"><span id="bank-cmbc" class="bank-logo"></span></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">691131279</td>
			               <td class="align_left">中国民生银行广州分行</td>
			             </tr>
		                </table>
		            </div>
		        </div>
			</c:otherwise>
		</c:choose>
		<input type="hidden" name="orderNo" value="${salesOrder.orderNo}" />
		<input type="hidden" name="doAction" value="gotoPaymentGateway" />
	</form>
		<%@ include file="../../decorators/include/footerNew.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script>
	function index_login(){
		  var url =""+self.location.href;
		   $("#papeurl").val(url);
		    //alert( $("#papeurl").val());
		    $("#loginForm").submit();
		}
		
	var swiper = new Swiper('.swiper-container', {
		nextButton : '.swiper-page-next',
		prevButton : '.swiper-page-prev',
		paginationClickable : true,
		spaceBetween : 0,
		mousewheelControl : false,
		//							autoplay: 5000,
		speed : 500,
		onInit : function(swiper) {
			swiperAnimateCache(swiper);
			swiperAnimate(swiper);
		},
		onSlideChangeEnd : function(swiper) {
			swiperAnimate(swiper);
		},
		onTransitionEnd : function(swiper) {
			swiperAnimate(swiper);
		}
	});

	function refreshImage(type, obj) {
		//var image=document.getElementById("imgValidationCode");
		var image = $(obj).children()[0];
		var url = "${ctxPath}/jCaptcha.html?type=" + type;
		var xmlHttpReq = null;
		if (window.ActiveXObject) {
			xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xmlHttpReq = new XMLHttpRequest();
		}
		xmlHttpReq.open("Post", url, true);
		xmlHttpReq.send(null);

		image.src = "${ctxPath}/jCaptcha.html?rand="
				+ parseInt(1000 * Math.random());
		return false;
	}
</script>
<!-----在线支付银行tabs-------->
        <script type="text/javascript">
			function resetTabs(){
				$("#banks-contents > div").hide();
				$("#tabs a").attr("id","");
			}
			
			var myUrl = window.location.href;
			var myUrlTab = myUrl.substring(myUrl.indexOf("#")); 
			var myUrlTabName = myUrlTab.substring(0,4);
			
			(function(){
				$("#banks-contents > div").hide();
				$("#tabs li:first a").attr("id","current");
				$("#banks-contents > div:first").fadeIn();
			
				$("#tabs a").on("click",function(e) {
					e.preventDefault();
					if ($(this).attr("id") == "current"){
						return       
					}else{             
						resetTabs();
						$(this).attr("id","current");
						$($(this).attr('name')).fadeIn(); 
					}
				});
			
				for (i = 1; i <= $("#tabs li").length; i++) {
					if(myUrlTab == myUrlTabName + i){
						resetTabs();
						$("a[name='"+myUrlTab+"']").attr("id","current");
						$(myUrlTab).fadeIn();
					}
				}
			})()
		</script>
        
        <!------展开更多银行------>
        <script type="text/javascript">
        	$(function(){
					$(".more-banks a.more-banks-btn").click(function(){
							if($(this).parent().parent().hasClass("active")){
									$(this).parent().parent().removeClass("active").find("ul").css("height","47px")
								}else{
									$(this).parent().parent().addClass("active").find("ul").css("height","auto")
									}
						})
				})
        </script>
        
		<script>
			 //				alert(document.documentElement.clientWidth+'+'+document.documentElement.clientHeight)
			var swiper = new Swiper('.swiper-container', {
				nextButton: '.swiper-page-next',
				prevButton: '.swiper-page-prev',
				paginationClickable: true,
				spaceBetween: 0,
				mousewheelControl: false,
				//							autoplay: 5000,
				speed: 500,
				onInit: function(swiper) {
					swiperAnimateCache(swiper);
					swiperAnimate(swiper);
				},
				onSlideChangeEnd: function(swiper) {
					swiperAnimate(swiper);
				},
				onTransitionEnd: function(swiper) {
					swiperAnimate(swiper);
				}
			});
		</script>
        <script type="text/javascript">
        	$(function(){
					$(window).scroll(function(){
						$(".index-nav").addClass("w-nav-s")
					})
				})
        </script>
	</body>

</html>