<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<HTML>
	<HEAD>
		<TITLE><fmt:message key="passwordRecover.resetPassword" />
		</TITLE>
		<link href="${ctxPath}/styles/account.css" rel="stylesheet"
			type="text/css" />
	</HEAD>
	<BODY>
		<div class="box-register-wrap">
			<div class="top">
				<div class="title">
					<fmt:message key="passwordRecover.resetPassword" />
				</div>
			</div>
			<%@ include file="/common/messages.jsp"%>
			<div class="blank10"></div>
			<div class="content">
				<span style="color: red; font-weight: bold;"> <c:set
						var="forgetURL">${ctxPath}/forgetPassword.html</c:set> <fmt:message
						key="passwordRecover.expried">
						<fmt:param value="${forgetURL}" />
					</fmt:message> </span>
				<div class="blank10"></div>

			</div>

		</div>
	</BODY>
</HTML>
