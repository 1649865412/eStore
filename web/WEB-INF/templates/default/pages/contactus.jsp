<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<head>
	<title>Contact Us</title>
	<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
</head>
<body>
	<content tag="heading"> Contact Us</content>
		<div class="news-content">
			<h1>
				Contact Us
			</h1>
				<c:choose>
					<c:when test="${param.info!='Success'}">
						 <p>If you have any pre-sale inquires or need any after-sale customer service, please feel free to contact our Help Center. We always have someone on hand to answer your questions and will do everything possible to satisfy our customers. You may also refer to <strong>Frequently Asked Questions</strong>.</p>
						 <p> 
							 <span class="f13px fB">•</span> <strong>Email :</strong><br>
							  &nbsp;&nbsp;&nbsp;<a href="mailto:sales@handbagsmama.com">sales@handbagsmama.com</a> for any questions 24/7. Guaranteed personal reply within 1 business day.
						 </p>
						 <p> 
							 <span class="f13px fB">•</span> <strong>Web Form Ticket :</strong><br>
							  &nbsp;&nbsp;&nbsp;You may also submit a ticket in the following, and we will get back to you as soon as possible. 
						 </p>
						 <div class="blank10"></div>
						 <strong> &nbsp;&nbsp;&nbsp;Required items indicated with *. Be sure to click ‘Submit’.</strong>
						<form id="contactusForm" action="${ctxPath}/contactUsForm.html" method="post">
							<input type="hidden" name="doAction" value="sendContact" />
							<table width="100%" cellspacing="0" cellpadding="0" border="0" class="contactus">
								<tr>
									<th width="30%">
										<span class="cRed">*</span> Full Name :
									</th>
									<td>
										<input type="text" class="box-input" name="fullName"
											value="${param.fullName}" />
									</td>
								</tr>
								<tr>
									<th>
										<span class="cRed">*</span> Email :
									</th>
									<td>
										<input type="text" class="box-input" name="email"
											value="${param.email}" />
									</td>
								</tr>
								<tr>
									<th>
										<span class="cRed">*</span> Phone Number :
									</th>
									<td>
										<input type="text" class="box-input" name="phoneNumber"
											value="${param.phoneNumber}" />
									</td>
								</tr>
								<%-- <tr>
									<th>
										<span class="cRed">*</span> City :
									</th>
									<td>
										<input type="text" class="box-input" name="city"
											value="${param.city}" />
									</td>
								</tr>
								<tr>
									<th>
										<span class="cRed">*</span> Country :
									</th>
									<td>
										<input type="text" class="box-input" name="country"
											value="${param.country}" />
									</td>
								</tr>--%>
								<tr>
									<th>
										Order No. :
									</th>
									<td>
										<input type="text" class="box-input" name="orderNo"
											value="${param.orderNo}" /> (For the after-sale customer service.)
									</td>
								</tr>
								<tr>
									<th>
										<span class="cRed">*</span> Subject :
									</th>
									<td>
										<input type="text" class="box-input" name="subject" value="${param.subject}" />
									</td>
								</tr>
								<tr>
									<th valign="top">
										Comments :
									</th>
									<td>
										<textarea name="comments" rows="7" cols="40" class="box-input">${param.comments}</textarea>
									</td>
								</tr>
								<tr>
									<th valign="top">
										verification code:
									</th>
									<td>
										<input type="text" autocomplete="off" name="validationCode"
										 maxlength="30" class="box-input"
											tabindex="3" />
										<img id="imgValidationCode"
											src="${ctxPath}/validateCode.html"
											alt="Can't see the image?" style="vertical-align: middle;" /><br />
										Can't see the image?
										<a onClick="return refreshImage();" href="#">Load new image</a>.
										<c:if test="${info=='error'}">
											<br />
											<span class="cRed">Incorrect verification code, please
												try again.</span>
										</c:if>
									</td>
								</tr>
								<tr>
									<th></th>
									<td>
										<input type="submit" value=" Submit " />
									</td>
								</tr>
							</table>
						</form>
					</c:when>
					<c:otherwise>
						<br />
						Dear ${param.fullName},
						<br />
						<br />
						Thank you for your message and one of our customer service representatives will get back to you within the next 12 hours. 
						<br />
						<br />
						If you have any further inquiry, please email us directly at <a href="mailto:sales@handbagsmama.com">sales@handbagsmama.com</a>. Thanks again for shopping at ${appConfig.store.name}!
						<br />
						<br />
						<br />
					</c:otherwise>
				</c:choose>
	</div>
	<script type="text/javascript">
	$("#contactusForm").validate({rules:{
			fullName:{required:true,minlength:4},
			email:{required:true,email:true},
			phoneNumber:{required:true,number:true, rangelength:[6,15]},
			subject:{required:true,minlength:10},
			comments:{required:true,minlength:20}
		},
	messages:{
			email:{
				required:"Sorry,fullName is required.",
				email:'Are you sure your Email address is correct? E-mail addresses must contain an "at" sign (@) and a period (.) somewhere to the right of the @, with no spaces or commas. (Example: yourname@gmail.com)'
			},
			email:{
				required:"Sorry,email address is required.",
				email:'Are you sure your Email address is correct? E-mail addresses must contain an "at" sign (@) and a period (.) somewhere to the right of the @, with no spaces or commas. (Example: yourname@gmail.com)'
				},
			phoneNumber:{
					required:"Sorry, a phoneNumber is required.",
					number:"Please enter your phone number (between 6 and 15 characters).",
					rangelength:"Please enter your phone number (between 6 and 15 characters).",
				},
			subject:{
					required:"Sorry, a subject is required.",
					minlength:"Your subject must contain a minimum of 10 characters."
				},
			comments:{
					required:"Sorry, a subject is required.",
					minlength:"Your subject must contain a minimum of 20 characters."
				}
		}
	});
	function refreshImage() {
		var image = document.getElementById("imgValidationCode");
		var url = "${ctxPath}/validateCode.html";
		var xmlHttpReq = null;
		if (window.ActiveXObject) {
			xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xmlHttpReq = new XMLHttpRequest();
		}
		xmlHttpReq.open("Post", url, true);
		xmlHttpReq.send(null);
		image.src = "${ctxPath}/validateCode.html?rand="
				+ parseInt(1000 * Math.random());
		return false;
	}
</script>
</body>
</html>