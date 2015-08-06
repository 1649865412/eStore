<%--
产品详情页修订版
--%>
<%@ page pageEncoding="utf-8"%>
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

<html>
	<head>
		<c:set var="productPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></c:set>
		<c:set value="${empty product.title?product.productName:product.title}" var="pageTitle"></c:set>
		<TITLE>${pageTitle}</TITLE>
		<meta name="keywords" content="<c:out value="${product.metaKeyword}"/>" />
		<meta name="description" content="<c:out value="${empty product.metaDescription ? product.productName : product.metaDescription}"/>" />

      <meta name="baidu-site-verification" content="3PsP8afx3G">
      
      <link href="${resPath}/styles/global.css" rel="stylesheet" type="text/css" />
      <link href="${resPath}/styles/head_foot.css" rel="stylesheet" type="text/css" />
		
      <link rel="stylesheet" href="${resPath }/styles/jquery.bxslider.css" type="text/css" />
      <link href="${resPath }/styles/nav.css" rel="stylesheet" type="text/css"/>
      <link href="${resPath }/styles/main.css" rel="stylesheet" type="text/css"/>
      <!--product detail css-->
      <link rel="stylesheet" href="${resPath }/styles/tabs.css" type="text/css" media="screen" />
      <!--detail page css-->
      <link href="${resPath }/styles/detail.css" rel="stylesheet" type="text/css" />
      <link href="${resPath }/styles/comment.css" rel="stylesheet" type="text/css">
      <!-- Include the awesome icon css -->
      <link href="${resPath }/font-awesome/css/font-awesome.min.css" rel="stylesheet"/>


      
      <!-- Include the story plugin: -->
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
          
      <!-- Add fancyBox main JS and CSS files -->
      
      <link rel="stylesheet" type="text/css" href="${resPath }/styles/jquery.fancybox.css" media="screen" />
    </script>
	  <!-- Include the elevatezoom plugin: -->
      
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
			loadingIcon: "${resPath}/images/bx_loader.gif"
			}); 

		  $("#zoom_03").bind("click", function(e) {
				var ez =   $('#zoom_03').data('elevateZoom');
				//ez.closeAll(); //NEW: This function force hides the lens, tint and window	
				var list2 = ez.getGalleryList_2();
				$.fancybox(list2);
				return false;
		  }); 
	  
	  }); 

      </script>
      <!--bxslider-->
      
      <script>
	  $(function(){
		  $('.slider2').bxSlider({
			  pager: false,
			  controls:true,
			  wrapper_class: 'sale_popular',
			  pause: 2500,
			  slideWidth: 100,
			  minSlides: 4,
			  maxSlides: 4,
			  slideMargin: 4
		  });
	  });
      </script>
      <!--product detail-->
      
      <!--comment-->
      
      <script>
	   $(function() {
			$.fn.raty.defaults.path = 'lib/img';
			var $star = $('.target_star');
			$star.each(function(){
				var $this = $(this);
				var rate = $this.next().val();
				$this.raty({ 
					  readOnly: true, 
					  score: rate ,
					  number: 5,//多少个星星设置		
					  path      : '${resPath}/images',
					  size      : 24,
					  starOff   : 'star-off.png',
					  starOn    : 'star-on.png',
					  cancel    : false,
					  targetKeep: true
				 });
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
		$("#p_designer_oth .sub_active").css({"display":"inline-block"});
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
      <!--[if lt IE 9]>
      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
      <![endif]-->
   </head>
   <body> 
   <content tag="heading"> <product:navigatorBar navigatorCategorys="${navigatorCategorys}" pageType="2"/></content>
      <div class="maincontent" id="designer_detail">
       <div class="detail_top">
         <div class="detail_t_left">
           <div class="detail_l_top">
             <div class="detail_l_out">
               <div class="header-2">
                 <a href="${ctxPath}/search-prod.html?brandId=${product.brand.id}" target="_blank"><h3>${product.brand.designer}</h3></a>
               </div><!--header-2-->
               <div class="designer_pic">
                 <a href="${ctxPath}/search-prod.html?brandId=${brand.id}" target="_blank">
                	 <cartmatic:img url="${product.brand.logo}" mediaType="other" width="100" height="152"></cartmatic:img>
                 </a>
                 <div class="rsp"></div>
                 <div class="text">
                   <a href="#">
                     <p>
                     	${product.brand.story }
                     </p>
                   </a>
                 </div><!--text-->
               </div><!--designer_pic-->
               <div class="designer_story">
                  <p style="cursor: pointer;">品牌故事<span><i class="fa fa-caret-right fa-lg"></i></span></p>
               </div><!--designer_story-->
             </div><!--detail_l_out-->
           </div><!--detail_l_top-->
           <div class="detail_l_bottom">
             <div class="detail_l_out">
              <div class="header-2">
                 <h4>品牌简介</h4>
               </div><!--header-2-->
              <p class="detail_point">
              	${product.productDescription.shortDescription}
              </p><!--detail_point-->
             </div><!--detail_l_out-->
           </div><!--detail_l_bottom-->
         </div><!--detail_t_left-->
         
         <div class="detail_mid">
         
               <div class="detail_thumb_big">
                  <img id="zoom_03"  
                  	src="${mediaPath}productMedia/d/${productMoreImages[0].mediaUrlLarge}" 
                  	data-zoom-image="${mediaPath}productMedia/v/${productMoreImages[0].mediaUrlLarge}" 
                  	width="380" />
                 </div>
              
             <div class="detail_thumb">
	            <div id="gallery_01" class="slider2">
	            	<c:forEach items="${productMoreImages}" var="productMoreImage" varStatus="s">
						<a  href="#" class='elevatezoom-gallery <c:if test="${s.index==0 }">active</c:if>' data-update=""
							 data-image="${mediaPath}productMedia/d/${productMoreImage.mediaUrlLarge}"
							 data-zoom-image="${mediaPath}productMedia/v/${productMoreImage.mediaUrlLarge}">
							 <cartmatic:img url="${productMoreImage.mediaUrlLarge}" mediaType="productMedia" size="d" alt="" width="100"/>
						</a>
					</c:forEach>
					<c:forEach items="${productMoreImagesUp}" var="productMoreImage" varStatus="s">
						<a  href="#" class='elevatezoom-gallery' data-update=""
							 data-image="${mediaPath}productMedia/d/${productMoreImage.mediaUrl}"
							 data-zoom-image="${mediaPath}productMedia/v/${productMoreImage.mediaUrl}">
							 <cartmatic:img url="${productMoreImage.mediaUrl}" mediaType="productMedia" size="d" alt="" width="100"/>
						</a>
					</c:forEach>
	             </div>
			</div>
			
         </div>
         
         <div class="detail_t_right">
         
           <p class="detail_title">${product.productName}</p>
           
           <p class="sale_price">
             <%@ include file="./include/productTemplate_priceArea.jspf"%>
           </p><!--sale_price-->
           
           <div class="detail_information">
             <p class="product_designer">
               by<span class="designer_name">${product.brand.brandName}</span>
             </p><!--product_designer-->
             <p class="product_brand">
               <i class="fa fa-tag"></i><span>${product.brand.designer}设计师旗下品牌</span>
               
             </p><!--product_brand-->
             <p class="product_barcode">
               <i class="fa fa-barcode fa-lg"></i><span>产品编号: ${product.productCode}</span>
             </p><!--product_barcode-->
           </div><!--detail_information-->
           
           <input type="hidden" id="productId" value="${product.productId}" />
           <input type="hidden" id="productCode" value="${product.productCode}" />
           <input type="hidden" id="productName" value="${product.productName}" />
           <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
           <input type="hidden" id="accessoriesSkuCodes" value="" />
           <input type="hidden" id="categoryId" value="${category.categoryId}" />
           <input type="hidden" id="product_simpleName" value="<app:interceptString str="${product.productName}" length="50"></app:interceptString>" />
           <input type="hidden" id="productLinkUrl" value="${uri}" />
           <input type="hidden" id="listPrice" value="${product.defaultProductSku.listPrice}" />
           
  			<div id="skuOptions">
                 <c:forEach items="${productSkuOptionAndValues}" var="productSkuOptionAndValue">
                 	<div class="tb-prop tm-clear">
							<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'color') > -1}">
								<div class="product_color">
									<%--图片 --%>
									<ul class="tm-clear J_TSaleProp tb-img" data-property="${productSkuOptionAndValue.key.skuOptionName}">
										<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
											<li data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}" >
													<a  id="color_${skuOptionValue.skuOptionValue }" class="imageSku"  href="#">
														<span>${skuOptionValue.skuOptionValueName}</span>
														<!--  background: url(<product:productImg sku="${skuOptionValue.sku}" size="a" isUrlOnly="true"/>) center no-repeat; -->
													</a>
											</li>
				                        </c:forEach>
									</ul>
								</div>
							</c:if>
                                  
							<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'size') > -1}">
								<div class="product_size">
									<p onclick="javascript:window.open('${resPath}/images/layout/sizechart.jpg')" style="cursor: pointer;">
										<img src="${resPath }/images/size.png" width="11"/>
										<span class="size_ruler">尺码对照表</span>
									</p>
									<%--文本 --%>
	                                 <ul class="size" data-property="${productSkuOptionAndValue.key.skuOptionName}">
										<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
											<li data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}" >
											<a href="#">
												<span>${skuOptionValue.skuOptionValueName}</span>
											</a>
											</li>
				                        </c:forEach>
									</ul>
								</div>
							</c:if>
					</div>
                 </c:forEach>
           	</div>
           	
           	<c:if test="${productSkuOptionAndValues==null}">
	           	<div class="product_color">
	               <span class="chose"><span id="color_black"></span></span>
	           </div><!--product_color-->
	           <div class="product_size">
	               <p onclick="javascript:window.open('${resPath}/images/layout/sizechart.jpg')" style="cursor: pointer;">
	               		<img src="${resPath }/images/size.png" width="11"/>
		               <!-- <a href="${resPath }/images/layout/sizechart.jpg" target="_blank"></a> -->
		               <span class="size_ruler" >
		              		尺码对照表
		               </span>
	               </p>
		               <ul class="size">
		                   <li><a href="#" class="current">36</a></li>
		               </ul>
         	  </div><!--product_size-->
           	</c:if>
			
           <div class="product_quantity">
           	<product:productQuantity2 product="${product}" />
             <form id="myform" method="POST" action="#">
               <input id="min" name="" type="button" value="-" />
               <input id="quantity" name="quantity" type="text"  value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
               <input id="add" name="" type="button" value="+" />
             </form>
              <!--product_quantity-->
			  <script>
              $(function(){
                  var t = $("#quantity");
                  $("#add").click(function(){		
                      t.val(parseInt(t.val())+1)
                      //setTotal();
                  })
                  $("#min").click(function(){
                      if(parseInt(t.val()) == 1)
                          t.val(1);
                      else{
                    	  t.val(parseInt(t.val())-1)
                          //setTotal();
                      }
                  })
                  
              })
              </script>
             
             <%--
             <div class="product_stock">
               <i class="fa fa-exclamation-circle fa-lg fa_storck"></i>
                还剩<span>${maxOrderQuantity == null ? 0 :  maxOrderQuantity}</span>件
             </div><!--product_stock-->
            --%>
             
             
           </div><!--product_quantity-->
          
           <div class="product_delivery">
           	 <attribute:attributeValue attributeCode="fahuoshijian" attributeValueVar="fahuoshijian" entity="${product}"/>
             <i class="fa fa-truck fa-lg fa_storck"></i>
             付款后
             <span>
             	<c:if test="${fahuoshijian.attributeValue == null}">
             		10
             	</c:if>
             	<c:if test="${fahuoshijian.attributeValue != null}">
             		${fn:substring(fahuoshijian.attributeValue,0,fn:indexOf(fahuoshijian.attributeValue,'天'))}
             	</c:if>
             </span>个工作日发货
             <c:if test="${fahuoshijian.attributeValue != null}">
             		${fn:substringAfter(fahuoshijian.attributeValue,'货')}
             	</c:if>
             <span id="selectedProdMsg"></span>
           </div><!--product_delivery-->
           <%--秒杀立即够买 --%>
          <%--<c:choose>
           <c:when test="${param.flag==65456}">
	                <button id="button2id" name="button2id" class="btn detail_sold margin_b" type="button">
	          <i class="fa fa-ban fa-lg fa_storck"></i>      已抢光了
	                
	                </button>
            </c:when>
           <c:when test="${param.flag==5613}">
	                <button id="button2id" name="button2id" class="btn detail_will_start margin_b" type="button" title="秒杀产品数量有限，下单后请尽快付款，末件产品以优先支付订单为准">
	           <i class="fa fa-bolt fa-lg fa_storck"></i>      即将开始
	               
	                </button>
            </c:when>
            
            <c:when test="${param.flag==562345}">
	           <!--      <button id="button2id" name="button2id" class="btn detail_start margin_b" type="button">
	               <i class="fa fa-gavel fa-lg fa_storck"></i> 立即抢购
	                </button> -->
	                
	                <product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart"  flag="${param.flag}"/>
	                
            </c:when>
           
             购物车test="${param.flag==2||param.flag==null}"
           <c:otherwise ><product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
				</c:otherwise>
				</c:choose>

			--%><product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />

           <div class="product_social">
           
              <div class="product_love">
                <a href="#" class="addtolove" onclick="addToFavorite(${product.id});return false;" >
               		 <i class="fa fa-heart fa-lg fa_storck"></i>
	                <div id="add_love">
	               	 点击加入收藏
	                </div>
                </a>
                <div id="love_count"><a href="#"  onclick="addToFavorite(${product.id});return false;" >点击加入收藏</a></div>
                <script type="text/javascript">
				$(document).ready(function(){
				  $(".addtolove").click(function(){
				  $("#add_love").hide();
				  $("#love_count").show();
				  });
				});
				function changeToOne(obj){
					if($(obj).val() == ""){
						$(obj).val(1);
					}
				}
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
						  bdText : '我在四方街看中了一款产品，觉得不错，希望小伙伴们能给我出出主意，到底要哪个颜色好呢？中国首家新锐设计师多品牌集成店——四方街网站www.sifangstreet.com   ',	
						  bdMini : '2',	
						  bdMiniList : ['mogujie','meilishuo','duitang','huaban','diandian','fbook','linkedin','twi','deli','kaixin001','mshare','tqq','tieba','bdysc','ty','bdxc','bdhome','tsohu','taobao','hi','t163','tfh','fx','youdao','qingbiji','ifeng','people','xinhua','ff','isohu','wealink','xg','print']
					  },
					  share : [{
						  "bdSize" : 16,
						  "bdStyle": 2,
						  "bdCustomStyle": '${resPath}/styles/baidu_share.css'
						  
					  }]
				  }
				  with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
                </script>
              
              </div><!--social_part-->
           </div><!--product_social-->
         
           
           
         </div><!--detail_t_right-->
       </div><!--detail_top-->
       
       
       <div class="detail_bottom">
         <div class="detail_b_left">
            <div class="sidebar">
                <ul>
	                <li>
	                <a href="javascript:void(0);" id="silerbar_click">
	                <i class="fa fa-bars push" id="title_icon"></i>
	                <span id="siderbar_title">该设计师其他款式</span>
	                </a>
	                   <ul class="sub-menu">
	                   	<li>
	                       <a href="" id="" class="current"><span class="sub_active"></span>该设计师其他款式</a>
	                     </li>
	                     <li>
	                       <a href="" id="p_other"><span class="sub_active"></span>相似款式</a>
	                     </li>
	                       <li>
	                       <a href="" id="p_collocate"><span class="sub_active"></span>可选配件</a>
	                     </li>
	                   </ul><!--sub-->
	                </li>
	              </ul>
	             <div class="p_side">	
	            	 <div class="p_s_sth">
	                	<!-- 该设计师其他款式 -->
		             	<jsp:include flush="true" page="/sales/recommendedProduct.html">
				             <jsp:param name="typeName" value="same_brand" />
				             <jsp:param name="firstResult" value="0" />
				             <jsp:param name="maxResults" value="5" />
				             <jsp:param name="template" value="sales/include/recommendProductContent" />
				             <jsp:param name="doAction" value="defaultAction" />
				             <jsp:param name="sourceId" value="${product.productId}" />
				         </jsp:include>
				        </div>
	             	<div class="p_s_sth">
	             		 <!-- 相似款式  -->
				         <jsp:include flush="true" page="/sales/recommendedProduct.html">
				             <jsp:param name="typeName" value="similar_product" />
				             <jsp:param name="firstResult" value="0" />
				             <jsp:param name="maxResults" value="5" />
				             <jsp:param name="template" value="sales/include/recommendProductContent" />
				             <jsp:param name="doAction" value="defaultAction" />
				             <jsp:param name="sourceId" value="${product.productId}" />
				         </jsp:include>
				      </div>
				      
				         <div class="p_s_sth">
	             		 <!-- 可选配件  -->
				         <jsp:include flush="true" page="/sales/recommendedProduct.html">
				             <jsp:param name="typeName" value="accessories" />
				             <jsp:param name="firstResult" value="0" />
				             <jsp:param name="maxResults" value="5" />
				             <jsp:param name="template" value="sales/include/recommendProductContent" />
				             <jsp:param name="doAction" value="defaultAction" />
				             <jsp:param name="sourceId" value="${product.productId}" />
				         </jsp:include>
				      </div>
			      </div>
             </div>
            
         </div><!--detail_b_left-->
         <div class="detail_b_right hot_trends">
         <div class="tabs_postion">
            <ul class="tabs">
	            <li><a href="#">产品写真&nbsp;|</a></li>
	            <li><a href="#">产品详情&nbsp;|</a></li>
	            <li><a href="#">商品评论&nbsp;|</a></li>
	            <li><a href="#">达人秀场</a></li>
            </ul><!-- tab "panes" -->
          </div><!--tabs_postion-->
          <div class="boards">
          
           <!-- id="productImages" -->
           <div class="board" id="productImages">
             <div class="detail_r_design">
               <cartmatic:img url="${product.productHandDraw.mediaUrl}" mediaType="productMedia" size="hd" alt=""/>
             </div><!--detail_r_design-->
             <div class="detail_r_text">
               <p>
             	 	${product.productDescription.imageDescription}
               </p>
             </div><!--detail_r_text-->
             <div class="detail_r_detailpic">
               <div class="detail_r_pic">
                	<%-- ===================== 产品写真  =====================--%>
			        <c:forEach items="${productMoreImages}" var="productMoreImage">
			            <cartmatic:img url="${productMoreImage.mediaUrlLarge}" mediaType="productMedia" size="d" alt=""/>
			        </c:forEach>
               </div><!--detail_r_pic-->
             </div><!--detail_r_pic-->
           </div><!--id="productImages"-->
           
            <!-- productDescription -->
           <div class="board" id="productDescription">
             <div class="product_description">
               <ul>
					<li>商品名称：${product.productName }</li>
					<li>商品编码：${product.productCode }</li>
					<li>设计师：${product.brand.brandName }</li>
					<li>上架时间：<fmt:formatDate value="${product.publishTime}" pattern="yyyy-MM-dd"/></li>
					<c:if test="${not empty product.defaultProductSku.weight}">
						<li>商品毛重：${product.defaultProductSku.weight}${appConfig.weightUnit }</li>
					</c:if>
					<c:forEach items="${productAttGroups}" var="productAttGroup">
						<c:forEach items="${productAttGroup.productAttrValues}" var="productAttrValue">
							<c:if test="${not empty productAttrValue.attributeValue}">
								<li>${productAttrValue.attribute.attributeName}：
									<c:choose>
										<c:when test="${productAttrValue.attributeDataType==1}">
											${fn:replace(productAttrValue.attributeValue,",","，")}
										</c:when>
										<c:otherwise>${productAttrValue.attributeValue}</c:otherwise>
									</c:choose>
								</li>
							</c:if>
						</c:forEach>
					</c:forEach>
				</ul>    
              <p>
              	<product:htmlConverter content="${product.productDescription.fullDescription}"></product:htmlConverter>   
              </p>
             </div><!--product_description-->
           </div><!--productDescription-->
           
            <!-- b3 -->
            
            <div class="board" id="b3">
	            <jsp:include flush="true" page="/review/product/${product.productId}.html">
	                <jsp:param name="PrmItemsPerPage" value="10" />
	            </jsp:include>
	         </div>
            
           <!-- b4 -->
           <div class="board" id="b4">
           </div><!--b4-->
          </div><!--boards-->
			<script>
            // perform JavaScript after the document is scriptable.
            $(function() {
                // setup ul.tabs to work as tabs for each div directly under div.panes
                $(".tabs").tabs("div.boards > div.board");	
				$(".sub-menu").tabs("div.p_side > div.p_s_sth");	
                
            });
            </script>
         </div><!--detail_b_right-->
       </div><!--detail_bottom-->
      
      
      </div><!--end of maincontent-->
      
      
      
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
<script type="text/javascript" defer>
var skuWholesalePrices = new Array();
<c:if test="${product.status==1}">
<%--产品价格包括批发价--%>
skuWholesalePrices[0]=[1,"${defaultProductSkuPrice}"];
<c:forEach items="${skuWholesalePrices}" var="wholesalePrice" varStatus="varStatus">
	skuWholesalePrices[${varStatus.count}]=["${wholesalePrice.minQuantity}","${wholesalePrice.price}"];
