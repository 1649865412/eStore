<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ attribute name="orderSku" required="true" type="com.cartmatic.estore.common.model.order.OrderSku"%>
<c:set var="str" value="${orderSku.displaySkuOptions}"/>
<c:if test="${not empty str}">
<c:forEach var="item" items='${fn:split(str,"###")}'>
   ${item}<br/>
</c:forEach>
</c:if>