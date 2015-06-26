<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%><%@ 
	taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%><%@
	tag import="org.apache.commons.lang.StringUtils"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
	attribute name="mediaType" description="product,productMedia。默认为：product"%><%@ 
	attribute name="product" type="com.cartmatic.estore.common.model.catalog.Product" description="显示产品默认Sku的图片"%><%@ 
	attribute name="sku" type="com.cartmatic.estore.common.model.catalog.ProductSku" description="显示指定Sku的图片"%><%@ 
	attribute name="width" %><%@ 
	attribute name="height" %><%@ 
	attribute name="id" %><%@ 
	attribute name="alt" %><%@ 
	attribute name="onLoadHandler" %><%@ 
	attribute name="onClickHandler" %><%@ 
	attribute name="mouseOverHandler" %><%@ 
	attribute name="size" description="规格目录，相应的图片目录，如a,b,c,d;默认字母越大图片越大" required="true"%><%@ 
	attribute name="isUrlOnly" type="java.lang.Boolean" description="只打印图片Url，不包含path"%><%@ 
	attribute name="noLink" description="true 表示图片上有详细页超连接"%><%@ 
	attribute name="category" type="com.cartmatic.estore.common.model.catalog.Category" description="超连接 的产品目录"%>
<%@ attribute name="isLazyload" type="java.lang.Boolean" description="延迟加载"%>
<%
	if(StringUtils.isBlank(mediaType)){
		mediaType="product";
	}
	if(sku!=null){
		product=sku.getProduct();
	}else if(product!=null){
		sku=product.getDefaultProductSku();
	}
	if(StringUtils.isBlank(alt)){
		alt=product.getProductName();
	}
	jspContext.setAttribute("alt",alt);
%>
<c:if test="${empty noLink&&empty isUrlOnly}"><a base target="_blank" href="<product:productUrl product="<%=product%>" category="${pageScope.category}"/>" <c:if test="${not empty pageScope.alt}"> title="<c:out value="${pageScope.alt}"/>"</c:if>></c:if>
<cartmatic:img url="<%=sku.getImage()%>" mediaType="<%=mediaType%>" size="${size}" alt="" height="${height}" width="${width}" isUrlOnly="${isUrlOnly}" id="${id}" mouseOverHandler="${mouseOverHandler}" onClickHandler="${onClickHandler}" onLoadHandler="${onLoadHandler}" isLazyload="${isLazyload}"></cartmatic:img>
<c:if test="${empty noLink&&empty isUrlOnly}"></a></c:if>