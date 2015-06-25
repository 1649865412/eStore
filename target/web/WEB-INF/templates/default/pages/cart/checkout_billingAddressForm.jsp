<%@ include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="customer" tagdir="/WEB-INF/tags/customer"%>
<script type="text/javascript"	src="${ctxPath}/scripts/cartmatic/common/region.js"></script>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<spring:bind path="address.*">
	<c:if test="${not empty status.errorMessages}">
		<div class="error_box">
		<c:forEach var="error" items="${status.errorMessages}">
			<c:out value="${error}" escapeXml="false" /><br/>
		</c:forEach>
		</div>
	</c:if>
</spring:bind>
Billing Address<br />
<form id="addressForm"  method="post">
	<div class="checkout-content">
		<%@ include file="include/shippingAddressFormBody.jspf" %>
		<input type="hidden" name="url" value="${param.url}">
		<div class="blank24"></div>
		<div align="center"><input type="image" src="${resPath}/images/btn/btn_save.gif" value="save"></div>
	</div>
</form>