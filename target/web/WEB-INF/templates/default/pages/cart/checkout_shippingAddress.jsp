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
<div class="left">
	<img src="${resPath}/images/icon/cart2.jpg"/ >
</div>
<div class="clear"></div>
<c:choose>
	<c:when test="${(not empty shippingAddressList)||(not empty billingAddress)}">
	<%--列出相应的运输地址及发票地址--%>
		<div class="checkout-content" style="font-size:14px;">
			<h5>选择收货地址</h5>
			<ul class="review">
				<c:forEach items="${shippingAddressList}" var="shippingAddress">
					<li class="ship">
						<input type="submit" value="配送到这个地址" class="box-btn" onclick="fnSelectAddress(${shippingAddress.addressId});"><br />
						${shippingAddress.stateName}${emptySpace}${shippingAddress.cityName}${emptySpace}${shippingAddress.address}${emptySpace}${emptySpace}${emptySpace}${emptySpace}${shippingAddress.zip}${emptySpace}${emptySpace}${emptySpace}${emptySpace}(${shippingAddress.firstname}${emptySpace}收)${emptySpace}${emptySpace}${emptySpace}${emptySpace}${shippingAddress.telephone}
						<ul class="pad_top">
							<a href="${ctxPath}/checkout/address/edit/${shippingAddress.addressId}.html" style="color:#f00;">编辑</a>
							<a href="javascript:if(confirm('是否要删除这收货地址?')){window.location.href='${ctxPath}/checkout/address/delete/${shippingAddress.addressId}.html';}" style="color:#f00;">删除</a>
						</ul>
					</li>
				</c:forEach>
			</ul>
			<form id="selectAddressForm" action="${ctxPath}/checkout/address.html" method="post">
				<input type="hidden" value="selectShippingAddress" name="doAction">
				<input type="hidden" name="shippingAddressId">
			</form>
			<script type="text/javascript">
				function fnSelectAddress(addressId){
					$("#selectAddressForm").get(0).shippingAddressId.value=addressId;
					$("#selectAddressForm").submit();
				}
			</script>
			<div class="blank24"></div>
			<div class="billing-address">
				<a name="createShip"></a>
				<h4>
					使用新地址
				</h4>
			</div>
			<form id="addressForm" action="${ctxPath}/checkout/address/add.html" method="post">
				<table border="0" cellpadding="0" cellspacing="0" align="center" width="950">
					<%@ include file="../customer/include/addressFormBody.jspf" %>
				</table>
				<div class="blank24"></div>
				<input type="hidden" value="list" name="list">
				<div align="center"><input type="submit" class="box-btn"  value="保存" /></div>
			</form>
		</div>
	</c:when>
	<c:otherwise>
		<%--直接显示表单创建运输地址及发票地址--%>
		<form id="addressForm" <c:if test="${empty address.id&& empty param.adreType}"> action="${ctxPath}/checkout/address.html"</c:if> method="post">
			<div class="checkout-content">
				<%@ include file="include/shippingAddressFormBody.jspf" %>
				<input type="hidden" name="url" value="${param.url}">
				<div class="blank24"></div>
				<div align="center"><input type="submit" class="box-btn"  value="保存" /></div>
			</div>
		</form>
	</c:otherwise>
</c:choose>
