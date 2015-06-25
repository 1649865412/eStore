<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:if test="${fn:length(productList)>0}">
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">
	<div class="product-list-v">
		<product:productImg product="${productItem}" size="e" width="165" height="165" category="${category}"/>		
    	<div><product:productName product="${productItem}" category="${category}" interceptLength="40"/>
    	<br/><product:showPrice productSku="${productItem.defaultProductSku}" viewType="4"/></div>
	</div>
	<c:if test="${varStatus.index==4}"><div class="blank10"></div></c:if>
</c:forEach>
</c:if>
