<%@ page language="java" errorPage="/error.jsp" contentType="text/html; charset=UTF-8" 
isELIgnored="false" buffer="24kb" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<%@ taglib uri="/WEB-INF/eStore.tld" prefix="eStore" %>
<%@ taglib uri="/WEB-INF/eStore.tld" prefix="v" %>
<%@ taglib uri="/WEB-INF/I18n.tld" prefix="i18n" %>
<%@ taglib uri="/WEB-INF/Functions.tld" prefix="cfn" %>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="attribute" tagdir="/WEB-INF/tags/attribute"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags/app"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" scope="application"/>
<c:if test="${pageContext.request.scheme == 'https'}">
<c:set var="mediaPath" value="/media/" scope="request"/>
</c:if>
<c:if test="${pageContext.request.scheme != 'https'}">
<c:set var="mediaPath" value="${appConfig.store.mediaUrlPath}" scope="request"/>
</c:if>
<c:set var="emptySpace" value=" " scope="request"/>