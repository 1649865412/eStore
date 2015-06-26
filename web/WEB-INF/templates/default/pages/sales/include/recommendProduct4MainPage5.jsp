<%@ page  pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">
<div class="hot_items">

          <div class="hot_img">
        <product:productImg product="${productItem}" size="c" category="${category}"/>
        </div><!--hot_img-->
           <div class="hot_name">
            <p class="text_prod">
          <product:productName product="${productItem}" category="${category}" interceptLength="20"/>
           </p> 
         <br/>
         <p class="text_designer">${productItem.brand.brandName}</p>
         <br/>
            <p class="price">
            <product:showPrice productSku="${productItem.defaultProductSku}" viewType="4"/>
            </p>
            <br/>
           <p class="lab">热荐 HOT！ TOP ${varStatus.count}！</p>
         </div><!--hot_name--> 

     </div><!--hot_items-->
 
</c:forEach>
