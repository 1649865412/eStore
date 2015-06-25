<%@tag import="com.cartmatic.estore.Constants"%>
<%@tag import="com.cartmatic.estore.common.model.catalog.Category"%><%@
   tag import="com.cartmatic.estore.common.model.catalog.CategoryTreeItem"%><%@
   tag import="com.cartmatic.estore.common.helper.CatalogHelper"%><%@ 
   taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
   taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
   taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
   attribute name="category" required="true" type="com.cartmatic.estore.common.model.catalog.Category"%><%@ 
   attribute name="var"  type="java.lang.String" description="输入保存变量"%><%
String url=null;
if(category instanceof CategoryTreeItem){
	url=((CategoryTreeItem)category).getUrl();
}else{
	if(category.getCategoryType().intValue()==Constants.CATEGORY_TYPE_CATALOG){
		url=CatalogHelper.getInstance().getProductCategoryUrl(category);
	}else{
		url=CatalogHelper.getInstance().getContentCategoryUri(category);
	}
}
if(var!=null){
	request.setAttribute(var,url);
}else{
	out.print(url);
}
%>