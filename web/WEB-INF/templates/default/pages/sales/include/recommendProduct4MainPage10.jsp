<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<div class="product_box">
<ul class="product list-unstyled col4 c sku_list" id="pinterestList">
<c:forEach items="${productList}" var="product" varStatus="varStatus" begin="0" end ="100">
		<li>
                    <div class="li1" onmouseover="setShare('${product.productName}', 'product/${product.productId}.html');">
	                    <a href="${ctxPath}/product/${product.productId}.html">
			            	<img class="imgo" src="${mediaPath}product/v/${product.defaultProductSku.image}" width="100%"/>
			            	<%--<img class="imgt" src="${mediaPath}/productMedia/hd/${product.productHandDraw.mediaUrl}" width="100%"/>
		            	--%></a>
	            	</div>
                    <div class="li2">
	                    <div class="cutstr2">
	                    	<a href="${ctxPath}/product/${product.productId}.html">${product.productName}</a>
	                    </div>
                    	<span>&nbsp;</span>
                    </div>
                    <p class="li3">${product.brand.designer}</p>
                	<p class="li4">${product.brand.brandName}</p>
                    <div class="li5"><product:showPrice productSku="${product.defaultProductSku}" viewType="4"/></div>
                    <div id="skuOptions" class="join_box">
                    <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
					           	<product:productQuantity2 product="${product}" />
					             <form id="myform" method="POST" action="#">
					             <div class="spinner">
					               <a href="#" id="min"><i class="fa fa-minus"></i></a>
					               <input type="hidden" id="quantity" name="quantity" type="text"  value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
					               <a href="#" id="add"><i class="fa fa-plus"></i></a>
					               </div>
					             </form>
                    <c:forEach items="${productMap}" var="productMapItem">
                    	<c:if test="${productMapItem.key == product.productId}">
		                 <c:forEach items="${productMapItem.value}" var="productSkuOptionAndValue">
		                 	<div class="tb-prop tm-clear">
									<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'color') > -1}">
										<div class="product_color">
											<ul class="tm-clear J_TSaleProp tb-img" data-property="${productSkuOptionAndValue.key.skuOptionName}">
												<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
													<li class="tb-selected"  data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}" style="display:none">
															<a  id="color_${skuOptionValue.skuOptionValue }" class="imageSku"  href="#">
																<span>${skuOptionValue.skuOptionValueName}</span>
																<!--  background: url(<product:productImg sku="${skuOptionValue.sku}" size="a" isUrlOnly="true"/>) center no-repeat; -->
															</a>
															<i>selected</i>
													</li>
						                        </c:forEach>
											</ul>
										</div>
									</c:if>
		                                  
									<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'size') > -1}">
										<div class="j1">尺码</div>
										<ul class="size" data-property="${productSkuOptionAndValue.key.skuOptionName}">
			                                 <p>
			                                 	<div class="j2">
													<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
							                        	<span data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}">${skuOptionValue.skuOptionValueName}</span>
							                        </c:forEach>
						                        </div>
						                     </p>
										</ul>
									</c:if>
							</div>
		                 </c:forEach>
		               </c:if>
		            </c:forEach>
		            <span class="cart_close">
						关闭
					</span>
		            <product:addToCartSmall  productSkuCode="${product.defaultProductSku.productSkuCode}"  productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
                    </div>
                    <p class="li6">
                        <!-- JiaThis Button BEGIN -->
                                        
                                        <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
                                       
                                        <!-- JiaThis Button END -->
                    <a href="#"><i class="fa fa-heart-o"></i> 加入收藏</a>
                                        <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
                </p>
         </li>
</c:forEach>
</ul>
</div><!--product_box-->
<div class="w-shopping-list-box" style="text-align:center;">
		          	<div class="w-page" style="width:100px;margin:0 auto;">
	                	<c:if test="${pageNum - 1 != 0}">
	                		<a href="/weekly.html?page=${pageNum - 1 }"><i class="fa fa-long-arrow-left"></i></a>
	                    </c:if>
	                    <a href="javascript:;">${pageNum }</a>
	                    <c:if test="${pageNum + 1 <= totalPage}">
	                    	<a href="/weekly.html?page=${pageNum + 1 }">${pageNum + 1 }</a>
	                    </c:if>
	                    <c:if test="${pageNum + 2 <= totalPage}">
	                    	<a href="/weekly.html?page=${pageNum + 2 }">${pageNum + 2 }</a>
	                    </c:if>
	                    <c:if test="${totalPage >4 && pageNum + 3 < totalPage}">
	                    	·······
	                    </c:if>
	                    <c:if test="${pageNum + 3 <= totalPage}">
				            <a href="/weekly.html?page=${totalPage}">${totalPage }</a>
			            </c:if>
	                    <c:if test="${pageNum + 1 <= totalPage}">
	                    	<a href="/weekly.html?page=${pageNum + 1 }"><i class="fa fa-long-arrow-right"></i></a>
	                    </c:if>
	                </div>
                </div>
                <!--/分页-->