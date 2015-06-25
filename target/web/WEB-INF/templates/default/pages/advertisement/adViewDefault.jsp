<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<c:forEach var="item" items="${ads}" end="1">
	<content:displayOneAd ad="${item}"/>
</c:forEach>