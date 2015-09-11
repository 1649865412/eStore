<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page pageEncoding="utf-8"%>
<%@page import="com.cartmatic.estore.common.model.catalog.ProductReview"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.cartmatic.estore.common.model.catalog.ProductDescription"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags/app"%>
<!--文化资讯列表页-->
<html lang="en" class="no-js">
	<head>
		<c:set var="productPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></c:set>
		<c:set value="${empty product.title?product.productName:product.title}" var="pageTitle"></c:set>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
      	<%@ include file="../../decorators/include/styles7.jspf"%>
	     <script src="${ctxPath}/scripts/jquery/js/global_brain.js"></script>
	     <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
		
	</head>
	<body>
			<div class="designer_show">
            <div class="swiper-wrapper">
             <c:if test="${brand.pic2 !=null&&fn:trim(brand.pic2)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic2}" mediaType="other" ></cartmatic:img>
                </div>
              </c:if>
              <c:if test="${brand.pic3 !=null&&fn:trim(brand.pic3)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic3}" mediaType="other"></cartmatic:img>
                </div>
              </c:if>
              <c:if test="${brand.pic4 !=null&&fn:trim(brand.pic4)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic4}" mediaType="other"></cartmatic:img>
                </div>
              </c:if>
              <c:if test="${brand.pic5 !=null&&fn:trim(brand.pic5)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic5}" mediaType="other"></cartmatic:img>
                </div>
              </c:if>
              <c:if test="${brand.pic6 !=null&&fn:trim(brand.pic6)!=''}">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                	<cartmatic:img isUrlOnly="false" url="${brand.pic6}" mediaType="other"></cartmatic:img>
                </div>
              </c:if>
            </div>
            <div class="designer_pagination"></div>
            <a class="designer_enlarge" href="#"></a>
            <a class="designer_close" href="javascript;"></a>
        </div><!--designer_show end-->
        <div class="designer_box c">
        	<div class="designer_con">
            	<div class="li1"><cartmatic:img isUrlOnly="false" url="${brand.icon}" mediaType="other" width="270" height="270" ></cartmatic:img></div>
                <div class="li2 title-font">${brand.brandName}</div>
                <div class="li3 c"><cartmatic:img isUrlOnly="false" url="${brand.logo}" mediaType="other" width="107" height="40" ></cartmatic:img><a href="#"><i></i>分享</a></div>
                <div class="li4">${brand.story}</div>
            </div>
        </div>
        <div class="title"><div><span class="title-font">设计师代表作品</span></div></div>
        

        <!--此处需要从后台传过推荐产品8个productRecommendId-->
        <ul class="product list-unstyled c">
        <c:forEach items="${recommendProductList}" var="product" begin="0" end ="7">
           <li>
            	<div class="li1"><a href="${ctxPath}/product/${product.productId}.html">
            	
            	<img class="imgo" src="${mediaPath}product/v/${product.defaultProductSku.image}" width="100%"/>
            	
            	<img class="imgt" src="${mediaPath}/productMedia/hd/${product.productHandDraw.mediaUrl}" width="100%"/>
            	
            	</a></div>
                <div class="li2"><div class="cutstr2"><a href="#" title="${product.productName}">${product.productName}</a></div><span>&nbsp;</span></div>
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
											<%--图片 --%>
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
											<%--文本 --%>
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
	                	</c:forEach>
	                <product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
                    <a class="j3" href="#">加入购物车</a>
                
                <p class="li6"><a href="#"><i class="i1"></i>分享</a><a href="#"><i class="i2"></i>加入收藏</a></p>
            </li>
        </c:forEach>
        </ul>
        
        
        <div class="product_more"><a href="#">点击查看更多</a></div>
        <div class="dialogue_box">
        	<div class="dialogue">
            	<div class="c">
                    <div class="dialogue_left">
                        <div class="dialogue_info">
                            <h3 class="dialogue_info_left title-font">思维对话</h3>
                            <div class="dialogue_info_right">
                            	<div class="li1">${culturalInformation.title}</div>
                                <div class="li2"><a href="#"><i></i>分享</a></div>
                                <div class="li3">
                                ${culturalInformation.content}
                                 </div>
                                <a class="li4" href="#">点击查看详细</a>
                            </div>
                        </div>
                    </div><!--dialogue_left end-->
                    <div class="dialogue_right"><cartmatic:img isUrlOnly="false" url="${culturalInformation.logoImg}" mediaType="other" id="logoImage" height="100" width="100%;"></cartmatic:img></div>
                    <div class="dialogue_left">
                    	<div class="dialogue_left_bottom"><i class="line"></i>
                    ${brand.quotation}</div>
                    	<cartmatic:img isUrlOnly="false" url="${brand.pic}" mediaType="other" id="logoImage" height="100" width="100%;"></cartmatic:img>
                    </div><!--dialogue_left end-->
               	</div>
            </div>
        </div><!--dialogue_box end-->
        <div class="title title2"><div><span class="title-font">设计师最新动态</span></div></div>
        <ul class="designer_news list-unstyled c">
           <c:forEach items="${brandDynamicList}" var="brandDynamic" >
        	<li>
            	<div class="designer_news_img" style="background-image:url(${brandDynamic.img})">
            		<cartmatic:img isUrlOnly="false" url="v/${brandDynamic.img}" mediaType="productMedia" ></cartmatic:img>
            	<a href="http://${brandDynamic.website}" target="_blank"></a></div>
                <div class="designer_news_info">
                    <div class="li1"><span  
                    
                     <c:if test="${brandDynamic.colorType==1}">class='xinlang'</c:if>
                     
                     >${brandDynamic.resource}</span></div>
                    <div class="li2">${brandDynamic.resourceTime}</div>
                    <div class="li3 cutstr3">
                        <div >${brandDynamic.content}</div>
                    </div>
                   	<a class="li4" href="http://${brandDynamic.website}" target="_blank">点击访问来源<i></i></a>
                    <a class="li5" href="#" target="_blank"><i></i>分享</a>
                </div>
            </li>   
           </c:forEach>            
        </ul><!--list-unstyled end-->
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/classie.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/list.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jqueryjs/jquery.masonry.min.js"></script>
		
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
		<%--购物车弹出层 begin --%>
		<textarea id="shoppingCartTemplate" style="display: none;">
			<h2>
				已将{0}件商品加入购物车！
			</h2>
			<div class="left">
				<div class="wrap-line">
					<div class="photo">
						<img src="${appConfig.store.mediaUrlPath}/product/e/{1}" width="165" height="165" alt="" onerror="$(this).attr('originsrc',this.src).attr('src',__defaultImage).removeAttr('onerror');" originsrc=""/>
					</div>
					<div class="txt">
						{2}
						<div class="blank10"></div>
						<strong class="red f13px">{3}</strong>
						<br>
							<strong class="f13px">数量:{4}</strong>
					</div>
				</div>
			</div>
			<div class="right">
				{5}件商品在您的购物车内
				<br>
				<strong class="f18px">小计: <span class="red">{6}</span>
				</strong>
				<div class="blank10"></div>
				<div class="out">
					<button class="toggle1 checkout" title="CheckOut" type="button"
						value="CheckOut"
						onclick="window.location.href='/cart/shoppingcart.html'">
						去结算
					</button>
				</div>
				<div class="shop">
					<a onclick="closeSimpleDialog('shoppingcartAlertWId_');return false;" href="#">继续购物</a>
				</div>
			</div>
		</textarea>
		<%--购物车弹出层 end --%>
	</body>
</html>