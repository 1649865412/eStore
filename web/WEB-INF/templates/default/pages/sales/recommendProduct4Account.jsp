<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<c:if test="${not empty productList}">
	<ul class="alsobuy">
		<c:forEach items="${productList}" var="productItem" varStatus="itemStatus">
			<li>
				 <product:productImg product="${productItem}" size="b" width="130" height="130"/>
				 <br/>
				 <product:productName product="${productItem}"/>
			</li>
		</c:forEach>
	</ul>
	<div class="clear"></div>
</c:if>