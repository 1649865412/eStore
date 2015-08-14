<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<!--文化资讯列表页-->
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/index.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/list.css" />
		<link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
		<link href="${resPath}/styles/css/animate.min.css" rel="stylesheet">
        <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
		<script src="${ctxPath}/scripts/jquery/js/modernizr.custom.js"></script>
	</head>
	<body>
			<div class="designer_show">
            <div class="swiper-wrapper">
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)">
                    <a class="designer_video" href="#"></a>
                </div>
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)"></div>
                <div class="swiper-slide" style="background-image:url(img/authors/1.jpg)"></div>
            </div>
            <div class="designer_pagination"></div>
            <a class="designer_enlarge" href="#"></a>
            <a class="designer_close" href="javascript;"></a>
        </div><!--designer_show end-->
        <div class="designer_box c">
        	<div class="designer_con">
            	<div class="li1"><img src="${brand.icon}" width="270" height="270"/></div>
                <div class="li2 title-font">${brand.brandName}</div>
                <div class="li3 c"><img src="img/authors/12.jpg" width="107" height="40"><a href="#"><i></i>分享</a></div>
                <div class="li4">${brand.story}</div>
            </div>
        </div>
        <div class="title"><div><span class="title-font">设计师代表作品</span></div></div>
        

        <!--此处需要从后台传过推荐产品6个productRecommendId-->
        <ul class="product list-unstyled c">
        <c:forEach items="${recommendProduct}" var="product" >
           <li>
            	<div class="li1"><a href="#"><img class="imgo" src="img/authors/10.jpg" width="100%"/><img class="imgt" src="img/authors/13.jpg" width="100%"/></a></div>
                <div class="li2"><div class="cutstr2"><a href="#" title="${product.productName}">${product.productName}</a></div><span>&nbsp;</span></div>
                <p class="li3">${product.brand.designer}</p>
                <p class="li4">${product.brand.brandName}</p>
                <div class="li5"><span class="s1">￥ ${product.salePrice}</span><span class="s2">￥  ${product.price}</span></div>
                <div class="join_box">
                	<div class="j1">尺码</div>
                    <div class="j2"><span class="current">XS</span><span>S</span><span>M</span><span>L</span></div>
                    <a class="j3" href="#">加入购物车</a>
                </div>
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
                    <div class="dialogue_right"><img src="${culturalInformation.logoImg}" width="100%;"/></div>
                    <div class="dialogue_left">
                    	<div class="dialogue_left_bottom"><i class="line"></i>
                    ${brand.quotation}</div>
                    	<img src=" ${brand.pic}" width="100%;"/>
                    </div><!--dialogue_left end-->
               	</div>
            </div>
        </div><!--dialogue_box end-->
        <div class="title title2"><div><span class="title-font">设计师最新动态</span></div></div>
        <ul class="designer_news list-unstyled c">
           <c:forEach items="${brandDynamicList}" var="brandDynamic" >
        	<li>
            	<div class="designer_news_img" style="background-image:url(${brandDynamic.img})"><a href="#" target="_blank"></a></div>
                <div class="designer_news_info">
                    <div class="li1"><span  
                    
                     <c:if test="${brandDynamic.colorType==1}">class='xinlang'</c:if>
                     
                     >${brandDynamic.resource}</span></div>
                    <div class="li2">${brandDynamic.resourceTime}</div>
                    <div class="li3 cutstr3">
                        <div title="${brandDynamicList.content}">${brandDynamic.content}</div>		
                    </div>
                   	<a class="li4" href="#" target="_blank">点击访问来源日<i></i></a>
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
	</body>
</html>