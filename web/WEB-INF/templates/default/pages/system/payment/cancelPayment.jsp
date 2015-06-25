<%@ include file="/common/taglibs.jsp"%>
<%
	//author:csx 
	//desc: A page to which the customer's browser is returned if payment is canceled;
%>
<HTML>
<HEAD>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<TITLE><fmt:message key="payment.cancel.title"/></TITLE>
</HEAD>
<BODY>
	<div style="text-align: center">
		<div class="clewmsg">
			<div class="text" style="width:100%">
				<table border="0" align="center" width="100%">
					<tr>
						<td rowspan="2" width="60" valign="top"><IMG height="50" alt="error" src="${resPath}/images/msg_error.gif" width="50" align="middle"></td>
					</tr>
					<tr>
						<td valign="top">
							<span>
								<font color="red">
									<fmt:message key="payment.cancel.tips"/>
								</font>
							</span>
						</td>
					</tr>	
				</table>
			</div>
		</div>
		<div style="font: 0px/0px sans-serif;clear: both;display: block"></div>
	</div>
	<br/>
</BODY>
</HTML>
