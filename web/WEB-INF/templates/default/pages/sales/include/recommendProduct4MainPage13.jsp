<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
					<li>
                    	<dl>
                            <dt>
	                            <c:forEach items="${productList}" var="product" varStatus="varStatus" begin="0" end ="0">
	                            	<a href="${ctxPath}/product/${product.productId}.html"><img src="${mediaPath}product/v/${product.defaultProductSku.image}" /><span><p>${product.productName}</p><product:showPrice productSku="${product.defaultProductSku}" viewType="5"/></span></a>
	                            </c:forEach>
                            </dt>
                            <dd>
	                            <c:forEach items="${productList}" var="product" varStatus="varStatus" begin="1" end ="2">
	                            	<a href="${ctxPath}/product/${product.productId}.html"><img src="${mediaPath}product/v/${product.defaultProductSku.image}" /><span><p>${product.productName}</p><product:showPrice productSku="${product.defaultProductSku}" viewType="5"/></span></a>
	                            </c:forEach>
                                <a href="javascript:;" class="buy_btn"><img src="images/yearly1.jpg"></a>
                            </dd>
                        </dl>
                    </li>
                    <li>
                    	<dl>
                            <dt>
	                            <c:forEach items="${productList}" var="product" varStatus="varStatus" begin="3" end ="3">
	                            	<a href="${ctxPath}/product/${product.productId}.html"><img src="${mediaPath}product/v/${product.defaultProductSku.image}" /><span><p>${product.productName}</p><product:showPrice productSku="${product.defaultProductSku}" viewType="5"/></span></a>
	                            </c:forEach>
                            </dt>
                            <dd>
                                <c:forEach items="${productList}" var="product" varStatus="varStatus" begin="4" end ="5">
                            		<a href="${ctxPath}/product/${product.productId}.html"><img src="${mediaPath}product/v/${product.defaultProductSku.image}" /><span><p>${product.productName}</p><product:showPrice productSku="${product.defaultProductSku}" viewType="5"/></span></a>
                            	</c:forEach>
                                <a href="javascript:;" class="buy_btn"><img src="images/yearly2.jpg"></a>
                            </dd>
                        </dl>
                    </li>
