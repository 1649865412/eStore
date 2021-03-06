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
		<%@ include file="../../decorators/include/javascripts.jspf"%>
		<%@ include file="../../decorators/include/styles7.jspf"%>
        <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
        <link href="${resPath}/styles/css/designers.css" rel="stylesheet">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
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
			alert("hello1");
			var skuOptions=$("#skuOptions").children("div.tb-prop").find("ul[data-property]");
			var name="";
			skuOptions.each(function(i){
				if($(this).find("li.tb-selected").length==0){
					name+="."+$(this).attr("data-property");
				}
			});
			alert("name="+name);
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
							<li><a href="${ctxPath}/culturalinformation/index.html" id="culturalinformation"><span class="w-menu-on">文化资讯</span></a>
							</li>
							<li><a href="${ctxPath}/designerList.html" id="designerList"><span>设计师</span></a>
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
						<a href="${ctxPath}/index.html">四方街</a>
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
		<div class="w-designers">
	        <div class="w-designers-hd">
	        	<div><a class="active num" href="/designerList.html">A-Z</a><a href="/designer/initialsSelect.html?initials=A">A</a><a href="/designer/initialsSelect.html?initials=B">B</a><a href="/designer/initialsSelect.html?initials=C">C</a><a href="/designer/initialsSelect.html?initials=D">D</a><a href="/designer/initialsSelect.html?initials=E">E</a><a href="/designer/initialsSelect.html?initials=F">F</a><a href="/designer/initialsSelect.html?initials=G">G</a><a href="/designer/initialsSelect.html?initials=H">H</a><a href="/designer/initialsSelect.html?initials=I">I</a><a href="/designer/initialsSelect.html?initials=J">J</a><a href="/designer/initialsSelect.html?initials=K">K</a><a href="/designer/initialsSelect.html?initials=L">L</a><a href="/designer/initialsSelect.html?initials=M">M</a><a href="/designer/initialsSelect.html?initials=N">N</a><a href="/designer/initialsSelect.html?initials=O">O</a><a href="/designer/initialsSelect.html?initials=P">P</a><a href="/designer/initialsSelect.html?initials=Q">Q</a><a href="/designer/initialsSelect.html?initials=R">R</a><a href="/designer/initialsSelect.html?initials=S">S</a><a href="/designer/initialsSelect.html?initials=T">T</a><a href="/designer/initialsSelect.html?initials=U">U</a><a href="/designer/initialsSelect.html?initials=V">V</a><a href="/designer/initialsSelect.html?initials=W">W</a><a href="/designer/initialsSelect.html?initials=X">X</a><a href="/designer/initialsSelect.html?initials=Y">Y</a><a href="/designer/initialsSelect.html?initials=Z">Z</a>
	        	</div>
	        </div>
        
        	
        	<c:if test="${empty mapResult}">
			           <h2 class="designer_nav_title" style="padding-top:180px;">暂无设计师</h1>
		  </c:if>
		  
		  <c:if test="${!empty mapResult}">
        			   <c:forEach items="${mapResult}" var="map">
			           <h3 class="designer_nav_title" style="padding-top:180px;">${map.key}</h3>
			           	<div class="w-mem-list w-mem-list2 c">
			              <c:forEach items="${map.value}" var="brand">
			              	<a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}">
						            <div class="w-mem-con">
						                <span class="w-mem-cn">${brand.designer}</span>
						                <span class="w-mem-en">${brand.brandName}</span>
						                <figure class="w-mem-milo">
						                    <img src="${mediaPath}/other/${brand.icon}" alt="img11" class="w-mem-imgo" />
						                    <img src="${mediaPath}/other/${brand.logo}" alt="img11" class="w-mem-imgt" />
						                    <figcaption>
						                        <div class="w-mem-bg">
						                        </div>
						                        <p>${brand.quotation}</p>
						                    </figcaption>
						                </figure>
						            </div>
						       </a>
			              </c:forEach>
			              </div><!-- w-mem-list2 end-->
			  </c:forEach>
        		
        	</c:if>
        </div>
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
							<span>邮箱：cs@sifangstreet.com 电话：4006615677 周一至周五 9:30-18:30 节假日休息</span>
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
		<script type="text/javascript">
		
			//设计师锚点跳转
	        $(function () {
	            $(".w-designers-hd a").on("click", function () {
	                var catid = $(this).attr("catid");
	                $(this).addClass("active").siblings().removeClass("active")
	                var top = $(".designer_nav_title[catid='" + catid + "']").offset().top;
	                if ($(window).width() > 992) {
	                    $(window).scrollTop(top - 195);
	                } else {
	                    $(window).scrollTop(top - 50);
	                }
	            });
	        });
	
	        //改变数字锚点
	        $(function () {
	            if ($(window).width() > 980) {
	                $(".w-designers-hd a:first-child").html("0-9")
	            } else {
	                $(".w-designers-hd a:first-child").html("0<br>|<br>9")
	            }
	            window.onresize = function () {
	                if ($(window).width() > 980) {
	                    $(".w-designers-hd a:first-child").html("0-9")
	                } else {
	                    $(".w-designers-hd a:first-child").html("0<br>|<br>9")
	                }
	            }
	        })
	
	
	    </script>
	</body>

</html>