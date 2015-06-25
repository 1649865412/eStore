<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
		javax.servlet.ServletContext servletContext = session.getServletContext();
		org.springframework.context.ApplicationContext ctx = org.springframework.web.context.support.WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		com.cartmatic.estore.system.service.MetricUnitManager metricUnitMgr=(com.cartmatic.estore.system.service.MetricUnitManager)ctx.getBean("metricUnitManager");
		try{
		String weightUnitName=metricUnitMgr.getDefaultWeightUnitName();
		request.setAttribute("weightUnitName",weightUnitName);
		}catch(Exception ex){} 
%>
${weightUnitName}