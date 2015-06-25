<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<%@ include file="/common/taglibs.jsp" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE><fmt:message key="customer.login.title" /></TITLE>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
		<%--<link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />
		--%><link href="${resPath}/styles/head_foot.css" rel="stylesheet" type="text/css" />
		<link href="${resPath}/styles/nav.css" rel="stylesheet" type="text/css" />
		<link href="${resPath}/styles/main.css" rel="stylesheet" type="text/css">
	    <link href="${resPath}/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
	    <link href="${resPath}/styles/chart.css" rel="stylesheet" type="text/css" />
	    <link href="${resPath}/styles/login.css" rel="stylesheet" type="text/css" /><%--
	    
	    <style>
		.red {
			margin-bottom: 5px !important;
			font-size: 14px;
			color: #ef7d36;
			font-weight: bold;
			margin-left: 7px;
		}
		</style>
	    
	    --%><!--placeholder for IE 8-->
	    <script type="text/javascript">   
	      function checkPlaceHolderSupport()
			{
				var i = document.createElement('input');
				return 'placeholder' in i;
			}
			$(document).ready(function() {
				if(!checkPlaceHolderSupport()){
					$("input").each(
						function(){
							if($(this).val()=="" && $(this).attr("placeholder")!=""){
								$(this).val($(this).attr("placeholder"));
								$(this).focus(function(){
									if($(this).val()==$(this).attr("placeholder")) $(this).val("");
								});
								$(this).blur(function(){
									if($(this).val()=="") $(this).val($(this).attr("placeholder"));
								});
							}
					});
				}
			});
	    </script>
	    
	</HEAD>
	<body>
		<%@ include file="/common/messages.jsp"%>
		<%if(request.getAttribute("customer")==null)request.setAttribute("customer",new Customer()); %>
		<spring:bind path="customer.*">
			<c:if test="${not empty status.errorMessages}">
				<c:forEach var="error" items="${status.errorMessages}">
					<div class="error_box"><c:out value="${error}" escapeXml="false" /></div>
				</c:forEach>
			</c:if>
		</spring:bind>
		<c:if test="${param.error != null}">
			<div class="error_box"><fmt:message key="customer.login.fail" /></div>
		</c:if>
		<c:if test="${param.errorCode != null}">
			<div class="error_box"><fmt:message key="front.errorCode" /></div>
		</c:if>
        <div class="blank10"></div>
        
		<div class="maincontent">
	      	<div class="login_reg">
	      	<%@ include file="customer/include/loginInfo.jspf"%>
	      	<%@ include file="customer/include/registerInfo.jspf"%>
	      	</div>
      	</div>
		
	</body>
</HTML>
