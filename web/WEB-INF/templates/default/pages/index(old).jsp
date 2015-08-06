<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<html>
	<head>
		<title>${appConfig.store.title}</title>
		<meta name="keywords" content="${appConfig.store.keyWords}" />
		<meta name="description" content="${appConfig.store.description}" />
		<meta name="baidu-site-verification" content="3PsP8afx3G" />
		<script>
	jQuery(document).ready(function($) {
		$('.grid-container').gridQuote( {
			slideshow : false,
			initOpen : false			
		});
	});
</script>
		<script>
	$(function() {
		$('.big_ab').bxSlider( {
			margin : 0,
			auto : true,
			controls : false,
			autoHover : true,
			mode : 'fade',
			pause : 4000

		});
		$('.hot').bxSlider( {
			margin : 0,
			auto : true,
			controls : false,
			autoHover : true,
			pagerCustom : '.hot_tabs'

		});

		$('.slider2').bxSlider({
			auto: true,
			pager: false,
			controls:true,
			nextSelector: '#slider-next',
			prevSelector: '#slider-prev',
			nextText:'▶',
			prevText:'◀',
			wrapper_class: 'sale_popular',
			pause: 2500,
			slideWidth: 150,
		    minSlides: 6,
		    maxSlides: 6,
		    moveSlides: 1,
		    slideMargin: 30
		});
	});
</script>
<script>
// perform JavaScript after the document is scriptable.
$(function() {
    // setup ul.tabs to work as tabs for each div directly under div.panes
    $("#product_tabs").tabs("div.boards > div.board");	
	$("#css_tabs").tabs("div.css-panes > div.items", {
 
    // enable "cross-fading" effect
    effect: 'default',
    fadeOutSpeed: "slow",
 
    // start from the beginning after the last tab
    rotate: true
 
    // use the slideshow plugin. It accepts its own configuration
    }).slideshow();
	
});
</script>
<%--<!--自动弹出窗-->
 <!-- Add fancyBox main JS and CSS files -->
    <script type="text/javascript" src="${ctxPath}/scripts/jquery/jquery.fancybox.js"></script>
    
    <link rel="stylesheet" type="text/css" href="${resPath}/styles/jquery.fancybox.css?v=2.1.5" 

media="screen" />
    <link href="${resPath}/styles/popout.css" rel="stylesheet" type="text/css">
  <script type="text/javascript">
		$(document).ready(function() {
			$.fancybox('#target');
 
});
		
		</script>

<!--end of 自动弹出窗-->
--%></head>
	<body>
		<%-- ========== 广告开始  修订之后的一个版本========== --%><%--
		 <!--自动弹出窗-->


 <div id="target" class="popout_ad">
   
   <div class="ad_detail_half">
     <h1 class="ad_title margin_TD20">母亲节尊爱巨献</h1>
     <h2 class="detail_title">消费满888元送母亲节鲜花一束</h2>
     <p class="detail_text">关注微信参与母亲节抽奖</p>
     <p class="detail_text">回复”我爱妈妈”送400元优惠券</p>
     <a href="${ctxPath}/static/special47.html" class="btn btn-pupo margin_top30">点击查看详情</a>
   </div>
   
   <div class="ad_detail_half half_last">
     <h1 class="ad_title margin_TD20">四方街网秒杀周</h1>
     <h2 class="detail_title">狂欢继续，秒杀不断</h2>
     <p class="detail_text">5月8日-5月10日</p>
      <p class="detail_text">每天10:00开抢</p>
     <a href="${ctxPath}/seckill.html" class="btn btn-pupo margin_top30">点击查看详情</a>
   </div>
 </div>
