
<%@tag import="com.cartmatic.estore.common.model.attribute.BaseAttributeValue"%>
<%@tag import="java.util.Set"%>
<%@tag import="com.cartmatic.estore.common.model.attribute.Attribute"%>
<%@tag import="org.apache.commons.lang.StringUtils"%>
<%@tag import="com.cartmatic.estore.attribute.service.AttributeManager"%>
<%@tag import="com.cartmatic.estore.catalog.service.ProductManager"%>
<%@tag import="com.cartmatic.estore.common.model.catalog.Product"%>
<%@tag import="com.cartmatic.estore.catalog.service.CategoryManager"%>
<%@tag import="com.cartmatic.estore.common.model.catalog.Category"%>
<%@tag import="com.cartmatic.estore.content.service.ContentManager"%>
<%@tag import="com.cartmatic.estore.common.model.content.Content"%>
<%@tag import="com.cartmatic.estore.common.model.customer.Customer"%>
<%@tag import="com.cartmatic.estore.core.util.ContextUtil"%>
<%@tag import="com.cartmatic.estore.customer.service.CustomerManager"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ attribute name="attributeCode"  required="true"  type="java.lang.String"%>
<%@ attribute name="attributeValueVar"  required="true"  type="java.lang.String"%>
<%@ attribute name="entity" required="true" description="one entity of Product、Customer、Content、Category、Salesorder" type="java.lang.Object" %>
<%
AttributeManager attributeManager=(AttributeManager)ContextUtil.getSpringBeanById("attributeManager");
Attribute attribute=null;
if(StringUtils.isNotBlank(attributeCode)){
	attribute=attributeManager.getAttribute(attributeCode);
}
BaseAttributeValue baseAttributeValue=null;
if(attribute!=null&&entity != null){
	Set attributeValues=null;
   if(entity instanceof Customer){
       Customer value = (Customer) entity;
       CustomerManager customerManager=(CustomerManager)ContextUtil.getSpringBeanById("customerManager");
       value=customerManager.getById(value.getAppuserId());
       attributeValues=value.getCustomerAttrValues();
   }
   else if(entity instanceof Content){
       Content value = (Content) entity;
       ContentManager contentManager=(ContentManager)ContextUtil.getSpringBeanById("contentManager");
       value=contentManager.getById(value.getContentId());
       attributeValues=value.getContentAttrValues();
   }
   else if(entity instanceof Category){
       Category value = (Category) entity;
       CategoryManager categoryManager=(CategoryManager)ContextUtil.getSpringBeanById("categoryManager");
       value=categoryManager.getById(value.getCategoryId());
       attributeValues=value.getCategoryAttrValues();
   }
   else if(entity instanceof Product){
       Product value = (Product) entity;
       ProductManager productManager=(ProductManager)ContextUtil.getSpringBeanById("productManager");
       value=productManager.getById(value.getProductId());
       attributeValues=value.getProductAttrValues();
   }
   if(attributeValues!=null){
   		for(Object obj_attributeValue:attributeValues){
   			BaseAttributeValue attributeValue=(BaseAttributeValue)obj_attributeValue;
   			if(attributeValue.getAttribute().getAttributeCode().equals(attributeCode)){
   				baseAttributeValue=attributeValue;
   				break;
   			}
		}
   }
}
request.setAttribute(attributeValueVar,baseAttributeValue);
%>