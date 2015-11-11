<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>

		<c:forEach items="${productList}" var="product" varStatus="varStatus" begin="0" end="3">
			<div class="collocation-item" id="recProduct">
                                        <a href="${ctxPath}/product/${product.productId}.html"><img class="imgo" src="${mediaPath}product/v/${product.defaultProductSku.image}"/>
	            	
						            	<%--<img class="imgt" src="${mediaPath}/productMedia/hd/${product.productHandDraw.mediaUrl}" width="100%"/>
						            	
						            	--%></a>
                                        <div class="bd-list-tit"><a href="${ctxPath}/product/${product.productId}.html">${product.productName}</a></div>
                                        <p><span>${product.brand.designer}</span></p>
                                        <p><em>${product.brand.brandName}</em></p>
                                        <p>
                                        <b><product:showPrice productSku="${product.defaultProductSku}" viewType="4"/></b>
                                          <div class="join_box">
                                              <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
									           	<product:productQuantity2 product="${product}" />
									             <%--<form id="myform" method="POST" action="#">
									             <div class="spinner">
									               <a href="#" id="min"><i class="fa fa-minus"></i></a>
									               <input type="hidden" id="quantity" name="quantity" type="text"  value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
									               <a href="#" id="add"><i class="fa fa-plus"></i></a>
									               </div>
									             </form>
				                    --%><c:forEach items="${productMap}" var="productMapItem">
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
														<ul class="size3" data-property="${productSkuOptionAndValue.key.skuOptionName}">
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
						            <product:addToCartSmall  productSkuCode="${product.defaultProductSku.productSkuCode}"  productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCartSmall" />
                                          </div>
                                        </p>
                                        
                                        <p class="li6">
                                        <!-- JiaThis Button BEGIN -->
                                        
                                        <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
                                       
                                        <!-- JiaThis Button END -->
                                        <a href="javascript:" onClick="addToFavorite(${product.productId})"><i class="fa fa-heart-o"></i> 加入收藏</a>
                                        <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a></p>
                                         
                                    </div>
		
		</c:forEach>
