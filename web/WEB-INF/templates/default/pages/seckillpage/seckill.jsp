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

<!DOCTYPE HTML>
<html>
<head>

    <link href="${resPath}/styles/main.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="${resPath}/styles/component.css" />
   
 
 
		
	
       
   <style type="text/css">
   /* tabs-s */
.tabs-s {
	position: relative;
	width: 95%;
	overflow: hidden;
	margin: 1em 2em;
	font-weight: 300;
	background-color:rgba(255,255,255, 0.95);
	filter:alpha(opacity=95)
}
   
     /* Nav */
.tabs-s nav {
	text-align: center;
}

.tabs-s nav ul {
	padding: 0;
	margin: 0;
	list-style: none;
	display: inline-block;
}

.tabs-s nav ul li {
	border: 1px solid #aaa;
	border-bottom: none;
	margin: 0 0.85em;
	display: block;
	float: left;
	position: relative;
}

.tabs-s nav ul li a.current{
	border: 1px solid #ee86a1;
	box-shadow: inset 0 2px #ee86a1;
	border-bottom: none;
	z-index: 100;
	color: #ee86a1;
}

.tabs-s nav li a.current:before,
.tabs-s nav li a.current:after {
	content: '';
	position: absolute;
	height: 1px;
	right: 100%;
	bottom: 0;
	width: 1000px;
	background: #ee86a1;
}

.tabs-s nav li a.current:after {
	right: auto;
	left: 100%;
	width: 1000px;
}

.tabs-s nav a {
	color: #aaa;
	display: block;
	font-size: 1.45em;
	line-height: 2.5;
	padding: 0.1em 2.25em;
	white-space: nowrap;
}

.tabs-s nav a:hover {
	color: #777;
}

.tabs-s nav li.tab-current a {
	color: #ee86a1;
}
 
/* Content */
.content .sale_s {
	font-size: 1.25em;
	padding: 3em 1em;
	display: none;
	max-width: 1000px;
	margin: 0 auto;
}

.content .sale_s:before,
.content .sale_s:after {
	content: '';
	display: table;
}

.content .sale_s:after {
	clear: both;
}



  
   </style> 
</head>

