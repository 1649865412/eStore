<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>

		<c:forEach items="${productList}" var="productItem" varStatus="varStatus" >
		<div class="collocation-item addpro">
             <a href="${ctxPath}/product/${product.productId}.html">
		         <img src="${mediaPath}product/v/${product.defaultProductSku.image}" />
		         <img class="imgt" src="${mediaPath}other/${product.brand.icon}" />
	         </a>
             <div class="bd-list-tit"><span class="hot">HOT</span><a href="${ctxPath}/product/${product.productId}.html">${product.productName}</a></div>
             <p><span>${product.brand.designer}</span></p>
             <p><em>${product.brand.brandName}</em></p>
             <p>
              <product:showPriceRecommend productSku="${product.defaultProductSku}" viewType="4"/>
        </div>
		</c:forEach>
