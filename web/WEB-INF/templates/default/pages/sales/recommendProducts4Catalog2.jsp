<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:if test="${fn:length(productList)>0}">
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">

<li>
 <div class="right_item unmargin">
<div class="Item_images_s">
		<product:productImg product="${productItem}" size="c" category="${category}"/>
	
</div><!--Item_images_s-->
 <div class="Item_name_s">
 <p class="text_prod">
	    	<product:productName product="${productItem}" category="${category}" interceptLength="40"/>
	    	</p>
	    	<br/>
	    	<p class="price">
	        <product:showPrice productSku="${productItem.defaultProductSku}" viewType="4"/>
	        </p>
	        <br/>
	        <p class="text_designer">
	        <product:productStat var="productStat" productId="${productItem.id}"></product:productStat>
	        <%--<c:if test="${productStat.buyCount>0}"><strong>${productStat.buyCount}</strong></c:if>
	        --%></p>
	    </div><!--right_item-->
 </li>
</c:forEach>
</c:if>
