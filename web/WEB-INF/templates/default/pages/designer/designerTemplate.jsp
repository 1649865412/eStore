<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page pageEncoding="utf-8"%>
<%@page import="com.cartmatic.estore.common.model.catalog.ProductReview"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.cartmatic.estore.common.model.catalog.ProductDescription"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags/app"%>
<!--设计师详情页-->
<html lang="en" class="no-js">
	<head>
		<c:set var="productPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></c:set>
		<c:set value="${empty product.title?product.productName:product.title}" var="pageTitle"></c:set>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<script src="${ctxPath}/scripts/jquery/js/global_brain.js"></script>
		<%@ include file="../../decorators/include/javascripts.jspf"%>
	    <%@ include file="../../decorators/include/styles7.jspf"%>
	    <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
	    <link href="${ctxPath}/scripts/jquery/js/colorbox/colorbox.css" rel="stylesheet" />
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
		
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
			<div class="designer_show">
            <div class="swiper-wrapper">
             <c:if test="${brand.pic2 !=null&&fn:trim(brand.pic2)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic2}" mediaType="other" ></cartmatic:img>
                </div>
              </c:if>
              <c:if test="${brand.pic3 !=null&&fn:trim(brand.pic3)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic3}" mediaType="other"></cartmatic:img>
                </div>
              </c:if>
              <c:if test="${brand.pic4 !=null&&fn:trim(brand.pic4)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic4}" mediaType="other"></cartmatic:img>
                </div>
              </c:if>
              <c:if test="${brand.pic5 !=null&&fn:trim(brand.pic5)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic5}" mediaType="other"></cartmatic:img>
                </div>
              </c:if>
              <c:if test="${brand.pic6 !=null&&fn:trim(brand.pic6)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic6}" mediaType="other"></cartmatic:img>
                </div>
              </c:if>
            </div>
            <div class="designer_pagination"></div>
            <a class="designer_enlarge" href="#"></a>
            <a class="designer_close" href="javascript;"></a>
        </div><!--designer_show end-->
        <div class="designer_box c">
	        <div class="designer_con">
	            <div class="li1"><cartmatic:img isUrlOnly="false" url="${brand.icon}" mediaType="other" width="270" height="270" ></cartmatic:img></div>
	            <div class="li2 title-font">${brand.brandName}</div>
	            <div class="li3 c">
	              <cartmatic:img isUrlOnly="false" url="${brand.logo}" mediaType="other"></cartmatic:img>
	              <!-- JiaThis Button BEGIN -->
	              <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	              <!-- JiaThis Button END -->
	            </div>
	
	            <div class="li4">${brand.story}</div>
	        </div>
	    </div>
	    <!--设计师作品-->
    	<div class="designer_work">
        <div class="title"><div><span class="title-font">设计师代表作品</span></div></div>
        

        <!--此处需要从后台传过推荐产品8个productRecommendId-->
        <div class="product_box">
        <ul class="product list-unstyled col4 c sku_list" id="pinterestList">
        <c:forEach items="${recommendProductList}" var="product" begin="0" end ="7">
					<li>
						<div class="li1">
	                        <a href="${ctxPath}/product/${product.productId}.html">
	                            <img class="imgo" src="${mediaPath}product/v/${product.defaultProductSku.image}" width="100%" />
	                            <%--<img class="imgt" src="${mediaPath}/productMedia/hd/${product.productHandDraw.mediaUrl}" width="100%"/>--%>
	                        </a>
	                    </div>
	                    <div class="li2">
	                        <div class="cutstr2">
	                            <a href="${ctxPath}/product/${product.productId}.html">
	                                ${product.productName}
	                            </a>
	                        </div>
	                        <span class="new">
	                        </span>
	                    </div>
	                    <p class="li3">
	                        ${product.brand.designer}
	                    </p>
	                    <p class="li4">
	                        ${product.brand.brandName}
	                    </p>
                        <div class="li5"><product:showPrice productSku="${product.defaultProductSku}" viewType="4"/></div>
                        <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
                        <div class="join_box">
	                        <c:forEach items="${productMap}" var="productMapItem">
		                    	<c:if test="${productMapItem.key == product.productId}">
				                 <c:forEach items="${productMapItem.value}" var="productSkuOptionAndValue">
											<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'color') > -1}">
												<div class="product_color">
													<ul class="tm-clear J_TSaleProp tb-img" data-property="${productSkuOptionAndValue.key.skuOptionName}">
														<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
															<li class="tb-selected"  data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}" style="display:none">
																	<a  id="color_${skuOptionValue.skuOptionValue }" class="imageSku"  href="#">
																		<span>${skuOptionValue.skuOptionValueName}</span>
																		<!--  background: url(<product:productImg sku="${skuOptionValue.sku}" size="a" isUrlOnly="true"/>) center no-repeat; -->
																	</a>
																	<i>selected</i>
															</li>
								                        </c:forEach>
													</ul>
												</div>
											</c:if>
				                                  
											<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'size') > -1}">
												<div class="j1">尺码</div>
												<ul class="size" data-property="${productSkuOptionAndValue.key.skuOptionName}">
					                                 <p>
					                                 	<div class="j2">
															<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
									                        	<span data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}">${skuOptionValue.skuOptionValueName}</span>
									                        </c:forEach>
								                        </div>
								                     </p>
												</ul>
											</c:if>
				                 </c:forEach>
				               </c:if>
				            </c:forEach>
				            <form id="myform" method="POST" action="#">
					               <input id="quantity" type="hidden" name="quantity" type="text"  value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
					             </form>
	                        <span class="cart_close">
	                            关闭
	                        </span>
	                        <product:addToCartSmall productSkuCode="${product.defaultProductSku.productSkuCode}" productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
	                    </div>
	                    <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
		                <p class="li6">
	                        <!-- JiaThis Button BEGIN -->
	                                            
	                                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	                                           
	                                            <!-- JiaThis Button END -->
	                        <a href="javascript:" onClick="addToFavorite(${product.productId})"><i class="fa fa-heart-o"></i> 加入收藏</a>
	                        <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
	                    </p>
                    </li>
				</c:forEach>
        </ul>
        </div>
        <div class="product_more"><a href="${ctxPath}/designerProductList.html?brandId=${brand.brandId}">点击查看更多</a></div>
        </div>
        <!--设计师思维对话-->
        <div class="dialogue_box">
        	<div class="dialogue">
            	<div class="c dialogue_part">
                    <div class="dialogue_left">
                        <div class="dialogue_info">
                            <h3 class="dialogue_info_left title-font">思维对话</h3>
                            <div class="dialogue_info_right">
                            	<div class="li1">${culturalInformation.title}</div>
                                <div class="li2"><a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a></div>
                                <div class="li3">
                                ${culturalInformation.content}
                                 </div>
                                <a class="li4" href="#">点击查看详细</a>
                            </div>
                        </div>
                    </div><!--dialogue_left end-->
                    <div class="dialogue_right"><cartmatic:img isUrlOnly="false" url="${culturalInformation.logoImg}" mediaType="other" id="logoImage"></cartmatic:img></div>
                    <div class="dialogue_left">
                    	<div class="dialogue_left_bottom"><i class="line"></i>
                    ${brand.quotation}</div>
                    	<cartmatic:img isUrlOnly="false" url="${brand.pic}" mediaType="other" id="logoImage"></cartmatic:img>
                    </div><!--dialogue_left end-->
               	</div>
            </div>
        </div><!--dialogue_box end-->
        <!--设计师动态-->
        <c:if  test="${fn:length(brandDynamicList)!=0 }">
        <div class="title title2"><div><span class="title-font">设计师最新动态</span></div></div>
        </c:if>
        <ul class="designer_news list-unstyled c">
           <c:forEach items="${brandDynamicList}" var="brandDynamic" >
        	<li>
            	<div class="designer_news_img data_bg" style="background-image:url(${brandDynamic.img})">
            		<cartmatic:img isUrlOnly="false" url="v/${brandDynamic.img}" mediaType="productMedia" ></cartmatic:img>
            	<a href="http://${brandDynamic.website}" target="_blank"></a></div>
                <div class="designer_news_info">
                    <div class="li1"><span>${brandDynamic.resource}</span></div>
                    <div class="li2">${brandDynamic.resourceTime}</div>
                    <div class="li3 cutstr3">
                        <div >${brandDynamic.content}</div>
                    </div>
                   	<a class="li4" href="http://${brandDynamic.website}" target="_blank">点击访问来源<i></i></a>
                    <!-- JiaThis Button BEGIN -->
	                <a href="http://www.jiathis.com/share" class="li5 jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	                <!-- JiaThis Button END -->
                </div>
            </li>   
           </c:forEach>            
        </ul><!--list-unstyled end-->
        <!-- 加入购物车成功 -->
	    <div style="display:none">
                    <div id="cart_box" class="after_addtocart">
                        <div class="w-cart-header">
                            <span><i class="fa fa-check-circle-o"></i>该产品已经成功加入您的购物车</span>
                            <hr class="aftercart_hr"/>
                        </div><!--w-cart-header-->
                        <div class="w-cart-body">
                            <div class="addcart_top">
                                <div class="addcart_part">
                                    <span class="addcart_part_title">购买该产品的用户还买了</span>
                                    <span class="addcart_part_more"><a href="javascript:;">更多>></a></span>
                                </div><!--addcart_part-->
                                <div class="addcart_sku">
                                  <ul class="sku_row">
                                    <li class="sku_list">
                                    	<jsp:include flush="true" page="/sales/recommendedProduct.html">
								             <jsp:param name="typeName" value="also_buy" />
								             <jsp:param name="firstResult" value="0" />
								             <jsp:param name="maxResults" value="7" />
								             <jsp:param name="template" value="sales/include/recommendProductContentNew2"/>
								             <jsp:param name="doAction" value="defaultAction" />
								             <jsp:param name="sourceId" value="${product.productId}" />
								         </jsp:include>
                                    </li>
                                  </ul>
                                </div><!--addcart_sku-->
                            </div><!--addcart_top-->
                        </div><!--w-cart-body-->
                    </div><!--cart_box-->
                </div>
	     <!-- End 加入购物车成功 -->
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
		<script type="text/javascript">
		  
		  function addToFavorite(productId){
      		    if(isLogined()){
      		  	$.post("/ajaxFavorite.html?doAction=addFavorite", {
          		  	productId : productId
        		  	}, function(result) {
        		  		    alert(result.msg);
        		  		}, "json");
          		    }else{
	              		 alert("此操作需要登陆");
	          		  	$(".w-login").show();
						$(".w-login-left").show();
						$(".w-login-right").hide();
              		    }
			}
         </script>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/pinterest.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/index.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/slider.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/colorbox/jquery.colorbox-min.js"></script>
	    <script type="text/javascript">
	        $(function () {
	            //弹出图片和视屏
	            $(".img_box").colorbox({ rel: 'group1' , innerWidth: "90%", innerHeight: "90%"});
	            $(".video_box").colorbox({ iframe: true, innerWidth: "80%", innerHeight: "80%" });
	            $(".j3").colorbox({ inline: true, width: "50%" });
	            //循环绑定背景图片
	            $(".data_bg").each(function () {
	                var img = $(this).attr("data-img");
	                if (img != undefined)
	                    $(this).css({ 'background': 'url(' + img + ')' })
	            })
	        })
	    </script>
	      <script type="text/javascript" >
		  var jiathis_config={
			  summary:"",
			  shortUrl:true,
			  hideMore:false
		  }
		  </script>
		  <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
	</body>
</html>