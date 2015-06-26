<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:if test="${empty productReviewList}">
        <div class="board" id="b3" style="display: block;">
            <div class="tab-content">
             <div class="tab-pane">
             
              <div class="write_comment" style="float: left;padding: 0 0 0 0;">
                <strong>该商品暂无评论。赶快来发表第一个评论吧！</strong>&nbsp;&nbsp;&nbsp;
                <a class="fancybox md-button" href="javascript:addReviewAction(${appConfig.isAllowAnonymousReview});" title="<fmt:message key="product.addReview.hint" />">
                我要评论
                </a>
               </div><!--write_comment-->
              
             </div><!--tab-pane-->
            </div><!--tab-content-->           
           </div>
</c:if>

<c:if test="${not empty productReviewList}">

	<div class="tab-content">
             <div class="tab-pane">
             
             	<c:forEach items="${productReviewList}" var="productReview" varStatus="itemStatus">
	             	<div class="comment-item">
	                <div class="row">
	                  <div class="col-lg-2">
	                    <div class="avatar">
	                      <img alt="avatar" src="${resPath }/images/default-avatar.jpg">
	                    </div><!--avatar-->
	                  </div><!--col-lg-2-->
	                  <div class="col-lg-10">
	                    <div class="comment-body">
	                       <div class="meta-info">
	                         <div class="author">
	                           <a>${productReview.subject}</a>
	                         </div><!--author-->
	                         <div class="date">
	                         <fmt:formatDate value="${productReview.updateTime}" pattern="yyyy-MM-dd HH:mm"/>
	                         </div><!--date-->
	                         <br/>
	                         <div class="star">
	                            <div class="target_star">
	                            </div>
	                            <input type="hidden" value="${productReview.rate}"/>
	                            
	                         </div><!--star-->
	                       </div><!--meta-info-->
	                       <br/>
	                       <p class="comment-text">
	                        ${productReview.message}
	                       </p><!--comment-text-->
	                       <div class="mama-btn" style="margin-top:2px;"><fmt:message key="productReview.reviewIsUseful" /></div>
							<div class="mama-btn" style="margin-left:10px;">
								<a href="javascript:fnVote('${productReview.productReviewId}','1')">是</a> &nbsp;&nbsp;&nbsp;
								<a href="javascript:fnVote('${productReview.productReviewId}','0')">否</a>
								&nbsp;&nbsp;&nbsp;
								<fmt:message key="productReview.voteHelpHint">
									<fmt:param value="${productReview.usefulCount + productReview.unusefulCount }" />
									<fmt:param value="${productReview.usefulCount + 0}" />
								</fmt:message>
							</div>
							<div class="clear"></div>
							<span class="green" id="info_${productReview.productReviewId}"></span>
	                    </div><!--comment-body-->
	                  </div><!--col-lg-10-->
	                </div><!--row-->
	              </div><!--comment-item-->
	              
             	</c:forEach>
                
              <div class="write_comment">
              <!-- javascript:addReviewAction(${appConfig.isAllowAnonymousReview}); -->
               <a class="fancybox md-button" href="javascript:addReviewAction(${appConfig.isAllowAnonymousReview});" title="<fmt:message key="product.addReview.hint" />">添加评论</a>
              </div><!--write_comment-->

             </div><!--tab-pane-->
     </div><!--tab-content-->  
     
</c:if>