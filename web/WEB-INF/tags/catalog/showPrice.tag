<%@	tag pageEncoding="UTF-8" 
	trimDirectiveWhitespaces="true"
 	import="com.cartmatic.estore.common.model.catalog.ProductSku,java.util.List,com.cartmatic.estore.common.helper.CatalogHelper"%><%@ 
 	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
 	taglib prefix="system" tagdir="/WEB-INF/tags/system"%><%@ 
 	taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%><%@ 
 	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@ 
 	taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><%@ 
 	attribute name="productSku" required="true" type="com.cartmatic.estore.common.model.catalog.ProductSku"%><%@ 
 	attribute name="viewType" type="java.lang.Short" description="默认显示适合一般列表；1只会显示一个价格，没有价格标签"%>
<%--
viewType=3
<span class="listPrice">US$ 139.99</span>&nbsp;&nbsp;<a href="#" class="price">US$ 99.99</a>

.price{color:#333; text-decoration:line-through;}加中划线
.ourPrice{color:#f26522; font-weight:bold;}实际的售价
.wholesalePrice{color:#999;}批发价
--%>
<sales:setDiscount productSku="${productSku}" />
<%
	CatalogHelper.getInstance().setPriceViewType(productSku);
%>
<c:choose>
	<c:when test="${viewType==1}">
		<%--只显示实际的售价--%>
		<c:choose>
			<c:when test="${productSku.priceViewType==2}">
				<span class="price" title="<fmt:message key="productDetail.salePrice" />">
				<system:CurrencyForRate value="${productSku.salePrice}" />
				</span>
				<system:otherCurrency value="${productSku.salePrice}"/>
			</c:when>
			<c:when test="${productSku.priceViewType==3}">
				<span class="price" title="<fmt:message key="productDetail.discountPrice" />">
				<system:CurrencyForRate value="${productSku.discountPrice}" />
				</span>
				<system:otherCurrency value="${productSku.discountPrice}"/>
			</c:when>
			<c:otherwise>
				<span class="price" title="<fmt:message key="productDetail.ourPrice" />">
				<system:CurrencyForRate value="${productSku.price}" />
				</span>
				<system:otherCurrency value="${productSku.discountPrice}"/>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test="${viewType==2}">
		<%--永远只会见到两个价. ”市场价”和”售价”或”售价”和”特价”--%>
		<c:if test="${productSku.priceViewType==1}">
			<li class="f12px">
			<fmt:message key="productDetail.listPrice" />：<span class="listPrice">
			<system:CurrencyForRate value="${productSku.listPrice}" />
			</span>
			<system:otherCurrency value="${productSku.listPrice}"/>
			</li>
		</c:if>
		<li class="${(productSku.priceViewType==2||productSku.priceViewType==3)?'f12px':'fB'}">
		<fmt:message key="productDetail.ourPrice" />:<span class="${(productSku.priceViewType==2||productSku.priceViewType==3)?'listPrice':'price'}">
		<system:CurrencyForRate value="${productSku.price}" />
		</span>
		<system:otherCurrency value="${productSku.price}"/>
		</li>
		<c:choose>
			<c:when test="${productSku.priceViewType==2}">
				<li class="fB">
				<fmt:message key="productDetail.salePrice" />:<span class="price">
				<system:CurrencyForRate value="${productSku.salePrice}" />
				</span>
				<system:otherCurrency value="${productSku.salePrice}"/>
				</li>
			</c:when>
			<c:when test="${productSku.priceViewType==3}">
				<li class="fB">
				<fmt:message key="productDetail.discountPrice" />:<span class="price">
				<system:CurrencyForRate value="${productSku.discountPrice}" />
				</span>
				<system:otherCurrency value="${productSku.discountPrice}"/>
				</li>
			</c:when>
		</c:choose>
	</c:when>
	<c:when test="${viewType==3}">
		<%--
		产品列表价格显示
		<span class="listPrice">US$ 139.99</span>&nbsp;&nbsp;<a href="#" class="price">US$ 99.99</a>
		--%>
		<c:if test="${productSku.priceViewType==1}">
			<span class="listPrice"><system:CurrencyForRate value="${productSku.listPrice}" /></span>&nbsp;&nbsp;
		</c:if>
		<span class="${(productSku.priceViewType==2||productSku.priceViewType==3)?'listPrice':'price'}">
			<system:CurrencyForRate value="${productSku.price}" />
		</span>
		<system:otherCurrency value="${productSku.price}"/>
		<c:choose>
			<c:when test="${productSku.priceViewType==2}">
				<span class="price">
					<system:CurrencyForRate value="${productSku.salePrice}" />
				</span>
			</c:when>
			<c:when test="${productSku.priceViewType==3}">
				<span class="price">
				<system:CurrencyForRate value="${productSku.discountPrice}" />
				</span>
			</c:when>
		</c:choose>
	</c:when>
	<c:when test="${viewType==4}">
		<%--
		价格显示,有促销的显示两个价格，原价格+划线,
		<span class="listPrice">US$ 139.99</span>&nbsp;&nbsp;<a href="#" class="price">US$ 99.99</a>
		--%>
		<c:choose>
			<c:when test="${productSku.priceViewType==2}">
				<span class="ourPrice"><system:CurrencyForRate value="${productSku.price}" /></span>
				<span class="price" title="<fmt:message key="productDetail.salePrice" />">
				<system:CurrencyForRate value="${productSku.salePrice}" />
				</span>
			</c:when>
			<c:when test="${productSku.priceViewType==3}">
				<span class="ourPrice"><system:CurrencyForRate value="${productSku.price}" /></span>
				<span class="price" title="<fmt:message key="productDetail.discountPrice" />">
				<system:CurrencyForRate value="${productSku.discountPrice}" />
				</span>
			</c:when>
			<c:otherwise>
				<span class="price" title="<fmt:message key="productDetail.ourPrice" />">
				<system:CurrencyForRate value="${productSku.price}" />
				</span>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<%--永远只会见到两个价. ”市场价”和”售价”或”售价”和”特价”--%>
		<c:if test="${productSku.priceViewType==1}">
			<fmt:message key="productDetail.listPrice" />:
			<span class="listPrice">
			<system:CurrencyForRate value="${productSku.listPrice}" />
			</span>
			<br />
		</c:if>
		<fmt:message key="productDetail.ourPrice" />:
		<span class="${(productSku.priceViewType==2||productSku.priceViewType==3)?'listPrice':'price'}">
		<system:CurrencyForRate value="${productSku.price}" />
		</span>
		<system:otherCurrency value="${productSku.price}"/>
		<br />
		<c:choose>
			<c:when test="${productSku.priceViewType==2}">
				<fmt:message key="productDetail.salePrice" />:
				<span class="price">
				<system:CurrencyForRate value="${productSku.salePrice}" />
				</span>
			</c:when>
			<c:when test="${productSku.priceViewType==3}">
				<fmt:message key="productDetail.discountPrice" />:
				<span class="price">
				<system:CurrencyForRate value="${productSku.discountPrice}" />
				</span>
			</c:when>
		</c:choose>
	</c:otherwise>
</c:choose>