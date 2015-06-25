<%@page import="com.opensymphony.module.sitemesh.RequestConstants"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>Text Messege</title>
<style type="text/css">
html{background:#eee}body{margin:17px 0 15px 0;padding:0;text-align:center;font-size:12px; font-family:Verdana, Geneva, sans-serif;}.container{text-align:left;background:#fff;border:1px solid #ccc;-webkit-box-shadow:rgba(0,0,0,0.2) 0px 0px 5px;-moz-box-shadow:rgba(0,0,0,0.2) 0px 0px 5px;-o-box-shadow:rgba(0,0,0,0.2) 0px 0px 5px;box-shadow:rgba(0,0,0,0.2) 0px 0px 5px;margin:0 auto 10px auto;width:640px; overflow:hidden;line-height:180%;}label.desc{font-size:95%;font-weight:bold;color:#222;line-height:150%;margin:0;padding:0 0 3px 0;border:none;display:block;white-space:normal;width:100%}input.text{border-top:1px solid #7c7c7c;border-left:1px solid #c3c3c3;border-right:1px solid #c3c3c3;border-bottom:1px solid #ddd; background-color:#fff; height:20px;}.left{ float:left;}.symbol{ float:left; margin:0 4px;}.title{ height:40px; width:100%; float:left; background-color:#DEDEDE;}.content{ float:left;padding:20px;}
.info { border-bottom: 1px dotted #CCCCCC;clear: both;display: inline-block;margin: 0 0 5px;padding: 0 1% 1.1em;}input,label{ display:block;}.blank6{ height:6px; width:100%; float:left; overflow:hidden; clear:both;}
.red,.cRed {
	color:#C20000
}
</style>
<script type="text/javascript" src="${pageContext.request.scheme}://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js" ></script>
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
</head>
<%
request.setAttribute(RequestConstants.DECORATOR,"nothing");
%>
<body>
	<c:choose>
		<c:when test="${param.info!='Success'}">
			 <div class="container">
		    	<div class="title"><img src="http://www.eluxuryoutlets.com/resources/images/email/el.jpg"></div>
		        <div class="content">
		        	<form id="textMessegeForm" method="Post">
		            	<div class="info">We apologize for the disturb using text messages, please enter your phone NO. to unsubscribe and stop receiving messages from us:<br>
		              	Your phone NO: XXXXX<br/>Email:xxx@xx.com</div>
		                  <label for="Field1"  class="desc">
		                	Phone Number
		                </label>
		                <div class="left">
		                    <input type="tel" name="tel1" id="tel1" tabindex="1" maxlength="3" size="3" value="" class="text"  >
		                    <label for="Field1">###</label>
		                </div>
		                <div class="symbol">-</div>
		                <div class="left">
		                    <input type="tel" name="tel2" id="tel2" tabindex="2" maxlength="3" size="3" value="" class="text" >
		                    <label for="Field1-1">###</label>
		                </div>
		                <div class="symbol">-</div>
		                <div class="left">
		                 <input type="tel" name="tel3" id="tel3" tabindex="3" maxlength="4" size="4" value="" class="text" >
		                <label for="Field1-2">####</label>
		                </div>
		                <span id="telMsg"></span>
		              <div class="blank6"></div>
		              <div class="left">
		                 	<label for="Field1"  class="desc">
		                    Email
		                 </label>
		                <input type="tel" name="email" id="email" tabindex="1"  size="20" value="" class="text"  >
		              </div>
		              <div class="blank10"></div>
		  				<div style="width:100%; float:left; margin:10px 0;"><input type="submit"  value="Submit" style="background-color:#000; height:26px; line-height:26px; color:#fff;border:0; cursor:pointer;" tabindex="31"></div>
		          </form>
		        </div>
		    </div>
		</c:when>
		<c:otherwise>
			<div class="container">
		    	<div class="title"><img src="http://www.eluxuryoutlets.com/resources/images/email/el.jpg"></div>
		        <div class="content">
		        	<br />
					<br />
					Thank you for your message and one of our customer service representatives will get back to you within the next 12 hours. 
					<br />
					<br />
					If you have any further inquiry, please email us directly at <a href="mailto:sales@handbagsmama.com">sales@handbagsmama.com</a>. Thanks again for shopping at eLuxury.cm!
					<br />
					<br />
					<br />
		        </div>
		    </div>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript">
	$("#textMessegeForm").validate({rules:{
			email:{required:true,email:true},
			tel1:{required:true,number:true, rangelength:[3,3]},
			tel2:{required:true,number:true, rangelength:[3,3]},
			tel3:{required:true,number:true, rangelength:[4,4]}
		},
	errorPlacement: function(error, element) {
			if(element.attr("name").indexOf("tel")!=-1){
				$("#telMsg").append(error);
			}else{
				error.insertAfter(element)
			}
		},
	messages:{
			email:{
				required:"Sorry,email address is required.",
				email:'Are you sure your Email address is correct? E-mail addresses must contain an "at" sign (@) and a period (.) somewhere to the right of the @, with no spaces or commas. (Example: yourname@eLuxury.cm)'
			},
			tel1:{
					required:"Sorry, a Phone Number is required.",
					number:"Please enter your phone number (10 characters).",
					rangelength:"Please enter your phone number (15 characters)..",
				},
				tel2:{
					required:"Sorry, a Phone Number is required.",
					number:"Please enter your phone number (10 characters).",
					rangelength:"Please enter your phone (10 characters).",
				},
				tel3:{
					required:"Sorry, a Phone Number is required.",
					number:"Please enter your phone (10 characters).",
					rangelength:"Please enter your phone number (10 characters).",
				}
		}
	});
</script>
</body>
</html>