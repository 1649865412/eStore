<%@	tag pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ attribute name="var" type="com.cartmatic.estore.common.model.catalog.Product"%>

<c:if test="${not empty var.customerRating}">
   <c:set var="tempCustomerRating">${var.customerRating}</c:set>
   <c:set var="customerRatingTimes"></c:set>  
   <c:set var="isIncluded">${fn:contains(var.customerRating,"###")}</c:set>  
   <c:if test="${isIncluded eq true}">
       <c:set var="tempCustomerRating">${fn:substringBefore(var.customerRating,"###")}</c:set>
       <c:set var="customerRatingTimes">${fn:substringAfter(var.customerRating,"###")}</c:set>
   </c:if>
  			 <c:set var="customerRating" value='${fn:split(tempCustomerRating,".")}'/> 
         <c:if test="${not empty customerRating[0] }">   
           <c:forEach begin="1"  end="${0+customerRating[0]}" var="i">
               <img src="${resPath}/images/star/star_4.gif"/>
           </c:forEach>
       </c:if>    
         <c:if test="${(not empty customerRating[1]) and (0+customerRating[1] ne 0 )}">
             <img src="${resPath}/images/star/star_${customerRating[1]}.gif"/>
         </c:if>
         <c:if test="${not empty customerRating[2] }">                   
           <c:forEach begin="1"  end="${0+customerRating[2]}" var="i">
               <img src="${resPath}/images/star/star_0.gif"/>
           </c:forEach>
         </c:if>      
        <c:if test="${not empty customerRatingTimes}">     
            (${customerRatingTimes} <fmt:message key="productDetail.customerRating"/>)
        </c:if>          
 </c:if>
<c:if test="${empty var.customerRating}">             
     <c:forEach begin="1"  end="5" >
         <img src="${resPath}/images/star/star_0.gif"/>        
     </c:forEach>
      (0 <fmt:message key="productDetail.customerRating"/>)
</c:if>