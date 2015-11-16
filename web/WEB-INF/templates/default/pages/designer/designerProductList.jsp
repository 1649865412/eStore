<!DOCTYPE html>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<html lang="zh-CN">
	<head>
		 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>四方街</title>

    <!-- Bootstrap -->
    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
    <script src="${ctxPath}/scripts/jquery/js/global_brain.js"></script>
    <%@ include file="../../decorators/include/javascripts.jspf"%>
    <%@ include file="../../decorators/include/styles7.jspf"%>
    <link href="${ctxPath}/scripts/jquery/js/colorbox/colorbox.css" rel="stylesheet" />
    
    <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
    <link href="${resPath}/styles/css/mall_nav.css" rel="stylesheet">
    <link href="${resPath}/styles/css/shooping-list.css" rel="stylesheet">
    <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
    <!--[if IE]>  <link rel="stylesheet" type="text/css" href="index2-ie-only.css/> <![endif]-->
    
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <c:choose>
			<c:when test="${sc.pageNo>1}">
				<title>${category.categoryName} Page (${sc.pageNo})</title>
			</c:when>
			<c:otherwise>
				<attribute:attributeValue entity="${category}" attributeValueVar="categoryTitle" attributeCode="categoryTitle"></attribute:attributeValue>
				<title>${empty categoryTitle.attributeValue ? category.categoryName : categoryTitle.attributeValue}</title>
				<meta name="keywords" content="<c:out value="${category.metaKeyword}"/>" />
				<meta name="description" content="<c:out value="${category.metaDescription}"/>" />
			</c:otherwise>
		</c:choose>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>

	<body>
	<%@ include file="../../decorators/include/headerMarket.jspf"%>
        <!--主体内容开始-->
         <div class="w-shooping-list">
           <div  class="w-shooping-list-sort" id="sticky">
                <ul class="row">
                	<li>
                        <div class="sort-tit">排序方式<i class="fa fa-caret-down"></i></div>
                        <p><a href="?sort=new&brandId=${brand.brandId}&page=${param.page}" <c:if test="${fn:indexOf(pageContext.request.queryString,'sort=new')!=-1}">class='active'</c:if>>最新上架</a></p>
                        <p><a href="?sort=up&brandId=${brand.brandId}&page=${param.page}" <c:if test="${fn:indexOf(pageContext.request.queryString,'sort=up')!=-1}">class='active'</c:if>>价格由低到高</a></p>
                        <p><a href="?sort=down&brandId=${brand.brandId}&page=${param.page}" <c:if test="${fn:indexOf(pageContext.request.queryString,'sort=down')!=-1}">class='active'</c:if>>价格由高到低</a></p>
                    </li>
                    <%--<li>
                        <p><a href="/catalog_default_catalog.html" class="active">所有产品</a></p> 
                        <p><a href="/wen_catalog.html"><i class="fa fa-venus"></i>女性</a></p>
                        <p><a href="/man_catalog.html"><i class="fa fa-mars"></i>男性</a></p>
                    </li>
                --%></ul>
                <div class="sort-btn active">
                	<i class="fa fa-chevron-left"></i>
                    <p>分<br>类<br>筛<br>选</p>
                </div>           
           </div><!--w-shooping-list-sort-->
           <div class="w-shooping-list-box">
                <div class="w-designer-deta">
                	<div class="designer-deta-img"><cartmatic:img isUrlOnly="false" url="${brand.pic2}" mediaType="other" width="100%" ></cartmatic:img></div>
                    <dl>
                    	<dt><cartmatic:img isUrlOnly="false" url="${brand.icon}" mediaType="other" width="146" height="146" ></cartmatic:img></dt>
                        <dd>
                        	<h2>${brand.designer}</h2>
                            <time><em>${brand.brandName}</em></time>
                            <p>${brand.story}</p>
                            <p class="last"><a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}"><i class="fa fa-caret-left"></i>点击查看更详细的设计师讯息</a></p>
                        </dd>
                    </dl>
                </div>  
                
                <div class="product_box">
             <ul class="product list-unstyled col4 c sku_list" id="pinterestList">
             	<c:forEach items="${productList}" var="product" varStatus="varStatus">
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
                        <div class="li5">
                        <c:if test="${!empty product.defaultProductSku}">
                        <product:showPrice productSku="${product.defaultProductSku}" viewType="4"/>
                        </c:if>
                        </div>
                        
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
	                        <c:if test="${!empty product.defaultProductSku}">
	                        	<product:addToCartSmall productSkuCode="${product.defaultProductSku.productSkuCode}" productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
	                        </c:if>
	                        
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
            
        </div><!--product_box-->
                <div class="w-page">
                	<c:if test="${pageNum - 1 != 0}">
                		<a href="/designerProductList.html?brandId=${brand.brandId}&sort=${param.sort}&page=${pageNum - 1 }"><i class="fa fa-long-arrow-left"></i></a>
                    </c:if>
                    <a href="javascript:;">${pageNum }</a>
                    <c:if test="${pageNum + 1 <= totalPage}">
                    	<a href="/designerProductList.html?brandId=${brand.brandId}&sort=${param.sort}&page=${pageNum + 1 }">${pageNum + 1 }</a>
                    </c:if>
                    <c:if test="${pageNum + 2 <= totalPage}">
                    	<a href="/designerProductList.html?brandId=${brand.brandId}&sort=${param.sort}&page=${pageNum + 2 }">${pageNum + 2 }</a>
                    </c:if>
                    <c:if test="${totalPage >4 && pageNum + 3 < totalPage}">
                    	·······
                    </c:if>
                    <c:if test="${pageNum + 3 <= totalPage}">
			            <a href="/culturalinformation/index.html?page=${totalPage}">${totalPage }</a>
		            </c:if>
                    <c:if test="${pageNum + 1 <= totalPage}">
                    	<a href="/designerProductList.html?brandId=${brand.brandId}&sort=${param.sort}&page=${pageNum + 1 }"><i class="fa fa-long-arrow-right"></i></a>
                    </c:if>
                </div>
                <!--/分页-->
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
           </div><!--w-shooping-list-box-->
         </div><!--w-shooping-list-->
        
        <!--主体内容结束-->
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
    <script src="${ctxPath}/scripts/jquery/js/colorbox/jquery.colorbox-min.js"></script>
    <!--<style>.w-nav{height:94px;background:url(img/navbg.gif) 0 0 repeat-x}</style>-->
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
            $(".j3").colorbox({ inline: true, width: "50%" });
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
      <script type="text/javascript">
        	$(function(){
				
					$(window).scroll(function(){
							$(".index-nav").addClass("w-nav-s")
						})
					if($(window).width()<993){
							$(".sort-btn p").html("分类筛选")
						}else{
							$(".sort-btn p").html("分<br>类<br>筛<br>选")
							}
				
					var H = $(window).height()
					$(".w-weekly-hd").height(H)
					if($(window).width()<992){
						$(".sort-btn p").html("分类筛选")
					}else{
						$(".sort-btn p").html("分<br>类<br>筛<br>选")
						}
					var MH = $(".weekly-hd-info").height()
					$(".weekly-hd-info").css("margin-top",-MH/2 - 30)
					$(".w-weekly-recomm ul li dl dd").click(function(){
							$(".w-buy-pop").fadeIn()
							$(".w-buy-pop-mask").fadeIn()
						})
					$(".w-buy-pop i").click(function(){
							$(".w-buy-pop").fadeOut()
							$(".w-buy-pop-mask").fadeOut()
						})
					
					
					if($(window).width()>992){
							$(".w-shooping-list-box").css({"margin-left":"290px","width":$(window).width()-290})
							$(".sort-btn").click(function(){
								if($(this).hasClass("active")){
										$(this).removeClass("active")
										$(".sort-btn i").removeClass("fa-chevron-left")
										$(".sort-btn i").addClass("fa-chevron-right")
										$(".w-shooping-list-box").animate({marginLeft:"60px","width":$(window).width()-60})
										$(".w-shooping-list-sort").animate({marginLeft:-230})
									}else{
										$(this).addClass("active")
										$(".sort-btn i").addClass("fa-chevron-left")
										$(".sort-btn i").removeClass("fa-chevron-right")
										$(".w-shooping-list-sort").animate({marginLeft:0})
										$(".w-shooping-list-box").animate({marginLeft:"290px","width":$(window).width()-290})
										}
							})
						}else{
								$(".sort-btn").removeClass("active")
								$(".sort-btn").click(function(){
										if($(this).hasClass("active")){
												$(".w-shooping-list-sort ul").css({height:"0"})
												$(this).removeClass("active")
											}else{
												$(".w-shooping-list-sort ul").css({height:"auto"})
												$(this).addClass("active")
												}
									})
							}
					window.onresize=function(){
							var H = $(window).height()
							$(".w-weekly-hd").height(H)
							if($(window).width()<992){
								$(".sort-btn p").html("分类筛选")
								$(".w-shooping-list-box").css({"margin-left":"0","width":"100%"})
								$(".sort-btn").removeClass("active")
							}else{
								$(".sort-btn p").html("分<br>类<br>筛<br>选")
								$(".w-shooping-list-box").css({"margin-left":"290px","width":$(window).width()-290})
								}
						}
				})
        </script>
        


	</body>

</html>