</c:forEach>
<c:if test="${product.productKind==2}">
var jProduct=${jsonProduct};
$("#skuOptions").children("div.tb-prop").find("li[data-value]").click(function(){
	if($(this).hasClass("tb-out-of-stock")){return false;};
	if($(this).toggleClass("tb-selected").hasClass("tb-selected")){
		$(this).append("<i>selected</i>").siblings("li").removeClass("tb-selected").children("i").remove();
	}else{
		$(this).children("i").remove();
	}
	var selectedOptions=$("#skuOptions").children("div.tb-prop").find("li.tb-selected[data-value]");
	var selectOptions=$("#skuOptions").children("div.tb-prop").find("li[data-value]").not(".tb-selected");
	
	var aOptionValueIds=",";
	var skus=jProduct.productSkus;
	
	for(var i=0;i<selectOptions.length;i++){
		var selectOption=$(selectOptions[i]);
		var optionId=selectOption.attr("data-value").split(":")[0];
		var optionValueId=selectOption.attr("data-value").split(":")[1];
		var hasMatchSku=false;
		var sku=null;
		for (k in skus){
			sku=skus[k];
			var skuOptions=sku.skuOptions;
			var hasOptionValue=false;
			for(j in skuOptions){
				var skuOption=skuOptions[j];
				if(selectOption.attr("data-value")==(skuOption.id+":"+skuOption.vid)){
					hasOptionValue=true;
					break;
				}
			}
			if(hasOptionValue){
				hasMatchSku=true;
			}else{
				continue;
			}
			for(var j=0;j<selectedOptions.length;j++){
				var selectedOption=$(selectedOptions[j]);
				var selectedOptionId=selectedOption.attr("data-value").split(":")[0];
				if(optionId!=selectedOptionId){
					hasOptionValue=false;
					for(l in skuOptions){
						var skuOption=skuOptions[l];
						if(selectedOption.attr("data-value")==(skuOption.id+":"+skuOption.vid)){
							hasOptionValue=true;
							break;
						}
					}
					if(!hasOptionValue){
						hasMatchSku=false;
						break;
					}
				}
			}
			if(hasMatchSku){
				break;
			}
		}
		if(hasMatchSku){
			if(aOptionValueIds.indexOf(","+optionValueId+",")==-1){
				aOptionValueIds+=optionValueId+",";
			}
		}
	}
		
	for(var i=0;i<selectOptions.length;i++){
		var option=$(selectOptions.get(i));
		var optionV=option.attr("data-value").split(":");
		if(aOptionValueIds.indexOf(","+optionV[1]+",")==-1){
			option.addClass("tb-out-of-stock");
		}else{
			option.removeClass("tb-out-of-stock");
		}
	}
		
	var selectedSku=null;
	for (i in skus){
		var sku=skus[i];
		var skuOptions=sku.skuOptions;
		var isMatch=false;
		for(j in skuOptions){
			isMatch=false;
			var skuOption=skuOptions[j];
			for(var k=0;k<selectedOptions.length;k++){
				if($(selectedOptions[k]).attr("data-value")==(skuOption.id+":"+skuOption.vid)){
					isMatch=true;
					break;
				}
			}
			if(!isMatch){
				break;
			}
		}
		if(isMatch){
			selectedSku=sku;
			break;
		}
	}
	var add2CartBtn=$("#add2Cart"+${product.id});
	if(selectedSku){
		//更新图片
		$("#productImgA").find("img").attr("src",__mediaPath+"product/d/"+selectedSku.image);
		//价格
		var skuPrice=selectedSku.salePrice!=null?selectedSku.salePrice:selectedSku.discountPrice!=null?selectedSku.discountPrice:selectedSku.price;
		$("#priceSpan").attr("data-value",skuPrice).html(fnFormatPrice(skuPrice));
		$("#priceSpan").next("span[name='otherCurrency']").attr("defaultvalue",skuPrice);
		if(selectedSku.priceViewType==2||selectedSku.priceViewType==3){
			$("#listPriceSpan").html('<del>'+fnFormatPrice(selectedSku.price)+'</del>').show();
			$("#discountPercent").html("("+selectedSku.discountPercent+"% OFF)");
		}else{
			$("#listPriceSpan,#discountCount").hide();
		}
		$("#productSkuCodeSpan").html(selectedSku.productSkuCode);
		$("#productSkuCode").val(selectedSku.productSkuCode);
		$("#productSkuId").val(selectedSku.productSkuId);
		$("#productWeightSpan").attr("data-value",selectedSku.weight+"").html(selectedSku.weight);
		if(!selectedSku.inventory){
			$("#productStockSpan").html("有现货");
			add2CartBtn.removeClass("stock").removeClass("no-addtocart").removeAttr("disabled").attr("title",__FMT.minicart_addToCart).val(__FMT.minicart_addToCart);
		}else if(selectedSku.inventory.availableQuantity>0){
			$("#productStockSpan").html(selectedSku.inventory.availableQuantity+" 件");
			add2CartBtn.removeClass("stock").removeClass("no-addtocart").removeAttr("disabled").attr("title",__FMT.minicart_addToCart).val(__FMT.minicart_addToCart);
		}else{
			$("#productStockSpan").html(__FMT.outOfStock);
			add2CartBtn.addClass("stock").attr("disabled","disabled").attr("title",__FMT.outOfStock).val(__FMT.outOfStock);
		}
		
		$("#skuWholesalePriceTbl").find("tr").slice(1).remove();
		skuWholesalePrices=selectedSku.wholesalePrices.slice(0,selectedSku.wholesalePrices.length);
		skuWholesalePrices.unshift([1,skuPrice]);
		$("#skuWholesalePriceTbl").append('<tr><td>1-1</td><td>'+fnFormatPrice(skuPrice)+'<span defaultvalue="'+skuPrice+'" name="otherCurrency"></span></td></tr>');
		for(var i=1;i<skuWholesalePrices.length;i++){
			var ws_qty=skuWholesalePrices[i][0]+"+";
			if(i<skuWholesalePrices.length-1){
				ws_qty=skuWholesalePrices[i][0]+"-"+(skuWholesalePrices[i+1][0]-1);
			}
			$("#skuWholesalePriceTbl").append('<tr><td>'+ws_qty+'</td><td>'+fnFormatPrice(skuWholesalePrices[i][1])+'<span defaultvalue="'+skuWholesalePrices[i][1]+'" name="otherCurrency"></span></td></tr>');
		}
		fnChangePrice();
	}else{
		add2CartBtn.removeClass("stock").addClass("no-addtocart").removeAttr("disabled").val(__FMT.minicart_addToCart);
	}
	
	var skuOptions=$("#skuOptions").children("div.tb-prop").find("li.tb-selected");
	var name="";
	skuOptions.each(function(i){
		if($(this).find("span").length!=0){
			name+=$(this).find("span").text();
		}
	});
	var msg="";
	if(name!=""){
		msg="已选："+name;
		if(selectedSku&&((!selectedSku.inventory)||selectedSku.inventory.availableQuantity>0)){
			msg+='&nbsp;&nbsp;<span class="mark_co">现在有货</span>';
		}
	}
	$("#selectedProdMsg").html(msg);
	return false;
});

