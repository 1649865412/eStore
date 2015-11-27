<!DOCTYPE html>
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
<style type="text/css">
.w-pro-pic .swiper-slide img{
	text-align: center; 
	display: block;
    vertical-align: middle;
	max-width: 100%;
    max-height: 100%;	
}
</style>

<c:if test="${product.status != 1}">
	<%response.setStatus(response.SC_GONE);%>
	
</c:if>
<html lang="zh-CN">
	<head>
		<c:set var="productPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></c:set>
		<c:set value="${empty product.title?product.productName:product.title}" var="pageTitle"></c:set>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		
		<!-- Bootstrap -->
		<%@ include file="../../decorators/include/javascripts.jspf"%>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
        <!-- 字体 -->
	    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		<link href="${resPath}/styles/font-awesome.css" rel="stylesheet">
	    <!-- Bootstrap -->
	    <link href="${resPath}/styles/css/bootstrap.css" rel="stylesheet">
	    <!-- 轮播图 -->
	    <link href="${resPath}/styles/css/swiper.min.css" rel="stylesheet">
	    <!-- 动画库 -->
	    <link href="${resPath}/styles/css/animate.min.css" rel="stylesheet">
	    <!-- 样式表 -->
	    <link href="${resPath}/styles/css/index.css" rel="stylesheet">
	    <link href="${resPath}/styles/css/pro-deta.css" rel="stylesheet">
	    <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
	    <link href="${resPath}/styles/css/mall_nav.css" rel="stylesheet">
	    <!-- 弹出框 -->
	    <link href="js/colorbox/colorbox.css" rel="stylesheet" />
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
       <!-- <link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />->
        
         <!-- Include the story plugin: -->
         <script type="text/javascript">
         //判断是否存在推荐搭配，若不存在则隐藏
	      $(document).ready(function(){
	    	  if(document.getElementById("recProduct") == null || document.getElementById("recProduct") == "")
	    	  {
	    		  $("#recType").hide();
	    	  } 
	      });
	      </script>  
	  <script type="text/javascript">
      $(document).ready(function(){
          $(".designer_pic .rsp").hide();
          
          $(".designer_story").hover(function(){
              $(".designer_pic").find(".rsp").stop().fadeTo(500,0.5)
              $(".designer_pic").find(".text").stop().animate({left:'0'}, {duration: 500})
          },function(){
              $(".designer_pic").find(".rsp").stop().fadeTo(500,0)
              $(".designer_pic").find(".text").stop().animate({left:'238'}, {duration: "fast"})
              $(".designer_pic").find(".text").animate({left:'-238'}, {duration: 0})
          });
      
      });
      </script>  
      <script>
		$(document).ready(function(){
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
					                  
			});
		</script>
          
      <!-- Add fancyBox main JS and CSS files -->
      
      <link rel="stylesheet" type="text/css" href="${resPath }/styles/jquery.fancybox.css" media="screen" />
	  <!-- Include the elevatezoom plugin: -->
	  <script type="text/javascript" src="${ctxPath}/scripts/jquery/jquery.fancybox.js"></script>
      <script type="text/javascript">
		$(document).ready(function() {
			$(".target").fancybox({
				maxWidth	: 800,
				maxHeight	: 600,
				fitToView	: false,
				width		: '70%',
				height		: '70%',
				autoSize	: false,
				closeClick	: false,
				openEffect	: 'none',
				closeEffect	: 'none'
			});
		});
 
});
		
		</script>
		
	  <script type="text/javascript">
      $(document).ready(function($){
			$("#zoom_03").elevateZoom({
			gallery:'gallery_01', 
			cursor: 'pointer', 
			galleryActiveClass: "active", 
			imageCrossfade: true, 
			borderColour: "#fff",
			borderSize: 2,
			zoomWindowOffetx: 25,
			zoomWindowWidth:330,
			zoomWindowHeight:400,
			loadingIcon: "${resPath}/images/bx_loader.gif"
			}); 

		  $("#zoom_03").bind("click", function(e) {
				var ez =   $('#zoom_03').data('elevateZoom');
				//ez.closeAll(); //NEW: This function force hides the lens, tint and window	
				var list2 = ez.getGalleryList_2();
				$.fancybox(list2);
				return false;
		  }); 
	  
	  }); 

      </script>
      <!--bxslider-->
      
      <script>
	  $(function(){
		  $('.slider2').bxSlider({
			  pager: false,
			  controls:true,
			  wrapper_class: 'sale_popular',
			  pause: 2500,
			  slideWidth: 100,
			  minSlides: 4,
			  maxSlides: 4,
			  slideMargin: 4
		  });
	  });
      </script>
      <!--product detail-->
      
      <!--comment-->
      
      <script>
	   $(function() {
			$.fn.raty.defaults.path = 'lib/img';
			var $star = $('.target_star');
			$star.each(function(){
				var $this = $(this);
				var rate = $this.next().val();
				$this.raty({ 
					  readOnly: true, 
					  score: rate ,
					  number: 5,//多少个星星设置		
					  path      : '${resPath}/images',
					  size      : 24,
					  starOff   : 'star-off.png',
					  starOn    : 'star-on.png',
					  cancel    : false,
					  targetKeep: true
				 });
			});
	   });
	  </script>
	  <script type="text/javascript">
      $(document).ready(function() {
      	$('.fancybox').fancybox({
			padding : 0
		 });
      	});
	  </script>
	  <script>
	  $(document).ready(function(){
		$("#p_designer_oth .sub_active").css({"display":"inline-block"});
		$("#p_collocate").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("搭配款式");
			 $("#p_collocate").addClass("active_href");
			 $("#p_other").removeClass("active_href");
			 $("#p_designer_oth").removeClass("active_href");
		   $("#p_collocate .sub_active").css({"display":"inline-block"});
		   $("#p_other .sub_active").css({"display":"none"});
		   $("#p_designer_oth .sub_active").css({"display":"none"});
		});
		
		$("#p_other").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("相似款式");
			 $("#p_other").addClass("active_href");
			 $("#p_collocate").removeClass("active_href");
			 $("#p_designer_oth").removeClass("active_href");
		   $("#p_other .sub_active").css({"display":"inline-block"});
		   $("#p_collocate .sub_active").css({"display":"none"});
		   $("#p_designer_oth .sub_active").css({"display":"none"});
		});
		
		$("#p_designer_oth").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("该设计师其他款式");
			 $("#p_designer_oth").addClass("active_href");
			 $("#p_collocate").removeClass("active_href");
			 $("#p_other").removeClass("active_href");
		   $("#p_designer_oth .sub_active").css({"display":"inline-block"});
		   $("#p_collocate .sub_active").css({"display":"none"});
		   $("#p_other .sub_active").css({"display":"none"});
		});
		
	  });
	  </script>   
      <!--[if lt IE 9]>
      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
      <![endif]-->
      <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>

	<body>
	<%@ include file="../../decorators/include/headerMarket.jspf"%>
		<!--页面主内容-->
		<div class="w-pro-deta">
            <!--产品详情部分-->
        	<div class="w-pro-deta-hd row"><!--2015-9 此处修改了-蔡蔡-->
                <!--产品图片-->
            	<div class="w-pro-pic">
                    <!-- Swiper -->
                    <div class="swiper-container">
                    	<div class="pro-pic-share">
                        	<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
                        </div>

                        <div class="swiper-wrapper">
                        <c:if test="${empty productMoreImages}">
                        	<img src="/images/null.jpg">
                        </c:if>
                        <c:forEach items="${productMoreImages}" var="productImages">
                            <div class="swiper-slide"  style="background-image: url(${mediaPath}productMedia/v/${productImages.mediaUrlLarge});"><img src="${mediaPath}productMedia/v/${productImages.mediaUrlLarge}"></div>
                        </c:forEach>
                        </div>
                        <!-- Add Pagination -->
                        <div class="swiper-pagination"></div>
                        <!-- Add Arrows -->
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                    </div>
                </div>
                <!--end of 产品图片-->
                <!--产品信息-->
            	<div class="w-pro-info">
                    <div class="w-pro-info-tit">${product.productName}</div>
                    <div class="w-pro-info-price"><%@ include file="./include/productTemplate_priceArea.jspf"%></div>
                    <div class="w-pro-info-form">
                    	<p><span>设计师：</span><a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${product.brand.id}">${product.brand.designer}</a></p>
                        <p><span>品牌：</span><a href="${ctxPath}/designerProductList.html?brandId=${product.brand.id}">${product.brand.brandName}</a></p>
                    </div>
                    <p class="w-pro-info-numbering">产品编号：${product.productCode}</p>
                    <input type="hidden" id="productId" value="${product.productId}" />
		           <input type="hidden" id="productCode" value="${product.productCode}" />
		           <input type="hidden" id="productName" value="${product.productName}" />
		           <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
		           <input type="hidden" id="accessoriesSkuCodes" value="" />
		           <input type="hidden" id="categoryId" value="${category.categoryId}" />
		           <input type="hidden" id="product_simpleName" value="<app:interceptString str="${product.productName}" length="50"></app:interceptString>" />
		           <input type="hidden" id="productLinkUrl" value="${uri}" />
		           <input type="hidden" id="listPrice" value="${product.defaultProductSku.listPrice}" />
                    <!--分页tab-->
                    <div class="w-pro-info-tabs">
                    	<ul id="tabs" class="row">
                        	<li><a href="#" name="#tab1">产品信息</a></li>
                            <li><a href="#" name="#tab2">尺码指导</a></li>
                            <li><a href="#" name="#tab3">售后&运费说明</a></li>
                            <li><a href="#" name="#tab4">二维码购买</a></li>
                        </ul>
                        <div id="info-tabs-contents">
                        	<div id="tab1">
                            	<div class="info_item1">
                                	${product.productDescription.imageDescription}
                                </div>
                                <div class="info_item2">
                                	<ul>
										<li>上架时间：<fmt:formatDate value="${product.publishTime}" pattern="yyyy-MM-dd"/></li>
										<c:if test="${not empty product.defaultProductSku.weight}">
											<li>商品毛重：${product.defaultProductSku.weight}${appConfig.weightUnit }</li>
										</c:if>
										<c:forEach items="${productAttGroups}" var="productAttGroup">
											<c:forEach items="${productAttGroup.productAttrValues}" var="productAttrValue">
												<c:if test="${not empty productAttrValue.attributeValue}">
													<li>${productAttrValue.attribute.attributeName}：
														<c:choose>
															<c:when test="${productAttrValue.attributeDataType==1}">
																${fn:replace(productAttrValue.attributeValue,",","，")}
															</c:when>
															<c:otherwise>${productAttrValue.attributeValue}</c:otherwise>
														</c:choose>
													</li>
												</c:if>
											</c:forEach>
										</c:forEach>
									</ul>    
					              <p>
					              	<product:htmlConverter content="${product.productDescription.fullDescription}"></product:htmlConverter>   
					              </p>
                                </div>
                                <div class="info_item3">
                                	<p><strong>${product.productDescription.productInfoationDescription}</strong></p>
                                </div>
                            </div>
                            <div id="tab2">
                            	<div class="info2_item1">
                                    ${product.productDescription.productSizeDescription}
                                </div>
                                <div class="info2_item3"><p><a href="/resources/images/layout/sizechart.jpg">查看 SIZE 对照表</a></p></div>
                            </div>
                            <div id="tab3">
                            	<div class="info3_item1">
                                    ${product.productDescription.customerServiceDescription}
                                </div>
                            </div>
                            <div id="tab4">
                            	<div class="info4_item1">
                                    <p>扫扫享手机专享价</p>
                                    <p><img src="${mediaPath}qrcode/${encoderContent}"></p><br>
                                </div>
                                <div class="info4_item2">
                                    ${product.productDescription.qrCodeDescription}
                               	</div>
                            </div>
                        </div>
                        <div class="w-pro-info-btn addbefore"><a href="javascript:;">加入购物车</a></div>
                    </div>
                    <!--end of 分页tab-->
                    <!--选择颜色等-->
                    <div id="skuOptions" class="w-pro-car">
                    	<em class="fa fa-close"></em>
                    	<ul>
		                 <c:forEach items="${productSkuOptionAndValues}" var="productSkuOptionAndValue">
		                 	<div class="tb-prop tm-clear">
									<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'color') > -1}">
										<div class="product_color">
											<%--图片 --%>
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
									 	<%--<div class="product_size">
											文本 
			                                 <ul class="size" data-property="${productSkuOptionAndValue.key.skuOptionName}">
			                                 	<label>选择尺码</label>
												<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
													<li class="pro-car-1" data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}">
						                                <a href="javascript:;" >${skuOptionValue.skuOptionValueName}</a>
						                            </li>
						                        </c:forEach>
											</ul>
										</div>
										--%>
										<li class="pro-car-1">
			                                 	<label>选择尺码</label>
			                                 	<ul class="size" data-property="${productSkuOptionAndValue.key.skuOptionName}">
												<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
													<span  class="size2" data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}">
						                                <a href="javascript:;">${skuOptionValue.skuOptionValueName}</a>
						                            </span>
						                        </c:forEach>
						                        </ul>
										</li>
									</c:if>
							</div>
		                 </c:forEach>
		                 <li class="pro-car-2">
		                 	<label>选择颜色</label>
		                 	<ul>
		                	<!-- 该产品其他颜色 -->
		                	<li><a href="javascript:void(0)"  class="active"><img src="${ctxPath}/media/product/v/${product.defaultProductSku.image}" width="72" height="97"></a></li>
			             	<jsp:include flush="true" page="/sales/recommendedProduct.html">
					             <jsp:param name="typeName" value="other_color" />
					             <jsp:param name="firstResult" value="0" />
					             <jsp:param name="maxResults" value="5" />
					             <jsp:param name="template" value="sales/include/recommendProductContentNew"/>
					             <jsp:param name="doAction" value="defaultAction" />
					             <jsp:param name="sourceId" value="${product.productId}" />
					         </jsp:include>
					         </ul>
					        <li style="clear:both"></li>
					        <li class="pro-car-3">
					        	<label>选择数量</label>
					             <form id="myform" method="POST" action="#">
						             <div class="spinner">
							               <a href="javascript:;" id="min"><i class="fa fa-minus"></i></a>
							               		<input id="quantity" name="quantity" type="text"  value="${minOrderQuantity>1?minOrderQuantity:1}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" onblur="changeToOne(this);">
							              <a href="javascript:;" id="add"><i class="fa fa-plus"></i></a>
						              </div>
					             </form>
					           
					           </li>
					           </ul>
		                 <product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
		           	</div>
                    <!--end of 选择颜色等-->
                </div><!--w-pro-info-->
                <!--end of 产品信息-->
            </div><!--w-pro-deta-hd row-->
            <!--end of 产品详情部分-->
            <!--下方集合-->
            <div class="w-pro-deta-bd">
            	<!--优惠搭配/推荐搭配-->
            	<div class="deta-bd-group1">
                	<div class="deta-bd-tit"><!--暂时没有优惠套餐不用套用--><!--<a href="#" name="#tabb1">优惠套餐</a> | --> <a href="#" name="#tabb2"  class="current"><span id="recType">推荐搭配</span></a></div>
                    <div id="deta_bd_content">
                        <div id="tabb2">
                        	<ul class="sku_row"><!--2015-9 此处修改了-蔡蔡--->
                                <li class="center sku_list"><!--2015-9 此处修改了-蔡蔡-->
                                	<jsp:include flush="true" page="/sales/recommendedProduct.html">
							             <jsp:param name="typeName" value="similar_product" />
							             <jsp:param name="firstResult" value="0" />
							             <jsp:param name="maxResults" value="4" />
							             <jsp:param name="template" value="sales/include/recommendProductContentNew3" />
							             <jsp:param name="doAction" value="defaultAction" />
							             <jsp:param name="sourceId" value="${product.productId}" />
							         </jsp:include>
                                </li>
                            </ul>
                        </div><!--tabb2-->
                    </div><!--deta_bd_content-->
                </div><!--deta-bd-group1-->
                <!--end of 推荐优惠搭配-->
            	
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
                <!--达人秀-->
                <c:if  test="${fn:length(product.productTalenshowValues)!=0 }">
                <div class="deta-bd-group2">
                	<h2>达人秀</h2>
                	<div class="swiper2">
                        <div class="swiper-wrapper">
                        <c:forEach items="${product.productTalenshowValues}" var="productTalenshowValues">
                            <div class="swiper-slide"><img src="${mediaPath}other/${productTalenshowValues.talentShow.img}"><div class="swiper2-mask"><div class="swiper2-pop"><p>${productTalenshowValues.talentShow.content}</p><p><fmt:formatDate value="${productTalenshowValues.talentShow.releaseTime}" type="date" dateStyle="long"/>上传</p></div></div></div>
                        </c:forEach>
                        </div>
                        <!-- Add Arrows -->
                        <div class="swiper-button-next1"><a href="#"><i class="fa fa-caret-right"></i></a></div>
                        <div class="swiper-button-prev1"><a href="#"><i class="fa fa-caret-left"></i></a></div>
                    </div>
                </div>
                </c:if>
                <!--end of 达人秀-->
                <!--站内广告-->
                <div class="deta-bd-group3"><content:showAdNew adPositionType="product" /></div>
            <!--end of 下方集合-->
        </div><!--w-pro-deta-->
        <%@ include file="../../decorators/include/footerNew.jspf"%>
		<script type="text/javascript">
		  
		  function addToFavorite(productId){
      		    if(isLogined()){
      		  	$.post("/ajaxFavorite.html?doAction=addFavorite", {
          		  	productId : productId
        		  	}, function(result) {
        		  		    alert("result:"+result.msg);
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
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/slider.js"></script>
        <script src="${ctxPath}/scripts/jquery/js/colorbox/jquery.colorbox-min.js"></script> 
		<script>
			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				paginationClickable: '.swiper-pagination',
				nextButton: '.swiper-button-next',
				prevButton: '.swiper-button-prev',
				spaceBetween: 30,
				loop:true
			});
		</script>
        <script>
			if($(window).width()>768){
					var swiper = new Swiper('.swiper2', {
						slidesPerView:4,
						paginationClickable: true,
						nextButton: '.swiper-button-next1',
						prevButton: '.swiper-button-prev1',
						spaceBetween: 20
					});
				}else{
						var swiper = new Swiper('.swiper2', {
							slidesPerView:2,
							paginationClickable: true,
							nextButton:'.swiper-button-next1',
							prevButton:'.swiper-button-prev1',
							spaceBetween: 20
						});
						$(function(){
							$(".w-pro-pic .swiper-slide img").width("100%")
						})
					}
				window.onresize=function(){
					if($(window).width()>768){
						var swiper = new Swiper('.swiper2', {
							slidesPerView:4,
							paginationClickable: true,
							nextButton: '.swiper-button-next1',
							prevButton: '.swiper-button-prev1',
							spaceBetween: 20
						});
					}else{
							var swiper = new Swiper('.swiper2', {
								slidesPerView:2,
								paginationClickable: true,
								nextButton: '.swiper-button-next1',
								prevButton: '.swiper-button-prev1',
								spaceBetween: 20
							});
							$(function(){
								$(".w-pro-pic .swiper-slide img").width("100%")
							})
						}
				}
		</script>
        <script type="text/javascript">
			function resetTabs(){
				$("#info-tabs-contents > div").hide();
				$("#tabs a").attr("id","");
			}
			
			var myUrl = window.location.href;
			var myUrlTab = myUrl.substring(myUrl.indexOf("#")); 
			var myUrlTabName = myUrlTab.substring(0,4);
			
			(function(){
				$("#info-tabs-contents > div").hide();
				$("#tabs li:first a").attr("id","current");
				$("#info-tabs-contents > div:first").fadeIn();
			
				$("#tabs a").on("click",function(e) {
					e.preventDefault();
					if ($(this).attr("id") == "current"){
						return       
					}else{             
						resetTabs();
						$(this).attr("id","current");
						$($(this).attr('name')).fadeIn();
					}
				});
			
				for (i = 1; i <= $("#tabs li").length; i++) {
					if(myUrlTab == myUrlTabName + i){
						resetTabs();
						$("a[name='"+myUrlTab+"']").attr("id","current");
						$(myUrlTab).fadeIn();
					}
				}
			})()
		</script>
        <script type="text/javascript">
			function resetTabss(){
				$("#deta_bd_content > div").hide();
				$(".deta-bd-tit a").attr("id","");
			}
			
			var myUrl = window.location.href;
			var myUrlTab = myUrl.substring(myUrl.indexOf("#")); 
			var myUrlTabName = myUrlTab.substring(0,4);
			
			(function(){
				$("#deta_bd_content > div").hide();
				$(".deta-bd-tit a:first").attr("id","current");
				$("#deta_bd_content > div:first").fadeIn();
			
				$(".deta-bd-tit a").on("click",function(e) {
					e.preventDefault();
					if ($(this).attr("id") == "current"){
						return       
					}else{             
						resetTabss();
						$(this).attr("id","current");
						$($(this).attr('name')).fadeIn();
					}
				});
			
				for (i = 1; i <= $(".deta-bd-tit a:first").length; i++) {
					if(myUrlTab == myUrlTabName + i){
						resetTabss();
						$("a[name='"+myUrlTab+"']").attr("id","current");
						$(myUrlTab).fadeIn();
					}
				}
			})()
		</script>
        <script type="text/javascript">
        	$(function(){
				
					$(window).scroll(function(){
						$(".index-nav").addClass("w-nav-s")
					})
					
					$(".w-pro-info").height($(".swiper-container").height())
					
					
					$(".group1-pop").height($(".deta-bd-group1 ul li.center a img").height()).css("line-height",$(".deta-bd-group1 ul li.center a img").height()+"px")
					$(".deta-bd-group1 ul li.center .addpro").click(function(){
							if($(this).hasClass("active")){
									$(this).removeClass("active")
								}else{
									$(this).addClass("active")
									$(".deta-bd-group1 ul li.right p a").addClass("active")
									}
						})
					
					$(".swiper2-mask").height($(".swiper2 .swiper-slide img").height())
					if($(window).width()<992){
							$(".w-pro-info").height("auto").css("padding-bottom","20px")
						}else{
							$(".w-pro-info").height($(".swiper-container").height())
							}
					$(".swiper2 .swiper-slide").hover(function(){
							$(".swiper2-mask",this).animate({top:0})
						},function(){
							$(".swiper2-mask",this).animate({top:100+"%"})
							}
						)
					$(".addbefore").click(function(){
							$(".w-pro-car").fadeIn()
							$(".w-pro-info-tabs").hide()
						})
					$(".addafter").click(function(){
						var skuOptions=$(".size[data-property]");
						var name="";
						skuOptions.each(function(i){
							if($(this).find("span.tb-selected").length==0){
								name+="."+$(this).attr("data-property");
							}
						});
						if(name ==""){
							$(".addcart").colorbox({ inline: true, width: "50%" });
						}
							
						})
					$(".w-pro-car em").click(function(){
							$(".w-pro-car").hide()
							$(".w-pro-info-tabs").fadeIn()
						})
						
					var H = $(window).height()
					$(".w-404").height(H)
					var H1 = $(".deta-bd-group1 ul li.center").height()
					$(".deta-bd-group1").height(H1 + 80)
					$(".deta-bd-group1  ul li.left").height($(".deta-bd-group1 ul li.center").height())
					$(".deta-bd-group1  ul li.right").height($(".deta-bd-group1 ul li.center").height())
					window.onresize=function(){
							var H1 = $(".deta-bd-group1 ul li.center").height()
							var H = $(window).height()
							$(".w-404").height(H)
							$(".w-pro-info").height($(".swiper-container").height())
							if($(window).width()<992){
								$(".w-pro-info").height("auto").css("padding-bottom","20px")
							}else{
								$(".w-pro-info").height($(".swiper-container").height())
								}
							$(".group1-pop").height($(".deta-bd-group1 ul li.center a img").height()).css("line-height",$(".deta-bd-group1 ul li.center a img").height()+"px")
							$(".deta-bd-group1").height(H1 + 80)
							$(".deta-bd-group1  ul li.left").height($(".deta-bd-group1 ul li.center").height())
							$(".deta-bd-group1  ul li.right").height($(".deta-bd-group1 ul li.center").height())
						}
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
        <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
<script type="text/javascript" defer>
var skuWholesalePrices = new Array();
<c:if test="${product.status==1}">
<%--产品价格包括批发价--%>
skuWholesalePrices[0]=[1,"${defaultProductSkuPrice}"];
<c:forEach items="${skuWholesalePrices}" var="wholesalePrice" varStatus="varStatus">
	skuWholesalePrices[${varStatus.count}]=["${wholesalePrice.minQuantity}","${wholesalePrice.price}"];
</c:forEach>
<c:if test="${product.productKind==2}">
var jProduct=${jsonProduct};
//alert("length:"+${fn:length(productSkuOptionAndValue.value)});
	$(".size2[data-value]").click(function(){
		if($(this).hasClass("tb-out-of-stock")){return false;};
		if($(this).toggleClass("tb-selected").hasClass("tb-selected")){
			$(this).siblings("span").removeClass("tb-selected").children("a").removeClass("active");
			$(this).children("a").attr("class","active")
		}else{
			$(this).children("a").removeClass("active");
		}
		var selectedOptions=$(".size").find("span.tb-selected[data-value]");
		var selectOptions=$(".size").find("span[data-value]").not(".tb-selected");
		
		var aOptionValueIds=",";
		var skus=jProduct.productSkus;
		
		for(var i=0;i<selectOptions.length;i++){
			var selectOption=$(selectOptions[i]);
			var optionId=selectOption.attr("data-value").split(":")[0];
			var optionValueId=selectOption.attr("data-value").split(":")[1];
			var hasMatchSku=false;
			var sku=null;
			for (k in skus){
				sku=skus[k];
				var skuOptions=sku.skuOptions;
				var hasOptionValue=false;
				for(j in skuOptions){
					var skuOption=skuOptions[j];
					if(selectOption.attr("data-value")==(skuOption.id+":"+skuOption.vid)){
						hasOptionValue=true;
						break;
					}
				}
				if(hasOptionValue){
					hasMatchSku=true;
				}else{
					continue;
				}
				for(var j=0;j<selectedOptions.length;j++){
					var selectedOption=$(selectedOptions[j]);
					var selectedOptionId=selectedOption.attr("data-value").split(":")[0];
					if(optionId!=selectedOptionId){
						hasOptionValue=false;
						for(l in skuOptions){
							var skuOption=skuOptions[l];
							if(selectedOption.attr("data-value")==(skuOption.id+":"+skuOption.vid)){
								hasOptionValue=true;
								break;
							}
						}
						if(!hasOptionValue){
							hasMatchSku=false;
							break;
						}
					}
				}
				if(hasMatchSku){
					break;
				}
			}
			if(hasMatchSku){
				if(aOptionValueIds.indexOf(","+optionValueId+",")==-1){
					aOptionValueIds+=optionValueId+",";
				}
			}
		}
			
		for(var i=0;i<selectOptions.length;i++){
			var option=$(selectOptions.get(i));
			var optionV=option.attr("data-value").split(":");
			if(aOptionValueIds.indexOf(","+optionV[1]+",")==-1){
				option.addClass("tb-out-of-stock");
			}else{
				option.removeClass("tb-out-of-stock");
			}
		}
			
		var selectedSku=null;
		for (i in skus){
			var sku=skus[i];
			var skuOptions=sku.skuOptions;
			var isMatch=false;
			for(j in skuOptions){
				isMatch=false;
				var skuOption=skuOptions[j];
				for(var k=0;k<selectedOptions.length;k++){
					if($(selectedOptions[k]).attr("data-value")==(skuOption.id+":"+skuOption.vid)){
						isMatch=true;
						break;
					}
				}
			}
			if(isMatch){
				selectedSku=sku;
				break;
			}
		}
		var add2CartBtn=$("#add2Cart"+${product.id});
		if(selectedSku){
			//更新图片
			$("#productImgA").find("img").attr("src",__mediaPath+"product/d/"+selectedSku.image);
			//价格
			var skuPrice=selectedSku.salePrice!=null?selectedSku.salePrice:selectedSku.discountPrice!=null?selectedSku.discountPrice:selectedSku.price;
			$("#priceSpan").attr("data-value",skuPrice).html(fnFormatPrice(skuPrice));
			$("#priceSpan").next("span[name='otherCurrency']").attr("defaultvalue",skuPrice);
			if(selectedSku.priceViewType==2||selectedSku.priceViewType==3){
				$("#listPriceSpan").html('<del>'+fnFormatPrice(selectedSku.price)+'</del>').show();
				$("#discountPercent").html("("+selectedSku.discountPercent+"% OFF)");
			}else{
				$("#listPriceSpan,#discountCount").hide();
			}
			$("#productSkuCodeSpan").html(selectedSku.productSkuCode);
			$("#productSkuCode").val(selectedSku.productSkuCode);
			$("#productSkuId").val(selectedSku.productSkuId);
			$("#productWeightSpan").attr("data-value",selectedSku.weight+"").html(selectedSku.weight);
			if(!selectedSku.inventory){
				$("#productStockSpan").html("有现货");
				add2CartBtn.removeClass("stock").removeClass("no-addtocart").removeAttr("disabled").attr("title",__FMT.minicart_addToCart).val(__FMT.minicart_addToCart);
			}else if(selectedSku.inventory.availableQuantity>0){
				$("#productStockSpan").html(selectedSku.inventory.availableQuantity+" 件");
				add2CartBtn.removeClass("stock").removeClass("no-addtocart").removeAttr("disabled").attr("title",__FMT.minicart_addToCart).val(__FMT.minicart_addToCart);
			}else{
				$("#productStockSpan").html(__FMT.outOfStock);
				add2CartBtn.addClass("stock").attr("disabled","disabled").attr("title",__FMT.outOfStock).val(__FMT.outOfStock);
			}
			
			$("#skuWholesalePriceTbl").find("tr").slice(1).remove();
			skuWholesalePrices=selectedSku.wholesalePrices.slice(0,selectedSku.wholesalePrices.length);
			skuWholesalePrices.unshift([1,skuPrice]);
			$("#skuWholesalePriceTbl").append('<tr><td>1-1</td><td>'+fnFormatPrice(skuPrice)+'<span defaultvalue="'+skuPrice+'" name="otherCurrency"></span></td></tr>');
			for(var i=1;i<skuWholesalePrices.length;i++){
				var ws_qty=skuWholesalePrices[i][0]+"+";
				if(i<skuWholesalePrices.length-1){
					ws_qty=skuWholesalePrices[i][0]+"-"+(skuWholesalePrices[i+1][0]-1);
				}
				$("#skuWholesalePriceTbl").append('<tr><td>'+ws_qty+'</td><td>'+fnFormatPrice(skuWholesalePrices[i][1])+'<span defaultvalue="'+skuWholesalePrices[i][1]+'" name="otherCurrency"></span></td></tr>');
			}
			fnChangePrice();
		}else{
			add2CartBtn.removeClass("stock").addClass("no-addtocart").removeAttr("disabled").val(__FMT.minicart_addToCart);
		}
		
		var skuOptions=$(".size2");
		var name="";
		skuOptions.each(function(i){
			if($(this).find("span").length!=0){
				name+=$(this).find("span").text();
			}
		});
		var msg="";
		if(name!=""){
			msg="已选："+name;
			if(selectedSku&&((!selectedSku.inventory)||selectedSku.inventory.availableQuantity>0)){
				msg+='&nbsp;&nbsp;<span class="mark_co">现在有货</span>';
			}
		}
		$("#selectedProdMsg").html(msg);
		return false;
	});
	


function checkAddProductToCart(){
	var skuOptions=$(".size[data-property]");
	var name="";
	skuOptions.each(function(i){
		if($(this).find("span.tb-selected").length==0){
			name+="."+$(this).attr("data-property");
		}
	});
	if(name!=""){
		alert("请选择 "+name);
	}
	return name=="";
}

function checkAddProductToCartSmall(){
	var skuOptions=$("#skuOptions").children("div.tb-prop").find("ul[data-property]");
	var name="";
	skuOptions.each(function(i){
		if($(this).find("li.tb-selected").length==0){
			name+="."+$(this).attr("data-property");
		}
	});
	if(name!=""){
		alert("请选择 "+name);
	}
	return name=="";
}
</c:if>
</c:if>

//图片lightbox,稳定好移到js
function showLightbox(){
	var lightbox=$("#lightbox");
	var left=Math.round((($(document).width()||$(window).width())-lightbox.width())/2);
	var top=Math.round($("html").scrollTop()+($(window).height()-lightbox.height())/2);
	if(top<0)top=0;
	$("#lightboxOverlay").show();
	lightbox.css({ top: top, left: left }).show();
}

$("#lb-close,#lightboxOverlay").click(function(){
	$("#lightbox").hide();
	$("#lightboxOverlay").hide();
});
$("#lb-thumbnailContent").children().click(function(){
	$(this).addClass("selected").siblings().removeClass("selected");
	$("#lb-image").attr("src",__resPath+"/images/img/empty.gif");
	$("#lb-image").attr("src",__resPath+"/images/img/empty.gif").attr("src",$(this).children("img").attr("src").replace("/a/","/v/"));
});
$("#lb-previous").click(function(){
	$("#lb-thumbnailContent").children(".selected").prev().click();
});
$("#lb-next").click(function(){
	$("#lb-thumbnailContent").children(".selected").next().click();
});
$("a[target='popup_larger_image']").click(function(){
	var thumbImgUrl=$("#imgContent").children(".selected").children("img").attr("src");
	$("#lb-thumbnailContent").find("img[src='"+thumbImgUrl+"']").parent().click();
	showLightbox();
	return false;
});
</script>
<script type="text/javascript">
		                          function setShare(title, url) {
		                            //  alert("titile:"+title);
		                            //  alert("url:"+url);
		                             // alert("http://"+window.location.host+"/"+url);
		                              jiathis_config.title = title;
		                              jiathis_config.url = "http://"+window.location.host+"/"+url;
		                          }
		                            var jiathis_config = {}
		                          </script>  
		<script type="text/javascript" >
			var jiathis_config={
				data_track_clickback:false,
				sm:"qzone,tsina,weixin,cqq",
				summary:"",
				shortUrl:true,
				hideMore:false
			}
		</script>
		<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js?uid=2052677" charset="utf-8"></script>
	</body>

</html>