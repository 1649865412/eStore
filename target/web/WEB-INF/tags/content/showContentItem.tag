<%@tag import="com.cartmatic.estore.common.helper.ConfigUtil"%>
<%@tag import="com.cartmatic.estore.common.model.content.Content,java.util.List,com.cartmatic.estore.common.model.catalog.Category,com.cartmatic.estore.Constants,com.cartmatic.estore.common.helper.CatalogHelper,com.cartmatic.estore.content.service.ContentManager,com.cartmatic.estore.core.util.ContextUtil"%><%@ 
	attribute name="contentCode" required="true" type="java.lang.String"%><%@ 
	attribute name="var" required="true" type="java.lang.String"%>
<%
	ContentManager contentManager = (ContentManager) ContextUtil.getSpringBeanById("contentManager");
	Content content=contentManager.getContentByCode(ConfigUtil.getInstance().getStore().getStoreId(),contentCode);
	if(content!=null){
		content.setUrl(CatalogHelper.getInstance().getContentUrl(content));
	}
	request.setAttribute(var,content);
if(content!=null){  
 %>
<jsp:doBody />
<%}%>