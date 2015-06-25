<%@	tag import="com.cartmatic.estore.common.model.catalog.CategoryTreeItem"%><%@
	tag import="com.cartmatic.estore.common.model.catalog.Category"%><%@ 
	tag import="com.cartmatic.estore.catalog.service.CategoryManager"%><%@ 
	tag import="com.cartmatic.estore.core.util.ContextUtil"%><%@ 
	tag import="com.cartmatic.estore.content.model.ColumnComponent"%><%@ 
	tag import="java.util.List"%><%@ 
	tag import="java.util.ArrayList"%><%@ 
	tag import="com.cartmatic.estore.content.model.ColumnRepository"%><%@ 
	tag body-content="scriptless" pageEncoding="utf-8"%><%@ 
	tag import="com.cartmatic.estore.common.helper.CatalogHelper"%><%@
	tag import="com.cartmatic.estore.common.model.catalog.CategoryMenu"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@ 
	attribute name="categoryCode" type="java.lang.String" required="true" description="要显示目录的父目录的Code;注意尽量使用指定Id"%><%@ 
	attribute name="categoryType" type="java.lang.Short" required="true" description="目录类型，1为产品目录，2为内容目录。默认为1"%><%@ 
	attribute name="var" type="java.lang.String" required="true" description="变量不能为category"%><%
	Category category=null;
	try{
		CatalogHelper catalogHelper=CatalogHelper.getInstance();
		category=catalogHelper.getCategoryByCode4Front(categoryType,categoryCode);
		if(category!=null){
			CategoryTreeItem categoryTreeItem=(CategoryTreeItem)category;
			String url=((CategoryTreeItem)category).getUrl();
			categoryTreeItem.setUrl(url); 
		}
		request.setAttribute(var,category);
	}catch(Exception e){ 
		throw e;
	}
	if(category!=null){
 %> 
<jsp:doBody />
<%}%>