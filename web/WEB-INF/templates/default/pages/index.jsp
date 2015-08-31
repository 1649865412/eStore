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
		<%@ include file=".././decorators/include/meta.jspf"%>
		<%@ include file=".././decorators/include/styles2.jspf"%>
		<%@ include file=".././decorators/include/styles3.jspf"%>
		<%@ include file=".././decorators/include/styles5.jspf"%>
		<%@ include file=".././decorators/include/javascripts2.jspf"%>
		<script type="text/javascript"
			src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript"
			src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
		<!-- Bootstrap -->
		<link rel="stylesheet"
			href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		<link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
		<link href="${resPath}/styles/css/bootstrap.css" rel="stylesheet">
		<link href="${resPath}/styles/css/swiper.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/animate.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/index.css" rel="stylesheet">
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function(){
			$("#error_box1").hide();
			$("#error_box2").hide();
			
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
						delCookie("error");
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

	function passWord2() {
		var password = $("#password").val().trim();
		if (password.length == 0) {
			$("#a_password").show();
			$("#b_password").hide();
		}else if(password.length>0 && password.length<6){
			$("#a_password").hide();
			$("#b_password").show();
		}else{
			$("#a_password").hide();
			$("#b_password").hide();
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
	jQuery(document).ready(function($) {
		$('.grid-container').gridQuote( {
			slideshow : false,
			initOpen : false
		});
	});
</script>

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
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
						<div class="w-l-title">
							会员登陆
						</div>
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
						<%if(request.getAttribute("customer")==null)request.setAttribute("customer",new Customer()); %>
						<spring:bind path="customer.*">
							<c:if test="${not empty status.errorMessages}">
								<c:forEach var="error" items="${status.errorMessages}">
									<div class="error_box"><c:out value="${error}" escapeXml="false" /></div>
								</c:forEach>
							</c:if>
						</spring:bind>
						--%><div class="error_box" id="error_box1"><fmt:message key="customer.login.fail" /></div>
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
						<div class="w-l-title">
							注册新会员
						</div>
						<div class="w-l-items w-l-user">
							<div class="w-l-itemscon">
								<i class="fa fa-user"></i>
								<input type="text" id="email" name="email" value="${status.value}" size = "41" maxlength="128" class="form-control"  placeholder="邮箱/手机" onblur="emailPhone();">
							</div>
						</div>
						<div class="mark margin-bottom-sm">
           					<div for="email" generated="true" class="red mark margin-bottom-sm" style="display: none;" id="p_email">&nbsp;&nbsp;&nbsp;&nbsp;邮箱/手机不能为空</div>
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
								<div for="password" generated="true" class="red"style="display: none;" id="q_password">
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
            			
            			<%@ include file="/common/messages.jsp"%>
						<%if(request.getAttribute("customer")==null)request.setAttribute("customer",new Customer()); %>
						<spring:bind path="customer.*">
							<c:if test="${not empty status.errorMessages}">
								<c:forEach var="error" items="${status.errorMessages}">
									<div class="error_box"><c:out value="${error}" escapeXml="false" /></div>
								</c:forEach>
							</c:if>
						</spring:bind>
						
						<c:if test="${param.error != null}">
							<div class="error_box"><fmt:message key="customer.login.fail" /></div>
						</c:if>
						<c:if test="${param.errorCode != null}">
							<div class="error_box"><fmt:message key="front.errorCode" /></div>
						</c:if>
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
									<input type="checkbox" id="checkboxre" class="regular-checkbox" onclick="checkbox1()"/>
									我已阅读并接受四方街sifangstreet服务条款。
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
					</form>
			</div>
		</div>
		<div class="w-nav navbar-fixed-top">
			<div class="container" style="position: relative; z-index: 1300;">
				<div class="w-sea">
					<div class="w-sea-list">
						<div class="w-sea-sj"></div>
						<div class="w-sea-con">
						<!-- 搜索 -->
						<form  method="get" id="searchForm" action="" >
								<input name="q" type="text" title="Search for" autocomplete="off" id="q"/>
								<i class="fa fa-long-arrow-right" onclick="fnUnlock()"></i>
								</span>
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
							<div class="w-car-msg">
								购物车里还有${shoppingcart.buyNowItemsCount <=2 || shoppingcart.buyNowItemsCount ==null?0:shoppingcart.buyNowItemsCount -2}件物品
							</div>
							<div class="w-car-zj clearfix">
								<div class="w-car-zjmc">
									总计：
								</div>
								<div class="w-car-price">
									￥ ${shoppingcart.subtotal == null?0:shoppingcart.subtotal}
								</div>
							</div>
							<div class="w-car-btn">
								<a class="w-car-btn" href="/cart/shoppingcart.html">查看购物车</a>
							</div>
						</div>
					</div>
				</div>
				<div class="row visible-md-block visible-lg-block">
					<div class="col-md-2 col-lg-2 w-logo">
						<a href="${ctxPath}/index.html">四方街</a>
					</div>
					<div class="col-md-6 col-lg-7">
						<ul class="w-menu list-unstyled">
							<li>
								<a href="${ctxPath}/MarketIndex.html"><span class="w-menu-on">商城</span> </a>
							</li>
							<li>
								<a href="${ctxPath}/culturalinformation/index.html"><span>文化资讯</span>
								</a>
							</li>
							<li>
								<a href="${ctxPath}/designerList.html"><span>设计师</span> </a>
							</li>
							<li>
								<a href="#"><span>关于我们</span> </a>
							</li>
							<li>
								<a href="#"><span>线下店铺</span> </a>
							</li>
						</ul>
					</div>
					<div class="col-md-4 col-lg-3" style="padding-bottom: 50px;">
						<ul class="w-menu-right list-unstyled">
							<li>
								<a href="javascript:void(0)"><span class="w-gwc">购物车
										(${shoppingcart.buyNowItemsCount})</span> </a>
							</li>
							<li id="loginPromptHolderTemplateLogout">
								<a href="javascript:void(0)"><span class="w-menu-lr">登录/</span><span
									class="w-menu-lrzc">注册</span> </a>
							</li>
							<li id="loginPromptHolderTemplateLogin">
								<a href="javascript:void(0)"><span id="username" class="w-gwc"></span> </a> (
								<a href="${ctxPath}/j_acegi_logout" rel="nofollow" onclick="window.location.href='${ctxPath}/j_acegi_logout'">退出</a>)&nbsp;&nbsp;
							</li>
							<li>
								<a href="#"><span class="w-search">搜索</span> </a>
							</li>
						</ul>
					</div>
				</div>
				<div class="row visible-sm-block visible-xs-block w-menusm">
					<div class="col-xs-4 col-sm-3 text-left">
						<a href="javascript:void(0)"><i class="fa fa-bars"></i> </a>
					</div>
					<div class="col-xs-4 col-sm-6 w-logo text-center">
						<a href="#">四方街</a>
					</div>
					<div class="col-xs-4 col-sm-3 text-right w-gwct"
						style="padding-bottom: 50px;">
						<a href="javascript:void(0)"><span class="w-gwc">购物车
								(0)</span> </a>
					</div>

				</div>

			</div>
			<div class="w-menush visible-sm-block visible-xs-block">
				<ul class="w-menush-items list-unstyled">
					<li>
						<a href="#"><span class="w-menu-on">商城</span> </a>
					</li>
					<li>
						<a href="list.html"><span>文化资讯</span> </a>
					</li>
					<li>
						<a href="#"><span>设计师</span> </a>
					</li>
					<li>
						<a href="#"><span>关于我们</span> </a>
					</li>
					<li>
						<a href="#"><span>线下店铺</span> </a>
					</li>
					<li>
						<a href="javascript:void(0)"><span class="w-menu-lr">登录/</span><span
							class="w-menu-lrzc">注册</span> </a>
					</li>
					<li>
						<a href="#"><span>搜索</span> </a>
					</li>
				</ul>
			</div>
		</div>

		<div class="w-slide jumbotron">
			<div class="swiper-container">
				<div class="swiper-page-right">
					<div class="swiper-page-next">
						<i class="fa fa-angle-right"></i>
					</div>
				</div>
				<div class="swiper-page-left">
					<div class="swiper-page-prev">
						<i class="fa fa-angle-left"></i>
					</div>
				</div>

				<div class="swiper-wrapper">
					<%--首页轮播图，目前数量为4，如需改动数量可在此修改 --%>
					<content:showAdNew adPositionType="mainadNew1" />

					<content:showAdNew adPositionType="mainadNew2" />

					<content:showAdNew adPositionType="mainadNew3" />

					<content:showAdNew adPositionType="mainadNew4" />

				</div>
			</div>
		</div>
		<div class="w-banner jumbotron">
			<content:showAdNew adPositionType="mainsadNew1" />
		</div>
		<div class="w-bannert jumbotron ">
			<content:showAdNew adPositionType="mainsadNew2" />
		</div>

		<div class="w-lf jumbotron clearfix">
			<div class="w-lf-con">
				<content:showAdNew adPositionType="mainsadNew3" />
				<div class="w-lf-cen">
					<div class="w-lf-br"></div>
				</div>
				<content:showAdNew adPositionType="mainsadNew4" />
			</div>
		</div>

		<div class="w-mem">
			<div class="w-mem-hse"></div>
			<div class="container">
				<div class="row">

					<div class="w-mem-hr">
						<div class="w-mem-hrt">
							最新入驻设计师
						</div>
					</div>
					<div class="w-mem-list">
						<c:forEach items="${brandList}" var="brand" varStatus="varStatus"
							end="4">
							<div class="w-mem-con">
								<span class="w-mem-cn">${brand.designer}</span>
								<span class="w-mem-en">${brand.brandName}</span>
								<figure class="w-mem-milo">

								<img src="${mediaPath}other/${brand.pic}" alt="img11" />
								<figcaption>
								<div class="w-mem-bg">
								</div>
								<p>
									${brand.story}
								</p>

								</figcaption>
								</figure>
							</div>


						</c:forEach>

					</div>
				</div>
			</div>
		</div>
		<div class="w-footer">
			<div class="container">
				<div class="row">
					<div class="w-footer-con">
						<div class="w-footer-item w-footer-links col-lg-4">
							<span class="w-links"> <a href="#">关于我们 | </a> <a href="#">隐私保护政策
									| </a> <a href="#">使用条款 | </a> <a href="#">商家入驻 | </a> <a href="#">友情链接
									| </a> <a href="#">优品联盟</a> </span>
							<span>Copyright©2013-2014 SifangStreet四方街版权所有
								粤ICP备13075482号-1</span>
							<a href="http://www.anquan.org/s/www.sifangstreet.com"
								name="bIe7hLFwEsIGD6e0PKwvzqD2yXwpSzfTo6hyXQFEOOuySFBo9P">安全联盟、百度</a>
							<script type="text/javascript">
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://"
			: " http://");
	document
			.write(unescape("%3Cscript src='"
					+ _bdhmProtocol
					+ "hm.baidu.com/h.js%3F5987b6886920e65d633daea3a74b6ffe' type='text/javascript'%3E%3C/script%3E"));
</script>
						</div>
						<div class="w-footer-item col-lg-4">
							<div class="w-footer-email">
								<input type="text" name="" value="输入邮箱地址订阅最新资讯" />
								<a> <i class="fa fa-arrow-right"></i> </a>
							</div>
						</div>
						<div class="w-footer-item w-footer-con col-lg-4">
							<span>联系我们</span>
							<span>邮箱：cs@sifangstreet.com 电话：4008976336 周一至周五
								9:30-18:30 节假日休息</span>
							<span><img src="${resPath}/images/img/yj.png" /> </span>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>

		<script>
	function index_login(){
		  var url =""+self.location.href;
		   $("#papeurl").val(url);
		    //alert( $("#papeurl").val());
		    $("#loginForm").submit();
		}
		
	var swiper = new Swiper('.swiper-container', {
		nextButton : '.swiper-page-next',
		prevButton : '.swiper-page-prev',
		paginationClickable : true,
		spaceBetween : 0,
		mousewheelControl : false,
		//							autoplay: 5000,
		speed : 500,
		onInit : function(swiper) {
			swiperAnimateCache(swiper);
			swiperAnimate(swiper);
		},
		onSlideChangeEnd : function(swiper) {
			swiperAnimate(swiper);
		},
		onTransitionEnd : function(swiper) {
			swiperAnimate(swiper);
		}
	});

	function refreshImage(type, obj) {
		//var image=document.getElementById("imgValidationCode");
		var image = $(obj).children()[0];
		var url = "${ctxPath}/jCaptcha.html?type=" + type;
		var xmlHttpReq = null;
		if (window.ActiveXObject) {
			xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xmlHttpReq = new XMLHttpRequest();
		}
		xmlHttpReq.open("Post", url, true);
		xmlHttpReq.send(null);

		image.src = "${ctxPath}/jCaptcha.html?rand="
				+ parseInt(1000 * Math.random());
		return false;
	}
</script>



	</body>

</html>