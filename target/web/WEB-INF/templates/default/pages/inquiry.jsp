<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<head>
	<title>Contact Us</title>
</head>
<body>
		<form id="inquiryForm" name="inquiryForm" action="${ctxPath}/contactUsForm.html" method="post">
			<input type="hidden" name="doAction" value="inquiry" />
			<table width="100%" cellspacing="0" cellpadding="0" border="0" class="contactus">
				<tr>
					<td colspan="2">
						<h1 style="float:left; font-size:16px; width:200px; text-indent:20px;">Write an inquiry</h1>
						<%-- <div style="float:right; margin-right:10px;" id="pdiLiveChat"><img src="${resPath}/images/icon/staffonline.gif" /></div>--%>
					</td>
				</tr>
				<tr>
					<th width="30%">
						<span class="cRed">*</span> Full Name :
					</th>
					<td>
						<input type="text" class="box-input" name="fullName" id="fullName" size="35"/>
					</td>
				</tr>
				<tr>
					<th>
						<span class="cRed">*</span> Email :
					</th>
					<td>
						<input type="text" class="box-input" name="email" id="email" size="35"/>
					</td>
				</tr>
				<tr>
					<th>
						<span class="cRed">*</span> Phone Number :
					</th>
					<td>
						<input type="text" class="box-input" name="phoneNumber" id="phoneNumber" size="35"/>
					</td>
				</tr>
				<tr>
					<th>
						<span class="cRed">*</span> City :
					</th>
					<td>
						<input type="text" class="box-input" name="city" id="city" size="35"/>
					</td>
				</tr>
				<tr>
					<th>
						<span class="cRed">*</span> Country :
					</th>
					<td>
						<input type="text" class="box-input" name="country" id="country" size="35"/>
					</td>
				</tr>
				<%-- 
				<tr>
					<th>
						Order No. :
					</th>
					<td>
						<input type="text" class="box-input" name="orderNo" id="orderNo" size="35"/>
					</td>
				</tr>
				--%>
				<tr>
					<th>
						Subject :
					</th>
					<td>
						<input type="text" class="box-input" name="subject" id="subject" size="35"/>
					</td>
				</tr>
				<tr>
					<th valign="top">
						Comments :
					</th>
					<td>
						<textarea name="comments" rows="7" cols="40" class="box-input" id="comments"></textarea>
					</td>
				</tr>
				<tr>
					<th valign="top">
						verification code:
					</th>
					<td>
						<input type="text" autocomplete="off" name="validationCode" id="validationCode" 
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
	<script type="text/javascript" defer="defer">
	$("#inquiryForm").validate({rules:{
			fullName:{required:true,minlength:4},
			email:{required:true,email:true},
			phoneNumber:{required:true,number:true, rangelength:[6,15]},
			city:{required:true,minlength:3},
			country:{required:true,minlength:3},
			subject:{required:true,minlength:10},
			comments:{required:true,minlength:20}
		},
	messages:{
			email:{
				required:"Sorry,fullName is required.",
				email:'Are you sure your Email address is correct? E-mail addresses must contain an "at" sign (@) and a period (.) somewhere to the right of the @, with no spaces or commas. (Example: yourname@gmail.com)'
			},
			email:{
				required:"Sorry, a valid email address is required.",
				email:'Are you sure your Email address is correct? E-mail addresses must contain an "at" sign (@) and a period (.) somewhere to the right of the @, with no spaces or commas. (Example: yourname@gmail.com)'
				},
			phoneNumber:{
					required:"Sorry, a phoneNumber is required.",
					number:"Please enter your phone number (between 6 and 15 characters).",
					rangelength:"Please enter your phone number (between 6 and 15 characters).",
				},
				city:{
				required:"Sorry, a city is required.",
				minlength:"Your city must contain a minimum of 3 characters."
			},country:{
					required:"Sorry, a country is required.",
					minlength:"Your country must contain a minimum of 3 characters."
				},subject:{
					required:"Sorry, a subject is required.",
					minlength:"Your subject must contain a minimum of 10 characters."
				},comments:{
					required:"Sorry, a subject is required.",
					minlength:"Your subject must contain a minimum of 20 characters."
				}
		},submitHandler: function(form) {
				var params=$(form).serialize();
				params=params+"&productLinkUrl="+$("#productLinkUrl").val();
				$.post("${ctxPath}/contactUsForm.html",params,function(data){
					if(data.info=='ok'){
						closeSimpleDialog('Inquiry');
						dlgInquiry_r=new Date().getTime();
						alert("Your inquiry was successfully submitted and will be answered within 24 hours.Thank you for visiting ${appConfig.store.name}");
					}else{
						alert("Your validate number information is false.");
					}
				},"json");
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
		image.src = "${ctxPath}/validateCode.html?rand="+ parseInt(1000 * Math.random());
		return false;
	}
	$("#pdiLiveChat").html($("#pdLiveChat").html());
	$("#inquiryForm").find("#subject").val("[INQUIRY] "+$("#productName").val());
</script>
</body>
</html>
