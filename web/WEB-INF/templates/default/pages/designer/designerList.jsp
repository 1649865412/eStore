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
		<link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
		<link href="${resPath}/styles/css/bootstrap.css" rel="stylesheet">
		<link href="${resPath}/styles/css/swiper.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/animate.min.css" rel="stylesheet">
		<link href="${resPath}/styles/css/index.css" rel="stylesheet">
        <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	</head>

	<body>
        <div class="designer_nav">
        	<div class="designer_nav_con c"><a class="current" href="/designerList.html">A-Z</a><a href="/designer/initialsSelect.html?initials=A">A</a><a href="/designer/initialsSelect.html?initials=B">B</a><a href="/designer/initialsSelect.html?initials=C">C</a><a href="/designer/initialsSelect.html?initials=D">D</a><a href="/designer/initialsSelect.html?initials=E">E</a><a href="/designer/initialsSelect.html?initials=F">F</a><a href="/designer/initialsSelect.html?initials=G">G</a><a href="/designer/initialsSelect.html?initials=H">H</a><a href="/designer/initialsSelect.html?initials=I">I</a><a href="/designer/initialsSelect.html?initials=J">J</a><a href="/designer/initialsSelect.html?initials=K">K</a><a href="/designer/initialsSelect.html?initials=L">L</a><a href="/designer/initialsSelect.html?initials=M">M</a><a href="/designer/initialsSelect.html?initials=N">N</a><a href="/designer/initialsSelect.html?initials=O">O</a><a href="/designer/initialsSelect.html?initials=P">P</a><a href="/designer/initialsSelect.html?initials=Q">Q</a><a href="/designer/initialsSelect.html?initials=R">R</a><a href="/designer/initialsSelect.html?initials=S">S</a><a href="/designer/initialsSelect.html?initials=T">T</a><a href="/designer/initialsSelect.html?initials=U">U</a><a href="/designer/initialsSelect.html?initials=V">V</a><a href="/designer/initialsSelect.html?initials=W">W</a><a href="/designer/initialsSelect.html?initials=X">X</a><a href="/designer/initialsSelect.html?initials=Y">Y</a><a href="/designer/initialsSelect.html?initials=Z">Z</a>
        	</div>
        </div>
        
        	
        	<c:if test="${empty mapResult}">
			           <h2 class="designer_nav_title" style="padding-top:180px;">暂无设计师</h1>
		  </c:if>
		  
		  <c:if test="${!empty mapResult}">
        			   <c:forEach items="${mapResult}" var="map">
			           <h3 class="designer_nav_title" style="padding-top:180px;">${map.key}</h3>
			           	<div class="w-mem-list w-mem-list2 c">
			              <c:forEach items="${map.value}" var="brand">
			              	<a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}">
						            <div class="w-mem-con">
						                <span class="w-mem-cn">${brand.designer}</span>
						                <span class="w-mem-en">${brand.brandName}</span>
						                <figure class="w-mem-milo">
						                    <img src="${mediaPath}/other/${brand.logo}" alt="img11" class="w-mem-imgo" />
						                    <img src="${mediaPath}/other/${brand.icon}" alt="img11" class="w-mem-imgt" />
						                    <figcaption>
						                        <div class="w-mem-bg">
						                        </div>
						                        <p>${brand.quotation}</p>
						                    </figcaption>
						                </figure>
						            </div>
						       </a>
			              </c:forEach>
			              </div><!-- w-mem-list2 end-->
			  </c:forEach>
        		
        	</c:if>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
	</body>

</html>