function checkAddProductToCart(){
	var skuOptions=$("#skuOptions").children("div.tb-prop").find("ul[data-property]");
	var name="";
	skuOptions.each(function(i){
		if($(this).find("li.tb-selected").length==0){
			name+="."+$(this).attr("data-property");
		}
	});
	if(name!=""){
		alert("请选择 "+name);
	}
	return name=="";
}
</c:if>
</c:if>

//图片lightbox,稳定好移到js
function showLightbox(){
	var lightbox=$("#lightbox");
	var left=Math.round((($(document).width()||$(window).width())-lightbox.width())/2);
	var top=Math.round($("html").scrollTop()+($(window).height()-lightbox.height())/2);
	if(top<0)top=0;
	$("#lightboxOverlay").show();
	lightbox.css({ top: top, left: left }).show();
}

$("#lb-close,#lightboxOverlay").click(function(){
	$("#lightbox").hide();
	$("#lightboxOverlay").hide();
});
$("#lb-thumbnailContent").children().click(function(){
	$(this).addClass("selected").siblings().removeClass("selected");
	$("#lb-image").attr("src",__resPath+"/images/img/empty.gif");
	$("#lb-image").attr("src",__resPath+"/images/img/empty.gif").attr("src",$(this).children("img").attr("src").replace("/a/","/v/"));
});
$("#lb-previous").click(function(){
	$("#lb-thumbnailContent").children(".selected").prev().click();
});
$("#lb-next").click(function(){
	$("#lb-thumbnailContent").children(".selected").next().click();
});
$("a[target='popup_larger_image']").click(function(){
	var thumbImgUrl=$("#imgContent").children(".selected").children("img").attr("src");
	$("#lb-thumbnailContent").find("img[src='"+thumbImgUrl+"']").parent().click();
	showLightbox();
	return false;
});
</script>

