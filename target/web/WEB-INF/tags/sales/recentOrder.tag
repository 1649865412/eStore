<%@ tag import="com.cartmatic.estore.order.service.OrderPickListManager"%><%@
	tag import="com.cartmatic.estore.core.util.ContextUtil"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
	attribute name="var" required="true" type="java.lang.String"%><%@ 
	attribute name="maxResult" type="java.lang.Integer"%>
<%
{
    OrderPickListManager orderPickListManager=(OrderPickListManager)ContextUtil.getSpringBeanById("orderPickListManager");
	if(maxResult == null){
	    maxResult = 20;
	}
	request.setAttribute(var,orderPickListManager.getRecentShipments(maxResult));
}
%>