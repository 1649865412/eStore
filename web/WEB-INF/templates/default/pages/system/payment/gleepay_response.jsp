<%@page import="com.cartmatic.estore.common.service.OrderService"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder"%>
<%@ include file="/common/taglibs.jsp"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="com.cartmatic.estore.system.util.TranslateService"%>
<%@page import="com.cartmatic.estore.system.service.PaymentMethodManager"%>
<%@page import="com.cartmatic.estore.system.util.PaymentUtil"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.apache.commons.logging.Log"%>
<%
WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	//OrderService orderService=(OrderService)webAppContext.getBean("orderService");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("gleepay");
	String signkey = (String)paymentMethod.getConfigData().get("signkey");//"12345678"测试用
    //字符编码
    request.setCharacterEncoding("UTF-8");
    String succFlag="0";
    String merNo = request.getParameter("merNo");
   	String gatewayNo = request.getParameter("gatewayNo");
   	String tradeNo = request.getParameter("tradeNo");
   	String orderNo = request.getParameter("orderNo");
   	String orderCurrency = request.getParameter("orderCurrency");
    String orderAmount = request.getParameter("orderAmount");
    String orderStatus = request.getParameter("orderStatus");
    String signInfo = request.getParameter("signInfo");
    String orderInfo = request.getParameter("orderInfo");
    
    //SalesOrder salesOrder=orderService.getSalesOrderByOrderNo(orderNo);
    
    if (merNo != null && gatewayNo != null && signInfo != null)
    {
    	String massage = merNo + gatewayNo + tradeNo + orderNo + orderCurrency + orderAmount + orderStatus + orderInfo + signkey;
    	String shastr = TranslateService.sha256Encode(massage);
		if(shastr.equalsIgnoreCase(signInfo)){
			if(orderStatus.equals("1")){
				succFlag="1";
			}else if(orderStatus.equals("-1")||orderStatus.equals("-2")){
				succFlag="-1";
			}
		}
    }
	
	request.setAttribute("orderNo",orderNo);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	request.setAttribute("amount",orderAmount);
	request.setAttribute("errorMessage",request.getParameter("orderInfo"));
	//request.setAttribute("salesOrder",salesOrder);
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>