<%--购物车弹出层 begin --%>
<textarea id="shoppingCartTemplate" style="display: none;">
	<h2>
		已将{0}件商品加入购物车！
	</h2>
	<div class="left">
		<div class="wrap-line">
			<div class="photo">
				<img src="${appConfig.store.mediaUrlPath}/product/e/{1}" width="165" height="165" alt="" onerror="$(this).attr('originsrc',this.src).attr('src',__defaultImage).removeAttr('onerror');" originsrc=""/>
			</div>
			<div class="txt">
				{2}
				<div class="blank10"></div>
				<strong class="red f13px">{3}</strong>
				<br>
					<strong class="f13px">数量:{4}</strong>
			</div>
		</div>
	</div>
	<div class="right">
		{5}件商品在您的购物车内
		<br>
		<strong class="f18px">小计: <span class="red">{6}</span>
		</strong>
		<div class="blank10"></div>
		<div class="out">
			<button class="toggle1 checkout" title="CheckOut" type="button"
				value="CheckOut"
				onclick="window.location.href='/cart/shoppingcart.html'">
				去结算
			</button>
		</div>
		<div class="shop">
			<a onclick="closeSimpleDialog('shoppingcartAlertWId_');return false;" href="#">继续购物</a>
		</div>
	</div>
</textarea>
<%--购物车弹出层 end --%>
<%--收藏夹弹出层 begin --%>
<div id="favoriteTemplate" style="display: none;">
	<h2>
		{0}
	</h2>
	<a href="/myaccount/favorites.html">您可以 查看收藏夹</a>
</div>
<%--收藏夹弹出层 end --%>
      
   </body>
</html>