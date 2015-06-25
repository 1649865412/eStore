<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ attribute name="var" type="java.util.List"%>
<fmt:message key="productDetail.clickToDownAttach"/>
<c:forEach items="${var}" var="item">
	<c:set var="tempMediaUrl" value="${item.mediaUrl}"></c:set>
   	<a href="${mediaPath}${item.mediaUrl}" target="_blank" title="${item.mediaDescription}"><b><%String tempMediaUrl=(String)jspContext.getAttribute("tempMediaUrl");out.println(tempMediaUrl.substring(tempMediaUrl.lastIndexOf("/")+1,tempMediaUrl.length()));%></b></a>&nbsp;&nbsp;
</c:forEach>