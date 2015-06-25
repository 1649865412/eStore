<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><%@ 
	attribute name="step"%>
<c:choose>
	<c:when test="${checkoutModel.checkoutFlow.isSupportWrap }">
		<img src="${resPath}/images/img/check-cn-flow-plugin-${step}.jpg"
			alt="address" usemap="#Map2" onclick="return false;" />
	</c:when>
	<c:otherwise>
		<img src="${resPath}/images/img/check-cn-flow-${step}.gif"
			width="420" height="35" alt="address" usemap="#Map1"
			onclick="return false;" />
	</c:otherwise>
</c:choose>
<map name="Map1" id="Map1">
	<c:if test="${checkoutModel.status==3}">
		<c:if
			test="${step eq 'shipping' or step eq 'payment' or step eq 'place'}">
			<area shape="rect" coords="1,1,87,34" href="#"
				alt="<fmt:message key='checkout.gotoAddress'/>"
				onclick="fnJumpStep('loadAddress');" />
		</c:if>
		<c:if
			test="${step eq 'address' or step eq 'payment' or step eq 'place'}">
			<area shape="rect" coords="101,0,191,35" href="#"
				alt="<fmt:message key='checkout.gotoShipping'/>"
				onclick="fnJumpStep('loadShipping');" />
		</c:if>
		<c:if
			test="${step eq 'address' or step eq 'shipping' or step eq 'place'}">
			<area shape="rect" coords="204,0,301,34" href="#"
				alt="<fmt:message key='checkout.gotoPayment'/>"
				onclick="fnJumpStep('loadPayment');" />
		</c:if>
		<c:if
			test="${step eq 'address' or step eq 'shipping' or step eq 'payment'}">
			<area shape="rect" coords="336,1,419,34" href="#"
				alt="<fmt:message key='checkout.gotoPlaceOrder'/>"
				onclick="fnJumpStep('previewOrder');" />
		</c:if>
	</c:if>
	<c:if test="${checkoutModel.status==2}">
		<c:if test="${step eq 'shipping' or step eq 'payment'}">
			<area shape="rect" coords="1,1,87,34" href="#"
				alt="<fmt:message key='checkout.gotoAddress'/>"
				onclick="fnJumpStep('loadAddress');" />
		</c:if>
		<c:if test="${step eq 'payment'}">
			<area shape="rect" coords="101,0,191,35" href="#"
				alt="<fmt:message key='checkout.gotoShipping'/>"
				onclick="fnJumpStep('loadShipping');" />
		</c:if>
	</c:if>
</map>
<map name="Map2" id="Map2">
	<c:if test="${checkoutModel.status==3}">
		<c:if
			test="${step eq 'wrap' or step eq 'shipping' or step eq 'payment' or step eq 'place'}">
			<area shape="rect" coords="2,1,81,33" href="#"
				alt="<fmt:message key='checkout.gotoAddress'/>"
				onclick="fnJumpStep('loadAddress');" />
		</c:if>
		<c:if
			test="${step eq 'address' or step eq 'shipping' or step eq 'payment' or step eq 'place'}">
			<area shape="rect" coords="98,1,187,34" href="#"
				onclick="fnJumpStep('loadWrap');" alt="<fmt:message key='checkout.wrap.plase'/>" />
		</c:if>
		<c:if
			test="${step eq 'address' or step eq 'wrap' or step eq 'payment' or step eq 'place'}">
			<area shape="rect" coords="199,1,297,34" href="#"
				onclick="fnJumpStep('loadShipping');"
				alt="<fmt:message key='checkout.gotoShipping'/>" />
		</c:if>
		<c:if
			test="${step eq 'address' or step eq 'wrap' or step eq 'shipping' or step eq 'place'}">
			<area shape="rect" coords="303,1,398,34" href="#"
				onclick="fnJumpStep('loadPayment');"
				alt="<fmt:message key='checkout.gotoPayment'/>" />
		</c:if>
		<c:if
			test="${step eq 'address' or step eq 'wrap' or step eq 'shipping' or step eq 'payment'}">
			<area shape="rect" coords="407,1,496,34" href="#"
				onclick="fnJumpStep('previewOrder');"
				alt="<fmt:message key='checkout.gotoPlaceOrder'/>" />
		</c:if>
	</c:if>
	<c:if test="${checkoutModel.status==2}">
		<c:if
			test="${step eq 'wrap' or step eq 'shipping' or step eq 'payment'}">
			<area shape="rect" coords="2,1,81,33" href="#"
				alt="<fmt:message key='checkout.gotoAddress'/>"
				onclick="fnJumpStep('loadAddress');" />
		</c:if>
		<c:if test="${step eq 'shipping' or step eq 'payment'}">
			<area shape="rect" coords="98,1,187,34" href="#"
				onclick="fnJumpStep('loadWrap');" alt=""<fmt:message key='checkout.wrap.plase'/>" />
		</c:if>
		<c:if test="${step eq 'payment'}">
			<area shape="rect" coords="199,1,297,34" href="#"
				onclick="fnJumpStep('loadShipping');"
				alt="<fmt:message key='checkout.gotoShipping'/>" />
		</c:if>
	</c:if>
</map>
<c:if test="${checkoutModel.status==3}">
<br />
<div class="tip">
	<fmt:message key="checkout.jumpstep" />!
</div>
</c:if>
<p />