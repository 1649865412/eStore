<%@ taglib prefix="app" tagdir="/WEB-INF/tags/app"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set scope="request" var="requestURI" value="${OriginalRequestURL}"/>
<c:if test="${not empty pageContext.request.queryString}">
	<c:set scope="request" var="requestURI" value="${OriginalRequestURL}?${pageContext.request.queryString}"/>
</c:if>
<script type="text/javascript">
function goPage(pageNo)
{
	var url = "<app:pagingUtil url="${requestURI}" pageNum="1"/>";
	if (url.indexOf("search-prod.html") > 0)
	{
		url = url.replace("pageNo=1","pageNo="+pageNo);
	}
	else
	{
		url = url.replace(".html","_pn"+pageNo+".html");
	}
	window.location = url;
}
function changeSort($sort)
{
	window.location = removeParamFromUrl(fnAppendUrl("${OriginalRequestURL}?${pageContext.request.queryString}", "sort", $sort),"pageNo");
}
function changePageSize($size)
{
	window.location = removeParamFromUrl(fnAppendUrl("${OriginalRequestURL}?${pageContext.request.queryString}", "rows", $size),"pageNo");
}
</script>
<div class="space">
	<ul class="pagination">
		<c:if test="${sc.pageNo > 1}">
		<li><a href="<app:pagingUtil url="${requestURI}" pageNum="${sc.pageNo-1}"/>" title="Previous"><img src="${resPath}/images/icon/icon_back.gif"/ ></a></li>
		</c:if>
		<c:if test="${sc.pageCount>1}">
		<li style="padding-top:1px;">
			<c:if test="${1 == sc.pageNo}">1</c:if>
			<c:if test="${1 != sc.pageNo}"><a href="<app:pagingUtil url="${requestURI}" pageNum="1"/>">1</a></c:if>
			<c:if test="${sc.pageCount >= 2}">
			<c:forEach begin="2" end="${sc.pageCount - 1}" var="vPage">
			<c:choose>
				<c:when test="${sc.pageNo == 1 || sc.pageNo == sc.pageCount}">
					<c:choose>
					<c:when test="${vPage == sc.pageNo +3 || vPage == sc.pageNo - 3}">
						...
					</c:when>
					<c:when test="${vPage <= sc.pageNo +2 && vPage >= sc.pageNo -2}">
						<c:if test="${vPage == sc.pageNo}">${vPage}</c:if>
						<c:if test="${vPage != sc.pageNo}"><a href="<app:pagingUtil url="${requestURI}" pageNum="${vPage}"/>">${vPage} </a></c:if>
					</c:when>				
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${vPage == sc.pageNo +2 || vPage == sc.pageNo - 2}">
						...
					</c:when>
					<c:when test="${vPage <= sc.pageNo +1 && vPage >= sc.pageNo -1}">
						<c:if test="${vPage == sc.pageNo}">${vPage}</c:if>
						<c:if test="${vPage != sc.pageNo}"><a href="<app:pagingUtil url="${requestURI}" pageNum="${vPage}"/>">${vPage} </a></c:if>
					</c:when>				
					</c:choose>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			</c:if>
			<c:if test="${sc.pageCount == sc.pageNo}">${sc.pageCount}</c:if>
			<c:if test="${sc.pageCount != sc.pageNo}"><a href="<app:pagingUtil url="${requestURI}" pageNum="${sc.pageCount}"/>">${sc.pageCount}</a></c:if>
		</li>
		</c:if>
		<c:if test="${sc.pageNo < sc.pageCount}">
		<li><a href="<app:pagingUtil url="${requestURI}" pageNum="${sc.pageNo+1}"/>" title="Next"><img src="${resPath}/images/icon/icon_next.gif"/ ></a></li>
		</c:if>
	</ul>
</div>