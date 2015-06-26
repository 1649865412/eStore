<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<html>
	<head>
		<title>${product.productName}</title>
		<meta name="keywords" content="${not empty product.metaKeyword?product.metaKeyword:product.productName}" />
		<meta name="description" content="${not empty product.metaDescription?product.metaDescription:product.productDescription.shortDescription}" />
	</head>
	<body>
		<%@ include file="../../decorators/include/styles.jspf"%>
		<%@ include file="../../decorators/include/javascripts.jspf"%>
		<div class="more-photo">
			<div class="small-photo" id="imgContent">
                    <a href="javascript:void(0);" onmouseover="fnChangeProdImg(this);" <c:if test="${0==param.imageIndex||empty param.imageIndex}"> class="selected"</c:if>><product:productImg product="${product}" size="a" noLink="true" width="46" height="46"/></a>
                    <c:forEach items="${productMoreImages}" var="productMoreImage">
                        <a href="javascript:void(0);" onmouseover="fnChangeProdImg(this);" <c:if test="${varStatus.count==param.imageIndex}"> class="selected"</c:if>>
                            <cartmatic:img url="${productMoreImage.mediaUrl}" mediaType="productMedia" size="a" width="46" height="46"/>
                        </a>
                    </c:forEach>
					<fmt:parseNumber integerOnly="true" value="${(fn:length(productMoreImages)+1)/5}" var="imgPageCount"></fmt:parseNumber>
					<fmt:parseNumber integerOnly="true" value="${(fn:length(productMoreImages)+1)%5}" var="imgPageTempMod"></fmt:parseNumber>
					<c:set var="imgPageCount" value="${(imgPageTempMod>0?1:0)+imgPageCount}"/>
					<input type="hidden" id="imgPageCount" value="${imgPageCount}">
				<div class="blank24"></div>
			</div>
		</div>
        <div class="blank10"></div>
        <div class="photo">
	        <c:choose>
	       		<c:when test="${0==param.imageIndex||empty param.imageIndex}">
	       			 <product:productImg product="${product}" size="v" noLink="true" id="productImg" />
	       		</c:when>
	       		<c:otherwise>
	       			 <c:forEach items="${productMoreImages}" var="productMoreImage" varStatus="varStatus">
	       			 		<c:if test="${varStatus.count==param.imageIndex}">
	       			 			<cartmatic:img url="${productMoreImage.mediaUrl}" mediaType="productMedia" size="v"  id="productImg"/>
	       			 		</c:if>
	             </c:forEach>
	       		</c:otherwise>
	       	</c:choose>
        </div>
		<script type="text/javascript">
			function fnChangeProdImg(img){
				var imglis=$("#imgContent").children();
				for(var i=0;i<imglis.length;i++){
					var imgli=$(imglis.get(i));
					if(imgli.get(0)==img){
						imgli.addClass("selected");
					}else{
						imgli.removeClass("selected");
					}
				}
				var imgsrc=$(img).find("img").attr("src").replace("/a/","/v/");
				
				$("#productImg").attr("src",__resPath+"/images/img/empty.gif");
				var newBigImage = document.createElement("IMG");
			    newBigImage.src = imgsrc;
				newBigImage.onload=function(){$("#productImg").attr("src",imgsrc);};
			}
			//产品详细页面图片下面的小图分页处理
			var imgPageCount=${imgPageCount};
			var imgOnePageLenght=265;
			var imgMaxLenght=imgPageCount*imgOnePageLenght;
			var imgPageNum=1;
			function moveR(){
				imgPageNum++;
				var pageIndex=imgPageNum-1;
				var leftPx=pageIndex*imgOnePageLenght;
				if(leftPx>=imgMaxLenght){
					$("#imgContent").attr("left",0+"px");
					imgPageNum=1;
				}else{
					$("#imgContent").attr("left",-leftPx+"px");
				}
				$("#imgPageShow").html(imgPageNum+"/"+imgPageCount);
			}
			function moveL(){
				imgPageNum--;
				var pageIndex=imgPageNum-1;
				var leftPx=pageIndex*imgOnePageLenght;
				if(leftPx<0){
					$("#imgContent").css("left",-(imgMaxLenght-imgOnePageLenght)+"px");
					imgPageNum=imgPageCount;
				}else{
					$("#imgContent").css("left",-leftPx+"px");
				}
				$("#imgPageShow").html(imgPageNum+"/"+imgPageCount);
			}
		</script>
	</body>
</html>