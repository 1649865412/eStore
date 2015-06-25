<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:if test="${fn:length(productList)>0}">
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">
	<div class="topsale-item">
		<div class="left"><product:productImg product="${productItem}" size="c" width="80" height="80" category="${category}"/></div>
	    <div class="right">
	    	<product:productName product="${productItem}" category="${category}" interceptLength="40"/><br/>
	        <product:showPrice productSku="${productItem.defaultProductSku}" viewType="4"/><br/>
	        <product:productStat var="productStat" productId="${productItem.id}"></product:productStat>
	        <c:if test="${productStat.buyCount>0}">已经售出<strong>${productStat.buyCount}件</strong></c:if>
	    </div>
	</div>
</c:forEach>
</c:if>