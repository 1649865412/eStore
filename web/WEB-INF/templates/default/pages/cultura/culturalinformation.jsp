<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<!--文化资讯列表页-->
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<%@ include file="../../decorators/include/javascripts.jspf"%>
		<script type="text/javascript"
			src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript"
			src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
		<%@ include file="../../decorators/include/styles7.jspf"%>
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/list.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/normalize.css" />
		<script src="${ctxPath}/scripts/jquery/js/modernizr.custom.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/snap.svg-min.js"></script>
		
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
		<script type="text/javascript">
		
			function getDetail(culid){
				$.post("/culturalinformation/getCulView.html", {
					culId : culid
				}, function(result) {
					   var json = eval("("+result.data+")");
						var object = json.culturalInformation;
						if(object.type !=4){
							changeNotMonth(json);
							}
						else{
							changetMonth(json);
							}
						article(json);
						/* var month = "";
                    	var content = $(".bb-item").html();
                    	alert(content);
						for(i=0;i<json.monthlyCultural.length;i++){
						      	month = json.monthlyCultural[i];
						      	alert("img:"+month.img);
						      	var a ="http://www.baidu.com/img/bd_logo1.png";
						      	content+=("<div class='bb-custom-side page-layout-3' style=' background: rgba(0, 0, 0, 0) url("+a+") no-repeat scroll left top / cover ;'></div>");
							}
						alert(content)
						 $(".bb-item").html(content);*/
					}, "json");
			}

			function article(json){
				var month = "";
            	var content = $(".w-x-items").html();
            	var img  = "";
            	var typeNum  = "";
            	var type  = "";
            	var content ="";
            	var value="";
            	var time="";
            	var culid="";
                var click="";
                var title="";
                var key="";
				for(i=0;i<json.reCommendResults.length;i++){
					var object=json.reCommendResults[i];
					 img ="/StoreAdmin/media/other/"+object.logoImg;
					 typeNum=object.type;
					 if(typeNum==0){
						 type="秀场";
						 }else if(typeNum==1){
							 type="访谈";
							 }else if(typeNum==2){
							 type="搭配";
							 }else if(typeNum==3){
							 type="线下主题活动";
							 }
					 time=(object.createTime.year+1900)+"年"+(object.createTime.month+1)+"月"+object.createTime.date+"日";
					 culid=object.culturalInformationId;
					 click="getDetail("+culid+")";
					 title=object.title;
					 key=object.metaKeywork;
					 value = ("<div class='w-x-item  w-g-b'><div class='w-g-header'><b></b>"+type+" | "+time+"</div>"+
					"<a onClick='"+click+"'><div class='w-x-imgs'><img src='"+img+"' /></div><h2 class='title title--preview'>"+title+"</h2></a>"+
					"<div class='loader'></div><div class='meta meta--preview'><a >"+key+"</a></div></div>");
						content+=value;
					}
				 $(".w-x-items").html(content);
				}

			function lastNext(culId){
					
				}

			function changetMonth(json){
				$("#box2").show();
				$("#box1").hide();
				setMonth(json);
				}

			function changeNotMonth(json){
				$("#box1").show();
				$("#box2").hide();
				setNotMonth(json);
				}

			function checkNull(value){
				  if(value==null){
					  return "";
					  }else{
						  return value;
						  }
			}

	
			
			function setNotMonth(json){
				var object = json.culturalInformation;
				var color ="";
				if(object.type ==0){
					$("#boxType").html("秀场");
					color="#fbbd6a";
					}else if(object.type ==1){
						$("#boxType").html("访谈");
						color="#a6d5ab";
					}else if(object.type ==2){
						$("#boxType").html("搭配");
						color="#abdce3";
					}else if(object.type ==3){
						$("#boxType").html("线下主题活动");
						color="#fb6e67";
					}
				
				$("#boxTitle").html(checkNull(object.title));
				$("#boxTitle").css("color",color);
				$("#boxBy").html("来源:"+checkNull(object.writer));
				$("#boxTime").html((object.createTime.year+1900)+"年"+(object.createTime.month+1)+"月"+object.createTime.date+"日");
				$("#boxRead").html("<a href='http://www.jiathis.com/share' class='jiathis jiathis_txt jiathis_separator jtico jtico_jiathis' target='_blank'><i class='fa fa-share-alt'></i> 分享</a>| 阅读数 （"+checkNull(object.readNumber)+"）");
				$("#boxText").html(checkNull(object.textIntroduction));
				$("#informationKey").html(checkNull(object.metaKeywork));
				var lastid=checkNull(json.lastCultural.culturalInformationId);
				var nextid=checkNull(json.nextCultural.culturalInformationId);
				//alert(lastid+"------"+nextid);
				var value = ("<a class='grid__item_a' onClick='getDetail("+lastid+")'><div class='w-c-prev'><div class='w-c-i'><i class='fa fa-angle-double-left'></i>"+
						"</div><div class='w-c-txt' id='flipLast'><span>上一篇</span><span class='w-c-ttitle' id='boxLast'></span></div></div></a>"+
						"<a class='grid__item_a' onClick='getDetail("+nextid+")'><div class='w-c-next'><div class='w-c-i'><i class='fa fa-angle-double-right'></i></div>"+
								"<div class='w-c-txt' id='flipNext'><span>下一篇</span><span class='w-c-ttitle' id='boxNext'></span></div></div></a>");
				$("#last_next").html(value);
				$("#boxLast").html(checkNull(json.lastCultural.title));
				$("#boxNext").html(checkNull(json.nextCultural.title));
				var readNum=checkNull(object.readNumber);
				//alert(readNum);
				var valueRead = ("<span><a href='http://www.jiathis.com/share' class='jiathis jiathis_txt jiathis_separator jtico jtico_jiathis' target='_blank'><i class='fa fa-share-alt'></i> 分享</a></span> | <span>阅读数 （"+readNum+"）</span>");
				$(".w-lin-right").html(valueRead);
				
				if(lastid==null||lastid==""){
					$("#flipLast").hide();
					}else{
						$("#flipLast").show();
						};
				if(nextid==null||nextid==""){
					$("#flipNext").hide();
					}else{
						$("#flipNext").show();
						};
				}

			function setMonth(json){
				var object = json.culturalInformation;
				if(object.type ==0){
					$("#boxType").html("秀场");
					}else if(object.type ==1){
						$("#boxType").html("访谈");
					}else if(object.type ==2){
						$("#boxType").html("搭配");
					}else if(object.type ==3){
						$("#boxType").html("线下主题活动");
					}
				$("#boxTitle").html(checkNull(object.title));
				$("#boxBy").html("来源:"+checkNull(object.writer));
				$("#boxTime").html((object.createTime.year+1900)+"年"+(object.createTime.month+1)+"月"+object.createTime.date+"日");
				$("#boxRead").html("阅读数	("+checkNull(object.readNumber)+")		|");
				$("#boxText").html(checkNull(object.textIntroduction));
				$("#informationKey").html(checkNull(object.metaKeywork));
				var lastid=checkNull(json.lastCultural.culturalInformationId);
				var nextid=checkNull(json.nextCultural.culturalInformationId);
				var value = ("<a class='grid__item_a' onClick='getDetail("+lastid+")'><div class='w-c-prev'><div class='w-c-i'><i class='fa fa-angle-double-left'></i>"+
						"</div><div class='w-c-txt' id='flipLast'><span>上一篇</span><span class='w-c-ttitle' id='boxLast'></span></div></div></a>"+
						"<a class='grid__item_a' onClick='getDetail("+nextid+")'><div class='w-c-next'><div class='w-c-i'><i class='fa fa-angle-double-right'></i></div>"+
								"<div class='w-c-txt' id='flipNext'><span>下一篇</span><span class='w-c-ttitle' id='boxNext'></span></div></div></a>");
				$("#last_next").html(value);
				$("#boxLast").html(checkNull(json.lastCultural.title));
				$("#boxNext").html(checkNull(json.nextCultural.title));
				if(lastid==null||lastid==""){
					$("#flipLast").hide();
					}else{
						$("#flipLast").show();
						};
				if(nextid==null||nextid==""){
					$("#flipNext").hide();
					}else{
						$("#flipNext").show();
						};
				}
		
		</script>
		
		
	</head>
	<body>
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
								<button class="btn btn-default signup" type="submit" id="button2" disabled="true">
									注册
								</button>
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
								<a href="${ctxPath}/culturalinformation/index.html"><span class="w-menu-on">文化资讯</span>
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
		<div class="w-container">
	        <button id="menu-toggle" class="menu-toggle"><span>Menu</span></button>
	        <div id="theSidebar" class="sidebar">
	            <!--xuanyang-->
	            <div class="related">
					<a href="/culturalinformation/index.html" class="w-list-btn <c:if test='${param.type == null || param.type ==""}'>on</c:if>" date-type="all" id="t1">全部</a>
					<a href="/culturalinformation/index.html?type=0" class="w-list-btn <c:if test='${param.type == 0}'>on</c:if>" date-type="all" id="t2">时尚前沿</a>
					<a href="/culturalinformation/index.html?type=1" class="w-list-btn <c:if test='${param.type == 1}'>on</c:if>" date-type="all" id="t3">思维对话</a>
					<a href="/culturalinformation/index.html?type=2" class="w-list-btn <c:if test='${param.type == 2}'>on</c:if>" date-type="all" id="t4">品牌播报</a>
					<a href="/culturalinformation/index.html?type=3" class="w-list-btn <c:if test='${param.type == 3}'>on</c:if>" date-type="all" id="t5">聚焦四方</a>
					<%--<a href="/culturalinformation/index.html?type=4" class="w-list-btn <c:if test='${param.type == 4}'>on</c:if>" date-type="all" id="t6">四方志</a>
				--%></div>
	        </div>
	<c:if test="${param.type == null || param.type ==''}"></c:if>
	        <div id="theGrid" class="main">
	            <div id="loader" class="pageload-overlay" data-opening="M20,15 50,30 50,30 30,30 Z;M0,0 80,0 50,30 20,45 Z;M0,0 80,0 60,45 0,60 Z;M0,0 80,0 80,60 0,60 Z" data-closing="M0,0 80,0 60,45 0,60 Z;M0,0 80,0 50,30 20,45 Z;M20,15 50,30 50,30 30,30 Z;M30,30 50,30 50,30 30,30 Z">
	                <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 80 60" preserveAspectRatio="none">
	                    <path d="M30,30 50,30 50,30 30,30 Z" />
	                </svg>
	            </div>
	
	            <section class="grid">
	            	<c:forEach items="${culturalinformationList}" var="culList" varStatus="i">
		                <c:if test="${culList.type == 0}"><div class="grid__item w-g-h"></c:if>
						<c:if test="${culList.type == 1}"><div class="grid__item w-g-l"></c:if>
						<c:if test="${culList.type == 2}"><div class="grid__item w-g-r"></c:if>
						<c:if test="${culList.type == 3}"><div class="grid__item w-g-x"></c:if>
						<c:if test="${culList.type == 4}"><div class="grid__item w-g-s"></c:if>
		                    <a onClick="getDetail('${culList.culturalInformationId}')" class="grid__item_a" data-content="contentArticle" data-item="content__item" data-close="close-button-list">
		                        <div class="w-g-header">
		                            <b></b>
		                            <c:if test="${culList.type == 0}">时尚前沿</c:if>
									<c:if test="${culList.type == 1}">思维对话</c:if>
									<c:if test="${culList.type == 2}">品牌播报</c:if>
									<c:if test="${culList.type == 3}">聚焦四方</c:if>
									<c:if test="${culList.type == 4}">四方志</c:if>
		                             | <fmt:formatDate value="${culList.releaseTime}" type="date" dateStyle="long"/>
		                        </div>
		                        <img src="${mediaPath}other/${culList.logoImg}"/>
		                        <h2 class="title title--preview">${culList.title}</h2>
		                        <p class="w-content">
		                            ${culList.content}
		                        </p>
		                    </a>
		                    <div class="w-g-pyf">
		                       <span>
		                        <!-- JiaThis Button BEGIN -->
		                       <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
		                       
		                        <!-- JiaThis Button END -->
		                        </span> | <span>评论数 (${culList.commentNumber})</span> | <span>阅读数 (${culList.readNumber})</span>
		                        
		                    </div>
		                    <div class="loader"></div>
		                    <div class="meta meta--preview">
		                        ${culList.metaKeywork}
		                    </div>
		
		                </div>
		                <!--End-->
	                </c:forEach>
	            </section>
	            <section class="BookContent content1">
	                <div class="scroll-wrap">
	                    <article class="content__item w-g-h content__item_b">
	                        <iframe id="bookFrame" allowtransparency="true" src="monthly_1.html" style="height:2113px" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
	                    </article>
	                </div>
	                <button class="close-button-list close-button-list_b" id="close_button_a1"><i class="fa fa-close"></i><span>Close</span></button>
	            </section>
	            <section class="content contentArticle">
	                <div class="scroll-wrap">
	                    <article class="content__item w-g-h">
	                    
	                    	<div class="w-c-nrb" id="box1">
								<span class="category category--full" id="boxType"></span>
								<h2 class="title title--full" id="boxTitle"></h2>
								<div class="meta meta--full">
									<span class="meta__author" id="boxBy"></span>
									<span class="meta__date" id="boxTime"></span>
									<span class="meta__reading-time" id="boxRead"></span>
								</div>
								<div class="article_culture_detail" id="boxText"></div>
								<div class="w-c-np" id="last_next">
										<a class="grid__item_a" onClick="getDetail()">
											<div class="w-c-prev">
												<div class="w-c-i">
													<i class="fa fa-angle-double-left"></i>
												</div>
												<div class="w-c-txt" id="flipLast">
													<span>上一篇</span>
													<span class="w-c-ttitle" id="boxLast"></span>
												</div>
											</div>
										</a>
										<a class="grid__item_a" onClick="getDetail()">
											<div class="w-c-next">
	
												<div class="w-c-i">
													<i class="fa fa-angle-double-right"></i>
												</div>
												<div class="w-c-txt" id="flipNext">
													<span>下一篇</span>
													<span class="w-c-ttitle" id="boxNext"></span>
												</div>
											</div>
										</a>
									</div>
							</div>
							<div class="w-c-links">
	                            <div class="w-lin-left">
									<b>标签：</b>
									<a id="informationKey"></a>
								</div>
	                            <div class="w-lin-right">
	                              <span>
	                                <!-- JiaThis Button BEGIN -->
	                              <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	                                <!-- JiaThis Button END -->
	                              </span> | <span>阅读数 （12）</span>
	                             </div>
	                        </div>
	                        <div class="w-x-wz">
								<h3>相关文章</h3>
								<div class="w-x-items">
									
								</div>
							</div>
	                        <div class="w-c-pl">
								<!--jiaThis评论 UY BEGIN -->
								<div id="uyan_frame"></div>
								<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=2052677"></script>
								<!-- UY END -->
							</div>
	                    </article>
	
	                </div>
	
	                <button class="close-button-list" id="close_button_a"><i class="fa fa-close"></i><span>Close</span></button>
	            </section>
	            
	              <!--/分页-->
	              
	            
	        </div>
	         
	      </div>
	              <!-- /w-container -->
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
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/classie.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/list.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
	
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
	
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/tmasonry.js"></script>
	    <!--<script type="text/javascript" src="js/jquery.masonry.min.js"></script>-->
	
	    <script type="text/javascript">
	        $(function () {
				$(".grid__item_a").click(function(){
				$(".w-paget").css("z-index","-1");
	            });
	            //$(".w-paget").css("top",$("#theGrid .grid").outerHeight()-60);
	            $(window).load(function () {
	                //$("#close_button_a").click(function () {
	                //    $(this).removeClass("close-button--show");
	                //    $(".content__item_b").removeClass("content__item--show");
	                //    $(".content1").removeClass("content--show");
	                //})
	                var container = document.querySelector('#theGrid');
	                var msnry = new Masonry(container, {
	                    itemSelector: '.grid__item',
	                    columnWidth: 0
	                });
	                //xuanyang
	                $(".w-list-btn").bind('click', function (event) {
	                    var showclass = $(this).attr('date-type');
	                    $(this).addClass("on").siblings().removeClass("on");
	                    $("#theGrid .grid__item").each(function () {
	                        if (!$(this).hasClass(showclass) && showclass != 'all') {
	                            $(this).hide();
	                        } else {
	                            $(this).show();
								$(".w-paget").css("z-index","1300");
	                        }
	                    });
	                    //$(document.body).animate({ 'scrollTop': 0 }, 1000);
	                    msnry.layout();
	                });
	            });
	        });
	    </script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/svgLoader.js"></script>
	    <script>
	        (function () {
	            //				var pageWrap = document.getElementById( 'close_button_a' ),
	            //					pages = [].slice.call( document.querySelectorAll( 'div.container-p' ) ),
	            var currentPage = 0,
	                triggerLoading = [].slice.call(document.querySelectorAll('a.grid__item_a')),
	                closebutton = document.getElementById('close_button_a')
	            loader = new SVGLoader(document.getElementById('loader'), {
	                speedIn: 100
	            });
	
	            function init() {
	                triggerLoading.forEach(function (trigger) {
	                    trigger.addEventListener('click', function (ev) {
	                        ev.preventDefault();
	                        loader.show();
	                        // after some time hide loader
	                        setTimeout(function () {
	                            loader.hide();
	                            //								classie.removeClass( pages[ currentPage ], 'show' );
	                            // update..
	                            currentPage = currentPage ? 0 : 1;
	                            //								classie.addClass( pages[ currentPage ], 'show' );
	                        }, 2000);
	                    });
	                    closebutton.addEventListener('click', function (ev) {
	                        ev.preventDefault();
	                        loader.show();
	                        // after some time hide loader
	                        setTimeout(function () {
	                            loader.hide();
	                            //								classie.removeClass( pages[ currentPage ], 'show' );
	                            // update..
	                            currentPage = currentPage ? 0 : 1;
	                            //								classie.addClass( pages[ currentPage ], 'show' );
	                        }, 2000);
	                    });
	                });
	            }
	            init();
	        })();
	    </script>
	     <script type="text/javascript" >
		  var jiathis_config={
			  summary:"",
			  shortUrl:true,
			  hideMore:false
		  }
		  </script>
		  <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
		<script>
			$(function(){
				$("#theGrid").css("height",$("#theGrid .grid").outerHeight());
				$(window).resize(function() {
		  			$("#theGrid").css("height",$("#theGrid .grid").outerHeight());
			})
			})
		</script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery.masonry.min.js"></script>
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
		<script type="text/javascript">
			$(function() {
				//$(".w-paget").css("top",$("#theGrid .grid").outerHeight()-60);
				$(window).load(function() {
						
					var container = document.querySelector('#theGrid');
					var msnry = new Masonry(container, {
						itemSelector: '.grid__item',
						columnWidth: 0
					});
					$(".w-list-btn").bind('click', function(event) {
						var showclass = $(this).attr('date-type');
						
						$("#theGrid .grid__item").each(function() {
							if (!$(this).hasClass(showclass)&&showclass!='all') {
								$(this).hide();
							}else{
								$(this).show();
							}
						});
						msnry.layout();
					});
				});
			});
		</script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/svgLoader.js"></script>
		<script>
			(function() {
				//				var pageWrap = document.getElementById( 'close_button_a' ),
				//					pages = [].slice.call( document.querySelectorAll( 'div.container-p' ) ),
				var currentPage = 0,
					triggerLoading = [].slice.call(document.querySelectorAll('a.grid__item_a')),
					closebutton = document.getElementById('close_button_a')
				loader = new SVGLoader(document.getElementById('loader'), {
					speedIn: 100
				});

				function init() {
					triggerLoading.forEach(function(trigger) {
						trigger.addEventListener('click', function(ev) {
							ev.preventDefault();
							loader.show();
							// after some time hide loader
							setTimeout(function() {
								loader.hide();
								//								classie.removeClass( pages[ currentPage ], 'show' );
								// update..
								currentPage = currentPage ? 0 : 1;
								//								classie.addClass( pages[ currentPage ], 'show' );
							}, 2000);
						});
						closebutton.addEventListener('click', function(ev) {
							ev.preventDefault();
							loader.show();
							// after some time hide loader
							setTimeout(function() {
								loader.hide();
								//								classie.removeClass( pages[ currentPage ], 'show' );
								// update..
								currentPage = currentPage ? 0 : 1;
								//								classie.addClass( pages[ currentPage ], 'show' );
							}, 2000);
						});
					});
				}
				init();
			})();
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