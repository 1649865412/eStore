<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	attribute name="date" type="java.util.Date"%><%@ 
	attribute name="mask"%><%
	if(mask!=null&&date!=null){
		java.text.SimpleDateFormat _sdf=new java.text.SimpleDateFormat(mask);
		String formatDate=_sdf.format(date);	
		request.setAttribute("formatDate",formatDate);
	}
%>
<c:out value="${formatDate}"/>