<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<html>
	<head>
<title>我的收藏</title>
</head>
<body>

<div class="maincontent">
         
			         <div class="position-wrap">
			            <a href="${ctxPath }/index.html">首页</a>&nbsp;&gt;&nbsp;
			            <a href="${ctxPath }/myaccount/order/list.html">我的账户</a>&nbsp;&gt;&nbsp;
			            <span class="selected">我的收藏</span>
			         </div>  
			         <div class="top_about">
			         <br>
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
			           <div class="blank24"></div>
			           <hr>
			         </div>
                
	                <div class="bottom_about">
	       
			           <div class="remote_nav">
			            <ul id="remote_nav_ul">
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
			           
			           
			           <div class="down_right left_border" id="tab1">
				             <p class="account_info_title">
				               账户：${customer.email}
				               <span class="header_breadcrumb">我的收藏</span>
				             </p>
				             <p class="cus_id">会员级别：${membership.membershipName}</p>
				             <table class="account_table" cellspacing="0" cellpadding="0">
				               <thead>
				                 <tr>
				                    <th width="20%">
				                      商品图像
				                    </th>
				                    <th width="35%">
				                      商品名称
				                    </th>
				                    <th width="15%">
				                      收藏时间
				                    </th>
				                    <th width="30%">
				                      操作
				                    </th>
				                 </tr>
				               </thead><!--thead-->
				               <tbody>
				               <c:forEach var="favorite" items="${favoriteList}" varStatus="s">
				                 <tr>
				                    <td class="wish_img">
				                  	  <product:productImg product="${favorite.product}" size="e" width="110" height="110" isLazyload="true"/>
				                    <td>
										<product:productName product="${favorite.product}" />
									</td>
				                    <td><fmt:formatDate value="${favorite.createTime}" pattern="yyyy-MM-dd" /></td>
				                    <td>
				                      <button name="cancel_wish" class="btn_small btn-black" type="button" onclick="fnRemoveFavorite(${favorite.id});">
				                          <i class="fa fa-times padding_right10"></i>
				                          取消收藏
				                      </button>
				                    </td>
				                 </tr>
				                 </c:forEach>
				               </tbody>
				             </table>
				
				           </div><!--down_right-->
				           
			         </div>
                
			</div>

	<script type="text/javascript">
		function fnRemoveFavorite(id){
			if(confirm("确定要取消该商品收藏？")){
				window.location.href=__ctxPath+"/myaccount/favorite/delete/"+id+".html"
			}
		}
	</script>
	
</body>
</html>