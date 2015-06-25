<%@ page  pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">
<div class="slide">

        <product:productImg product="${productItem}" size="c" category="${category}"/>
       <div class="product_details">
         <p class="designer">${productItem.brand.brandName}</p>
         <p class="detail">已加入购物车</p>
       </div><!--product_details-->

</div><!--slide-->  
</c:forEach>