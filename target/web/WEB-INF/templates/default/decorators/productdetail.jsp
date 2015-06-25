<%--
产品详情页修订版
--%>
<%@ page pageEncoding="utf-8"%>
<!doctype html>
<%@page import="com.cartmatic.estore.common.model.catalog.ProductReview"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.cartmatic.estore.common.model.catalog.ProductDescription"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags/app"%>

<c:if test="${product.status != 1}">
	<%response.setStatus(response.SC_GONE);%>
</c:if> 

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">


	<head>
	<c:set var="productPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></c:set>
<c:set value="${empty product.title?product.productName:product.title}" var="pageTitle"></c:set>
		<TITLE>${pageTitle}</TITLE>
	<meta name="keywords" content="<c:out value="${product.metaKeyword}"/>" />
<meta name="description" content="<c:out value="${empty product.metaDescription ? product.productName : product.metaDescription}"/>" />
		<%@ include file="./include/styles2.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<link rel="stylesheet" href="${resPath}/styles/tabs.css" type="text/css" media="screen" />
      <!--detail page css-->
      <link href="${resPath}/styles/detail.css" rel="stylesheet" type="text/css" />
      <link href="${resPath}/styles/comment.css" rel="stylesheet" type="text/css">
      <!-- Include the awesome icon css -->
      <link href="${resPath}/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
		<link href="${resPath}/styles/jquery.fancybox.css?v=2.1.5" rel="stylesheet" />
		
		<%@ include file="./include/javascripts5.jspf"%>
		<script type="text/javascript">
				      $(document).ready(function(){
				          
				          $(".designer_pic .rsp").hide();
				          
				          $(".designer_story").hover(function(){
				              $(".designer_pic").find(".rsp").stop().fadeTo(500,0.5)
				              $(".designer_pic").find(".text").stop().animate({left:'0'}, {duration: 500})
				          },function(){
				              $(".designer_pic").find(".rsp").stop().fadeTo(500,0)
				              $(".designer_pic").find(".text").stop().animate({left:'238'}, {duration: "fast"})
				              $(".designer_pic").find(".text").animate({left:'-238'}, {duration: 0})
				          });
				      
				      });
		</script>  
	 <script type="text/javascript">
      $(document).ready(function($){
		$("#zoom_03").elevateZoom({
		gallery:'gallery_01', 
		cursor: 'pointer', 
		galleryActiveClass: "active", 
		imageCrossfade: true, 
		borderColour: "#fff",
		borderSize: 2,
		zoomWindowOffetx: 25,
		zoomWindowWidth:330,
		zoomWindowHeight:400,
		loadingIcon: "images/bx_loader.gif"
		}); 

	  $("#zoom_03").bind("click", function(e) {  
		var ez =   $('#zoom_03').data('elevateZoom');
		ez.closeAll(); //NEW: This function force hides the lens, tint and window	
		  $.fancybox(ez.getGalleryList());

		return false;
	  }); 
	  
	  }); 

      </script>
       <script>
	  $(function(){
		  $('.slider2').bxSlider({
		  pager: false,
		  controls:true,
		  wrapper_class: 'sale_popular',
		  pause: 2500,
		  slideWidth: 100,
		  minSlides:1,
		  maxSlides: 5,
		  moveSlides: 1,
		  slideMargin: 5
		  });
	  });
      </script>
        <script>
	   $(function() {
			$.fn.raty.defaults.path = 'lib/img';
			$('.target_star2').raty({
			  number: 5,//多少个星星设置		
			  path      : '${resPath}/images',
			  size      : 24,
			  starOff   : 'star-off.png',
			  starOn    : 'star-on.png',
			  cancel    : false,
			  targetKeep: true,
			  targetText: '请选择评分'
			});    
			
			 
			 $('.target_star').raty({ 
			  readOnly: true, 
			  score: 4 ,
			  number: 5,//多少个星星设置		
			  path      : '${resPath}/images',
			  size      : 24,
			  starOff   : 'star-off.png',
			  starOn    : 'star-on.png',
			  cancel    : false,
			  targetKeep: true
			  
			 });
	   });
	  </script>
     <script type="text/javascript">
      $(document).ready(function() {
      	$('.fancybox').fancybox({
			padding : 0
		 });
      	});
    </script>
     <script>
	  $(document).ready(function(){
		$("#p_collocate .sub_active").css({"display":"inline-block"});
		$("#p_collocate").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("搭配款式");
			 $("#p_collocate").addClass("active_href");
			 $("#p_other").removeClass("active_href");
			 $("#p_designer_oth").removeClass("active_href");
		   $("#p_collocate .sub_active").css({"display":"inline-block"});
		   $("#p_other .sub_active").css({"display":"none"});
		   $("#p_designer_oth .sub_active").css({"display":"none"});
		});
		
		$("#p_other").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("相似款式");
			 $("#p_other").addClass("active_href");
			 $("#p_collocate").removeClass("active_href");
			 $("#p_designer_oth").removeClass("active_href");
		   $("#p_other .sub_active").css({"display":"inline-block"});
		   $("#p_collocate .sub_active").css({"display":"none"});
		   $("#p_designer_oth .sub_active").css({"display":"none"});
		});
		
		$("#p_designer_oth").click(function(){
			$("#siderbar_title").empty();
			$("#siderbar_title").append("该设计师其他款式");
			 $("#p_designer_oth").addClass("active_href");
			 $("#p_collocate").removeClass("active_href");
			 $("#p_other").removeClass("active_href");
		   $("#p_designer_oth .sub_active").css({"display":"inline-block"});
		   $("#p_collocate .sub_active").css({"display":"none"});
		   $("#p_other .sub_active").css({"display":"none"});
		});
		
	  });
	  </script>   
    <!-- google分析统计 -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-50473328-1', 'sifangstreet.com');
  ga('send', 'pageview');

