<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ 
    taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ 
    attribute name="value" type="java.math.BigDecimal"%>
<c:if test="${empty value||value<0.1}"><c:set var="value" value="4"/></c:if>
<c:forEach begin="0" end="4" var="index">
<c:choose>
<c:when test="${value-index >= 1}"><img style="display: inline;" itemprop="rating" src="${resPath}/images/star-on.png" alt="stars_4"/></c:when>
<c:when test="${value-index >= 0.5}"><img itemprop="rating" src="${resPath}/images/star-off.png" alt="stars_2"/></c:when>
<c:otherwise><img itemprop="rating" src="${resPath}/images/star-off.png" alt="stars_0"/></c:otherwise>
</c:choose>
</c:forEach>
