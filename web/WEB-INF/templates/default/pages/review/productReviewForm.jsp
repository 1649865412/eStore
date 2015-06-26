<%@page import="com.cartmatic.estore.common.model.catalog.ProductReview"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="authz" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%
	request.setAttribute("productReview", new ProductReview());
%>
<%@ include file="/common/messages.jsp"%>
<!-- 
<link rel="stylesheet" href="${resPath }/styles/review_form.css"/>
  -->

		<form role="form" method="post" action="#" id="productReviewForm">
                  <div class="form-group">
                      <label for="inputFirstName" class="control-label">您的昵称:<span class="text-error">*</span></label>
                      <div>
                          <input name="customerName" id="productReview_username" type="text" class="form-control" size="40" value="${appUser.appuserId==-2?'':(empty appUser.firstname?appUser.username:appUser.firstname)}"/>
                      </div>
                  </div>
                  <div class="form-group">
                      <label for="input_title" class="control-label">评论标题:<span class="text-error">*</span></label>
                      <div>
                            <spring:bind path="productReview.subject">
								<input type="text" name="${status.expression}" id="${status.expression}" value="${status.value}" class="form-control" maxlength="128" size="40" />
							</spring:bind>
                      </div>
                  </div>
                  <div class="form-group">
                  	    <label for="input_comment" class="control-label">评论内容:<span class="text-error">*</span></label>
                        <spring:bind path="productReview.message">
							<textarea name="${status.expression}" id="${status.expression}" cols="60" rows="10" class="form-control">${status.value}</textarea>
						</spring:bind>
                  </div>
                  <div class="form-group">
                      <label class="control-label">星级评价:</label>
                      <div class="product-rating">
                          <div class="star">
                            <div class="target_star2" id="score_star"></div>
                          </div><!--star-->
                      </div>
                  </div>
                  <br/>
           		<input type="button" class="btn-default-1" value="提交评论" onclick="doReviewAction(this.form,${appConfig.isAllowAnonymousReview})" >
           <p>温馨提示：评论将在提交后72小时后显示，若评论中有涉及广告或违反国家法律的内容，四方街有权不显示或删除。</p>
         </form>

<script>
 $(function() {
	$('#score_star').raty({
		  scoreName: "productRate",
		  number: 5,//多少个星星设置		
		  path      : '${resPath}/images',
		  size      : 24,
		  start: 	3,
		  starOff   : 'star-off.png',
		  starOn    : 'star-on.png',
		  cancel    : false,
		  targetKeep: true,
		  targetText: '请选择评分'
		});
	 });
</script>

