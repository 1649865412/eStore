<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<html>
	<head>
		<title><fmt:message key="checkout.checkoutFlow" /> | <fmt:message
				key="checkout.stepOrderReview" /></title>
		<meta http-equiv="Pragma" content="no-cache" />
	</head>
	<body>
		<div class="last-step-order">
        	<div class="left"><img src="${resPath}/images/icon/icon_right.jpg" /></div>
            <div class="left" style="font-size:14px; font-weight:bold; line-height:180%; padding-left:10px;">
            	恭喜生成订单号:<span class="red">${salesOrder.orderNo}</span> 应付金额合计:<span class="red"><system:CurrencyForRate value="${salesOrder.shouldPay}" /></span>
                <br/>
                <c:if test="${paymentMethod != null}">
                请尽快完成付款，以便我们尽快安排发货。<br/>
                <span style="color:#A0A0A0; font-size:12px;">请您在提交订单后72小时内完成支付，否则订单自动取消。</span>
                </c:if>
                <c:if test="${paymentMethod == null}">
                我们尽快安排发货，收货后请完成付款。<br/>
                </c:if>
                
            </div>
            <div class="right"><img src="${resPath}/images/icon/step3.jpg" /></div>
        </div>
        <div class="blank24"></div>
		<div class="review-book">
        	<h4>收货人信息：</h4>
            <h6></h6>
            <div class="blank10"></div>
            <div style="padding:10px 0; width:98%; margin:auto; line-height:200%;">
            	<c:forEach items="${salesOrder.orderShipments}" var="ship" varStatus="varStatus" end="0">	
                    <c:if test="${not ship.isAllDigitalItem}">
                        姓    名：${ship.orderAddress.firstname }
                        <br />
                        地    址：${ship.orderAddress.state } ${ship.orderAddress.city } ${ship.orderAddress.address1 }
                        <br />					
                        邮    编：${ship.orderAddress.postalcode}
                        <br/>	
                        电    话：${ship.orderAddress.phoneNumber}
                        <br/>			
                    </c:if>
                </c:forEach>
            </div>
        </div>
            <div class="blank10"></div>
            <table width="60%" border="0" cellspacing="0" cellpadding="0" class="table-review-total" align="left">
					<c:forEach items="${salesOrder.orderShipments}" var="ship" varStatus="varStatus">
					<c:if test="${not varStatus.first}">
						<tr>
							<td colspan="4"></td>
						</tr>
					</c:if>
					<tr>
						<th width="68%">
							<c:choose>
								<c:when test="${fn:length(salesOrder.orderShipments)>1}">${ship.shipmentNo}</c:when>
								<c:otherwise><fmt:message key="orderItem.productName" /></c:otherwise>
							</c:choose>
						</th>
						<th width="10%">
							<fmt:message key="orderItem.price" />
						</th>
						<th width="10%">
							<fmt:message key="orderItem.quantity" />
						</th>
						<th width="12%">
							<fmt:message key="orderItem.total" />
						</th>
					</tr>
					<c:forEach items="${ship.orderSkus}" var="sku">
						<tr>
							<td style="padding-left:10px;">
								<c:choose>
									<c:when test="${sku.itemType==1}">
										<a href="<product:productUrl product="${sku.productSku.product}" />">${sku.productName }</a><br />
										<fmt:message key="productDetail.productNo" />:${sku.productSkuCode }<br />
										<product:orderSkuOption orderSku="${sku}" />
										<product:showAccessories accessories="${sku.accessories}"/>
									</c:when>
									<c:otherwise>
										<fmt:message key="shoppingcart.gcName" />
										<c:set var="op" value="${fn:split(sku.displaySkuOptions,'###')}" />
										<br />
										<fmt:message key="shoppingcart.gcRecipient" />:${op[0]}<br />
										<fmt:message key="shoppingcart.gcRecipientEmail" />:${op[1]}
									</c:otherwise>
								</c:choose>
							</td>
							<td align="center">
								<system:CurrencyForRate value="${sku.discountPrice }" />
								<br />
								<c:if test="${sku.discountPrice!=sku.price}">
							(<fmt:message key="minicart.money.yuan" />
									<span class="listPrice"><system:CurrencyForRate value="${sku.price}" />
									</span>)
						</c:if>
							</td>
							<td align="center">
								${sku.quantity }
							</td>
							<td class="order-class">
								<system:CurrencyForRate value="${sku.subTotalAmount}" />
							</td>
						</tr>
					</c:forEach>
					<c:set var="sum_itemSubTotal" value="${ship.itemSubTotal+sum_itemSubTotal}"/>
					<c:set var="sum_shippingCost" value="${ship.shippingCost+sum_shippingCost}"/>
					<c:set var="sum_wrapUnitPrice" value="${ship.wrapUnitPrice+sum_wrapUnitPrice}"/>
					<c:set var="sum_itemTax" value="${ship.itemTax+sum_itemTax}"/>
					<c:set var="sum_discountAmount" value="${ship.discountAmount+sum_discountAmount}"/>
					</c:forEach>
