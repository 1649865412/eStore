<%@tag import="com.cartmatic.estore.catalog.service.SkuOptionManager"%>
<%@tag import="com.cartmatic.estore.common.model.catalog.SkuOption"%><%@
	tag import="com.cartmatic.estore.core.util.ContextUtil"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
	attribute name="skuOptionCode" required="true"  type="java.lang.String"%><%@ 
	attribute name="var" required="true"  type="java.lang.String"%><%
SkuOptionManager skuOptionManager=(SkuOptionManager)ContextUtil.getInstance().getSpringBeanById("skuOptionManager");
SkuOption skuOption=skuOptionManager.getSkuOptionByCode(skuOptionCode);
request.setAttribute(var,skuOption);
%>