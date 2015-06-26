<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title><decorator:title /></title>
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
			
			 <div class="maincontent">
			  <div>
			        <c:if test="${not empty brand.brandName}">
					<cartmatic:img url="${brand.pic2}" mediaType="other"/>
					</c:if>
					<c:if test="${empty productList}">
						抱歉，没有找到与“${param.q}”相关的商品。
					</c:if>			  
					
			</div>
			 <div class="position-wrap">
            <%@ include file="include/navigatorBar.jspf"%>
           </div>	
			
					<decorator:body />
				 </div><!--end of maincontent-->	
			<%-- ========== 内容结束 ========= --%>
			   <div class="blank10"></div>
			<%-- ========== 底部开始 ========= --%>
				<%@ include file="./include/footer.jspf"%>
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>