/**
 * 实时判断用户是否登录并在会话有效期内的方法，适合需要实时检查的时候用。主要方法为doRequiredLoginAction，其他方法主要是内部使用。
 */
function isLoginedAtServer() {
	var currentUserId;
	$.ajax({type: "GET", url: __ctxPath+"/ajaxCurrentUser.html", async: false ,dataType: "json",success:function(result){
		currentUserId = result.data.appUserId;
	}});
	return currentUserId == "-2" ? false : true;
}
var globalLoginCallback = null;
function doRequiredLoginAction(loginCallback , flag) {
	if(!flag)
		globalLoginCallback = loginCallback;
	if (!isLoginedAtServer()) {
		if (window.confirm(__FMT.loginConfirm)) {
			fnShowLoginDialog();
		}
	} else {
		globalLoginCallback = loginCallback;
		execLoginCallback();
	}
}
function execLoginCallback() {
	if (globalLoginCallback!=null) {
		globalLoginCallback.call();
		globalLoginCallback=null;
	}
}
var dlgLogin=null;
function fnShowLoginDialog() {
	if (dlgLogin==null) {
		dlgLogin = fnCreateSimpleDialog("Login",__FMT.first_login,null,{
			dialogWidth:"400px",
			dialogHeight:"180px"
		});
	}
	dlgLogin.showDialog(__ctxPath + "/loginDlg.html?decorator=blank",function(){
		$("#j_username").val(getLoginUserEmail(false));
	});
}
function fnDoLoginHandler() {
	var username = $("#j_username").val();
	var password = $("#j_password").val();
	if (trim(username) == "") {
		alert(__FMT.customer_username_isRequired);
		$("#j_username").focus();
		return;
	}
	if (trim(password) == "") {
		alert(__FMT.customer_password_isRequired);
		$("#j_password").focus();
		return;
	}
	$.post(__ctxPath+"/ajaxLogin.html",{username:username,password:password},function (result) {
		if (result.status == 1) {
			//sysMsg("You signed in system successfully!");
			dlgLogin.closeDialog();
			fillLoginPrompt();
			$mnc.refresh();
			execLoginCallback();
		} else {
			$("#loginMsg").html("<font color='red'>"+__FMT.customer_login_fail+"</font>");
		}
	},"json");
}
function password_onkeypress(event) {
	var code = (event.keyCode == null) ? event.charCode : event.keyCode;
	if (code == 13) {
		fnDoLoginHandler();
	}
}