<%@ include file="/common/taglibs.jsp"%>
<HTML>
<HEAD>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<TITLE><fmt:message key="errors.notice"/></TITLE>
</HEAD>
<BODY>
	<c:set var="isError" value="true" scope="request"/>
	<div style="text-align: center">
		<div class="clew-message">
		  <div class="clew-top"><fmt:message key="errors.notice"/></div>
			<div class="clew-content">
			<div class="text" style="text-align:left;width:100%">
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td valign="top" align="right">
							<IMG height="50" alt="error" src="${resPath}/images/msg_error.gif" width="50" align="middle">					
						</td>
						<td>
							<font color="red"><i18n:msg expr="payment.setting.wrongtips"/></font>
						</td>
					</tr>
				</table>
			</div>
		</div>
		</div>
	</div>
	<br/>
</BODY>
</HTML>
