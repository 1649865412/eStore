<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<c:forEach items="${productList}" var="product" varStatus="varStatus">
			<li><a href="${ctxPath}/product/${product.productId}.html"><img src="${mediaPath}product/v/${product.defaultProductSku.image}"></a>
                        	<div class="bd-list-tit"><span>SALE</span><a href="${ctxPath}/product/${product.productId}.html">${product.productName}</a></div>
                            <p><span>${product.brand.designer}</span></p>
                            <p><em>${product.brand.brandName}</em></p>
                            <p><b> <c:choose>
					<c:when test="${product.defaultProductSku.priceViewType==2}">
						<c:set var="defaultProductSkuPrice" value="${product.defaultProductSku.salePrice}"/>
					</c:when>
					<c:when test="${product.defaultProductSku.priceViewType==3}">
						<c:set var="defaultProductSkuPrice" value="${product.defaultProductSku.discountPrice}"/>
					</c:when>
					<c:otherwise>
						<c:set var="defaultProductSkuPrice" value="${product.defaultProductSku.price}"/>
					</c:otherwise>
				</c:choose>
                <c:choose>
					<c:when test="${product.defaultProductSku.priceViewType==2||product.defaultProductSku.priceViewType==3}">
							<span id="salesPriceSpan" class="price"><system:CurrencyForRate value="${defaultProductSkuPrice}" /></span>
							<span id="priceSpan" class="ourPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></span>
					</c:when>
					<c:otherwise>
							<span id="priceSpan" class="price"><system:CurrencyForRate value="${defaultProductSkuPrice}" /></span>
					</c:otherwise>
				</c:choose>
                
                	
	                	<c:forEach items="${productSkuOptionValuesAndproductIdMap}" var="productSkuOptionAndValues">
	                		<c:forEach items="${productSkuOptionAndValues.value}" var="productSkuOptionAndValue">
	                		<c:if test="${product.productId==productSkuOptionAndValues.key}">
	                		<div class="join_box">
			                	<div class="tb-prop tm-clear">
									<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'color') > -1}">
										<div class="product_color">
											图片 
											<ul class="tm-clear J_TSaleProp tb-img" data-property="${productSkuOptionAndValue.key.skuOptionName}">
												<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
													<li data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}" >
															<a  id="color_${skuOptionValue.skuOptionValue }" class="imageSku"  href="#">
																<span>${skuOptionValue.skuOptionValueName}</span>
																<!--  background: url(<product:productImg sku="${skuOptionValue.sku}" size="a" isUrlOnly="true"/>) center no-repeat; -->
															</a>
													</li>
						                        </c:forEach>
											</ul>
										</div>
									</c:if>
		                                  
									<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'size') > -1}">
										<div class="product_size">
											文本 
			                                 <ul class="size" data-property="${productSkuOptionAndValue.key.skuOptionName}">
												<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
													<li data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}" >
													<a href="#">
														<span>${skuOptionValue.skuOptionValueName}</span>
													</a>
													</li>
						                        </c:forEach>
											</ul>
										</div>
									</c:if>
								</div>
								<c:if test="${productSkuOptionAndValue==null}">
						           	<div class="product_color">
						               <span class="chose"><span id="color_black"></span></span>
						           </div><!--product_color-->
						           <div class="product_size">
							               <ul class="size">
							                   <li><a href="#" class="current">36</a></li>
							               </ul>
					         	  </div><!--product_size-->
					           	</c:if>
					           	</div>
					           	</c:if>
           					</c:forEach>
	                	</c:forEach></b></p>
                            <product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
                    <a class="j3" href="#">加入购物车</a>
                
                <p class="li6"><a href="#"><i class="i1"></i>分享</a><a href="#"><i class="i2"></i>加入收藏</a></p>
             </li>
</c:forEach>
