<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<c:forEach items="${productList}" var="product" varStatus="varStatus" begin="0" end ="0">
	        	<li>
	            	<img src="${mediaPath}product/v/${product.defaultProductSku.image}" />
	                <div class="mall_right_title">
	                    <i></i>
	                    <a class="mall_right_title_box" href="${ctxPath}/product/${product.productId}.html">
	                        <div class="li2"><cartmatic:img isUrlOnly="false" url="${product.brand.logo}" mediaType="other"  ></cartmatic:img></div>
	                        <div class="li3">${product.brand.designer}</div>
	                        <div class="li4">${product.productName}</div>
	                    </a>
	                </div>
	            </li>
</c:forEach>
<c:forEach items="${productList}" var="product" varStatus="varStatus" begin="1" end ="1">
	        	<li>
	            	<img src="${mediaPath}product/v/${product.defaultProductSku.image}" class="height_a"/>
	                <div class="mall_right_title">
	                    <i></i>
	                    <a class="mall_right_title_box" href="${ctxPath}/product/${product.productId}.html">
	                        <div class="li2"><cartmatic:img isUrlOnly="false" url="${product.brand.logo}" mediaType="other"  ></cartmatic:img></div>
	                        <div class="li3">${product.brand.designer}</div>
	                        <div class="li4">${product.productName}</div>
	                    </a>
	                </div>
	            </li>
</c:forEach>
<c:forEach items="${productList}" var="product" varStatus="varStatus" begin="2" end ="2">
	        	<li>
	            	<img src="${mediaPath}product/v/${product.defaultProductSku.image}" class="height_b"/>
	                <div class="mall_right_title">
	                    <i></i>
	                    <a class="mall_right_title_box" href="${ctxPath}/product/${product.productId}.html">
	                        <div class="li2"><cartmatic:img isUrlOnly="false" url="${product.brand.logo}" mediaType="other"  ></cartmatic:img></div>
	                        <div class="li3">${product.brand.designer}</div>
	                        <div class="li4">${product.productName}</div>
	                    </a>
	                </div>
	            </li>
</c:forEach>
<c:forEach items="${productList}" var="product" varStatus="varStatus" begin="3" end ="3">
	        	<li>
	            	<img src="${mediaPath}product/v/${product.defaultProductSku.image}" />
	                <div class="mall_right_title">
	                    <i></i>
	                    <a class="mall_right_title_box" href="${ctxPath}/product/${product.productId}.html">
	                        <div class="li2"><cartmatic:img isUrlOnly="false" url="${product.brand.logo}" mediaType="other"  ></cartmatic:img></div>
	                        <div class="li3">${product.brand.designer}</div>
	                        <div class="li4">${product.productName}</div>
	                    </a>
	                </div>
	            </li>
</c:forEach>
