<%@ include file="/common/taglibs.jsp"%>
<c:set var="promotionListSize" value="${fn:length(promotionList)}" />
<c:if test="${promotionListSize > 0}">
<div class="promo">
    <ul>
            <c:forEach items="${promotionList}" var="item" varStatus="itemStatus">
           	<li>
             <c:if test="${not empty item.endTime}">
                   <span class="f13px">
                            <fmt:message key="promotion.during.to" >
                                <fmt:param><fmt:formatDate value="${item.endTime}" /></fmt:param>
                            </fmt:message>
                     </span>
             </c:if>
             </li>
            </c:forEach>
      </ul>
</div>
</c:if>