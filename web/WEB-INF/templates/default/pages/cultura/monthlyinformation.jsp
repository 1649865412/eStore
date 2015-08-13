<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<!--月刊列表页-->
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
		
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/monthly.css" />
		

		<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/js/book/css/book.css" />
		<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/js/book/css/bookblock.css" />
		<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/js/book/css/component.css" />
		
		
		<script src="${ctxPath}/scripts/jquery/js/modernizr.custom.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/snap.svg-min.js"></script>
		
		
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
						 type="秀场";
						 }else if(typeNum==1){
							 type="访谈";
							 }else if(typeNum==2){
							 type="行业动态";
							 }else if(typeNum==3){
							 type="线下主题活动";
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
				if(object.type ==0){
					$("#boxType").html("秀场");
					}else if(object.type ==1){
						$("#boxType").html("访谈");
					}else if(object.type ==2){
						$("#boxType").html("行业动态");
					}else if(object.type ==3){
						$("#boxType").html("线下主题活动");
					}
				$("#boxTitle").html(checkNull(object.title));
				$("#boxBy").html("来源:"+checkNull(object.writer));
				$("#boxTime").html((object.createTime.year+1900)+"年"+(object.createTime.month+1)+"月"+object.createTime.date+"日");
				$("#boxRead").html("阅读数	("+checkNull(object.readNumber)+")		|");
				$("#boxText").html(checkNull(object.textIntroduction));
				$("#boxLast").html(checkNull(json.lastCultural.title));
				$("#boxNext").html(checkNull(json.nextCultural.title));
				var lastid=checkNull(json.lastCultural.culturalInformationId);
				var nextid=checkNull(json.nextCultural.culturalInformationId);
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
						$("#boxType").html("行业动态");
					}else if(object.type ==3){
						$("#boxType").html("线下主题活动");
					}
				$("#boxTitle").html(checkNull(object.title));
				$("#boxBy").html("来源:"+checkNull(object.writer));
				$("#boxTime").html((object.createTime.year+1900)+"年"+(object.createTime.month+1)+"月"+object.createTime.date+"日");
				$("#boxRead").html("阅读数	("+checkNull(object.readNumber)+")		|");
				$("#boxText").html(checkNull(object.textIntroduction));
				$("#boxLast").html(checkNull(json.lastCultural.title));
				$("#boxNext").html(checkNull(json.nextCultural.title));
				var lastid=checkNull(json.lastCultural.culturalInformationId);
				var nextid=checkNull(json.nextCultural.culturalInformationId);
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
			<div id="theSidebar" class="sidebar" >
				<div class="related">
					<a href="#section-2" id="t2">秀场</a>
					<a href="#section-3" id="t3">访谈</a>
					<a href="#section-4" id="t4">行业动态</a>
					<a href="#section-5" id="t5">线下主题活动</a>
					<a href="/monthlyinformation/index.html?type=4" id="t6">月刊</a>
				</div>
			</div>
		
			<div id="theGrid" class="main">
			
				<section class="grid">
					<c:forEach items="${culturalinformationList}" var="culList" varStatus="i">
						<c:if test="${culList.type == 0}"><div class="grid__item w-g-h"></c:if>
						<c:if test="${culList.type == 1}"><div class="grid__item w-g-l"></c:if>
						<c:if test="${culList.type == 2}"><div class="grid__item w-g-b"></c:if>
						<c:if test="${culList.type == 3}"><div class="grid__item w-g-r"></c:if>
						<c:if test="${culList.type == 4}"><div class="grid__item w-g-y"></c:if>
						
						<a class="grid__item_a" onClick="getDetail('${culList.culturalInformationId}')">
						<div class="w-g-header">
							<b></b>
							<c:if test="${culList.type == 0}">秀场</c:if>
							<c:if test="${culList.type == 1}">访谈</c:if>
							<c:if test="${culList.type == 2}">行业动态</c:if>
							<c:if test="${culList.type == 3}">线下主题活动</c:if>
							<c:if test="${culList.type == 4}">月刊</c:if>
							 | <fmt:formatDate value="${culList.releaseTime}" type="date" dateStyle="long"/>
						</div>
						<img src="${mediaPath}other/${culList.logoImg}" height="230"/>
						<h2 class="title title--preview">${culList.title}</h2>
						<p class="w-content">
							${culList.content}
						</p>
						<div class="w-g-pyf jiathis_style_32x32" onmouseover="setShare('${culList.title}', 'culturalinformation/culturatemplate.html?culId=${culList.culturalInformationId}');">
							评论数 (${culList.commentNumber}) | 阅读数 (${culList.readNumber}) |
							<a class="jiathis_button_qzone"></a>
							<a class="jiathis_button_tsina"></a>
							<a class="jiathis_button_weixin"></a>
							<a class="jiathis_button_cqq"></a>
						</div>
						<div class="loader"></div>
						<div class="meta meta--preview">
							${culList.metaKeywork}
						</div>
						</a>
						</div>
					</c:forEach>
				</section>
				<section class="content">
					<div class="scroll-wrap" >
						<article class="content__item w-g-h">
							<div class="w-c-nrb" id="box1">
								<span class="category category--full" id="boxType"></span>
								<h2 class="title title--full" id="boxTitle"></h2>
								<div class="meta meta--full">
									<span class="meta__author" id="boxBy"></span>
									<span class="meta__date" id="boxTime"></span>
									<span class="meta__reading-time" id="boxRead"></span>
									<a class="jiathis_button_qzone"></a>
									<a class="jiathis_button_tsina"></a>
									<a class="jiathis_button_weixin"></a>
									<a class="jiathis_button_cqq"></a>
								</div>
								<div id="boxText"></div>

								
							</div>
							
							<div class="w-book" id="box2">
								<div class="bb-custom-wrapper show" id="book-1">
									<div class="bb-bookblock">
										<div class="bb-item">
											<div class="bb-custom-side page-layout-1">
												<h3>
													Chapter 9 <span>Nomadic Lifestyle</span>
												</h3>
											</div>
											<div class="bb-custom-side page-layout-1">
												<p>Candy canes lollipop macaroon marshmallow gummi bears tiramisu. Dessert croissant cupcake candy canes. Bear claw faworki faworki lemon drops. Faworki marzipan sugar plum jelly-o marzipan cookie.</p>
											</div>
										</div>
										<div class="bb-item">
											<div class="bb-custom-side page-layout-2">
												<div>
													<h3>Aa</h3>
													<p>Faworki marzipan sugar plum jelly-o marzipan. Soufflé tootsie roll jelly beans. Sweet icing croissant dessert bear claw. Brownie dessert cheesecake danish jelly pudding bear claw soufflé.</p>
												</div>
												<div>
													<h3>Bb</h3>
													<p>Faworki marzipan sugar plum jelly-o marzipan. Soufflé tootsie roll jelly beans. Sweet icing croissant dessert bear claw. Brownie dessert cheesecake danish jelly pudding bear claw soufflé.</p>
												</div>
											</div>
											<div class="bb-custom-side page-layout-2">
												<div>
													<h3>Cc</h3>
													<p>Faworki marzipan sugar plum jelly-o marzipan. Soufflé tootsie roll jelly beans. Sweet icing croissant dessert bear claw. Brownie dessert cheesecake danish jelly pudding bear claw soufflé.</p>
												</div>
												<div>
													<h3>Dd</h3>
													<p>Faworki marzipan sugar plum jelly-o marzipan. Soufflé tootsie roll jelly beans. Sweet icing croissant dessert bear claw. Brownie dessert cheesecake danish jelly pudding bear claw soufflé.</p>
												</div>
											</div>
										</div>
									</div><!-- /bb-bookblock -->
									<nav>
										<a href="#" class="bb-nav-prev"><i class="fa fa-chevron-left"></i></a>
										<a href="#" class="bb-nav-next"><i class="fa fa-chevron-right"></i></a>
										<a href="#" class="bb-nav-close">Close</a>
									</nav>
								</div><!-- /bb-custom-wrapper -->
							</div>
							<div class="w-c-np">
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
							
							<div class="w-c-links">
								<div class="w-lin-left">
									<b>标签：</b>
									<a href="#">对话</a>,
									<a href="#">时尚</a>,
									<a href="#">时尚预测</a>,
									<a href="#">Li EdelKoort</a>,
									<a href="#">设计博览会</a>
								</div>
								<div class="w-lin-right">阅读数 （12）| <a href="#">分享<i class="fa fa-share"></i></a></div>
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
			</div>
			<!-- /container -->
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/classie.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/list.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		
		<script src="${ctxPath}/scripts/jquery/js/book/js/bookblock.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/book/js/bookshelf.js"></script>
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
		<script type="text/javascript">
		                          function setShare(title, url) {
		                            //  alert("titile:"+title);
		                            //  alert("url:"+url);
		                            //  alert("http://"+window.location.host+"/"+url);
		                              jiathis_config.title = title;
		                              jiathis_config.url = "http://"+window.location.host+"/"+url;
		                          }
		                            var jiathis_config = {}
		                          </script>  
		<script type="text/javascript" >
			var jiathis_config={
				data_track_clickback:true,
				sm:"qzone,tsina,weixin,cqq",
				summary:"",
				shortUrl:true,
				hideMore:false
			}
		</script>
		<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jia.js?uid=2052677" charset="utf-8"></script>
	</body>
</html>