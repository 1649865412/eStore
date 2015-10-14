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
        <link href="${resPath}/styles/css/order-edit.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/checkout/jquery.tools_side_menu.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/checkout/checkoutPagingManager.js"></script>
        <script>
		  $(document).ready(function () {
			  debugger;
	
			  if(${flag=='already'}){
				  alert("你的账号已享受过面膜优惠或去我的账号里继续支付,该订单不享受优惠噢");
			  }
	
			//$(":range").rangeinput({progress: true});
	
				
				/* Slide Toogle */
				$(".checkout_title").click(function()
				{
					var arrow = $(this).find("i.updown");
	
					if(arrow.hasClass("fa-chevron-up"))
					{
						arrow.removeClass("fa-chevron-up");
						arrow.addClass("fa-chevron-down");
						$(this).parent().find(".current_infowtool").show();
						$(this).parent().find(".checkout_list").hide();
					}
					else if(arrow.hasClass("fa-chevron-down"))
					{
						arrow.removeClass("fa-chevron-down");
						arrow.addClass("fa-chevron-up");
						$(this).parent().find(".current_infowtool").hide();
						$(this).parent().find(".checkout_list").show();
					}
	
					
				});
				
				$("#personal_tool").click(function()
				{
					var arrow = $(this).parents().find("#user_info_title i.updown");
	
					if(arrow.hasClass("fa-chevron-up"))
					{
						arrow.removeClass("fa-chevron-up");
						arrow.addClass("fa-chevron-down");
						$(this).parents().find("#current_user_info").show();
						$(this).parents().find("#user_info_list").hide();
					}
					else if(arrow.hasClass("fa-chevron-down"))
					{
						arrow.removeClass("fa-chevron-down");
						arrow.addClass("fa-chevron-up");
						$(this).parents().find("#current_user_info").hide();
						$(this).parents().find("#current_user_info_no").hide();
						$(this).parents().find("#user_info_list").show();
					}
	
					
				});
				$("#personal_checked .fa-times").click(function()
				{
					 //$("#current_address").remove();
					 //document.getElementById('radios-0').checked=true;
					 //$("#personal_userinfo").show();
				});
				
				
				$("#radios-a").click(function()
				{
					$(this).parents().find("#personal_userinfo").show();
					$(this).parents().find("#personal_userinfo_update").hide();
				});
				
				
				$("#delivery_time_tool").click(function()
				{
					var arrow = $(this).parents().find("#delivery_time_title i.updown");
	
					if(arrow.hasClass("fa-chevron-up"))
					{
						arrow.removeClass("fa-chevron-up");
						arrow.addClass("fa-chevron-down");
						$(this).parents().find("#current_delivery_time").show();
						$(this).parents().find("#delivery_time_list").hide();
					}
					else if(arrow.hasClass("fa-chevron-down"))
					{
						arrow.removeClass("fa-chevron-down");
						arrow.addClass("fa-chevron-up");
						$(this).parents().find("#current_delivery_time").hide();
						$(this).parents().find("#delivery_time_list").show();
					}
	
					
				});
				
				$("#pay_methods_tool").click(function()
				{
					var arrow = $(this).parents().find("#pay_methods_title i.updown");
	
					if(arrow.hasClass("fa-chevron-up"))
					{
						arrow.removeClass("fa-chevron-up");
						arrow.addClass("fa-chevron-down");
						$(this).parents().find("#current_pay_methods").show();
						$(this).parents().find("#pay_methods_list").hide();
					}
					else if(arrow.hasClass("fa-chevron-down"))
					{
						arrow.removeClass("fa-chevron-down");
						arrow.addClass("fa-chevron-up");
						$(this).parents().find("#current_pay_methods").hide();
						$(this).parents().find("#pay_methods_list").show();
					}
	
					
				});
				fnUpdatePrice;
				
		});

      </script>


       <!--placeholder for IE 8-->
	  <script type="text/javascript">   
		var _placeholderSupport = function() {
			var t = document.createElement("input");
			t.type = "text";
			return (typeof t.placeholder !== "undefined");
		}();
		
		window.onload = function() {
			var arrInputs = document.getElementsByTagName("input");
			for (var i = 0; i < arrInputs.length; i++) {
				var curInput = arrInputs[i];
				if (!curInput.type || curInput.type == "" || curInput.type == "text")
					HandlePlaceholder(curInput);
			}
		};
		 
		function HandlePlaceholder(oTextbox) {
			if (!_placeholderSupport) {
				var curPlaceholder = oTextbox.getAttribute("placeholder");
				if (curPlaceholder && curPlaceholder.length > 0) {
					oTextbox.value = curPlaceholder;
					oTextbox.setAttribute("old_color", oTextbox.style.color);
					oTextbox.style.color = "#c0c0c0";
					oTextbox.onfocus = function() {
						this.style.color = this.getAttribute("old_color");
						if (this.value === curPlaceholder)
							this.value = "";
					};
					oTextbox.onblur = function() {
						if (this.value === "") {
							this.style.color = "#c0c0c0";
							this.value = curPlaceholder;
						}
					}
				}
			}
		}
      </script>
			<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>

	<body>
        <!--[if lt IE 8]>
       <p class="browserupgrade">你正在使用一个 <strong>过时的</strong> 浏览器. 请 <a href="http://browsehappy.com/">提高您的浏览器</a> 以提高您的经验.</p>
       <![endif]-->
		<!--登陆注册-->
		<%@ include file="../../decorators/include/headerNew.jspf"%>
			<div class="w-menush visible-sm-block visible-xs-block">
				<ul class="w-menush-items list-unstyled">
					<li><a href="#"><span class="w-menu-on">商城</span></a>
					</li>
					<li><a href="list.html"><span>文化资讯</span></a>
					</li>
					<li><a href="#"><span>设计师</span></a>
					</li>
					<li><a href="#"><span>关于我们</span></a>
					</li>
					<li>
						<a href="#"><span>线下店铺</span></a>
					</li>
					<li>
						<a href="javascript:void(0)"><span class="w-menu-lr">登录/</span><span class="w-menu-lrzc">注册</span></a>
					</li>
					<li>
						<a href="#"><span>搜索</span></a>
					</li>
				</ul>
			</div>
		</div>
        <!--end of 导航-->
        <!--主体内容开始-->

		<div class="m-order-tit clearfix">
        	<span class="step-1 current">1 收货人信息</span>
            <span class="step-2">2 快递配送&付款方式</span>
            <span class="step-3">3 商品信息&确认</span>
        </div>
		<div class="w-order-edit row">
		<form id="form1" action="${ctxPath}/checkout/paymentProcess.html" method="post" > 
        	<div class="order-edit-item item1 current">
                <div class="order-edit-tit">1 收货人信息</div>
                <div class="new-add">
                        <ul>
                            <li>
                                <p><label>姓名*</label></p>
                                <p><input class="span12" type="text" value="" name="firstname" id="firstname" /></p>
                                <p class="new-add-tips">*姓名不能为空</p>
                            </li>
                            <li>
                                <p><label class="city">省份*</label><label class="province">城市*</label><label class="yb">区县*</label></p>
                                <p>
                                    <select id="s_province" name="stateName" class="city-select"></select>
                                    <select id="s_city" name="cityName" class="province-select"></select>
                                    <select id="s_county" name="sectionName" class="span12"></select>	
                                </p>
                                <p class="new-add-tips">*请选择城市</p>
                            </li>
                            <li>
                                <p><label>邮编</label></p>
                                <p><input class="span12" type="text" value="" name="zip" id="zip" /> </p>
                            </li>
                            <li>
                                <p><label>地址*</label></p>
                                <p><input class="span12" type="text" value="" name="address" id="address" /></p>
                                <p class="new-add-tips">*地址不能为空</p>
                            </li>
                            <li>
                                <p><label>电话*</label></p>
                                <p><input class="span12" type="text" value="" name="phone" id="phone" /></p>
                                <p class="new-add-tips">*电话号码不能为空</p>
                            </li>
                            <li><label><input name="" type="checkbox" value="">并设置为默认地址</label></li>
                            <li><a  href="javascript:;" id="buttonsave_info" name="buttonsave_info" class="next" onclick="addAddress();">保存</a></li>
                            <li><a href="javascript:;" class="history_address">选择以往历史地址</a><i>>></i></li>
                        </ul>
                </div>
                <div class="address-list">
                    <div class="address-list-box">
                    	<c:forEach items="${shippingAddressList}" var="address" varStatus="status">
                    		<dl class="row" for="radios-${address.id }" id="current_address_${address.id }">
	                            <dt><input type="radio" name="shippingAddressId" id="radios-${address.id }" value="${address.id }"  <c:if test="${status.index == 0 }">checked="checked"</c:if> onchange="addressChange();"></dt>
	                            <dd>
	                                <p><span>收件人：</span><em>${address.firstname }</em></p>
	                                <p><span>收货地址：</span><em>${address.stateName }${address.cityName }${address.sectionName }${address.address }</em></p>
	                                <p><span>联系电话：</span><em>${address.telephone }</em></p>
	                            </dd>
	                        </dl>
	                	</c:forEach>
                       
                    </div>
                    <div class="more-address"><a href="javascript:;">使用其他地址</a><p><span><i class="fa fa-angle-double-down"></i></span></p></div>
                    <div class="add-address-btn"><a href="javascript:;">+点击新增地址</a></div>
                    <div class="the-next"><a href="javascript:;" class="next">下一步</a></div>
                </div>
                <div class="edit-btn"><a href="#">编辑</a></div>
                <div class="item-mask"></div>
            </div>
            <div class="order-edit-item item2">
            	<div class="order-edit-tit">2 快递配送&付款方式</div>
                <ul>
                	<%--<li>
                    	<p><b>快递公司</b></p>
                        <p>
                            <label><input type="radio" name="RadioGroup1" value="快递名称" id="RadioGroup1_0"><img src="img/pic16.jpg"></label>
                            <label><input type="radio" name="RadioGroup1" value="快递名称" id="RadioGroup1_1"><img src="img/pic16.jpg"></label>
                        </p>
                    </li>
                    <li>
                    	<p>给快递公司的留言(如送货特殊要求）</p>
                        <p><input name="" type="text" class="ask"></p>
                    </li>
                    --%>
                    <li>
                    	<p><b>付款方式</b></p>
                        <p>
                            <label><input type="radio" name="payType" id="radios-e" value="online" checked="checked">在线付款</label>
                            <c:if test="${shoppingcart.total > 128}">
                            	<label><input type="radio" name="payType" id="radios-f" value="cod">货到付款</label>
                            </c:if>
                            <label><input type="radio" name="payType" id="radios-g" value="transfer">对公转账</label>
                        </p>
                    </li>
                    <li>
                    	<p>给四方街的留言</p>
                        <p><input name="" type="text" class="ask"></p>
                    </li>
                    <li><a href="javascript:;" class="next">下一步</a></li>
                </ul>
            	
                <div class="edit-btn"><a href="#">编辑</a></div>
                <div class="item-mask"></div>
            </div>
            <div class="order-edit-item item3">
            	<div class="order-edit-tit">3 商品信息&确认</div>
                <div class="item3-content">
                    <div class="show-hide"><i class="fa fa-plus-square-o"></i>展开详细信息</div>
                    <div class="pro-show-hide">
                        <ul class="row">
                        	<c:choose>
								<c:when test="${shoppingcart==null || shoppingcart.buyNowItemsCount==0}">
								    <tr>
										<td colspan="6">
											<br/>&nbsp;<fmt:message key="shoppingcart.message.isEmpty" />
										</td>
									</tr>
								</c:when>
								<c:otherwise>
						            <%-- 商品开始 --%>
									<c:forEach items="${shoppingcart.cartItems}" var="item" varStatus="varStatus">
										<c:if test="${item.isSaved==0 and empty item.parent}">
											<li>
				                                <dl class="row">
				                                    <dt><img src="${mediaPath}product/v/${item.productSku.product.defaultProductSku.image}" width="65" /></dt>
				                                    <dd>
				                                        <p>${item.productSku.product.productName}</p>
				                                        <p>产品编码：${item.productSku.productSkuCode}</p>
				                                        <p><product:showSkuOptions productSkuId="${item.productSku.productSkuId}"></product:showSkuOptions></p>
				                                    </dd>
				                                </dl>
				                            </li>
										</c:if>
									</c:forEach>
								  <%-- 商品结束 --%>
								</c:otherwise>
							</c:choose>
                           
                        </ul>
                        <%--<div class="page"><a href="#" class="current">1</a><a href="#">2</a></div>
                    --%></div>
                    
                    <div class="item3-bottom">
                        <p><b>￥<span id="cart_total">${shoppingcart.subtotal }</span></b>${shoppingcart.buyNowItemsCount }件物品</p>
                        <p><b>￥<span id="shippingRate">0.00</span></b>运费</p>
                        <p><b>￥<span id="discount">0.00</span></b>减免</p>
                        <p>（发货时间请留意产品详情页面提示，具体到货时间以快递公司物流信息为准）</p>
                        <h3><b>￥<span id="cart_sum">${shoppingcart.total}</span></b>总计</h3>
                    </div>
                    <div class="the-big-bth">
	                    <button id="button2id" name="button2id" class="btn" type="button" onclick="checkAddress();">
	                      确认提交
		                </button>
                    </div>
                    <input type="hidden" name="doAction" value="doCK"/>
                </div>
                <div class="edit-btn"><a href="#">编辑</a></div>
            	<div class="item-mask"></div>
            </div>
            
            <div style="display: none;">
				<c:forEach items="${shippingRateList}" var="shippingRate" varStatus="varStatus">
					<div class="left" style="margin-left:10px;"><input type="radio" value="${shippingRate.shippingRateId},${shippingRate.shippingMethod.shippingMethodId}" name="shippingMethodId"<c:if test="${varStatus.first}"> checked="checked"</c:if>/>
						<input type="hidden" id="cartShipping_${shippingRate.shippingMethod.shippingMethodId}" value="${shippingRate.cartShipping}"/></div>
					<div class="left"><label>${shippingRate.shippingMethod.shippingMethodName}</label></div>
				</c:forEach>
				<textarea name="orderNote" id="orderNote" rows="4" cols="150" style="border:1px solid #ccc;"></textarea>
		       </div>
        </form>
        </div>
        
        
        <div style="display: none;">
            <table width="280" border="0" cellspacing="0" cellpadding="0" align="right" class="table-total">
                <tr id="wrap_tr" style="display: none;">
                  <th class="f13px">包装费:</th>
                  <td class="f13px red fB">${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_wrap">0.00</span></td>
                </tr>
                <tr id="shipping_tr" style="display: none;">
                  <th class="f13px">运费:</th>
                  <td class="f13px red fB">${appConfig.defaultCurrencySymbol}&nbsp;
                  	<span id="cart_shipping">
                  		<c:choose>
                  			<c:when test="${not empty shippingRateList}">
                  				<c:forEach items="${shippingRateList}" var="shippingRate" end="0">
                  					${shippingRate.basePrice }
                  				</c:forEach>
                  			</c:when>
                  			<c:otherwise>
                  				0.00
                  			</c:otherwise>
                  		</c:choose>
                  	</span>
                  </td>
                </tr>
                <tr id="tax_tr" style="display: none;">
                  <th class="f13px"><fmt:message key="shoppingcart.taxAmt" />:</th>
                  <td class="f13px red fB">${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_tax">0.00</span></td>
                </tr>
                <tr id="save_tr"  style="display: block">
                  <th class="f13px"><fmt:message key="shoppingcart.discount" />:</th>
                  <td class="f13px red fB">-${appConfig.defaultCurrencySymbol}&nbsp;<span id="save">${shoppingcart.cartDiscountAmount == null ? 0.00 : shoppingcart.cartDiscountAmount}</span></td>
                </tr>
                <tr id="full_tr"  style="display: block">
                  <th class="f13px"><fmt:message key="shoppingcart.fullCutSum" />:</th>
                  <td class="f13px red fB">-${appConfig.defaultCurrencySymbol}&nbsp;<span id="full_cut">${shoppingcart.fullCutSum == null ? 0.00 : shoppingcart.fullCutSum}</span></td>
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
                  <td class="f13px red fB"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:right; padding:0 20px 20px 0;">
                    <div class="place"><input type="image" src="${resPath}/images/btn/btn_gotopay.jpg"/></div>
                    </td>
                </tr>
            </table>
        </div>
        
    <div id="newAddressTemp" style="display: none;">
    <div>
     <br/><br/>
     </div>
     <label class="radio" for="radios-{0}" id="current_address_{0}">
       <input type="radio" name="shippingAddressId" id="radios-{0}" value="{0}"  onchange="addressChange();"  checked="checked"/>
       <div class="current_checked" id="personal_checked">
          <div class="current_info_col">
            <div class="current_info_t">收货人（Name):</div>
            <div class="current_info_c current_address_firstname">{1}</div>
          </div>
          <div class="current_info_col">
            <div class="current_info_t">地址 (Address)：</div>
            <div class="current_info_c">
             <span class="current_address_address">{2}{3}{4}{5}</span>
            <span class="colour_trash padding_left20">
            	<a href="javascript:void(0);" onclick="editAddress(this,{0});">
             	 <i class="fa fa-pencil-square-o fa-lg"></i>
              </a>
              <a href="javascript:void(0);" onclick="delAddress(this,{0})">
            	  <i class="fa fa-times fa-lg"></i> 
              </a>
            </span>
            </div>
          </div>
          <div class="current_info_col">
            <div class="current_info_t">联系电话 (Phone)：</div>
            <div class="current_info_c current_address_telephone">{6}</div>
          </div>
        </div><!--current_checked-->
   	 </label>
   	 <div>
   	 	<br/><br/>
   	 </div>
  	</div>
  	
  	<div  id="personal_userinfo_update_temp" style="display: none;">
  		<div id="update_address_base_temp">
	  		<input type="hidden" value="{0}" name="addressId" id="addressId"/>
	       <div class="span6 margin_left50">
	        <div class="control-group">
	           <label for="first_name" class="control-label">
	           收货人
	           <span class="text-error">*</span>
	           </label>
	               <input class="span12" type="text" value="{1}" name="firstname_u" id="firstname_u" />
	        </div>
	        <div class="control-group">
	            <label for="postcode" class="control-label">
	           邮政编码
	           <span class="text-error">*</span>
	           </label>
	               <input class="span12" type="text" value="{2}" name="zip_u" id="zip_u" /> 
	        </div>
	        <div class="control-group">
	           <label for="email" class="control-label">
	           电子邮件
	           <span class="text-error">*</span>
	           </label>
	               <input class="span12" type="text" value="{3}" name="email_u" id="email_u" />
	        </div>
	        <div class="control-group">
	           <label for="phone" class="control-label">
	           联系电话
	           <span class="text-error">*</span>
	           </label>
	               <input class="span12" type="text" value="{4}" name="telephone_u" id="telephone_u" />
	        </div>
	       </div><!--span6-->
	       <div class="span6">
	       <div class="control-group">
	         
	           <label for="last_name" class="control-label">
	           地址
	           <span class="text-error">*</span>
	           </label>
	               <input class="span12" type="text" value="{5}" name="address_u" id="address_u" />
	        </div>
	        </div>
        
        </div>
      
	      <div class="span6 margin_left10 margin_TD20">
	        <button id="buttonsave_info" name="buttonsave_info" class="btn btn-gold infor_form_button" type="button" onclick="updateAddress();">
	         <i class="fa fa-floppy-o padding_right10"></i>
	         保存
	        </button>
	        <button id="clearbutton_info" name="clearbutton_info" class="btn btn-black infor_form_button" type="button" onclick="resetAddress(this);">
	         <i class="fa fa-undo padding_right10"></i>
	         清除
	        </button>
	        
	      </div>
     </div><!--new_info_form-->
        
		<!--主体内容结束-->
		<%@ include file="../../decorators/include/footerNew.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<!--省市三级联动-->
    <script class="resources library" src="${ctxPath}/scripts/cartmatic/cart/checkout/area.js" type="text/javascript"></script>
	  <script type="text/javascript">
		  _init_area();
	  </script>
    <!--end of 省市三级联动-->
  	
  	<script type="text/javascript">

	var edit_address_id ;

  	//删除收货人信息
  	function delAddress(obj,id){
  	  	if(confirm('是否要删除此收货人信息')){
	  	  	var url = "/checkout/address/delete/" + id + ".html";  
	  	  	$.post(__ctxPath+url,
		 			{
							id:id
						},
		 			function(result){
				 			var $this = $(obj);
				 			var $label = $this.parents("label");
				 			var $nextDiv = $label.next();
				 			//var $prevDiv = $label.prev();
				 			$nextDiv.remove();
				 			//$prevDiv.remove();
				 			$label.remove();
	    	 		},
	    	 		"json"
	    	 	);
  	  	}
  	}

  //增加新收货人信息
    function addAddress(){
  	 	var firstname = $("#firstname").val().trim();
  	 	var address = $("#address").val().trim();
  	 	var zip = $("#zip").val().trim();
  	 	var email = "";
  	 	var telephone = $("#phone").val().trim();
  	 	var stateName = $("#s_province").val().trim();
  	 	var cityName = $("#s_city").val().trim();
  	 	var sectionName = $("#s_county").val().trim();
  	 	var title = "先生";
         var tag =true;
  	 	if(firstname ==null || firstname ==""){
                alert("名字不能为空");
                tag =false;
  		 	}
  	 	else if(telephone ==null || telephone ==""){
  	 		  alert("电话不能为空");
  	 		 tag =false;
  	 	}
  	 	else if(address ==null || address ==""){
  	 		  alert("地址不能为空");
  	 		 tag =false;
  		 	}
  		if(tag){
  	 		$.post("/checkout/address/addAjax.html",
  	   	 			{
  							firstname:firstname,
  							address:address,
  							zip:zip,
  							email:email,
  							telephone:telephone,
  							stateName:stateName,
  							cityName:cityName,
  							sectionName:sectionName,
  							title:title
  						},
  	   	 			function(result){
  	       	 			if(result != null){
  	           	 			var ss = format_params($("#newAddressTemp").html(), result.id, result.firstname, result.stateName, result.cityName, result.sectionName, result.address, result.telephone);
  	           	 			var $label = $("#radios-a").parent("label");
  	           	 			$(ss).insertBefore($label); 
  		           	 		var $nifDiv = $label.next();
  		           			$nifDiv.find("input").val("");		
  		           			$nifDiv.find("select").each(function(){
  		           				$(this).find("option:first").attr("selected",true);
  		           			});
  	       	 			}else{
  	           	 			alert("保存新地址有误！");
  	       	 			}
  	       	 		},
  	       	 		"json"
  	       	 	);
  	 		window.location.href="/checkout/paymentProcess.html"; 
  		 	}
   	}

  //编辑收货人信息
	function editAddress(obj,id){
		edit_address_id = id;
		$.post(__ctxPath+"/checkout/address/edit.html",
  	 			{
 					addressId:id
				},
  	 			function(result){
      	 			if(result != null){
          	 			var s_base = format_params($("#update_address_base_temp").html(), result.id, result.firstname, result.zip, result.email, result.telephone, result.address);
          	 			//var s_more = format_params($("#update_address_more_temp").html(), result.stateName, result.cityName, result.sectionName, result.title);
						var $pi = $("#personal_userinfo_update");
						$("#update_address_base").html(s_base);
						//$("#update_address_more").html(s_more);
						$pi.show();
						$("#personal_userinfo").hide();
						$("#radios-" + id).attr("checked",true);
						$("select[name='stateName_u'] option").each(function(){
							if($(this).val().indexOf($.trim(result.stateName))>=0){
								$(this).attr("selected",true);
								change_u(1);
								return false;
							}
						});
						$("select[name='cityName_u'] option").each(function(){
							if($(this).val().indexOf($.trim(result.cityName)) >= 0){
								$(this).attr("selected",true);
								change_u(2);
								return false;
							}
						});
						$("select[name='sectionName_u'] option").each(function(){
							if($(this).val().indexOf($.trim(result.sectionName)) >= 0 ){
								$(this).attr("selected",true);
								return false;
							}
						});
						$("select[name='title_u'] option").each(function(){
							if($(this).val() == result.title){
								$(this).attr("selected",true);
								return false;
							}
						});
      	 			}else{
          	 			alert("此地址有误！");
      	 			}
      	 		},
      	 		"json"
      	 	);
	}

	  //更新收货人信息
	  function updateAddress(){
	  	var addressId = $("#addressId").val();
	 	var firstname = $("#firstname_u").val();
	 	var address = $("#address_u").val();
	 	var zip = $("#zip_u").val();
	 	var email = $("#email_u").val();
	 	var telephone = $("#telephone_u").val();
	 	var stateName = $("#s_province_u").val();
	 	var cityName = $("#s_city_u").val();
	 	var sectionName = $("#s_county_u").val();
	 	var title = $("#title_u").val();
		$.post(__ctxPath+"/checkout/address/addAjax.html",
	  	 			{
	 					addressId:addressId,
						firstname:firstname,
						address:address,
						zip:zip,
						email:email,
						telephone:telephone,
						stateName:stateName,
						cityName:cityName,
						sectionName:sectionName,
						title:title
					},
	  	 			function(result){
	      	 			if(result != null){
		      	 			var $label = $("#current_address_" + edit_address_id);
		      	 			$label.find(".current_address_firstname").html(result.firstname);
		      	 			$label.find(".current_address_address").html(result.stateName + result.cityName + result.sectionName);
		      	 			$label.find(".current_address_telephone").html(result.telephone);
		      	 			var $pi = $("#personal_userinfo_update");
		      	 			$pi.hide();
	      	 			}else{
		      	 			alert("更新地址有误！");
	      	 			}
	      	 		},
	      	 		"json"
	      	 	);
 	}
	//重置收货人信息
	function resetAddress(obj){
		var $nifDiv = $(obj).parents(".new_info_form");
		$nifDiv.find("input").val("");		
		$nifDiv.find("select").each(function(){
			$(this).find("option:first").attr("selected",true);
		});
	}
	//改变配送时间
	function changeDeliveryTime(){
		var dt = $("input:radio[name='deliveryTime']:checked").val();
		switch(dt){
		case "wd"://只限工作日送货
			$("#delivery_time_msg").html("只限工作日送货");
			break;
		case "wk_hd"://只限双休日、假日送货
			$("#delivery_time_msg").html("只限双休日、假日送货");
			break;
		case "wd_wk_hd"://工作日、双休日或假日均可送货
			$("#delivery_time_msg").html("工作日、双休日或假日均可送货");
			break;
		}
		$("#current_delivery_time").show();
		$("#delivery_time_list").hide();
	}
	//重置配送时间
	function resetDeliveryTime(){
		$("input:radio[name='deliveryTime']:first").attr("checked",true);
		$("#delivery_time_msg").html("只限工作日送货");
		
	}
	//改变支付方式
	function changePayMethod(){
		var pt = $("input:radio[name='payType']:checked").val();
		switch(pt){
		case "online":
			$("#pay_method_msg").html("在线付款");
			break;
		case "cod":
			$("#pay_method_msg").html("货到付款");
			break;
		case "transfer":
			$("#pay_method_msg").html("对公转账");
			break;
		}
		$("#current_pay_methods").show();
		$("#pay_methods_list").hide();
	}

	//重置支付方式
	function resetPayMethod(){
		$("input:radio[name='payType']:first").attr("checked",true);
		$("#pay_method_msg").html("在线付款");
	}

	  //收货人信息修改后 改变表头收货人信息
	  function addressChange(){
		  var id = $("input:radio[name='shippingAddressId']:checked").val();
		  var $label = $("#current_address_" + id);
		  var firstname = $label.find(".current_address_firstname").html();
		  var address = $label.find(".current_address_address").html();
		  var telephone = $label.find(".current_address_telephone").html();
		  var $div = $("#current_user_info");
		  
		  $div.find(".current_address_firstname").html(firstname);
		  $div.find(".current_address_address").html(address);
		  $div.find(".current_address_telephone").html(telephone);
		  
		  if(${shippingAddressList==null || fn:length(shippingAddressList) <= 0}){
			  $div.find(".current_address_firstname_title").html("收货人（Name):");
			  $div.find(".current_address_address_title").html("地址 (Address)：");
			  $div.find(".current_address_telephone_title").html("联系电话 (Phone)：");
		  }
	  }

	  function checkAddress(){
		  var id = $("input:radio[name='shippingAddressId']:checked").val();
		  if(id.indexOf("{")>-1){
			  alert("请填写或者选择您的收货人信息！");
			  return ;
		  }else{
			  $("#form1").submit();
		  }
	  }
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
        
        <!-------表单1填写地址JS----->
        <script type="text/javascript">
			$(function(){
					$(".more-address").click(function(){
						$(".address-list-box").css("height","auto")
						if($(this).hasClass("active")){
							$(this).removeClass("active")
							$(".address-list-box").css("height","390px")
							$(this).find("a").text("使用其他地址")
						}else{
							$(".address-list-box").css("height","auto")
							$(this).addClass("active")
							$(this).find("a").text("收起")
							}
					})
					$(".add-address-btn a").click(function(){
							$(".new-add").fadeIn()
							$(".address-list").hide()
						})
					$(".new-add li a.history_address").click(function(){
							$(".new-add").hide()
							$(".address-list").fadeIn()
						})
					$(".show-hide").click(function(){
						if($("i",this).hasClass("fa-plus-square-o")){
							$("i",this).removeClass("fa-plus-square-o").addClass("fa-minus-square-o")
							$(".pro-show-hide").addClass("active")
							$(".pro-show-hide .page").addClass("pageshow")
						}else{
							$("i",this).addClass("fa-plus-square-o").removeClass("fa-minus-square-o")
							$(".pro-show-hide").removeClass("active")
							$(".pro-show-hide .page").removeClass("pageshow")
						}
					})
				})
        </script>
        
        <!-------表单下一步JS----->
        <script type="text/javascript">
        	$(function(){
					
					if($(window).width()>992){
						
						$(".item1 .the-next a").click(function(){
							$(this).parentsUntil("order-edit-item").removeClass("current")
							$(".item2").addClass("current").show()
						})
							
						$(".item2 ul li a.next").click(function(){
							$(this).parentsUntil("order-edit-item").removeClass("current")
							$(".item3").addClass("current").show()
						})
						
						$(".order-edit-item .edit-btn").click(function(){
							$(this).parent().addClass("current").siblings().removeClass("current")
						})
					}else{
							$(".item1 .the-next a").click(function(){
								$(this).parentsUntil("order-edit-item").removeClass("current")
								$(".item1").hide()
								$(".item2").addClass("current").fadeIn()
								$(".step-1").removeClass("current")
								$(".step-2").addClass("current")
							})
								
							$(".item2 ul li a.next").click(function(){
								$(this).parentsUntil("order-edit-item").removeClass("current")
								$(".item2").removeClass("current").hide()
								$(".item3").addClass("current").fadeIn()
								$(".step-2").removeClass("current")
								$(".step-3").addClass("current")
							})
							
							$(".order-edit-item .edit-btn").click(function(){
								$(this).parent().addClass("current").siblings().removeClass("current")
							})
						}
					
				})
        </script>
        
        <!----------手机版上一步下一步------->
        <script type="text/javascript">
        	$(function(){
					$(".step-1").click(function(){
						$(this).addClass("current").siblings().removeClass("current")
						$(".item1").fadeIn().addClass("current").siblings().fadeOut().removeClass("current")
					})
					$(".step-2").click(function(){
						$(this).addClass("current").siblings().removeClass("current")
						$(".item2").fadeIn().addClass("current").siblings().fadeOut().removeClass("current")
					})
					$(".step-3").click(function(){
						$(this).addClass("current").siblings().removeClass("current")
						$(".item3").fadeIn().addClass("current").siblings().fadeOut().removeClass("current")
					})
				})
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