<%--
所以目录没有指定显示模板的,统一由这页面显示（列表目录的产品）
--%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
		
<html>
	<head>
		<title>设计师</title>	
		<%@ include file="/WEB-INF/templates/default/decorators/include/styles2.jspf"%>
		<%@ include file="/WEB-INF/templates/default/decorators/include/styles6.jspf"%>
		<%@ include file="/WEB-INF/templates/default/decorators/include/javascripts4.jspf"%>
				
	</head>
	<body>
        <div class="lyt-content-left">
        	<div class="solid-line"></div>
            <h2 class="brand">按所有品类</h2>
            <ul>
                <product:showCategorys categoryType="1" displayCategoryId="1" displayLevel="1" excludeCode="all"></product:showCategorys>
                <c:forEach items="${categoryTreeItems}" var="categoryTreeItem">
			    	<li><a href="<product:categoryUrl category="${categoryTreeItem}" />">${categoryTreeItem.name}</a></li>
                </c:forEach>
            </ul>
            <div class="solid-line"></div>
            <h2 class="brand">全部鞋款</h2>
            <ul>
            	<product:showCategorys categoryType="1" displayCategoryCode="all" displayLevel="1"></product:showCategorys>
                <c:forEach items="${categoryTreeItems}" var="categoryTreeItem">
	        		<li><a href="<product:categoryUrl category="${categoryTreeItem}" />">${categoryTreeItem.name}</a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="lyt-sidebar-right">
        	<img src="${resPath}/images/content/ad11.jpg"/ >
        </div>
        <div class="blank10"></div>
        <div class="productlist-wrap">
            <div class="brand-logo">
            	<h2>设计师品牌 Brands</h2>
                <div class="blank24"></div><div class="blank24"></div>
                <div class="brand-line"></div>
                <ul>
                <c:forEach items="${brandList}" var="brand" end="4">
                    <li><cartmatic:img url="${brand.icon}" width="190" height="41" mediaType="other"/></li>			
                </c:forEach>
                </ul>
            </div>
            <div class="brand-wrap">
            	<h2 class="brand">设计师 Designer</h2>
                <c:forEach items="${brandList}" var="brand" end="4">
                <div class="design-line"></div>
                <div class="left">
                	<div class="brand-wrap-logo"><cartmatic:img url="${brand.icon}"  width="190" height="41" mediaType="other"/></div>
                    <div class="brand-wrap-logo2"><cartmatic:img url="${brand.logo}" width="146" height="146" mediaType="other"/></div>
                     <div class="blank10"></div>
                    <b>${brand.designer}</b>
                    <div class="blank10"></div>
                    ${brand.story}
                </div>
                <div class="right">
                	<a href="${ctxPath}/search-prod.html?brandId=${brand.id}"><cartmatic:img url="${brand.pic}" width="694" height="322" mediaType="other"/></a>
                </div>
                <div class="blank24"></div>
                    <c:forEach items="${brand.products}" var="productItem" end="4">
                        <div class="product-list-v">
                            <product:productImg product="${productItem}" size="c" width="150" height="150" category="${category}" isLazyload="true"/>
                            <br/>${productItem.productName}<br/>
                            <product:showPrice productSku="${productItem.defaultProductSku}" viewType="4"/>
                        </div>
                    </c:forEach>
                    <div class="brand-more">
                    	<a href="${ctxPath}/search-prod.html?brandId=${brand.id}"><img src="${resPath}/images/icon/brand_more.png" /></a>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="clear"></div>
	</body>
</html>