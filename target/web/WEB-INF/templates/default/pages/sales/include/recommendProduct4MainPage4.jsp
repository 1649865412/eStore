<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<c:forEach items="${productList}" var="productItem" varStatus="varStatus">
 <div class="book_items">

        <div class="book_img">
        <product:productImg product="${productItem}" size="c" category="${category}"/>
        </div><!--book_img-->
        <div class="book_name">
            <p class="text_prod">
          <product:productName product="${productItem}" category="${category}" interceptLength="20"/>
           </p> 
         <br/>
         <p class="text_designer">${productItem.brand.brandName}</p>
         <br/>
            <p class="price">
            <product:showPrice productSku="${productItem.defaultProductSku}" viewType="4"/>
            </p>
           
         </div><!--book_name-->  

     </div><!--book_items-->
 
</c:forEach>
