<!DOCTYPE html>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<html>
	<head>
		<title>礼券/优惠券查询</title>
		<%@ include file="../../decorators/include/styles7.jspf"%>
		<link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
        <link href="${resPath}/styles/css/help.css" rel="stylesheet" type="text/css" />
        <link href="${resPath}/styles/css/myaccount.css" rel="stylesheet" type="text/css" />
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
           <div class="down_right left_border" id="tab7">
             <p class="account_info_title">
               账户：${customer.email}
               <span class="header_breadcrumb">优惠劵</span>
             </p>
             <p class="cus_id">会员级别：${membership.membershipName}</p>          
             <form action="${ctxPath }/myaccount/giftCouponQuery.html" method="post" name="giftCouponQueryForm" id="giftCouponQueryForm">
			             
				             <div class="score_top">
				               <div class="leftright_form">
				                 <h3 class="padding_left10">优惠劵查询</h3>
				                 <div class="score_exchange">
				                        <p>请输入您的礼券/优惠劵代码点击查询</p>
				                        <input type="text" class="box-input" id="giftCouponNo" name="giftCouponNo" size="33">
				                        <div class="mark_co input_waring" style="display: inline;">
				                            <div for="giftCouponNo" generated="true" class="red" style="display: none;">
				                            </div>
				                         </div>
				                        <br/>
				                        <br/>
				
				                        <button name="giftCouponbutton" class="btn btn-black" type="submit">
				                           <i class="fa fa-search padding_right10"></i>
				                           查询
				                         </button>
				                 </div><!--score_exchange-->
				               </div><!--leftright_form-->
				             </div><!--score_top-->
			             
			             </form>
             
             <!--以下为查询结果，平常应为不可见，查询后可见-->
			             	<c:choose>
								<c:when test="${coupon.state == 1}">
										<div class="score_top">
						               <h3 class="padding_left10">查询结果</h3>
						               <div class="score_info">
						                   <div class="score_info_left">
						                     <p>优惠劵号码:</p>
						                     <p>有效期:</p>
						                     <p>描述:</p>
						                     <p>剩余可使用次数:	</p>
						                   </div><!--score_info_left-->
						                   <div class="score_info_right">
						                     <p>${coupon.couponNo}</p>
						                     <p>
						                     	<c:choose>
												<c:when test="${not empty coupon.promoRule.endTime}">
													<fmt:formatDate value="${coupon.promoRule.endTime}" pattern="MM/dd/yyyy hh:mm:ss" />
												</c:when>
												<c:otherwise>
													<fmt:message key="giftCouponQuery.noEndTime"></fmt:message>
												</c:otherwise>
											</c:choose>	
											</p> 
						                     <p>${coupon.promoRule.name}</p>
						                     <p>${coupon.remainedTimes}</p>
						                   </div><!--score_info_right-->
						                 </div><!--score_info-->
						             </div><!--score_top-->
								</c:when>
								<c:when test="${giftCertificate.state == 1 or giftCertificate.state == -2}">
									<div class="score_top">
						               <h3 class="padding_left10">查询结果</h3>
						               <div class="score_info">
						                   <div class="score_info_left">
						                     <p>礼券号码：</p>
						                     <p>有效期：</p>
						                     <p>面值：</p>
						                     <p>余额：</p>
						                   </div><!--score_info_left-->
						                   <div class="score_info_right">
						                     <p>${giftCertificate.giftCertificateNo}</p>
						                     <p>
						                     	<c:choose>
													<c:when test="${not empty giftCertificate.expireTime}">
														<fmt:formatDate value="${giftCertificate.expireTime}"
															pattern="MM/dd/yyyy hh:mm:ss" />
													</c:when>
													<c:otherwise>
														<fmt:message key="giftCouponQuery.noEndTime"></fmt:message>
													</c:otherwise>
												</c:choose>
											</p> 
						                     <p><system:CurrencyForRate value="${giftCertificate.giftCertAmt}" /></p>
						                     <p><system:CurrencyForRate value="${giftCertificate.remainedAmt}" /></p>
						                   </div><!--score_info_right-->
						                 </div><!--score_info-->
						             </div><!--score_top-->
								</c:when>
								<c:when test="${(not empty coupon and coupon.state != 0)||(not empty giftCertificate and giftCertificate.state != 0)||(coupon.state == 0 and giftCertificate.state == 0)}">
									<div class="score_top">
							               <h3 class="padding_left10">查询结果：此礼券/优惠劵不存在！</h3>
							             </div><!--score_top-->
									<!-- 
									<h5><fmt:message key="giftCouponQuery.tip" /></h5>
									<div class="dashed-line"></div>
									<table cellSpacing="0" cellPadding="0" width="100%" align="center"	class="table-account" border="0">
										<tr>
											<th width="30%">&nbsp;</th>
											<td>
												<font color="red">
													<c:choose>
														<c:when test="${not empty coupon and coupon.state != 0}">
															<fmt:message key="giftCouponQuery.coupon.state${coupon.state}">
																<fmt:param>${giftCouponNo}</fmt:param>
															</fmt:message>
														</c:when>
														<c:when test="${not empty giftCertificate and giftCertificate.state != 0}">
															<fmt:message key="giftCouponQuery.giftCertificate.state${giftCertificate.state}">
																<fmt:param>${giftCouponNo}</fmt:param>
															</fmt:message>
														</c:when>
														<c:when test="${coupon.state == 0 and giftCertificate.state == 0}">
															<fmt:message key="giftCouponQuery.notExist">
																<fmt:param>${giftCouponNo}</fmt:param>
															</fmt:message>
														</c:when>
													</c:choose>
												</font>
											</td>
										</tr>
									</table>
									 -->
								</c:when>
							</c:choose>
			            <!--查询结果到此为止-->
            
            
           </div><!--down_right-tab7-->
         
         </div><!--bottom_about-->
         </div><!--account_all-->
           
      </div><!--end of maincontent-->
      <%@ include file="../../decorators/include/footerNew.jspf"%>
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
			<script type="text/javascript">
	$("#giftCouponQueryForm").validate({rules:{
		giftCouponNo:{required:true}
	},
		messages:{
			giftCouponNo:{
				required:"请输入礼券/优惠劵！"
				}
		}
	});
	</script>
    
	</body>
</html>