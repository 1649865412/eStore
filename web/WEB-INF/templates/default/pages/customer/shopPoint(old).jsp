<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"	src="${ctxPath}/scripts/cartmatic/common/region.js"></script>
<title>积分查询/兑换</title>


<div class="maincontent">
         
			         <div class="position-wrap">
			            <a href="${ctxPath }/index.html">首页</a>&nbsp;&gt;&nbsp;
			            <a href="${ctxPath }/myaccount/order/list.html">我的账户</a>&nbsp;&gt;&nbsp;
			            <span class="selected">积分</span>
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
			           
			           
			           <div class="down_right left_border" id="tab6">
				             <p class="account_info_title">
				               账户：${customer.email}
				               <span class="header_breadcrumb">积分</span>
				             </p>
				             <p class="cus_id">会员级别：${membership.membershipName}</p>          
				             <div class="score_top">
				               <div class="leftright_form">
				                 <h3 class="padding_left10">积分情况</h3>
				                 <div class="score_info">
				                   <div class="score_info_left">
				                     <p>我的积分:</p>
				                     <p>已使用:</p>
				                     <p>未使用:</p>
				                     <p>更新:	</p>
				                   </div><!--score_info_left-->
				                   <div class="score_info_right">
				                     <p>${shopPoint.gainedTotal}</p>
				                     <p>${shopPoint.usedTotal }</p> 
				                     <p>${shopPoint.total }</p>
				                     <p><fmt:formatDate value="${shopPoint.updateTime}" pattern="MM/dd/yyyy hh:mm:ss" />&nbsp;</p>
				                   </div><!--score_info_right-->
				                 </div><!--score_info-->
				               </div><!--leftright_form-->
				             </div><!--score_top-->
				             <div class="score_bottom">
				               <h3 class="score_detail_title">积分明细</h3>
				               <table class="account_table" cellspacing="0" cellpadding="0">
				                 <thead>
				                   <tr>
				                      <th width="35%">
				                        时间
				                      </th>
				                      <th width="15%">
				                        类型
				                      </th>
				                      <th width="30%">
				                        描述
				                      </th>
				                      <th width="20%">
				                        积分
				                      </th>
				                   </tr>
				                 </thead><!--thead-->
				                 <tbody>
				                 <c:forEach var="shopPointHistory" items="${shopPointHistoryList}" >
				                   <tr>
				                      <td> <fmt:formatDate value="${shopPointHistory.createTime}" pattern="MM/dd/yyyy hh:mm:ss" /></td>
				                      <td><fmt:message key="shopPoint.shopPointType_${shopPointHistory.shopPointType}" /></td>
				                      <td>${shopPointHistory.description }</td>
				                      <td>${shopPointHistory.amount}</td>
				                   </tr>
				                  </c:forEach>
				                 </tbody>
				               </table>
				               <div class="pagebar">
								<%@ include file="/common/pagingOnlyNew.jsp"%>
								</div>
				             </div><!--score_bottom-->
				           </div><!--down_right-->
				           
			         </div>
                
			</div>