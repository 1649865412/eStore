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
        <link href="${resPath}/styles/css/car-list.css" rel="stylesheet">
        <%@ include file="../../decorators/include/meta.jspf"%>
		<%@ include file="../../decorators/include/javascripts.jspf"%>
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/checkout/cartManager.js"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>

	<body>
	<!--[if lt IE 8]>
       <p class="browserupgrade">你正在使用一个 <strong>过时的</strong> 浏览器. 请 <a href="http://browsehappy.com/">提高您的浏览器</a> 以提高您的经验.</p>
       <![endif]-->
		<!--登陆注册-->
		<<%@ include file="../../decorators/include/headerNew.jspf"%>
        <!--end of 导航-->
        <form action="/cart/shoppingcart.html" id="cart_form" method="post">
		<div class="w-car-box">
        	<div class="w-car-box-tit">购物车</div>
            <div class="w-car-box-list-tit">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <%--<td width="2%"><input name="" type="checkbox" value=""></td>
                      --%><td width="35%">产品信息</td>
                      <td width="10%" align="center">删除</td>
                      <td width="12%" align="center">单价</td>
                      <td width="18%" align="center">数量</td>
                      <td width="10%" align="center">优惠</td>
                      <td width="10%" align="center">总价</td>
                    </tr>
                </table>
            </div>
            <div class="w-car-box-list-box">
            <c:choose>
            	<c:when test="${shoppingcart==null || shoppingcart.buyNowItemsCount==0}">
				    <tr>
						<td colspan="6">
							<br/>&nbsp;<fmt:message key="shoppingcart.message.isEmpty" />
						</td>
					</tr>
				</c:when>
				<c:otherwise>
				<c:forEach items="${brandList}" var="brand" varStatus="varStatus">
				
            	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            		<tr>
                        <%--<th width="2%"><input name="" type="checkbox" value=""></th>
                        --%><th width="15%">品牌：<a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}" class="underline">${brand.brandName}</a></th>
                    </tr>
            		<c:forEach items="${shoppingcart.cartItems}" var="item" varStatus="varStatus">
                    <c:if test="${item.productSku.product.brandId==brand.brandId}">
                    
                    <tr>
                        <%--<td width="2%"><input name="" type="checkbox" value=""></td>
                        --%><td width="15%"><product:productImg sku="${item.productSku}" size="e" width="70%"/></td>
                        <td valign="top">
                        	<dl>
                            	<dt>
                                	<p><product:productName product="${item.productSku.product}"/></p>
                                    <p>产品编码：${item.productSku.product.productCode}</p>
                                    <p><product:showSkuOptions productSkuId="${item.productSku.productSkuId}"></product:showSkuOptions></p>
                                    <p><span>库存有限，请及时购买</span></p>
                                    <%--<p><em>本产品参加10月周年庆活动</em></p>   
                                --%></dt>
                                <dd class="w-car-close">
                                	<a href="javascript:void()" onclick="javascript:$cm.deleteItem('${item.shoppingcartItemId}');"><i class="fa fa-close"></i></a>
									<input type="hidden" name="buyNowItemId" value="${item.shoppingcartItemId}"/>
									<input type="hidden" name="${item.shoppingcartItemId}_sku" value="${item.productSku.productSkuCode}"/>
								</dd>
                                <dd class="b-car-price"><system:CurrencyForRate value="${item.price}" /></dd>
                                
                                
                                <dd class="w-car-last">
                                	<div class="Spinner">
                                		<a href="javascript:void()" onclick="substractQuantity(this,'${item.shoppingcartItemId}','${item.shoppingcart.uuid}',
						               '${item.price}','${item.discountPrice}','${item.shoppingcart.subtotal}','${item.shoppingcart.cartDiscountAmount}');"><i class="fa fa-minus"></i></a>
						               <input name="${item.shoppingcartItemId}_quantity"  type="text"  value="${item.quantity}" />
						               <a href="javascript:void()"  onclick="addQuantity(this,'${item.shoppingcartItemId}','${item.shoppingcart.uuid}',
						               '${item.price}','${item.discountPrice}', '${item.shoppingcart.subtotal}','${item.shoppingcart.cartDiscountAmount}',
						               '${item.productSku.productSkuId}','${item.productSku.inventory.quantityOnHand}');"><i class="fa fa-plus"></i></a>
                                    </div>
                                    <div class="m-car-price"><span id="discountPrice_${item.shoppingcartItemId}">
					              	  <system:CurrencyForRate value="${(item.price - item.discountPrice)*item.quantity}"/>
					              	</span><span id="oneTotalPrice_${item.shoppingcartItemId}">
					                  <system:CurrencyForRate value="${item.discountPrice*item.quantity}"/>
					                </span></div>
                                </dd>
                            </dl>
                    	</td>
                    </tr>
                    </c:if>
                    </c:forEach>
                </table>
                </c:forEach>
                </c:otherwise>
            </c:choose>
            </div>
            <div class="w-car-bottom row">
            	<div class="w-car-bottom-info">
                	<p><span></span>在您选择送货目的地后，商品的价格可能会有所更改。在完成付款程序前，请在订单总结页面检查总金额。</p>
                    <p><span></span>一旦订购过程完成后，您将无法在此订单中添加新的商品。</p>
                    <p><span></span>积分兑换，每20积分可兑换1元，但每次需兑换100积分的倍数。</p>
                </div>
                <div class="w-car-bottom-btn">
                	<h2>小计：${appConfig.defaultCurrencySymbol}<span id="subtotal">${shoppingcart.subtotal }</span></h2>
                	<td colspan="2" class="chart_howmany"  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="display:none">会员优惠：</span></td>
             
		              <!--会员优惠-->
		              <td class="align_right padding_right30">
			         
			              <span id="cart_dis_member" style="display:none">${shoppingcart.cartDiscountAmount == null ? 0.00 : shoppingcart.cartDiscountAmount}</span>
		              </td>
		              <h id="full_cut" colspan="2" class="chart_howmany" >
			              <td colspan="2" class="chart_howmany" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;品牌满减优惠：</td>
			              </td>
			              <td class="align_right padding_right30">
				             -${appConfig.defaultCurrencySymbol}
				              <span id="cart_full_cut">${fullCutPrice}</span>
			              </td>
			            </h>
                    <ul>
                    	<li><input id="couponNo_input_id" name="couponNo_input_name" 
			                     type="text" placeholder="输入优惠劵"  title="温馨提示：“输入优惠券”后，点击“去结算”，即可看到“优惠”的金额。"
			                      onblur="fnUseCoupon(${shoppingcart.usedCouponNo });"  value="${shoppingcart.usedCouponNo }"
			                       autocomplete="off"  <c:if test="${shoppingcart.giftCertificateNos != null }">disabled</c:if>/>
			                       <input  type="hidden" value ="" id="rightcoupon">
	              <span id="cartDiscountAmount" style="display:none">0.00</span></li>
                        <span style="display:none"><li><input name="giftCertificateNo" id="giftCertificateNo" type="text" placeholder="输入礼品卡/礼券"  
			                    onblur="fnUseGift('${shoppingcart.giftCertificateNos == null ? '' : fn:substringBefore(shoppingcart.giftCertificateNos,':') }',1);"  
			                    onfocus="showGiftList();" value="${fn:substringBefore(shoppingcart.giftCertificateNos,':') }" autocomplete="off" <c:if test="${shoppingcart.usedCouponNo != null }">disabled</c:if>/>
			                    <c:if test="${not empty gcList}">
									<div id="giftList"  style="position: absolute; background-color: white;display: none;width: 150px;height: 85px;border:1px solid #C1F248;overflow: auto;line-height: 25px;">
										<c:forEach var="gc" items="${gcList}">
												<ul>
													<a onclick="fnUseGift('${gc.giftCertificateNo}',2);" style="cursor: pointer;">
													${gc.giftCertificateNo}&nbsp;余额 <system:CurrencyForRate value="${gc.remainedAmt}" />
													</a>
												</ul>
											</c:forEach>
									</div>
								</c:if>-${appConfig.defaultCurrencySymbol}
	              <span id="giftPay">${shoppingcart.giftCertificateNos == null ? '0.00' : fn:substringAfter(shoppingcart.giftCertificateNos,':')}</span></li></span>
                        <c:if test="${checkHaveJuankong==1}">
                        <li><input name="juankongPayNo" id="juankongPayNo" type="text" placeholder="输入卷控验证码"  onblur="fnjuankongPay();" 
                        	value=""  autocomplete="off" />-${appConfig.defaultCurrencySymbol}
			              <span id="juankongPay">
					           <!--     ${shoppingcart.giftCertificateNos == null ? '0.00' : fn:substringAfter(shoppingcart.giftCertificateNos,':')}-->
					           0.00
			              </span></li>
			              </c:if>
                        <li><select id="selectbasic" name="selectbasic" onchange="fnSelectChangeGift(this.value);">
                      <option class="select_title" value="0">您本次可使用积分</option>
                      <c:forEach begin="100" end="${shopPoint.total}" step="100" var="point">
						<option value="${point}" <c:if test="${shoppingcart.shopPoint==point }">selected</c:if>>${point}</option>
					 </c:forEach>
                    </select>
	              <span id="shopPointMoney" style="display:none">${shoppingcart.shopPoint == null ? '0.00' : shoppingcart.shopPoint * appConfig.shopPointUseGiftPercent }</span></li>
                    </ul>
                    <p><b>共计：${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_sum">${shoppingcart.subtotal}</span></b></p>
                    <p><a href="javascript:void(0);" onclick="javascript:window.location.href='${ctxPath}/checkout/login.html';">
	                确认购买
                	</a></p>
                </div>
            </div>
		</div>
		<input type="hidden" value="" name="doAction" id="doAction"/>
		<input type="hidden" value="" name="selected_sku" id="selected_sku"/>
		<input type="hidden" value="" name="selected_itemId" id="selected_itemId"/>
		<input type="hidden" value="${referer}" name="referer" />
		<input type="hidden" id="cart_sum_prev" value="${shoppingcart.subtotal}" />
		</form>
        <%@ include file="../../decorators/include/footerNew.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
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
					var H = $(window).height()
					$(".w-404").height(H)
					window.onresize=function(){
							var H = $(window).height()
							$(".w-404").height(H)
						}
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
        $(document).ready(function () {
	  		  debugger;
	  		  if(!${useAbled}){
	  				$("#couponNo_input_id").attr("disabled",true);
	  				$("#giftCertificateNo").attr("disabled",true);
	  			}
	  			fnUpdatePrice();
	  			if(${fullCutPrice==0}){
	  				document.getElementById("full_cut").style.display="none";
	  			}
	  	  });
	        
        	$(function(){
					$(window).scroll(function(){
						$(".index-nav").addClass("w-nav-s")
					})
				})
				
		
        </script>
	</body>

</html>