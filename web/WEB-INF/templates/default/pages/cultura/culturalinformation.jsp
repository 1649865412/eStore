<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<!--文化资讯列表页-->
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/index.css" />
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/list.css" />
		<link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
		<script src="${ctxPath}/scripts/jquery/js/modernizr.custom.js"></script>
	</head>
	<body>
			<div id="theSidebar" class="sidebar" >
				<div class="related">
					<a href="/culturalinformation/index.html" class="on" id="t1">全部</a>
					<a href="#section-2" id="t2">秀场</a>
					<a href="#section-3" id="t3">访谈</a>
					<a href="#section-4" id="t4">行业动态</a>
					<a href="#section-5" id="t5">线下主题活动</a>
					<a href="#section-6" id="t6">月刊</a>
				</div>
			</div>
		
			<div id="theGrid" class="main">
			
				<section class="grid">
				<c:forEach items="${culturalinformationList}" var="culList" varStatus="i">
				
			<c:choose>
              <c:when test="${i.count==1}">
       <a class="grid__item w-g-h" href="/culturalinformation/culturatemplate.html?culId=${culList.culturalInformationId}&lastId=null&nextId=${culturalinformationList[i.count+1].culturalInformationId}">
                </c:when>
              <c:when test="${i.count==fn:length(list)}">
       <a class="grid__item w-g-h" href="/culturalinformation/culturatemplate.html?culId=${culList.culturalInformationId}&lastId=${culturalinformationList[i.count-1].culturalInformationId}&nextId=null">
                </c:when>
                <c:otherwise>
          <a class="grid__item w-g-h" href="/culturalinformation/culturatemplate.html?culId=${culList.culturalInformationId}&lastId=${culturalinformationList[i.count-2].culturalInformationId}&nextId=${culturalinformationList[i.count].culturalInformationId}">
                </c:otherwise>
            </c:choose>
            
		
					
					
						<div class="w-g-header">
							<b></b>
							<c:if test="${culList.type == 0}">秀场</c:if>
							<c:if test="${culList.type == 1}">访谈</c:if>
							<c:if test="${culList.type == 3}">行业动态</c:if>
							<c:if test="${culList.type == 4}">线下主题活动</c:if>
							<c:if test="${culList.type == 5}">月刊</c:if>
							 | <fmt:formatDate value="${culList.releaseTime}" type="date" dateStyle="long"/>
						</div>
						<img src="${mediaPath}other/${culList.logoImg}" height="230"/>
						<h2 class="title title--preview">${culList.title}</h2>
						<p class="w-content">
							${culList.content}
						</p>
						<div class="w-g-pyf" onmouseover="setShare('${culList.title}', 'culturalinformation/culturatemplate.html?culId=${culList.culturalInformationId}');">
							评论数 (${culList.commentNumber}) | 阅读数 (${culList.readNumber}) |<a href="http://www.jiathis.com/share/?uid=2052677" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank")>分享</a> 
						</div>

						<div class="loader"></div>
						<div class="meta meta--preview">
							${culList.metaKeywork}
						</div>
					</a>
				</c:forEach>
				</section>
			</div>
			<!-- /container -->
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/classie.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/list.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jqueryjs/jquery.masonry.min.js"></script>
		<script type="text/javascript">
$(function(){  
//$(".w-paget").css("top",$("#theGrid .grid").outerHeight()-60);
$(window).load(function(){
	 $('#theGrid').masonry({
    itemSelector : '.grid__item',
    columnWidth: 0
});  

});
$(window).resize(function() {
		   $('#theGrid').masonry({
    itemSelector : '.grid__item',
    columnWidth: 0
});  

	});
});
</script>
<script type="text/javascript">
                          function setShare(title, url) {
                            //  alert("titile:"+title);
                            //  alert("url:"+url);
                            //  alert("http://"+window.location.host+"/"+url);
                              jiathis_config.title = title;
                              jiathis_config.url = "http://"+window.location.host+"/"+url;
                          }
                            var jiathis_config = {}
                          </script>  
<!--分享参数代码结束-->
<!--分享功能代码统一放到页尾-->
<script type="text/javascript" src="http://v1.jiathis.com/code/jia.js?uid=2052677" charset="utf-8"></script>
	</body>
</html>