<%@tag import="com.cartmatic.estore.common.model.content.Content,
	java.util.List,
	com.cartmatic.estore.common.model.catalog.Category,
	com.cartmatic.estore.Constants,
	com.cartmatic.estore.common.helper.CatalogHelper,
	com.cartmatic.estore.content.service.ContentManager,
	com.cartmatic.estore.core.util.ContextUtil"%><%@ 
	attribute name="categoryCode" required="true" type="java.lang.String"%><%@ 
	attribute name="var" required="true" type="java.lang.String"%><%@ 
	attribute name="firstResult" type="java.lang.Integer"%><%@ 
	attribute name="maxResult" type="java.lang.Integer"%><%
Category category=CatalogHelper.getInstance().getCategoryByCode4Front(Constants.CATEGORY_TYPE_CONTENT,categoryCode);
ContentManager contentManager=(ContentManager)ContextUtil.getSpringBeanById("contentManager");
List<Content> contentList=null;
if(category!=null){
	if(firstResult==null)firstResult=0;
	if(maxResult==null)maxResult=10;
	contentList=contentManager.searchContentByCategory(category, firstResult, maxResult);
	request.setAttribute(var,contentList);
}
%>