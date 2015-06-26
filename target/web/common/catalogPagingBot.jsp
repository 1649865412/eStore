<%@ taglib prefix="app" tagdir="/WEB-INF/tags/app"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set scope="request" var="requestURI" value="${OriginalRequestURL}"/>
<c:if test="${not empty pageContext.request.queryString}">
	<c:set scope="request" var="requestURI" value="${OriginalRequestURL}?${pageContext.request.queryString}"/>
</c:if>
<div class="space">
	
		<c:if test="${sc.pageNo > 1}">
		<a href="<app:pagingUtil url="${requestURI}" pageNum="${sc.pageNo-1}"/>">Previous</a>
		</c:if>
		|
		<c:if test="${(sc.pageNo - 2) > 1}"><a href="<app:pagingUtil url="${requestURI}" pageNum="1"/>">1</a>&nbsp;</c:if>
		<c:if test="${(sc.pageNo - 2) > 2}">...</c:if>
		<c:forEach begin="${(sc.pageNo - 2) > 0? (sc.pageNo - 2):1}" 
		           end="${(sc.pageNo + 2) < sc.pageCount ? (sc.pageNo + 2): sc.pageCount}" 
		           var="vPage">
			<c:if test="${sc.pageNo == vPage}">${vPage}</c:if>
			<c:if test="${sc.pageNo != vPage}"><a href="<app:pagingUtil url="${requestURI}" pageNum="${vPage}"/>">${vPage}</a></c:if>
			&nbsp;
		</c:forEach>
		<c:if test="${(sc.pageNo + 2) < (sc.pageCount - 1)}">...&nbsp;</c:if>
		<c:if test="${(sc.pageNo + 2) < sc.pageCount}"><a href="<app:pagingUtil url="${requestURI}" pageNum="${sc.pageCount}"/>">${sc.pageCount}</a>&nbsp;</c:if>
		|
		<c:if test="${sc.pageNo < sc.pageCount}">
		<a href="<app:pagingUtil url="${requestURI}" pageNum="${sc.pageNo+1}"/>">Next</a>
		</c:if>
</div>