</script>
	</head>
	<body>
        <decorator:getProperty property="body.id" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>
			<%-- ========== 头部开始 ========= --%>
				<%@ include file="./include/header.jspf"%>
				<c:set var="isShowHiddenCategory" value="true"></c:set>
			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========= --%>
			<div class="maincontent" id="product_detail">
			<div class="position-wrap">
					<%@ include file="include/navigatorBar.jspf"%>
					<content tag="heading"> <product:navigatorBar navigatorCategorys="${navigatorCategorys}" pageType="2"/></content>
					
				</div>
		<div class="detail_top">
         <div class="detail_t_left">
           <div class="detail_l_top">
             <div class="detail_l_out">
               <div class="header-2">
                 <a href="${ctxPath}/search-prod.html?brandId=${brand.id}"><h3>${brand.designer}</h3></a>
               </div><!--header-2-->
               <div class="designer_pic">
<cartmatic:img url="${brand.logo}" mediaType="other" alt="" />
                 <div class="rsp"></div>
                 <div class="text">
                   <a href="#">
                  ${brand.story} </a>
                 </div><!--text-->
               </div><!--designer_pic-->
               <div class="designer_story">
                 <a href="${ctxPath}/search-prod.html?brandId=${brand.id}" title="点击浏览品牌页面"><p>品牌故事<span><i class="fa fa-caret-right fa-lg"></i></span></p></a>
               </div><!--designer_story-->
             </div><!--detail_l_out-->
           </div><!--detail_l_top-->
           <div class="detail_l_bottom">
             <div class="detail_l_out">
              <div class="header-2">
                 <h4>产品亮点</h4>
               </div><!--header-2-->
              <p class="detail_point">
             ${product.productDescription.shortDescription}
              </p><!--detail_point-->
             </div><!--detail_l_out-->
           </div><!--detail_l_bottom-->
         </div><!--detail_t_left-->
          <div class="detail_mid">
               <div class="detail_thumb_big">
                  <img id="zoom_03" src="/images/detail/1.jpg" data-zoom-image="/images/detail/1_large.jpg" width="380"/>
                 </div><!--detail_thumb_big-->
              
            <div id="gallery_01" class="slider2">

              <a  href="#" class="elevatezoom-gallery active" data-update="" data-image="/images/detail/1.jpg" 
data-zoom-image="images/detail/1_large.jpg">
<img class="etalage_small_thumbs "src="/images/detail/1.jpg" width="100"  /></a>
             
                  <a  href="#" class="elevatezoom-gallery" data-update="" data-image="/images/detail/2.jpg" 
data-zoom-image="/images/detail/2_large.jpg">
<img class="etalage_small_thumbs "src="images/detail/2.jpg" width="100"  /></a>
             
                   <a  href="#" class="elevatezoom-gallery" data-update="" data-image="/images/detail/3.jpg" 
data-zoom-image="/images/detail/3_large.jpg">
<img class="etalage_small_thumbs "src="/images/detail/3.jpg" width="100"  /></a>
              
                  <a  href="#" class="elevatezoom-gallery" data-update="" data-image="/images/detail/4.jpg" 
data-zoom-image="/images/detail/4_large.jpg">
<img src="/images/detail/4.jpg"/></a>              
                   <a  href="#" class="elevatezoom-gallery" data-update="" data-image="/images/detail/5.jpg" 
data-zoom-image="/images/detail/5_large.jpg">
<img src="/images/detail/5.jpg"/></a>
                
             </div><!--gallery_01-->

         </div><!--detail_mid-->
         <div class="detail_t_right">
           <p class="detail_title">${product.productName }</p>
           <p class="sale_price">
             <span class="price">
             <c:choose>
	<c:when test="${product.defaultProductSku.priceViewType==2||product.defaultProductSku.priceViewType==3}">
		<div class="left">
			<fmt:message key="productDetail.ourPrice" />:<span id="priceSpan" class="ourPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></span>
		</div>
		<div class="clear"></div>
		<div class="left">
			<fmt:message key="productDetail.discountPrice" />: <span id="salesPriceSpan" class="price"><system:CurrencyForRate value="${defaultProductSkuPrice}" /></span>
			<fmt:message key="productDetail.saved"/>:<system:CurrencyForRate value="${product.defaultProductSku.price-defaultProductSkuPrice}" />
		</div>
		<div class="clear"></div>
	</c:when>
	<c:otherwise>
		<div class="left">
			<fmt:message key="productDetail.ourPrice" />:<span id="priceSpan" class="price"><system:CurrencyForRate value="${defaultProductSkuPrice}" /></span>
		</div>
		<div class="clear"></div>
	</c:otherwise>
