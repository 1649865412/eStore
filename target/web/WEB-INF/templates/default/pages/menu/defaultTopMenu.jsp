<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<ul>
<product:showCategorys displayLevel="1" categoryType="2" displayCategoryCode="top-links" >
	<c:forEach var="categoryTreeItem" items="${categoryTreeItems}" end="9">
		<product:showCategoryItem var="rootCat" categoryType="1" categoryCode="${categoryTreeItem.code}"></product:showCategoryItem>
	    <li class="${fn:endsWith(OriginalRequestURL,categoryTreeItem.url)?'selected ':''}${(not empty rootCat.categorys)?'top-mama':''}"><a href="${categoryTreeItem.url}" >${categoryTreeItem.name}</a>
	    <c:if test="${not empty rootCat.categorys}">
	    	<ul>
	            <c:forEach items="${rootCat.categorys}" var="catItem">
		            <li><a href="${catItem.url}" title="<c:out value="${catItem.name}"/>">${catItem.name}</a></li>
	    		</c:forEach>
                <li style="height:10px; width:188px;"></li>
	        </ul>
	    </c:if>
        </li>
	    
	</c:forEach>
</product:showCategorys>
</ul>