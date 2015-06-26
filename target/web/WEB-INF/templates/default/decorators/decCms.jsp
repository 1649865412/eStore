<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title><decorator:title /></title>
		<%@ include file="./include/meta.jspf"%>
		<c:if test="${!(content.id == 18 || content.id == 19 || content.id == 27)}">
		<link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />
		</c:if>
		<%@ include file="./include/styles.jspf"%>
		<%@ include file="./include/styles3.jspf"%>	
		<%@ include file="./include/javascripts.jspf"%>
		<decorator:head />
		<script type="text/javascript">
		function fnCheckSearchContent($frm)
		{
			if ($frm.cq.value == "")
			{
				alert("Please submit the keyword!");
				$frm.cq.focus();
				return false;
			}
			return true;
		}
		</script>	
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/> <decorator:getProperty property="body.onload" writeEntireProperty="true"/> <decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
				<%-- ========== 头部开始 ========= --%>
							<%@ include file="./include/header.jspf"%>
			<%-- ========== 头部结束 ========= --%>
		<%-- ========== 内容开始 ========= --%>
			<div class="lyt-maincontent">
				<c:if test="${!(content.id == 18 || content.id == 19 || content.id == 27)}">
				<%-- ========== 内容详细页面左侧菜单开始 ========= --%>
				<div class="maincontent">
         		<%--<content tag="heading">
					<c:forEach items="${category.navigatorCategorys}" var="categoryItem">
						${categoryItem.categoryName} >
					</c:forEach>
					${content.contentTitle}
				</content>--%>
		         <div class="position-wrap">
		            <a href="http://www.sifangstreet.com/">首页</a>&nbsp;&gt;&nbsp;
		            <span class="selected">帮助中心</span>
		         </div>
		         
		         <div class="bottom_about">
		           <div class="remote_nav">
		            <ul id="remote_nav_ul">
		            	<content:showContents var="cat_content_list" categoryCode="site-help"></content:showContents>
		            	<c:forEach items="${cat_content_list}" var="cat_content" end="15">
							<content:contentUrl content='${cat_content}' var="contUrl"/>
							<li<c:if test="${fn:endsWith(OriginalRequestURL,contUrl)}"> class="selected current"</c:if>>
								<a href="${contUrl}" title="<c:out value="${cat_content.contentTitle}"/>">${cat_content.contentTitle}</a>
							</li>
						</c:forEach>
		            </ul>
		           </div><!--remote_nav-->
		           
			           <c:choose>
							<c:when test="${empty content}">
								Sorry, the page you're looking for cannot be found.
								<br /><br />
								Have questions? Comments? Contact our <a href="${ctxPath}/contactus.html">customer service </a>department about your experience at ${appConfig.store.name} and we will respond to you within 24 hours. 
							</c:when>
							<c:otherwise>
								 <!-- ========== 内容详细页面右侧开始 ========= --> 
								<div class="down_right" >
									<h1>
										${content.contentTitle}
									</h1>
									<br/>
									${content.contentBody}
								</div>
								<div class="blank10"></div>
								<div align="right">
									<c:if test="${category.category.categoryCode=='knowledge-base'}">
									<a href="${category.url}" title="<c:out value="${category.categoryName}"/>"><< Back</a>
									</c:if>
								</div>
								 <!-- ========== 内容详细页面右侧结束 =========  -->
							</c:otherwise>
						</c:choose>
		         </div><!--bottom_about-->
		           <hr>
		      </div><!--end of maincontent-->
				
				</c:if>
				<%-- ========== 内容详细页面左侧菜单结束 ========= --%>
				<%-- ========== 内容详细页面右侧开始 ========= --%>
				<c:if test="${content.id == 18 || content.id == 19 || content.id == 27}">
					<decorator:body></decorator:body>
				</c:if>
				<%-- ========== 内容详细页面右侧结束 ========= --%>
			</div>
			<%-- ========== 内容结束 ========= --%>
            <div class="blank10"></div>
			<%-- ========== 底部开始 ========= --%>
			<%@ include file="./include/footer.jspf"%>
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>