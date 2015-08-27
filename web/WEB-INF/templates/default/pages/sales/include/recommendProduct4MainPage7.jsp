<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">
	<li style="background-image:url(${mediaPath}product/v/${productItem.defaultProductSku.image})">
                	<div class="mall_right_title">
                    	<i></i>
                    	<a class="mall_right_title_box" href="${ctxPath}/product/${productItem.productId}.html">
                            <div class="li1">${productItem.productName}</div>
                            <c:choose>
					<c:when test="${productItem.defaultProductSku.priceViewType==2}">
						<c:set var="defaultProductSkuPrice" value="${productItem.defaultProductSku.salePrice}"/>
					</c:when>
					<c:when test="${productItem.defaultProductSku.priceViewType==3}">
						<c:set var="defaultProductSkuPrice" value="${productItem.defaultProductSku.discountPrice}"/>
					</c:when>
					<c:otherwise>
						<c:set var="defaultProductSkuPrice" value="${productItem.defaultProductSku.price}"/>
					</c:otherwise>
				</c:choose>
                <c:choose>
					<c:when test="${productItem.defaultProductSku.priceViewType==2||productItem.defaultProductSku.priceViewType==3}">
							<span id="salesPriceSpan" class="s1"><system:CurrencyForRate value="${defaultProductSkuPrice}" /></span>
							<span id="priceSpan" class="s2"><system:CurrencyForRate value="${productItem.defaultProductSku.price}" /></span>
					</c:when>
					<c:otherwise>
							<span id="priceSpan" class="s1"><system:CurrencyForRate value="${defaultProductSkuPrice}" /></span>
					</c:otherwise>
				</c:choose>
                        </a>
                    </div>
    </li>

</c:forEach>