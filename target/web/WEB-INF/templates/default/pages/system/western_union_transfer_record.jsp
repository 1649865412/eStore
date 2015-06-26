
<%@page import="com.opensymphony.module.sitemesh.RequestConstants"%><%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
<script type="text/javascript"	src="${ctxPath}/scripts/cartmatic/common/region.js"></script>
<title>World Telecommunication Day</title>
<%
request.setAttribute(RequestConstants.DECORATOR,"checkout");
%>
<div class="box-western">
	<form id="remitInfoForm" action="${ctxPath}/checkout/transferRecord.html" method="post">
	<h5>
		Western Union
	</h5>
	&nbsp;&nbsp;&nbsp;<span class="red">*</span>Indicates required fields
	<table width="90%" cellspacing="0" cellpadding="0" border="0" align="center" class="table-western">
		<tbody>
			<tr>
				<th width="40%">
					Money Transfer Control No.
					<span class="red">*</span>
				</th>
				<td>
					<div>
						<spring:bind path="transferRecord.mtcnNo">
							<input type="text" onkeyup="value=value.replace(/[^\d]/g,'');" class="box-input" maxlength="10" id="${status.expression}" name="${status.expression}" value="${status.value}">
						</spring:bind>
					</div>
					WESTERN UNION CONTROL NUMBER-MTCN: must be 10 digits;
				</td>
			</tr>
			<tr>
				<th width="40%">
					Amount
					<span class="red">*</span>
				</th>
				<td>
					<spring:bind path="transferRecord.amount">
						<input type="text"  class="box-input" maxlength="10" id="${status.expression}" name="${status.expression}" value="${status.value}">
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>
					Sender’s First Name:
					<span class="red">*</span>
				</th>
				<td>
					<spring:bind path="transferRecord.firstname">
						<input type="text" maxlength="32" id="${status.expression}" name="${status.expression}" value="${status.value}" class="box-input">
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>
					Middle Name:
				</th>
				<td>
					<spring:bind path="transferRecord.middlename">
						<input type="text" maxlength="32" id="${status.expression}" name="${status.expression}" value="${status.value}" class="box-input">
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>
					Last Name:
					<span class="red">*</span>
				</th>
				<td>
					<div>
						<spring:bind path="transferRecord.lastname">
							<input type="text"  maxlength="32" id="${status.expression}" name="${status.expression}" value="${status.value}" class="box-input">
						</spring:bind>
					</div>
					Please enter your FULL NAME exactly as stated on the WesternUnion depositing paper
				</td>
			</tr>

			<tr>
				<th>
					Sender's Address
					<span class="red">*</span>
				</th>
				<td>
					<div>
						<spring:bind path="transferRecord.address">
							<input type="text" maxlength="64" class="box-input" id="${status.expression}" name="${status.expression}" value="${status.value}" style="width: 381px">
						</spring:bind>
					</div>
					Please fill in the address accordingly and in detail; default address for all refunds.
				</td>
			</tr>
			<tr>
				<th>
					City:
					<span class="red">*</span>
				</th>
				<td>
					<spring:bind path="transferRecord.city">
						<input type="text" id="city" maxlength="32" class="box-input" id="${status.expression}" name="${status.expression}" value="${status.value}" style="width: 381px">
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>
					Country/Region:
					<span class="red">*</span>
				</th>
				<td>
					<select name="countryId" id="countryId" class="box-input" onchange="stateSelector(this.value,'stateId');" style="width: 381px">
					</select>
					<input type="hidden" name="country" id="country" >
				</td>
			</tr>
			<tr>
				<th>
					State/Province/Region:
					<span class="red">*</span>
				</th>
				<td>
					<select name="stateId" id="stateId" class="box-input" style="width: 381px">
					</select>
					<input type="hidden" name="state" id="state" >
				</td>
			</tr>
			<tr id="tax_code_block">
				<th>
					CPF Code:
				</th>
				<td>
					<spring:bind path="transferRecord.taxCode">
						<input type="text" id="taxCode" maxlength="11" id="${status.expression}" name="${status.expression}" value="${status.value}" class="box-input">
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>
					ZIP/Postal Code:
					<span class="red">*</span>
				</th>
				<td>
					<spring:bind path="transferRecord.zip">
						<input type="text" maxlength="10" class="box-input" id="${status.expression}" name="${status.expression}" value="${status.value}">
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>
					Sender’s Phone Number:
					<span class="red">*</span>
				</th>
				<td>
					<div>
						<spring:bind path="transferRecord.phone">
							<input type="text" class="box-input" maxlength="45" id="${status.expression}" name="${status.expression}" value="${status.value}">
						</spring:bind>
					</div>
					Must be a valid telephone number, at which we can reach you if necessary
				</td>
			</tr>
			<tr>
				<th>
					Test Question:
				</th>
				<td>
					<div style="width: 120px;">
						<spring:bind path="transferRecord.question">
							<input type="text" class="box-input" maxlength="40" id="${status.expression}" name="${status.expression}" value="${status.value}">
						</spring:bind>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					Test Answer:
				</th>
				<td>
					<div style="width: 120px;">
						<spring:bind path="transferRecord.answer">
							<input type="text" class="box-input" maxlength="40" id="${status.expression}" name="${status.expression}" value="${status.value}">
						</spring:bind>
					</div>
					<div class="clear">
						Some countries require an authentication question, if you reside in a country which requires such verification, please remember to fill in accordingly
					</div>
				</td>
			</tr>
			<tr>
				<td align="center"colspan="2">
					<c:if test="${!updateSuccess}">
					<input type="image" class="bt_login" title=" send " alt="send" src="${resPath}/images/btn/btn_send.gif">
					</c:if>
				</td>
			</tr>
			<tr>
				<td align="right" colspan="2">
					<div class="blank10"></div>
					<span class="red">*</span>The client is responsible for the local Western Union handling fees and Intermediary bank handling fees. Please contact you local bank for more information.
				</td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="orderNo"  value="${param.orderNo}">
	<input type="hidden" name="doAction"  value="saveWUTransferRecord">
	</form>
