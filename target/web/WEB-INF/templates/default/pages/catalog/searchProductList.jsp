<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html>
	<head>
		<title>"${empty param.q?brand.brandName:param.q}" 搜索结果</title>
		<meta name="keywords" content="${empty param.q?brand.brandName:param.q}" />
	</head>
	<body>
		<content tag="heading"> 搜索 “${empty param.q?brand.brandName:param.q}”</content>
            <div class="lyt-content-left">
              <div class="expmenu">
			<form action="${ctxPath}/search-prod.html" method="get" id="productListForm">
                
                    <div class="attribute-item"  id="searchAllCategory">
                  <div class="sort_title">
                    <p>鞋款<span>Category</span><span class="arrow up"></span></p>
                    
                  </div><!--sort_title-->
                  <ul class="sort_list">
                   <product:showCategorys categoryType="1" displayCategoryCode="all" displayLevel="1"></product:showCategorys>
                        	<c:forEach items="${categoryTreeItems}" var="categoryTreeItem">
					        	<li><a href="<product:categoryUrl category="${categoryTreeItem}" />">${categoryTreeItem.name}</a></li>
                        	</c:forEach>
                  </ul>
               </div>
                
                   
			    <attribute:attribute var="attribute" attributeCode="changhe"></attribute:attribute>
                    <c:set var="checkBoxIndex" value="1"/>
                    <div class="attribute-item">
                    	  <div class="sort_title">
                    <p>场合<span>Occasion</span><span class="arrow up"></span></p>
                    
                  </div><!--sort_title-->
                  
                        <ul class="sort_list">
                        	<c:forTokens items="${attribute.defaultValue}" delims="," var="conditionValue">
								<c:choose>
									<c:when test="${cfn:contains4Array(paramValues['changHe'],conditionValue)}">
										<li><input type="checkbox" value="${conditionValue}" name="changHe" checked="checked" id="${checkBoxIndex}"><label for="${checkBoxIndex}">${conditionValue}</label></li>
									</c:when>
									<c:otherwise>
										<li><input type="checkbox" value="${conditionValue}" name="changHe" id="${checkBoxIndex}"><label for="${checkBoxIndex}">${conditionValue}</label></li>
									</c:otherwise>
								</c:choose>
                    			<c:set var="checkBoxIndex" value="${checkBoxIndex+1}"/>
							</c:forTokens>
                       	</ul>
                    </div>
                    <attribute:attribute var="attribute" attributeCode="heel_type"></attribute:attribute>
                    <div class="attribute-item">
                    	<div class="sort_title">
                    <p>跟型<span>Heel</span> <span class="arrow up"></span></p>
                   
                  </div><!--sort_title-->
                        <ul class="sort_list">
                        	<c:forTokens items="${attribute.defaultValue}" delims="," var="conditionValue">
								<c:choose>
									<c:when test="${cfn:contains4Array(paramValues['heelType'],conditionValue)}">
										<li><input type="checkbox" value="${conditionValue}" name="heelType" checked="checked" id="${checkBoxIndex}"><label for="${checkBoxIndex}">${conditionValue}</label></li>
									</c:when>
									<c:otherwise>
										<li><input type="checkbox" value="${conditionValue}" name="heelType" id="${checkBoxIndex}"><label for="${checkBoxIndex}">${conditionValue}</label></li>
									</c:otherwise>
								</c:choose>
                    			<c:set var="checkBoxIndex" value="${checkBoxIndex+1}"/>
							</c:forTokens>
                       	</ul>
                    </div>
					<product:skuOption skuOptionCode="color" var="colorOption"></product:skuOption>
                    <div class="attribute-item">
                    	  <div class="sort_title">
                    <p>颜色<span>Color</span> <span class="arrow up"></span></p>
                   
                  </div><!--sort_title-->
                  
                         <ul class="sort_list selected_color">
                        	<c:forEach items="${colorOption.skuOptionValues}" var="optionValue">
                        		<c:choose>
									<c:when test="${cfn:contains4Array(paramValues['color'],optionValue.skuOptionValue)}">
										<li><input type="checkbox" value="${optionValue.skuOptionValue}" name="color" checked="checked" id="${checkBoxIndex}">
										<label for="${checkBoxIndex}">${optionValue.skuOptionValueName}</label><span id="color_${optionValue.skuOptionValue}"></span>
                                        </li>
									</c:when>
									<c:otherwise>
										<li><input type="checkbox" value="${optionValue.skuOptionValue}" name="color" id="${checkBoxIndex}">
										<label for="${checkBoxIndex}">${optionValue.skuOptionValueName}</label><span id="color_${optionValue.skuOptionValue}"></span>
                                 
                                        </li>
									</c:otherwise>
								</c:choose>
                    			<c:set var="checkBoxIndex" value="${checkBoxIndex+1}"/>
							</c:forEach>
                       	</ul>
                    </div>
					<product:skuOption skuOptionCode="size" var="sizeOption"></product:skuOption>
                    <div class="attribute-item">
                    	<div class="sort_title">
                    <p>尺码<span>Size</span> <span class="arrow up"></span></p>
                   
                  </div><!--sort_title-->
                  <ul class="sort_list">
                        	<c:forEach items="${sizeOption.skuOptionValues}" var="optionValue">
                        		<c:choose>
									<c:when test="${cfn:contains4Array(paramValues['size'],optionValue.skuOptionValue)}">
										<li><input type="checkbox" value="${optionValue.skuOptionValue}" name="size" checked="checked" id="${checkBoxIndex}"><label for="${checkBoxIndex}">${optionValue.skuOptionValueName}</label></li>
									</c:when>
									<c:otherwise>
										<li><input type="checkbox" value="${optionValue.skuOptionValue}" name="size" id="${checkBoxIndex}"><label for="${checkBoxIndex}">${optionValue.skuOptionValueName}</label></li>
									</c:otherwise>
								</c:choose>
                    			<c:set var="checkBoxIndex" value="${checkBoxIndex+1}"/>
							</c:forEach>
                       	</ul>
                    </div>
                    
                    <div class="attribute-item">
                    	 <div class="sort_title">
                    <p>价格<span>Price</span><span class="arrow up"></span></p>
                    
                  </div><!--sort_title-->
                  <ul class="sort_list" id="productListPrice">
                        	<li><input type="checkbox" maxVal="199"<c:if test="${param.maxPrice==199}"> checked="checked"</c:if> id="${checkBoxIndex}"><label for="${checkBoxIndex}">￥0-￥199</label></li>
                    		<c:set var="checkBoxIndex" value="${checkBoxIndex+1}"/>
                            <li><input type="checkbox" minVal="200" maxVal="399"<c:if test="${param.maxPrice==399}"> checked="checked"</c:if> id="${checkBoxIndex}"><label for="${checkBoxIndex}">￥200-￥399</label></li>
                    		<c:set var="checkBoxIndex" value="${checkBoxIndex+1}"/>
                            <li><input type="checkbox" minVal="400" maxVal="799"<c:if test="${param.maxPrice==799}"> checked="checked"</c:if> id="${checkBoxIndex}"><label for="${checkBoxIndex}">￥400-￥799</label></li>
                    		<c:set var="checkBoxIndex" value="${checkBoxIndex+1}"/>
                            <li><input type="checkbox" minVal="800" maxVal="999"<c:if test="${param.maxPrice==999}"> checked="checked"</c:if> id="${checkBoxIndex}"><label for="${checkBoxIndex}">￥800-￥999</label></li>
                    		<c:set var="checkBoxIndex" value="${checkBoxIndex+1}"/>
                            <li><input type="checkbox" minVal="1000"<c:if test="${param.minPrice==1000}"> checked="checked"</c:if> id="${checkBoxIndex}"><label for="${checkBoxIndex}">￥1000以上</label></li>
                       	</ul>
                       	<input type="hidden" id="minPrice" <c:if test="${not empty param.minPrice}">name="minPrice" </c:if>value="${param.minPrice}"/>
                       	<input type="hidden" id="maxPrice" <c:if test="${not empty param.maxPrice}">name="maxPrice" </c:if>value="${param.maxPrice}"/>
                    </div>
                    <c:if test="${not empty param.rows}"><input type="hidden" name="rows" value="${param.rows}"/></c:if>
                    <c:if test="${not empty param.sort}"><input type="hidden" name="sort" value="${param.sort}"/></c:if>
                    <div class="blank10"></div>
                     <input id="clearCondition" type="reset" value="清除所有选项">
                    </form>
                    <script type="text/javascript">
                    	var c=$("#productListForm").find("input:checkbox");
                    	c.change(function(){
                    		if(!$(this).attr("name")){
                    			if($(this).attr("checked")){
                    				$("#productListPrice").find("input:checkbox").not($(this)).attr("checked",false);
                    				var min=$(this).attr("minVal");
                    				if(min){
                    					$("#minPrice").attr("name","minPrice").val(min);
                    				}else{
                    					$("#minPrice").removeAttr("name");
                    				}
                    				var max=$(this).attr("maxVal");
                    				if(max){
                    					$("#maxPrice").attr("name","maxPrice").val(max);
                    				}else{
                    					$("#maxPrice").removeAttr("name");
                    				}
                    			}else{
                    				$("#minPrice,#maxPrice").removeAttr("name");
                    			}
                    		}
                    		$("#productListForm").submit();
                    	});
                    	$("#clearCondition").click(function(){
                    		$("#minPrice").removeAttr("name");
                    		$("#maxPrice").removeAttr("name");
                    		$("#productListForm").find("input:checkbox").attr("checked",false);
							$("#productListForm").submit();
						});
                    </script>
                    </div><!--expmenu-->
                     </div><!--lyt-content-left-->
            <div class="lyt-sidebar-right">
	            <div class="clear"></div>
				<div class="hot-sell">
					<c:if test="${not empty productList}">
			        <form method="post" action="">
			              <div class="up_form">
						<div class="mama-page"><%@ include file="./include/productSort.jspf"%></div>
						<%-- ========== 分页开始 ========= --%>
			            <%@ include file="./../../decorators/include/catalogPagingTop.jsp"%>
						<%-- ========== 分页结束 ========= --%>
			              </div><!--up_form-->
						<%-- ========== 产品列表开始 ========= --%>
						<div class="productlist-wrap">
							<c:if test="${empty productList}"><fmt:message key="product.search.empty"/></c:if>
							<c:forEach items="${productList}" var="productItem" varStatus="varStatus">
								<%@ include file="include/incDefaultProductList.jspf"%>
							</c:forEach>
						</div>
						<%-- ========== 产品列表结束 ========= --%>
						<div class="clear"></div>
						<%-- ========== 分页开始 ========= --%>
						<%@ include file="./../../decorators/include/catalogPagingTop.jsp"%>
						<%-- ========== 分页结束 ========= --%>
						<div class="clear"></div>
					</form>
					</c:if>
		        </div>
	        </div>
	</body>
</html>