<%@ include file="/common/taglibs.jsp"%>
<HTML>
<HEAD>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<TITLE><fmt:message key="errors.pay.money"/></TITLE>
</HEAD>
<BODY>
	<c:set var="isError" value="true" scope="request"/>
	<div style="text-align: center">
		<div class="clewmsg">
			<div class="text" style="text-align:left;width:100%">
				<IMG height="50" alt="error" src="${resPath}/images/msg_error.gif" width="50" align="middle">
				<font color="red"><i18n:msg expr="payment.setting.wrongtips"/></font>
				<div style="font: 0px/0px sans-serif;clear: both;display: block"></div>
			</div>
		</div>
	</div>
	<br/>
</BODY>
</HTML>
