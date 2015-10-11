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
			<script type="text/javascript">
								$(document).ready(function(){
								  $(".addtolove").click(function(){
								  $("#add_love").hide();
								  $("#love_count").show();
								  });
								});
								function changeToOne(obj){
									if($(obj).val() == ""){
										$(obj).val(1);
									}
								}
								</script>
	    <script type="text/javascript">
			$(document).ready(function(){
				var url =""+self.location.href;
				var value = ("<a href='/myaccount/account.html?url="+url+"'><i class='fa fa-user'></i></a> ("+
						"<a href='${ctxPath}/j_acegi_logout' rel='nofollow' onclick='window.location.href='${ctxPath}/j_acegi_logout''>退出</a>)&nbsp;&nbsp;");
				$("#loginPromptHolderTemplateLogin").html(value);
				
				$("#error_box1").hide();
				$("#error_box2").hide();
				$("#error_box3").hide();
				
				var tag = getCookie("tag");
				var error = getCookie("error");
				if(tag!=""&&tag!=null){
						$(".w-login").show();
						$(".w-login-left").show();
						$(".w-login-right").hide();
						delCookie("tag");
						if(error!=""&&error!=null){
							$("#error_box1").show();
							$("#error_box2").hide();
							$("#error_box3").hide();
							delCookie("error");
					}
						if(flag!=""&&flag!=null){
							$("#error_box1").hide();
							$("#error_box2").hide();
							$("#error_box3").show();
							delCookie("flag");
					}
				}
				
				//alert('${param.tag}');
				if('${param.tag}'!=""){
					   // alert("hello");
						$(".w-login").show();
						$(".w-login-left").show();
						$(".w-login-right").hide();
						
				}
				//alert('${param.tag1}');
				if('${param.tag1}'!=""){
					   // alert("hello");
						$(".w-login").show();
						$(".w-login-left").hide();
						$(".w-login-right").show();
				}
	
				var _str = '';
				if (!isLogined()) {
					$("#loginPromptHolderTemplateLogin").hide();
					$("#loginPromptHolderTemplateLogout").show();
				} else {
					var uname = getCookie("UNAME");
					//alert("uname:"+uname);
					//emial的去掉@后的部分
					if (uname.indexOf("@") != -1)
						uname = uname.substring(0, uname.indexOf("@"));
					$("#username").html(uname);
					$("#loginPromptHolderTemplateLogin").show();
					$("#loginPromptHolderTemplateLogout").hide();
				}
				});
			function fnUnlock(){
				if(window.location.pathname=="/culturalinformation/index.html" || window.location.pathname=="/Cultural_Service/search.html"){
					$("#searchForm").attr("action", "${ctxPath}/Cultural_Service/search.html?q="+$("#q").val());
					$("#searchForm").submit();
				}else{
				//$("#searchForm").action="${ctxPath}/search-prod.html?q="+$("#q").val();
				$("#searchForm").attr("action", "${ctxPath}/search-prod.html?q="+$("#q").val());
				$("#searchForm").submit();
				}
			}
	
			function delCookie(name)
			{
			var exp = new Date();
			exp.setTime (exp.getTime() - 1);
			var cval = getCookie (name);
			document.cookie = name + "=" + cval + "; expires="+ exp.toGMTString();
			}
					
			
		function getCurrentUserId() {
			return getCookie("UID") || -2;
		}
		/**不严格的简单判断用户是否登录的方法，性能较好，缺省设置为5分钟更新一次*/
		function isLogined() {
			return getCurrentUserId() > 0;
		}
		function getCurrentUserName(loginRequired) {
			return (!loginRequired || isLogined()) && getCookie("UNAME") || "";
		}
		function getLoginUserEmail(loginRequired) {
			return (!loginRequired || isLogined()) && getCookie("UEMAIL") || "";
		}
	
		function userName() {
			var username = getLoginUserEmail(false);
			if ($("#j_username").val().trim().length == 0) {
				$("#p_username").show();
			}else{
				$("#p_username").hide();
			}
		}
	
		function passWord() {
			var password = $("#j_password").val().trim();
			if (password.length == 0) {
				$("#p_password").show();
				$("#q_password").hide();
			}else if(password.length>0 && password.length<6){
				$("#p_password").hide();
				$("#q_password").show();
			}else{
				$("#p_password").hide();
				$("#q_password").hide();
			}
		}
	
		function validateMethod() {
			var validatecode = $("#j_validateCode").val().trim();
			if(validatecode.length ==0){
				$("#p_validateCode").show();
			}else{
				$("#p_validateCode").hide();
			}
		}
	
		function validateCode2() {
			var validatecode = $("#k_validateCode").val().trim();
			if(validatecode.length ==0){
				$("#q_validateCode").show();
			}else{
				$("#q_validateCode").hide();
			}
		}
	
		function emailPhone() {
			if ($("#email").val().trim().length == 0) {
				$("#p_email").show();
			}else{
				$("#p_email").hide();
			}
		}
	
		function telePhone() {
			if ($("#telephone").val().trim().length == 0) {
				$("#p_telephone").show();
			}else{
				$("#p_telephone").hide();
			}
			var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
			 if (reg.test($("#telephone").val().trim())) {
				 $("#p_telephone").hide();
			 }else{
				 $("#p_telephone").show();
			 };
		}
	
		function passWord2() {
			var password = $("#password").val().trim();
			if (password.length == 0) {
				$("#a_password").show();
				$("#o_password").hide();
			}else if(password.length>0 && password.length<6){
				$("#a_password").hide();
				$("#o_password").show();
			}else{
				$("#a_password").hide();
				$("#o_password").hide();
			}
		}
	
		function rePassWord() {
			var password = $("#password").val().trim();
			var rePassword = $("#rePassword").val().trim();
			if (rePassword.length == 0) {
				$("#p_rePassword").show();
				$("#q_rePassword").hide();
			}else if(rePassword !=password){
				$("#p_rePassword").hide();
				$("#q_rePassword").show();
			}else{
				$("#p_rePassword").hide();
				$("#q_rePassword").hide();
			}
		}
	
		function checkbox1() {
			if($("#checkboxre").is(":checked")){
				$("#button1").show();
				$("#button2").hide();
			}else{
				$("#button1").hide();
				$("#button2").show();
			}
		}
		
		function getCookie(name) {
			var prefix = name + "="
			var start = document.cookie.indexOf(prefix)
			if (start == -1) {
				return null;
			}
			start += prefix.length;
			var end = document.cookie.indexOf(";", start)
			if (end == -1) {
				end = document.cookie.length;
			}
			var cookieValue = document.cookie.substring(start, end);
			if (cookieValue) //把所有'"'去掉.
			{
				cookieValue = cookieValue.replace(/"/g, "");
				cookieValue = decodeURI(cookieValue);
			}
			return unescape(cookieValue);
		}
		function checkAddProductToCart(){
			var skuOptions=$("#skuOptions").children("div.tb-prop").find("ul[data-property]");
			var name="";
			skuOptions.each(function(i){
				if($(this).find("li.tb-selected").length==0){
					name+="."+$(this).attr("data-property");
				}
			});
			if(name!=""){
				alert("请选择 "+name);
			}
			return name=="";
		}
		
		jQuery(document).ready(function($) {
			$('.grid-container').gridQuote( {
				slideshow : false,
				initOpen : false
			});
		});
	</script>
	</head>

	<body>
        <!--[if lt IE 8]>
       <p class="browserupgrade">你正在使用一个 <strong>过时的</strong> 浏览器. 请 <a href="http://browsehappy.com/">提高您的浏览器</a> 以提高您的经验.</p>
       <![endif]-->
		<!--登陆注册-->
		<div class="w-login">
			<div class="w-login-s"></div>
			<div class="w-login-c">
			<form method="post" name="loginForm" id="loginForm"
					action="${ctxPath}/index_check.html" >
				<div class="w-login-left">
					<div class="w-l-close">
						<a href="javascript:void(0)"> <i class="fa fa-times"></i> </a>
					</div>
					<div class="w-l-title">会员登陆</div>
					<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-user"></i>
								<input class="form-control" type="text" placeholder="邮箱/手机"
									name="j_username" size="41" maxlength="288" id="j_username"
									onblur="userName();">
								<input type="hidden"  name ="papeurl" id="papeurl" value=""/>
							</div>
					</div>
					<div class="mark margin-bottom-sm">
							<div for="j_username" generated="true" class="red"
								style="display: none;" id="p_username">
								&nbsp;&nbsp;&nbsp;&nbsp;邮箱/手机 不能为空
							</div>
					</div>
					<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-lock"></i>
								<input class="form-control" type="password" placeholder="输入用户密码"
									name="j_password" size="41" maxlength="120" id="j_password"
									onblur="passWord();">
							</div>
					</div>
					<div class="mark margin-bottom-sm">
								<div for="j_password" generated="true" class="red"
									style="display: none;" id="p_password">
									&nbsp;&nbsp;&nbsp;&nbsp;密码不能为空
								</div>
					</div>
					<div class="mark margin-bottom-sm">
								<div for="j_password" generated="true" class="red"
									style="display: none;" id="q_password">
									&nbsp;&nbsp;&nbsp;&nbsp;密码必须最小为6位字符
								</div>
					</div>
					<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-tag"></i>
								<input class="form-control" type="text" placeholder="输入验证码" name="validateCode" id="j_validateCode" onblur="validateMethod()">
							</div>
					</div>
					<div class="mark margin-bottom-sm">
							<div for="j_validateCode" generated="true" class="red" style="display: none;" id="p_validateCode">
									&nbsp;&nbsp;&nbsp;&nbsp;验证码不能为空
							</div>
					</div>
						<%--<%@ include file="/common/messages.jsp"%>
						<%if(request.getAttribute("customer")==null); %>
						<spring:bind path="customer.*">
							<c:if test="${not empty status.errorMessages}">
								<c:forEach var="error" items="${status.errorMessages}">
									<div class="error_box"><c:out value="${error}" escapeXml="false" /></div>
								</c:forEach>
							</c:if>
						</spring:bind>
						
						--%>
							<div class="error_box" id="error_box1"><fmt:message key="customer.login.fail" /></div>
							<div class="error_box" id="error_box2"><fmt:message key="front.errorCode" /></div>
					<div class="w-l-yzm">
						<div class="w-l-itemscon">
							<a href="javascript:;" onClick="return refreshImage('login',this)"><img id="imgValidationCode" src="${ctxPath}/jCaptcha.html?type=login" title="点击改变" /> </a>
						</div>
					</div>
					<div class="w-l-btn">
						<div class="w-l-itemscon">
							<button name="login" class="btn btn-default signin" type="submit" onClick="index_login()">
									登陆
								</button>
						</div>
					</div>
					<div class="w-l-info">
							<div class="w-l-itemscon">
								<a class="lost_password"
									href="<c:url value="/forgetPassword.html" />" title="忘记密码">忘记密码?</a>
								|
								<a href="javascript:void(0)" class="w-menu-lrzc">注册新用户</a>
							</div>
					</div>
					<%--<div class="w-l-note">
						<div class="w-l-itemscon">
							<script id='denglu_login_js' type='text/javascript' charset='utf-8'></script>
							<script type='text/javascript' charset='utf-8'>
								(function() {
									var _dl_time = new Date().getTime();
									var _dl_login = document.getElementById('denglu_login_js');
									_dl_login.id = _dl_login.id + '_' + _dl_time;
									_dl_login.src = 'http://static.denglu.cc/connect/logincode?appid=82529denuh8LjbM9yT1Fqp48COxlA3&v=1.0.2&widget=3&styletype=1&size=348_214&asyn=true&time=' + _dl_time;
								})();
							</script>
							</div>
					</div>
				--%></div>
				</form>
				<form id="customerRegisterForm" action="${ctxPath}/register.html" method="post">
				<div class="w-login-right">
					<div class="w-l-close">
						<a href="javascript:void(0)"> <i class="fa fa-times"></i> </a>
					</div>
					<div class="w-l-title">注册新会员</div>
					<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-user"></i>
								<input type="text" id="email" name="email" value="${status.value}" size = "41" maxlength="128" class="form-control"  placeholder="邮箱" onblur="emailPhone();">
							</div>
						</div>
						<div class="mark margin-bottom-sm">
           					<div for="email" generated="true" class="red mark margin-bottom-sm" style="display: none;" id="p_email">&nbsp;&nbsp;&nbsp;&nbsp;邮箱不能为空</div>
           				</div>
           				
           				<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-user"></i>
								<input type="text" id="telephone" name="telephone" value="${status.value}" size = "41" maxlength="128" class="form-control"  placeholder="手机" onblur="telePhone();">
							</div>
						</div>
						<div class="mark margin-bottom-sm">
           					<div for="telephone" generated="true" class="red mark margin-bottom-sm" style="display: none;" id="p_telephone">&nbsp;&nbsp;&nbsp;&nbsp;请填写正确的联系电话</div>
           				</div>
					<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-lock"></i>
								<input type="password" name="password" id="password" size = "41" maxlength= "120" " class="form-control" placeholder="输入用户密码" onblur="passWord2();">
							</div>
					</div>
					<div class="mark margin-bottom-sm">
            				<div for="password" generated="true" class="red mark margin-bottom-sm" style="display: none;" id="a_password">&nbsp;&nbsp;&nbsp;&nbsp;密码不能为空</div>
            		</div>
            		<div class="mark margin-bottom-sm">
							<div for="password" generated="true" class="red"style="display: none;" id="o_password">
									&nbsp;&nbsp;&nbsp;&nbsp;密码必须最小为6位字符
							</div>
					</div>
					<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-lock"></i>
								<input type="password" name="rePassword" id="rePassword"  size = "41" maxlength= "120" class="form-control" placeholder="确认用户密码" onblur="rePassWord()">
							</div>
					</div>
					<div class="mark margin-bottom-sm">
            				<div for="rePassword" generated="true" class="red mark margin-bottom-sm" style="display: none;" id="p_rePassword">&nbsp;&nbsp;&nbsp;&nbsp;请确认用户密码</div>
            		</div>
            		<div class="mark margin-bottom-sm">
							<div for="password" generated="true" class="red"style="display: none;" id="q_rePassword">
									&nbsp;&nbsp;&nbsp;&nbsp两次输入密码不一致
							</div>
					</div>
					<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-tag"></i>
								<input type="text" name="validateCode" class="form-control" id="k_validateCode" placeholder="输入验证码" onblur="validateCode2();">
							</div>
					</div>
					<div class="mark margin-bottom-sm">
            				<div for="validateCode" generated="true" class="red mark margin-bottom-sm" style="display: none;" id="q_validateCode">&nbsp;&nbsp;&nbsp;&nbsp;验证码不能为空</div>
            		</div>
            		
            		<%--<%@ include file="/common/messages.jsp"%>
						<%if(request.getAttribute("customer")==null); %>
						<spring:bind path="customer.*">
							<c:if test="${not empty status.errorMessages}">
								<c:forEach var="error" items="${status.errorMessages}">
									<div class="error_box"><c:out value="${error}" escapeXml="false" /></div>
								</c:forEach>
							</c:if>
						</spring:bind>
						
						--%><div class="error_box" id="error_box1"><fmt:message key="customer.login.fail" /></div>
						<div class="error_box" id="error_box2"><fmt:message key="front.errorCode" /></div>
						<div class="error_box" id="error_box3"><fmt:message key="customer.login.first" /></div>
					<div class="w-l-yzm">
						<div class="w-l-itemscon">
							<a href="javascript:;" onClick="return refreshImage('register',this)">
                   					<img id="imgValidationCode" src="${ctxPath}/jCaptcha.html?type=register" title="点击改变" />
               					</a>
						</div>
					</div>
					<div class="w-l-info">
						<div class="w-l-itemscon">
							<label>
									<!--2015-8 蔡蔡改动-->  
										<input type="checkbox" id="checkboxre" onclick="checkbox1()"/> <a href="#" style="float:right; margin-top:2px; margin-left:5px;">我已阅读并接受四方街sifangstreet服务条款。</a>
		                            <!--end of 蔡蔡改动-->   
							</label>
						</div>
					</div>
					<div class="w-l-btn">
							<div class="w-l-itemscon">
								<button class="btn btn-default signup" type="submit" id="button1" style="display: none;">
									注册
								</button>
								<span class="btn btn-default un-signup" type="" id="button2">
									无法注册
								</span>
							</div>
					</div>

					<div class="w-l-note">
						<div class="w-l-itemscon">
							<span class="w-menu-lr">会员登录</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="w-nav navbar-fixed-top index-nav w-nav-s">
			<div class="container" style="position: relative;z-index: 1300;">
				<div class="w-sea">
					<div class="w-sea-list">
						<div class="w-sea-sj"></div>
						<div class="w-sea-con">
						<!-- 搜索 -->
						<form  method="get" id="searchForm" action="" >
							<input name="q" type="text" required placeholder="输入搜索内容" class="search_txt" "q">
                            <input type="submit" class="search_button" value="&rarr;" onclick="fnUnlock()">
						</form>
						</div>
					</div>
				</div>

				<div class="w-car">
					<div class="w-car-list">
						<div class="w-car-sj"></div>
						<div class="w-car-con">
							<ul class="list-unstyled clearfix">
								<c:forEach items="${shoppingcart.cartItems}" var="item" varStatus="varStatus" begin="0" end ="1">
								<c:if test="${item.isSaved==0 and empty item.parent}">
									<li class="clearfix">
									<div class="w-car-img">
										<product:productImg sku="${item.productSku}" size="e" width="100" height="100"/>
									</div>
									<div class="w-car-info">
										<span><product:productName product="${item.productSku.product}"/></span>
										<span>${item.productSku.product.brand.brandName}</span>
										<span class="w-car-price">￥<system:CurrencyForRate value="${item.price}" /></span>
									</div>
									</li>
								</c:if>
								</c:forEach>
							</ul>
							<div class="w-car-msg">购物车里还有${shoppingcart.buyNowItemsCount <=2 || shoppingcart.buyNowItemsCount ==null?0:shoppingcart.buyNowItemsCount -2}件物品</div>
							<div class="w-car-zj clearfix">
								<div class="w-car-zjmc">总计：</div>
								<div class="w-car-price">￥ ${shoppingcart.subtotal == null?0:shoppingcart.subtotal}</div>
							</div>
							<div class="w-car-btn">
								<a class="w-car-btn" href="/cart/shoppingcart.html">查看购物车</a>
							</div>
						</div>
					</div>
				</div>
				<div class="row visible-md-block visible-lg-block">
					<div class="col-md-2 col-lg-2 w-logo"><a href="${ctxPath}/index.html" id="w-logot">四方街</a>
					</div>
					<div class="col-md-6 col-lg-7">
						<ul class="w-menu list-unstyled">
							<li><a href="${ctxPath}/MarketIndex.html" id="MarketIndex"><span>商城</span></a>
							</li>
							<li><a href="${ctxPath}/culturalinformation/index.html" id="culturalinformation"><span>文化资讯</span></a>
							</li>
							<li><a href="${ctxPath}/designerList.html" id="designerList"><span class="w-menu-on">设计师</span></a>
							</li>
							<li><a href="${ctxPath}/customer_service/_18.html" id="customer_service"><span>关于我们</span></a>
							</li>
							<li><a href="${ctxPath}/coming.html" id="coming"><span>线下店铺</span></a>
							</li>
						</ul>
					</div>
					<div class="col-md-4 col-lg-3" style="padding-bottom: 50px;">
						<ul class="w-menu-right list-unstyled">
							<li><a href="javascript:void(0)"><span class="w-gwc">购物车 (${shoppingcart.buyNowItemsCount == null?0:shoppingcart.buyNowItemsCount})</span></a>
							</li>
							<li id="loginPromptHolderTemplateLogout">
								<a href="javascript:void(0)"><span class="w-menu-lr">登录/</span><span
									class="w-menu-lrzc">注册</span> </a>
							</li>
							<li id="loginPromptHolderTemplateLogin">
								<a href="/myaccount/account.html"><i class="fa fa-user"></i></a> (
								<a href="${ctxPath}/j_acegi_logout" rel="nofollow" onclick="window.location.href='${ctxPath}/j_acegi_logout'">退出</a>)&nbsp;&nbsp;
							</li>
							<li><a href="#"><span class="w-search">搜索</span> </a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row visible-sm-block visible-xs-block w-menusm">
					<div class="col-xs-4 col-sm-3 text-left">
						<a href="javascript:void(0)"><i class="fa fa-bars"></i></a>
					</div>
					<div class="col-xs-4 col-sm-6 w-logo text-center">
						<a href="#">四方街</a>
					</div>
					<div class="col-xs-4 col-sm-3 text-right w-gwct" style="padding-bottom: 50px;">
						<a href="javascript:void(0)"><span class="w-gwc">购物车 (0)</span></a>
					</div>

				</div>

			</div>
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
	                    <button id="button2id" name="button2id" class="btn btn-gold" type="button" onclick="checkAddress();">
		                提交
		                <i class="fa fa-chevron-right padding_left10"></i>
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
		<div class="w-footer">
			<div class="container">
				<div class="row">
					<div class="w-footer-con">
						<div class="w-footer-item w-footer-links col-lg-4">
							<span class="w-links">
							<a href="${ctxPath}/customer_service/_18.html">关于我们 | </a>
							<a href="${ctxPath}/coming.html">隐私保护政策 | </a>
							<a href="${ctxPath}/coming.html">使用条款 | </a>
							<a href="${ctxPath}/coming.html">商家入驻 | </a>
							<a href="${ctxPath}/coming.html">友情链接 | </a>
						</span>
                     <!--2015-8 蔡蔡改动-->
							<span>Copyright©2013-2014 &nbsp;SifangStreet四方街版权所有&nbsp;<a href="http://www.miibeian.gov.cn/">粤ICP备13075482号-1</a></span>
                            
                      <!--end of 蔡蔡改动-->
							<a href="http://www.anquan.org/s/www.sifangstreet.com" name="bIe7hLFwEsIGD6e0PKwvzqD2yXwpSzfTo6hyXQFEOOuySFBo9P" >安全联盟、百度</a>
							 <script type="text/javascript">
									var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
									document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F5987b6886920e65d633daea3a74b6ffe' type='text/javascript'%3E%3C/script%3E"));
							</script>
						</div><!--w-footer-item w-footer-links col-lg-4-->
						<div class="w-footer-item col-lg-4">
							<div class="w-footer-email">
                             <!--2015-8 蔡蔡改动---->
								<input type="text" class="email_txt" required placeholder="输入邮箱地址订阅最新资讯"/>
								<input type="submit" class="email_button" value="&rarr;" src="/resources/images/icon/btn_form.jpg" onclick="saveUserRss()">
                             <!--end of 蔡蔡改动-->
                             <script>
								function saveUserRss(){
									var userName = $("#userName").val();
									var email = $("#email").val();
									$.post(__ctxPath+"/customer/addUserRss.html",{userName:userName,email:email},function(result){
										if(result.status==1){
											alert("订阅成功！");
										}else{
										}
									},"json");
								}
							</script>
							</div>
						</div><!--w-footer-item col-lg-4-->
						<div class="w-footer-item w-footer-con col-lg-4">
							<span>联系我们</span>
							<span>邮箱：cs@sifangstreet.com 电话：4008976336 周一至周五 9:30-18:30 节假日休息</span>
                            <!--2015-8 蔡蔡改动-->
							<span>
                              <!-- WPA Button Begin -->

                               <!--<script charset="utf-8" type="text/javascript" src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODAxODYxMl8yMDgwNTlfNDAwNjYxNTY3N18"></script> -->
                              <!--<a target="_blank" href ="http://webim.qiao.baidu.com//im/index?siteid=4706350&ucid=7282853"><img src="/resources/images/baidushangqiao.png"/></a>-->
                              <a target="_blank" href="http://sighttp.qq.com/authd?IDKEY=c3cc32bebc6899c096fda967ed082d5ca51abca8944190c6"><img border="0"  src="http://wpa.qq.com/imgd?IDKEY=c3cc32bebc6899c096fda967ed082d5ca51abca8944190c6&pic=51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
                              <!-- WPA Button End -->
                              <a target="_blank" href="http://weibo.com/sifangstreet" class="social_link">
									<i class="fa fa-weibo fa-lg"></i>
							  </a>
                               
                               <a target="_blank" href="http://www.sifangstreet.com/resources/images/weixin.jpg" class="social_link">
									<i class="fa fa-weixin fa-lg"></i>
							  </a>

                              
							</span>
                            <!--end of 蔡蔡改动-->
						</div><!--w-footer-item w-footer-con col-lg-4-->
					</div><!--w-footer-con-->
				</div><!--row-->
			</div><!--container-->
		</div><!--w-footer-->
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