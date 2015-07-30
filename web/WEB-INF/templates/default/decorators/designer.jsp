<%--
设计师界面
--%>
<!doctype html>
<%@ page pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!--全设计师页面-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>全球新锐设计师-设计师品牌集成|四方街网sifangstreet</title>	
		<meta name="keywords" content="四方街，四方街网，设计师品牌集成店，原创品牌，都市时尚，女鞋，饰品，个性，定制，sifangstreet" />
		<meta name="description" content="四方街网sifangstreet全球新锐设计师频道，提供四方街进驻的新锐设计师及设计师品牌商品信息，新锐设计师个人经历、品牌故事，设计师原创设计、个性时尚、与众不同的商品图片、价格、促销、导购信息。" />
		<%@ include file="./include/styles2.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<%@ include file="./include/styles6.jspf"%>
		<%@ include file="./include/javascripts4.jspf"%>
				     <script>
                   $(function(){
                   $('.top_slider').bxSlider({
					  margin:0,
					  auto: true,
					  controls:false,
					  autoHover:true,
					  mode: 'fade',
					  pause: 4000
					  });
                });
            </script>	
             <script type="text/javascript">
      $(document).ready(function() {
      	$('.filters.designer_list').filters();
      
      	});
    </script>
     <script type="text/javascript">
      $(document).ready(function() {
      	$('.fancybox').fancybox({
			padding : 0
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
			<div class="maincontent" id="designer_main">
			
			 <div class="sort_top">
       <div class="top_slider">
        <div><content:showAd adPositionType="designerlist_1" /></div>
        <div><content:showAd adPositionType="designerlist_2" /></div>
        <div><content:showAd adPositionType="designerlist_3" /></div>
       </div><!--iview2-->
      </div><!--sort_top-->
		   <div class="filters designer_list">
        <div class="filter">
          <a href="#" rel="all">全部设计师&nbsp;&nbsp;/</a>
          <a href="#" rel="shoe">鞋品设计师&nbsp;&nbsp;/</a>
          <a href="#" rel="accessories">饰品设计师&nbsp;&nbsp;/</a>
          <a href="#" rel="dress">服饰设计师&nbsp;&nbsp;/</a>
         
        </div><!--filter-->
        
        
         <div class="container">
          <ul>
			<c:forEach items="${brandList}" var="brand">   
				<c:if test="${fn:substring(brand.brandCode,0,11)=='accessories'}">		     	
	        		<li class="accessories">
		              <a class="fancybox" href="#${brand.sortOrder}" title="${brand.designer}（${brand.countryCode}）">
		                
		                <div class="galleryImage">
		                <cartmatic:img url="${brand.icon}" mediaType="other"></cartmatic:img>
		                  <div class="infor">
		                    <p>${brand.designer}（${brand.countryCode}） </p>
		                    <p>品牌：${brand.brandName}</p>
		                    <p> ${brand.story} </p>
		                  </div>
		                </div>
		                <!--end galleryEntry-->
		              </a>
		            </li>
		       </c:if>
			</c:forEach>  
			   
			   
			<c:forEach items="${brandList}" var="brand">      	
	        	<c:if test="${fn:substring(brand.brandCode,0,4)=='shoe'}">			
		          	<li class="shoe">
		              <a class="fancybox" href="#${brand.sortOrder}" title="${brand.designer}（${brand.countryCode}）">
		                <div class="galleryImage">
		                  <cartmatic:img url="${brand.icon}"  mediaType="other"></cartmatic:img>
		                  <div class="infor">
		                    <p>${brand.designer}（${brand.countryCode}） </p>
		                    <p>品牌：${brand.brandName}</p>
		                    <p> ${brand.story} </p>
		                  </div>
		                </div>
		                <!--end galleryEntry-->
		              </a>
		            </li>
	         	</c:if>
			</c:forEach>
			
			<c:forEach items="${brandList}" var="brand">      	
	        	<c:if test="${fn:substring(brand.brandCode,0,5)=='dress'}">			
		          	<li class="dress">
		              <a class="fancybox" href="#${brand.sortOrder}" title="${brand.designer}（${brand.countryCode}）">
		                <div class="galleryImage">
		                  <cartmatic:img url="${brand.icon}"  mediaType="other"></cartmatic:img>
		                  <div class="infor">
		                    <p>${brand.designer}（${brand.countryCode}） </p>
		                    <p>品牌：${brand.brandName}</p>
		                    <p> ${brand.story} </p>
		                  </div>
		                </div>
		                <!--end galleryEntry-->
		              </a>
		            </li>
	         	</c:if>
			</c:forEach>  
			  
			</ul>
			   
			   
			<c:forEach items="${brandList}" var="brand">   
				 <div id="${brand.sortOrder}" class="desginer_detail">
		            <div class="fancy_left">
		              <div class="fancy_l_up">
		               <cartmatic:img url="${brand.pic}" mediaType="other"></cartmatic:img>
		              </div><!--fancy_l_up-->
		              <div class="fancy_l_down">
		                 <p><span>设计师：</span>${brand.designer}（${brand.countryCode}）</p>
		                 <p><span>品牌：</span>${brand.brandName}</p>
		                 <p><span>简介：</span>${brand.story}</p>
		                 <p><span>关键字：</span>${brand.website}</p>
		              </div><!--fancy_l_down-->
		            </div><!--fancy_left-->
		            <div class="fancy_right">
		              <div class="designer_shoe">
		              
		              
		              	<c:forEach items="${brand.products}" var="product" varStatus="varStatus" end="5">         
			                  <div class="shoe_show">
			                   <product:productImg product="${product}" flag="${product.sekillStatus}" size="e"/>   
			                   <div class="Item_name">
			                     <p class="text_prod">${product.productName}</p>
			                     <p class="price">
			                     <product:showPrice productSku="${product.defaultProductSku}" viewType="4"/></p>
			                   </div><!--Item_name-->
			                  </div><!--shoe_show-->
		                </c:forEach>
		                  
		                  
		                 </div><!--designer_shoe-->
		                 <p>
		                <a href="${ctxPath}/search-prod.html?brandId=${brand.id}"><span class="date-info">More+</span></a>
						</p>
		            </div>
	          </div><!--inline1-->
			</c:forEach>  
			
		  </div><!--container-->
      </div><!--filters demo1-->
      </div>
    <%-- ========== 内容结束 ========= --%>
           
			<%-- ========== 底部开始 ========= --%>
				<%@ include file="./include/footer.jspf"%>
			
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>