<body>
<div class="maincontent">
      <div id="large-header" class="large-header_520">
                  <canvas id="demo-canvas" style="width:1358px;"></canvas>
       </div><!--large-->
    <div class="bg-s">
      <div id="tabs-s" class="tabs-s">
                  <nav>
                      <ul>
                          <li><a href="#section-1" id="t1"><span>For Our Love</span></a></li>
                          <li><a href="#section-2" id="t2"><span>For My Princess</span></a></li>
                          <li><a href="#section-3" id="t3"><span>For My Prince</span></a></li>
                          
                      </ul>
                  </nav>
                  <div class="content"> 
                   <div id="section-1" class="sale_s">
                 
                    <c:forEach items="${sekillProductListDay1}" var="sekillProductListDay1Item" varStatus="varStatus">
					<div class="mediabox">
                      <div class="shoe_show">
                       <!--     <img src="${sekillProductListDay1Item.product.defaultProductSku.image}"  alt="" /> -->
                       <product:productImg product="${sekillProductListDay1Item.product}" flag="${sekillProductListDay1Item.status }"  size="v" isLazyload="false"/>
                        <div class="Item_name">
                          <p class="text_prod">${sekillProductListDay1Item.product.productName}</p>
                          <p class="text_designer">${sekillProductListDay1Item.product.brand.brandName}</p>
                          <%--<p class="price"> 
                             <span class="ourPrice">原价： ¥${sekillProductListDay1Item.product.defaultProductSku.price}</span>
                          </p>
                          --%><p class="price"> 
                             <span class="price" title="活动价">¥${sekillProductListDay1Item.product.defaultProductSku.price}</span>
                          </p>
                        </div><!--Item_name-->
                       <a href="<product:productUrl product="${ sekillProductListDay1Item.product}" />" title="${sekillProductListDay1Item.product.title}">
                         <div class="btn start">  查看详情</div>
                         <%--秒杀立即够买 --%>
                         <%--<c:if test="${ sekillProductListDay1Item.status==65456}">
                           <div class="btn sold">  已经抢光</div>
                         </c:if>
                         <c:if test="${sekillProductListDay1Item.status==5613}">
	                       <div class="btn will_start"> 即将开始</div>
                         </c:if>
            
                         <c:if test="${sekillProductListDay1Item.status==562345}">
	                       <div class="btn start">  查看详情</div>
                         </c:if>
                       --%></a>
                      </div><!--shoe_show-->              
					</div><!--mediabox-->
                    </c:forEach>

			</div><!--section-1-->
			<%-- ========== 产品列表结束 ========= --%>
			<div id="section-2" class="sale_s">
                 
                          <%-- ========== 产品列表开始 ========= --%>

                    <c:forEach items="${sekillProductListDay2}" var="sekillProductListDay2Item" varStatus="varStatus">
					<div class="mediabox">
                      <div class="shoe_show">
                      <!--     <img src="${sekillProductListDay1Item.product.defaultProductSku.image}"  alt="" /> -->
                      <product:productImg product="${sekillProductListDay2Item.product}"flag="${sekillProductListDay2Item.status }" size="v" isLazyload="false"/>
                        <div class="Item_name">
                          <p class="text_prod">${sekillProductListDay2Item.product.productName}</p>
                          <p class="text_designer">${sekillProductListDay2Item.product.brand.brandName}</p>
                          <%--<p class="price"> 
                             <span class="ourPrice">原价： ¥${sekillProductListDay2Item.product.defaultProductSku.price}</span>
                          </p>
                          --%><p class="price"> 
                             <span class="price" title="活动价">¥${sekillProductListDay2Item.product.defaultProductSku.price}</span>
                          </p>
                        </div><!--Item_name-->
                        <a href="<product:productUrl product="${ sekillProductListDay2Item.product}" />" title="${sekillProductListDay2Item.product.title}">
                        <div class="btn start"> 查看详情</div>
                        <%--秒杀立即够买 
                         <c:if test="${ sekillProductListDay2Item.status==65456}">
                          <div class="btn sold">已经抢光</div>
                         </c:if>
                         <c:if test="${sekillProductListDay2Item.status==5613}">
                          <div class="btn will_start"> 即将开始</div>
                         </c:if>
                         <c:if test="${sekillProductListDay2Item.status==562345}">
                           <div class="btn start"> 查看详情</div>
                         </c:if>--%>
                        </a>
                      </div><!--shoe_show-->              
					</div><!--mediabox-->
				</c:forEach>

			<%-- ========== 产品列表结束 ========= --%>
			</div><!--section-2-->
                      
			<div id="section-3" class="sale_s">
             
                          <%-- ========== 产品列表开始 ========= --%>

				<c:forEach items="${sekillProductListDay3}" var="sekillProductListDay3Item" varStatus="varStatus">
					<div class="mediabox">
                      <div class="shoe_show">
                      <!--     <img src="${sekillProductListDay1Item.product.defaultProductSku.image}"  alt="" /> -->
                      <product:productImg product="${sekillProductListDay3Item.product}"flag="${sekillProductListDay3Item.status }" size="v" isLazyload="false"/>
                      <div class="Item_name">
                           <p class="text_prod">${sekillProductListDay3Item.product.productName}</p>
                           <p class="text_designer">${sekillProductListDay3Item.product.brand.brandName}</p>
                           <%--<p class="price"> 
                             <span class="ourPrice">原价： ¥${sekillProductListDay3Item.product.defaultProductSku.price}</span>
                          </p>
                          --%><p class="price"> 
                             <span class="price" title="活动价">¥${sekillProductListDay3Item.product.defaultProductSku.price}</span>
                          </p>
                      </div>
                      <a href="<product:productUrl product="${ sekillProductListDay3Item.product}" />" title="${sekillProductListDay3Item.product.title}">
                    <div class="btn start"> 查看详情</div>
                      <%--秒杀立即够买
                      <c:if test="${ sekillProductListDay3Item.status==65456}">
                        <div class="btn sold"> 已经抢光</div>
                      </c:if>
                      <c:if test="${sekillProductListDay3Item.status==5613}">
                      <div class="btn will_start">即将开始</div>
                      </c:if>
            
                      <c:if test="${sekillProductListDay3Item.status==562345}">
                      <div class="btn start"> 查看详情</div>
                      </c:if> --%>
                      </a>
                      </div><!--shoe_show-->              
					</div><!--mediabox-->
				</c:forEach>

			<%-- ========== 产品列表结束 ========= --%>
              </div><!--section-3-->
             </div><!-- content -->
           </div><!-- tabs-s -->
		</div><!--bg-s-->
		<script>
		$(function() {
			// setup ul.tabs to work as tabs for each div directly under div.panes
			$("div#tabs-s nav ul").tabs("div.sale_s", { history: false });	
			
		});
		</script>
		<script src="${ctxPath}/scripts/jquery/rAF.js"></script>
		<script src="${ctxPath}/scripts/jquery/twinkle-c.js"></script>
		
    </div><!--end of maincontent-->
    
</body>
</html>
