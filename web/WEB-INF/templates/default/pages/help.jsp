<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<style type="text/css">
a {
color: black ! important;
}
</style>
<html lang="zh-CN">

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>

		<!-- Bootstrap -->
		<%@ include file="../decorators/include/styles7.jspf"%>
        <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
        <link href="${resPath}/styles/css/help.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	</head>

	<body>
		<%@ include file="../decorators/include/headerNew.jspf"%>
        <div class="maincontent">
           
           
           
           <div class="bottom_about">
             <div class="remote_nav">
              <ul id="remote_nav_ul">
              <li><a href="${ctxPath}/customer_help.html?contentId=16" title="会员政策" <c:if test="${param.contentId == 16}">class="current"</c:if>>会员政策</a></li>
              <li><a href="${ctxPath}/customer_help.html?contentId=9" title="礼品卡使用指南" <c:if test="${param.contentId == 9}">class="current"</c:if>>礼品卡使用指南</a></li>
              <li><a href="${ctxPath}/customer_help.html?contentId=7" title="尺码对照表" <c:if test="${param.contentId == 7}">class="current"</c:if>>尺码对照表</a></li>
              <li><a href="${ctxPath}/customer_help.html?contentId=6" title="支付方式 " <c:if test="${param.contentId == 6}">class="current"</c:if>>支付方式</a></li>
              <li><a href="${ctxPath}/customer_help.html?contentId=13" title="配送方式" <c:if test="${param.contentId == 13}">class="current"</c:if>>配送方式</a></li>
              <li><a href="${ctxPath}/customer_help.html?contentId=12" title="售后服务" <c:if test="${param.contentId == 12}">class="current"</c:if>>售后服务</a></li>
              <li><a href="${ctxPath}/customer_help.html?contentId=11" title="服务条款" <c:if test="${param.contentId == 11}">class="current"</c:if>>服务条款</a></li>
              <li><a href="${ctxPath}/customer_help.html?contentId=8" title="隐私政策" <c:if test="${param.contentId == 8}">class="current"</c:if>>隐私政策</a></li>
              <li><a href="${ctxPath}/customer_help.html?contentId=28" title="常见问题" <c:if test="${param.contentId == 28}">class="current"</c:if>>常见问题</a></li> 
              <li><a href="${ctxPath}/customer_help.html?contentId=29" title="员工专场活动购物指南" <c:if test="${param.contentId == 29}">class="current"</c:if>>员工专场活动购物指南</a></li>
              </ul>
           </div><!--remote_nav-->
           <div class="down_right">
           		${contentBody}
           </div><!--down_right-->
         </div><!--bottom_about-->
           
          
             
    
      </div><!--end of maincontent-->
		<%@ include file="../decorators/include/footerNew.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script> 
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
        
        <script src="${ctxPath}/scripts/jquery/js/jquery.tools.min.js"></script>
		
	</body>

</html>