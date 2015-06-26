<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.util.*,org.springframework.web.context.support.WebApplicationContextUtils,
			org.springframework.web.context.WebApplicationContext"
			pageEncoding="UTF-8"
			errorPage="/error.jsp"
%>
<% 
    String tid=request.getParameter("tid");//商户唯一交易号 
    String bid=bid=request.getParameter("bid");//商户网站订单号
    String sid=request.getParameter("sid");//  易付通交易成功 流水号
    String prc=request.getParameter("prc");// 支付的金额
    String actionCode=request.getParameter("actionCode");//交易码
    String actionParameter=request.getParameter("actionParameter");//业务代码
    String card=request.getParameter("card");//支付方式
    String success=request.getParameter("success");//成功标志，
    String bankcode=request.getParameter("bankcode");//支付银行代码
    String remark1=request.getParameter("remark1");//备注信息
    String username=request.getParameter("username");//商户网站支付用户
    String md=request.getParameter("md");//32位md5加密数据
    
    PaymentMethod paymentMethod=null;
    String succFlag="0";
    
    if ("true".equals(success)){//支付成功状态！
   		  
		//验证数据是否正确  
		//在xpayconfig.asp里取出key的值
		//接收页面进行数据加密
		
		WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
		PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
		paymentMethod=paymentMethodManager.getPaymentMethodByCode("xpay");
		
		String payKey=paymentMethod.getConfigData().get("payKey").toString();	
		String ymd=com.cartmatic.estore.system.util.TranslateService.md5Translate(payKey+":"+bid+","+sid+","+prc+","+actionCode+","+actionParameter+","+tid+","+card+","+success);
	
	    if(md==ymd){ //验证数据正确
	    	succFlag="1";
	    	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	    }
	}

	request.setAttribute("orderNo",bid);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("amount",prc);
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>
