<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="customer" tagdir="/WEB-INF/tags/customer"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
	<head>
		<title>个人资料</title>
	</head>
	<body>
		
		<div class="maincontent">
         
			         <div class="position-wrap">
			            <a href="${ctxPath }/index.html">首页</a>&nbsp;&gt;&nbsp;
			            <a href="${ctxPath }/myaccount/order/list.html">我的账户</a>&nbsp;&gt;&nbsp;
			            <span class="selected">个人资料</span>
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
			           
			           
			          <div class="down_right left_border" id="tab4">
			          
			             <p class="account_info_title">
			               账户：${customer.email}
			               <span class="header_breadcrumb">个人资料</span>
			             </p>
			             <p class="cus_id">会员级别：${membership.membershipName}</p>
			             <div class="break_detail">
			             
			             <spring:bind path="customerSettingsInfoModel.*">
							<c:if test="${not empty status.errorMessages}">
								<div class="error_box">
								<c:forEach var="error" items="${status.errorMessages}">
									<c:out value="${error}" escapeXml="false" /><br/>
								</c:forEach>
								</div>
							</c:if>
						</spring:bind>
						<spring:bind path="customerSettingsAccountModel.*">
							<c:if test="${not empty status.errorMessages}">
								<div class="error_box">
								<c:forEach var="error" items="${status.errorMessages}">
									<c:out value="${error}" escapeXml="false" /><br/>
								</c:forEach>
								</div>
							</c:if>
						</spring:bind>
						<spring:bind path="customerSettingsPasswordModel.*">
							<c:if test="${not empty status.errorMessages}">
								<div class="error_box">
								<c:forEach var="error" items="${status.errorMessages}">
									<c:out value="${error}" escapeXml="false" /><br/>
								</c:forEach>
								</div>
							</c:if>
						</spring:bind>
			             
			             <form id="infoForm" method="post" action="${ctxPath}/myaccount/settings.html">
			               <div class="leftright_form">
			                 <p>
			                  <label for="newfirstname">姓名:</label>
			                  <spring:bind path="customerSettingsInfoModel.firstname">
									<input type="text" class="box-input" name="firstname" id="firstname" value="${status.value}" maxlength="32">
									<div class="mark_co input_waring">
			                            <div for="firstname" generated="true" class="red" style="display: none;">
			                            请输入姓名
			                            </div>
		                            </div>
								</spring:bind>
			                 </p>
			               </div><!--leftright_form-->
			               <div class="leftright_form">
			                 <p>
			                  <label for="newfirstname">性别:</label>
			                  <spring:bind path="customerSettingsInfoModel.title">
									<customer:userTitle id="title" name="title" value="${status.value}" />
								</spring:bind>
			                 </p>
			               </div><!--leftright_form-->
			               <div class="form_button">
			                 <button name="buttonsave_info" class="btn btn-gold" type="submit">
			                  <i class="fa fa-floppy-o padding_right10"></i>
			                  保存
			                 </button>
			               </div>
			               <input type="hidden" name="doAction" value="changeProfile">
							<script type="text/javascript"><%--
							$("#infoForm").validate({rules:{
										firstname:{required:true,minlength:2}
									},
								messages:{
										firstname:{
											required:"请输入姓名。",
											minlength:"最少两个字。"
											}
									}
								});
							--%></script>
			             </form>
			             </div><!--break_detail-->
			             
			             <div class="break_detail">
			             <form method="post" action="${ctxPath}/myaccount/settings.html" name="emailForm" id="emailForm">
			               <div class="leftright_form">
			                 
			                 <p>
			                            <label for="password_current_to_change_email">现有密码:</label>
			                            <input  name="password" type="password" value="" size="25">
			                            <div class="mark_co input_waring">
				                            <div for="password" generated="true" class="red" style="display: none;">
				                            请输入当前的登录密码
				                            </div>
			                            </div>
			                 </p>
			               </div><!--leftright_form-->
			               <div class="leftright_form">
			                 <p>
			                            <label for="email_email1">新邮件地址:</label>
			                            <spring:bind path="customerSettingsAccountModel.email">
											<input type="text" class="box-input" name="email" id="email" value="${status.value}"  size="25">
										</spring:bind>
			                 </p>
			                 <p>
			                            <label for="email_email2">确认新邮件地址:</label>
			                            <input name="newEmailConfirm" type="text" value="" size="25">
			                            <div class="mark_co input_waring">
				                            <div for="newEmailConfirm" generated="true" class="red" style="display: none;">
				                            请确认新邮件地址
				                            </div>
			                            </div>
			                 </p>
			               </div><!--leftright_form-->
			               <div class="form_button">
			                 <button name="buttonsave_info" class="btn btn-gold" type="submit">
			                  <i class="fa fa-floppy-o padding_right10"></i>
			                  保存
			                 </button>
			               </div>
			               <input type="hidden" name="doAction" value="changeEmail">
							<script type="text/javascript">
								$("#emailForm").validate({rules:{
										password:{required:true,minlength:5},
										email:{required:true,email:true},
										newEmailConfirm:{required:true,email:true,equalTo:"#email"}
									},
									messages:{
										password:{
											required:"请输入你当前的登录密码。",
											minlength:"密码最少5个字符。"
											},
										email:{
												required:"请输新的邮件地址。",
												email:"邮件地址格式不正确(例如: yourname@gmail.com)"
											},
											newEmailConfirm:{
												required:"请确认新的邮件地址。",
												email:"邮件地址格式不正确(例如: yourname@gmail.com)",
												equalTo:"两个邮件地址不一致！"
											}
									}
								});
							</script>
			             </form>
			             </div><!--break_detail-->
			             <div class="break_detail">
			             <form method="post" action="${ctxPath}/myaccount/settings.html" name="passwordForm" id="passwordForm">
			               <div class="leftright_form">
			                 <p>
			                            <label for="password_current">现有密码:</label>
			                            <input type="password" class="box-input" value="" id="password" name="password" />
			                            <div class="mark_co input_waring">
				                            <div for="password" generated="true" class="red" style="display: none;">
				                            请输入当前的登录密码
				                            </div>
			                            </div>
			                 </p>    
			
			                 
			             </div><!--leftright_form-->
			               <div class="leftright_form">
			                 <p>
			                            <label for="newpassword">新密码:</label>
			                            <input type="password" class="box-input" value="" id="newPassword" name="newPassword" />
			                            <div class="mark_co input_waring">
				                            <div for="newPassword" generated="true" class="red" style="display: none;">
				                            密码长度不得少于6个字符
				                            </div>
			                            </div>
			                 </p>
			                 <p>
			                            <label for="newpassword2">确认新密码:</label>
			                            <input type="password" class="box-input" value="" name="confirmPassword" id="confirmPassword"/>
			                            <div class="mark_co input_waring">
				                            <div for="confirmPassword" generated="true" class="red" style="display: none;">
				                            请再次输入新密码
				                            </div>
			                            </div>
			                 </p>
			               </div><!--leftright_form-->
			               <div class="form_button">
			                 <button name="buttonsave_info" class="btn btn-gold" type="submit">
			                  <i class="fa fa-floppy-o padding_right10"></i>
			                  保存
			                 </button>
			               </div>
			               <input type="hidden" name="doAction" value="changePassword">
							<script type="text/javascript">
								$("#passwordForm").validate({rules:{
										password:{required:true,minlength:5},
										newPassword:{required:true,minlength:5},
										confirmPassword:{required:true,equalTo:"#newPassword"}
										},
										messages:{
											password:{
												required:"请输入当前的登录密码。",
												minlength:"密码必须大于5个字符"
												},
												newPassword:{
													required:"请输入新密码",
													minlength:"密码必须大于5个字符"
												},
												confirmPassword:{
													required:"请再次输入新密码",
													equalTo:"两个密码不一致，请再输入。"
												}
										}
									});
							</script>
			             </form>
			             </div><!--break_detail-->
			            
			           </div><!--down_right-->
				           
			         </div>
                
			</div>
		
		
	</body>
</html>