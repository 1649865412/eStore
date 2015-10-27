<!DOCTYPE html>
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
<html lang="zh-CN">
	<head>
		 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>四方街</title>

    <!-- Bootstrap -->
    <%@ include file="../../decorators/include/styles7.jspf"%>
    
    <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
    <link href="${resPath}/styles/css/mall_nav.css" rel="stylesheet">
    <link href="${resPath}/styles/css/special_topic.css" rel="stylesheet">
    <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
    <!--[if IE]>  <link rel="stylesheet" type="text/css" href="index2-ie-only.css/> <![endif]-->
    
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>

	<body>
	<%@ include file="../../decorators/include/headerMarket.jspf"%>
        <!--主体内容开始-->
        <div class="special_topic">
          <div class="whole_width">
              <img src="/images/special/sifang/01-01-01_01.jpg"/>
          </div><!--whole_width-banner-->
          <div class="center_middle">
              <img src="/images/special/sifang/01-01-01_04.jpg"/>
          </div><!--center_middle_topic-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_06.jpg"/>
          </div><!--half_width-left-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_07.jpg"/>
          </div><!--half_width-right-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_08.jpg"/>
          </div><!--half_width-left-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_09.jpg"/>
          </div><!--half_width-right-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_10.jpg"/>
          </div><!--half_width-left-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_11.jpg"/>
          </div><!--half_width-right-->
          <div class="half_width">
              <img src="/images/special//sifang/01-01-01_12.jpg"/>
          </div><!--half_width-left-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_13.jpg"/>
          </div><!--half_width-right-->
           <div class="center_middle">
              <img src="/images/special/sifang/01-01-01_15.jpg"/>
          </div><!--center_middle_topic-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_17.jpg"/>
          </div><!--half_width-left-->
          <div class="half_width">
              <img src="/images/special/sifang/01-01-01_18.jpg"/>
          </div><!--half_width-right-->
           <div class="whole_width">
              <img src="/images/special/sifang/01-01-01_19.jpg"/>
          </div><!--whole_width-bottom-->
        </div>
        <!--主体内容结束-->
		<%@ include file="../../decorators/include/footerNew.jspf"%>
		
    <script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
	<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
	<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
        





	</body>

</html>