</c:choose>
</span>
            </p><!--sale_price-->
           <div class="detail_information">
             <p class="product_designer">
               by<span class="designer_name">${brand.designer}</span>
             </p><!--product_designer-->
             <p class="product_brand">
               <i class="fa fa-tag"></i><span>${brand.designer}（${brand.countryCode}） 设计师旗下品牌</span>
             </p><!--product_brand-->
             <p class="product_barcode">
               <i class="fa fa-barcode fa-lg"></i><span>产品编号:${product.defaultProductSku.productSkuCode}</span>
             </p><!--product_barcode-->
           </div><!--detail_information-->
           
           
           
           
           
           <div class="product_color">
               <span class="chose"><span id="color_black"></span></span>
               <span id="color_gold"></span>
               <span id="color_silvery"></span>
           </div><!--product_color-->
           <div class="product_size">
               <p><img src="images/size.png" width="11"/><span class="size_ruler">尺码对照表</span></p>
               <ul class="size">
                   <li><a href="#">34</a></li>
                   <li><a href="#">35</a></li>
                   <li><a href="#" class="current">36</a></li>
                   <li><a href="#">37</a></li>
               </ul>
           </div><!--product_size-->
           <div class="product_quantity">
             <form id="myform" method="POST" action="#">
               <input id="min" name="" type="button" value="-" />
               <input id="text_box" name="" type="text" value="1" />
               <input id="add" name="" type="button" value="+" />
             </form>
              <!--product_quantity-->
			  <script>
              $(function(){
                  var t = $("#text_box");
                  $("#add").click(function(){		
                      t.val(parseInt(t.val())+1)
                      setTotal();
                  })
                  $("#min").click(function(){
                      t.val(parseInt(t.val())-1)
                      setTotal();
                  })
                  
              })
              </script>
              
              
              
              
              <div class="product_stock">
               <i class="fa fa-exclamation-circle fa-lg fa_storck"></i>还剩<span>408</span>件
             </div><!--product_stock-->
           </div><!--product_quantity-->
           <div class="product_delivery">
             <i class="fa fa-truck fa-lg fa_storck"></i>${fahuoshijian.attributeValue}
           </div><!--product_delivery-->
           <div class="product_chose">
              <a class="btn btn-danger" href="#">
               <i class="fa fa-shopping-cart fa-lg fa_storck"></i> 放入购物车
              </a>
           </div>
           
           
           
           <div class="product_social">
              <div class="product_love">
                <a href="#" class="addtolove">
                <i class="fa fa-heart fa-lg fa_storck"></i>
                <div id="add_love">点击加入收藏</div>
                </a>
                <div id="love_count"><span>2000</span>个人喜欢</div>
                <script type="text/javascript">
				$(document).ready(function(){
				  $(".addtolove").click(function(){
				  $("#add_love").hide();
				  $("#love_count").show();
				  });
				});
				</script>
              </div><!--product_love-->
              
              
              
              <div class="social_part">
                <div class="bdsharebuttonbox">
                  <a href="#" class="bds_more" data-cmd="more"></a>
                  <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                  <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                  <a href="#" class="bds_douban" data-cmd="douban" title="分享到豆瓣网"></a>
                  <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                  <a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
                  <a href="#" class="bds_mail" data-cmd="mail" title="分享到邮件分享"></a>
                  <a href="#" class="bds_copy" data-cmd="copy" title="分享到复制网址"></a>
                </div><!--bdsharebuttonbox-->
                
                
                <script>
				  window._bd_share_config = {
					  common : {
						  bdText : '我在四方街看中了一款产品，觉得不错，希望小伙伴们能给我出出主意，到底要哪个颜色好呢？中国首家新锐设计师多品牌集成店——四方街网站www.sifangstreet.com',	
						  bdMini : '2',	
						  bdMiniList : ['mogujie','meilishuo','duitang','huaban','diandian','fbook','linkedin','twi','deli','kaixin001','mshare','tqq','tieba','bdysc','ty','bdxc','bdhome','tsohu','taobao','hi','t163','tfh','fx','youdao','qingbiji','ifeng','people','xinhua','ff','isohu','wealink','xg','print']
					  },
					  share : [{
						  "bdSize" : 16,
						  "bdStyle": 2,
						  "bdCustomStyle": 'css/baidu_share.css'
						  
					  }]
				  }
				  with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
                </script>
              
              </div><!--social_part-->
              
              
              
           </div><!--product_social-->
         </div><!--detail_t_right-->
       </div><!--detail_top-->
    <%-- ========== 内容结束 ========= --%>
           
			<%-- ========== 底部开始 ========= --%>
				<%@ include file="./include/footer.jspf"%>
			
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>