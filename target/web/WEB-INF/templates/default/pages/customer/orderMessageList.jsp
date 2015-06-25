<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<HTML>
	<HEAD>
		<TITLE>Order Message</TITLE>
		<script type="text/javascript">
		function fnValidaSendMsgForm($target)
		{
			if (validateForm($target))
				return true;
			else
			{
				alert(__vaMsg.notPass);
				return false;
			}
		}
		</script>
	</HEAD>
	<BODY>
		<div class="checkout-content">
		<content tag="heading"> Order Message </content>
		<form action="${ctxPath}/myaccount/orderMessage/list.html" method="post">
		<h5>My Messages</h5>
		<div class="account-content">
			<c:forEach var="message" items="${orderMessageList}" varStatus="varStatus">
			<table width="98%" border="0" cellpadding="0" cellspacing="0" align="center" class="table-message">
			  <tr>
				<td width="70%">
					<strong>Order# ${message.orderNo}</strong>
					<c:if test="${message.customerId!=message.createBy&&message.status!=1}">
					<img alt="new" src="${resPath}/images/img/new.gif">
					<c:set var="newMessageIds" value="${message.id},${newMessageIds}"></c:set>
					</c:if>
					<br />
					<strong>${message.subject}</strong><br />
					<span><fmt:formatDate value="${message.createTime}" pattern="MM/dd/yyyy HH:mm:ss" /></span>
				</td>
				<td align="center" valign="top">
					<a href="${ctxPath}/myaccount/order/${message.salesOrderId}.html" style="color:#3C660B;" target="_blank">VIEW ORDER DETAILS</a><br/>
					<a href="${ctxPath}/myaccount/orderMessage/delete/${message.id}.html" style="color:#E70D0D;">Delete This Message</a>
				</td>
			  </tr>
			  <tr>
				<td colspan="2" bgcolor="#FFFFFF" class="${message.customerId == message.createBy?'said':'back'}">
					<strong>
						<c:choose>
							<c:when test="${message.customerId == message.createBy}">You said</c:when>
							<c:otherwise>${appConfig.store.name} said</c:otherwise>
						</c:choose>
					:</strong><br />
					<c:set var="temp_message"><c:out value="${message.message}"></c:out></c:set>
					<%request.setAttribute("vEnter", "\n"); %>
					${fn:replace(temp_message,vEnter,"<br/>")}
				</td>
			  </tr>
			</table>
			<c:if test="${!varStatus.last}">
			<div class="dashed-line"></div>
			</c:if>
			</c:forEach>	
			<div class="blank24"></div>	
			<c:if test="${not empty orderMessageList}">
			<div class="dashed-line"></div>
			<div class="page"><%@ include file="/common/pagingOnlyNew.jsp"%></div>
			<div class="clear"></div>
			</c:if>
		</div>
		</form>
		
		<div class="blank24"></div>		
		<h5>Send a Message</h5>
		<div class="account-content">
		<form action="${ctxPath}/myaccount/orderMessage/add.html" method="post" onSubmit="return fnValidaSendMsgForm(this);">
		<table cellSpacing="0" cellPadding="0" width="100%" align="center"	class="table-account" border="0">
			<tr>
				<th width="30%">Order</th>
				<td>
					<select name="orderId" class="box-input" validConf="required">
						<c:forEach var="salesOrder" items="${activeOrders}">
						<option value="${salesOrder.salesOrderId}">
						${salesOrder.orderNo} -- placed on 
						<fmt:formatDate value="${salesOrder.createTime}" pattern="MM/dd/yyyy" />
						 for $${salesOrder.totalAmount}
						</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th width="30%">Subject</th>
				<td>
					<input type="text" class="box-input" name="subject" value="" validConf="required,maxlength=128" onBlur="validateEventHandler();">
				</td>
			</tr>
			<tr>
				<th width="30%">message</th>
				<td>
					<textarea type="textarea" id="messageContent" name="message" value="" rows="5" cols="45" validConf="required" 
					 onblur="validateEventHandler();"></textarea>
				</td>
			</tr>
			<tr>
				<th width="30%"></th>
				<td>
					<input type="submit" value="保存" class="box-btn">
				</td>
			</tr>
		</table>
		</form>
		</div>
		<c:if test="${not empty newMessageIds}">
		<script type="text/javascript">
			ajaxCall(__ctxPath+"${ctxPath}/myaccount/orderMessage/list.html?doAction=updateStatus","ids=${newMessageIds}","post",false,function(){});
		</script>
		</c:if>
		</div>
	</BODY>
</HTML>