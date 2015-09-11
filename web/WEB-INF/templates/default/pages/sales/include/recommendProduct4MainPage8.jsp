<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<c:forEach items="${productList}" var="product" varStatus="varStatus" begin="0" end ="8">
           <li>
           
            	<div class="li1" onmouseover="setShare('${product.productName}', 'product/${product.productId}.html');"><a href="${ctxPath}/product/${product.productId}.html">
            	
            	<img class="imgo" src="${mediaPath}product/v/${product.defaultProductSku.image}" width="100%"/>
            	
            	<img class="imgt" src="${mediaPath}/productMedia/hd/${product.productHandDraw.mediaUrl}" width="100%"/>
            	
            	</a></div>
                <div class="li2"><div class="cutstr2"><a href="${ctxPath}/product/${product.productId}.html" title="${product.productName}">${product.productName}</a></div><span>&nbsp;</span></div>
                <p class="li3">${product.brand.designer}</p>
                <p class="li4">${product.brand.brandName}</p>
                <div class="li5">
                <c:choose>
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
					           	<div class="product_quantity">
						           	<product:productQuantity2 product="${product}" />
						             <form id="myform" method="POST" action="#">
						               <input id="min" name="" type="button" value="-" />
						               <input id="quantity" name="quantity" type="text"  value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
						               <input id="add" name="" type="button" value="+" />
						             </form>
						              <!--product_quantity-->
									  <script>
						              $(function(){
						                  var t = $("#quantity");
						                  $("#add").click(function(){		
						                      t.val(parseInt(t.val())+1)
						                      //setTotal();
						                  })
						                  $("#min").click(function(){
						                      if(parseInt(t.val()) == 1)
						                          t.val(1);
						                      else{
						                    	  t.val(parseInt(t.val())-1)
						                          //setTotal();
						                      }
						                  })
						                  
						              })
						              </script>
						             
						             <%--
						             <div class="product_stock">
						               <i class="fa fa-exclamation-circle fa-lg fa_storck"></i>
						                还剩<span>${maxOrderQuantity == null ? 0 :  maxOrderQuantity}</span>件
						             </div><!--product_stock-->
						            --%>  
						           
						           </div><!--product_quantity-->
					           	</c:if>
           					</c:forEach>
	                	</c:forEach>
	                	</div>
	                <product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
                    <a class="j3" href="#">加入购物车</a>
                
                <p class="li6"><div class="jiathis_style">
							<span class="jiathis_txt">分享到</span>
							<a href="http://www.jiathis.com/share?uid=2052677" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" 

target="_blank"></a>
						</div>
			                <a href="#" class="addtolove" onclick="addToFavorite(${product.id});return false;" >
			               		 <i class="fa fa-heart fa-lg fa_storck"></i>
				                <div id="add_love">
				               	 点击加入收藏
				                </div>
			                </a>
			                <div id="love_count"><a href="#"  onclick="addToFavorite(${product.id});return false;" >点击加入收藏</a></div>
			                <script type="text/javascript">
							$(document).ready(function(){
								alert("hello");
							  $(".addtolove").click(function(){
							  $("#add_love").hide();
							  $("#love_count").show();
							  });
							});
							function changeToOne(obj){
								if($(obj).val() == ""){
									$(obj).val(1);
								}
							}
							</script>
						</p>
            </li>
        </c:forEach>