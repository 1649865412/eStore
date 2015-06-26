<%@tag import="com.cartmatic.estore.catalog.util.HtmlConverter"%><%@ attribute name="content" required="true" type="java.lang.String"%><%
	String newContent=HtmlConverter.converProductDescription(content);
	out.print(newContent);
%>