<!--end of 自动弹出窗-->
		--%><div class="index-show">
			<div class="left_ab">
				<div class="big_ab">
					<div>
						<content:showAd adPositionType="mainad1" />			
					</div>
					<div>
						<content:showAd adPositionType="mainad2" />
					</div>
					<div>
						<content:showAd adPositionType="mainad3" />
					</div>
					<div>
						<content:showAd adPositionType="mainad4" />
					</div>
				</div>
				<!--big_ab-->
			</div>
			<!--left_ab-->
			<div id="rightphoto">
				<div class="customer-links">
					<content:showAd adPositionType="mainsad1" />
				</div>
				<div class="banner">
					<div class="banner_in">
						<content:showAd adPositionType="mainsad2" />
					</div>
					<div class="banner_in">
						<content:showAd adPositionType="mainsad3" />
					</div>
					<div class="banner_in">
						<content:showAd adPositionType="mainsad4" />
					</div>
				</div>
			</div>
		</div>

		<div class="break">
			<span class="title_Ch_l">设计师推荐</span>
			<p class="title_eng">
				Designers ' Collections
			</p>
		</div>
		<!--break-->
		
		<div class="wrapper">
    <!--for triangle-->
	<div class="popover top">
	
	    <div class="arrow"></div>
	    <div class="popover-inner">
	      <!-- <h3 class="popover-title"></h3> -->
	      <div class="popover-content">
	        
	      </div>
	    </div>
 	</div><!--popover top-->

	<div class="grid-container">
	<c:forEach items="${brandList}" var="brand" varStatus="varStatus"
					end="7">
		<div class="thumb-container" data-title="${brand.designer}<br/> 品牌：${brand.brandName}" data-fontsize="18" data-bgcolor="black">
			<cartmatic:img url="${brand.logo}" mediaType="other" alt="" />
		
				
			<div class="quote-container">
				<p>
                <a href="${ctxPath}/search-prod.html?brandId=${brand.id}"><span class="date-info">More+</span></a>
				</p>
				
			<div class="shoe_section">
                 <div class="designer_shoe">                 
                 <c:forEach items="${brand.products}" var="product"
								varStatus="varStatus" end="9">             

                  <div class="shoe_show">
                  
                   <product:productImg product="${product}" size="e"/>   
              
                   <div class="Item_name">
                     <p class="text_prod">${product.productName}</p> 
                     <p class="price">
                     <product:showPrice productSku="${product.defaultProductSku}" viewType="4"/>
                  
          
                     </p>
                   </div><!--Item_name-->
                  </div><!--shoe_show-->
                 
			</c:forEach>
			</div><!--designer_shoe-->
                </div><!--shoe_section-->
		
				
			</div><!--quote-container-->
		</div><!--thumb-container-->
	
				</c:forEach>
				
					</div><!--grid-container-->
 </div><!--wrapper-->
 
 
		<div class="break">
  <span class="title_Ch_l">热门风向标</span>
  <p class="title_eng">Hot Trends</p>
 </div><!--break-->
 <div class="hot_trends">
  <div id="new_product">
 

	<ul class="tabs" id="product_tabs">
	<li><a href="#">新品上架&nbsp;|</a></li>
	<li><a href="#">热卖款式&nbsp;</a></li>
	
	<%--<li><a href="#">人气收藏&nbsp;|</a></li>
    <li><a href="#">即将售罄</a></li>
