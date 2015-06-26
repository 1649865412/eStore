<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--
Note: to use this file, include this JSP inside a form.
Then in the controller, use getPagingBean() to pass to the BO and then DAO.
--%>
<script type="text/javascript">
var fnOnGoToPage${pagingId};
function gotoPage(pageNo) {
	$("#PrmPageNo").attr("name","PrmPageNo");
	$("#PrmPageNo").val(pageNo);
	//当页面存在fnOnGoToPage时，不自动提交表单，调用fnOnGoToPage
	if(fnOnGoToPage${pagingId}){
		fnOnGoToPage${pagingId}(pageNo);
	}else{
		$("#PrmPageNo").closest("form").submit();
	}
	return false;
}
</script>
<c:if test="${sc.totalPageCount>0}">
	<ul class="pagination">
		<c:choose>
			<c:when test="${sc.pageNo<=1}">
				<%--<li>
					First
				</li>
				--%>
				<li  style="padding-top:1px;">
					<a href="javascript:void(0);">
						<img src="${resPath }/images/icon/icon_back.gif">
					</a>
				</li>
			</c:when>
			<c:otherwise>
				<%--<li>
					<a href="javascript:gotoPage(1);void(0)">First</a>
				</li>
				--%><li  style="padding-top:1px;">
					<a href="javascript:gotoPage(<c:choose><c:when test="${(sc.pageNo-1) lt 1}">1</c:when><c:otherwise>${sc.pageNo-1}</c:otherwise></c:choose>);void(0)"> 
						<img src="${resPath }/images/icon/icon_back.gif">
					</a>
				</li>
			</c:otherwise>
		</c:choose>
		<c:set var="minPager" value="${(sc.totalPageCount-sc.pageNo>=2)?(sc.pageNo>=3?sc.pageNo-2:1):(sc.pageNo>=(3+2-sc.totalPageCount+sc.pageNo)?(sc.pageNo-4+sc.totalPageCount-sc.pageNo):1)}"></c:set>
		<c:set var="maxPager" value="${(maxPager+4>sc.totalPageCount)?sc.totalPageCount:(minPager+4)}"></c:set>
		<c:forEach begin="${minPager}" end="${maxPager}" var="pageNum" varStatus="varStatus">
			<c:choose>
				<c:when test="${sc.pageNo==pageNum}">
					<li class="selected"  style="padding-top:1px;">
						 ${pageNum}<c:if test="${!varStatus.last}"></c:if>
					</li>
				</c:when>
				<c:otherwise>
					<li  style="padding-top:1px;">
						<a href="javascript:gotoPage(${pageNum});void(0)">${pageNum}</a> <c:if test="${!varStatus.last}"></c:if>
					</li>
				</c:otherwise>
			</c:choose>

		</c:forEach>
		<c:choose>
			<c:when test="${sc.pageNo==sc.totalPageCount}">
				<li>
					<a href="javascript:void(0);">
						<img src="${resPath }/images/icon/icon_next.gif">
					</a>
				</li>
				<%--<li>
					Last
				</li>
			--%></c:when>
			<c:otherwise>
				<li>
					<a href="javascript:gotoPage(${sc.pageNo+1});void(0)"> 
						<img src="${resPath }/images/icon/icon_next.gif">
					</a>
				</li>
				<%--<li>
					<a href="javascript:gotoPage(${sc.totalPageCount});void(0)"> Last </a>
				</li>
			--%></c:otherwise>
		</c:choose>
	</ul>
	<input type="hidden" id="pagingform"/>
	<input type="hidden" id="PrmPageNo"/>
</c:if>