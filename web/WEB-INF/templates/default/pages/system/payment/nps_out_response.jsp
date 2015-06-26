<%@page import="java.util.*,com.eitop.platform.tools.encrypt.*"
	contentType="text/html; charset=UTF-8" 
	errorPage="/error.jsp"
%>
<jsp:directive.page import="org.springframework.web.context.support.WebApplicationContextUtils"/>
<jsp:directive.page import="org.springframework.web.context.WebApplicationContext"/>
<jsp:directive.page import="com.eitop.platform.tools.Charset"/>
<%
	
	//com.cartmatic.estore.system.util.PaymentUtil.writeReceiveDataToFile(request,"d:\\common.txt");
	
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("nps_out");
	
	String key=paymentMethod.getConfigData().get("Mer_Key").toString();
	
	//get the data from nps;
	//String orderInfo= Charset.ISO8859_2_Gb(request.getParameter("OrderMessage"));
	String orderInfo= ISO8859_2_UTF8(request.getParameter("OrderMessage")); 
	String orderDigest=request.getParameter("Digest");
	
	String digest = MD5Digest.encrypt(orderInfo+key);
	
	//success flag
	String succFlag="0";
	String errorMessage="";
	String orderNo="";
	if(digest.equals(orderDigest)){
		orderInfo = xStrEncrypt.StrDecrypt(orderInfo, key);
		//System.out.println("Kson Test OrderInfo="+orderInfo);

		String array[];
		StringTokenizer OrderInfos = new StringTokenizer(orderInfo,"|");
		array	=	new String[OrderInfos.countTokens()];
		int i	=	0;
		while(OrderInfos.hasMoreTokens()){
			array[i]=OrderInfos.nextToken();
			i++;	
		}
			
		String m_id		=	array[0];
		String m_orderid	=	array[1];	
		String m_oamount	=	array[2];	
		String m_ocurrency	=	array[3];	
		String m_url		=	array[4];	
		String m_language	=	array[5];	
		String s_name		=	array[6];	
		String s_addr		=	array[7];	
		String s_postcode	=	array[8];	
		String s_tel		=	array[9];	
		String s_eml		=	array[10];	
		String r_name		=	array[11];	
		String r_addr		=	array[12];	
		String r_postcode	=	array[13];	
		String r_tel		=	array[14];	
		String r_eml		=	array[15];	
		String m_ocomment	=	array[16];
        String modate       =   array[17];	
		String Status		=	array[18];	//payment status ==> 2:success,3:failure
		
		orderNo=m_orderid;
		if (Status.equals("2")){//success
			succFlag="1";
		}
		request.setAttribute("amount",m_oamount);
		request.setAttribute("modate",modate);
	}else{
		errorMessage="transaction has failture, maybe the order information has modified by others.";
	}
	request.setAttribute("orderNo",orderNo);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("errorMessage",errorMessage);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	
%>

<%!
public String ISO8859_2_UTF8(String str)
{
    if(str == null)
        return "";
    try
    {
        str = new String(str.getBytes("iso-8859-1"), "UTF-8");
        return str;
    }
    catch(Exception ex)
    {
        ex.printStackTrace();
    }
    return null;
}
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>