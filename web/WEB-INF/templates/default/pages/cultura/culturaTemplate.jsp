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
		
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/normalize.css" />
	    <link rel="stylesheet" type="text/css" href="${resPath}/styles/css/bootstrap.css" />
	    <link rel="stylesheet" type="text/css" href="${resPath}/styles/css/index.css" />
	    <link rel="stylesheet" type="text/css" href="${resPath}/styles/css/list.css" />
	    <link href="${resPath}/styles/css/animate.min.css" rel="stylesheet" />
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>
	<body style="overflow:hidden">
	<%@ include file="../../decorators/include/headerNew.jspf"%>
	<div class="pt-loading" style="position:initial">
        <div class="pt-page">
            <div class="LoaderProgres"><span></span></div>
        </div>
		<div class="w-container">
			<button id="menu-toggle" class="menu-toggle"><span>Menu</span></button>
			<div id="theSidebar" class="sidebar" >
				<div class="related">
					<a href="/culturalinformation/index.html" class="w-list-btn <c:if test='${param.type == null || param.type ==""}'>on</c:if>" date-type="all" id="t1">全部</a>
					<a href="/culturalinformation/index.html?type=0" class="w-list-btn <c:if test='${param.type == 0}'>on</c:if>" date-type="all" id="t2">时尚前沿</a>
					<a href="/culturalinformation/index.html?type=1" class="w-list-btn <c:if test='${param.type == 1}'>on</c:if>" date-type="all" id="t3">思维对话</a>
					<a href="/culturalinformation/index.html?type=2" class="w-list-btn <c:if test='${param.type == 2}'>on</c:if>" date-type="all" id="t4">品牌播报</a>
					<a href="/culturalinformation/index.html?type=3" class="w-list-btn <c:if test='${param.type == 3}'>on</c:if>" date-type="all" id="t5">聚焦四方</a>
					<%--<a href="/culturalinformation/index.html?type=4" class="w-list-btn <c:if test='${param.type == 4}'>on</c:if>" date-type="all" id="t6">四方志</a>--%>
				</div>
			</div>
			<div id="theGrid" class="main">
				<a href="/culturalinformation/index.html" class="close-button-list close-button--show" id="close_button_a">
                    <i class="fa fa-close"></i><span>Close</span>
                </a>
	            
	            <section class="content contentArticle content--show">
                <div class="scroll-wrap">
                	<div class="mobile_menu" style="padding-top: 20px;">
                            <div><a href="/culturalinformation/index.html" class="w-list-btn on" date-type="all" id="t1">全部</a></div>
                            <div>
                                <a href="/culturalinformation/index.html?type=0" class="w-list-btn" date-type="all" id="t2">时尚前沿</a>
                            </div>
                            <div>
                                <a href="/culturalinformation/index.html?type=1" class="w-list-btn" date-type="all" id="t3">思维对话</a>
                            </div>
                            <div>
                                <a href="/culturalinformation/index.html?type=2" class="w-list-btn" date-type="all" id="t4">行业动态</a>
                            </div>
                            <div>
                                <a href="/culturalinformation/index.html?type=3" class="w-list-btn" date-type="all" id="t5">线下活动</a>
                            </div>
                            <%--<div><a href="/culturalinformation/index.html?type=4" class="w-list-btn" date-type="all" id="t6">四方志</a></div>
                        --%></div>
                    <article class="content__item w-g-h content__item--show">
                        <div class="w-c-nrb">
                            <span class="category category--full">
                            	<c:if test="${culturalInformation.type == 0}">时尚前沿</c:if>
                            	<c:if test="${culturalInformation.type == 1}">思维对话</c:if>
                            	<c:if test="${culturalInformation.type == 2}">品牌播报</c:if>
                            	<c:if test="${culturalInformation.type == 3}">聚焦四方</c:if>
                            	<%--<c:if test="${culturalInformation.type == 4}">四方志</c:if>--%>
                            </span>
                            <c:if test="${culturalInformation.type == 0}"><h2 class="title title--full" style="color:#fbbd6a"></c:if>
                            <c:if test="${culturalInformation.type == 1}"><h2 class="title title--full" style="color:#a6d5ab"></c:if>
                            <c:if test="${culturalInformation.type == 2}"><h2 class="title title--full" style="color:#abdce3"></c:if>
                            <c:if test="${culturalInformation.type == 3}"><h2 class="title title--full" style="color:#fb6e67"></c:if>
                                ${culturalInformation.title}
                            </h2>
                            <div class="meta meta--full">
                                <span class="meta__author">来源：${culturalInformation.writer}</span>
                                <span class="meta__date"><fmt:formatDate value="${culturalInformation.createTime}" type="date" dateStyle="long"/></span>
                                <span class="meta__reading-time">
                                 
                                    <!-- JiaThis Button BEGIN -->
                                   <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
                                    <!-- JiaThis Button END -->
                                  | 阅读数 （${culturalInformation.readNumber}）
                              </span>
                            </div>
                            <div class="article_culture_detail">
                              ${culturalInformation.textIntroduction}
                          </div><!--article_culture_detail-->
                            <div class="w-c-np">
                            	<c:if test="${lastCultural.culturalInformationId != null && lastCultural.culturalInformationId != ''}">
	                                <a href="/culturalinformation/culturaTemplate.html?culId=${lastCultural.culturalInformationId}">
	                                    <div class="w-c-prev">
	                                        <div class="w-c-i">
	                                            <i class="fa fa-angle-double-left"></i>
	                                        </div>
	                                        <div class="w-c-txt">
	                                            <span>上一篇</span>
	                                            <span class="w-c-ttitle">${lastCultural.title}</span>
	                                        </div>
	                                    </div>
	                                </a>
                                </c:if>
                                <c:if test="${nextCultural.culturalInformationId != null && nextCultural.culturalInformationId != ''}">
	                                <a href="/culturalinformation/culturaTemplate.html?culId=${nextCultural.culturalInformationId}">
	                                    <div class="w-c-next">
	
	                                        <div class="w-c-i">
	                                            <i class="fa fa-angle-double-right"></i>
	                                        </div>
	                                        <div class="w-c-txt">
	                                            <span>下一篇</span>
	                                            <span class="w-c-ttitle">
	                                                ${nextCultural.title}
	                                            </span>
	                                        </div>
	                                    </div>
	                                </a>
                                </c:if>
                            </div>
                    
                        </div>
                        	<div class="w-c-links">
	                            <div class="w-lin-left">
	                                <b>标签：</b>
	                                <a href="javascript:;">${culturalInformation.metaKeywork}</a>
	                            </div>
	                            <div class="w-lin-right">
	                              <span>
	                                <!-- JiaThis Button BEGIN -->
	                              <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	                                <!-- JiaThis Button END -->
	                              </span> | <span>阅读数 （${culturalInformation.readNumber}）</span>
	                             </div>
	                        </div>
	                        <div class="w-x-wz">
	                            <h3>相关文章</h3>
	                            <div class="w-x-items">
	                            <c:forEach items="${reCommendResultsList}" var="reCommendResults"  varStatus="r">
	                            	<c:if test="${reCommendResults.type == 0}"><div class="w-x-item w-g-h"></c:if>
	                                <c:if test="${reCommendResults.type == 1}"><div class="w-x-item w-g-l"></c:if>
	                                <c:if test="${reCommendResults.type == 2}"><div class="w-x-item w-g-r"></c:if>
	                                <c:if test="${reCommendResults.type == 3}"><div class="w-x-item w-g-x"></c:if>
	                                <c:if test="${reCommendResults.type == 4}"><div class="w-x-item w-g-s"></c:if>
	                                    <div class="w-g-header">
	                                        <b></b>
	                                        <c:if test="${reCommendResults.type == 0}">时尚前沿</c:if>
	                                        <c:if test="${reCommendResults.type == 1}">思维对话</c:if>
	                                        <c:if test="${reCommendResults.type == 2}">品牌播报</c:if>
	                                        <c:if test="${reCommendResults.type == 3}">聚焦四方</c:if>
	                                        <c:if test="${reCommendResults.type == 4}">四方志</c:if>
	                                         | <fmt:formatDate value="${reCommendResults.createTime}" type="date" dateStyle="long"/>
	                                    </div>
	                                    <a href="/culturalinformation/culturaTemplate.html?culId=${reCommendResults.culturalInformationId}">
	                                        <div class="w-x-imgs">
	                                            <img src="/StoreAdmin/media/other/${reCommendResults.logoImg}" />
	                                        </div>
	                                        <h2 class="title title--preview">${reCommendResults.title}</h2>
	                                    </a>
	                                    <div class="loader"></div>
	                                    <div class="meta meta--preview">
	                                        <a href="javascript:;">${reCommendResults.metaKeywork}</a>
	                                    </div>
	                                </div>
	                            </c:forEach>
	                            </div>
	                        </div>
	                        
	                        <div class="w-c-pl">
	                            <!--jiaThis评论 UY BEGIN -->
								<div id="uyan_frame"></div>
								<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=2052677"></script>
								<!-- UY END -->
	                        </div>
	                    </article>
	
	                </div>
	
	                <button class="close-button-list" id="close_button_a"><i class="fa fa-close"></i><span>Close</span></button>
	            </section>
			</div>
		</div>
		<!-- /container -->
		<%@ include file="../../decorators/include/footerNew.jspf"%>
		</div>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/classie.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/list.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jqueryjs/jquery.masonry.min.js"></script>
		<script type="text/javascript">
	        $(function () {
	            //2015-11-11 宣扬修改 页面加载动画 每次跳转页面自动加载
	            $("#theGrid").height($(document).height());
	            //$('body').css("overflow", "auto");
	            document.documentElement.scrollTop = document.body.scrollTop = 0;
	            $('body').css("overflow", "hidden");
	            setTimeout(function () {
	                $('.pt-page').addClass('pt-page-moveToTopEasing');
	                //$('body').css("overflow", "auto");
	            }, 3000);
	            //END 页面加载特效
	            $('.w-footer').css("display", "none");
	
	            //显示底部导航
	            $('.scroll-wrap').scroll(function () {
	                console.log($('.scroll-wrap').scrollTop())
	                console.log($('.content__item').height())
	                if ($('.scroll-wrap').scrollTop() >= $('.content__item').height() - $('.scroll-wrap').height()) {
	                    $('.w-footer').css("display", "block")
	                }
	                else {
	                    $('.w-footer').css("display", "none")
	                }
	            });
	            $(window).load(function () {
	                //左侧导航点击事件
	                $(".w-list-btn").bind('click', function (event) {
	                    var showclass = $(this).attr('date-type');
	                    $(this).addClass("on").siblings().removeClass("on");
	                    $("#theGrid .grid__item").each(function () {
	                        if (!$(this).hasClass(showclass) && showclass != 'all') {
	                            $(this).hide();
	                        } else {
	                            $(this).show();
	                            $(".w-paget").css("z-index", "1300");
	                        }
	                    });
	                });
	            });
	        });
	    </script>
	    <script type="text/javascript">
	        var jiathis_config = {
	            summary: "",
	            shortUrl: true,
	            hideMore: false
	        }
	    </script>
	    <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
	</body>
</html>