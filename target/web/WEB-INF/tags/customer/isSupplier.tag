
<%@tag import="com.cartmatic.estore.Constants"%><%@tag import="com.cartmatic.estore.common.model.customer.Customer"%>
<%@tag import="com.cartmatic.estore.webapp.util.RequestContext"%>
<%@tag import="com.cartmatic.estore.core.util.ContextUtil"%>
<%@tag import="com.cartmatic.estore.customer.service.CustomerManager"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%
CustomerManager customerManager=(CustomerManager)ContextUtil.getSpringBeanById("customerManager");
Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
if(customer.getSupplier()!=null&&customer.getSupplier().getStatus().intValue()==Constants.STATUS_ACTIVE){
%>
<jsp:doBody></jsp:doBody>
<%}%>