<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>

<!--产品列表页左边类型组件与产品列表页销量top，最爱top组件   鞋与衣服页面 --->

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>
		女鞋、设计师品牌女鞋-四方街网sifangstreet|设计师品牌正品保障
		</title>
		<%@ include file="./include/meta.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<%@ include file="./include/styles4.jspf"%>
		<%@ include file="./include/javascripts3.jspf"%>
		
		<decorator:head />
		 <script>
	  $(document).ready(function () {

		$(":range").rangeinput({progress: true});

			/* Slide Toogle */
			$(".sort_title").click(function()
			{
				var arrow = $(this).find("span.arrow");

				if(arrow.hasClass("up"))
				{
					arrow.removeClass("up");
					arrow.addClass("down");
				}
				else if(arrow.hasClass("down"))
				{
					arrow.removeClass("down");
					arrow.addClass("up");
				}

				$(this).parent().find(".sort_list").slideToggle();
			});
		
	});
	
      </script>
      <script>
	
	  $(document).ready(function () {

		//set the default location (fix ie 6 issue)
		$('.lava').css({left:$('span.item:first').position()['left']});
		
		$('.item').mouseover(function () {
			//scroll the lava to current item position
			$('.lava').stop().animate({left:$(this).position()['left']}, {duration:200});
			
			//scroll the panel to the correct content
			$('.catHotSale').stop().animate({left:$(this).position()['left'] * (-2)}, {duration:200});
		});
		
	});
	
	</script>
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/> <decorator:getProperty property="body.onload" writeEntireProperty="true"/> <decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
		
			<%-- ========== 头部开始 ========= --%>
				<%@ include file="./include/header.jspf"%>
	
			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========= --%>
			<div class="w-shooping-list">
			<div class="w-shooping-list-sort">
            	<ul class="row">
                	<li>
                    	<div class="sort-tit">男排序方式<i class="fa fa-caret-down"></i></div>
                        <p><a class="active">默认</a></p> 
                        <p><a href="#">最新上架</a></p>
                        <p><a href="#">价格由低到高</a></p>
                        <p><a href="#">价格由高到低</a></p>
                    </li>
                    
               		<li>
                        <p><div class="attribute-item">
				                  <p><a class="active">所有产品</a></p> 
				                 
				                     <product:showCategorys categoryType="1" displayCategoryId="1" displayLevel="1" excludeCode="all"></product:showCategorys>
				                        	<c:forEach items="${categoryTreeItems}" var="categoryTreeItem">
									        	<p>
									        		<c:if test="${categoryTreeItem.name != '关于四方街'}">
									        			<a href="<product:categoryUrl category="${categoryTreeItem}" />">${categoryTreeItem.name}</a>
									        		</c:if>
									        	</p>
				                        	</c:forEach>
				               </div>
				          </p> 
                    </li>
                    <li>
                    <li>
                    
                        <p><a class="active">所有产品</a></p> 
                        <p><a href="#"><i class="fa fa-venus"></i>女性</a></p>
                        <p><a href="#"><i class="fa fa-mars"></i>男性</a></p>
                    </li>
                    <li>
                        <p><b>服装</b></p> 
                        <p><a href="#">外套</a></p>
                        <p><a href="#">上衣</a></p>
                        <p><a href="#">裙子</a></p>
                        <p><a href="#">裤子</a></p>
                    </li>
                    <li>
                        <p><b>鞋品</b></p> 
                        <p><a href="#">平底鞋/芭蕾鞋</a></p>
                        <p><a href="#">凉鞋/拖鞋</a></p>
                        <p><a href="#">靴子/雨鞋</a></p>
                        <p><a href="#">高跟鞋</a></p> 
                        <p><a href="#">商务鞋</a></p>
                        <p><a href="#">休闲鞋</a></p>
                        <p><a href="#">运动鞋</a></p>
                    </li>
                    <li>
                        <p><b>配件</b></p> 
                        <p><a href="#">眼镜</a></p>
                        <p><a href="#">配饰</a></p>
                        <p><a href="#">帽子</a></p>
                        <p><a href="#">手表</a></p> 
                        <p><a href="#">围巾</a></p>
                        <p><a href="#">包箱</a></p>
                    </li>
                </ul>
                <div class="sort-btn">
                	<i class="fa fa-chevron-right"></i>
                    <p>分<br>类<br>筛<br>选</p>
                </div>
            </div>
            <div class="w-shooping-list-box">
            <ul class="row">
				<c:forEach items="${productList}" var="product" varStatus="varStatus">
					<li><a href="#"><img src="${product.defaultProductSku.image}"></a>
                        <div class="bd-list-tit"><span>SALE</span><a href="#">${product.productName}</a></div>
                        <p><span>${product.brand.designer}</span></p>
                        <p><em>${product.brand.brandName}</em></p>
                        <p><b>￥ ${product.defaultProductSku.salePrice}</b></p>
                        <p><a href="#"><i class="fa fa-share-alt"></i> 分享</a><a href="#"><i class="fa fa-heart-o"></i> 加入收藏</a><a href="#"><i class="fa fa-cart-plus"></i> 加入购物车</a></p>
                    </li>
				</c:forEach>
            
            </ul>
                <div class="w-page">
                	<a href="#"><i class="fa fa-long-arrow-left"></i></a>
                    <a href="#">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    ·······
                    <a href="#"><i class="fa fa-long-arrow-right"></i></a>
                </div>
            </div>
        </div>
			
			
			
			
			
			
			
			 <div class="maincontent" id="productlist_main">
			  <div>
						<content:showAd adPositionType="liebiao" />
			</div>
			 <div class="position-wrap">
           <%@ include file="include/navigatorBar.jspf"%>
         </div>
         <div class="lyt-content-left">
            <div class="expmenu">
           <form action="${category.url}" method="get" id="productListForm">
               <div class="attribute-item">
                
                  <div class="sort_title">
                    <p>精选 <span>Collection</span><span class="arrow up"></span></p>
                    
                  </div><!--sort_title-->
                 
                  <ul class="sort_list">
                     <product:showCategorys categoryType="1" displayCategoryId="1" displayLevel="1" excludeCode="all"></product:showCategorys>
                        	<c:forEach items="${categoryTreeItems}" var="categoryTreeItem">
					        	<li>
					        		<c:if test="${categoryTreeItem.name != '关于四方街'}">
					        			<a href="<product:categoryUrl category="${categoryTreeItem}" />">${categoryTreeItem.name}</a>
					        		</c:if>
					        	</li>
                        	</c:forEach>
                  </ul>
               </div>
               
                <div class="attribute-item">
                  <div class="sort_title">
                    <p>服装<span>accessories</span><span class="arrow up"></span></p>
                  </div><!--sort_title-->
                  <ul class="sort_list">
                   <product:showCategorys categoryType="1" displayCategoryCode="Mmeizhuang" displayLevel="2"></product:showCategorys>
                        	<c:forEach items="${categoryTreeItems}" var="categoryTreeItem">
					        	<li><a href="<product:categoryUrl category="${categoryTreeItem}" />">${categoryTreeItem.name}</a></li>
                        	</c:forEach>
                  </ul>
               </div>
               
              <div class="attribute-item">
                  <div class="sort_title">
                    <p>鞋品<span>Shoes</span><span class="arrow up"></span></p>
                    
                  </div><!--sort_title-->
                  <ul class="sort_list">
                   <product:showCategorys categoryType="1" displayCategoryCode="Mshoes" displayLevel="1"></product:showCategorys>
                        	<c:forEach items="${categoryTreeItems}" var="categoryTreeItem">
					        	<li><a href="<product:categoryUrl category="${categoryTreeItem}" />">${categoryTreeItem.name}</a></li>
                        	</c:forEach>
                  </ul>
               </div>
               
                 <div class="attribute-item">
                  <div class="sort_title">
                    <p>配件<span>accessories</span><span class="arrow up"></span></p>
                  </div><!--sort_title-->
                  <ul class="sort_list">
                   <product:showCategorys categoryType="1" displayCategoryCode="Maccessories" displayLevel="2"></product:showCategorys>
                        	<c:forEach items="${categoryTreeItems}" var="categoryTreeItem">
					        	<li><a href="<product:categoryUrl category="${categoryTreeItem}" />">${categoryTreeItem.name}</a></li>
                        	</c:forEach>
                  </ul>
               </div>
               
               
               
               
                    <attribute:attribute var="attribute" attributeCode="changhe"></attribute:attribute>
                    <c:set var="checkBoxIndex" value="1"/>
                    <div class="attribute-item">
                    	  <div class="sort_title">
                    <p>场合<span>Occasion</span><span class="arrow down"></span></p>
                    
                  </div><!--sort_title-->
                  
                        <ul class="sort_list"  style="display:none">
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
                    <p>跟型<span>Heel</span> <span class="arrow down"></span></p>
                   
                  </div><!--sort_title-->
                        <ul class="sort_list" style="display: none;">
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
                    <p>颜色<span>Color</span> <span class="arrow down"></span></p>
                   
                  </div><!--sort_title-->
                  
                         <ul class="sort_list selected_color" style="display: none;">
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
                    <p>尺码<span>Size</span> <span class="arrow down"></span></p>
                   
                  </div><!--sort_title-->
                  <ul class="sort_list" style="display: none;">
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
                    <div class="blank24"></div>
                  
                   <div id="moving_tab">
              
              
            </div><!--moving_tab-->
         </div><!--lyt-content-left-->
         
                <div class="lyt-sidebar-right">
                	<decorator:body />
                </div><!--lyt-sidebar-right-->
      </div><!--end of maincontent-->
			<%-- ========== 内容结束 ========= --%>
            <div class="blank10"></div>
			<%-- ========== 底部开始 ========= --%>
			
				<%@ include file="./include/footer.jspf"%>
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>