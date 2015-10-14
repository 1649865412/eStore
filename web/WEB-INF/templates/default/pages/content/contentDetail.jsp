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
        <link href="${resPath}/styles/css/help.css" rel="stylesheet" type="text/css" />
        <link href="${resPath}/styles/css/about.css" rel="stylesheet" type="text/css" />

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
        <div class="maincontent">
           <div class="about_nav">
              <ul id="remote_nav_ul">
                <li><a id="t1" href="#tab1" title="关于四方街">关于四方街&middot;</a></li>
                <li><a id="t2" href="#tab2" title="联系我们">联系我们&middot;</a></li>
                <li><a id="t3" href="#tab3" title="加入我们">加入我们</a></li>
              </ul>
           </div><!--about_nav-->
           <div class="about_all" id="tab1">
             <div class="about_bg"></div> 
             <div class="sec2">
               <img src="${resPath }/images/img/press.png" />
             </div>
             <div class="top_about">
               <div class="about_us">
                  <p><span class="smalltop">四方街目前由广州名度网络技术有限公司运营</span>
                  <h1 class="about_slogan">我们是四方街</h1>
                  <h2 class="about_slogan_down">新锐设计师品牌集成店</h2>
                  <hr>
                  <p>
                  ${contentAbout.contentBody }
                  </div><!--about_us-->
             </div><!--top_about-->
           </div><!--about_all-->
           <div class="about_all" id="tab2">
             <div class="contact_bg"></div> 
             <div class="sec2">
               <img src="${resPath }/images/img/fields.png" />
             </div>
             <div class="contact_us" >
              <h1 class="about_slogan">联系四方街</h1>
              <h2 class="contact_us_title_down">如果您在购物过程中遇到问题，我们很愿意为您提供帮助。<br>我们的服务时间为：周一至周五 09：00—18:30（节假日除外）</h2>
              <hr>
              <ul class="list_icon_items">
                <li>
                  <a href="mailto:cs@sifangstreet.com" class="icon_a">
                  
                  <div class="icon_width">
  
                     <i class="fa fa-envelope icon_nohover"></i>
                   </div>
                      <p class="secondary">电子邮箱</p>
                      <p>
                        <span class="pseudo-link">cs@sifangstreet.com</span>
                      </p>
                  </a>
                </li>
                <li>
                  <a href="#" class="icon_a">
                  <div class="icon_width">
                    <i class="fa fa-phone icon_nohover"></i>
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
                      <i class="fa fa-weibo icon_nohover"></i>
                  </div>
                      <p class="secondary">微博</p>
                      <p>
                          <span class="pseudo-link">关注SiFangStreet四方街</span>
                      </p>
                  </a>
  
                </li>
                <li>
                  <a href="#" class="icon_a">
                  <div class="icon_width">
                      <i class="fa fa-weixin icon_nohover"></i>
                      
                  </div>
                  
                      <p class="secondary">微信</p>
                      <p>
                          <span class="pseudo-link">搜索sifangstreet或扫描二维码</span>
                      </p>
                      <ul>
                          <li><img src="${resPath }/images/img/weixin.jpg"></li>
                       </ul>
                  </a>
                </li>
                <li>
                  <a href="http://wpa.qq.com/msgrd?v=3&uin=4006615677&site=qq&menu=yes" class="icon_a" target="_blank">
                  <div class="icon_width">
                      <i class="fa fa-qq icon_nohover"></i>
                  </div>
                      <p class="secondary">QQ客服</p>
                      <p>
                          <span class="pseudo-link">点击可访问QQ客服</span>
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
                        <p><i class="fa fa-map-marker"></i>广州市荔湾区西村街道西增路63号原创元素创意园C4栋</p>
                        <p><i class="fa fa-university"></i>四方街广州形象店</p>
                      </div>
                  </div>
              </div>
          </div>
             </div><!--contact_us-->
           </div><!--about_all-->
           <div class="about_all" id="tab3">
             <div class="joinus_bg"></div> 
             <div class="sec2">
               <img src="${resPath }/images/img/shake.png" />
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
           
          
             
    
      </div><!--end of maincontent-->
      <%@ include file="../../decorators/include/footerNew.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script> 
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
        
        <script src="${ctxPath}/scripts/jquery/js/jquery.tools.min.js"></script>
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
         <script>
		$(function() {
			// setup ul.tabs to work as tabs for each div directly under div.panes
			$("#remote_nav_ul").tabs("div.about_all");	
			
		});
		</script>
	</body>

</html>