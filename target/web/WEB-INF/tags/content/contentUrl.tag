<%@ tag import="com.cartmatic.estore.common.helper.CatalogHelper,java.util.List"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
	attribute name="content" required="true" type="com.cartmatic.estore.common.model.content.Content"%><%@ 
   attribute name="var"  type="java.lang.String" description="输入保存变量"%><%
String url=CatalogHelper.getInstance().getContentUrl(content);
if(var!=null){
	request.setAttribute(var,application.getAttribute("ctxPath")+url);
}else{
	out.print(application.getAttribute("ctxPath")+url);
}
%>