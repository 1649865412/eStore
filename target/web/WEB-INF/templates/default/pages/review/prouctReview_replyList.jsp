<%@ include file="/common/taglibs.jsp"%>
<c:forEach items="${reviewReplyList}" var="item" varStatus="itemStatus">
    <div class="replyinfo">
         <div class="replyinfo-wrap">
			 <strong><fmt:message key="productReview.Replier"/>:</strong><span class="cRed">${appConfig.store.name} Sales Representative</span> (<fmt:formatDate value="${item.createTime}" pattern="MM/dd/yyyy hh:mm:ss"/>)
			  <p><c:out value="${item.message}"/></p>
		 </div>
    </div>
    <div class="blank10"></div>
</c:forEach>