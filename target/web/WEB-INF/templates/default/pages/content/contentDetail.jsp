<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cms" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<title>${content.contentTitle} | ${category.categoryName}  </title>
		<meta name="keywords" content="${not empty content.metaKeyword?content.metaKeyword:content.contentTitle}" />
		<meta name="description" content="${content.metaDescription}" />
		
		<link href="${resPath }/styles/main.css" rel="stylesheet" type="text/css">
      <!-- Include the awesome icon css -->
      <link href="${resPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
      <link href="${resPath }/styles/help.css" rel="stylesheet" type="text/css" />
      <c:if test="${content.id == 18 || content.id == 19 || content.id == 27}">
      	<link href="${resPath }/styles/about.css" rel="stylesheet" type="text/css" />
      </c:if>
      <script type="text/javascript">
	  $(document).ready(function() {
	  $("a.icon_a").hover(function() {
			  $(this).children(".icon_width").children(".fa").removeClass("icon_nohover");
			  $(this).children(".icon_width").children(".fa").addClass("icon_hover");
		  }, function() {
			  $(this).children(".icon_width").children(".fa").removeClass("icon_hover");
			  $(this).children(".icon_width").children(".fa").addClass("icon_nohover");
		  });
	  });
	  </script>
    <link rel="stylesheet" type="text/css" href="${resPath }/styles/jquery.fancybox.css?v=2.1.5" media="screen" />
    <script type="text/javascript">
      $(document).ready(function() {
      	$('.fancybox').fancybox({
			padding : 0
		 });
      	});
    </script>
		
	</head>
	
	<body>
	
	<c:if test="${content.id == 18 || content.id == 19 || content.id == 27}">
	
		<div class="maincontent">
	         
	         <div class="position-wrap portfolio_item_text">
	            <a href="${ctxPath }/index.html">首页</a>&nbsp;&gt;&nbsp;
	            <span class="selected">关于四方街</span>
	         </div>
	         
	         <div class="about_nav">
	            <ul id="remote_nav_ul">
	              <li><a id="t1" href="#tab1" title="关于四方街" <c:if test="${content.id==18 }">class="current"</c:if>>关于四方街&middot;</a></li>
	              <li><a id="t2" href="#tab2" title="联系我们" <c:if test="${content.id==27 }">class="current"</c:if>>联系我们&middot;</a></li>
	              <li><a id="t3" href="#tab3" title="加入我们" <c:if test="${content.id==19 }">class="current"</c:if>>加入我们</a></li>
	            </ul>
	         </div><!--about_nav-->
	         <div class="about_all" id="tab1">
	           <div class="about_bg"></div> 
	           <div class="sec2">
	             <img src="${resPath }/images/press.png" />
	           </div>
	           <div class="top_about">
	             <div class="about_us">
	                <p><span class="smalltop">四方街目前由广州名度网络技术有限公司运营</span>
	                <h1 class="about_slogan">我们是四方街</h1>
	                <h2 class="about_slogan_down">新锐设计师品牌集成店</h2>
	                <hr>
	                	${contentAbout.contentBody }
	                </div><!--about_us-->
	           </div><!--top_about-->
	         </div><!--about_all-->
	         <div class="about_all" id="tab2">
	           <div class="contact_bg"></div> 
	           <div class="sec2">
	             <img src="${resPath }/images/fields.png" />
	           </div>
	           <div class="contact_us" >
	            <h1 class="about_slogan">联系四方街</h1>
	            <h2 class="contact_us_title_down">如果您在购物过程中遇到问题，我们很愿意为您提供帮助。我们的服务时间为：周一至周五 09：00—18:30（节假日除外）</h2>
	            <hr>
	            <ul class="list_icon_items">
	              <li>
	                <a href="mailto:cs@sifangstreet.com" class="icon_a">
	                
	                <div class="icon_width">
	
	                   <i class="fa fa-envelope fa-5x icon_nohover"></i>
	                 </div>
	                    <p class="secondary">电子邮箱</p>
	                    <p>
	                      <span class="pseudo-link">cs@sifangstreet.com</span>
	                    </p>
	                </a>
				  </li>
	              <li>
	                <a href="javascript:void(0);" class="icon_a">
	                <div class="icon_width">
	                  <i class="fa fa-phone fa-5x icon_nohover"></i>
	                </div>
	                  <p class="secondary">客服专线</p>
	                  <p>
	                        <span class="pseudo-link" id="Pcode">400-661-5677</span>
	                    </p>
	                </a>
	              </li>
	             
	              <li>
	                <a href="http://weibo.com/sifangstreet" class="icon_a">
	                <div class="icon_width">
	                    <i class="fa fa-weibo fa-5x icon_nohover"></i>
	                </div>
	                    <p class="secondary">微博</p>
	                    <p>
	                        <span class="pseudo-link">关注SiFangStreet四方街</span>
	                    </p>
	                </a>
	
	              </li>
	              <li>
	                <a href="#inline1" class="icon_a fancybox">
	                <div class="icon_width">
	                    <i class="fa fa-weixin fa-5x icon_nohover"></i>
	                    
	                </div>
	                
	                    <p class="secondary">微信</p>
	                    <p>
	                        <span class="pseudo-link">搜索sifangstreet四方街或点击打开二维码</span>
	                    </p>
	                </a>
	              </li>
	              <li>
	                <a href="http://wpa.qq.com/msgrd?v=3&uin=4006615677&site=qq&menu=yes" class="icon_a" target="_blank">
	                <div class="icon_width">
	                    <i class="fa fa-qq fa-5x icon_nohover"></i>
	                </div>
	                    <p class="secondary">QQ客服</p>
	                    <p>
	                        <span class="pseudo-link">点击可访问QQ客服</span>
	                    </p>
	                </a>
	
	              </li>
	               <li>
	                <a href="javascript:void(0);" class="icon_a">
	                <div class="icon_width">
	                    <i class="fa fa-comments-o fa-5x icon_nohover"></i>
	                </div>
	                    <p class="secondary">在线客服</p>
	                    <p>
	                        <span class="pseudo-link">点击页面右侧侧边栏</span>
	                    </p>
	                </a>
	
	              </li>
	            </ul>
	            
	            <div class="weixin_QR" id="inline1"></div>
	            <hr class="grid-2 center">
	            <h2 class="align_center">欢迎莅临四方街体验店</h2>
	            <div class="grid-14 center">
				<div class="map_find_us"></div>
				
				<div class="map-lower">
					<div class="grid-9">
						<h3>体验店&nbsp;&amp;&nbsp;办公地址</h3>
	                    <div class="dec">
	                      <p><i class="fa fa-map-marker fa-2x padding_right15"></i>广州市越秀区东风东路753号天誉大厦东塔3104</p>
	                      <p><i class="fa fa-university fa-lg padding_right10"></i>广州名度网络技术有限公司</p>
	                    </div>
					</div>
				</div>
			</div>
	           </div><!--contact_us-->
	         </div><!--about_all-->
	         <div class="about_all" id="tab3">
	           <div class="joinus_bg"></div> 
	           <div class="sec2">
	             <img src="${resPath }/images/shake.png" />
	           </div>
	           <div class="join_us">
	            <h1 class="about_slogan">加入四方街</h1>
	            <h3 class="join_us_title_down">
	              四方街SiFangStreet.com由广州名度网络技术有限公司（下称“本公司”或“我们）拥有和运营。
	              <br/>
	              “成就设计梦想”是名度网络的使命，为爱美族提供触手可及的设计师轻时尚产品。
	              <br/>我们需要服务热忱的伙伴提供专业及优质的服务，将四方街SiFangStreet的品牌精神传达给消费者。
	              <br/>
	              如果你也喜爱和认同四方街SiFangStreet，请加入我们！
	            </h3>
	            <hr>
	            <div class="down_right">
		            ${contentJoin.contentBody }
	            </div><!--down_right-->
	           </div><!--join_us-->
	         </div><!--about_all-->
	         
	         <script>
			$(function() {
				// setup ul.tabs to work as tabs for each div directly under div.panes
				var index = 0;
				switch(${content.id}){
				case 18:
					index = 0;
					break;
				case 19:
					index = 2;
					break;
				case 27:
					index = 1;
					break;
				}
				$("#remote_nav_ul").tabs("div.about_all", { history: true,initialIndex: index});
			});
			</script>
	           
	       <hr>
	      </div><!--end of maincontent-->
	      
	</c:if>
	
	</body>
</html>