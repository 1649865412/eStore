<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
<head>
<title>Knowledge Base</title>
</head>
<body>
<content tag="heading"> <h1 class="selected">Knowledge Base</h1></content>
<h2>Welcome to ${appConfig.store.name} Knowledge Base!</h2>
<div>We have developed this help page to assist you with standard information you may need, It also includes all the frequently asked questions from our customers.You can browse by categories you are interested or you can search some information you want to know at knowledgebase by entering keywords in the search bar. If you can not get a satisfied answer here,  Our customer service representative will help you figure it out. </div>
<cms:showCategoryItem var="knowledgeBaseCat" categoryType="2" categoryCode="knowledge-base">
	<c:forEach items="${knowledgeBaseCat.categorys}" var="knowledgeBaseCatItem" varStatus="varStatus">
		<ol<c:if test="${varStatus.count%2==0}"> class="mar20"</c:if>>
			<h3>${knowledgeBaseCatItem.categoryName}</h3>
			<content:showContents var="cat_content_list" categoryCode="${knowledgeBaseCatItem.categoryCode}"></content:showContents>
			<c:forEach items="${cat_content_list}" var="cat_content" end="3">
				<li><a href="<content:contentUrl content='${cat_content}'/>" title="<c:out value="${cat_content.contentTitle}"/>">${cat_content.contentTitle}</a></li>
			</c:forEach>
			<div class="more"><a title="<c:out value="${knowledgeBaseCatItem.categoryName}"/>" href="${knowledgeBaseCatItem.url}">More >></a></div>
		</ol>
	</c:forEach>
</cms:showCategoryItem>
</body>
</html>