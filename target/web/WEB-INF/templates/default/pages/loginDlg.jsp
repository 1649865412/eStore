<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache");
%>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" style="font-size:13px; line-height:200%;">
	<tr>
		<td colspan="3" align="center">
			<div id="loginMsg" style="text-align: center">
&nbsp;			</div>		</td>
	</tr>
	<tr>
		<td width="32%" align="right">
			<fmt:message key="label.username" />
			&nbsp;*&nbsp;		</td>
		<td width="40%">
			<input type="text" id="j_username" name="j_username" tabindex="1" class="box-input" style="width: 200px" />		</td>
		<td width="28%" rowspan="2" class="logindlg" align="center">
			<input type="button" onclick="fnDoLoginHandler();" value="登录" class="box-btn">
			</td>
	</tr>
	<tr>
		<td align="right">
			<fmt:message key="label.password" />
			&nbsp;*&nbsp;		</td>
		<td>
			<input type="password" class="box-input" id="j_password" name="j_password" tabindex="2" style="width: 200px" onkeypress="password_onkeypress(event);" />		</td>
	</tr>
	<tr>
		<td height="28">&nbsp;		</td>
		<td colspan="2">

			&nbsp;
			<a href="${ctxPath}/signup.html" style="color:#756B48; text-decoration:underline;"><fmt:message key="customer.register.title" />
			</a> &nbsp;
			<a href="${ctxPath}/forgetPassword.html" style="color:#756B48; text-decoration:underline;"><fmt:message key="yourPocket.forgetPassword" />
			</a>		</td>
	</tr>
</table>
