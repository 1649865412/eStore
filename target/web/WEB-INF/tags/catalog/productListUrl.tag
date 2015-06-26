<%@tag import="org.apache.commons.lang.ArrayUtils"%>
<%@tag import="java.util.Arrays"%>
<%@tag import="java.util.Map"%>
<%@tag import="java.util.HashMap"%>
<%@tag import="com.cartmatic.estore.core.util.UrlUtil"%>
<%@tag import="java.net.URLEncoder"%>
<%@tag import="java.util.Set"%>
<%@tag import="org.apache.commons.lang.StringUtils"%>
<%@tag import="com.cartmatic.estore.common.model.catalog.Category"%><%@
   tag import="com.cartmatic.estore.common.model.catalog.CategoryTreeItem"%><%@
   tag import="com.cartmatic.estore.common.helper.CatalogHelper"%><%@ 
   taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
   taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
   taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
   attribute name="url" required="true" type="java.lang.String"%><%@ 
   attribute name="var" type="java.lang.String" description="输入保存变量"%><%@ 
   attribute name="param" type="java.lang.String" description=""%><%@ 
   attribute name="removeParam" type="java.lang.String" description=""%>
   <%@ attribute name="removeParamName" type="java.lang.String" description="与removeParamValue一起使用"%>
   <%@ attribute name="removeParamValue" type="java.lang.String" description="与removeParamName一起使用"%><%
try{
	Map<String,String[]> temp_params=new HashMap<String, String[]>();
	Map<String,String[]> p1=request.getParameterMap();
	temp_params.putAll(p1);
	if(param!=null&&StringUtils.isNotBlank(param)){
		Map<String,String[]> p2=UrlUtil.getParamsMap(param);
		temp_params.putAll(p2);
	}
	temp_params.remove("pageNo");
	if(removeParam!=null&&StringUtils.isNotBlank(removeParam)){
		String removePramaNames[]=removeParam.split(",,");
		for(String removePramaName:removePramaNames){
			if(StringUtils.isNotBlank(removePramaName)){
				temp_params.remove(removePramaName);
			}
		}
	}
	if(StringUtils.isNotBlank(removeParamName)&&removeParamValue!=null){
		String tempVals[]=temp_params.get(removeParamName);
		if(tempVals!=null){
			String tempValsNew[]=(String[])ArrayUtils.removeElement(tempVals,removeParamValue);
			if(tempValsNew.length==0){
				temp_params.remove(removeParamName);
			}else if(tempValsNew.length!=tempVals.length){
				temp_params.put(removeParamName,tempValsNew);
			}
		}
	}
	
	String queryParams=UrlUtil.mapToQuery(temp_params);
	if(StringUtils.isNotBlank(queryParams)){
		if(url.indexOf("?")==-1){
			url+="?"+queryParams;
		}else if(url.endsWith("&")){
			url+=queryParams;
		}else {
			url+="&"+queryParams;
		}
	}
	if(var!=null){
		request.setAttribute(var,url);
	}else{
		out.print(url);
	}
}catch(Exception e){
	e.printStackTrace();
}
%>