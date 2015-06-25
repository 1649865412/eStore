<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
	   <title>四方街网-设计师品牌首饰、配饰、手工配饰【设计师品牌正品保障】</title>	
		<meta name="keywords" content="设计师品牌配饰、首饰，手工配饰，手绳，项链，手链，四方街网" />
		<meta name="description" content="四方街网sifangstreet.com配饰频道，提供设计师品牌首饰，配饰，手工配饰款式，图片，价格，评价等信息，其中很多首饰和配饰在国内仅在四方街网有售。" />
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
	<!-- google分析统计 -->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-50473328-1', 'sifangstreet.com');
  ga('send', 'pageview');

</script>
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/> <decorator:getProperty property="body.onload" writeEntireProperty="true"/> <decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
		
			<%-- ========== 头部开始 ========= --%>
				<%@ include file="./include/header.jspf"%>
	
			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========= --%>
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
                   <c:set var="checkBoxIndex" value="1"/>
                 
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
                    <p>价格<span>Price</span><span class="arrow down"></span></p>
                    
                  </div><!--sort_title-->
                  <ul class="sort_list" style="display: none;" id="productListPrice">
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
                    <div class="blank24"></div>
                  
                   <div id="moving_tab">
              <div class="move_tabs">
                <div class="lava">
                </div>
                <span class="item" name="catHotSale">销量TOP5</span><span class="item"  name="catHotFavorite">最爱TOP5</span>
              </div><!--move_tabs-->
              
              
                <div class="mtab_content">
                <div class="catHotSale">
                  <ul>
            
                  
	                      <jsp:include flush="true" page="/sales/recommendedProduct.html">
	                            <jsp:param name="typeName" value="hot_sell" />
	                            <jsp:param name="firstResult" value="0" />
	                            <jsp:param name="maxResults" value="5" />
	                            <jsp:param name="template" value="sales/recommendProducts4Catalog2" />
	                            <jsp:param name="doAction" value="defaultAction" />
	                            <jsp:param name="sourceId" value="${category.categoryId}" />
	                      </jsp:include>
	                  </ul>
	                  
	                   <ul>
	                    
	                      <jsp:include flush="true" page="/sales/recommendedProduct.html">
	                            <jsp:param name="typeName" value="favorite" />
	                            <jsp:param name="firstResult" value="0" />
	                            <jsp:param name="maxResults" value="5" />
	                            <jsp:param name="template" value="sales/recommendProducts4Catalog2" />
	                            <jsp:param name="doAction" value="defaultAction" />
	                            <jsp:param name="sourceId" value="${category.categoryId}" />
	                      </jsp:include>
	                      </ul>
                   </div><!--catHotSale-->
              </div><!--mtab_content-->
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