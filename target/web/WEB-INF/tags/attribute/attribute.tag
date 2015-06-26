<%@ tag import="com.cartmatic.estore.common.service.AttributeService"%><%@
	tag import="com.cartmatic.estore.core.util.ContextUtil"%><%@
	tag import="com.cartmatic.estore.common.model.attribute.Attribute"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
	attribute name="attributeCode" required="true"  type="java.lang.String"%><%@ 
	attribute name="var" required="true"  type="java.lang.String"%><%
AttributeService attributeService=(AttributeService)ContextUtil.getInstance().getSpringBeanById("attributeService");
Attribute attribute=attributeService.getAttribute(attributeCode);
request.setAttribute(var,attribute);
%>