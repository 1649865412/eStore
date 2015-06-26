<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<c:forEach var="item" items="${ads}" end="1">
<div class="blank10"></div>
<content:displayOneAd ad="${item}"/>
</c:forEach>
