<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ attribute name="navigatorCategorys" type="java.util.List" required="true" description="导航目录"%>
<%@ attribute name="pageType" type="java.lang.Short" description="导航页面类型，1表示产品目录页面，2表示详细页面（如Product，Content）"%>
<c:forEach items="${navigatorCategorys}" var="category" varStatus="navIndex">
	<c:choose>
		<c:when test="${pageType==2}">
			<a<c:if test="${navIndex.last}"> class="selected"</c:if> href="<product:categoryUrl category="${category}" />" >
				${category.categoryName}
			</a>
			<c:if test="${not navIndex.last}">&nbsp;&gt;&nbsp;</c:if>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${(fn:length(navigatorCategorys))>navIndex.count}">
					<a href="<product:categoryUrl category="${category}"/>">${category.categoryName}</a>
					&nbsp;&gt;&nbsp;
				</c:when>
				<c:otherwise>
					<span class="selected">${category.categoryName}</span>					
				</c:otherwise>		
			</c:choose>
		</c:otherwise>
	</c:choose>
</c:forEach>