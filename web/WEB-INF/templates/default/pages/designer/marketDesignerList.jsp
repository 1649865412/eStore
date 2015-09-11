<!DOCTYPE html>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@page import="com.cartmatic.estore.common.model.customer.Customer"%>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<!-- Bootstrap -->
		<%@ include file="../../decorators/include/styles7.jspf"%>
        <link href="${resPath}/styles/css/designers.css" rel="stylesheet">
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
	</head>

	<body>

		<div class="w-designers">
        	<div class="w-designers-hd">
        	<a class="active num" catid="0">A-Z</a><a href="/marketDesigner/initialsSelect.html?initials=A">A</a><a href="/marketDesigner/initialsSelect.html?initials=B">B</a><a href="/marketDesigner/initialsSelect.html?initials=C">C</a><a href="/marketDesigner/initialsSelect.html?initials=D">D</a><a href="/marketDesigner/initialsSelect.html?initials=E">E</a><a href="/marketDesigner/initialsSelect.html?initials=F">F</a><a href="/marketDesigner/initialsSelect.html?initials=G">G</a><a href="/marketDesigner/initialsSelect.html?initials=H">H</a><a href="/marketDesigner/initialsSelect.html?initials=I">I</a><a href="/marketDesigner/initialsSelect.html?initials=J">J</a><a href="/marketDesigner/initialsSelect.html?initials=K">K</a><a href="/marketDesigner/initialsSelect.html?initials=L">L</a><a href="/marketDesigner/initialsSelect.html?initials=M">M</a><a href="/marketDesigner/initialsSelect.html?initials=N">N</a><a href="/marketDesigner/initialsSelect.html?initials=O">O</a><a href="/marketDesigner/initialsSelect.html?initials=P">P</a><a href="/marketDesigner/initialsSelect.html?initials=Q">Q</a><a href="/marketDesigner/initialsSelect.html?initials=R">R</a><a href="/marketDesigner/initialsSelect.html?initials=S">S</a><a href="/marketDesigner/initialsSelect.html?initials=T">T</a><a href="/marketDesigner/initialsSelect.html?initials=U">U</a><a href="/marketDesigner/initialsSelect.html?initials=V">V</a><a href="/marketDesigner/initialsSelect.html?initials=W">W</a><a href="/marketDesigner/initialsSelect.html?initials=X">X</a><a href="/marketDesigner/initialsSelect.html?initials=Y">Y</a><a href="/marketDesigner/initialsSelect.html?initials=Z">Z</a>
        	</div>
            </div>
            
       	  <div class="w-designers-bd">
		            <ul>
		  <c:if test="${empty mapResult}">
			          <li> <h2 class="designer_nav_title" style="padding-top:180px;">暂无设计师</h1></li>
		  </c:if>
		  
		  <c:if test="${!empty mapResult}">
        			   <c:forEach items="${mapResult}" var="map"  varStatus="s">
				        	<li catid="${s.index}" class="row">
				                    	<span>${map.key}</span>
				                        <div class="designers_names">
				              <c:forEach items="${map.value}" var="brand"><%--
							           	<em><a href="#" title="">${brand.designer}（品牌：${brand.brandName}）</a></em>
				              --%>
				              <a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}" title="">${brand.designer}（品牌：${brand.brandName}）</a>
				              </c:forEach>
				                      </div>
				            </li>
				         </c:forEach>
        		
        	</c:if>
        	
        	     	
				        <%--<c:forEach items="${mapResult}" var="map"  varStatus="s">
				        	<li catid="${s.index}" class="row">
				                    	<span>${map.key}</span>
				                        <div class="designers_names">
				              <c:forEach items="${map.value}" var="brand">
							           	<em><a href="#" title="">${brand.designer}（品牌：${brand.brandName}）</a></em>
				              
				              <a href="#" title="">${brand.designer}（品牌：${brand.brandName}）</a>
				              </c:forEach>
				                      </div>
				            </li>
				         </c:forEach>
		            --%></ul>
		       </div>
      </div>
        
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
	</body>

</html>