<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>

		<c:forEach items="${productList}" var="productItem" varStatus="varStatus" begin="0" end="3">
			<div class="p_img">
				<div class="Item_images_s">
					<product:productImg product="${productItem}" size="v" width="165" height="165" category="${category}"/>
				</div>
				<div class="Item_name_s">
				<p class="text_prod">
		            <product:productName product="${productItem}" category="${category}" interceptLength="40"/>
		         </p>
		         <br/>
		         <p class="text_designer">${product.brand.brandName }</p>
		         <br/>
		            <product:showPrice productSku="${productItem.defaultProductSku}" viewType="4"/>
		        </div>
			</div>
		</c:forEach>
