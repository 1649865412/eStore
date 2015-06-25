<%@tag import="com.cartmatic.estore.common.model.catalog.ProductSku"%>
<%@tag import="java.util.List"%>
<%@ tag pageEncoding="UTF-8"%>
<%@tag import="com.cartmatic.estore.catalog.service.ProductMainManager"%>
<%@tag import="com.cartmatic.estore.core.util.ContextUtil"%>
<%@tag import="java.util.Map"%>
<%@tag import="com.cartmatic.estore.common.model.catalog.SkuOption"%>
<%@tag import="com.cartmatic.estore.common.model.catalog.SkuOptionValue"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ attribute name="productSkuId" required="true" rtexprvalue="true" type="java.lang.Integer" description="Sku Id"%>
<%
ProductMainManager productMainManager=(ProductMainManager)ContextUtil.getSpringBeanById("productMainManager");
Map<SkuOption,SkuOptionValue> result=productMainManager.findSkuOptionAndValuesByProductSku(productSkuId);
jspContext.setAttribute("__skuOptions",result);
%>
<c:forEach items="${__skuOptions}" var="optionAndValue">
	<span class="colour_trash"><i class="fa fa-angle-right fa-lg"></i></span>
	${optionAndValue.key.skuOptionName}：${optionAndValue.value.skuOptionValueName}<br/><br/>
</c:forEach>
<c:if test="${empty __skuOptions }">
	<span class="colour_trash"><i class="fa fa-angle-right fa-lg"></i></span>
     尺码：均码
     <br/>
     <span class="colour_trash"><i class="fa fa-angle-right fa-lg"></i></span>
     颜色：绿色
</c:if>