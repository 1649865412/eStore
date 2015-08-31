<!DOCTYPE html>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<!-- Bootstrap -->
		<link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
		<link href="${resPath}/styles/css/bootstrap.css" rel="stylesheet">
		<link href="${resPath}/styles/css/swiper.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/animate.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/index.css" rel="stylesheet">
        <link href="${resPath}/styles/css/weekly.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
	</head>

	<body>

		<div class="w-weekly">
        	<div class="w-weekly-hd">
            	<div class="weekly-hd-info">
                	<content:showAdNew adPositionType="weeklyTitle" />
                </div>
            </div>
            
            
            <div class="w-weekly-bd">
            	<div class="bd-tit">${tempCatalog.weekOnNewTitle}</div>
                <div class="bd-tit1">${tempCatalog.weekOnNewContent}</div>
                <div class="bd-list">
                	<ul class="row">
                		<jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
							<jsp:param name="typeName" value="feature_product" />
							<jsp:param name="firstResult" value="0" />
							<jsp:param name="maxResults" value="8" />
							<jsp:param name="template" value="sales/include/recommendProduct4MainPage10" />
							<jsp:param name="doAction" value="defaultAction" />
							<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
						</jsp:include>
                    </ul>
                    <div class="more"><a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${tempCatalog.brandId}">点击查看更多该品牌产品</a></div>
                </div>
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
				
					var H = $(window).height()
					$(".w-weekly-hd").height(H).css("overflow","hidden")
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
					window.onresize=function(){
							var H = $(window).height()
							$(".w-weekly-hd").height(H)
							var MH = $(".weekly-hd-info").height()
							$(".weekly-hd-info").css("margin-top",-MH/2 - 30)
						}
				})
        </script>
	</body>

</html>