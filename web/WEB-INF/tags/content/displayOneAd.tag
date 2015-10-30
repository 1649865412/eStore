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
			
			
			--%>
			<%--首页中间大图一--%>
			<c:when test="${ad.advertisementId == 78}">
			<a <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if> target="_blank">
		  		<div class="w-banner-con">
					<div class="w-b-bg" style="background-image: url(${mediaPath}a_and_d/${ad.url});">
					<!--<img src="img/bg.jpg" />-->
					</div>
					<div class="w-banner-txt">
					<c:if test="${ad.showContext ==1}">
						<c:if test="${ad.contextBackColor ==1}">
							<h1 style="color:black">${ad.contextTitle}</h1>
							<p style="color:black">${ad.contextSubTitle}</p>
						</c:if>
						<c:if test="${ad.contextBackColor ==2}">
							<h1>${ad.contextTitle}</h1>
							<p>${ad.contextSubTitle}</p>
						</c:if>
					</c:if>
					</div>
				</div>
			</a>
			</c:when>
			<%--首页中间大图二--%>
			<c:when test="${ad.advertisementId == 79}">
		  		<div class="w-banner-cont">
					<div class="w-banner-img" style="background-image: url(${mediaPath}a_and_d/${ad.url});"></div>
						<div class="w-bannert-txt">
							<div class="w-bannert-k">
							<c:if test="${ad.showContext ==1}">
								<c:if test="${ad.contextBackColor ==1}">
									<h1 style="color:black">${ad.contextTitle}</h1>
									<p style="color:black">${ad.contextSubTitle}</p>
								</c:if>
								<c:if test="${ad.contextBackColor ==2}">
									<h1>${ad.contextTitle}</h1>
									<p>${ad.contextSubTitle}</p>
								</c:if>
							</c:if>
					</div>
						<div class="w-bannert-kt">
						<c:if test="${ad.showContext ==1}">
							<c:if test="${ad.contextBackColor ==1}">
								<p style="color:black">${ad.context}</p>
							</c:if>
							<c:if test="${ad.contextBackColor ==2}">
								<p>${ad.context}</p>
							</c:if>
						</c:if>
						<a href="${ad.redirectUrl}">点击查看</a>
						</div>
					</div>
				</div>
			</c:when>
			<%--首页中间左图--%>
			<c:when test="${ad.advertisementId == 80}">
		  		<div class="w-lf-left">
		  		<a <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if>>
					<div class="w-lf-lrcon">
						<div class="w-lf-img" style="background-image: url(${mediaPath}a_and_d/${ad.url});">
							<div class="w-lf-yywz">
							<c:if test="${ad.showContext ==1}">
								<c:if test="${ad.contextBackColor ==1}">
									<p style="color:black">${ad.context}</p>
								</c:if>
								<c:if test="${ad.contextBackColor ==2}">
									<p>${ad.context}</p>
								</c:if>
							</c:if>
							</div>
						</div>
						<div class="w-lf-txt">
						<c:if test="${ad.showContext ==1}">
							<c:if test="${ad.contextBackColor ==1}">
								<h1 style="color:black">${ad.contextTitle}</h1>
							</c:if>
							<c:if test="${ad.contextBackColor ==2}">
								<h1>${ad.contextTitle}</h1>
							</c:if>
						</c:if>
						</div>
					</div>
				</a>
				</div>
			</c:when>
			<%--首页中间右图--%>
			<c:when test="${ad.advertisementId == 81}">
		  		<div class="w-lf-right">
		  		<a <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if>>
					<div class="w-lf-lrcon">
					<div class="w-lf-img" style="background-image: url(${mediaPath}a_and_d/${ad.url});">
						<div class="w-lf-yywz">
						<c:if test="${ad.showContext ==1}">
							<c:if test="${ad.contextBackColor ==1}">
								<p style="color:black">${ad.context}</p>
							</c:if>
							<c:if test="${ad.contextBackColor ==2}">
								<p>${ad.context}</p>
							</c:if>
						</c:if>
						</div>
					</div>
					<div class="w-lf-txt">
					<c:if test="${ad.showContext ==1}">
						<c:if test="${ad.contextBackColor ==1}">
							<h1 style="color:black">${ad.contextTitle}</h1>
						</c:if>
						<c:if test="${ad.contextBackColor ==2}">
							<h1>${ad.contextTitle}</h1>
						</c:if>
					</c:if>
					</div>
					</div>
					</a>
				</div>
			</c:when>
			<%--商城首页轮播图一--%>
			<c:when test="${ad.advertisementId == 82}">
				<div class="swiper-slide" style="background-image:url(${mediaPath}a_and_d/${ad.url})">
					<a <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if> target="_blank" class="sh_link">
						<div class="w-video">
						</div>
                        <div class="show_title">
                        <c:if test="${ad.showContext ==1}">
                        	<c:if test="${ad.contextBackColor ==1}">
	                            <h3 class="li1 title-font" style="color:black">${ad.contextTitle}</h3>
	                            <p><span style="color:black">${ad.contextSubTitle}</span></p>
                            </c:if>
                            <c:if test="${ad.contextBackColor ==2}">
                            	<h3 class="li1 title-font">${ad.contextTitle}</h3>
	                            <p><span>${ad.contextSubTitle}</span></p>
                            </c:if>
                        </c:if>
                        </div>
                     </a>
                    </div>
			</c:when>
			<%--商城首页轮播图二--%>
			<c:when test="${ad.advertisementId == 83}">
				<div class="swiper-slide" style="background-image:url(${mediaPath}a_and_d/${ad.url})">
					<a <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if> target="_blank" class="sh_link">
						<div class="w-video">
						</div>
                        <div class="show_title">
                        <c:if test="${ad.showContext ==1}">
                        	<c:if test="${ad.contextBackColor ==1}">
	                            <h3 class="li1 title-font" style="color:black">${ad.contextTitle}</h3>
	                            <p><span style="color:black">${ad.contextSubTitle}</span></p>
                            </c:if>
                            <c:if test="${ad.contextBackColor ==2}">
                            	<h3 class="li1 title-font">${ad.contextTitle}</h3>
	                            <p><span>${ad.contextSubTitle}</span></p>
                            </c:if>
                        </c:if>
                        </div>
                     </a>
                    </div>
			</c:when>
			<%--商城首页轮播图三--%>
			<c:when test="${ad.advertisementId == 88}">
				<div class="swiper-slide" style="background-image:url(${mediaPath}a_and_d/${ad.url})">
					<a <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if> target="_blank" class="sh_link">
						<div class="w-video">
						</div>
                        <div class="show_title">
                        <c:if test="${ad.showContext ==1}">
                        	<c:if test="${ad.contextBackColor ==1}">
	                            <h3 class="li1 title-font" style="color:black">${ad.contextTitle}</h3>
	                            <p><span style="color:black">${ad.contextSubTitle}</span></p>
                            </c:if>
                            <c:if test="${ad.contextBackColor ==2}">
                            	<h3 class="li1 title-font">${ad.contextTitle}</h3>
	                            <p><span>${ad.contextSubTitle}</span></p>
                            </c:if>
                        </c:if>
                        </div>
                     </a>
                    </div>
			</c:when>
			<%--商城首页轮播图二--%>
			<%--<c:when test="${ad.advertisementId == 83}">
				<div class="swiper-slide" style="background-image:url(${mediaPath}a_and_d/${ad.url})">
                        <div class="w-video">
							<video id="wvideo" autoplay>
								<source src="${mediaPath}a_and_d/${ad.mediaPathMpFour}" type="video/mp4"> 
								<source src="${mediaPath}a_and_d/${ad.mediaPathOgv}" type="video/ogv"> 
								<source src="${mediaPath}a_and_d/${ad.mediaPathMpWebm}" type="video/webm">
							</video>
						</div>
                    </div>
			</c:when>
			--%><%--商城首页右上角大图--%>
			<c:when test="${ad.advertisementId == 84}">
			<a class="index_right_title" <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if>>
				<div class="index_right" style="background-image:url(${mediaPath}a_and_d/${ad.url})">
				<c:if test="${ad.showContext ==1 && ad.contextTitle !=null && ad.contextTitle !=''}">
					<div class="have_text"></div>
				</c:if>
            	<c:if test="${ad.showContext ==1}">
            		<div class="text_content">
            		<c:if test="${ad.contextBackColor ==1}">
	                	<h3 class="li1 title-font" style="color:black">${ad.contextTitle}</h3>
	                    <p class="li2" style="color:black">${ad.contextSubTitle}</p>
	                    <p class="li3" style="color:black">${ad.context}</p>
                    </c:if>
                    <c:if test="${ad.contextBackColor ==2}">
	                	<h3 class="li1 title-font">${ad.contextTitle}</h3>
	                    <p class="li2">${ad.contextSubTitle}</p>
	                    <p class="li3">${ad.context}</p>
                    </c:if>
                    </div>
                </c:if>
            	</div>
            </a>
			</c:when>
			
			<%--每周上新顶部大图--%>
			<c:when test="${ad.advertisementId == 85}">
				<img src="${mediaPath}a_and_d/${ad.url}" width="100%">
            	<%--<div class="weekly-hd-info">
                	<div class="hd-info">${ad.contextTitle}<a href="${ad.redirectUrl}">了解更多关于品牌设计师的理念</a><font>>></font></div>
                    <div class="hd-info-text">
                    	${ad.context}
                    </div>
                </div>
			--%></c:when>
			
			<%--商品详情页底部广告--%>
			<c:when test="${ad.advertisementId == 86}">
			<a <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if>>
				<img src="${mediaPath}a_and_d/${ad.url}" width="100%">
				<div class="deta-bd-group3_info">
				<c:if test="${ad.showContext ==1}">
					<c:if test="${ad.contextBackColor ==1}">
                    	<h2 style="color:black">${ad.contextTitle}</h2>
                        <p style="color:black">${ad.context}</p>
                     </c:if>
                     <c:if test="${ad.contextBackColor ==2}">
                    	<h2>${ad.contextTitle}</h2>
                        <p>${ad.context}</p>
                     </c:if>
                </c:if>
                </div><!--deta-bd-group3_info-->
            </a>
			</c:when>
			
			<%--商城首页左侧广告--%>
			<c:when test="${ad.advertisementId == 87}">
				<div class="mall c" style="background:url(${mediaPath}a_and_d/${ad.url}) no-repeat">
			        <c:if test="${not empty brand}">
			        	<div class="mall_left">
			            	<div class="mrzt">
			            	<c:if test="${ad.showContext ==1}">
			            		<c:if test="${ad.contextBackColor ==1}">
			                		<div class="title-font" style="color:black">${ad.contextTitle}<br/>${ad.context}</div>
			                	</c:if>
			                	<c:if test="${ad.contextBackColor ==2}">
			                		<div class="title-font">${ad.contextTitle}<br/>${ad.context}</div>
			                	</c:if>
			                </c:if>
			                </div>
			            	<div class="mall_con">
			                	<div class="designer">
			                    	<a class="designer_left" href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}"><cartmatic:img isUrlOnly="false" url="${brand.icon}" mediaType="other" width="270" height="270" ></cartmatic:img></a>
			                        
			                        <div class="designer_right">
			                        <a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}">
			                        	<div class="li1 title-font">每周主打品牌设计师</div>
			                            <div class="li2">${brand.designer}</div>
			                            <div class="li3">${brand.brandName}</div>
			                        </a>
			                        </div>
			                        
			                    </div>
			                    <a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}">
			                    	<div class="designer_info"><c:out value="${fn:substring(brand.story, 0, 230)}......" /></div>
			                    </a>
			                    <div class="carefully_title title-font">每周主打品牌产品精选</div>
			                    <ul class="carefully_list list-unstyled c">
			                    	
			                    	<jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
										<jsp:param name="typeName" value="feature_product" />
										<jsp:param name="firstResult" value="0" />
										<jsp:param name="maxResults" value="6" />
										<jsp:param name="template" value="sales/include/recommendProduct4MainPage6" />
										<jsp:param name="doAction" value="defaultAction" />
										<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
									</jsp:include>
			                    	
			                    </ul>
			                    <div class="carefully_more list-unstyled c">
				                    <a class="li3" href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}">点击查看更多 >></a>
				                </div>
			                </div>
			            </div>
			            </c:if>
			            <ul class="mall_right list-unstyled">
			            
			            	<jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
										<jsp:param name="typeName" value="feature_product" />
										<jsp:param name="firstResult" value="0" />
										<jsp:param name="maxResults" value="6" />
										<jsp:param name="template" value="sales/include/recommendProduct4MainPage7" />
										<jsp:param name="doAction" value="defaultAction" />
										<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
							</jsp:include>
			            	
			            </ul>
			        </div>
			
			
			</c:when>
			
			<c:otherwise>
				<%--<cartmatic:img url="${ad.url}" mediaType="a_and_d" width="${ad.adPositionType.width}" height="${ad.adPositionType.height}" alt="${ad.advertisementDetail}"></cartmatic:img>
				--%>
					<%--<div class="w-video">
							<video id="wvideo" autoplay="autoplay" loop="loop">
								<c:if test="${ad.mediaPathMpFour !=null && ad.mediaPathMpFour !=''}">
									<source src="${mediaPath}a_and_d/${ad.mediaPathMpFour}" type="video/mp4">
								</c:if>
								<c:if test="${ad.mediaPathOgv !=null && ad.mediaPathOgv !=''}">
									<source src="${mediaPath}a_and_d/${ad.mediaPathOgv}" type="video/ogv">
								</c:if>
								<c:if test="${ad.mediaPathMpWebm !=null && ad.mediaPathMpWebm !=''}">
									<source src="${mediaPath}a_and_d/${ad.mediaPathMpWebm}" type="video/webm">
								</c:if>
							</video>
						</div>
					--%><section class="swiper-slide swiper-slide-o" style="background-image: url(${mediaPath}a_and_d/${ad.url});">
						<a <c:if test="${ad.redirectUrl != null && ad.redirectUrl != ''}">href="${ad.redirectUrl}"</c:if> target="_blank" class="a_link">
						<div class="ani resize swiper-o-to" swiper-animate-effect="fadeIn" swiper-animate-duration="1.5s" swiper-animate-delay="0s">
						<c:if test="${ad.showContext ==1}">
							<c:if test="${ad.contextBackColor ==1}">
								<h1 style="color:black">${ad.contextTitle}</h1>
								<p style="color:black">${ad.contextSubTitle}</p>
							</c:if>
							<c:if test="${ad.contextBackColor ==2}">
								<h1>${ad.contextTitle}</h1>
								<p>${ad.contextSubTitle}</p>
							</c:if>
						</c:if>
						</div>
						</a>
					</section>
			</c:otherwise>
		</c:choose>
