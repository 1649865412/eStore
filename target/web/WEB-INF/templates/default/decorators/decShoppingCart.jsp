<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title>${appConfig.store.title}${emptySpace}<decorator:title /></title>
		<meta name="keywords" content="${appConfig.store.keyWords}" />
		<meta name="description" content="${appConfig.store.description}" />
		<%@ include file="./include/meta.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<%@ include file="./include/javascripts.jspf"%>
		<link rel="icon" href="${resPath}/images/favicon.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="${resPath}/images/mindo.ico" type="image/x-icon" />
		<decorator:head />
	</head>
	<body <decorator:getProperty property="body.id" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
		<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
			<%-- ========== 头部开始 ========= --%>
				<%@ include file="./include/header.jspf"%>
			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========= --%>
			<div class="lyt-maincontent">
				<div class="productlist-wrap">
					<%@ include file="/common/messages.jsp"%>
					<decorator:body />
				</div>
				
                <div class="blank10"></div>
                <%--AlsoBuy栏 参数sourceIds 是一个字符串的形式,如1,2,3  1 2 3为购买的productId,用","分隔 --%>
                <%--<jsp:include flush="true" page="/sales/recommendedProduct.html">
                    <jsp:param name="sourceFormat" value="list" />
                    <jsp:param name="typeName" value="also_buy" />
                    <jsp:param name="sourceIds" value="${sourceIds}" /> 
                    <jsp:param name="firstResult" value="0" />
                    <jsp:param name="maxResults" value="5" />
                    <jsp:param name="template" value="sales/recommendProducts" />
                    <jsp:param name="doAction" value="defaultAction" />
                </jsp:include>--%>
			</div>
			<%-- ========== 内容结束 ========= --%>
            <div class="blank10"></div>
			<%-- ========== 底部开始 ========= --%>
				<%@ include file="./include/footer.jspf"%>
			<%-- ========== 底部结束 ========= --%>
	</body>
</html>