--%></ul>
<!-- tab "panes" -->
<!-- /eStore/src/com/cartmatic/estoresf/sales/web/action/RecommendedProductFrontController.java -->
<div class="boards">
<!-- b1 -->
     <div class="board" id="b1">
     <div class="new_big">
                                      <!-- 新品上架的商品 new_arrival 最新商品-->
									<jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
										<jsp:param name="typeName" value="new_arrival" />
										<jsp:param name="firstResult" value="0" />
										<jsp:param name="maxResults" value="1" />
										<jsp:param name="template"
											value="sales/include/recommendProduct4MainPage2" />
										<jsp:param name="doAction" value="defaultAction" />
										<jsp:param name="sourceId"
											value="${appConfig.store.catalog.categoryId}" />
									</jsp:include>
							
	   </div>
  
      <div class="right_small">
                                       <!-- 新品上架的商品  new_arrival-->       
	                                   <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
											<jsp:param name="typeName" value="new_arrival" />
											<jsp:param name="firstResult" value="1" />
											<jsp:param name="maxResults" value="4" />
											<jsp:param name="template"
												value="sales/include/recommendProduct4MainPage" />
											<jsp:param name="doAction" value="defaultAction" />
											<jsp:param name="sourceId"
												value="${appConfig.store.catalog.categoryId}" />
										</jsp:include>

      </div><!--right_small-->		
     </div><!--b1-->
     <!--end of b1-->
	<!-- b2 -->
     <div class="board" id="b2">
        <div class="new_big">
                                    <!-- 热卖款式的商品 hot_sell 热卖商品-->
									<jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
										<jsp:param name="typeName" value="hot_sell" />
										<jsp:param name="firstResult" value="0" />
										<jsp:param name="maxResults" value="1" />
										<jsp:param name="template"
											value="sales/include/recommendProduct4MainPage2" />
										<jsp:param name="doAction" value="defaultAction" />
										<jsp:param name="sourceId"
											value="${appConfig.store.catalog.categoryId}" />
									</jsp:include>							
	   </div>
	     <div class="right_small">
	                                    <!-- 热卖款式的商品 hot_sell 热卖商品 -->
	                                   <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
											<jsp:param name="typeName" value="hot_sell" />
											<jsp:param name="firstResult" value="1" />
											<jsp:param name="maxResults" value="4" />
											<jsp:param name="template"
												value="sales/include/recommendProduct4MainPage" />
											<jsp:param name="doAction" value="defaultAction" />
											<jsp:param name="sourceId"
												value="${appConfig.store.catalog.categoryId}" />
										</jsp:include>

      </div><!--right_small-->		
      </div><!--b2-->
     <!--end of b2-->
</div>


  </div><!--new_product-->
  <!--booking-->
  <div id="booking_hot">
  <div id="product_booking">
    <div class="thumb_tabs">
       
      <ul id="css_tabs" class="tabs">
      <li><a id="t1" href="#">新品预售&nbsp;|</a></li>
      <li><a id="t2" href="#">配饰预售</a></li>  
      </ul>
      <div class="slide_bu">
      <!-- "previous slide" button -->
      <a class="backward"><img src="images/img_narrow_l.gif"/></a>
       <!-- "next slide" button -->
      <a class="forward"><img src="images/img_narrow_r.gif"/></a>
      </div><!--slide_bu-->
    </div><!--thumb_tabs-->
<!-- panes -->
  <div class="css-panes">
   <div class="items">
                                        <!-- 鞋品预售的商品 Hot Wholesale Products -->    
                           <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
											<jsp:param name="typeName" value="hot_wholesale_products" />
											<jsp:param name="firstResult" value="0" />
											<jsp:param name="maxResults" value="3" />
											<jsp:param name="template"
												value="sales/include/recommendProduct4MainPage4" />
											<jsp:param name="doAction" value="defaultAction" />
											<jsp:param name="sourceId"
												value="${appConfig.store.catalog.categoryId}" />
										</jsp:include>
     
     
  <a href="${ctxPath}/new-arrivals/shoespresell_catalog.html"><span class="date-info">More+</span></a>
  </div><!--items-->
  <div class="items">
                                   <!-- 配饰预售的商品 feature_product 特色商品 --> 
                                  <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
											<jsp:param name="typeName" value="feature_product" />
											<jsp:param name="firstResult" value="0" />
											<jsp:param name="maxResults" value="3" />
											<jsp:param name="template"
												value="sales/include/recommendProduct4MainPage4" />
											<jsp:param name="doAction" value="defaultAction" />
											<jsp:param name="sourceId"
												value="${appConfig.store.catalog.categoryId}" />
										</jsp:include>


<a href="${ctxPath}/new-arrivals/accepresell_catalog.html"><span class="date-info">More+</span></a>


