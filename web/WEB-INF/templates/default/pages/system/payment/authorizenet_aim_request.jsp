<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@page import="java.net.URL"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="javax.net.ssl.HttpsURLConnection"%>
<%@page import="java.net.URLConnection"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder"%>
<%@page import="com.cartmatic.estore.system.model.AppUser"%>
<%@page import="com.cartmatic.estore.common.model.customer.Address"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.common.model.system.AppUser"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Connet To Authorize.Net Payment Gateway</title>
		<style>
		.table-content-front {
			line-height: 20px;
			border-collapse: collapse;
			margin: 0 auto;
		}
		
		.table-content-front td {
			border: 1px solid #ccc;
			padding: 5px;
		}
		</style>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
  </head>  
  <body>
  		<%
  		
  		 //读取来自网关的配置数据，该数据可以在后台的相应的网关进行配置
  		 SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
		 PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
    	 //OrderPayment orderPayment=(OrderPayment)request.getAttribute("orderPayment");
    	 AppUser appUser=salesOrder.getCustomer() ;
    	 //Address address=salesOrder.getBillingAddress();
    	 DecimalFormat dcf=new DecimalFormat("0.00");
    	 String testMode=(String)paymentMethod.getConfigData().get("testModel");
    	 
  

    	 
    	 boolean isTest=true;
    	 if("0".equals(testMode)){
    	 	isTest=false;
    	 }
    	 String x_currency_code=(String)paymentMethod.getConfigData().get("x_currency_code");
    	 String x_type=(String)paymentMethod.getConfigData().get("x_type");
  		 
    	
    	 
	      // mandatory name/value pairs for all AIM CC transactions
	      // as well as some "good to have" values
	      String x_login=(String)paymentMethod.getConfigData().get("x_login");
	      String x_tran_key=(String)paymentMethod.getConfigData().get("x_tran_key");
	      String x_md5_hash=(String)paymentMethod.getConfigData().get("x_md5_hash");
	      
	      String x_amount=dcf.format(salesOrder.getShouldPay().doubleValue());
	      
	      
	      if(request.getParameter("cmd")!=null && "true".equals(request.getParameter("cmd"))){
	    	  
	    	  
		      StringBuffer sb = new StringBuffer();
		      sb.append("x_login="+x_login+"&");             // replace with your own
		      sb.append("x_tran_key="+x_tran_key+"&");     // replace with your own
		      sb.append("x_version=3.1&");
		      if(isTest){
		      	sb.append("x_test_request=TRUE&");             // for testing
		      }
		      sb.append("x_method=CC&");
		      sb.append("x_type="+x_type+"&");
		      sb.append("x_amount="+x_amount+"&");
		      sb.append("x_delim_data=TRUE&");
		      sb.append("x_delim_char=|&");
              sb.append("x_relay_response=FALSE&");
		      sb.append("x_currency="+x_currency_code+"&");
		 /*
	      if(address!=null){
			  sb.append("x_first_name=" +request.getParameter("x_first_name")+"&");
		      sb.append("x_last_name="+request.getParameter("x_last_name")+"&");
		      sb.append("x_address="+request.getParameter("x_address")+"&");
		      sb.append("x_company="+request.getParameter("x_company")+"&");
		      sb.append("x_city="+request.getParameter("x_city")+"&");
		      sb.append("x_state="+request.getParameter("x_state")+"&");
		      sb.append("x_zip="+request.getParameter("x_zip")+"&");
		      sb.append("x_country="+request.getParameter("x_country")+"&");
	      }
		 */
	      sb.append("x_cust_id="+appUser.getAppuserId()+"&");
	      
	      // CC information
	      //TODO get from user filled in the form
	      if(request.getParameter("x_card_num")!=null){
	     	 sb.append("x_card_num="+request.getParameter("x_card_num")+"&");
	      }
		  
		  
		  
		  if(request.getParameter("x_first_name")!=null){
	     	 sb.append("x_first_name="+request.getParameter("x_first_name")+"&");
	      }
		  if(request.getParameter("x_last_name")!=null){
	     	 sb.append("x_last_name="+request.getParameter("x_last_name")+"&");
	      }
		   if(request.getParameter("x_zip")!=null){
	     	 sb.append("x_zip="+request.getParameter("x_zip")+"&");
	      }
		  
	      //else{
	    	//  sb.append("x_card_num=4007000000027&");
	      //}
	      if(request.getParameter("x_exp_date")!=null){
	      	sb.append("x_exp_date="+request.getParameter("x_exp_date")+"&");
	      }
	      if(request.getParameter("x_card_code")!=null){
		      	sb.append("x_card_code="+request.getParameter("x_card_code")+"&");
		      }
	      if(request.getParameter("x_address")!=null){
		      	sb.append("x_address="+request.getParameter("x_address")+"&");
		      }
	      //else{
	    	//  sb.append("x_exp_date=0809&");
	      //}
	      if(x_type.equals("CAPTURE_ONLY")) {
	      if(request.getParameter("x_auth_code")!=null){
		      	sb.append("x_auth_code="+request.getParameter("x_auth_code")+"&");
		  }
	      }

	      // not required...but my test account is set up to require it
	      sb.append("x_description=Authorize.Net Payment Gateway&");
		  String line="";
		  
		  
		  try{
			  
			  System.err.println("3333333333333333============");
		      // open secure connection
		      URL url =null;
		      if(isTest){
		       		 url=new URL("https://test.authorize.net/gateway/transact.dll");
		      }else{
		      		 url=new URL("https://secure.authorize.net/gateway/transact.dll");
		      }
		      
		      //HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
		      URLConnection connection = url.openConnection();
		      connection.setDoOutput(true);
		      connection.setUseCaches(false);
		      connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
		      DataOutputStream outWriter = new DataOutputStream( connection.getOutputStream() );
		      outWriter.write(sb.toString().getBytes());
		      outWriter.flush();
		      outWriter.close();
		     BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		     line = in.readLine();
		     in.close();
		     request.setAttribute("receiveData",line);
		     
	     	 // no more data
 		 }catch(Exception ex){
 		 	//连接超时的错误或其他错误
 		 	ex.printStackTrace();
 		 	response.sendRedirect("timeoutError.html");
 		 }
 		 
		
		//---------------------------------------------------------------
		//以下处理返回结果
		//---------------------------------------------------------------
		
	     // ONLY FOR THOSE WHO WANT TO CAPTURE GATEWAY RESPONSE INFORMATION
	     // make the reply readable (be sure to use the x_delim_char for the split operation)
	     Vector ccrep = com.cartmatic.estore.payment.web.AuthorizeNetAIM.split("|",line); 
	     
	   
		
	     String responseCode=(String)ccrep.elementAt(0);
	     String transitionId=(String)ccrep.elementAt(6);
	     //当前支付的用户id
	     String customerId=(String)ccrep.elementAt(12);
	     //MD5 Hash Server
	     String md5HashKey=(String)ccrep.elementAt(37);
	     
	     Boolean isSuccess=Boolean.FALSE;
	     
	     
	     if("1".equals(responseCode)){//同时还需要验证md5key是否正确才可以进行后面的操作  //TODO
	     	//处理结果，如升级会员，订单状态的更新等，然后跳转到成功页面  //TODO
	     	System.err.println("approved the data from payemntGateway============");
	     	String signature = x_md5_hash+x_login+transitionId+x_amount;
	     	String localMD5 = com.cartmatic.estore.system.util.TranslateService.md5Translate(signature).toUpperCase();
	     	if(md5HashKey!=null && md5HashKey.equals(localMD5)){
	     		isSuccess=Boolean.TRUE;
	     	}
	     }else{//出错页,显示出错的原因
	     
		    String respSubcode=(String)ccrep.elementAt(1);	     	
	     	String respReasonCode=(String)ccrep.elementAt(2);
	     	String respReasonText=(String)ccrep.elementAt(3);
	     	String avsCode=(String)ccrep.elementAt(5);
		    String cvvCode=(String)ccrep.elementAt(38);
		    String cavvCode=(String)ccrep.elementAt(39);
			
			HashMap respCode=new HashMap();
			respCode.put("1","Approved");
			respCode.put("2","Declined");
			respCode.put("3","");
			
	    	HashMap avserr = new HashMap();
	        avserr.put("A" , "Address (Street) matches, ZIP does not");
			avserr.put("E" , "AVS error");
			avserr.put("N" , "No Match on Address (Street) or ZIP");
			avserr.put("P" , "AVS not applicable for this transaction");
			avserr.put("R" , "Retry. System unavailable or timed out");
			avserr.put("S" , "Service not supported by issuer");
			avserr.put("U" , "Address information is unavailable");
			avserr.put("W" , "9 digit ZIP matches, Address (Street) does not");
			avserr.put("X" , "Exact AVS Match");
			avserr.put("Y" , "Address (Street) and 5 digit ZIP match");
			avserr.put("Z" , "5 digit ZIP matches, Address (Street) does not");
			
			HashMap cvverr = new HashMap();
			
			cvverr.put("M" , "Match");
			cvverr.put("N" , "No Match");
			cvverr.put("P" , "Not Processed");
			cvverr.put("S" , "Should have been present");
			cvverr.put("U" , "Issuer unable to process request");
			
			HashMap cavverr = new HashMap();
			cavverr.put("0" , "CAVV not validated because erroneous data was submitted");
			cavverr.put("1" , "CAVV failed validation");
			cavverr.put("2" , "CAVV passed validation");
			cavverr.put("3" , "CAVV validation could not be performed; issuer attempt incomplete");
			cavverr.put("4" , "CAVV validation could not be performed; issuer system error");
			cavverr.put("7" , "CAVV attempt - failed validation - issuer available (US issued card/non-US acquirer)");
			cavverr.put("8" , "CAVV attempt - passed validation - issuer available (US issued card/non-US acquirer)");
			cavverr.put("9" , "CAVV attempt - failed validation - issuer unavailable (US issued card/non-US acquirer)");
			cavverr.put("A" , "CAVV attempt - passed validation - issuer unavailable (US issued card/non-US acquirer)");
			cavverr.put("B" , "CAVV passed validation, information only, no liability shift");
		    
		   %>
		   <div class="blank24"></div>
		   <div class="blank24"></div>	
		   	<table cellpadding="0" cellspacing="0" align="center" border="1" class="table-content-front"> 
		   		<tr>
		   			<td>Response Result:</td>
		   			<td>
		   				<%=(String)respCode.get(responseCode) %>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>Response Subcode:</td>
		   			<td>
		   				<%=respSubcode %>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>Response Reason Code:</td>
		   			<td>
		   				<%=respReasonCode %>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>Response Reason Text:</td>
		   			<td>
		   				<%=respReasonText %>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>AVS Result:</td>
		   			<td>
		   				<%=(String)avserr.get(avsCode)%>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>
		   			</td>
		   			<td>
		   				<input type="button" class="button" value="close" />
		   			</td>
		   		</tr>
		   	</table>
		   <% 
		  	request.setAttribute("errorCode",respReasonCode);
	    	request.setAttribute("errorMessage",respReasonText);
	      	}
	    	request.setAttribute("appuserId",appUser.getAppuserId());
	    	request.setAttribute("orderNo",salesOrder.getOrderNo());
	    	request.setAttribute("amount",salesOrder.getTotal().doubleValue());
	    	
	    	String succFlag="";
	    	if (isSuccess){
				succFlag="1";
			}else{
				succFlag="0";
			}
	    	request.setAttribute("successFlag",succFlag);
	   
  		 
  		%>
  			<%@include file="./include/finishPayResult.jspf"%>
  			<%@include file="./include/inc_common_response.jspf" %> 
  			
  		<%} %>
		   <div class="blank24"></div>
		   <div class="blank24"></div>	 		
		<form action="" method="post" id="AuthorizenetForm" name="AuthorizenetForm" onSubmit="return validNullForm();">
			<table cellpadding="0" cellspacing="0" align="center" class="table-content-front"> 
		   		<tr>
		   			<td>Accepted Payment Method:</td>
		   			<td>American Express, Diners Club, Discover, EnRoute, JCB, MasterCard, Visa
		   			</td>
		   		</tr>
		   		
		   		<tr>
		   			<td>Card Number:</td>
		   			<td><input type="text" name="x_card_num" id="x_card_num" maxlength="16" size="20" class="box-input"> (enter number without spaces) *
		   			</td>
		   		</tr>
				
				
				
				
				
		   		<tr>
		   			<td>Expiration Date:</td>
		   			<td><input type="text" name="x_exp_date" id="x_exp_date" maxlength="4" size="6" class="box-input"> (mmyy) *
		   			</td>
		   		</tr>
				<tr>
					<td >
						CVV Code:
					</td>
					<td>
						<input type="text" name="x_card_code" id="x_card_code" maxlength="4"
							size="20" class="box-input">   *
					</td>
				</tr>
				<tr>
		   			<td>First Name:</td>
		   			<td><input type="text" name="x_first_name" id="x_first_name" maxlength="50" size="30" class="box-input"> (enter first name) *
		   			</td>
		   		</tr>
				<tr>
		   			<td>Last Name:</td>
		   			<td><input type="text" name="x_last_name" id="x_last_name" maxlength="50" size="30" class="box-input"> (enter last name) *
		   			</td>
		   		</tr>
                <tr>
		   			<td>Billing address:</td>
		   			<td><input type="text" name="x_address" id="x_address" maxlength="60" size="50" class="box-input">  (enter billing address) *
		   			</td>
		   		</tr>
                <tr>
		   			<td>Zip Code:</td>
		   			<td><input type="text" name="x_zip" id="x_zip" maxlength="20" size="20" class="box-input"> (enter zip code) *
		   			</td>
		   		</tr>
		   		
		   		<tr>
		   			<td>Amount:</td>
		   			<td>
		   				<%=x_amount %>
		   			</td>
		   		</tr>
		   		<% if(x_type.equals("CAPTURE_ONLY")) {%>
		   		<tr>
		   			<td>Authorization Code:</td>
		   			<td>
		   				<input type="text" name="x_auth_code" id="x_auth_code" maxlength="10" size="20" class="box-input">
		   			</td>
		   		</tr>
		   		<%} %>
		   		
		   		<tr>
		   			
		   			<td colspan="2">
		   			<center>
		   				<input name="cmd" id="cmd" value="true" type="hidden"/>
		   				<input name="doAction" id="doAction" value="gotoPaymentGateway"
								type="hidden" />
							<input name="orderNo" id="orderNo"
								value="<%=salesOrder.getOrderNo()%>" type="hidden" />
							<input name="paymentMethodId" id="paymentMethodId"
								value="${paymentMethod.paymentMethodId}" type="hidden" />
		   				<input type="image" name="submits" id="submits" value=""
								src="${resPath}/images/btn/btn_pay.gif">
		   				</center>
		   			</td>
		   		</tr>
		   	</table>
			</form>  	
  		<div class="blank24"></div>	
  		<script type="text/javascript">
  			function validNullForm(){
  			var x_card_num = document.getElementById("x_card_num");
  			var x_exp_date = document.getElementById("x_exp_date");
  			var x_address = document.getElementById("x_address");
            var x_card_code =document.getElementById("x_card_code");
			
			var x_first_name =document.getElementById("x_first_name");
			var x_last_name =document.getElementById("x_last_name");
			var x_zip =document.getElementById("x_zip");
			
            if(x_card_num.value==""){
  				alert("Card Number Is Null");
  				x_card_num.select();
  				return false;
  			}
			
			
			
  			if(x_exp_date.value==""){
  				alert("Expiration Date Is Null");
  				x_exp_date.select();
  				return false;
  			}
			 if(x_card_code.value==""){
  				alert("CVV code Is Null");
  				x_card_code.select();
  				return false;
  			}
			
			if(x_first_name.value==""){
  				alert("First Name Is Null");
  				x_first_name.select();
  				return false;
  			}
			
			if(x_last_name.value==""){
  				alert("Last Name Is Null");
  				x_last_name.select();
  				return false;
  			}
			
			
  			if(x_address.value==""){
  				alert("Billing address Is Null");
  				x_address.select();
  				return false;
  			}
			
			if(x_zip.value==""){
  				alert("Zip Code Is Null");
  				x_zip.select();
  				return false;
  			}
			
           
              <% if(x_type.equals("CAPTURE_ONLY")) {%>
  				var x_auth_code = document.getElementById("x_auth_code");
  				if(x_auth_code.value==""){
  				alert("Authorization Code Is Null");
  				x_auth_code.select();
  				return false;
  			}
  			<%}%>
  			
  			window.document.AuthorizenetForm.submit();
  			}
  		</script>
  		
  		
  </body>
</html>