</div>
<c:set var="countryId" value="${empty param.countryId?0:param.countryId}"/>
<c:set var="stateId" value="${empty param.stateId?0:param.stateId}"/>
<script type="text/javascript">
    //以下代码自动根据用户的运输地址加载国、市、区下拉框
    countrySelector("countryId","${countryId}");
	<c:if test="${not empty stateId}">
	stateSelector("${countryId}","stateId","${stateId}");
	</c:if>
</script>
<script type="text/javascript">
$.validator.setDefaults({focusout:true});
$.validator.addMethod("tel", function(value) {return /(^[0-9+-]{3,30}$)/.test(value);},"Is your Phone Number correct? Sorry, my system does not understand your telephone format.");
$.validator.addMethod("amount", function(value) {return /^\d+(\.\d{0,2})?$/.test(value);},"Is your Amount correct? Sorry, my system does not understand your amount format.");
$("#remitInfoForm").validate({event:blur,
	rules:{
		mtcnNo:{required:true,minlength:10},
		amount:{required:true,amount:true},
		firstname:{required:true,minlength:2},
		lastname:{required:true,minlength:2},
		address:{required:true,minlength:5},
		countryId:{required:true},
		stateId:{required:true},
		cityName:{required:true},
		zip:{required:true,minlength:4},
		phone:{required:true,minlength:5,tel:true}
	},
	errorPlacement: function(error, element) {
			if(element.parent().children(":input").length>1){
				error.appendTo(element.parent());
			}else{
				error.insertAfter(element);
			}
		},
messages:{
		mtcnNo:{
			required:"Sorry, Money Transfer Control No. is required.",
			minlength:"Your Money Transfer Control No. must contain a minimum of 10 characters."
			},	
		amount:{
			required:"Sorry, Money Transfer Amount is required.",
			amount:"Your Money Transfer Amount format must be xxxx.xx."
			},
		firstname:{
			required:"Sorry, Sender’s First Name is required.",
			minlength:"Your First name must contain a minimum of 2 characters."
			},
		lastname:{
				required:"Sorry, Last name is required.",
				minlength:"Your Last Name must contain a minimum of 2 characters."
			},
		address:{
			required:"Sorry, Sender's Address is required.",
			minlength:"Your Sender's Address must contain a minimum of 5 characters."
		},
		countryId:{
			required:'Please choose "Country".'
		},
		stateId:{
			required:'Please choose "State".'
		},
		cityName:{
			required:'Sorry, City is required.'
		},
		zip:{
			required:"Sorry, ZIP/Postal Code is required.",
			minlength:"Your ZIP/Postal Code must contain a minimum of 4 characters."
		},
		phone:{
			required:"Sorry, Phone Number is required.",
			minlength:"Your Phone Number must contain a minimum of 4 characters."
		}
	}
});
</script>