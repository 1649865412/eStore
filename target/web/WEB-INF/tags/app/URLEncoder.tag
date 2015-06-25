<%@tag import="java.net.URLEncoder"%>
<%@tag import="org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="value" type="java.lang.String" required="true" %>
<%@ attribute name="var" type="java.lang.String" %>
<%
if(StringUtils.isNotBlank(var)){
	if(StringUtils.isNotBlank(value)){
		value=value.trim();
		request.setAttribute(var,URLEncoder.encode(value,"UTF-8"));
	}else{
		request.setAttribute(var,"");
	}
}else{
	if(StringUtils.isNotBlank(value)){
		value=value.trim();
		out.print(URLEncoder.encode(value,"UTF-8"));
	}
}
%>