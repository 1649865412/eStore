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
		<%@ include file="../../decorators/include/javascripts.jspf"%>
		<script type="text/javascript"
			src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript"
			src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
		<%@ include file="../../decorators/include/styles7.jspf"%>
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/list.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/normalize.css" />
		<script src="${ctxPath}/scripts/jquery/js/modernizr.custom.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/snap.svg-min.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
		<script type="text/javascript">
		
			function getDetail(culid){
				$.post("/culturalinformation/getCulView.html", {
					culId : culid
				}, function(result) {
					   var json = eval("("+result.data+")");
						var object = json.culturalInformation;
						if(object.type !=4){
							changeNotMonth(json);
							}
						else{
							changetMonth(json);
							}
						article(json);
						/* var month = "";
                    	var content = $(".bb-item").html();
                    	alert(content);
						for(i=0;i<json.monthlyCultural.length;i++){
						      	month = json.monthlyCultural[i];
						      	alert("img:"+month.img);
						      	var a ="http://www.baidu.com/img/bd_logo1.png";
						      	content+=("<div class='bb-custom-side page-layout-3' style=' background: rgba(0, 0, 0, 0) url("+a+") no-repeat scroll left top / cover ;'></div>");
							}
						alert(content)
						 $(".bb-item").html(content);*/
					}, "json");
			}

			function article(json){
				var month = "";
            	var content = $(".w-x-items").html();
            	var img  = "";
            	var typeNum  = "";
            	var type  = "";
            	var content ="";
            	var value="";
            	var time="";
            	var culid="";
                var click="";
                var title="";
                var key="";
				for(i=0;i<json.reCommendResults.length;i++){
					var object=json.reCommendResults[i];
					 img ="/StoreAdmin/media/other/"+object.logoImg;
					 typeNum=object.type;
					 if(typeNum==0){
						 type="时尚前沿";
						 }else if(typeNum==1){
							 type="思维对话";
							 }else if(typeNum==2){
							 type="品牌播报";
							 }else if(typeNum==3){
							 type="聚焦四方";
							 }
					 time=(object.createTime.year+1900)+"年"+(object.createTime.month+1)+"月"+object.createTime.date+"日";
					 culid=object.culturalInformationId;
					 click="getDetail("+culid+")";
					 title=object.title;
					 key=object.metaKeywork;
					 value = ("<div class='w-x-item  w-g-b'><div class='w-g-header'><b></b>"+type+" | "+time+"</div>"+
					"<a onClick='"+click+"'><div class='w-x-imgs'><img src='"+img+"' /></div><h2 class='title title--preview'>"+title+"</h2></a>"+
					"<div class='loader'></div><div class='meta meta--preview'><a >"+key+"</a></div></div>");
						content+=value;
					}
				 $(".w-x-items").html(content);
				}

			function lastNext(culId){
					
				}

			function changetMonth(json){
				$("#box2").show();
				$("#box1").hide();
				setMonth(json);
				}

			function changeNotMonth(json){
				$("#box1").show();
				$("#box2").hide();
				setNotMonth(json);
				}

			function checkNull(value){
				  if(value==null){
					  return "";
					  }else{
						  return value;
						  }
			}

	
			
			function setNotMonth(json){
				var object = json.culturalInformation;
				var color ="";
				if(object.type ==0){
					$("#boxType").html("时尚前沿");
					color="#fbbd6a";
					}else if(object.type ==1){
						$("#boxType").html("思维对话");
						color="#a6d5ab";
					}else if(object.type ==2){
						$("#boxType").html("品牌播报");
						color="#abdce3";
					}else if(object.type ==3){
						$("#boxType").html("聚焦四方");
						color="#fb6e67";
					}
				
				$("#boxTitle").html(checkNull(object.title));
				$("#boxTitle").css("color",color);
				$("#boxBy").html("来源:"+checkNull(object.writer));
				$("#boxTime").html((object.createTime.year+1900)+"年"+(object.createTime.month+1)+"月"+object.createTime.date+"日");
				$("#boxRead").html("<a href='http://www.jiathis.com/share' class='jiathis jiathis_txt jiathis_separator jtico jtico_jiathis' target='_blank'><i class='fa fa-share-alt'></i> 分享</a>| 阅读数 （"+checkNull(object.readNumber)+"）");
				$("#boxText").html(checkNull(object.textIntroduction));
				$("#informationKey").html(checkNull(object.metaKeywork));
				var lastid=checkNull(json.lastCultural.culturalInformationId);
				var nextid=checkNull(json.nextCultural.culturalInformationId);
				//alert(lastid+"------"+nextid);
				var value = ("<a class='grid__item_a' onClick='getDetail("+lastid+")'><div class='w-c-prev'><div class='w-c-i'><i class='fa fa-angle-double-left'></i>"+
						"</div><div class='w-c-txt' id='flipLast'><span>上一篇</span><span class='w-c-ttitle' id='boxLast'></span></div></div></a>"+
						"<a class='grid__item_a' onClick='getDetail("+nextid+")'><div class='w-c-next'><div class='w-c-i'><i class='fa fa-angle-double-right'></i></div>"+
								"<div class='w-c-txt' id='flipNext'><span>下一篇</span><span class='w-c-ttitle' id='boxNext'></span></div></div></a>");
				$("#last_next").html(value);
				$("#boxLast").html(checkNull(json.lastCultural.title));
				$("#boxNext").html(checkNull(json.nextCultural.title));
				var readNum=checkNull(object.readNumber);
				//alert(readNum);
				var valueRead = ("<span><a href='http://www.jiathis.com/share' class='jiathis jiathis_txt jiathis_separator jtico jtico_jiathis' target='_blank'><i class='fa fa-share-alt'></i> 分享</a></span> | <span>阅读数 （"+readNum+"）</span>");
				$(".w-lin-right").html(valueRead);
				
				if(lastid==null||lastid==""){
					$("#flipLast").hide();
					}else{
						$("#flipLast").show();
						};
				if(nextid==null||nextid==""){
					$("#flipNext").hide();
					}else{
						$("#flipNext").show();
						};
				}

			function setMonth(json){
				var object = json.culturalInformation;
				if(object.type ==0){
					$("#boxType").html("秀场");
					}else if(object.type ==1){
						$("#boxType").html("访谈");
					}else if(object.type ==2){
						$("#boxType").html("搭配");
					}else if(object.type ==3){
						$("#boxType").html("线下主题活动");
					}
				$("#boxTitle").html(checkNull(object.title));
				$("#boxBy").html("来源:"+checkNull(object.writer));
				$("#boxTime").html((object.createTime.year+1900)+"年"+(object.createTime.month+1)+"月"+object.createTime.date+"日");
				$("#boxRead").html("阅读数	("+checkNull(object.readNumber)+")		|");
				$("#boxText").html(checkNull(object.textIntroduction));
				$("#informationKey").html(checkNull(object.metaKeywork));
				var lastid=checkNull(json.lastCultural.culturalInformationId);
				var nextid=checkNull(json.nextCultural.culturalInformationId);
				var value = ("<a class='grid__item_a' onClick='getDetail("+lastid+")'><div class='w-c-prev'><div class='w-c-i'><i class='fa fa-angle-double-left'></i>"+
						"</div><div class='w-c-txt' id='flipLast'><span>上一篇</span><span class='w-c-ttitle' id='boxLast'></span></div></div></a>"+
						"<a class='grid__item_a' onClick='getDetail("+nextid+")'><div class='w-c-next'><div class='w-c-i'><i class='fa fa-angle-double-right'></i></div>"+
								"<div class='w-c-txt' id='flipNext'><span>下一篇</span><span class='w-c-ttitle' id='boxNext'></span></div></div></a>");
				$("#last_next").html(value);
				$("#boxLast").html(checkNull(json.lastCultural.title));
				$("#boxNext").html(checkNull(json.nextCultural.title));
				if(lastid==null||lastid==""){
					$("#flipLast").hide();
					}else{
						$("#flipLast").show();
						};
				if(nextid==null||nextid==""){
					$("#flipNext").hide();
					}else{
						$("#flipNext").show();
						};
				}
		
		</script>
		
		
	</head>
	<body>
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
					<%--<a href="/culturalinformation/index.html?type=4" class="w-list-btn <c:if test='${param.type == 4}'>on</c:if>" date-type="all" id="t6">四方志</a>
				--%></div>
	        </div>
	<c:if test="${param.type == null || param.type ==''}"></c:if>
	        <div id="theGrid" class="main">
	            <div id="loader" class="pageload-overlay" data-opening="M20,15 50,30 50,30 30,30 Z;M0,0 80,0 50,30 20,45 Z;M0,0 80,0 60,45 0,60 Z;M0,0 80,0 80,60 0,60 Z" data-closing="M0,0 80,0 60,45 0,60 Z;M0,0 80,0 50,30 20,45 Z;M20,15 50,30 50,30 30,30 Z;M30,30 50,30 50,30 30,30 Z">
	                <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 80 60" preserveAspectRatio="none">
	                    <path d="M30,30 50,30 50,30 30,30 Z" />
	                </svg>
	            </div>
	
	            <section class="grid">
	            	<c:forEach items="${culturalinformationList}" var="culList" varStatus="i">
		                <c:if test="${culList.type == 0}"><div class="grid__item w-g-h"></c:if>
						<c:if test="${culList.type == 1}"><div class="grid__item w-g-l"></c:if>
						<c:if test="${culList.type == 2}"><div class="grid__item w-g-r"></c:if>
						<c:if test="${culList.type == 3}"><div class="grid__item w-g-x"></c:if>
						<c:if test="${culList.type == 4}"><div class="grid__item w-g-s"></c:if>
		                    <a onClick="getDetail('${culList.culturalInformationId}')" class="grid__item_a" data-content="contentArticle" data-item="content__item" data-close="close-button-list">
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
	            <section class="BookContent content1">
	                <div class="scroll-wrap">
	                    <article class="content__item w-g-h content__item_b">
	                        <iframe id="bookFrame" allowtransparency="true" src="monthly_1.html" style="height:2113px" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
	                    </article>
	                </div>
	                <button class="close-button-list close-button-list_b" id="close_button_a1"><i class="fa fa-close"></i><span>Close</span></button>
	            </section>
	            <section class="content contentArticle">
	                <div class="scroll-wrap">
	                    <article class="content__item w-g-h">
	                    
	                    	<div class="w-c-nrb" id="box1">
								<span class="category category--full" id="boxType"></span>
								<h2 class="title title--full" id="boxTitle"></h2>
								<div class="meta meta--full">
									<span class="meta__author" id="boxBy"></span>
									<span class="meta__date" id="boxTime"></span>
									<span class="meta__reading-time" id="boxRead"></span>
								</div>
								<div class="article_culture_detail" id="boxText"></div>
								<div class="w-c-np" id="last_next">
										<a class="grid__item_a" onClick="getDetail()">
											<div class="w-c-prev">
												<div class="w-c-i">
													<i class="fa fa-angle-double-left"></i>
												</div>
												<div class="w-c-txt" id="flipLast">
													<span>上一篇</span>
													<span class="w-c-ttitle" id="boxLast"></span>
												</div>
											</div>
										</a>
										<a class="grid__item_a" onClick="getDetail()">
											<div class="w-c-next">
	
												<div class="w-c-i">
													<i class="fa fa-angle-double-right"></i>
												</div>
												<div class="w-c-txt" id="flipNext">
													<span>下一篇</span>
													<span class="w-c-ttitle" id="boxNext"></span>
												</div>
											</div>
										</a>
									</div>
							</div>
							<div class="w-c-links">
	                            <div class="w-lin-left">
									<b>标签：</b>
									<a id="informationKey"></a>
								</div>
	                            <div class="w-lin-right">
	                              <span>
	                                <!-- JiaThis Button BEGIN -->
	                              <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	                                <!-- JiaThis Button END -->
	                              </span> | <span>阅读数 （12）</span>
	                             </div>
	                        </div>
	                        <div class="w-x-wz">
								<h3>相关文章</h3>
								<div class="w-x-items">
									
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
	            
	              <!--/分页-->
	              
	            
	        </div>
	         
	      </div>
	              <!-- /w-container -->
	     <%@ include file="../../decorators/include/footerNew.jspf"%>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/classie.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/list.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
	
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
	
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/tmasonry.js"></script>
	    <!--<script type="text/javascript" src="js/jquery.masonry.min.js"></script>-->
	
	    <script type="text/javascript">
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
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/svgLoader.js"></script>
	    <script>
	        (function () {
	            //				var pageWrap = document.getElementById( 'close_button_a' ),
	            //					pages = [].slice.call( document.querySelectorAll( 'div.container-p' ) ),
	            var currentPage = 0,
	                triggerLoading = [].slice.call(document.querySelectorAll('a.grid__item_a')),
	                closebutton = document.getElementById('close_button_a')
	            loader = new SVGLoader(document.getElementById('loader'), {
	                speedIn: 100
	            });
	
	            function init() {
	                triggerLoading.forEach(function (trigger) {
	                    trigger.addEventListener('click', function (ev) {
	                        ev.preventDefault();
	                        loader.show();
	                        // after some time hide loader
	                        setTimeout(function () {
	                            loader.hide();
	                            //								classie.removeClass( pages[ currentPage ], 'show' );
	                            // update..
	                            currentPage = currentPage ? 0 : 1;
	                            //								classie.addClass( pages[ currentPage ], 'show' );
	                        }, 2000);
	                    });
	                    closebutton.addEventListener('click', function (ev) {
	                        ev.preventDefault();
	                        loader.show();
	                        // after some time hide loader
	                        setTimeout(function () {
	                            loader.hide();
	                            //								classie.removeClass( pages[ currentPage ], 'show' );
	                            // update..
	                            currentPage = currentPage ? 0 : 1;
	                            //								classie.addClass( pages[ currentPage ], 'show' );
	                        }, 2000);
	                    });
	                });
	            }
	            init();
	        })();
	    </script>
	     <script type="text/javascript" >
		  var jiathis_config={
			  summary:"",
			  shortUrl:true,
			  hideMore:false
		  }
		  </script>
		  <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
		<script>
			$(function(){
				$("#theGrid").css("height",$("#theGrid .grid").outerHeight());
				$(window).resize(function() {
		  			$("#theGrid").css("height",$("#theGrid .grid").outerHeight());
			})
			})
		</script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery.masonry.min.js"></script>
		<script type="text/javascript">
			$(function() {
				//$(".w-paget").css("top",$("#theGrid .grid").outerHeight()-60);
				$(window).load(function() {
						
					var container = document.querySelector('#theGrid');
					var msnry = new Masonry(container, {
						itemSelector: '.grid__item',
						columnWidth: 0
					});
					$(".w-list-btn").bind('click', function(event) {
						var showclass = $(this).attr('date-type');
						
						$("#theGrid .grid__item").each(function() {
							if (!$(this).hasClass(showclass)&&showclass!='all') {
								$(this).hide();
							}else{
								$(this).show();
							}
						});
						msnry.layout();
					});
				});
			});
		</script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/svgLoader.js"></script>
		<script>
			(function() {
				//				var pageWrap = document.getElementById( 'close_button_a' ),
				//					pages = [].slice.call( document.querySelectorAll( 'div.container-p' ) ),
				var currentPage = 0,
					triggerLoading = [].slice.call(document.querySelectorAll('a.grid__item_a')),
					closebutton = document.getElementById('close_button_a')
				loader = new SVGLoader(document.getElementById('loader'), {
					speedIn: 100
				});

				function init() {
					triggerLoading.forEach(function(trigger) {
						trigger.addEventListener('click', function(ev) {
							ev.preventDefault();
							loader.show();
							// after some time hide loader
							setTimeout(function() {
								loader.hide();
								//								classie.removeClass( pages[ currentPage ], 'show' );
								// update..
								currentPage = currentPage ? 0 : 1;
								//								classie.addClass( pages[ currentPage ], 'show' );
							}, 2000);
						});
						closebutton.addEventListener('click', function(ev) {
							ev.preventDefault();
							loader.show();
							// after some time hide loader
							setTimeout(function() {
								loader.hide();
								//								classie.removeClass( pages[ currentPage ], 'show' );
								// update..
								currentPage = currentPage ? 0 : 1;
								//								classie.addClass( pages[ currentPage ], 'show' );
							}, 2000);
						});
					});
				}
				init();
			})();
		</script>
		<script type="text/javascript" >
	  var jiathis_config={
		  summary:"",
		  shortUrl:true,
		  hideMore:false
	  }
	  </script>
	  <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
	</body>
</html>