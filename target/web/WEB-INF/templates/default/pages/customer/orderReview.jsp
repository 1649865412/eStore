<%@page import="org.htmlparser.lexer.PageAttribute"%><%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<html>
	<head>
		<title>我的订单</title>
	</head>
	<body>
		
		
<div class="maincontent">
         
			         <div class="position-wrap">
			            <a href="${ctxPath }/index.html">首页</a>&nbsp;&gt;&nbsp;
			            <a href="${ctxPath }/myaccount/order/list.html">我的账户</a>&nbsp;&gt;&nbsp;
			            <span class="selected">我的订单</span>
			         </div>  
			         <div class="top_about">
			         <br>
			           <div class="top_title">
			           <h1>我的账户</h1>
			           </div>
			           <ul class="tophelp">
			                <li>有任何疑问&nbsp;|</li>
			                <li>请点击在线客服&nbsp;|</li>
			                <li>或拨打400-661-5677&nbsp;|</li>
			                <li><a href="mailto:cs@sifangstreet.com">客服电子邮件地址</a>&nbsp;|</li>
			                
			                    <li><a href="#"  target="_blank" >配送信息</a>&nbsp;|</li>
			                <li>
			                    <a href="#"  target="_blank" >退换货条款</a>
			                </li>
			           </ul> 
			           <div class="blank24"></div>
			           <hr>
			         </div>
                
	                <div class="bottom_about">
	       
			           <div class="remote_nav">
			            <ul id="remote_nav_ul">
			              <li><a id="t1" href="${ctxPath}/myaccount/order/list.html" title="我的订单" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/order/')!=-1}"> class="current"</c:if>>我的订单</a></li>
			              <li><a id="t2" href="${ctxPath}/myaccount/favorites.html" title="我的收藏" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/favorites.html')!=-1}"> class="current"</c:if>>我的收藏</a></li>
			              <li><a id="t3" href="${ctxPath}/myaccount/review/list.html" title="我的评价" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/review/')!=-1}"> class="current"</c:if>>我的评价<span id="reviews_count"></span></a></li>
			              <li><a id="t4" href="${ctxPath}/myaccount/settings.html" title="个人资料" <c:if test="${fn:endsWith(OriginalRequestURL,'/myaccount/settings.html')}"> class="current"</c:if>>个人资料</a></li>
			              <li><a id="t5" href="${ctxPath}/myaccount/address.html" title="收货地址 " <c:if test="${fn:endsWith(OriginalRequestURL,'/myaccount/address.html')}"> class="current"</c:if>>收货地址</a></li>
			              <li><a id="t6" href="${ctxPath}/myaccount/shopPoint.html" title="积分" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/shopPoint.html')!=-1}"> class="current"</c:if>>积分</a></li>
			              <li><a id="t7" href="${ctxPath}/myaccount/giftCouponQuery.html" title="礼券/优惠劵" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/giftCouponQuery.html')!=-1}"> class="current"</c:if>>礼券/优惠劵</a></li>
			              <li><a id="t8" href="${ctxPath}/myaccount/giftCard.html" title="礼品卡管理" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/giftCard.html')!=-1}"> class="current"</c:if>>礼品卡</a></li>
			        
			            </ul>
			           </div><!--remote_nav-->
			           
			           
			           <div class="down_right left_border">
			             <p class="account_info_title">
			               账户：${customer.email}
			               <span class="header_breadcrumb">订单详情</span>
			             </p>
			             <p class="cus_id">会员级别：${membership.membershipName}</p>          
			             <div class="score_top">
			               <div class="leftright_form">
			                 <h3 class="padding_left10">订单信息</h3>
			                 <div class="score_info">
			                   <div class="score_info_left">
			                     <p>订单编号:</p>
			                     <p>订单日期:</p>
			                     <p>支付状态:</p>
			                     <p>订单状态:	</p>
			                   </div><!--score_info_left-->
			                   <div class="score_info_right">
			                     <p>${salesOrder.orderNo}</p>
			                     <p>${salesOrder.createTime}</p> 
			                     <p><fmt:message key="salesOrder.paymentStatus_${salesOrder.paymentStatus}" /></p>
			                     <p>
			                     	<c:choose>
										<c:when test="${salesOrder.isOnHold==1 and salesOrder.isHoldByCustomer==1}">
											<fmt:message key="salesOrder.orderStatus.toCancel" />
										</c:when>
										<c:when test="${salesOrder.paymentStatus == 10 && salesOrder.orderStatus==10}">
											<%-- The Pending is displayed on orderStatus when paymentStatus is unpaid. --%>
											待处理
										</c:when>
										<c:otherwise>
											<fmt:message key="salesOrder.orderStatus_${salesOrder.orderStatus}" />
										</c:otherwise>
									</c:choose>
								</p>
			                   </div><!--score_info_right-->
			                 </div><!--score_info-->
			               </div><!--leftright_form-->
			               <div class="leftright_form">
			                 <h3 class="padding_left10">收货人信息</h3>
			                 <div class="score_exchange">
			                    <div class="score_info_left">
			                     <p>姓名:</p>
			                     <p>地址:</p>
			                     <p>联系方式:</p>
			                     <p>邮编:	</p>
			                   </div><!--score_info_left-->
			                   <div class="score_info_right">
			                   <c:forEach items="${salesOrder.orderShipments}" var="ship" varStatus="varStatus" end="0">	
			                     <p>${ship.orderAddress.firstname }</p>
			                     <p>${ship.orderAddress.state } ${ship.orderAddress.city } ${ship.orderAddress.section } ${ship.orderAddress.address1 }</p>
			                     <p>${ship.orderAddress.phoneNumber } </p>
			                     <p>${ship.orderAddress.postalcode}</p>
			                     </c:forEach>
			                   </div><!--score_info_right-->
			                 </div><!--score_exchange-->
			               </div><!--leftright_form-->
			             </div><!--score_top-->
			             <div class="score_bottom">
			               <table class="account_table" cellspacing="0" cellpadding="0">
			                 <thead>
			                   <tr>
			                      <th width="20%">
			                        商品图像
			                      </th>
			                      <th width="25%" class="align_left">
			                        商品名称
			                      </th>
			                      <th width="20%">
			                        编码
			                      </th>
			                      <th width="5%">
			                        数量
			                      </th>
			                      <th width="10%">
			                        单价
			                      </th>
			                      <th width="10%">
			                        优惠
			                      </th>
			                      <th width="10%">
			                        总价
			                      </th>
			                   </tr>
			                 </thead><!--thead-->
			                 <tbody>
				                 <c:forEach items="${salesOrder.orderShipments}" var="ship" varStatus="varStatus" end="0">	
					                 <c:forEach items="${ship.orderSkus}" var="sku" varStatus="varStatus" >
					                   <tr class="border_none">
					                      <td rowspan="2" class="wish_img border_with">
					                      <product:productImg sku="${sku.productSku}" size="e" width="110" height="110"/>
					                      </td>
					                      <td class="align_left"><a href="#">${sku.productName }</a></td>
					                      <td>${sku.productSkuCode }</td>
					                      <td>${sku.quantity }</td>
					                      <td>${sku.price }</td>
					                      <td>${sku.price - sku.discountPrice }</td>
					                      <td>${sku.discountPrice * sku.quantity }</td>
					                   </tr>
					                   <tr>
					                      <td class="size_colour align_left">
					                        <product:showSkuOptions productSkuId="${sku.productSkuId}"></product:showSkuOptions>
					                      </td>
					                      
					                      <td></td>
					                      <td></td>
					                      <td></td>
					                      <td></td>
					                      <td></td>
					                   </tr>
					                   </c:forEach>
				                   </c:forEach>
			                 </tbody>
			                 <tfoot>
			                  <tr class="border_none">
			                    <td colspan="2" rowspan="4" class="border_with"></td>
			                    <td colspan="2" class="align_right padding_right10">共计有<span class="colour_gold padding_td text_bold">3</span>件商品</td>
			                    <td>小计：</td>
			                    <td colspan="2" class="align_right padding_right30">￥${salesOrder.totalAmount }</td>
			                  </tr>
			                  
			                  <tr class="border_none">
			                    <td colspan="2"></td>
			                    <td>已支付</td>
			                    <td colspan="2" class="align_right padding_right30">￥${salesOrder.paidAmount }</td>
			                  </tr>            
			                  
			                  <tr>
			                    <td colspan="2"></td>
			                    <td class="colour_gold text_bold padding_bottom15">还需支付：</td>
			                    <td colspan="2" class="align_right padding_right30 colour_gold text_bold padding_bottom15">￥${salesOrder.totalAmount - salesOrder.paidAmount }</td>
			                  </tr>
			                  <c:forEach var="orderShipment" items="${salesOrder.orderShipments}" varStatus="orderShipment_varStatus">
				                  <td colspan="2"></td>
				                    <td class="colour_gold text_bold padding_bottom15"></td>
				                    <td colspan="2" class="align_right padding_right30 colour_gold text_bold padding_bottom15"></td>
				                  <tr>
				                    <td>快递公司：${orderShipment.carrierName }</td>
				                    <td>快递单号：${orderShipment.trackingNo }</td>
				                  </tr>
			                  </c:forEach>
			                 </tfoot>
			               </table>
			               <div class="accountdetail_button">
			               	<c:if test="${salesOrder.cancelOrderPermission4Customer}">
								<form method="post" name="cancelForm" action="${ctxPath}/myaccount/order/${salesOrder.salesOrderId}.html" onsubmit="return confirm('Cancel this Order?');" style="display: inline;">
								<input type="hidden" name="doAction" value="cancelOrder" />
								<input type="hidden" name="cancleType" value="6"/>
								<button name="cancel" class="btn btn-black" type="button" onclick="javascript:if(confirm('Are you sure you want to cancel this order?')){document.cancelForm.submit()};">
			                      <i class="fa fa-times padding_right10"></i>
			                      取消
			                  </button>
								</form>
							</c:if>
			                  
			                  <div class="right">
			                  <c:if test="${salesOrder.orderStatus!=40 and  salesOrder.orderStatus!=30 and  salesOrder.paymentStatus!=30 and salesOrder.orderStatus!=80}">
			                  <form action="${ctxPath}/checkout/goToPay.html">
							<input type="hidden" name="doAction" value="selectOnlinePayment"/>
							<input type="hidden" name="orderNo" value="${salesOrder.orderNo}"/>
							
			                  <button name="pay" class="btn btn-gold" type="submit">
			                      <i class="fa fa-credit-card padding_right10"></i>
			                      支付
			                  </button>
			                  </form>
			                  </c:if>
			                  </div>
			               </div><!--accountdetail_button-->
			             </div><!--score_bottom-->
			           </div><!--down_right-->
				           
			         </div>
                
			</div>

	<script type="text/javascript">
	</script>
	
		
		
	</body>
</html>