<!DOCTYPE html>
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

<c:if test="${product.status != 1}">
	<%response.setStatus(response.SC_GONE);%>
	
</c:if>
<html lang="zh-CN">
	<head>
		<c:set var="productPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></c:set>
		<c:set value="${empty product.title?product.productName:product.title}" var="pageTitle"></c:set>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		
		<!-- Bootstrap -->
		<%@ include file="../../decorators/include/javascripts.jspf"%>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<%@ include file="../../decorators/include/styles7.jspf"%>
        <link href="${ctxPath}/scripts/jquery/js/colorbox/colorbox.css" rel="stylesheet" />
        <link href="${resPath}/styles/css/pro-deta.css" rel="stylesheet">
        <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
        <link href="${resPath}/styles/css/mall_nav.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
       <!-- <link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />->
        
         <!-- Include the story plugin: -->
	  <script type="text/javascript">
      $(document).ready(function(){
          $(".designer_pic .rsp").hide();
          
          $(".designer_story").hover(function(){
              $(".designer_pic").find(".rsp").stop().fadeTo(500,0.5)
              $(".designer_pic").find(".text").stop().animate({left:'0'}, {duration: 500})
          },function(){
              $(".designer_pic").find(".rsp").stop().fadeTo(500,0)
              $(".designer_pic").find(".text").stop().animate({left:'238'}, {duration: "fast"})
              $(".designer_pic").find(".text").animate({left:'-238'}, {duration: 0})
          });
      
      });
      </script>  
      <script>
		$(document).ready(function(){
			var t = $("#quantity");
			$("#add").click(function(){		
				t.val(parseInt(t.val())+1)
				//setTotal();
			})
			$("#min").click(function(){
				if(parseInt(t.val()) == 1)
					t.val(1);
				else{
					t.val(parseInt(t.val())-1)
					//setTotal();
				}
			})
					                  
			});
		</script>
          
      <!-- Add fancyBox main JS and CSS files -->
      
      <link rel="stylesheet" type="text/css" href="${resPath }/styles/jquery.fancybox.css" media="screen" />
	  <!-- Include the elevatezoom plugin: -->
	  <script type="text/javascript" src="${ctxPath}/scripts/jquery/jquery.fancybox.js"></script>
      <script type="text/javascript">
		$(document).ready(function() {
			$(".target").fancybox({
				maxWidth	: 800,
				maxHeight	: 600,
				fitToView	: false,
				width		: '70%',
				height		: '70%',
				autoSize	: false,
				closeClick	: false,
				openEffect	: 'none',
				closeEffect	: 'none'
			});
		});
 
});
		
		</script>
		
	  <script type="text/javascript">
      $(document).ready(function($){
			$("#zoom_03").elevateZoom({
			gallery:'gallery_01', 
			cursor: 'pointer', 
			galleryActiveClass: "active", 
			imageCrossfade: true, 
			borderColour: "#fff",
			borderSize: 2,
			zoomWindowOffetx: 25,
			zoomWindowWidth:330,
			zoomWindowHeight:400,
			loadingIcon: "${resPath}/images/bx_loader.gif"
			}); 

		  $("#zoom_03").bind("click", function(e) {
				var ez =   $('#zoom_03').data('elevateZoom');
				//ez.closeAll(); //NEW: This function force hides the lens, tint and window	
				var list2 = ez.getGalleryList_2();
				$.fancybox(list2);
				return false;
		  }); 
	  
	  }); 

      </script>
      <!--bxslider-->
      
      <script>
	  $(function(){
		  $('.slider2').bxSlider({
			  pager: false,
			  controls:true,
			  wrapper_class: 'sale_popular',
			  pause: 2500,
			  slideWidth: 100,
			  minSlides: 4,
			  maxSlides: 4,
			  slideMargin: 4
		  });
	  });
      </script>
      <!--product detail-->
      
      <!--comment-->
      
      <script>
	   $(function() {
			$.fn.raty.defaults.path = 'lib/img';
			var $star = $('.target_star');
			$star.each(function(){
				var $this = $(this);
				var rate = $this.next().val();
				$this.raty({ 
					  readOnly: true, 
					  score: rate ,
					  number: 5,//多少个星星设置		
					  path      : '${resPath}/images',
					  size      : 24,
					  starOff   : 'star-off.png',
					  starOn    : 'star-on.png',
					  cancel    : false,
					  targetKeep: true
				 });
			});
	   });
	  </script>
	  <script type="text/javascript">
      $(document).ready(function() {
      	$('.fancybox').fancybox({
			padding : 0
		 });
      	});
	  </script>
	  <script>
	  $(document).ready(function(){
		$("#p_designer_oth .sub_active").css({"display":"inline-block"});
		$("#p_collocate").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("搭配款式");
			 $("#p_collocate").addClass("active_href");
			 $("#p_other").removeClass("active_href");
			 $("#p_designer_oth").removeClass("active_href");
		   $("#p_collocate .sub_active").css({"display":"inline-block"});
		   $("#p_other .sub_active").css({"display":"none"});
		   $("#p_designer_oth .sub_active").css({"display":"none"});
		});
		
		$("#p_other").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("相似款式");
			 $("#p_other").addClass("active_href");
			 $("#p_collocate").removeClass("active_href");
			 $("#p_designer_oth").removeClass("active_href");
		   $("#p_other .sub_active").css({"display":"inline-block"});
		   $("#p_collocate .sub_active").css({"display":"none"});
		   $("#p_designer_oth .sub_active").css({"display":"none"});
		});
		
		$("#p_designer_oth").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("该设计师其他款式");
			 $("#p_designer_oth").addClass("active_href");
			 $("#p_collocate").removeClass("active_href");
			 $("#p_other").removeClass("active_href");
		   $("#p_designer_oth .sub_active").css({"display":"inline-block"});
		   $("#p_collocate .sub_active").css({"display":"none"});
		   $("#p_other .sub_active").css({"display":"none"});
		});
		
	  });
	  </script>   
      <!--[if lt IE 9]>
      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
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
				<form id="customerRegisterForm" action="register.html" method="post">
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
		<div class="w-nav w-nav-s navbar-fixed-top">
          <div class="nav2-bg"> <!--2015-9 和其他一级页面不同的地方--> 
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
					<div class="col-md-2 col-lg-2 w-logo"><a href="${ctxPath}/index.html" id="w-logot">四方街</a>
					</div>
					<div class="col-md-6 col-lg-7">
						<ul class="w-menu list-unstyled">
							<li class="current">
                            	<a href="${ctxPath}/MarketIndex.html"><span class="w-menu-on">商城</span></a>
								<dl>
                                	<dd><a href="${ctxPath}/MarketIndex.html"><i></i>首页</a></dd>
                                    <dd>
                                    	<a href="/marketDesignerList/index.html"><i></i>设计师</a>
                                        <%--<div class="mem_dow">
                                        	<i></i>
                                            <a class="active" href="#">灯具</a>
                                            <a href="#">户外用品</a>
                                            <a href="#">慢教由問的行本</a>
                                            <a href="#">創臺文的統苦</a>
                                            <a href="#">那式根</a>
                                            <a href="#">二度</a>
                                            <a href="#">傳已經的然</a>
                                        </div>
                                    --%></dd>
                                    <dd><a href="/man_catalog.html"><i></i>男装</a></dd>
                                    <dd><a href="/wen_catalog.html"><i></i>女装</a></dd>
                                    <dd><a href="/catalog_default_catalog.html"><i></i>所有产品</a></dd>
                                </dl>
                            </li>
							<li><a href="${ctxPath}/culturalinformation/index.html"><span>文化资讯</span></a>
							</li>
							<li><a href="${ctxPath}/designerList.html"><span>设计师</span></a>
							</li>
							<li><a href="${ctxPath}/customer_service/_18.html"><span>关于我们</span></a>
							</li>
							<li><a href="${ctxPath}/coming.html"><span>线下店铺</span></a>
							</li>
						</ul>
					</div>
					<div class="col-md-4 col-lg-3" style="padding-bottom: 50px;">
						<ul class="w-menu-right list-unstyled">
							<li>
								<a href="javascript:void(0)"><span class="w-gwc">购物车
										(${shoppingcart.buyNowItemsCount == null || shoppingcart.buyNowItemsCount == "" ? 0 : shoppingcart.buyNowItemsCount})</span> </a>
							</li>
							<li id="loginPromptHolderTemplateLogout">
								<a href="javascript:void(0)"><span class="w-menu-lr">登录/</span><span
									class="w-menu-lrzc">注册</span> </a>
							</li>
							<li id="loginPromptHolderTemplateLogin">
								<a href="/myaccount/account.html"><i class="fa fa-user"></i></a> (
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
					<li class="current">
                        <a href="#"><span class="w-menu-on w-menu-sc">商城</span></a>
                        <ul class="w-m-tmenus  list-unstyled">
                        	<li>
                        		<a href="#" class="w-mto-a"><div class="w-mt-nav">首页 </div></a>
                        	</li>
                        	<li class="w-mt-ud w-mt-down"><a href="javascript:void(0)" class="w-mto-a"><div class="w-mt-nav">设计师 <i class="fa fa-chevron-down"></i></div> </a>
                        		<ul class="list-unstyled">
                        			<li><a href="#" class="w-ton">下级一</a></li>
                        			<li> <a href="#">下级一</a></li>
                        			<li><a href="#">下级一</a></li>
                        			<li><a href="#">下级一</a></li>
                        			<li><a href="#">下级一</a></li>
                        		</ul>
                        	</li>
                        	<li class="w-mt-ud w-mt-down"><a href="javascript:void(0)" class="w-mto-a"><div class="w-mt-nav">设计师 <i class="fa fa-chevron-down"></i></div> </a>
                        		<ul class="list-unstyled">
                        			<li><a href="#" class="w-ton">下级一</a></li>
                        			<li> <a href="#">下级一</a></li>
                        			<li><a href="#">下级一</a></li>
                        			<li><a href="#">下级一</a></li>
                        			<li><a href="#">下级一</a></li>
                        		</ul>
                        	</li>
                        	<li>
                        		<a href="#" class="w-mto-a"><div class="w-mt-nav">女装 </div></a>
                        	</li>
                        	<li>
                        		<a href="#" class="w-mto-a"><div class="w-mt-nav">众筹 </div></a>
                        	</li>
                        	<li>
                        		<a href="#" class="w-mto-a"><div class="w-mt-nav w-mt-nlast">超值优惠 </div></a>
                        	</li>
                        </ul>
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
			</div><!--nav2-bg--><!--2015-9 和其他一级页面不同的地方--> 
		</div>
		<div class="w-pro-deta">
        	<div class="w-pro-deta-hd row">
            	<div class="w-pro-pic">
                    <!-- Swiper -->
                    <div class="swiper-container">
                    	<div class="pro-pic-share">
                        	<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
                        </div>

                        <div class="swiper-wrapper">
                        <c:if test="${empty productMoreImages}">
                        	<img src="/images/null.jpg">
                        </c:if>
                        <c:forEach items="${productMoreImages}" var="productImages">
                            <div class="swiper-slide" ><img src="${mediaPath}productMedia/v/${productImages.mediaUrlLarge}"></div>
                        </c:forEach>
                        </div>
                        <!-- Add Pagination -->
                        <div class="swiper-pagination"></div>
                        <!-- Add Arrows -->
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </div>
            	<div class="w-pro-info">
                	<div class="w-pro-info-new">NEW</div>
                    <div class="w-pro-info-tit">${product.productName}</div>
                    <div class="w-pro-info-price"><%@ include file="./include/productTemplate_priceArea.jspf"%></div>
                    <div class="w-pro-info-form">
                    	<p><span>设计师：</span><a href="${ctxPath}/search-prod.html?brandId=${product.brand.id}">${product.brand.designer}</a></p>
                        <p><span>品牌：</span><a href="${ctxPath}/search-prod.html?brandId=${product.brand.id}">${product.brand.brandName}</a></p>
                    </div>
                    <p class="w-pro-info-numbering">产品编号：${product.productCode}</p>
                    <input type="hidden" id="productId" value="${product.productId}" />
		           <input type="hidden" id="productCode" value="${product.productCode}" />
		           <input type="hidden" id="productName" value="${product.productName}" />
		           <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
		           <input type="hidden" id="accessoriesSkuCodes" value="" />
		           <input type="hidden" id="categoryId" value="${category.categoryId}" />
		           <input type="hidden" id="product_simpleName" value="<app:interceptString str="${product.productName}" length="50"></app:interceptString>" />
		           <input type="hidden" id="productLinkUrl" value="${uri}" />
		           <input type="hidden" id="listPrice" value="${product.defaultProductSku.listPrice}" />
                    <div class="w-pro-info-tabs">
                    	<ul id="tabs" class="row">
                        	<li><a href="#" name="#tab1">产品信息</a></li>
                            <li><a href="#" name="#tab2">尺码指导</a></li>
                            <li><a href="#" name="#tab3">售后&运费说明</a></li>
                            <li><a href="#" name="#tab4">二维码购买</a></li>
                        </ul>
                        <div id="info-tabs-contents">
                        	<div id="tab1">
                            	<div class="info_item1">
                                	${product.productDescription.imageDescription}
                                </div>
                                <div class="info_item2">
                                	<ul>
										<li>上架时间：<fmt:formatDate value="${product.publishTime}" pattern="yyyy-MM-dd"/></li>
										<c:if test="${not empty product.defaultProductSku.weight}">
											<li>商品毛重：${product.defaultProductSku.weight}${appConfig.weightUnit }</li>
										</c:if>
										<c:forEach items="${productAttGroups}" var="productAttGroup">
											<c:forEach items="${productAttGroup.productAttrValues}" var="productAttrValue">
												<c:if test="${not empty productAttrValue.attributeValue}">
													<li>${productAttrValue.attribute.attributeName}：
														<c:choose>
															<c:when test="${productAttrValue.attributeDataType==1}">
																${fn:replace(productAttrValue.attributeValue,",","，")}
															</c:when>
															<c:otherwise>${productAttrValue.attributeValue}</c:otherwise>
														</c:choose>
													</li>
												</c:if>
											</c:forEach>
										</c:forEach>
									</ul>    
					              <p>
					              	<product:htmlConverter content="${product.productDescription.fullDescription}"></product:htmlConverter>   
					              </p>
                                </div>
                                <div class="info_item3">
                                	<p><strong>${product.productDescription.productInfoationDescription}</strong></p>
                                </div>
                            </div>
                            <div id="tab2">
                            	<div class="info2_item1">
                                    ${product.productDescription.productSizeDescription}
                                </div>
                                <div class="info2_item3"><p><a href="#">查看 SIZE 对照表</a></p></div>
                            </div>
                            <div id="tab3">
                            	<div class="info3_item1">
                                    ${product.productDescription.customerServiceDescription}
                                </div>
                            </div>
                            <div id="tab4">
                            	<div class="info4_item1">
                                    <p>扫扫享手机专享价</p>
                                    <p><img src="${mediaPath}qrcode/${encoderContent}"></p><br>
                                </div>
                                <div class="info4_item2">
                                    ${product.productDescription.qrCodeDescription}
                               	</div>
                            </div>
                        </div>
                        <div class="w-pro-info-btn addbefore"><a href="#">加入购物车</a></div>
                    </div>
                    <div id="skuOptions" class="w-pro-car">
                    	<em class="fa fa-close"></em>
		                 <c:forEach items="${productSkuOptionAndValues}" var="productSkuOptionAndValue">
		                 	<div class="tb-prop tm-clear">
									<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'color') > -1}">
										<div class="product_color">
											<%--图片 --%>
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
										<div class="product_size">
											<%--文本 --%>
			                                 <ul class="size" data-property="${productSkuOptionAndValue.key.skuOptionName}">
			                                 	<label>选择尺码</label>
			                                 	<p>
												<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
													<li class="pro-car-1" data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}">
						                                <a href="#" class="active">${skuOptionValue.skuOptionValueName}</a>
						                            </li>
						                        </c:forEach>
						                        </p>
											</ul>
										</div>
									</c:if>
							</div>
		                 </c:forEach>
		                 <li class="pro-car-2">
		                 	<label>选择颜色</label>
		                 	<p>
		                	<!-- 该产品其他颜色 -->
		                	<a href="#"><product:productImg product="${product}" size="v" width="72" height="97" category="${category}"/></a>
			             	<jsp:include flush="true" page="/sales/recommendedProduct.html">
					             <jsp:param name="typeName" value="other_color" />
					             <jsp:param name="firstResult" value="0" />
					             <jsp:param name="maxResults" value="5" />
					             <jsp:param name="template" value="sales/include/recommendProductContentNew"/>
					             <jsp:param name="doAction" value="defaultAction" />
					             <jsp:param name="sourceId" value="${product.productId}" />
					         </jsp:include>
					         </p>
					        </li>
					        <li style="clear:both"></<li>
					        <li class="pro-car-3">
					        	<label>选择数量</label>
					           	<product:productQuantity2 product="${product}" />
					             <form id="myform" method="POST" action="#">
						             <div class="spinner">
							               <a href="#" id="min"><i class="fa fa-minus"></i></a>
							               		<input id="quantity" name="quantity" type="text"  value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
							               <a href="#" id="add"><i class="fa fa-plus"></i></a>
						              </div>
					             </form>
					              <!--product_quantity-->
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
					             
					             <%--
					             <div class="product_stock">
					               <i class="fa fa-exclamation-circle fa-lg fa_storck"></i>
					                还剩<span>${maxOrderQuantity == null ? 0 :  maxOrderQuantity}</span>件
					             </div><!--product_stock-->
					            --%>  
					           
					           </li>
		                 <product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
		           	</div>
		           	
		           	
                </div>
            </div>
                <div class="deta-bd-group2">
                	<h2>达人秀</h2>
                	<div class="swiper2">
                        <div class="swiper-wrapper">
                        <c:forEach items="${product.productTalenshowValues}" var="productTalenshowValues">
                            <div class="swiper-slide"><img src="${mediaPath}other/${productTalenshowValues.talentShow.img}"><div class="swiper2-mask"><div class="swiper2-pop"><p>${productTalenshowValues.talentShow.content}</p><p><fmt:formatDate value="${productTalenshowValues.talentShow.releaseTime}" type="date" dateStyle="long"/>上传</p></div></div></div>
                        </c:forEach>
                        </div>
                        <!-- Add Arrows -->
                        <div class="swiper-button-next1"><a href="#"><i class="fa fa-caret-right"></i></a></div>
                        <div class="swiper-button-prev1"><a href="#"><i class="fa fa-caret-left"></i></a></div>
                    </div>
                </div>
                <div class="deta-bd-group3"><content:showAdNew adPositionType="product" /></div>
        </div>
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
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="hot">HOT</span><a href="#">产品名称写在这里长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p>
                                            <b>￥ 50.00</b>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="sale">SALE</span><a href="#">产品名称写在这里长很长很长很长很长很长很</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="new">NEW</span><a href="#">产品名称写在这里长很长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><a href="#">产品名称写在这里长很长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                    </li>
                                  </ul>
                                </div><!--addcart_sku-->
                            </div><!--addcart_top-->
                            <div class="addcart_top">
                                <div class="addcart_part">
                                    <span class="addcart_part_title">购买该产品的用户还买了</span>
                                    <span class="addcart_part_more"><a href="javascript:;">更多>></a></span>
                                </div><!--addcart_part-->
                                <div class="addcart_sku">
                                  <ul class="sku_row">
                                    <li class="sku_list">
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="hot">HOT</span><a href="#">产品名称写在这里长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p>
                                            <b>￥ 50.00</b>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="sale">SALE</span><a href="#">产品名称写在这里长很长很长很长很长很长很</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><span class="new">NEW</span><a href="#">产品名称写在这里长很长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
                                        <div class="collocation-item addpro">
                                            <a href="#"><img src="img/pic6.jpg"><img class="imgt" src="img/authors/13.jpg"></a>
                                            <div class="bd-list-tit"><a href="#">产品名称写在这里长很长很长很长很长很长很长</a></div>
                                            <p><span>郑荣凯&曾思宇</span></p>
                                            <p><em>品牌名</em></p>
                                            <p><b>￥ 50.00</b></p>
                                        </div>
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
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/slider.js"></script>
        <script src="${ctxPath}/scripts/jquery/js/colorbox/jquery.colorbox-min.js"></script> 
		<script>
			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				paginationClickable: '.swiper-pagination',
				nextButton: '.swiper-button-next',
				prevButton: '.swiper-button-prev',
				spaceBetween: 30
			});
		</script>
        <script>
			if($(window).width()>768){
					var swiper = new Swiper('.swiper2', {
						slidesPerView:4,
						paginationClickable: true,
						nextButton: '.swiper-button-next1',
						prevButton: '.swiper-button-prev1',
						spaceBetween: 20
					});
				}else{
						var swiper = new Swiper('.swiper2', {
							slidesPerView:2,
							paginationClickable: true,
							nextButton:'.swiper-button-next1',
							prevButton:'.swiper-button-prev1',
							spaceBetween: 20
						});
						$(function(){
							$(".w-pro-pic .swiper-slide img").width("100%")
						})
					}
				window.onresize=function(){
					if($(window).width()>768){
						var swiper = new Swiper('.swiper2', {
							slidesPerView:4,
							paginationClickable: true,
							nextButton: '.swiper-button-next1',
							prevButton: '.swiper-button-prev1',
							spaceBetween: 20
						});
					}else{
							var swiper = new Swiper('.swiper2', {
								slidesPerView:2,
								paginationClickable: true,
								nextButton: '.swiper-button-next1',
								prevButton: '.swiper-button-prev1',
								spaceBetween: 20
							});
							$(function(){
								$(".w-pro-pic .swiper-slide img").width("100%")
							})
						}
				}
		</script>
        <script type="text/javascript">
			function resetTabs(){
				$("#info-tabs-contents > div").hide();
				$("#tabs a").attr("id","");
			}
			
			var myUrl = window.location.href;
			var myUrlTab = myUrl.substring(myUrl.indexOf("#")); 
			var myUrlTabName = myUrlTab.substring(0,4);
			
			(function(){
				$("#info-tabs-contents > div").hide();
				$("#tabs li:first a").attr("id","current");
				$("#info-tabs-contents > div:first").fadeIn();
			
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
        <script type="text/javascript">
			function resetTabss(){
				$("#deta_bd_content > div").hide();
				$(".deta-bd-tit a").attr("id","");
			}
			
			var myUrl = window.location.href;
			var myUrlTab = myUrl.substring(myUrl.indexOf("#")); 
			var myUrlTabName = myUrlTab.substring(0,4);
			
			(function(){
				$("#deta_bd_content > div").hide();
				$(".deta-bd-tit a:first").attr("id","current");
				$("#deta_bd_content > div:first").fadeIn();
			
				$(".deta-bd-tit a").on("click",function(e) {
					e.preventDefault();
					if ($(this).attr("id") == "current"){
						return       
					}else{             
						resetTabss();
						$(this).attr("id","current");
						$($(this).attr('name')).fadeIn();
					}
				});
			
				for (i = 1; i <= $(".deta-bd-tit a:first").length; i++) {
					if(myUrlTab == myUrlTabName + i){
						resetTabss();
						$("a[name='"+myUrlTab+"']").attr("id","current");
						$(myUrlTab).fadeIn();
					}
				}
			})()
		</script>
        <script type="text/javascript">
        	$(function(){
				
					$(window).scroll(function(){
						$(".index-nav").addClass("w-nav-s")
					})
					
					$(".w-pro-info").height($(".swiper-container").height())
					
					
					$(".group1-pop").height($(".deta-bd-group1 ul li.center a img").height()).css("line-height",$(".deta-bd-group1 ul li.center a img").height()+"px")
					$(".deta-bd-group1 ul li.center .addpro").click(function(){
							if($(this).hasClass("active")){
									$(this).removeClass("active")
								}else{
									$(this).addClass("active")
									$(".deta-bd-group1 ul li.right p a").addClass("active")
									}
						})
					
					$(".swiper2-mask").height($(".swiper2 .swiper-slide img").height())
					if($(window).width()<992){
							$(".w-pro-info").height("auto").css("padding-bottom","20px")
						}else{
							$(".w-pro-info").height($(".swiper-container").height())
							}
					$(".swiper2 .swiper-slide").hover(function(){
							$(".swiper2-mask",this).animate({top:0})
						},function(){
							$(".swiper2-mask",this).animate({top:100+"%"})
							}
						)
					$(".addbefore").click(function(){
							$(".w-pro-car").fadeIn()
							$(".w-pro-info-tabs").hide()
						})
					$(".addafter").click(function(){
							$(".addcart").colorbox({ inline: true, width: "50%" });
						})
					$(".w-pro-car em").click(function(){
							$(".w-pro-car").hide()
							$(".w-pro-info-tabs").fadeIn()
						})
						
					var H = $(window).height()
					$(".w-404").height(H)
					var H1 = $(".deta-bd-group1 ul li.center").height()
					$(".deta-bd-group1").height(H1 + 80)
					$(".deta-bd-group1  ul li.left").height($(".deta-bd-group1 ul li.center").height())
					$(".deta-bd-group1  ul li.right").height($(".deta-bd-group1 ul li.center").height())
					window.onresize=function(){
							var H1 = $(".deta-bd-group1 ul li.center").height()
							var H = $(window).height()
							$(".w-404").height(H)
							$(".w-pro-info").height($(".swiper-container").height())
							if($(window).width()<992){
								$(".w-pro-info").height("auto").css("padding-bottom","20px")
							}else{
								$(".w-pro-info").height($(".swiper-container").height())
								}
							$(".group1-pop").height($(".deta-bd-group1 ul li.center a img").height()).css("line-height",$(".deta-bd-group1 ul li.center a img").height()+"px")
							$(".deta-bd-group1").height(H1 + 80)
							$(".deta-bd-group1  ul li.left").height($(".deta-bd-group1 ul li.center").height())
							$(".deta-bd-group1  ul li.right").height($(".deta-bd-group1 ul li.center").height())
						}
				})
        </script>
		<script type="text/javascript">
        $(function () {
            $(".j3").colorbox({ inline: true, width: "50%" });
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
        <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
<script type="text/javascript" defer>
var skuWholesalePrices = new Array();
<c:if test="${product.status==1}">
<%--产品价格包括批发价--%>
skuWholesalePrices[0]=[1,"${defaultProductSkuPrice}"];
<c:forEach items="${skuWholesalePrices}" var="wholesalePrice" varStatus="varStatus">
	skuWholesalePrices[${varStatus.count}]=["${wholesalePrice.minQuantity}","${wholesalePrice.price}"];
</c:forEach>
<c:if test="${product.productKind==2}">
var jProduct=${jsonProduct};
$("#skuOptions").children("div.tb-prop").find("li[data-value]").click(function(){
	if($(this).hasClass("tb-out-of-stock")){return false;};
	if($(this).toggleClass("tb-selected").hasClass("tb-selected")){
		$(this).append("<i>selected</i>").siblings("li").removeClass("tb-selected").children("i").remove();
	}else{
		$(this).children("i").remove();
	}
	var selectedOptions=$("#skuOptions").children("div.tb-prop").find("li.tb-selected[data-value]");
	var selectOptions=$("#skuOptions").children("div.tb-prop").find("li[data-value]").not(".tb-selected");
	
	var aOptionValueIds=",";
	var skus=jProduct.productSkus;
	
	for(var i=0;i<selectOptions.length;i++){
		var selectOption=$(selectOptions[i]);
		var optionId=selectOption.attr("data-value").split(":")[0];
		var optionValueId=selectOption.attr("data-value").split(":")[1];
		var hasMatchSku=false;
		var sku=null;
		for (k in skus){
			sku=skus[k];
			var skuOptions=sku.skuOptions;
			var hasOptionValue=false;
			for(j in skuOptions){
				var skuOption=skuOptions[j];
				if(selectOption.attr("data-value")==(skuOption.id+":"+skuOption.vid)){
					hasOptionValue=true;
					break;
				}
			}
			if(hasOptionValue){
				hasMatchSku=true;
			}else{
				continue;
			}
			for(var j=0;j<selectedOptions.length;j++){
				var selectedOption=$(selectedOptions[j]);
				var selectedOptionId=selectedOption.attr("data-value").split(":")[0];
				if(optionId!=selectedOptionId){
					hasOptionValue=false;
					for(l in skuOptions){
						var skuOption=skuOptions[l];
						if(selectedOption.attr("data-value")==(skuOption.id+":"+skuOption.vid)){
							hasOptionValue=true;
							break;
						}
					}
					if(!hasOptionValue){
						hasMatchSku=false;
						break;
					}
				}
			}
			if(hasMatchSku){
				break;
			}
		}
		if(hasMatchSku){
			if(aOptionValueIds.indexOf(","+optionValueId+",")==-1){
				aOptionValueIds+=optionValueId+",";
			}
		}
	}
		
	for(var i=0;i<selectOptions.length;i++){
		var option=$(selectOptions.get(i));
		var optionV=option.attr("data-value").split(":");
		if(aOptionValueIds.indexOf(","+optionV[1]+",")==-1){
			option.addClass("tb-out-of-stock");
		}else{
			option.removeClass("tb-out-of-stock");
		}
	}
		
	var selectedSku=null;
	for (i in skus){
		var sku=skus[i];
		var skuOptions=sku.skuOptions;
		var isMatch=false;
		for(j in skuOptions){
			isMatch=false;
			var skuOption=skuOptions[j];
			for(var k=0;k<selectedOptions.length;k++){
				if($(selectedOptions[k]).attr("data-value")==(skuOption.id+":"+skuOption.vid)){
					isMatch=true;
					break;
				}
			}
			if(!isMatch){
				break;
			}
		}
		if(isMatch){
			selectedSku=sku;
			break;
		}
	}
	var add2CartBtn=$("#add2Cart"+${product.id});
	if(selectedSku){
		//更新图片
		$("#productImgA").find("img").attr("src",__mediaPath+"product/d/"+selectedSku.image);
		//价格
		var skuPrice=selectedSku.salePrice!=null?selectedSku.salePrice:selectedSku.discountPrice!=null?selectedSku.discountPrice:selectedSku.price;
		$("#priceSpan").attr("data-value",skuPrice).html(fnFormatPrice(skuPrice));
		$("#priceSpan").next("span[name='otherCurrency']").attr("defaultvalue",skuPrice);
		if(selectedSku.priceViewType==2||selectedSku.priceViewType==3){
			$("#listPriceSpan").html('<del>'+fnFormatPrice(selectedSku.price)+'</del>').show();
			$("#discountPercent").html("("+selectedSku.discountPercent+"% OFF)");
		}else{
			$("#listPriceSpan,#discountCount").hide();
		}
		$("#productSkuCodeSpan").html(selectedSku.productSkuCode);
		$("#productSkuCode").val(selectedSku.productSkuCode);
		$("#productSkuId").val(selectedSku.productSkuId);
		$("#productWeightSpan").attr("data-value",selectedSku.weight+"").html(selectedSku.weight);
		if(!selectedSku.inventory){
			$("#productStockSpan").html("有现货");
			add2CartBtn.removeClass("stock").removeClass("no-addtocart").removeAttr("disabled").attr("title",__FMT.minicart_addToCart).val(__FMT.minicart_addToCart);
		}else if(selectedSku.inventory.availableQuantity>0){
			$("#productStockSpan").html(selectedSku.inventory.availableQuantity+" 件");
			add2CartBtn.removeClass("stock").removeClass("no-addtocart").removeAttr("disabled").attr("title",__FMT.minicart_addToCart).val(__FMT.minicart_addToCart);
		}else{
			$("#productStockSpan").html(__FMT.outOfStock);
			add2CartBtn.addClass("stock").attr("disabled","disabled").attr("title",__FMT.outOfStock).val(__FMT.outOfStock);
		}
		
		$("#skuWholesalePriceTbl").find("tr").slice(1).remove();
		skuWholesalePrices=selectedSku.wholesalePrices.slice(0,selectedSku.wholesalePrices.length);
		skuWholesalePrices.unshift([1,skuPrice]);
		$("#skuWholesalePriceTbl").append('<tr><td>1-1</td><td>'+fnFormatPrice(skuPrice)+'<span defaultvalue="'+skuPrice+'" name="otherCurrency"></span></td></tr>');
		for(var i=1;i<skuWholesalePrices.length;i++){
			var ws_qty=skuWholesalePrices[i][0]+"+";
			if(i<skuWholesalePrices.length-1){
				ws_qty=skuWholesalePrices[i][0]+"-"+(skuWholesalePrices[i+1][0]-1);
			}
			$("#skuWholesalePriceTbl").append('<tr><td>'+ws_qty+'</td><td>'+fnFormatPrice(skuWholesalePrices[i][1])+'<span defaultvalue="'+skuWholesalePrices[i][1]+'" name="otherCurrency"></span></td></tr>');
		}
		fnChangePrice();
	}else{
		add2CartBtn.removeClass("stock").addClass("no-addtocart").removeAttr("disabled").val(__FMT.minicart_addToCart);
	}
	
	var skuOptions=$("#skuOptions").children("div.tb-prop").find("li.tb-selected");
	var name="";
	skuOptions.each(function(i){
		if($(this).find("span").length!=0){
			name+=$(this).find("span").text();
		}
	});
	var msg="";
	if(name!=""){
		msg="已选："+name;
		if(selectedSku&&((!selectedSku.inventory)||selectedSku.inventory.availableQuantity>0)){
			msg+='&nbsp;&nbsp;<span class="mark_co">现在有货</span>';
		}
	}
	$("#selectedProdMsg").html(msg);
	return false;
});

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
</c:if>
</c:if>

//图片lightbox,稳定好移到js
function showLightbox(){
	var lightbox=$("#lightbox");
	var left=Math.round((($(document).width()||$(window).width())-lightbox.width())/2);
	var top=Math.round($("html").scrollTop()+($(window).height()-lightbox.height())/2);
	if(top<0)top=0;
	$("#lightboxOverlay").show();
	lightbox.css({ top: top, left: left }).show();
}

$("#lb-close,#lightboxOverlay").click(function(){
	$("#lightbox").hide();
	$("#lightboxOverlay").hide();
});
$("#lb-thumbnailContent").children().click(function(){
	$(this).addClass("selected").siblings().removeClass("selected");
	$("#lb-image").attr("src",__resPath+"/images/img/empty.gif");
	$("#lb-image").attr("src",__resPath+"/images/img/empty.gif").attr("src",$(this).children("img").attr("src").replace("/a/","/v/"));
});
$("#lb-previous").click(function(){
	$("#lb-thumbnailContent").children(".selected").prev().click();
});
$("#lb-next").click(function(){
	$("#lb-thumbnailContent").children(".selected").next().click();
});
$("a[target='popup_larger_image']").click(function(){
	var thumbImgUrl=$("#imgContent").children(".selected").children("img").attr("src");
	$("#lb-thumbnailContent").find("img[src='"+thumbImgUrl+"']").parent().click();
	showLightbox();
	return false;
});
</script>
<script type="text/javascript">
		                          function setShare(title, url) {
		                            //  alert("titile:"+title);
		                            //  alert("url:"+url);
		                             // alert("http://"+window.location.host+"/"+url);
		                              jiathis_config.title = title;
		                              jiathis_config.url = "http://"+window.location.host+"/"+url;
		                          }
		                            var jiathis_config = {}
		                          </script>  
		<script type="text/javascript" >
			var jiathis_config={
				data_track_clickback:false,
				sm:"qzone,tsina,weixin,cqq",
				summary:"",
				shortUrl:true,
				hideMore:false
			}
		</script>
		<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js?uid=2052677" charset="utf-8"></script>
	</body>

</html>