</div>
     
  
  </div><!--css-panes-->

  </div><!--product_booking-->
  
  
 <div class="top_hot">
   <div class="hot_section">
   <div class="section_title">
   <p class="hot_title">精选TOP 5</p>
   <div class="hot_tabs">
    <a data-slide-index="0" href=""></a>
    <a data-slide-index="1" href=""></a>
    <a data-slide-index="2" href=""></a>
    <a data-slide-index="3" href=""></a>
    <a data-slide-index="4" href=""></a>
   </div>
  </div><!--section_title-->
  
    <div class="hot">
                             <!-- 精选Top5的商品--Favorite --> 
                             <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
											<jsp:param name="typeName" value="Favorite" />
											<jsp:param name="firstResult" value="0" />
											<jsp:param name="maxResults" value="5" />
											<jsp:param name="template"
												value="sales/include/recommendProduct4MainPage5" />
											<jsp:param name="doAction" value="defaultAction" />
											<jsp:param name="sourceId"
												value="${appConfig.store.catalog.categoryId}" />
										</jsp:include> 
    
       </div><!--hot-->
  </div><!--hot_section-->
  </div><!--top_hot-->

 </div><!--booking_hot-->
 </div><!--hot_trends-->
  
<div class="break">
  <span class="title_Ch_l">品牌播报站</span>
  <p class="title_eng">Brand Issues</p>
 </div><!--break-->
  <!-- 中间的页面 广告4、5、6 -->
 <div class="topic_pic">
  <div class="topic_top">
  <div class="pic_left">
      <content:showAd adPositionType="3adbanner_A" />
      </div>   
       <div class="pic_mid">
       <content:showAd adPositionType="3adbanner_B" />
      </div>
      <div class="pic_right">
       <content:showAd adPositionType="3adbanner_C" />
      </div>   
  </div><!--topic_top-->
  
  <!-- 最下角的杂志页面 广告7、8、9 -->
  <div class="topic_bottom">
   <div class="bottom_left">
        <div class="pic_big">
           <content:showAd adPositionType="3adbanner_D" />
          </div>
   </div><!--bottom_left-->
   <div class="bottom_right">
           <div class="pic_ad">
           <content:showAd adPositionType="3adbanner_E" />
          </div>
           <div class="pic_video">
           <content:showAd adPositionType="3adbanner_F" />
          </div>
   </div><!--bottom_right-->
  </div><!--topic_bottom-->
 </div><!--topic_pic-->
<div class="break">
  <span class="title_Ch_l">人气单品带</span>
  <p class="title_eng">Best Sellers</p>
 </div><!--break-->
 
 <div class="sale_popular">
 
  <div class="outside">
    <p><span id="slider-prev"></span> <span id="slider-next"></span></p>
  </div>
  <div class="slider2">    
               <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
											<jsp:param name="typeName" value="hot_sell" />
											<jsp:param name="firstResult" value="0" />
											<jsp:param name="maxResults" value="10" />
											<jsp:param name="template"
												value="sales/include/recommendProduct4MainPage3" />
											<jsp:param name="doAction" value="defaultAction" />
											<jsp:param name="sourceId"
												value="${appConfig.store.catalog.categoryId}" />
										</jsp:include>
  

    </div><!--slider2-->
 </div><!--sale_popular--><%-- 
 
 <div id="tips" style="display: none;">
 	开始抢购》》》》
</div>
--%><script type="text/javascript">
/*
<!--
function showDD(){
	var popuw = function(skucode,type){
    	this.skucode = skucode;
    	this.type = type;
    }
    popuw.prototype={
    	id:'tips_',
    	skucode:'',
    	type:1,
    	messageDlgZIndex:1000,
		html:$("#tips").html(),
		show:function(){
			  var cartDlg=fnCreateSimpleDialog(this.id,'','',{});
			  $("#_dlgContBox"+this.id).html(this.html);
			  cartDlg.showDialog();
		}
    }
	var win = new popuw('',1);
	win.show();
}
//-->

if("${isRush}"){
	showDD();
}
*/
</script>
 
	</body>
	
</html>
