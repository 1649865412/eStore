<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.cartmatic.estore.webapp.util.RequestContext"%>
<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="customer" tagdir="/WEB-INF/tags/customer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>		
		<title>${appConfig.store.title} | <fmt:message key="user.myaccount"/> > <decorator:title /></title>
		<meta http-equiv="Cache-Control" content="no-store" />
		<meta http-equiv="Pragma" content="no-cache" />
		<%@ include file="./include/meta.jspf"%>
		<meta name="keywords" content="${appConfig.store.keyWords},<decorator:getProperty property='meta.keywords'/>" />
		
		<%--<link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />
		
		--%><link href="${resPath }/styles/main.css" rel="stylesheet" type="text/css"/>
      <link href="${resPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
      
		<%@ include file="./include/styles.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<link href="${ctxPath}/scripts/jquery/plugins/quicktip/quicktip.css" rel="stylesheet" type="text/css" />
		<%@ include file="./include/javascripts.jspf"%>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/validation.js"></script>
        <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/account.js"></script>		
        
        
        <link href="${resPath }/styles/help.css" rel="stylesheet" type="text/css" />
      <link href="${resPath }/styles/myaccount.css" rel="stylesheet" type="text/css" />

      <!--placeholder for IE 8-->
	  <script type="text/javascript">   
		var _placeholderSupport = function() {
			var t = document.createElement("input");
			t.type = "text";
			return (typeof t.placeholder !== "undefined");
		}();
		
		window.onload = function() {
			var arrInputs = document.getElementsByTagName("input");
			for (var i = 0; i < arrInputs.length; i++) {
				var curInput = arrInputs[i];
				if (!curInput.type || curInput.type == "" || curInput.type == "text")
					HandlePlaceholder(curInput);
			}
		};
		 
		function HandlePlaceholder(oTextbox) {
			if (!_placeholderSupport) {
				var curPlaceholder = oTextbox.getAttribute("placeholder");
				if (curPlaceholder && curPlaceholder.length > 0) {
					oTextbox.value = curPlaceholder;
					oTextbox.setAttribute("old_color", oTextbox.style.color);
					oTextbox.style.color = "#c0c0c0";
					oTextbox.onfocus = function() {
						this.style.color = this.getAttribute("old_color");
						if (this.value === curPlaceholder)
							this.value = "";
					};
					oTextbox.onblur = function() {
						if (this.value === "") {
							this.style.color = "#c0c0c0";
							this.value = curPlaceholder;
						}
					}
				}
			}
		}
      </script>     
        
        
		<decorator:head />
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
				<%@ include file="./include/header.jspf"%>
				
				<decorator:body />
                
            <div class="blank10"></div>
				<%@ include file="./include/footer.jspf"%>
		<script type="text/javascript">
		// show the message count.
		<%--$.post(__ctxPath+"/myaccount/orderMessage/list.html?doAction=getCountMsgs",function(result){
			if(result.status==-500){
				alert("系统错误了!");
			}else{
				var count=result.data;
				if (count > 0)
					$("#message_count").append("("+count+")");
				else
					$("#message_count").append("(0)");
			}
		},"json");--%>
		// show the 
		$.post(__ctxPath+"/myaccount/review/reviewCount.html",function(result){
			if(result.status==-500){
				alert("系统错误了!");
			}else{
				var count=result.data;
				if (count > 0)
					$("#reviews_count").append("("+count+")");
				else
					$("#reviews_count").append("(0)");
			}
		},"json");
		</script>
	</body>
</html>
