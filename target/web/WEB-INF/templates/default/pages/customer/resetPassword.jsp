<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<HTML>
	<HEAD>
		<TITLE><fmt:message key="passwordRecover.resetPassword" /></TITLE>
	</HEAD>
	<BODY>
		<%@ include file="/common/messages.jsp"%>
		<div class="content">
			<spring:bind path="passwordModel.*">
				<c:if test="${not empty status.errorMessages}">
					<ul>
						<c:forEach var="error" items="${status.errorMessages}">
							<li>
								<img src="${resPath}/images/imgs2.gif"
									alt="<fmt:message key="icon.warning"/>" class="icon" />
								<font color="red"><b><c:out value="${error}"
											escapeXml="false" /> </b> </font>
							</li>
						</c:forEach>
					</ul>
				</c:if>
			</spring:bind>
		</div>
		<div class="box-color">
			<h6><fmt:message key="passwordRecover.resetPassword" /></h6>
			<form id="passwordModel" action="${ctxPath}/resetPassword.html" method="post">
				<div class="clear"></div>
				<table cellpadding="0" cellspacing="0" width="100%" align="center"
					class="table-account">
					<tr>
						<td colspan="2">
							&nbsp;&nbsp;<fmt:message key="passwordRecover.resetPassword.tips" />
						</td>
					</tr>
					<tr>
						<td align="right">
							<fmt:message key="passwordRecover.email" />
							:
						</td>
						<td>
							<spring:bind path="passwordModel.email">
								<input type="text" name="${status.expression}"
									id="${status.expression}" value="${status.value}"
									class="box-input" size="33">
							</spring:bind>
						</td>
					</tr>
					<tr>
						<td align="right">
							<fmt:message key="passwordRecover.password" />
							:
						</td>
						<td>
							<input type="password" name="password" class="box-input"
								size="33" />
							<span class="tips">(6-16 characters)</span>
						</td>
					</tr>
					<tr>
						<td align="right">
							<fmt:message key="passwordRecover.repassword" />
							:
						</td>
						<td>
							<input type="password" name="repassword" class="box-input"
								size="33" />
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<spring:bind path="passwordModel.url">
								<input type="hidden" name="url" value="${status.value}" />
							</spring:bind>
							<input type="submit" name="submit"
								value="<fmt:message key="passwordRecover.submit"/>"
								class="button" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</BODY>
</HTML>
<v:javascript formName="passwordModel" staticJavascript="false" />