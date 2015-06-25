<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
	attribute name="confValue" required="true"%><c:if test="${not empty confValue}"><%{
	    String[] metaValue = confValue.split(":");
%><meta name="<%=metaValue[0]%>" content="<%=metaValue[1]%>"/><%}%></c:if>