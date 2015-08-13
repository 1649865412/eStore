<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<!--月刊详情页-->
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
		<link rel="stylesheet" type="text/css" href="${resPath}/styles/css/monthly.css" />
		<link href="${resPath}/styles/css/font-awesome.css" rel="stylesheet">
		<script src="${ctxPath}/scripts/jquery/js/book/js/modernizr.custom.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/classie.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
		

		<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/js/book/css/book.css" />
		<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/js/book/css/bookblock.css" />
		<link rel="stylesheet" type="text/css" href="${ctxPath}/scripts/jquery/js/book/css/component.css" />
		
	</head>
	<body>
			<div id="theSidebar" class="sidebar" >
				<div class="related">
					<a href="/culturalinformation/index.html" class="on" id="t1">全部</a>
					<a href="/culturalinformation/index.html?type=0" id="t2">秀场</a>
					<a href="/culturalinformation/index.html?type=1" id="t3">访谈</a>
					<a href="/culturalinformation/index.html?type=2" id="t4">行业动态</a>
					<a href="/culturalinformation/index.html?type=3" id="t5">线下主题活动</a>
					<a href="/culturalinformation/index.html?type=4" id="t6">月刊</a>
				</div>
			</div>
			<div id="theGrid" class="main">
					<div class="scroll-wrap">
							<div class="w-c-nrb">
								<div class="w-book">
									<div class="bb-custom-wrapper show" id="book-1">
										<div class="bb-bookblock">
											<div class="bb-item">
												<c:forEach items="${monthlyCultural}" var="culList" varStatus="i">
													<div class="bb-custom-side page-layout-3" style=" background: rgba(0, 0, 0, 0) url(${culList.img}) no-repeat scroll left top / cover ;">
													</div>
												</c:forEach>
											</div>
										</div><!-- /bb-bookblock -->
									</div><!-- /bb-custom-wrapper -->
									</div>
								<div class="w-c-np">
									<a href="#">
										<div class="w-c-prev">
											<div class="w-c-i">
												<i class="fa fa-angle-double-left"></i>
											</div>
											<div class="w-c-txt">
												<span>上一篇</span>
												<span class="w-c-ttitle">萬南子地報果海</span>
											</div>
										</div>
									</a>
									<a href="#">
										<div class="w-c-next">

											<div class="w-c-i">
												<i class="fa fa-angle-double-right"></i>
											</div>
											<div class="w-c-txt">
												<span>下一篇</span>
												<span class="w-c-ttitle">也車文說能不確西裡外門看或定手庭合麼樂軍了能</span>
											</div>
										</div>
									</a>
								</div>
							</div>
							<div class="w-c-links">
								<div class="w-lin-left">
									<b>标签：</b>
									<a href="#">对话</a>,
									<a href="#">时尚</a>,
									<a href="#">时尚预测</a>,
									<a href="#">Li EdelKoort</a>,
									<a href="#">设计博览会</a>
								</div>
								<div class="w-lin-right">阅读数 （12）| <a href="#">分享<i class="fa fa-share"></i></a></div>
							</div>
							<div class="w-x-wz content__item w-g-h">
								<h3>相关文章</h2>
								<div class="w-x-items">
									<div class="w-x-item  w-g-b">
										<div class="w-g-header">
											<b></b>时尚前言 | 2015年7月19日
										</div>
										<a href="#">
										<div class="w-x-imgs">
										<img src="img/list1.jpg"/>
										</div>
										<h2 class="title title--preview">2016春夏男装流行趋势：新简学主义</h2>
									</a>
										<div class="loader"></div>
										<div class="meta meta--preview">
											<a href="#">简学主义</a>,
							<a href="#">男装趋势</a>,
							<a href="#">流行趋势</a>,
							<a href="#">T台走秀</a>,
							<a href="#">伦敦时装周</a>,
							<a href="#">春夏时装周</a>
										</div>
									</div>
									<div class="w-x-item  w-g-y">
										<div class="w-g-header">
											<b></b>时尚前言 | 2015年7月19日
										</div>
										<a href="#">
										<div class="w-x-imgs">
										<img src="img/list2.jpg"/>
										</div>
										<h2 class="title title--preview">2016春夏男装流行趋势：新简学主义</h2>
									</a>
										<div class="loader"></div>
										<div class="meta meta--preview">
											<a href="#">简学主义</a>,
							<a href="#">男装趋势</a>,
							<a href="#">流行趋势</a>,
							<a href="#">T台走秀</a>,
							<a href="#">伦敦时装周</a>,
							<a href="#">春夏时装周</a>
										</div>
									</div>
									<div class="w-x-item  w-g-r">
										<div class="w-g-header">
											<b></b>时尚前言 | 2015年7月19日
										</div>
										<a href="#">
										<div class="w-x-imgs">
										<img src="img/list3.jpg"/>
										</div>
										<h2 class="title title--preview">2016春夏男装流行趋势：新简学主义</h2>
									</a>
										<div class="loader"></div>
										<div class="meta meta--preview">
											<a href="#">简学主义</a>,
							<a href="#">男装趋势</a>,
							<a href="#">流行趋势</a>,
							<a href="#">T台走秀</a>,
							<a href="#">伦敦时装周</a>,
							<a href="#">春夏时装周</a>
										</div>
									</div>
									<div class="w-x-item  w-g-l">
										<div class="w-g-header">
											<b></b>时尚前言 | 2015年7月19日
										</div>
										<a href="#">
										<div class="w-x-imgs">
										<img src="img/mem3.jpg"/>
										</div>
										<h2 class="title title--preview">2016春夏男装流行趋势：新简学主义</h2>
									</a>
										<div class="loader"></div>
										<div class="meta meta--preview">
											<a href="#">简学主义</a>,
							<a href="#">男装趋势</a>,
							<a href="#">流行趋势</a>,
							<a href="#">T台走秀</a>,
							<a href="#">伦敦时装周</a>,
							<a href="#">春夏时装周</a>
										</div>
									</div>
								</div>
							</div>
							<div class="w-c-pl">
								<!--jiaThis评论 UY BEGIN -->
<div id="uyan_frame"></div>
<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=2052677"></script>
<!-- UY END -->
							</div>

					</div>

					<button class="close-button-list"><i class="fa fa-close"></i><span>Close</span></button>
			</div>
			<!-- /container -->
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/classie.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/list.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/index.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jqueryjs/jquery.masonry.min.js"></script>
	</body>
</html>