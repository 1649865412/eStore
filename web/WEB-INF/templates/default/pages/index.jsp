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
		<meta name="uyan_auth" content="8527913b0f" />
		<title>四方街</title>
		<script type="text/javascript"
			src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript"
			src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
		<!-- Bootstrap -->
		<%@ include file="../decorators/include/styles7.jspf"%>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	</head>

	<body>
		<%@ include file="../decorators/include/headerNew.jspf"%>

		<div class="w-slide jumbotron">
			<div class="swiper-container">
				<div class="swiper-page-right">
					<div class="swiper-page-next">
						<i class="fa fa-angle-right"></i>
					</div>
				</div>
				<div class="swiper-page-left">
					<div class="swiper-page-prev">
						<i class="fa fa-angle-left"></i>
					</div>
				</div>

				<div class="swiper-wrapper">
					<%--首页轮播图，目前数量为4，如需改动数量可在此修改 --%>
					<content:showAdNew adPositionType="mainadNew1" />

					<content:showAdNew adPositionType="mainadNew2" />

					<content:showAdNew adPositionType="mainadNew3" />

					<content:showAdNew adPositionType="mainadNew4" />
					
					<content:showAdNew adPositionType="mainadNew5" />

				</div>
			</div>
		</div>
		<div class="w-banner jumbotron">
			<content:showAdNew adPositionType="mainsadNew1" />
		</div>
		<div class="w-bannert jumbotron ">
			<content:showAdNew adPositionType="mainsadNew2" />
		</div>

		<div class="w-lf jumbotron clearfix">
			<div class="w-lf-con">
				<content:showAdNew adPositionType="mainsadNew3" />
				<div class="w-lf-cen">
					<div class="w-lf-br"></div>
				</div>
				<content:showAdNew adPositionType="mainsadNew4" />
			</div>
		</div>

		<div class="w-mem">
			<div class="w-mem-hse"></div>
			<div class="container">
				<div class="row">

					<div class="w-mem-hr">
						<div class="w-mem-hrt">
							最新入驻设计师
						</div>
					</div>
					<div class="w-mem-list">
						<c:forEach items="${brandList}" var="brand" varStatus="varStatus"
							end="5">
							
							<div class="w-mem-con">
								<a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}">
								<span class="w-mem-cn">${brand.designer}</span>
								<span class="w-mem-en">${brand.brandName}</span>
								<figure class="w-mem-milo">
	
									<img src="${mediaPath}other/${brand.icon}" alt="img11" class="w-mem-imgo" />
									
									<figcaption>
										<div class="w-mem-bg">
										</div>
										<p><c:out value="${fn:substring(brand.story, 0, 230)}......" /></p>
	
									</figcaption>
								</figure>
								</a>
							</div>

						</c:forEach>

					</div>
				</div>
			</div>
		</div>
		<%@ include file="../decorators/include/footerNew.jspf"%>

		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>

		<script type="text/javascript">
		var swiper = new Swiper('.swiper-container', {
			nextButton : '.swiper-page-next',
			prevButton : '.swiper-page-prev',
			paginationClickable : true,
			spaceBetween : 0,
			mousewheelControl : false,
			loop : true,
			autoplay: 3000,
			speed : 500,
			onInit : function(swiper) {
				swiperAnimateCache(swiper);
				swiperAnimate(swiper);
			},
			onSlideChangeEnd : function(swiper) {
				swiperAnimate(swiper);
			},
			onTransitionEnd : function(swiper) {
				swiperAnimate(swiper);
			}
		});
		</script>



	</body>

</html>