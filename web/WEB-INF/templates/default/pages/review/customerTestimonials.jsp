<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:if test="${not empty productReviewList}">
<div id="customerTestimonials">
<c:forEach items="${productReviewList}" var="review" varStatus="varStatus">
	<c:if test="${varStatus.count%3==1}">
	<ul class="productReviews" <c:if test="${!varStatus.first}"> style="display: none;"</c:if> id="customerTestimonial_<fmt:formatNumber pattern="###" value="${varStatus.count/3+1}"></fmt:formatNumber>">
	</c:if>
	 	<li>
	       	<div class="photo"><product:productImg product="${review.product}" size="d" width="165" height="165" isLazyload="true"/></div>
	     	<div class="item">
	           <product:productName product="${review.product}" /><br/>
	     <strong>Posted:</strong>
	        <fmt:formatDate value="${review.createTime}"/><br/>
	     <strong>Reviewer:</strong>
	    			<app:showCustomerName str="${review.customerName}"/>
	             <br/>
	    		<strong>Overall Rating:</strong>
	             <product:ratingStar value="${review.rate}" />
	             <br/>
	              <a href="<product:productUrl product="${review.product}" />#reviews" title="${review.subject}" >
	             	<c:out value="${review.message}"/>                        
	             </a>
	          </div>
        </li>
    <c:if test="${varStatus.last||varStatus.count%3==0}"></ul></c:if>
</c:forEach>
</div>
</c:if>