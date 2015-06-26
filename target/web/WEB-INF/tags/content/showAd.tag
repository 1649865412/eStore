<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ attribute name="adPositionType"%>
<jsp:include page="/content/adPublish_dy.html">
	<jsp:param name="adPositionType" value="${adPositionType}" />
	<jsp:param name="categoryPath" value="${category.fullCategoryPath}" />
	<jsp:param name="doAction" value="defaultAction" />
</jsp:include>