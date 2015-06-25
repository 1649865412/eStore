<%@tag import="org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="str" type="java.lang.String" required="true" description="需截取的字符串"%>
<%
if(str!=null){
	if(str.contains("@")){
		str=str.substring(0,str.indexOf("@"));
		str+="...";
	}
	request.setAttribute("nameStr",str);
	%><c:out value="${nameStr}"/><%
}%>