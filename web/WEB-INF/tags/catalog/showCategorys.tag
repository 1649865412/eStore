<%@tag import="com.cartmatic.estore.Constants"%>
<%@	tag import="org.apache.commons.lang.ArrayUtils"%><%@
	tag import="org.apache.commons.lang.StringUtils"%><%@ 
	tag import="com.cartmatic.estore.catalog.service.CategoryManager"%><%@ 
	tag import="com.cartmatic.estore.core.util.ContextUtil"%><%@ 
	tag import="com.cartmatic.estore.content.model.ColumnComponent"%><%@ 
	tag import="java.util.List"%><%@ 
	tag import="java.util.ArrayList"%><%@ 
	tag import="com.cartmatic.estore.content.model.ColumnRepository"%><%@ 
	tag body-content="scriptless" pageEncoding="utf-8"%><%@ 
	tag import="com.cartmatic.estore.common.helper.CatalogHelper"%><%@ 
	tag import="com.cartmatic.estore.common.model.catalog.CategoryTreeItem"%><%@
	tag import="com.cartmatic.estore.common.model.catalog.CategoryMenu"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@ 
	attribute name="displayCategory"  type="com.cartmatic.estore.common.model.catalog.CategoryTreeItem" description="要显示目录的父目录"%><%@ 
	attribute name="displayCategoryId"  type="java.lang.Integer" description="要显示目录的父目录Id，"%><%@ 
	attribute name="displayCategoryCode" type="java.lang.String" description="要显示目录的父目录的Code;注意尽量使用指定Id"%><%@ 
	attribute name="displayLevel" type="java.lang.Integer" description="显示目录的级数（深度）,从1开始;-1代表显示该父目录的所有子目录"%><%@ 
	attribute name="categoryType" type="java.lang.Short" description="目录类型，1为产品目录，2为内容目录。默认为1"%><%@ 
	attribute name="var" type="java.lang.String" description="指定变量前缀"%><%@ 
	attribute name="excludeCode" type="java.lang.String" description="过滤掉的编码，多个的用,分隔"%><%
	try{
		CatalogHelper catalogHelper=CatalogHelper.getInstance();
		Integer level=displayLevel==null?-1:displayLevel; 
		categoryType=categoryType==null?Constants.CATEGORY_TYPE_CATALOG:categoryType; 
		List<CategoryTreeItem>categoryTreeItems=null;
		CategoryMenu categoryMenu=null;
		if(displayCategory!=null){
		}else if(displayCategoryCode!=null){
			displayCategory=(CategoryTreeItem)catalogHelper.getCategoryByCode4Front(categoryType,displayCategoryCode);
			//categoryMenu=CatalogHelper.getInstance().getCategoryByLevel(displayCategoryCode,level,categoryType,isDisplaySameLevel,isIncludeRoot);
		}else if(displayCategoryId!=null){
			displayCategory=(CategoryTreeItem)catalogHelper.getCategoryById4Front(categoryType,displayCategoryId);
			//categoryMenu=CatalogHelper.getInstance().getCategoryByLevel(displayCategoryId,level,categoryType,isDisplaySameLevel,isIncludeRoot);
		}
		if(displayCategory!=null){
			categoryMenu=CatalogHelper.getInstance().getCategoryByLevel(displayCategory,level,excludeCode);
			categoryTreeItems=categoryMenu.getCategoryTreeList();
		}
		
		
		var=var==null?"":(var+"_");
		request.setAttribute(var+"categoryTreeItems",categoryTreeItems);
		if(categoryMenu!=null){
			request.setAttribute(var+"displayLevel",categoryMenu.getDisplayLevel());
		}
	}catch(Exception e){
		throw e;
	}
 %> 
<jsp:doBody />