<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="3" class="title">
							<fmt:message key="shoppingcart.subtotal" />
							:
						</td>
						<td class="order-class">
							<system:CurrencyForRate value="${sum_itemSubTotal}" />
						</td>
					</tr>
					<c:if test="${sum_shippingCost>0}">
						<tr>
							<td colspan="3" class="title">
								<fmt:message key="salesOrder.shippingTotalCost" />
								:
							</td>
							<td class="order-class">
								<system:CurrencyForRate value="${sum_shippingCost}" />
							</td>
						</tr>
					</c:if>
					<c:if test="${sum_wrapUnitPrice>0}">
						<tr>
							<td colspan="3" class="title">
								<fmt:message key="salesOrder.wrapTotalCost" />
								:
							</td>
							<td class="order-class">
								<system:CurrencyForRate value="${sum_wrapUnitPrice }" />
							</td>
						</tr>
					</c:if>
					<c:if test="${sum_itemTax>0}">
					<tr><%-- ç¨æ¯æ°¸è¿é½æ¾ç¤ºçï¼åªæ¯å¤æ°ä¸º0  --%>
						<td colspan="3" class="title">
							<fmt:message key="salesOrder.taxAmt" />
							:
						</td>
						<td class="order-class">
							<system:CurrencyForRate value="${sum_itemTax}" />
						</td>
					</tr>
					</c:if>
					<c:if test="${sum_discountAmount>0}">
						<tr>
							<td colspan="3" class="title">
								<fmt:message key="salesOrder.saveMoneyTotal" />
								:
							</td>
							<td class="order-class">
								-<system:CurrencyForRate value="${sum_discountAmount }" />
							</td>
						</tr>
					</c:if>
					<c:if test="${sum_discountAmount<0}"><%-- åå°å¢å äºè®¢åçæç»­è´¹ ,ä¹ä½¿ç¨discountAmoutè®°å½,ä½ä½¿ç¨è´æ°è®°å½.--%>
						<tr>
							<td colspan="3" class="title">
								Other Fee
								:
							</td>
							<td class="order-class">
								<system:CurrencyForRate value="${-sum_discountAmount}" />
							</td>
						</tr>
					</c:if>
					<c:if test="${salesOrder.paidAmount>0}">
					<tr>
						<td colspan="3" class="title fB f13px">
							<fmt:message key="salesOrder.payTotal" />
							:
						</td>
						<td class="order-class fB f13px">
							<system:CurrencyForRate value="${salesOrder.paidAmount }" />
						</td>
					</tr>
					</c:if>
					<tr>
						<td colspan="3" class="title fB f13px red">
							<fmt:message key="salesOrder.grossTotal" />
							:
						</td>
						<td class="order-class fB f13px red">
							<system:CurrencyForRate value="${salesOrder.shouldPay}" />
						</td>
					</tr>
					<!-- 
					<tr>
						<td align="right" colspan="10">
							<input type="image" src="${resPath}/images/btn/btn_gotopay.jpg" onclick="window.location.href='${ctxPath}/checkout/goToPay.html?doAction=selectOnlinePayment&orderNo=${salesOrder.orderNo}'" />
						</td>
					</tr>
					 -->
				</table>
	<div class="blank24"></div>
	<c:if test="${paymentMethod != null}">
	<div class="review-book">
    	<h4>支付方式</h4>
        <h6></h6>
        <div style="width:80%; margin:30px auto; border:3px solid #D6C460; overflow:hidden;padding:40px;">
        	<div class="left"><img src="${resPath}/images/${paymentMethod.paymentMethodIcon}" onerror="this.src=__defaultImage" border="0" />
        	</div>
            <div class="left" style="padding:16px 0 0 20px; font-weight:bold;">
            	${paymentMethod.paymentMethodName}
            </div>
            <div class="left" style="height:35px; line-height:35px; border-bottom:1px solid #5C5C5C; color:#5C5C5C; background-color:#D6C462; font-size:16px; text-align:center; padding:0 10px;margin:8px 0 0 160px;">
         	   <a id="goToPay" href="${ctxPath }/checkout/goToPay.html?orderNo=${salesOrder.orderNo}"  style="text-decoration:none;">前往支付</a>
            </div>
        </div>
    </div>
    </c:if>
    <div class="solid-line"></div>

