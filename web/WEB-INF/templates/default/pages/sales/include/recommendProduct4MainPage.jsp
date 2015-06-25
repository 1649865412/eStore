<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">

 <div class="right_item">

		<div class="Item_images_s">
			<product:productImg product="${productItem}" size="c" category="${category}"/>
		</div><!--Item_images_s-->
		<div class="Item_name_s">
			<p class="text_prod">
			<product:productName product="${productItem}" category="${category}" interceptLength="10"/>
			</p> 
			<br/>
			<p class="text_designer">${productItem.brand.brandName}</p><br/>
			<p class="price"> <product:showPrice productSku="${productItem.defaultProductSku}" viewType="4"/></p>
			         
		</div><!--Item_name_s-->

</div><!--right_item-->

</c:forEach>