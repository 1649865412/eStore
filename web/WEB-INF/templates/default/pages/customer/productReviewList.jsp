<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<html>
	<head>
		<title>我的评论</title>
		<%@ include file="../../decorators/include/styles7.jspf"%>
		<link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
        <link href="${resPath}/styles/css/help.css" rel="stylesheet" type="text/css" />
        <link href="${resPath}/styles/css/myaccount.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
	<div class="maincontent">
         <div class="account_all">
         <div class="top_about">
           <div class="top_title">
           <h1>我的账户</h1>
           </div>
           <ul class="tophelp">
                <li>有任何疑问&nbsp;|</li>
                <li>请点击在线客服&nbsp;|</li>
                <li>或拨打400-661-5677&nbsp;|</li>
                <li><a href="mailto:cs@sifangstreet.com">客服电子邮件地址</a>&nbsp;|</li>
                
                    <li><a href="#"  target="_blank" >配送信息</a>&nbsp;|</li>
                <li>
                    <a href="#"  target="_blank" >退换货条款</a>
                </li>
           </ul> 
          
          
         </div>
         <div class="bottom_about">
       
           <div class="remote_nav">
            <ul id="">
			              <li><a id="t1" href="${ctxPath}/myaccount/order/list.html" title="我的订单" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/order/')!=-1}"> class="current"</c:if>>我的订单</a></li>
			              <li><a id="t2" href="${ctxPath}/myaccount/favorites.html" title="我的收藏" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/favorites.html')!=-1}"> class="current"</c:if>>我的收藏</a></li>
			              <li><a id="t3" href="${ctxPath}/myaccount/review/list.html" title="我的评价" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/review/')!=-1}"> class="current"</c:if>>我的评价<span id="reviews_count"></span></a></li>
			              <li><a id="t4" href="${ctxPath}/myaccount/settings.html" title="个人资料" <c:if test="${fn:endsWith(OriginalRequestURL,'/myaccount/settings.html')}"> class="current"</c:if>>个人资料</a></li>
			              <li><a id="t5" href="${ctxPath}/myaccount/address.html" title="收货地址 " <c:if test="${fn:endsWith(OriginalRequestURL,'/myaccount/address.html')}"> class="current"</c:if>>收货地址</a></li>
			              <li><a id="t6" href="${ctxPath}/myaccount/shopPoint.html" title="积分" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/shopPoint.html')!=-1}"> class="current"</c:if>>积分</a></li>
			              <li><a id="t7" href="${ctxPath}/myaccount/giftCouponQuery.html" title="礼券/优惠劵" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/giftCouponQuery.html')!=-1}"> class="current"</c:if>>礼券/优惠劵</a></li>
			              <li><a id="t8" href="${ctxPath}/myaccount/giftCard.html" title="礼品卡管理" <c:if test="${fn:indexOf(OriginalRequestURI,'/myaccount/giftCard.html')!=-1}"> class="current"</c:if>>礼品卡</a></li>
			        
			            </ul>
           </div><!--remote_nav-->
           <!--分页内容tab-->
           <div class="down_right left_border"  id="tab3">
             <p class="account_info_title">
               账户：${customer.email}
               <span class="header_breadcrumb">我的评价</span>
             </p>
             <p class="cus_id">会员级别：${membership.membershipName}</p>
             <div class="comment_part">
               <c:forEach var="review" items="${productReviewList}" varStatus="varStatus">
										             
					               <div class="div_comment">           
					                 <div class="left_comment wish_img">
					                     <a href="${ctxPath }/product/${review.product.productId}.html">
												<img src="${mediaPath}product/e/${review.product.defaultProductSku.image}"/>	
												<p>${review.product.productName }</p>				                     
					                     </a>
					                 </div><!--left_comment-->
					                 <div class="right_comment">
					                 <div class="meta-info">
					                   <div class="author">
					                     <p><a href="#">${review.subject}</a></p>
					                   </div><!--author-->
					                   <div class="date">
					                     <fmt:formatDate value="${review.createTime}" pattern="MM/dd/yyyy HH:mm:ss" />
					                   </div><!--date-->
					                   <br>
					                 </div><!--meta-info-->
					                 <p class="comment-text">
					                       ${review.message}
					                 </p>
					                 <div class="comment_button">
					                     <button name="change_comment" class="btn btn-gold" type="button" onclick="javascript:window.location.href='${ctxPath}/myaccount/review/${review.productReviewId}.html'">
					                        <i class="fa fa-pencil padding_right10"></i>
					                        编辑
					                     </button>
					                     <button name="delete_comment" class="btn btn-black" type="button" onclick="fnDeleteReview('${review.productReviewId}');">
					                        <i class="fa fa-times padding_right10"></i>
					                        删除
					                     </button>
					                 </div><!--comment_button-->
					                 </div><!--right_comment-->
					               </div><!--div_comment-->
					            
					           </c:forEach>
             </div><!--comment_part-->
             <c:if test="${not empty salesOrderList}">
							<div class="pagebar">
							<ul class="paginations">
							<%@ include file="/common/pagingOnlyNew.jsp"%>
							</ul>
							</div>
							</c:if>
           </div><!--down_right-tab3-->
         
         </div><!--bottom_about-->
         </div><!--account_all-->
           
      </div><!--end of maincontent-->
			<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
			<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
			<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script> 
			<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
			<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
	        
	        <script src="${ctxPath}/scripts/jquery/js/jquery.tools.min.js"></script>
			<script>
			$(function() {
				// setup ul.tabs to work as tabs for each div directly under div.panes
				$("#remote_nav_ul").tabs("div.down_right", { history: true });	
				
			});
			</script>
    
	</body>
</html>