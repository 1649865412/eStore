<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title><decorator:title /></title>
		<%@ include file="./include/meta.jspf"%>
		<%@ include file="./include/styles.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<%@ include file="./include/javascripts.jspf"%>
		<decorator:head />
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
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
		<decorator:getProperty property="page.header" />
		
			<%-- ========== 头部开始 ========= --%>
			
				<%@ include file="./include/header.jspf"%>

			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========= --%>
			<div class="lyt-maincontent">
				<div class="position-wrap">
					<%@ include file="include/navigatorBar.jspf"%>
				</div>
                <div class="blank10"></div>
                <decorator:body />
                <div class="blank10"></div>
			</div>
			<%-- ========== 内容结束 ========= --%>
     
			<%-- ========== 底部开始 ========= --%>
		
				<%@ include file="./include/footer.jspf"%>
	
			<%-- ========== 底部结束 ========= --%>
	
	</body>
</html>
