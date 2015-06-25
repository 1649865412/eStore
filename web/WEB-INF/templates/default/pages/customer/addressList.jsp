<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"	src="${ctxPath}/scripts/cartmatic/common/region.js"></script>
<title>我的收货地址</title>


<div class="maincontent">
         
			         <div class="position-wrap">
			            <a href="${ctxPath }/index.html">首页</a>&nbsp;&gt;&nbsp;
			            <a href="${ctxPath }/myaccount/order/list.html">我的账户</a>&nbsp;&gt;&nbsp;
			            <span class="selected">收货地址</span>
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
			           
			           
			           <div class="down_right left_border" id="tab5">
			             <p class="account_info_title">
			               账户：${customer.email}
			               <span class="header_breadcrumb">收货地址</span>
			             </p>
			             <p class="cus_id">会员级别：${membership.membershipName}</p>
			              
							<div class="current_address">
							
							<spring:bind path="address.*">
								<c:if test="${not empty status.errorMessages}">
									<div class="error_box">
										<c:forEach var="error" items="${status.errorMessages}">
											<c:out value="${error}" escapeXml="false" /><br/>
										</c:forEach>
									</div>
								</c:if>
							</spring:bind>
			               
			               <h3 class="padding_left10">我的收货地址</h3>
			               			               
			               <c:forEach items="${shippingAddressList}" var="address">
			               
				               <div class="address_chart">
				                   <div class="address_left">
				                     <p>收货人:</p>
				                     <p>联系电话：</p>
				                     <p>收货地址：</p>
				                   </div><!--address_left-->
				                   <div class="address_mid">
				                     <p>${address.firstname }</p>
				                     <p>${address.telephone }</p>
				                     <p>${address.stateName }${address.cityName }${address.sectionName }${address.address }</p>
				                   </div><!--address_mid-->
				                   <div class="address_right">
				                   <button name="change" class="btn btn-gold" type="button" onclick="window.location.href='${ctxPath}/myaccount/address/edit/${address.addressId}.html'">
				                      <i class="fa fa-pencil padding_right10"></i>
				                      编辑
				                   </button>
				                   <button name="delete_address" class="btn btn-black" type="button" onClick="if(confirm('是否要删除这收货地址?')){window.location.href='${ctxPath}/myaccount/address/delete/${address.addressId}.html';}">
				                      <i class="fa fa-times padding_right10"></i>
				                      删除
				                   </button>
				                   </div><!--address_right-->
				               </div><!--address_chart-->
			               
			               </c:forEach>
			               
			             </div><!--current_address-->
			             <div class="new_address">
			               <h3 class="padding_left10 padding_top10">新增收货地址</h3>
			               <form id="addressForm" action="${ctxPath}/myaccount/address/add.html" method="post">
				               <div class="new_info_form">
				                    <div class="leftright_form">
				                       <div class="control-group">
				                          <label for="first_name" class="control-label">
				                          收货人
				                          <span class="text-error">*</span>
				                          </label>
				                          <input class="span12" type="text" value="" name="firstname" id="firstname" />
				                          <div class="mark_co input_waring">
				                            <div for="firstname" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
				                       </div>
				                       <div class="control-group">
				                           <label for="postcode" class="control-label">
				                          邮政编码
				                          <span class="text-error">*</span>
				                          </label>
				                           <input class="span12" type="text" value="" name="zip" id="zip" />  
				                           <div class="mark_co input_waring">
				                            <div for="zip" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
				                           
				                       </div>
				                       <div class="control-group">
				                          <label for="email" class="control-label">
				                          电子邮件
				                          <span class="text-error">*</span>
				                          </label>
				                           <input class="span12" type="text" value="" name="email" id="email" />
				                           <div class="mark_co input_waring">
				                            <div for="email" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
				                           
				                       </div>
				                       <div class="control-group">
				                          <label for="phone" class="control-label">
				                          联系电话
				                          <span class="text-error">*</span>
				                          </label>
				                           <input class="span12" type="text" value="" name="telephone" id="telephone" />
				                           <div class="mark_co input_waring">
				                            <div for="telephone" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
				                           
				                       </div>
				                       <div class="control-group">
				                        
				                          <label for="last_name" class="control-label">
				                          地址
				                          <span class="text-error">*</span>
				                          </label>
				                          <input class="span12" type="text" value="" name="address" id="address" />
				                          <div class="mark_co input_waring">
				                            <div for="address" generated="true" class="red" style="display: none;">
				                            </div>
			                            </div>
				                          
				                       </div>
				                    </div><!--leftright_form-->
				                    
				                    <div class="leftright_form">
				                      <div class="control-group">
				                          <label for="country" class="control-label">省<span class="text-error">*</span></label>
				                           <select id="s_province" name="stateName" class="span12"></select>
				                      </div>
				                      <div class="control-group">
				                          <label for="state" class="control-label">市<span class="text-error">*</span></label>
				                          <select id="s_city" name="cityName" class="span12"></select>			
				                      </div>
				                      <div class="control-group">
				                          <label for="state" class="control-label">区<span class="text-error">*</span></label>
				                          <select id="s_county" name="sectionName" class="span12"></select>		
				                      </div>
				                      <div class="control-group">
				                          <label for="country" class="control-label">性别</label>
				                          <select class="span12" name="title" id="title">
				                           <option  class="select_title">请选择性别</option>
				                           <option>先生</option>
				                           <option>女士</option>
				                           </select>
				                      </div>
				                      <div class="address_button">
				                       <button id="buttonsave_info" name="buttonsave_info" class="btn-gold new_address_button" type="submit">
				                        <i class="fa fa-floppy-o padding_right10"></i>
				                        保存
				                       </button>
				                       <button id="clearbutton_info" name="clearbutton_info" class="btn-black new_address_button" type="reset">
				                        <i class="fa fa-undo padding_right10"></i>
				                        清除
				                       </button>
				                      </div><!--address_button-->
				                   </div><!--leftright_form--> 
				                  
				                  </div><!--new_info_form-->
			                </form>  
			                
			                <script type="text/javascript">
							$.validator.setDefaults({focusout:true});
							$.validator.addMethod("tel", function(value) {return /(^[0-9+-]{3,30}$)/.test(value);},"请填写正确的联系电话");
							$("#addressForm").validate({event:blur,
								rules:{
									firstname:{required:true},
									address:{required:true,minlength:5},
									zip:{required:true,minlength:4},
									telephone:{required:true,minlength:5,tel:true},
									email:{required:true,minlength:5,tel:true}
								},
								errorPlacement: function(error, element) {
										error.appendTo(element.parent());
									},
							messages:{
									firstname:{
										required:"请准确填写真实姓名"
										}
									,
									address:{
										required:"请填写详细路名及门牌号"
									},
									zip:{
										required:"请填写正确的邮政编码"
									},
									telephone:{
										required:"电话格式不正确（请输入手机号 或 区号-固话）"
									},
									email:{
										required:"请输入电子邮件地址"
									}
								}
							});
							</script>
			                
			             </div><!--new_address-->
			             
			               	 <!--省市三级联动-->
						    <script  src="${ctxPath}/scripts/cartmatic/cart/checkout/area.js" type="text/javascript"></script>
							  <script type="text/javascript">
								  _init_area();
							  </script>
						    <!--end of 省市三级联动-->
			            
			           </div><!--down_right-->
				           
			         </div>
                
			</div>