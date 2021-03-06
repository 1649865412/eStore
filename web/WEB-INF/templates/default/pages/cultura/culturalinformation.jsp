<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<!--文化资讯列表页-->
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		<link href="${resPath}/styles/font-awesome.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/index.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/list.css" />
		<link href="${resPath}/styles/css/animate.min.css" rel="stylesheet" />
		<script src="${ctxPath}/scripts/jquery/js/modernizr.custom.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/snap.svg-min.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>
	<body style="overflow:hidden">
		<div class="pt-loading">
	        <div class="pt-page">
	            <div class="LoaderProgres"><span></span></div>
	        </div>
	<%@ include file="../../decorators/include/headerNew.jspf"%>
		<div class="w-container">
	        <button id="menu-toggle" class="menu-toggle"><span>Menu</span></button>
	        <div id="theSidebar" class="sidebar">
	            <!--xuanyang-->
	            <div class="related">
					<a href="/culturalinformation/index.html" class="w-list-btn <c:if test='${param.type == null || param.type ==""}'>on</c:if>" date-type="all" id="t1">全部</a>
					<a href="/culturalinformation/index.html?type=0" class="w-list-btn <c:if test='${param.type == 0}'>on</c:if>" date-type="all" id="t2">时尚前沿</a>
					<a href="/culturalinformation/index.html?type=1" class="w-list-btn <c:if test='${param.type == 1}'>on</c:if>" date-type="all" id="t3">思维对话</a>
					<a href="/culturalinformation/index.html?type=2" class="w-list-btn <c:if test='${param.type == 2}'>on</c:if>" date-type="all" id="t4">品牌播报</a>
					<a href="/culturalinformation/index.html?type=3" class="w-list-btn <c:if test='${param.type == 3}'>on</c:if>" date-type="all" id="t5">聚焦四方</a>
					<%--<a href="/culturalinformation/index.html?type=4" class="w-list-btn <c:if test='${param.type == 4}'>on</c:if>" date-type="all" id="t6">四方志</a>--%>
				</div>
	        </div>
	        <div id="theGrid" class="main" style="position: relative; height: 975.812px;margin-top: 0px;">
	            <div class="mobile_menu">
                    <div><a href="/culturalinformation/index.html" class="w-list-btn on" date-type="all" id="t1">全部</a></div>
                    <div>
                        <a href="/culturalinformation/index.html?type=0" class="w-list-btn" date-type="all" id="t2">时尚前沿</a>
                    </div>
                    <div>
                        <a href="/culturalinformation/index.html?type=1" class="w-list-btn" date-type="all" id="t3">思维对话</a>
                    </div>
                    <div>
                        <a href="/culturalinformation/index.html?type=2" class="w-list-btn" date-type="all" id="t4">品牌播报</a>
                    </div>
                    <div>
                        <a href="/culturalinformation/index.html?type=3" class="w-list-btn" date-type="all" id="t5">聚焦四方</a>
                    </div>
                    <%--<div><a href="/culturalinformation/index.html?type=4" class="w-list-btn" date-type="all" id="t6">四方志</a></div>
                --%></div>
	
	            <section class="grid">
	            	<c:forEach items="${culturalinformationList}" var="culList" varStatus="i">
		                <c:if test="${culList.type == 0}"><div class="grid__item w-g-h"></c:if>
						<c:if test="${culList.type == 1}"><div class="grid__item w-g-l"></c:if>
						<c:if test="${culList.type == 2}"><div class="grid__item w-g-r"></c:if>
						<c:if test="${culList.type == 3}"><div class="grid__item w-g-x"></c:if>
						<c:if test="${culList.type == 4}"><div class="grid__item w-g-s"></c:if>
		                    <a onClick="getDetail('${culList.culturalInformationId}')" class="grid__item_a" data-content="contentArticle" data-item="content__item" data-close="close-button-list" href="/culturalinformation/culturaTemplate.html?culId=${culList.culturalInformationId}">
		                        <div class="w-g-header">
		                            <b></b>
		                            <c:if test="${culList.type == 0}">时尚前沿</c:if>
									<c:if test="${culList.type == 1}">思维对话</c:if>
									<c:if test="${culList.type == 2}">品牌播报</c:if>
									<c:if test="${culList.type == 3}">聚焦四方</c:if>
									<c:if test="${culList.type == 4}">四方志</c:if>
		                             | <fmt:formatDate value="${culList.releaseTime}" type="date" dateStyle="long"/>
		                        </div>
		                        <img src="${mediaPath}other/${culList.logoImg}"/>
		                        <h2 class="title title--preview">${culList.title}</h2>
		                        <p class="w-content">
		                            ${culList.content}
		                        </p>
		                    </a>
		                    <div class="w-g-pyf">
		                       <span>
		                        <!-- JiaThis Button BEGIN -->
		                       <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
		                       
		                        <!-- JiaThis Button END -->
		                        </span> | <span>评论数 (${culList.commentNumber})</span> | <span>阅读数 (${culList.readNumber})</span>
		                        
		                    </div>
		                    <div class="loader"></div>
		                    <div class="meta meta--preview">
		                        ${culList.metaKeywork}
		                    </div>
		
		                </div>
		                <!--End-->
	                </c:forEach>
	            </section>
	            <div class="w-paget">
		            <ul class="w_paginations">
		            <c:if test="${pageNum - 1 != 0}">
		            	<li><a href="/culturalinformation/index.html?type=${param.type }&page=${pageNum - 1 }" title="Previous"><i class="fa fa-caret-left"></i></a></li>
		            </c:if>
		            <li style="padding-top:1px;">
		            <c:if test="${pageNum - 2 > 0}">
		            	<a href="/culturalinformation/index.html?type=${param.type }&page=1">1</a>
		            	...
		            </c:if>
		            	<a href="javascript:;" class="paget_current">${pageNum }</a>
		            <c:if test="${pageNum + 1 <= totalPage}">
		            	<a href="/culturalinformation/index.html?type=${param.type }&page=${pageNum + 1 }">${pageNum + 1 }</a>
		            </c:if>
		            <c:if test="${pageNum + 2 < totalPage}">
		            	<a href="/culturalinformation/index.html?type=${param.type }&page=${pageNum + 2 }">${pageNum + 2 }</a> 
		            </c:if>
		            <c:if test="${totalPage >4 && pageNum + 3 < totalPage}">
		            	...
		            </c:if>
		            <c:if test="${pageNum + 3 <= totalPage}">
			             <a href="/culturalinformation/index.html?type=${param.type }&page=${totalPage}">${totalPage }</a>
		             </c:if>
		             </li>
		             <c:if test="${pageNum + 1 <= totalPage}">
		             	<li><a href="/culturalinformation/index.html?type=${param.type }&page=${pageNum + 1 }"" title="Next"><i class="fa fa-caret-right"></i></a></li>
		             </c:if>
		             </ul>
		         </div>
	            
                <!--/分页-->
	        </div>
	      </div>
	              <!-- /w-container -->
	     <%@ include file="../../decorators/include/footerNew.jspf"%>
	     </div>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/classie.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/list.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
	
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
	
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/tmasonry.js"></script>
	    <!--<script type="text/javascript" src="js/jquery.masonry.min.js"></script>-->
	    
	    <script type="text/javascript">
	        $(function () {
	            //2015-11-11 宣扬修改 页面加载动画 每次跳转页面自动加载
	            $('body').css("overflow", "auto");
	            document.documentElement.scrollTop = document.body.scrollTop = 0;
	            $('body').css("overflow", "hidden");
	            setTimeout(function () {
	                $('.pt-page').addClass('pt-page-moveToTopEasing');
	                $('body').css("overflow", "auto");
	            }, 3000);
	            //END 页面加载特效
	            var type = getvl("type");
	            if (type != "")
	                $(".w-list-btn").removeClass("on");
	            switch (type) {
	                case "0":
	                    $("#t2").addClass("on");
	                    break;
	                case "1":
	                    $("#t3").addClass("on");
	                    break;
	                case "2":
	                    $("#t4").addClass("on");
	                    break;
	                case "3":
	                    $("#t5").addClass("on");
	                    break;
	                case "4":
	                    $("#t6").addClass("on");
	                    break;
	
	            }
	            $(window).scroll(function () {
	                //滚动浏览器导航显示操作
	                $(".w-nav").addClass("w-nav-s");
	            })
	            $(window).load(function () {
	                var container = document.querySelector('#theGrid');
	                var msnry = new Masonry(container, {
	                    itemSelector: '.grid__item',
	                    columnWidth: 0
	                });
	                //左侧导航点击事件
	                $(".w-list-btn").bind('click', function (event) {
	                    var showclass = $(this).attr('date-type');
	                    $(this).addClass("on").siblings().removeClass("on");
	                });
	
	            });
	        });
	        //获取浏览器传入的值
	        function getvl(name) {
	            var reg = new RegExp("(^|\\?|&)" + name + "=([^&]*)(\\s|&|$)", "i");
	            if (reg.test(location.href)) return unescape(RegExp.$2.replace(/\+/g, " "));
	            return "";
	        };
	    </script>
	    <script type="text/javascript">
	        var jiathis_config = {
	            summary: "",
	            shortUrl: true,
	            hideMore: false
	        }
	    </script>
	    <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
	
	    <%--<script type="text/javascript">
	        $(function () {
				$(".grid__item_a").click(function(){
				$(".w-paget").css("z-index","-1");
	            });
	            //$(".w-paget").css("top",$("#theGrid .grid").outerHeight()-60);
	            $(window).load(function () {
	                //$("#close_button_a").click(function () {
	                //    $(this).removeClass("close-button--show");
	                //    $(".content__item_b").removeClass("content__item--show");
	                //    $(".content1").removeClass("content--show");
	                //})
	                var container = document.querySelector('#theGrid');
	                var msnry = new Masonry(container, {
	                    itemSelector: '.grid__item',
	                    columnWidth: 0
	                });
	                //xuanyang
	                $(".w-list-btn").bind('click', function (event) {
	                    var showclass = $(this).attr('date-type');
	                    $(this).addClass("on").siblings().removeClass("on");
	                    $("#theGrid .grid__item").each(function () {
	                        if (!$(this).hasClass(showclass) && showclass != 'all') {
	                            $(this).hide();
	                        } else {
	                            $(this).show();
								$(".w-paget").css("z-index","1300");
	                        }
	                    });
	                    //$(document.body).animate({ 'scrollTop': 0 }, 1000);
	                    msnry.layout();
	                });
	            });
	        });
	    </script>
	--%></body>
</html>