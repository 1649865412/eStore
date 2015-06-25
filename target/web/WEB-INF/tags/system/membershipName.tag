<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ attribute name="membershipId" %>
<%
		javax.servlet.ServletContext servletContext = session.getServletContext();
		org.springframework.context.ApplicationContext ctx = org.springframework.web.context.support.WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);		com.cartmatic.estore.customer.service.MembershipManager membershipMgr=(com.cartmatic.estore.customer.service.MembershipManager)ctx.getBean("membershipManager");
		try{
			com.cartmatic.estore.common.model.customer.Membership membershipModel=null;
			if(membershipId==null){
				membershipModel=membershipMgr.getAnonymousMembership();
			}else{
				membershipModel=membershipMgr.getMembership(new Integer(membershipId));				
			}
			request.setAttribute("membership",membershipModel);
		}catch(Exception ex){}
%>
${membership.membershipName}