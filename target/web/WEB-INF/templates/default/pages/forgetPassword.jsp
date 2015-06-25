<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
	<head>
		<title><fmt:message key="yourPocket.forgetPassword" /></title>
		<link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />
		<link href="${resPath}/styles/head_foot.css" rel="stylesheet" type="text/css" />
		<link href="${resPath}/styles/nav.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<%@ include file="/common/messages.jsp"%>
		<div class="box-color">
			<h6>
				<fmt:message key="yourPocket.forgetPassword" />
			</h6>
			<form name="forgotPasswordForm" method="post" action="${ctxPath}/forgetPassword.html" onSubmit="return validateForm(this);">
				<div class="clear"></div>
				<table class="table-sign" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="2">
							<fmt:message key="passwordRecover.mainDescription" />
						</td>
					</tr>
					<tr>
						<td align="right">
							<b><fmt:message key="passwordRecover.email" /> </b>
						</td>
						<td align="left">
							<input type="text" autocomplete="off" name="email" size="30" class="box-input" />
							&nbsp;
							<font color="red">*</font>
							<input type="submit" value="<fmt:message key="passwordRecover.submit"/>" class="button" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<script type="text/javascript">
			function validateForm(form){
				if(!fnValidateEmail(form.email.value)){
					alert("<fmt:message key="passwordRecover.email.required"/>");
					return false;
				}
				return true;
			}
		</script>
	</body>
</html>