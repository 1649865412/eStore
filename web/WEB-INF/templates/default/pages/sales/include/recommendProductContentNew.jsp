<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>

		<c:forEach items="${productList}" var="productItem" varStatus="varStatus" >
		<li><a href="#"><product:productImg product="${productItem}" size="v" width="72" height="97" category="${category}"/></a></li>
		</c:forEach>