<script type="text/javascript">
	$(document).ready(function(){
		/*
		$("#goToPay").click(function(){
			var orderNo = "${salesOrder.orderNo}";
			var cardTyp = $("input:checked").val();
			window.location.href = "${ctxPath}" + "/checkout/goToPay.html?orderNo=" + orderNo + "&cardTyp=" + cardTyp;
		});
		*/
	});
</script>



		
		
		
		
		<%--注意前台下单只有一个运输项,因此只取第一个运输项的数据，注意数字产品调整--%>
		<c:if test="${appConfig.store.isTrackOrder}">
<cartmatic:collectionToList var="orderShipmentList" itmes="${salesOrder.orderShipments}"></cartmatic:collectionToList>
<c:set var="ga_trackeer" scope="request">
  _gaq.push(['_addTrans',
    '${salesOrder.orderNo}',           <%-- // order ID - required--%>
    '${salesOrder.customerTitle}${emptySpace}${salesOrder.customerFirstname}',  <%-- // affiliation or store name--%>
    '${orderShipmentList[0].total}',     <%-- // total - required--%>
    '0',     <%-- // tax--%>
    '${orderShipmentList[0].shippingCost}',       <%-- // shipping--%>
    '<c:out value="${orderShipmentList[0].orderAddress.city}"/>',      <%-- // city--%>
    '${orderShipmentList[0].orderAddress.state}',    <%-- // state or province--%>
    '${orderShipmentList[0].orderAddress.country}'      <%-- // country--%>
  ]);			
<c:forEach items="${orderShipmentList[0].orderSkus}" var="os_item" >
  _gaq.push(['_addItem',
    '${salesOrder.orderNo}',          <%-- // order ID - required --%>
    '${os_item.productSkuCode}',          <%-- // SKU/code - required --%>
    '<c:out value="${os_item.productName}"/>',       <%-- // product name --%>
    'N/A',  <%-- // category or variation --%>
    '${empty os_item.discountPrice?os_item.price:os_item.discountPrice}',         <%-- // unit price - required --%>
    '${os_item.quantity}'              <%-- // quantity - required --%>
  ]);			 
</c:forEach>
  _gaq.push(['_trackTrans']); //submits transaction to the Analytics servers
</c:set>
		</c:if>
	</body>
</html>