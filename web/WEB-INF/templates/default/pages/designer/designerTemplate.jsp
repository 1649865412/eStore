<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<!--设计师详情页-->
<html lang="en" class="no-js">
	<head>
		<c:set var="productPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></c:set>
		<c:set value="${empty product.title?product.productName:product.title}" var="pageTitle"></c:set>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<script src="${ctxPath}/scripts/jquery/js/global_brain.js"></script>
		<%@ include file="../../decorators/include/javascripts.jspf"%>
	    <%@ include file="../../decorators/include/styles7.jspf"%>
	    <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
	    <link href="${ctxPath}/scripts/jquery/js/colorbox/colorbox.css" rel="stylesheet" />
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>
	<body>
		<%@ include file="../../decorators/include/headerNew.jspf"%>
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
	            <div class="li2 title-font">${brand.designer}</div>
	            <div class="li3 c">
	              <cartmatic:img isUrlOnly="false" url="${brand.logo}" mediaType="other"></cartmatic:img>
	              <!-- JiaThis Button BEGIN -->
	              <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	              <!-- JiaThis Button END -->
	            </div>
	
	            <div class="li4">${brand.story}</div>
	        </div>
	    </div>
	    <!--设计师作品-->
    	<div class="designer_work">
        <div class="title"><div><span class="title-font">设计师代表作品</span></div></div>
        

        <!--此处需要从后台传过推荐产品8个productRecommendId-->
        <div class="product_box">
        <ul class="product list-unstyled col4 c sku_list" id="pinterestList">
        <c:forEach items="${recommendProductList}" var="product" begin="0" end ="7">
        <c:if test="${product.status ==1}">
					<li>
						<div class="li1">
	                        <a href="${ctxPath}/product/${product.productId}.html">
	                            <img class="imgo" src="${mediaPath}product/v/${product.defaultProductSku.image}" width="100%" />
	                            <%--<img class="imgt" src="${mediaPath}/productMedia/hd/${product.productHandDraw.mediaUrl}" width="100%"/>--%>
	                        </a>
	                    </div>
	                    <div class="li2">
	                        <div class="cutstr2">
	                            <a href="${ctxPath}/product/${product.productId}.html">
	                                ${product.productName}
	                            </a>
	                        </div>
	                        <span class="new">
	                        </span>
	                    </div>
	                    <p class="li3">
	                        ${product.brand.designer}
	                    </p>
	                    <p class="li4">
	                        ${product.brand.brandName}
	                    </p>
                        <div class="li5"><product:showPrice productSku="${product.defaultProductSku}" viewType="4"/></div>
                        <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
                        <div class="join_box">
	                        <c:forEach items="${productMap}" var="productMapItem">
		                    	<c:if test="${productMapItem.key == product.productId}">
				                 <c:forEach items="${productMapItem.value}" var="productSkuOptionAndValue">
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
				                 </c:forEach>
				               </c:if>
				            </c:forEach>
				            <form id="myform" method="POST" action="#">
					               <input id="quantity" type="hidden" name="quantity" type="text"  value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
					             </form>
	                        <span class="cart_close">
	                            关闭
	                        </span>
	                        <product:addToCartSmall productSkuCode="${product.defaultProductSku.productSkuCode}" productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
	                    </div>
	                    <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
		                <p class="li6">
	                        <!-- JiaThis Button BEGIN -->
	                                            
	                                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	                                           
	                                            <!-- JiaThis Button END -->
	                        <a href="javascript:" onClick="addToFavorite(${product.productId})"><i class="fa fa-heart-o"></i> 加入收藏</a>
	                        <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
	                    </p>
                    </li>
                    </c:if>
				</c:forEach>
        </ul>
        </div>
        <div class="product_more"><a href="${ctxPath}/designerProductList.html?brandId=${brand.brandId}">点击查看更多</a></div>
        </div>
        <!--设计师思维对话-->
        <div class="dialogue_box">
        	<div class="dialogue">
            	<div class="c dialogue_part">
            		<c:if test="${culturalInformation.culturalInformationId != null && culturalInformation.culturalInformationId != ''}">
	                    <div class="dialogue_left">
	                        <div class="dialogue_info">
	                            <h3 class="dialogue_info_left title-font">思维对话</h3>
	                            <div class="dialogue_info_right">
	                            	<div class="li1">${culturalInformation.title}</div>
	                                <div class="li2"><a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a></div>
	                                <div class="li3">
	                                ${culturalInformation.content}
	                                 </div>
	                                 	<a class="li4" href="/culturalinformation/culturaTemplate.html?culId=${culturalInformation.culturalInformationId}">点击查看详细</a>
	                            </div>
	                        </div>
	                    </div><!--dialogue_left end-->
                    </c:if>
                    <div class="dialogue_right">
	                    <c:if test="${culturalInformation.logoImg != null && culturalInformation.logoImg != ''}">
	                    	<cartmatic:img isUrlOnly="false" url="${culturalInformation.logoImg}" mediaType="other" id="logoImage"></cartmatic:img>
	                    </c:if>
	                </div>
                    <div class="dialogue_left">
                    	<div class="dialogue_left_bottom"><i class="line"></i>
                    ${brand.quotation}</div>
                    	<cartmatic:img isUrlOnly="false" url="${brand.pic}" mediaType="other" id="logoImage"></cartmatic:img>
                    </div><!--dialogue_left end-->
               	</div>
            </div>
        </div><!--dialogue_box end-->
        <!--设计师动态-->
        <c:if  test="${fn:length(brandDynamicList)!=0 }">
        <div class="title title2"><div><span class="title-font">设计师最新动态</span></div></div>
        </c:if>
        <ul class="designer_news list-unstyled c">
           <c:forEach items="${brandDynamicList}" var="brandDynamic" >
        	<li>
            	<div class="designer_news_img data_bg" style="background-image:url(${brandDynamic.img})">
            		<cartmatic:img isUrlOnly="false" url="v/${brandDynamic.img}" mediaType="productMedia" ></cartmatic:img>
            	<a href="http://${brandDynamic.website}" target="_blank"></a></div>
                <div class="designer_news_info">
                    <div class="li1"><span>${brandDynamic.resource}</span></div>
                    <div class="li2">${brandDynamic.resourceTime}</div>
                    <div class="li3 cutstr3">
                        <div >${brandDynamic.content}</div>
                    </div>
                   	<a class="li4" href="http://${brandDynamic.website}" target="_blank">点击访问来源<i></i></a>
                    <!-- JiaThis Button BEGIN -->
	                <a href="http://www.jiathis.com/share" class="li5 jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	                <!-- JiaThis Button END -->
                </div>
            </li>   
           </c:forEach>            
        </ul><!--list-unstyled end-->
        <!-- 加入购物车成功 -->
	    <div style="display:none">
                    <div id="cart_box" class="after_addtocart">
                        <div class="w-cart-header">
                            <span><i class="fa fa-check-circle-o"></i>该产品已经成功加入您的购物车</span>
                            <hr class="aftercart_hr"/>
                        </div><!--w-cart-header-->
                        <div class="w-cart-body">
                            <div class="addcart_top">
                                    	<jsp:include flush="true" page="/sales/recommendedProduct.html">
								             <jsp:param name="typeName" value="also_buy" />
								             <jsp:param name="firstResult" value="0" />
								             <jsp:param name="maxResults" value="7" />
								             <jsp:param name="template" value="sales/include/recommendProductContentNew2"/>
								             <jsp:param name="doAction" value="defaultAction" />
								             <jsp:param name="sourceId" value="${product.productId}" />
								         </jsp:include>
                            </div><!--addcart_top-->
                        </div><!--w-cart-body-->
                    </div><!--cart_box-->
                </div>
	     <!-- End 加入购物车成功 -->
        <%@ include file="../../decorators/include/footerNew.jspf"%>
		<script type="text/javascript">
		  
		  function addToFavorite(productId){
      		    if(isLogined()){
      		  	$.post("/ajaxFavorite.html?doAction=addFavorite", {
          		  	productId : productId
        		  	}, function(result) {
        		  		    alert(result.msg);
        		  		}, "json");
          		    }else{
	              		 alert("此操作需要登陆");
	          		  	$(".w-login").show();
						$(".w-login-left").show();
						$(".w-login-right").hide();
              		    }
			}
         </script>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/pinterest.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/index.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/slider.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/colorbox/jquery.colorbox-min.js"></script>
	    <script type="text/javascript">
	        //2015-11-11 宣扬修改
	        //加入购物车弹出事件
	        $(function () {
	            $(".j3").colorbox({ inline: true, width: "50%" });
	            //解决图片加载好 底部出现没有加载好的现象
	            var imgSum = $('.imgo').length;
	            var imgSum2 = 0;
	            $(".imgo").load(function () {
	                imgSum2++;
	                console.log(imgSum2)
	                if (imgSum == imgSum2)
	                    w_resize();
	            });
	        })
	    </script>
	    <script type="text/javascript">
	    
	        $(function () {
	            //弹出图片和视屏
	            $(".img_box").colorbox({ rel: 'group1' , innerWidth: "90%", innerHeight: "90%"});
	            $(".video_box").colorbox({ iframe: true, innerWidth: "80%", innerHeight: "80%" });
	            $(".j3").colorbox({ inline: true, width: "50%" });
	            //循环绑定背景图片
	            $(".data_bg").each(function () {
	                var img = $(this).attr("data-img");
	                if (img != undefined)
	                    $(this).css({ 'background': 'url(' + img + ')' })
	            })
	        })
	    </script>
	      <script type="text/javascript" >
		  var jiathis_config={
			  summary:"",
			  shortUrl:true,
			  hideMore:false
		  }
		  </script>
		  <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
	</body>
</html>