<%@ tag import="com.cartmatic.estore.common.model.catalog.Category,
	java.util.Stack,
	com.cartmatic.estore.catalog.service.CategoryManager,
	com.cartmatic.estore.Constants"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
	attribute name="columnId"%><%@ 
	attribute name="excludeSelf" type="java.lang.Boolean"%><%

	CategoryManager categoryManager= 
		(CategoryManager)org.springframework.web.context.support.WebApplicationContextUtils.getRequiredWebApplicationContext(
			request.getSession().getServletContext()).getBean("categoryManager");
			
	StringBuilder pathGuide = new StringBuilder();
    Category category=categoryManager.getById(new Integer(columnId));
    if(category!=null && category.getCategoryId().intValue()!=Constants.ROOT_CATEGORY.intValue()){
    	String contextPath=(String)application.getAttribute("ctxPath");
    	Category parentCategory = category.getCategory();
	    do{
	    	if(parentCategory!=null && parentCategory.getCategoryId().intValue()==Constants.ROOT_CATEGORY.intValue()){
	    		pathGuide.insert(0, category.getCategoryName());
	    		break;
	    	}else{
	       		pathGuide.insert(0,"><a href=\""+contextPath+"/content/contents.html=doActionshowContentByCode=columnCode"+category.getCategoryCode()+"=templateshowContents.html\">"+category.getCategoryName()+"</a>");
	       		category = parentCategory;
	       		parentCategory = parentCategory.getCategory();
	       }
	    }while(true);
    }
	out.print(pathGuide);

%>