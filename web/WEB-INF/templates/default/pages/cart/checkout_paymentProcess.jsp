<%@ include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>

<link href="${resPath}/styles/head_foot.css" rel="stylesheet" type="text/css" />
<link href="${resPath}/styles/nav.css" rel="stylesheet" type="text/css" />
<link href="${resPath}/styles/main.css" rel="stylesheet" type="text/css" />
<link href="${resPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
<link href="${resPath }/styles/chart.css" rel="stylesheet" type="text/css" />
<link href="${resPath }/styles/checkout.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/checkout/jquery.tools_side_menu.js"></script>

<script>
	  $(document).ready(function () {
		  debugger;

		  if(${flag=='already'}){
			  alert("你的账号已享受过面膜优惠或去我的账号里继续支付,该订单不享受优惠噢");
		  }

		$(":range").rangeinput({progress: true});

			
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

<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/checkout/checkoutPagingManager.js"></script>

<div class="maincontent" id="designer_main">
     <div class="chart_top">
       <div class="chart_t_left">
         <p class="chart_title">核对订单信息</p>
       </div><!--chart_t_left-->
       <div class="chart_t_right">
         <img src="${resPath }/images/cart/step2.png"/>
       </div><!--chart_t_right-->
     </div><!--chart_top-->
     
     <form id="form1" action="${ctxPath}/checkout/paymentProcess.html" method="post" > 
     
     <div class="chart_bottom">
     
       <!-- 收货人信息 -->
       <div class="checkout_info">
       
         <div class="checkout_title margin_bottom20" id="user_info_title">
           <p><i class="fa fa-map-marker fa-2x margin_LR14"></i><span>收货人信息</span><i class="fa fa-chevron-down fa-18px right margin_LR10 updown"></i></p>
         </div><!--checkout_title-->
         
         <c:if test="${shippingAddressList != null && fn:length(shippingAddressList) > 0}">
         
	         <div class="current_infowtool" id="current_user_info">
	           <div class="current_info">
	             <div class="current_info_col">
	               <div class="current_info_t">收货人（Name)：</div>
	               <div class="current_info_c current_address_firstname">${shippingAddressList[0].firstname}</div>
	             </div>
	             <div class="current_info_col">
	               <div class="current_info_t">地址 (Address)：</div>
	               <div class="current_info_c">
	              	 <span class="current_address_address">
	              	 	${shippingAddressList[0].stateName}${shippingAddressList[0].cityName}${shippingAddressList[0].sectionName}${shippingAddressList[0].address}
	              	 </span>
	               </div>
	             </div>
	             <div class="current_info_col">
	               <div class="current_info_t">联系电话 (Phone)：</div>
	               <div class="current_info_c current_address_telephone">${shippingAddressList[0].telephone}</div>
	             </div>
	           </div><!--current_info-->
	           <div class="current_info_toolbar">
	             <div class="colour_trash change_tool margin_top15" id="personal_tool">
	               <i class="fa fa-pencil-square-o fa-2x change_it"></i>
	             </div><!--change_tool-->
	           </div><!--current_info_toolbar-->
	         </div><!--current_infowtool-->
	         
	         <div class="checkout_list margin_TD20" id="user_info_list">
	           <div class="info_form">
	
	              <!-- Multiple Radios -->
	              <div class="control-group">
	                <div class="controls">
	                	<c:forEach items="${shippingAddressList}" var="address" varStatus="status">
		                	<label class="radio" for="radios-${address.id }" id="current_address_${address.id }">
			                    <input type="radio" name="shippingAddressId" id="radios-${address.id }" value="${address.id }"  <c:if test="${status.index == 0 }">checked="checked"</c:if> onchange="addressChange();">
			                    <div class="current_checked" id="personal_checked">
			                       <div class="current_info_col">
			                         <div class="current_info_t">收货人（Name)：</div>
			                         <div class="current_info_c current_address_firstname">${address.firstname }</div>
			                       </div>
			                       <div class="current_info_col">
			                         <div class="current_info_t">地址 (Address)：</div>
			                         <div class="current_info_c">
			                         <span class="current_address_address">${address.stateName }${address.cityName }${address.sectionName }${address.address }</span>
			                         <span class="colour_trash padding_left20">
			                       	 	<a href="javascript:void(0);" onclick="editAddress(this,${address.id });">
			                           		<i class="fa fa-pencil-square-o fa-lg"></i>
			                           </a>
			                           <a href="javascript:void(0);" onclick="delAddress(this,${address.id });">
			                         	  <i class="fa fa-times fa-lg"></i> 
			                           </a>
			                         </span>
			                         </div>
			                       </div>
			                       <div class="current_info_col">
			                         <div class="current_info_t">联系电话 (Phone)：</div>
			                         <div class="current_info_c current_address_telephone">${address.telephone }</div>
			                       </div>
			                     </div><!--current_checked-->
		                 	 </label>
		                 	 <div>
			                 	 <c:if test="${fn:length(shippingAddressList) > 1 && status.index < fn:length(shippingAddressList) - 1}">
			                 	 	<br/><br/><br/>
			                 	 </c:if>
			                 	 <c:if test="${status.index == fn:length(shippingAddressList) - 1}">
			                 	 	<br/>
			                 	 </c:if>
		                 	 </div>
	                	</c:forEach>
	                	
	                  <label class="radio"  for="radios-a">
	                    <input type="radio" name="shippingAddressId" id="radios-a" value="Option two">
	                    <span class="new_info">使用新地址</span>
	                  </label>
	                  <div class="new_info_form" id="personal_userinfo">
	                    <div class="span6 margin_left50">
	                     <div class="control-group">
	                        <label for="first_name" class="control-label">
	                        收货人
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="firstname" id="firstname" />
	                     </div>
	                     <div class="control-group">
	                         <label for="postcode" class="control-label">
	                        邮政编码
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="zip" id="zip" /> 
	                     </div>
	                     <div class="control-group">
	                        <label for="email" class="control-label">
	                        电子邮件
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="email" id="email" />
	                     </div>
	                     <div class="control-group">
	                        <label for="phone" class="control-label">
	                        联系电话
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="telephone" id="telephone" />
	                     </div>
	                    </div><!--span6-->
	                    <div class="span6">
	                    <div class="control-group">
	                      
	                        <label for="last_name" class="control-label">
	                        地址
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="address" id="address" />
	                     </div>
	                     </div>
	                     <div class="row-fluid">
	                    
	                      <div class="span6">
	                          <div class="control-group">
	                              <label for="country" class="control-label">省</label>
	                               <select id="s_province" name="stateName" class="span12"></select>
	                          </div>
	                      </div>
	                      <div class="span6">
	                          <div class="control-group">
	                              <label for="state" class="control-label">市</label>
	                              <select id="s_city" name="cityName" class="span12"></select>						
	                          </div>
	                      </div>
	                      <div class="span6">
	                          <div class="control-group">
	                              <label for="state" class="control-label">区</label>
	                              <select id="s_county" name="sectionName" class="span12"></select>					
	                          </div>
	                      </div>
	                     
	                       <div class="span6">
	                          <div class="control-group">
	                              <label for="country" class="control-label">性别</label>
	                               <select class="span12" name="title" id="title">
	                               <option  class="select_title">请选择性别</option>
	                               <option>先生</option>
	                               <option>女士</option>
	                               
	                               </select>
	                          </div>
	                      </div>
	                   </div> 
	                   <div class="span6 margin_left10 margin_TD20">
	                     <button id="buttonsave_info" name="buttonsave_info" class="btn btn-gold infor_form_button" type="button" onclick="addAddress();">
	                      <i class="fa fa-floppy-o padding_right10"></i>
	                      保存
	                     </button>
	                     <button id="clearbutton_info" name="clearbutton_info" class="btn btn-black infor_form_button" type="button" onclick="resetAddress(this);">
	                      <i class="fa fa-undo padding_right10"></i>
	                      清除
	                     </button>
	                     
	                   </div>
	                  </div><!--new_info_form-->
	                  
	                    	<div class="new_info_form"   id="personal_userinfo_update" style="display: none;">
	                    		<div id="update_address_base" style="display: inline;">
							    </div>
							    <div class="row-fluid" id="update_address_more" style="display: inline;">
								    <div class="span6">
							             <div class="control-group">
							                 <label for="country" class="control-label">省</label>
							                  <select id="s_province_u" name="stateName_u" class="span12"></select>
							             </div>
							         </div>
							         <div class="span6">
							             <div class="control-group">
							                 <label for="state" class="control-label">市</label>
							                 <select id="s_city_u" name="cityName_u" class="span12"></select>						
							             </div>
							         </div>
							         <div class="span6">
							             <div class="control-group">
							                 <label for="state" class="control-label">区</label>
							                 <select id="s_county_u" name="sectionName_u" class="span12"></select>					
							             </div>
							         </div>
						        
							          <div class="span6">
							             <div class="control-group">
							                 <label for="country" class="control-label">性别</label>
							                  <select class="span12" name="title_u" id="title_u">
								                  <option  class="select_title">请选择性别</option>
								                  <option>男</option>
								                  <option>女</option>
							                  </select>
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
	                  
	                </div>
	              </div>
	
	           </div><!--info_form-->
	         </div><!--checkout_list-->
	         
         </c:if>
         
         <c:if test="${shippingAddressList == null || fn:length(shippingAddressList) <=0}">
         
         	  <div class="current_infowtool" id="current_user_info">
	           <div class="current_info">
	             <div class="current_info_col">
	               <div class="current_info_t current_address_firstname_title">暂无收货人信息，请使用新地址</div>
	               <div class="current_info_c current_address_firstname"></div>
	             </div>
	             <div class="current_info_col">
	               <div class="current_info_t current_address_address_title"></div>
	               <div class="current_info_c">
	              	 <span class="current_address_address">
	              	 </span>
	               </div>
	             </div>
	             <div class="current_info_col">
	               <div class="current_info_t current_address_telephone_title"></div>
	               <div class="current_info_c current_address_telephone"></div>
	             </div>
	           </div><!--current_info-->
	           <div class="current_info_toolbar">
	             <div class="colour_trash change_tool margin_top15" id="personal_tool">
	               <i class="fa fa-pencil-square-o fa-2x change_it"></i>
	             </div><!--change_tool-->
	           </div><!--current_info_toolbar-->
	         </div><!--current_infowtool-->
         
         	<div class="checkout_list margin_TD20" id="user_info_list">
	           <div class="info_form">
	
	              <!-- Multiple Radios -->
	              <div class="control-group">
	                <div class="controls">
	                  <label class="radio"  for="radios-a">
	                    <input type="radio" name="shippingAddressId" id="radios-a" value="Option two">
	                    <span class="new_info">使用新地址</span>
	                   
	                  </label>
	                  <div class="new_info_form" id="personal_userinfo">
	                    <div class="span6 margin_left50">
	                     <div class="control-group">
	                        <label for="first_name" class="control-label">
	                        收货人
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="firstname" id="firstname" />
	                     </div>
	                     <div class="control-group">
	                         <label for="postcode" class="control-label">
	                        邮政编码
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="zip" id="zip" /> 
	                     </div>
	                     <div class="control-group">
	                        <label for="email" class="control-label">
	                        电子邮件
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="email" id="email" />
	                     </div>
	                     <div class="control-group">
	                        <label for="phone" class="control-label">
	                        联系电话
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="telephone" id="telephone" />
	                     </div>
	                    </div><!--span6-->
	                    <div class="span6">
	                    <div class="control-group">
	                      
	                        <label for="last_name" class="control-label">
	                        地址
	                        <span class="text-error">*</span>
	                        </label>
	                            <input class="span12" type="text" value="" name="address" id="address" />
	                     </div>
	                     </div>
	                     <div class="row-fluid">
	                    
	                      <div class="span6">
	                          <div class="control-group">
	                              <label for="country" class="control-label">省</label>
	                               <select id="s_province" name="stateName" class="span12"></select>
	                          </div>
	                      </div>
	                      <div class="span6">
	                          <div class="control-group">
	                              <label for="state" class="control-label">市</label>
	                              <select id="s_city" name="cityName" class="span12"></select>						
	                          </div>
	                      </div>
	                      <div class="span6">
	                          <div class="control-group">
	                              <label for="state" class="control-label">区</label>
	                              <select id="s_county" name="sectionName" class="span12"></select>					
	                          </div>
	                      </div>
	                     
	                       <div class="span6">
	                          <div class="control-group">
	                              <label for="country" class="control-label">性别</label>
	                               <select class="span12" name="title" id="title">
	                               <option  class="select_title">请选择性别</option>
	                               <option>男</option>
	                               <option>女</option>
	                               
	                               </select>
	                          </div>
	                      </div>
	                   </div> 
	                   <div class="span6 margin_left10 margin_TD20">
	                     <button id="buttonsave_info" name="buttonsave_info" class="btn btn-gold infor_form_button" type="button" onclick="addAddress();">
	                      <i class="fa fa-floppy-o padding_right10"></i>
	                      保存
	                     </button>
	                     <button id="clearbutton_info" name="clearbutton_info" class="btn btn-black infor_form_button" type="button" onclick="resetAddress(this)">
	                      <i class="fa fa-undo padding_right10"></i>
	                      清除
	                     </button>
	                     
	                   </div>
	                  </div><!--new_info_form-->
	                  
	                  <div class="new_info_form"   id="personal_userinfo_update" style="display: none;">
                   		<div id="update_address_base" style="display: inline;">
					    </div>
					    <div class="row-fluid" id="update_address_more" style="display: inline;">
						    <div class="span6">
					             <div class="control-group">
					                 <label for="country" class="control-label">省</label>
					                  <select id="s_province_u" name="stateName_u" class="span12"></select>
					             </div>
					         </div>
					         <div class="span6">
					             <div class="control-group">
					                 <label for="state" class="control-label">市</label>
					                 <select id="s_city_u" name="cityName_u" class="span12"></select>						
					             </div>
					         </div>
					         <div class="span6">
					             <div class="control-group">
					                 <label for="state" class="control-label">区</label>
					                 <select id="s_county_u" name="sectionName_u" class="span12"></select>					
					             </div>
					         </div>
				        
					          <div class="span6">
					             <div class="control-group">
					                 <label for="country" class="control-label">性别</label>
					                  <select class="span12" name="title_u" id="title_u">
						                  <option  class="select_title">请选择性别</option>
						                  <option>男</option>
						                  <option>女</option>
					                  </select>
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
	                  
	                </div>
	              </div>
	
	           </div><!--info_form-->
	         </div><!--checkout_list-->
         
         </c:if>
         
       </div><!--checkout_info-->
      
       <!--配送时间-->
       <div class="checkout_info">
         <div class="checkout_title margin_TD20" id="delivery_time_title">
           <p><i class="fa fa-truck fa-2x margin_LR10"></i><span>配送时间</span><i class="fa fa-chevron-down fa-18px right margin_LR10 updown"></i></p>
         </div><!--checkout_title-->
         <div class="current_infowtool" id="current_delivery_time">
           <div class="current_info">
             <div class="current_info_col">
               <div class="current_info_t">期望的配送时间:</div>
               <div class="current_info_c" id="delivery_time_msg">只限工作日送货</div>
             </div><!--current_info_col-->
           </div><!--current_info-->
           <div class="current_info_toolbar">
             <div class="colour_trash change_tool" id="delivery_time_tool">
               <i class="fa fa-pencil-square-o fa-2x change_it"></i>
             </div><!--change_tool-->
           </div><!--current_info_toolbar-->
         </div><!--current_infowtool-->
          <div class="checkout_list" id="delivery_time_list">
           <div class="info_form">
	             <div class="info_title margin_left30 padding_bottom15">
	             请选择您方便的送货时间：
	             </div><!--info_title-->
	              <!-- Multiple Radios -->
	               <div class="control-group">
	                <div class="controls">
	                  <label class="radio" for="radios-b" id="weekdays">
	                    <input type="radio" name="deliveryTime" id="radios-b" value="wd" checked="checked">
	                    只限工作日送货
	                  </label>
	                  <label class="radio" for="radios-c" id="weekend">
	                    <input type="radio" name="deliveryTime" id="radios-c" value="wk_hd">
	                    只限双休日、假日送货
	                  </label>
	                  <label class="radio" for="radios-d" id="weekday_kend_hol">
	                    <input type="radio" name="deliveryTime" id="radios-d" value="wd_wk_hd">
	                    工作日、双休日或假日均可送货
	                  </label>
	                   <div class="margin_top15">
	                     <button id="buttonsave_delivery" name="buttonsave_delivery" class="btn btn-gold" type="button" onclick="changeDeliveryTime();">
	                      <i class="fa fa-floppy-o padding_right10"></i>
	                      保存
	                     </button>
	                     <button id="clearbutton_delivery" name="clearbutton_delivery" class="btn btn-black" type="button" onclick="resetDeliveryTime();">
	                      <i class="fa fa-undo padding_right10"></i>
	                      清除
	                     </button>
	                   </div>  
	  
	                </div>
	              </div>
           </div><!--info_form-->
           
         </div><!--checkout_list-->
         
       </div><!--checkout_info-->
       
       <!--支付方式-->
       <div class="checkout_info">
         <div class="checkout_title margin_TD20" id="pay_methods_title">
           <p><i class="fa fa-money fa-2x margin_LR10"></i><span>支付方式</span><i class="fa fa-chevron-down fa-18px right margin_LR10 updown"></i></p>
         </div><!--checkout_title-->
         <div class="current_infowtool" id="current_pay_methods">
           <div class="current_info">
             <div class="current_info_col">
               <div class="current_info_t">期望的支付方式:</div>
               <div class="current_info_c" id="pay_method_msg">在线付款</div>
             </div><!--current_info_col-->
           </div><!--current_info-->
           <div class="current_info_toolbar">
             <div class="colour_trash change_tool" id="pay_methods_tool">
               <i class="fa fa-pencil-square-o fa-2x change_it"></i>
             </div><!--change_tool-->
           </div><!--current_info_toolbar-->
         </div><!--current_infowtool-->
          <div class="checkout_list" id="pay_methods_list">
           <div class="info_form">
             <div class="info_title margin_left30 padding_bottom15">
             请选择期望的支付方式：
             </div><!--info_title-->
              <!-- Multiple Radios -->
               <div class="control-group">
                <div class="controls">
                  <label class="radio" for="radios-e" id="online">
                    <input type="radio" name="payType" id="radios-e" value="online" checked="checked">
                    在线付款
                  </label>
                  
                  
                <c:if test="${shoppingcart.total > 128}">
	                  <label class="radio" for="radios-f" id="cash">
	                    <input type="radio" name="payType" id="radios-f" value="cod">
	                    货到付款
	                  </label>
                  </c:if>
                  
                  <label class="radio" for="radios-g" id="transfer">
                    <input type="radio" name="payType" id="radios-g" value="transfer">
                   对公转账
                  </label>
                   <div class="margin_top15">
                     <button id="buttonsave_pay" name="buttonsave_pay" class="btn btn-gold" type="button" onclick="changePayMethod();">
                      <i class="fa fa-floppy-o padding_right10"></i>
                      保存
                     </button>
                     <button id="clearbutton_pay" name="clearbutton_pay" class="btn btn-black" type="button" onclick="resetPayMethod();">
                      <i class="fa fa-undo padding_right10"></i>
                      清除
                     </button>
                   </div>  
  
                </div>
              </div>

           </div><!--info_form-->
         </div><!--checkout_list-->
       </div><!--checkout_info-->
       
       <!--商品信息-->
       <div class="checkout_info">
         <div class="checkout_title margin_top20">
           <p><i class="fa fa-puzzle-piece fa-2x margin_LR10"></i><span>商品信息</span></p>
         </div><!--checkout_title-->
         <table class="checkout_table" cellspacing="0" cellpadding="0">
           <thead>
           		<tr>
	              <th width="16%">
	                                                   商品图像
	              </th>
	              <th width="23.5%">
	                商品名称
	              </th>
	              <th width="16.5%">
	                编码
	              </th>
	              <th width="8.5%">
	                数量
	              </th>
	              <th width="11.8%">
	                单价
	              </th>
	              <th width="11.8%">
	                优惠
	              </th>
	              <th width="11.9%">
	                总价
	              </th>
              </tr>
           </thead><!--thead-->
           <tbody>
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
							 <tr>
					              <td rowspan="3" class="chart_img border_with">
					                <product:productImg sku="${item.productSku}" size="e" width="165" height="165"/>
					              </td>
					              <td class="align_left  padding_top10"><product:productName product="${item.productSku.product}"/></td>
					              <td>${item.productSku.productSkuCode}</td>
					              <td>
					              	${item.quantity}
					              </td>
					              <td>
					                <system:CurrencyForRate value="${item.price}" />
					              </td>
					              <td>
					              	<system:CurrencyForRate value="${(item.price - item.discountPrice)*item.quantity}"/>
					              </td>
					              <td>
					                <system:CurrencyForRate value="${item.discountPrice * item.quantity}"/>
					              </td>
					            </tr>
					            <tr>
					              <td class="size_colour align_left">
										<product:showSkuOptions productSkuId="${item.productSku.productSkuId}"></product:showSkuOptions>
					              </td>
					              <td></td>
					              <td></td>
					              <td></td>
					              <td></td>
					              <td></td>
					              <td></td>
					            </tr>
					           
					            <tr class="border_last">
					              <td  class="colour_trash padding_last align_left">
					              <c:if test="${item.maxOrderQuantity <= 2 }">
						               <i class="fa fa-exclamation-triangle fa-lg"></i>
						               库存紧张，请尽快购买
					               </c:if>
					              </td>
					              <td></td>
					              <td></td>
					              <td></td>
					              <td></td>
					              <td></td>
					              <td></td>
					            </tr>
						</c:if>
					</c:forEach>
				  <%-- 商品结束 --%>
				</c:otherwise>
			</c:choose> 
           </tbody>     
           <tfoot>
           
              <tr class="chart_tfoot_first">
                <td colspan="4" rowspan="4" class="chart_td_waring"></td>
                <td class="checkout_howmany">共计有<span class="colour_trash padding_td text_bold">${shoppingcart.buyNowItemsCount }</span>件商品</td>
                <td class="chart_subtotal">小计：</td>
                <td class="align_right padding_right30 padding_bottom15">￥<span id="cart_total">${shoppingcart.subtotal }</span></td>
              </tr>
              
              <tr>
                <td> </td>
                <td class="chart_subtotal">减免</td>
                <td class="align_right padding_right30"><span id="discount">0.00</span></td>
              </tr>            
              
              <tr>
                <td class="checkout_howmany mark_co">100元以上免运费</td>
                <td class="chart_subtotal">运费</td>
                <td class="align_right padding_right30">￥<span id="shippingRate">0.00</span></td>
              </tr>
              
            
              <tr class="chart_last_total">
                <td></td>
                <td class="colour_trash text_bold">共计：</td>
                <td class="align_right padding_right30 colour_trash text_bold">
            	   ${appConfig.defaultCurrencySymbol}&nbsp;<span id="cart_sum">${shoppingcart.subtotal}</span>
                </td>
              </tr>
              
           </tfoot>       
         </table>
       </div><!--checkout_info-->
       
       <div class="checkout_button">
           
           <!-- Button -->
            <div class="control-button">
              <div class="controls">
             	 <a href="javascript:void(0);" onclick="javascript:window.location.href='${ctxPath }/cart/shoppingcart.html';">
	                <button id="singlebutton" name="singlebutton" class="btn btn-black" type="button">
	                <i class="fa fa-chevron-left padding_right10"></i>
	                修改购物车
	                </button>
                </a>
                <div class="right">
                
                <button id="button2id" name="button2id" class="btn btn-gold" type="button" onclick="checkAddress();">
                提交
                <i class="fa fa-chevron-right padding_left10"></i>
                </button>
                </div>
              </div><!--controls-->
            </div><!--control-button-->
            
            <input type="hidden" name="doAction" value="doCK"/>
            
       </div><!--chart_button-->
     </div><!--chart_bottom-->
     
     <div style="display: none;">
		<c:forEach items="${shippingRateList}" var="shippingRate" varStatus="varStatus">
			<div class="left" style="margin-left:10px;"><input type="radio" value="${shippingRate.shippingRateId},${shippingRate.shippingMethod.shippingMethodId}" name="shippingMethodId"<c:if test="${varStatus.first}"> checked="checked"</c:if>/>
				<input type="hidden" id="cartShipping_${shippingRate.shippingMethod.shippingMethodId}" value="${shippingRate.cartShipping}"/></div>
			<div class="left"><label>${shippingRate.shippingMethod.shippingMethodName}</label></div>
		</c:forEach>
		<textarea name="orderNote" id="orderNote" rows="4" cols="150" style="border:1px solid #ccc;"></textarea>
       </div>
     
     </form>
     
    </div><!--end of maincontent-->
    
    

    
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
	 	var firstname = $("#firstname").val();
	 	var address = $("#address").val();
	 	var zip = $("#zip").val();
	 	var email = $("#email").val();
	 	var telephone = $("#telephone").val();
	 	var stateName = $("#s_province").val();
	 	var cityName = $("#s_city").val();
	 	var sectionName = $("#s_county").val();
	 	var title = $("#title").val();
		$.post(__ctxPath+"/checkout/address/addAjax.html",
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
           	 			/*
           	 			if(${shippingAddressList == null}){
               	 			$("#current_user_info").remove();
           	 			}
           	 			*/
       	 			}else{
           	 			alert("保存新地址有误！");
       	 			}
       	 		},
       	 		"json"
       	 	);
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
                 	 
    