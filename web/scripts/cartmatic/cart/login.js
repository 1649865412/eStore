/*登陆注册相关方法*/
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
			}else if(window.location.pathname=="/designerList.html" || window.location.pathname=="/Designer_Service/search.html" || window.location.pathname=="/designer/initialsSelect.html"){
				$("#searchForm").attr("action", "${ctxPath}/Designer_Service/search.html?q="+$("#q").val());
				$("#searchForm").submit();
			}else if(window.location.pathname=="/marketDesignerList/index.html" || window.location.pathname=="/marketDesigner_Service/search.html" || window.location.pathname=="/marketDesigner/initialsSelect.html"){
				$("#searchForm").attr("action", "${ctxPath}/marketDesigner_Service/search.html?q="+$("#q").val());
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
		document.cookie = name + "=" + cval + "; expires="+ exp.toGMTString()+"; path=/";
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
	
	
	function addCartNum(){
		var cartNum = $(".w-gwc").val();
		alert(cartNum);
	}