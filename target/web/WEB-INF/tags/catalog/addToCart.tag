<%@tag import="com.cartmatic.estore.common.model.catalog.Category"%>
<%@tag import="java.util.List"%>
<%@tag import="com.cartmatic.estore.Constants"%>
<%@tag import="com.cartmatic.estore.common.model.catalog.Product"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ attribute name="productSku" required="true" type="com.cartmatic.estore.common.model.catalog.ProductSku"%>
<%@ attribute name="imgSrc"%>
<%@ attribute name="quantity" description="购买产品数量"%>
<%@ attribute name="isDynaProdCode" type="java.lang.Boolean" description="是否动态指定code"%>
<%@ attribute name="checkHandler" description="添加到购物车前的检查"%>
<%
//根据产品状态及其所在目录（所有目录）的状态决定该产品是否可以添加入购物车
boolean canNotAddToCart=false;
Product product=productSku.getProduct();
if(product.getStatus().intValue()!=Constants.STATUS_ACTIVE.intValue()){
	canNotAddToCart=true;
}
if(!canNotAddToCart){
	List<Category> navigatorCategorys=(List<Category>)request.getAttribute("navigatorCategorys");
	if(navigatorCategorys==null){
		navigatorCategorys=product.getMainCategory().getNavigatorCategorys();
		for (Category category : navigatorCategorys) {
			if(category.getStatus().intValue()!=Constants.STATUS_ACTIVE.intValue()){
				canNotAddToCart=true;
				break;
			}
		}
	}
}
%>
<c:choose>
	<c:when test="<%=canNotAddToCart%>">
		<c:set var="addToCardImg">${ctxPath}<fmt:message key="image.btn.addtocart.off" /></c:set>
		<c:set var="addToCardAlt"><fmt:message key="btn.txt.outOfStock" /></c:set>
		<c:set var="addToCardDisabled" value="true"></c:set>
	</c:when>
	<c:when test="${productSku.product.availabilityRule==4||productSku.product.availabilityRule==5||productSku.inventory.availableQuantity>0}">
		<%--当商品是无限库存或者可售数量大于0，显示“加入购物车”按钮--%>
		<c:set var="addToCardImg">${ctxPath}<fmt:message key="image.btn.addtocart.on" />
		</c:set>
		<c:set var="addToCardAlt"><fmt:message key="btn.txt.addtocart.on" /></c:set>
	</c:when>
	<c:when test="${productSku.product.availabilityRule==2&&(productSku.product.preOrBackOrderLimit<1||productSku.inventory.preOrBackOrderedQty<productSku.product.preOrBackOrderLimit)}">
		<%--当销售规则是预订并且(不存在预订数限制或者已分配预订数少于最大预订数)，显示“预订”按钮--%>
		<c:set var="addToCardImg">${ctxPath}<fmt:message key="image.btn.addtocart.preOrder" />
		</c:set>
		<c:set var="addToCardAlt">Pre Order</c:set>
	</c:when>
	<c:when test="${productSku.product.availabilityRule==3&&(productSku.product.preOrBackOrderLimit<1||productSku.inventory.preOrBackOrderedQty<productSku.product.preOrBackOrderLimit)}">
		<%--当销售规则是缺货销售并且(不存在预订数限制或者已分配预订数少于最大预订数)，显示“预订”按钮--%>
		<c:set var="addToCardImg">${ctxPath}<fmt:message key="image.btn.addtocart.backOrder" />
		</c:set>
		<c:set var="addToCardAlt">Back Order</c:set>
	</c:when>
	<c:otherwise>
		<%--否则，显示“灰色加入购物车”按钮--%>
		<c:set var="addToCardImg">${ctxPath}<fmt:message key="image.btn.addtocart.off" />
		</c:set>
		<c:set var="addToCardAlt"><fmt:message key="btn.txt.outOfStock" /></c:set>
		<c:set var="addToCardDisabled" value="true"></c:set>
	</c:otherwise>
</c:choose>

<%--添加/更新购物车按钮start--%>
<c:choose>
	<c:when test="${not empty isDynaProdCode&&isDynaProdCode}">
		<%--如果isDynaProdCode是真的,那么所有参数都是request传入的
		<input id="addToCart" name="addToCart" type="image" src="${addToCardImg}" alt="${addToCardAlt}" align="absmiddle" border="0" systran="yes" onclick="$cm.addToC('${productSku.productSkuCode}','',${quantity});return false;" <c:if test="${addToCardDisabled}">disabled="true"</c:if> />
		--%>
		<input class="toggle1<c:if test="${addToCardDisabled}"> stock</c:if>" title="${addToCardAlt}" type="submit" value="${addToCardAlt}" onclick="$cm.addToC('${productSku.productSkuCode}','',${quantity});return false;" <c:if test="${addToCardDisabled}">disabled="disabled"</c:if> />
	</c:when>
	<c:otherwise>
		<%--否则自行去页面取得所需参数--%>
		<%--
		<input id="add2Cart<%=product.getId()%>" name="addToCart" type="image"  src="${resPath}/images/btn/btn_go.jpg" alt="${addToCardAlt}" align="absmiddle" border="0" systran="yes" onclick="<c:if test="${not empty checkHandler}">if(!${checkHandler}())return;</c:if>$cm.addToC($('#productSkuCode').val(),fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;" <c:if test="${addToCardDisabled}">disabled="disabled"</c:if> />
		<input id="add2Cart<%=product.getId()%>" class="toggle1<c:if test="${addToCardDisabled}"> stock</c:if><c:if test="${productSku.product.productKind==2}"> no-addtocart</c:if>" title="${addToCardAlt}" type="submit" value="${addToCardAlt}" onclick="<c:if test="${not empty checkHandler}">if(!${checkHandler}())return;</c:if>$cm.addToC($('#productSkuCode').val(),fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;" <c:if test="${addToCardDisabled}">disabled="disabled"</c:if> />
		 --%>
		 <div class="product_chose" >
              <a class="btn btn-danger"  id="add2Cart<%=product.getId()%>" name="addToCart" onclick="<c:if test="${not empty checkHandler}">if(!${checkHandler}())return;</c:if>$cm.addToC($('#productSkuCode').val(),fnGetSelectedCheckBoxValues('accessoriesCodes'),$('#quantity').val(),$('#selectAccessorys').val());return false;" <c:if test="${addToCardDisabled}">disabled="disabled"</c:if>>
               <i class="fa fa-shopping-cart fa-lg fa_storck"></i> 
				<fmt:message key="btn.txt.addtocart.on" />
              </a>
           </div>
	</c:otherwise>
</c:choose>
<%--添加/更新购物车按钮end--%>
