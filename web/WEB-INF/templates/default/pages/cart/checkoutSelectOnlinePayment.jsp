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
        <link href="${resPath}/styles/css/submit-order.css" rel="stylesheet">
        <link href="${resPath }/styles/pay.css" rel="stylesheet" type="text/css" />
        <style>
		.w-nav{
			border-bottom: 1px #000000 solid;
		}
		</style>

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
			var errorCode = getCookie("errorCode");
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
					if(errorCode!=""&&errorCode!=null){
						$("#error_box1").hide();
						$("#error_box2").show();
						$("#error_box3").hide();
						delCookie("errorCode");
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

	function checkLogin(){
		if(!userName()||!passWord()||!validateMethod()){
			return false;
			}else{
				return true;
				}
		} 

	function userName() {
		var username = getLoginUserEmail(false);
		if ($("#j_username").val().trim().length == 0) {
			$("#p_username").show();
			return false;
		}else{
			$("#p_username").hide();
			return true;
		}
	}

	function passWord() {
		var password = $("#j_password").val().trim();
		if (password.length == 0) {
			$("#p_password").show();
			$("#q_password").hide();
			return false;
		}else if(password.length>0 && password.length<6){
			$("#p_password").hide();
			$("#q_password").show();
			return false;
		}else{
			$("#p_password").hide();
			$("#q_password").hide();
			return true;
		}
	}

	function validateMethod() {
		var validatecode = $("#j_validateCode").val().trim();
		if(validatecode.length ==0){
			$("#p_validateCode").show();
			return false;
		}else{
			$("#p_validateCode").hide();
			return true;
		}
	}

	function validateCode2() {
		var validatecode = $("#k_validateCode").val().trim();
		if(validatecode.length ==0){
			$("#q_validateCode").show();
			return false;
		}else{
			$("#q_validateCode").hide();
			return true;
		}
	}

	function emailPhone() {
		if ($("#email").val().trim().length == 0) {
			$("#p_email").show();
			return false;
		}else{
			$("#p_email").hide();
			return true;
		}
	}

	function telePhone() {
		var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
		if ($("#telephone").val().trim().length == 0) {
			$("#p_telephone").show();
			return false;
		}else if(reg.test($("#telephone").val().trim())){
			$("#p_telephone").hide();
			return true;
		}
		$("#p_telephone").show();
		return false;
	}

	function checkRegister(){
		if(!emailPhone()||!telePhone()||!passWord2()||!rePassWord()||!validateCode2()){
			return false;
			}else{
				return true;
				}
		} 

	function passWord2() {
		var password = $("#password").val().trim();
		if (password.length == 0) {
			$("#a_password").show();
			$("#o_password").hide();
			return false;
		}else if(password.length>0 && password.length<6){
			$("#a_password").hide();
			$("#o_password").show();
			return false;
		}else{
			$("#a_password").hide();
			$("#o_password").hide();
			return true;
		}
	}

	function rePassWord() {
		var password = $("#password").val().trim();
		var rePassword = $("#rePassword").val().trim();
		if (rePassword.length == 0) {
			$("#p_rePassword").show();
			$("#q_rePassword").hide();
			return false;
		}else if(rePassword !=password){
			$("#p_rePassword").hide();
			$("#q_rePassword").show();
			return false;
		}else{
			$("#p_rePassword").hide();
			$("#q_rePassword").hide();
			return true;
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
	</head>

	<body>
	 <script>
  function doGotoPaymentGateway(){
	  var pm = $("input:radio[name='paymentMethodId']:checked").val();
	  if(pm == '' || pm == undefined){
		  alert("请选择支付银行！");
		  //return false;
	  }else{
		  $("#frmGotoPaymentGateway").submit();
	  }
  }
</script>
        <!--[if lt IE 8]>
       <p class="browserupgrade">你正在使用一个 <strong>过时的</strong> 浏览器. 请 <a href="http://browsehappy.com/">提高您的浏览器</a> 以提高您的经验.</p>
       <![endif]-->
		<!--登陆注册-->
		<div class="w-login">
			<div class="w-login-s"></div>
			<div class="w-login-c">
			
				<form method="post" name="loginForm" id="loginForm"
					action="${ctxPath}/index_check.html" onsubmit="return checkLogin()">
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
						<div class="error_box" id="error_box3"><fmt:message key="customer.login.first" /></div>
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
					
					
					<form id="customerRegisterForm" action="register.html" method="post" onsubmit="return checkRegister()">
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
						<%if(request.getAttribute("customer")==null)request.setAttribute("customer",new Customer()); %>
						<spring:bind path="customer.*">
							<c:if test="${not empty status.errorMessages}">
								<c:forEach var="error" items="${status.errorMessages}">
									<div class="error_box"><c:out value="${error}" escapeXml="false" /></div>
								</c:forEach>
							</c:if>
						</spring:bind>
						
						--%><c:if test="${param.error != null}">
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
								<a href="${ctxPath}/MarketIndex.html"><span>商城</span> </a>
							</li>
							<li>
								<a href="${ctxPath}/culturalinformation/index.html"><span>文化资讯</span>
								</a>
							</li>
							<li>
								<a href="${ctxPath}/designerList.html"><span>设计师</span> </a>
							</li>
							<li>
								<a href="${ctxPath}/customer_service/_18.html"><span>关于我们</span> </a>
							</li>
							<li>
								<a href="${ctxPath}/coming.html"><span>线下店铺</span> </a>
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
								<a href="/myaccount/account.html" id="myAccountUrl"><i class="fa fa-user"></i></a> (
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
						<a href="${ctxPath}/index.html">四方街</a>
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
        <!--end of 导航-->
        <form name="frmGotoPaymentGateway" id="frmGotoPaymentGateway" action="${ctxPath}/checkout/goToPay.html" method="post" >
		<c:choose>
			<c:when test="${salesOrder.isCod == 0}">
				<div class="w-submit-order">
		        	<div class="w-submit-order-hd">
		            	<div class="order-hd-tit">订单已生成</div>
		                <div class="order-hd-number">
		                	<p>订单号：<b>${salesOrder.orderNo}</b></p>
		                    <p><span>应付款：<system:CurrencyForRate value="${salesOrder.shouldPay}" /></span></p>
		                </div>
		                <div class="order-hd-ps">
		                	<p><span>请您尽快完成支付，以便我们尽快安排发货。</span></p>
		                    <p>请您在提交订单后的72小时内完成支付，否则订单将会自动取消。</p>
		                </div>
		            </div>
		            <div class="w-submit-order-bd">
		            	<div class="tabs-banks">
		                	<ul id="tabs" class="row">
		                    	<li><a href="#" name="#tab1">网银支付 | </a></li>
		                        <li><a href="#" name="#tab2">信用卡支付 | </a></li>
		                        <li><a href="#" name="#tab3">第三方平台支付</a></li>
		                    </ul>
		                    <div id="banks-contents">
		                    	<div id="tab1">
		                        	<div class="banks-list">
		                                <ul class="row">
		                                	<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'boc'}">
				                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }" >
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-boc" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                           	</label></li>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'abc'}">
				                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-abc" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                             	<%--
					                             	<div class="add_more_tab">0元抢Selvä面膜</div>
					                           	--%></label></li>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
				                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
					                             	<span id="bank-cmb" class="bank-logo"></span>
					                             	<div class="add_more"></div>
					                             	<%--<div class="add_more_tab">折上再9折特价品除外</div>	--%>
					                             </label></li>
			                      			</c:if>
			                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbc'}">
				                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
					                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
					                             	<span id="bank-cmbc" class="bank-logo"></span>	
					                             	<div class="add_more"></div>	                              
					                        </label></li>
					                             	 	
			                      			</c:if>
			                      		</c:forEach>
			                      		
			                          <li><input type="radio" name="paymentMethodId" id="inlineRadio2" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ccb" class="bank-logo"></span>
			                           </label></li>
		                                
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio6" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cib" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio7" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-icbc" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio8" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bcom" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio9" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hxb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio10" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio11" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-spdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio12" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-sdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio13" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-citic" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio14" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-post" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio15" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ceb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio16" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bob" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio17" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-pab" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio18" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cbhb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio19" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hzb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio20" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-srcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio21" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-shb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio22" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-wzcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio23" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-jsb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio24" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-nbcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio25" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gzns" class="bank-logo"></span>
			                           </label></li>
		                                </ul>
		                                <div class="more-banks"><a href="javascript:;" class="more-banks-btn">
		                                <i class="fa fa-plus"></i>更多银行</a><a href="javascript:;" class="go-pay" onclick="doGotoPaymentGateway();">立即支付</a></div>
		                            </div>
		                        </div>
		                        <div id="tab2">
		                        	<div class="banks-list">
		                                <ul class="row">
		                                	<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'boc'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
						                             	<span id="bank-boc" class="bank-logo"></span>
						                             	<div class="add_more"></div>
						                           	</label></li>
				                      			</c:if>
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'abc'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
						                             	<span id="bank-abc" class="bank-logo"></span>
						                             	<div class="add_more"></div>
						                           	</label></li>
				                      			</c:if>
				                      			
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
						                             	<span id="bank-cmb" class="bank-logo"></span>
						                             	<div class="add_more"></div>
						                           	</label></li>
				                      			</c:if>
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbc'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }">
						                             	<span id="bank-cmbc" class="bank-logo"></span>
						                             	<div class="add_more"></div>
						                           	</label></li>
				                      			</c:if>
				                      		</c:forEach>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio2" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ccb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio6" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cib" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio7" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-icbc" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio8" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bcom" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio9" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hxb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio10" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio11" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-spdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio12" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-sdb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio13" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-citic" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio14" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-post" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio15" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-ceb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio16" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-bob" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio17" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-pab" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio18" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-cbhb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio19" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-hzb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio20" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-srcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio21" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-shb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio22" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-wzcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio23" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-jsb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio24" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-nbcb" class="bank-logo"></span>
			                           </label></li>
		                                    <li><input type="radio" name="paymentMethodId" id="inlineRadio25" value="27">
			                           <label class="radio-inline">
			                             <span id="bank-gzns" class="bank-logo"></span>
			                           </label></li>
		                                </ul>
		                                <div class="more-banks"><a href="javascript:;" class="more-banks-btn"><i class="fa fa-plus"></i>更多银行</a><a href="javascript:;" class="go-pay" onclick="doGotoPaymentGateway();">立即支付</a></div>
		                            </div>
		                        </div>
		                        <div id="tab3">
		                        	<div class="others-pay">
		                                <ul class="row">
		                                	<c:forEach items="${paymentMethodList}" var="paymentMethod" varStatus="status">
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'unionpay'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
						                             	<span id="pay-unionpay" class="pay-logo"></span>
						                           	</label></li>
				                      			</c:if>
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'alipay'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.id }" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.id }">
						                             	<span id="pay-alipay" class="pay-logo"></span>
						                           	</label></li>
				                      			</c:if>
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmb'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode }_c" value="${paymentMethod.id }">
						                           	<label class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode }_c">
						                             	<span id="pay-yiwangtong" class="pay-logo"></span>
						                           	</label></li>
				                      			</c:if>
				                      			
				                      			<c:if test="${paymentMethod.paymentMethodCode == 'cmbehome'}">
					                      			<li><input type="radio" name="paymentMethodId" id="paymentMethod_${paymentMethod.paymentMethodCode}" value="${paymentMethod.id }"
					                      			title="需从招商银行企业e家那边登录跳转过来的用户才可正常支付">
						                           	<label title="需从招商银行企业e家那边登录跳转过来的用户才可正常支付"  class="radio-inline" for="paymentMethod_${paymentMethod.paymentMethodCode}">
						                             	<span id="pay-rengxingpay" class="pay-logo"></span>
						                           	</label></li>
				                      			</c:if>
				                      			
				                      		</c:forEach>
		                                </ul>
		                            </div>
		                            <div class="more-banks"><a href="javascript:;" class="go-pay" onclick="doGotoPaymentGateway();">立即支付</a></div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
			</c:when>
			
			<c:when test="${salesOrder.isCod == 1}">
					<div class="w-submit-order">
			        	<div class="w-submit-order-hd">
			            	<div class="order-hd-tit">订单已生成</div>
			                <div class="order-hd-number">
			                	<p>订单号：<b>${salesOrder.orderNo }</b></p>
			                    <p><span>应付款：<system:CurrencyForRate value="${salesOrder.shouldPay}" /></span></p>
			                </div>
			                <div class="order-hd-ps">
			                	<p><span>我们将尽快安排发货，请在收货时把应付金额交给快递人员代收。</span></p>
			                </div>
			            </div>
			        </div>
					
			</c:when>
			<c:otherwise>
				<div class="w-submit-order">
		        	<div class="w-submit-order-hd">
		            	<div class="order-hd-tit">订单已生成</div>
		                <div class="order-hd-number">
		                	<p>订单号：<b>${salesOrder.orderNo }</b></p>
		                    <p><span>应付款：￥${salesOrder.shouldPay}</span></p>
		                </div>
		                <ul>
		                	<li><span></span>请您尽快完成支付，以便我们尽快安排发货。</li>
		                    <li><span></span>请您在提交订单后的72小时内完成支付，否则订单将会自动取消。</li>
		                    <li><span></span>请在成功付款后，截取【成功支付页面】至我们的客服邮箱cs@sifangstreet.com</li>
		                    <li><span></span>我们客服人员将会第一时间为您核查到账情况，并安排发货，并会以邮件形式回复您结果，谢谢配合。</li>
		                    <li><span></span>在客服核查期间，系统依然会显示“待支付”，属于正常现象，请耐心等候邮件通知。</li>
		                </ul>
		            </div>
		            <div class="w-submit-order-bd">
		                <table width="100%" border="0" cellspacing="0" cellpadding="0">
		                    <tr>
		                        <td>转账银行</td>
		                        <td>户名</td>
		                        <td>账号</td>
		                        <td>开户行</td>
		                    </tr>
		                    <tr>
			               <td class="bank_table"><span id="bank-boc" class="bank-logo"></span></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">678261846178</td>
			               <td class="align_left">中国银行股份有限公司广州东风东路支行</td>
			             </tr>
			              <tr>
			               <td class="bank_table"><span id="bank-ccb" class="bank-logo"></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">44001400115053006279</td>
			               <td class="align_left">中国建设银行广州东宝大厦支行</td>
			             </tr>
			              <tr>
			               <td class="bank_table"><span id="bank-cmb" class="bank-logo"></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">120908323010505</td>
			               <td class="align_left">招商银行股份有限公司广州锦城大厦支行</td>
			             </tr>
			              <tr>
			               <td class="bank_table"><span id="bank-abc" class="bank-logo"></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">44306001040009002</td>
			               <td class="align_left">中国农业银行东莞洪梅支行</td>
			             </tr>
			              <tr>
			               <td class="bank_table"><span id="bank-cmbc" class="bank-logo"></span></td>
			               <td>广州名度网络技术有限公司</td>
			               <td class="bank_num">691131279</td>
			               <td class="align_left">中国民生银行广州分行</td>
			             </tr>
		                </table>
		            </div>
		        </div>
			</c:otherwise>
		</c:choose>
		<input type="hidden" name="orderNo" value="${salesOrder.orderNo}" />
		<input type="hidden" name="doAction" value="gotoPaymentGateway" />
	</form>
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
<!-----在线支付银行tabs-------->
        <script type="text/javascript">
			function resetTabs(){
				$("#banks-contents > div").hide();
				$("#tabs a").attr("id","");
			}
			
			var myUrl = window.location.href;
			var myUrlTab = myUrl.substring(myUrl.indexOf("#")); 
			var myUrlTabName = myUrlTab.substring(0,4);
			
			(function(){
				$("#banks-contents > div").hide();
				$("#tabs li:first a").attr("id","current");
				$("#banks-contents > div:first").fadeIn();
			
				$("#tabs a").on("click",function(e) {
					e.preventDefault();
					if ($(this).attr("id") == "current"){
						return       
					}else{             
						resetTabs();
						$(this).attr("id","current");
						$($(this).attr('name')).fadeIn(); 
					}
				});
			
				for (i = 1; i <= $("#tabs li").length; i++) {
					if(myUrlTab == myUrlTabName + i){
						resetTabs();
						$("a[name='"+myUrlTab+"']").attr("id","current");
						$(myUrlTab).fadeIn();
					}
				}
			})()
		</script>
        
        <!------展开更多银行------>
        <script type="text/javascript">
        	$(function(){
					$(".more-banks a.more-banks-btn").click(function(){
							if($(this).parent().parent().hasClass("active")){
									$(this).parent().parent().removeClass("active").find("ul").css("height","47px")
								}else{
									$(this).parent().parent().addClass("active").find("ul").css("height","auto")
									}
						})
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
        	$(function(){
					$(window).scroll(function(){
						$(".index-nav").addClass("w-nav-s")
					})
				})
        </script>
	</body>

</html>