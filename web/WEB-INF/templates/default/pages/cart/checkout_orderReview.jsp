<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<html>
	<head>
		<title><fmt:message key="checkout.checkoutFlow" /> | <fmt:message
				key="checkout.stepOrderReview" /></title>
		<meta http-equiv="Pragma" content="no-cache" />
		<link href="${resPath}/styles/head_foot.css" rel="stylesheet" type="text/css" />
		<link href="${resPath}/styles/nav.css" rel="stylesheet" type="text/css" />
		<link href="${resPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
		<link href="${resPath }/styles/chart.css" rel="stylesheet" type="text/css" />
		<link href="${resPath }/styles/checkout.css" rel="stylesheet" type="text/css" />
		<link href="${resPath }/styles/pay.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="${resPath }/styles/tabs.css" type="text/css" media="screen" />
	</head>
	<body>
	
 <script>
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
	
	<form name="frmGotoPaymentGateway" id="frmGotoPaymentGateway" action="${ctxPath}/checkout/goToPay.html" method="post" >
		<c:choose>
			<c:when test="${salesOrder.isCod == 0}">
				<div class="maincontent" id="designer_main">
			     <div class="chart_bottom">
			       
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
			               <ul class="tabs" id="product_tabs">
			                <li><a href="#">网银支付&nbsp;|</a></li>
			                <li><a href="#">信用卡支付&nbsp;|</a></li>
			              <!--   <li><a href="#">信用积分支付&nbsp;|</a></li> -->
			                <li><a href="#">第三方平台支付</a></li>
			              </ul> 
			              <!-- tab "panes" -->
			              <div class="boards current_info_col">
			                <!-- b1 -->
			                <div class="board" id="b1">
			                  <div class="control-group">
			                    <div class="controls">
			                      <div id="current_bank">
			                      		<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'boc'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }" >
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-boc" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                           	</label>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'abc'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-abc" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                             	<%--
					                             	<div class="add_more_tab">0元抢Selvä面膜</div>
					                           	--%></label>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-cmb" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                             	<%--<div class="add_more_tab">折上再9折特价品除外</div>	--%>
					                             </label>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbc'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
					                             	<span id="bank-cmbc" class="bank-logo"></span>	
					                             	<div class="add_more"></div>	                              
					                        </label>
					                             	 	
			                      			</c:if>
			                      		</c:forEach>
			                      		
			                          <input type="radio" name="paymentMethodId" id="inlineRadio2" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ccb" class="bank-logo"></span>
			                             <div class="add_more"></div>
			                           </label>
			                          <%--<input type="radio" name="paymentMethodId" id="inlineRadio5" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cmbc" class="bank-logo"></span>
			                           </label>--%>
			                            
			                      </div><!--current_bank-->
			                      <div class="checkout_list margin_bottom20" id="more_bank">
			                        <div class="width_all margin_top20">
			                          <input type="radio" name="paymentMethodId" id="inlineRadio6" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cib" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio7" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-icbc" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio8" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bcom" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio9" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hxb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio10" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gdb" class="bank-logo"></span>
			                           </label>
			                        </div><!--width_all-->
			                        <div class="width_all margin_top20">
			                          <input type="radio" name="paymentMethodId" id="inlineRadio11" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-spdb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio12" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-sdb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio13" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-citic" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio14" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-post" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio15" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ceb" class="bank-logo"></span>
			                           </label>
			                        </div><!--width_all-->
			                        <div class="width_all margin_top20">
			                          <input type="radio" name="paymentMethodId" id="inlineRadio16" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bob" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio17" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-pab" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio18" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cbhb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio19" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hzb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio20" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-srcb" class="bank-logo"></span>
			                           </label>
			                        </div><!--width_all-->
			                        <div class="width_all margin_top20">
			                          <input type="radio" name="paymentMethodId" id="inlineRadio21" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-shb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio22" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-wzcb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio23" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-jsb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio24" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-nbcb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio25" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gzns" class="bank-logo"></span>
			                           </label>
			                        </div><!--width_all-->
			                      </div><!--more_bank-->
			                    </div><!--controls-->
			                  </div><!--control-group-->
			                  <div class="control-group margin_top20">
			                    <div class="controls">
			                      <button id="button_morebank" name="button_morebank" class="btn btn-gold" type="button">
			                        <i class="fa fa-plus padding_right10"></i>
			                        更多银行
			                      </button>
			                      <button class="btn btn-gold" type="button" onclick="doGotoPaymentGateway();">
			                        前往支付
			                      </button>
			                    </div><!--controls-->
			                  </div><!--control-group-->
			                </div><!--b1-->
			                <!-- b2 -->
			                <div class="board" id="b2">
			                 <div class="control-group">
			                    <div class="controls">
			                      <div id="current_cbank">
			                      		<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'boc'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
					                             	<span id="bank-boc" class="bank-logo"></span>
					                             
					                           	</label>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'abc'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
					                             	<span id="bank-abc" class="bank-logo"></span>
					                           	</label>
			                      			</c:if>
			                      			
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
					                             	<span id="bank-cmb" class="bank-logo"></span>
					                           	</label>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbc'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
					                             	<span id="bank-cmbc" class="bank-logo"></span>
					                           	</label>
			                      			</c:if>
			                      		</c:forEach>
			                      		
			                          <input type="radio" name="paymentMethodId" id="inlineRadio2" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ccb" class="bank-logo"></span>
			                           </label>
			                          <%--<input type="radio" name="paymentMethodId" id="inlineRadio5" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cmbc" class="bank-logo"></span>
			                           </label>--%>
			                            
			                      </div><!--current_cbank-->
			                      <div class="checkout_list margin_bottom20" id="more_cbank">
			                        <div class="width_all margin_top20">
			                          <input type="radio" name="paymentMethodId" id="inlineRadio6" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cib" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio7" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-icbc" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio8" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bcom" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio9" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hxb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio10" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gdb" class="bank-logo"></span>
			                           </label>
			                        </div><!--width_all-->
			                        <div class="width_all margin_top20">
			                          <input type="radio" name="paymentMethodId" id="inlineRadio11" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-spdb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio12" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-sdb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio13" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-citic" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio14" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-post" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio15" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ceb" class="bank-logo"></span>
			                           </label>
			                        </div><!--width_all-->
			                        <div class="width_all margin_top20">
			                          <input type="radio" name="paymentMethodId" id="inlineRadio16" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bob" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio17" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-pab" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio18" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cbhb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio19" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hzb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio20" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-srcb" class="bank-logo"></span>
			                           </label>
			                        </div><!--width_all-->
			                        <div class="width_all margin_top20">
			                          <input type="radio" name="paymentMethodId" id="inlineRadio21" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-shb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio22" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-wzcb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio23" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-jsb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio24" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-nbcb" class="bank-logo"></span>
			                           </label>
			                          <input type="radio" name="paymentMethodId" id="inlineRadio25" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gzns" class="bank-logo"></span>
			                           </label>
			                        </div><!--width_all-->
			                      </div><!--more_bank-->
			                    </div><!--controls-->
			                  </div><!--control-group-->
			                  <div class="control-group margin_top20">
			                    <div class="controls">
			                      <button id="button_morecbank" name="button_morecbank" class="btn btn-gold" type="button">
			                        <i class="fa fa-plus padding_right10"></i>
			                        更多银行
			                      </button>
			                      <button class="btn btn-gold" type="button" onclick="doGotoPaymentGateway();">
			                        前往支付
			                      </button>
			                    </div><!--controls-->
			                  </div><!--control-group-->
			                </div><!--b2-->
			                
			                  <div class="board" id="b3">
			                  <div class="control-group">
			                      <div class="controls">
			                        <div id="3party_pay">
			                         	<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'unionpay'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="pay-unionpay" class="pay-logo"></span>
					                           	</label>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'alipay'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="pay-alipay" class="pay-logo"></span>
					                           	</label>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }_c" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }_c">
					                             	<span id="pay-yiwangtong" class="pay-logo"></span>
					                           	</label>
			                      			</c:if>
			                      			
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbehome'}">
				                      			<input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode}" value="${paymentMethod.id }"
				                      			title="需从招商银行企业e家那边登录跳转过来的用户才可正常支付">
					                           	<label title="需从招商银行企业e家那边登录跳转过来的用户才可正常支付"  class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode}">
					                             	<span id="pay-rengxingpay" class="pay-logo"></span>
					                           	</label>
			                      			</c:if>
			                      			
			                      		</c:forEach>
			                      		<!-- 
			                            <input type="radio" name="paymentMethodId" id="inlineRadio26" value="option26">
			                             <label class="radio-inline">
			                               <span id="pay-unionpay" class="pay-logo"></span>
			                             </label>
			                            <input type="radio" name="paymentMethodId" id="inlineRadio27" value="option27">
			                             <label class="radio-inline">
			                               <span id="pay-alipay" class="pay-logo">
			                             </label>
			                            <input type="radio" name="paymentMethodId" id="inlineRadio28" value="option28">
			                             <label class="radio-inline">
			                               <span id="pay-yiwangtong" class="pay-logo">
			                             </label>
			                             -->
			                        </div><!--3party_pay--><br/><br/>
			                        <button class="btn btn-gold" type="button" onclick="doGotoPaymentGateway();">
				                        前往支付
				                      </button>
			                      </div><!--controls-->
			                  </div><!--control-group-->
			                </div><!--b3-->
			                
			                
			              </div><!--boards current_info_col-->
			          </div><!--current_infowtool-->
			       </div><!--checkout_info-->
			       
			     </div><!--chart_bottom-->
			    </div><!--end of maincontent-->
		    
			     <script>
					// perform JavaScript after the document is scriptable.
					$(function() {
					    // setup ul.tabs to work as tabs for each div directly under div.panes
					    $("#product_tabs").tabs("div.boards > div.board");	
						
					});
				</script>
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
		                <table class="checkout_table transfer_table" cellspacing="0" cellpadding="0">
				           <thead>
				           	<tr>
				              <th width="24%">
				                转账银行
				              </th>
				              <th width="25%">
				                户名
				              </th>
				              <th width="25%">
				                账号
				              </th>
				              <th width="26%">
				                开户行
				              </th>
				             </tr>
				           </thead><!--thead-->
				           <tbody>
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
				              
				           </tbody>     
				          
				         </table>
		            </div>
		        </div>
			
			</c:otherwise>
		</c:choose>
		<input type="hidden" name="orderNo" value="${salesOrder.orderNo}" />
		<input type="hidden" name="doAction" value="gotoPaymentGateway" />
	</form>
	</body>
</html>