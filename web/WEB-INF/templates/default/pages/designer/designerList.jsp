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
		<%@ include file="../../decorators/include/styles7.jspf"%>
        <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
        <link href="${resPath}/styles/css/designers.css" rel="stylesheet">
        <style>
		.w-nav{
			border-bottom: 1px #000000 solid;
		}
		</style>

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    	<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>

	<body>
        <!--[if lt IE 8]>
       <p class="browserupgrade">你正在使用一个 <strong>过时的</strong> 浏览器. 请 <a href="http://browsehappy.com/">提高您的浏览器</a> 以提高您的经验.</p>
       <![endif]-->
		<!--登陆注册-->
		<%@ include file="../../decorators/include/headerNew.jspf"%>
        <!--end of 导航-->
        <div class="w-designers">
            <div class="w-designers-hd">
                <div>
                	<a href="/designerList.html" <c:if test="${param.initials==null || param.initials==''}">class="active num"</c:if>>A-Z</a>
                	<a href="/designer/initialsSelect.html?initials=A" <c:if test="${param.initials=='A'}">class="active num"</c:if>>A</a>
                	<a href="/designer/initialsSelect.html?initials=B" <c:if test="${param.initials=='B'}">class="active num"</c:if>>B</a>
                	<a href="/designer/initialsSelect.html?initials=C" <c:if test="${param.initials=='C'}">class="active num"</c:if>>C</a>
                	<a href="/designer/initialsSelect.html?initials=D" <c:if test="${param.initials=='D'}">class="active num"</c:if>>D</a>
                	<a href="/designer/initialsSelect.html?initials=E" <c:if test="${param.initials=='E'}">class="active num"</c:if>>E</a>
                	<a href="/designer/initialsSelect.html?initials=F" <c:if test="${param.initials=='F'}">class="active num"</c:if>>F</a>
                	<a href="/designer/initialsSelect.html?initials=G" <c:if test="${param.initials=='G'}">class="active num"</c:if>>G</a>
                	<a href="/designer/initialsSelect.html?initials=H" <c:if test="${param.initials=='H'}">class="active num"</c:if>>H</a>
                	<a href="/designer/initialsSelect.html?initials=I" <c:if test="${param.initials=='I'}">class="active num"</c:if>>I</a>
                	<a href="/designer/initialsSelect.html?initials=J" <c:if test="${param.initials=='J'}">class="active num"</c:if>>J</a>
                	<a href="/designer/initialsSelect.html?initials=K" <c:if test="${param.initials=='K'}">class="active num"</c:if>>K</a>
                	<a href="/designer/initialsSelect.html?initials=L" <c:if test="${param.initials=='L'}">class="active num"</c:if>>L</a>
                	<a href="/designer/initialsSelect.html?initials=M" <c:if test="${param.initials=='M'}">class="active num"</c:if>>M</a>
                	<a href="/designer/initialsSelect.html?initials=N" <c:if test="${param.initials=='N'}">class="active num"</c:if>>N</a>
                	<a href="/designer/initialsSelect.html?initials=O" <c:if test="${param.initials=='O'}">class="active num"</c:if>>O</a>
                	<a href="/designer/initialsSelect.html?initials=P" <c:if test="${param.initials=='P'}">class="active num"</c:if>>P</a>
                	<a href="/designer/initialsSelect.html?initials=Q" <c:if test="${param.initials=='Q'}">class="active num"</c:if>>Q</a>
                	<a href="/designer/initialsSelect.html?initials=R" <c:if test="${param.initials=='R'}">class="active num"</c:if>>R</a>
                	<a href="/designer/initialsSelect.html?initials=S" <c:if test="${param.initials=='S'}">class="active num"</c:if>>S</a>
                	<a href="/designer/initialsSelect.html?initials=T" <c:if test="${param.initials=='T'}">class="active num"</c:if>>T</a>
                	<a href="/designer/initialsSelect.html?initials=U" <c:if test="${param.initials=='U'}">class="active num"</c:if>>U</a>
                	<a href="/designer/initialsSelect.html?initials=V" <c:if test="${param.initials=='V'}">class="active num"</c:if>>V</a>
                	<a href="/designer/initialsSelect.html?initials=W" <c:if test="${param.initials=='W'}">class="active num"</c:if>>W</a>
                	<a href="/designer/initialsSelect.html?initials=X" <c:if test="${param.initials=='X'}">class="active num"</c:if>>X</a>
                	<a href="/designer/initialsSelect.html?initials=Y" <c:if test="${param.initials=='Y'}">class="active num"</c:if>>Y</a>
                	<a href="/designer/initialsSelect.html?initials=Z" <c:if test="${param.initials=='Z'}">class="active num"</c:if>>Z</a>
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
						                    <img src="${mediaPath}/other/${brand.icon}" alt="img11" class="w-mem-imgo" />
						                    <%--<img src="${mediaPath}/other/${brand.logo}" alt="img11" class="w-mem-imgt" />
						                    --%><figcaption>
						                        <div class="w-mem-bg">
						                        </div>
						                        <p><c:out value="${fn:substring(brand.story, 0, 230)}......" /></p>
						                    </figcaption>
						                </figure>
						            </div>
						       </a>
			              </c:forEach>
			              </div><!-- w-mem-list2 end-->
			  	</c:forEach>
        	</c:if>
        </div><!--w-designers-->
		<%@ include file="../../decorators/include/footerNew.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
        <script type="text/javascript">
		
		//设计师锚点跳转
        $(function () {
            $(".w-designers-hd a").on("click", function () {
                var catid = $(this).attr("catid");
                $(this).addClass("active").siblings().removeClass("active")
                var top = $(".designer_nav_title[catid='" + catid + "']").offset().top;
                if ($(window).width() > 992) {
                    $(window).scrollTop(top - 195);
                } else {
                    $(window).scrollTop(top - 50);
                }
            });
        });

        //改变数字锚点
        $(function () {
            if ($(window).width() > 980) {
                $(".w-designers-hd a:first-child").html("A-Z")
            } else {
                $(".w-designers-hd a:first-child").html("A<br>|<br>Z")
            }
            window.onresize = function () {
                if ($(window).width() > 980) {
                    $(".w-designers-hd a:first-child").html("A-Z")
                } else {
                    $(".w-designers-hd a:first-child").html("A<br>|<br>Z")
                }
            }
        })


    </script>
	</body>

</html>