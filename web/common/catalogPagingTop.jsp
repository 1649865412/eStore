<%@ page pageEncoding="UTF-8"%>
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
</script>
<div class="space">
	<div class="left">Showing ${sc.itemNoBegin} - ${sc.itemNoEnd} of ${sc.totalCount} Items</div>
	<ul class="pagination">
		<c:if test="${sc.pageNo > 1}">
		<li class="next"><a href="<app:pagingUtil url="${requestURI}" pageNum="${sc.pageNo-1}"/>" title="Previous">«</a></li>
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
		<li class="next"><a href="<app:pagingUtil url="${requestURI}" pageNum="${sc.pageNo+1}"/>" title="Next">»</a></li>
		</c:if>
	</ul>
	<div class="right">
		<div class="left">Sorted By:</div>
		<div class="page-select">
			<select id="select_sort" class="box-input" onchange="changeSort(this.value)">
				<option value="s1" <c:if test="${param.sort == 's1' or empty param.sort}">selected</c:if>><fmt:message key="productList.sort.new_arrival"/></option>
				<option value="s2" <c:if test="${param.sort == 's2'}">selected</c:if>><fmt:message key="productList.sort.best_selling"/></option>
				<option value="s3" <c:if test="${param.sort == 's3'}">selected</c:if>><fmt:message key="productList.sort.item_name"/></option>
				<option value="s4" <c:if test="${param.sort == 's4'}">selected</c:if>><fmt:message key="productList.sort.price.lowToHigh"/></option>
				<option value="s5" <c:if test="${param.sort == 's5'}">selected</c:if>><fmt:message key="productList.sort.price.highToLow"/></option>
			</select>
		</div>
	</div>
</div>