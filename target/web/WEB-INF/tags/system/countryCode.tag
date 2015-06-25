<%@tag import="com.cartmatic.estore.common.model.system.Region,com.cartmatic.estore.system.service.RegionManager,com.cartmatic.estore.core.util.ContextUtil"%><%@ 
	attribute name="countryName" required="true"%><%
		javax.servlet.ServletContext servletContext = session.getServletContext();
		RegionManager mgr = (RegionManager) ContextUtil.getSpringBeanById("regionManager");
		try{
			Region region = mgr.getCountryByName(countryName);
			if (region != null)
				out.print(region.getRegionCode());
		}catch(Exception ex){}
%>