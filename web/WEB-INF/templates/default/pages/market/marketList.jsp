<!DOCTYPE html>
<%@ page pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<%@ include file="../../decorators/include/meta.jspf"%>
		<%@ include file="../../decorators/include/styles3.jspf"%>
		<%@ include file="../../decorators/include/styles4.jspf"%>
		<%@ include file="../../decorators/include/javascripts3.jspf"%>
		<!-- Bootstrap -->
		<link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
		<link href="${resPath}/styles/css/bootstrap.css" rel="stylesheet">
		<link href="${resPath}/styles/css/swiper.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/animate.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/index.css" rel="stylesheet">
        <link href="${resPath}/styles/css/shooping-list.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
	</head>

	<body>
	
		<div class="w-shooping-list">
			<div class="w-shooping-list-sort">
            	<ul class="row">
                	<li>
                    	<div class="sort-tit">排序方式<i class="fa fa-caret-down"></i></div>
                        <p><a href="?sort=new" class="active">最新上架</a></p>
                        <p><a href="?sort=up">价格由低到高</a></p>
                        <p><a href="?sort=down">价格由高到低</a></p>
                    </li>
                    
                    <li>
                        <p><a href="/main_catalog.html" class="active">所有产品</a></p> 
                        <p><a href="/wen/meizhuang/coat_catalog.html"><i class="fa fa-venus"></i>女性</a></p>
                        <p><a href="/man/Mmeizhuang/Mcoat_catalog.html"><i class="fa fa-mars"></i>男性</a></p>
                    </li>
                </ul>
                <div class="sort-btn">
                	<i class="fa fa-chevron-right"></i>
                    <p>分<br>类<br>筛<br>选</p>
                </div>
            </div>
            <div class="w-shooping-list-box">
            <ul class="row">
				<c:forEach items="${productList}" var="product" varStatus="varStatus">
					<li><a href="${ctxPath}/product/${product.productId}.html"><img src="${mediaPath}product/v/${product.defaultProductSku.image}"></a>
                        <div class="bd-list-tit"><span>SALE</span><a href="${ctxPath}/product/${product.productId}.html">${product.productName}</a></div>
                        <p><span>${product.brand.designer}</span></p>
                        <p><em>${product.brand.brandName}</em></p>
                        <p><b>
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
									<system:CurrencyForRate value="${defaultProductSkuPrice}" />
									<system:CurrencyForRate value="${product.defaultProductSku.price}" />
							</c:when>
							<c:otherwise>
									<system:CurrencyForRate value="${defaultProductSkuPrice}" />
							</c:otherwise>
						</c:choose>
		                </b>
		                </p>
                        <p><a href="#"><i class="fa fa-share-alt"></i> 分享</a><a href="#"><i class="fa fa-heart-o"></i> 加入收藏</a><a href="#"><i class="fa fa-cart-plus"></i> 加入购物车</a></p>
                    </li>
				</c:forEach>
            </ul>
            </div>
        </div>

		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script>
			 //				alert(document.documentElement.clientWidth+'+'+document.documentElement.clientHeight)
			var swiper = new Swiper('.swiper-container', {
				nextButton: '.swiper-page-next',
				prevButton: '.swiper-page-prev',
				paginationClickable: true,
				spaceBetween: 0,
				mousewheelControl: false,
				//							autoplay: 5000,
				speed: 500,
				onInit: function(swiper) {
					swiperAnimateCache(swiper);
					swiperAnimate(swiper);
				},
				onSlideChangeEnd: function(swiper) {
					swiperAnimate(swiper);
				},
				onTransitionEnd: function(swiper) {
					swiperAnimate(swiper);
				}
			});
		</script>
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
							$(".w-shooping-list-box").css({"margin-left":"60px","width":$(window).width()-60})
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
								$(".sort-btn").click(function(){
										if($(this).hasClass("active")){
												$(".w-shooping-list-sort ul.row").css({height:"0"})
												$(this).removeClass("active")
											}else{
												$(".w-shooping-list-sort ul.row").css({height:"auto"})
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
							}else{
								$(".sort-btn p").html("分<br>类<br>筛<br>选")
								$(".w-shooping-list-box").css({"margin-left":"60px","width":$(window).width()-60})
								}
						}
				})
        </script>
	</body>

</html>