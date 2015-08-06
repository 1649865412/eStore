<%@ tag pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
	taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%><%@ 
	attribute name="ad"	type="com.cartmatic.estore.common.model.content.Advertisement"%>
		<c:choose>
			<%--<c:when test="${not empty ad.redirectUrl}">
				<a href="${fn:indexOf(fn:toLowerCase(ad.redirectUrl),"http://")==0?'':ctxPath}${ad.redirectUrl}">
					<cartmatic:img url="${ad.url}" mediaType="a_and_d" width="${ad.adPositionType.width}" height="${ad.adPositionType.height}" alt="${ad.advertisementDetail}"></cartmatic:img>
				</a>
			</c:when>
			
			
			--%><c:when test="${ad.advertisementId == 78}">
		  		<div class="w-banner-con">
					<div class="w-b-bg" style="background-image: url(${mediaPath}a_and_d/${ad.url});">
					<!--<img src="img/bg.jpg" />-->
					</div>
					<div class="w-banner-txt">
						<h1>${ad.contextTitle}</h1>
						<p>${ad.contextSubTitle}</p>
					</div>
				</div>
			</c:when>
			
			<c:when test="${ad.advertisementId == 79}">
		  		<div class="w-banner-cont">
					<div class="w-banner-img" style="background-image: url(${resPath}/images/img/bg3.jpg);"></div>
						<div class="w-bannert-txt">
							<div class="w-bannert-k">
							<h1>${ad.contextTitle}</h1>
							<p>${ad.contextSubTitle}</p>
					</div>
						<div class="w-bannert-kt">
						<p>${ad.context}</p>
						<a href="${ad.redirectUrl}">点击查看</a>
						</div>
					</div>
				</div>
			</c:when>
			
			<c:when test="${ad.advertisementId == 80}">
		  		<div class="w-lf-left">
					<div class="w-lf-lrcon">
						<div class="w-lf-img" style="background-image: url(${mediaPath}a_and_d/${ad.url});">
							<div class="w-lf-yywz">
								<p>${ad.context}</p>
							</div>
						</div>
						<div class="w-lf-txt">
							<h1>${ad.contextTitle}</h1>
						</div>
					</div>
				</div>
			</c:when>
			
			<c:when test="${ad.advertisementId == 81}">
		  		<div class="w-lf-right">
					<div class="w-lf-lrcon">
					<div class="w-lf-img" style="background-image: url(${mediaPath}a_and_d/${ad.url});">
						<div class="w-lf-yywz">
							<p>${ad.context}</p>
						</div>
					</div>
					<div class="w-lf-txt">
						<h1>${ad.contextTitle}</h1>
					</div>
					</div>
				</div>
			</c:when>
			
			<c:otherwise>
				<%--<cartmatic:img url="${ad.url}" mediaType="a_and_d" width="${ad.adPositionType.width}" height="${ad.adPositionType.height}" alt="${ad.advertisementDetail}"></cartmatic:img>
				--%>
					<section class="swiper-slide swiper-slide-o" style="background-image: url(${mediaPath}a_and_d/${ad.url});">
						<div class="w-video">
							<video autoplay="" loop="">
								<source src="${mediaPath}a_and_d/${ad.mediaPathMpFour}" type="video/mp4"> 
								<source src="${mediaPath}a_and_d/${ad.mediaPathOgv}" type="video/ogv"> 
								<source src="${mediaPath}a_and_d/${ad.mediaPathMpWebm}" type="video/webm">
							</video>
						</div>
						<div class="ani resize swiper-o-to" swiper-animate-effect="fadeIn" swiper-animate-duration="1.5s" swiper-animate-delay="0s">
							<h1>${ad.contextTitle}</h1>
							<p>${ad.contextSubTitle}</p>
						</div>
					</section>
			</c:otherwise>
		</c:choose>
