<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<div class="addcart_part">
								<c:if test="${fn:length(productList)!=0}">
                                    <span class="addcart_part_title">购买该产品的用户还买了</span>
                                </c:if>
                                    <span class="addcart_part_more"><%--<a href="javascript:;">更多>></a>--%></span>
                                </div><!--addcart_part-->
                                <div class="addcart_sku">
                                  <ul class="sku_row">
                                    <li class="sku_list">
		<c:forEach items="${productList}" var="product" varStatus="varStatus" >
		<div class="collocation-item addpro">
             <a href="${ctxPath}/product/${product.productId}.html">
		         <img src="${mediaPath}product/v/${product.defaultProductSku.image}" />
		         <img class="imgt" src="${mediaPath}other/${product.brand.icon}" />
	         </a>
             <div class="bd-list-tit"><%--<span class="hot">HOT</span>--%><a href="${ctxPath}/product/${product.productId}.html">${product.productName}</a></div>
             <p><span>${product.brand.designer}</span></p>
             <p><em>${product.brand.brandName}</em></p>
             <p>
              <product:showPriceRecommend productSku="${product.defaultProductSku}" viewType="4"/>
        </div>
		</c:forEach>
</li>
                                  </ul>
                                </div><!--addcart_sku-->
