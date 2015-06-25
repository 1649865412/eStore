<%@ include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/checkout/checkoutPagingManager.js"></script>
<c:if test="${fn:length(shippingRateList)==0}">
	<div class="error_box">
<li class="succeed">
			<fmt:message key="checkout.message.noship" />
		</li>
	</div>
</c:if>
<form action="" method="post" onsubmit="return fnCheckPlaceOrder();">
<div class="left">
	<img src="${resPath}/images/icon/cart2.jpg"/ >
</div>
<div class="clear"></div>
<div class="checkout-content" style="padding:0; width:998px;">
	<div class="review-book">
		<div style="padding-right:20px; display:inline;">
			<h4>确认收货地址:</h4>
            <h6></h6>
            <div class="blank10"></div>
			<div style="padding:10px 0; width:90%; margin:auto; line-height:200%;">
				${shippingAddress.firstname}${emptySpace}${emptySpace}${shippingAddress.telephone}<br/>
				${shippingAddress.stateName}${emptySpace}${shippingAddress.cityName}${emptySpace}${shippingAddress.address}${emptySpace}${emptySpace}${emptySpace}${emptySpace}${shippingAddress.zip}
				${emptySpace}${emptySpace}${emptySpace}${emptySpace}&nbsp;&nbsp;&nbsp;<a href="${ctxPath}/checkout/shippingAddress.html?change" style="color:#f00; text-decoration:underline;">修改</a>
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<div class="review-book">
		<h4>选择配送方式:</h4>
        <h6></h6>
        <div class="blank10"></div>
		<c:if test="${fn:length(shippingRateList)==0}">
			<span class="red"><fmt:message key="checkout.message.noship" /></span>
		</c:if>
        <div style="padding-left:20px;">
		<c:forEach items="${shippingRateList}" var="shippingRate" varStatus="varStatus">
			<div class="left" style="margin-left:10px;"><input type="radio" value="${shippingRate.shippingRateId},${shippingRate.shippingMethod.shippingMethodId}" name="shippingMethodId"<c:if test="${varStatus.first}"> checked="checked"</c:if>/>
				<input type="hidden" id="cartShipping_${shippingRate.shippingMethod.shippingMethodId}" value="${shippingRate.cartShipping}"/></div>
			<div class="left"><label>${shippingRate.shippingMethod.shippingMethodName}</label></div>
		</c:forEach>
        </div>
		<%-- 2009/11/04 目前没有保险功能,先屏蔽.
		<input type="checkbox" name="" value=""  /><strong class="black">Add Shipping Insurance to your order</strong>
		<br/><span class="pad30">(We offer Shipping Insurance US$ 1.99 to protect your package against any lost or damaged shipments. Any missing issues reported, we will reship your order immediately.)</span>
		--%>
		<div class="blank10"></div>
	</div>
	<div class="clear"></div>
	<div class="review-book">
		<h4>选择支付方式:</h4>
        <h6></h6>
		<ul class="payment" style="padding:10px 0; width:92%; margin:auto;" id="paymentMethodList">
			
			<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="varStatus">
						<li style="float:left; margin-right:26px;">
								<div class="left" style="margin:10px 10px 0 0;">
									<input class="paymentMethod" name="paymentId" id="paymentId_${paymentMethod.paymentMethodId}" type="radio" value="${paymentMethod.paymentMethodId}" onclick="showExplain(this);" <c:if test="${varStatus.first}"> checked="checked"</c:if>/>
									<input type="hidden" value="${paymentMethod.paymentMethodCode }" />
								</div>
								<div class="left"><label for="paymentId_${paymentMethod.paymentMethodId}">
									<img src="${resPath}/images/${paymentMethod.paymentMethodIcon}" onerror="this.src=__defaultImage" border="0" />
								</label>
			                    </div>
						</li>
			</c:forEach>
			<li style="float:left; margin-right:26px;">
					<div class="left" style="margin:10px 10px 0 0;">
						<input class="paymentMethod" name="paymentId"  id="paymentId_cod" type="radio" value="cod" onclick="showExplain(this);" />
						<input type="hidden" value="cod" />
					</div>
					<div class="left">
						<label for="paymentId_cod">
							<img src="${resPath}/images/payment/icon/cod2.jpg" onerror="this.src=__defaultImage" border="0" />
						</label>
                    </div>
			</li>
		</ul>
        <div class="blank24"></div>
	</div>
	<div class="clear"></div>
	<div class="review-book">
		<h4>确认商品清单:</h4>
        <h6></h6>
		<table class="table-cart" width="90%" border="0" cellspacing="0" cellpadding="0" align="center" style="border:none;">
			<tr class="black">
				<th width="130" class="in_1em"></th>
				<th>商品名称</th>
				<th width="120">单价</th>
                <th width="120">数量</th>
                <th width="120">优惠</th>
				<th width="120">小计</th>
			</tr>
			<c:forEach items="${shoppingcart.cartItems}" var="cartItem" varStatus="varStatus">
				<tr>
					<td style="padding:10px;">
						<product:productImg sku="${cartItem.productSku}" size="e" width="120" height="120" />
					</td>
					<td>
						<product:productName product="${cartItem.productSku.product}"/><br/>
						(${cartItem.productSku.productSkuCode})<br/>
						<span class="blue">
							<product:showSkuOptions productSkuId="${cartItem.productSku.productSkuId}"/>
							<product:showAccessories accessories="${cartItem.accessories}"/>
						</span>
					
					</td>
					<td class="price">
						<system:CurrencyForRate value="${cartItem.price}"/>
					</td>
					<td class="b">${cartItem.quantity}</td>
					<td class="price">
						<system:CurrencyForRate value="${(cartItem.price - cartItem.discountPrice)* cartItem.quantity}"/>
					</td>
					<td class="price"><system:CurrencyForRate value="${cartItem.discountPrice*cartItem.quantity}"/></td>
				</tr>
			</c:forEach>
		</table>
		<div style="padding:20px; float:left;"><a href="${ctxPath}/cart/shoppingcart.html">回到购物车，修改产品>></a></div>
        <div style="padding:20px; float:right; font-weight:bold; color:#C20000;">商品金额小计:${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_total">${shoppingcart.subtotal}</span></div>
        <div class="blank10"></div>
	</div>
	<c:if test="${appConfig.isSupportWrapExpress}">
	<div class="check-alsobuy">
		<strong>${appConfig.store.name} now offer gift wrap services for this holiday season. Purchase any item you wish and we will gift wrap your order if you wish,for a small fee.Please select the option for our gift wrapping service and send your greetings via the card we will be sending with the gift.</strong>
		<table width="950" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" valign="middle"><img src="${resPath}/images/layout/card01.jpg" border="0"  /></td>
			<td align="center" valign="middle"><img src="${resPath}/images/layout/card02.jpg" border="0"  /></td>
			<td align="center" valign="middle"><img src="${resPath}/images/layout/card03.jpg" border="0"  /></td>
		</tr>
		 <tr>
			<td align="center" valign="middle">Tasty Gift Packaging<br />(Pattem may vary)</td>
			<td align="center" valign="middle">Silver/golden Ribbon</td>
		   <td align="center" valign="middle">Gift card with your<br />personal message-${appConfig.isSupportWrapExpress}-${shoppingcart.isOnlyVirtualItem }-</td>
		</tr>
		</table>
		<div class="clear"></div>
		<ul style="margin:10px auto; width:400px; font-weight:bold;">
			<c:choose>
				<c:when test="${appConfig.isSupportWrapExpress and not shoppingcart.isOnlyVirtualItem }">
					<li><input type="radio" value="0" name="wrap_wrapId" checked="checked"/><input id="wrapPrice_0" type="hidden" value="0" /><label>Dont't gif-wrap this item.</label></li>
					<c:forEach items="${wrapList}" var="wrap">
						<li>
							<input name="wrap_wrapId" type="radio" value="${wrap.wrapId}" <c:if test="${varStatus.first}"> checked="checked"</c:if>/>
							<input id="wrapPrice_${wrap.wrapId}" type="hidden" value="${wrap.defaultPrice}" />
							<label>
								${wrap.wrapName }(<span class="red">${appConfig.defaultCurrencySymbol}${wrap.defaultPrice}</span>)
								<br/>${wrap.description}
							</label>
						</li>
					</c:forEach>
				</c:when>
			</c:choose>
		</ul>
		<div class="dashed-line"></div>
			<table width="60%" border="0" cellspacing="0" cellpadding="0" style="display: none;" id="cardForm" align="center">
			  <tr>
				<td valign="top" width="20"><input type="hidden" name="wrap" id="wrap" value="false"/>Note：</td>
				<td><textarea name="wrapNote" cols="40" rows="8" class="box-input"  onblur="if (this.value == '') this.value = 'Write down your greetings here,and we will print them on the greeting card(within 1000 characters please) Or leave it blank for a blank card.';" onfocus="if (this.value == 'Write down your greetings here,and we will print them on the greeting card(within 1000 characters please) Or leave it blank for a blank card.') this.value = '';">Write down your greetings here,and we will print them on the greeting card(within 1000 characters please) Or leave it blank for a blank card.</textarea></td>
			  </tr>
			</table>
	</div>
	</c:if>
	<div class="review-book">
		<h4>订单备注:</h4>
		<table class="check-product" width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td style="padding:20px;">
				<textarea name="orderNote" id="orderNote" rows="4" cols="150" style="border:1px solid #ccc;"></textarea>
				</td>
			</tr>			
		</table>
	</div>
	<div class="blank10"></div>
 	<%--<div class="left" style="padding:10px 0 0 0;">
				<span id="giftPaymentData"></span>
				<input id="giftCertificateNos" name="giftCertificateNos" type="hidden" value="${giftCertificateNos }">
				<input id="giftCertificate" name="giftCertificate" type="hidden" value="${giftCertificate }">
				<div id="giftContent">
					<div style="margin:0 0px 0 0px;" class="left">
						礼品卡号/礼券
					</div>
					<div class="left">
						<input type="text" style="height:15px;" class="box-input" size="18" name="giftCertificateNo" id="giftCertificateNo">
					</div>
	                <div class="left" style="margin:-10px 0 0 10px;"><input type="button" value="确认" onclick="fnUseGift();" class="box-btn"></div>
	                <div class="clear" style="border:none;"></div>
	                <c:if test="${not empty gcList}">
	                <div style="margin:20px 20px 0 20px;" class="left">
						我的礼品卡<br />
					</div>
					<div class="left" style="padding-top:16px;">
						<table id="myGiftList" cellspacing="0" cellpadding="0">
							<c:forEach var="gc" items="${gcList}">
								<tr giftNum="${gc.giftCertificateNo}">
									<td>
										<a href="javascript:void(0);">${gc.giftCertificateNo}</a>
									</td>
									<td>
										本次结帐可用余额 <system:CurrencyForRate value="${gc.remainedAmt}" />&nbsp;&nbsp;<a href="javascript:void(0);">应用</a>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					</c:if>
					<div class="blank24" style="border:none;"></div>
				</div>
				<div style="display:none;" class="gift-checkout" id="usedGiftNoDiv">
				    <fmt:message key="checkout.labelUseGiftCertificate" /><br/>
	                <span id="usedGiftNoTab"></span>
				</div>
		</div>
		--%></div>
        <div class="right">
            <table width="280" border="0" cellspacing="0" cellpadding="0" align="right" class="table-total">
                <tr id="wrap_tr" style="display: none;">
                  <th class="f13px">包装费:</th>
                  <td class="f13px red fB">${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_wrap">0.00</span></td>
                </tr>
                <tr id="shipping_tr" style="display: none;">
                  <th class="f13px">运费:</th>
                  <td class="f13px red fB">${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_shipping">12.00</span></td>
                </tr>
                <tr id="tax_tr" style="display: none;">
                  <th class="f13px"><fmt:message key="shoppingcart.taxAmt" />:</th>
                  <td class="f13px red fB">${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_tax">0.00</span></td>
                </tr>
                <tr id="save_tr"  style="display: block">
                  <th class="f13px"><fmt:message key="shoppingcart.discount" />:</th>
                  <td class="f13px red fB">-${appConfig.defaultCurrencySymbol}&nbsp;<span id="save">${shoppingcart.cartDiscountAmount == null ? 0.00 : shoppingcart.cartDiscountAmount}</span></td>
                </tr>
                <tr id="gift_tr" style="display: block;">
                  <th class="f13px"><fmt:message key="checkout.labelUseGiftCertificate" />:</th>
                  <td class="f13px red fB">
	                  -${appConfig.defaultCurrencySymbol}&nbsp;
	                  <span id="giftPay">
	                  	<c:if test="${shoppingcart.giftCertificateNos == null}">
	                  		0.00
	                  	</c:if>
	                  	<c:if test="${shoppingcart.giftCertificateNos != null}">
	                  		${fn:substringAfter(shoppingcart.giftCertificateNos,":") }
	                  	</c:if>
	                  </span>
                  </td>
                </tr>
                <tr id="point_tr">
                  <th class="f13px">使用积分:</th>
                  <td class="f13px red fB">-${appConfig.defaultCurrencySymbol}&nbsp;<span id="point">${shoppingcart.shopPoint * appConfig.shopPointUseGiftPercent}</span></td>
                </tr>
                <tr id="abc_tr"  style="display: none;">
                  <th class="f13px">农业银行折扣 :</th>
                  <td class="f13px red fB">
                  	<input type="hidden" value="false" name="isAbcDiscount" id="isAbcDiscount"/>
                  	<span id="abc_discount">9折</span>
                  </td>
                </tr>
                <tr>
                  <th class="f13px">应付金额:</th>
                  <td class="f13px red fB">${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_sum">${shoppingcart.subtotal}</span></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:right; padding:0 20px 20px 0;">
                    <div class="place"><input type="image" src="${resPath}/images/btn/btn_gotopay.jpg"/></div>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 
        <div style="float: left; padding:30px 0 0 0;">
        	<table>
        		<tr>
                	<td align="right" style="padding-right:20px;color:#666;" >
                		<div id="payMsg" style="display: none;"></div>
					</td>
					<td>
						<input id="cardTypChoose" type="button" class="box-btn" value="下一步" onclick="chooseCardTyp('','','');" style="width: 100px;height: 37px;"/>
					</td>
					<td align="right">
						<div class="place" style="display: block;" id="paySubmit"><input type="image" src="${resPath}/images/btn/btn_gotopay.jpg"/></div>
					</td>
                </tr>
            </table>
        </div>
         -->
	<input type="hidden" name="doAction" value="doCK"/>
</form>

<%@ include file="./include/cardType.jsp"%>

<script type="text/javascript">
$(".paymentMethod:radio").change(function(){
	var $this = $(this);
	var $code = $this.next();
	var code = $code.val();
	var $cart_sum = $("#cart_sum");
	var cart_sum = $cart_sum.text();
	if(code == "abc"){
		$("#abc_tr").show();
		$("#isAbcDiscount").val("true");
		$cart_sum.html(parseFloat((cart_sum) * 0.9).toFixed(2));
		var a = 1;
	}else{
		$("#abc_tr").hide();
		$("#isAbcDiscount").val("false");
		//$cart_sum.html("${shoppingcart.total}");
		fnUpdatePrice();
	}
});
</script>

<div class="clear"></div>