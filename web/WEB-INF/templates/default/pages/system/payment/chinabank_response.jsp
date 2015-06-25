<%@ page errorPage="/error.jsp" language="java" contentType="text/html; charset=UTF-8"%>
<%
	response.setCharacterEncoding("gb2312");
	String key = "";						
	//****************************************

	//获取参数
	String v_oid = request.getParameter("v_oid");		// 订单号
	String v_pmode = request.getParameter("v_pmode");		// 支付方式中文说明，如"中行长城信用卡"
   	String v_pstatus = request.getParameter("v_pstatus");	// 支付结果，20支付完成；30支付失败；
   	String v_pstring = request.getParameter("v_pstring");	// 对支付结果的说明，成功时（v_pstatus=20）为"支付成功"，支付失败时（v_pstatus=30）为"支付失败"
	String v_amount = request.getParameter("v_amount");		// 订单实际支付金额
 	String v_moneytype = request.getParameter("v_moneytype");	// 币种
	String v_md5str = request.getParameter("v_md5str");		// MD5校验码
	String remark1 = request.getParameter("remark1");		// 备注1
	String remark2 = request.getParameter("remark2");		// 备注2
	String paymentGatewayId=remark1;
	
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("china_bank");
	if(paymentMethod.getConfigData()!=null){

		if(paymentMethod.getConfigData().get("key")!=null){
			key=paymentMethod.getConfigData().get("key").toString();	
		}
		
		String originalText = v_oid+v_pstatus+v_amount+v_moneytype+key; //拼凑加密串
		String v_md5 = TranslateService.md5Translate(originalText).toUpperCase();
		String succFlag="0";
		if (v_md5str.equals(v_md5)){
		   if ("20".equals(v_pstatus)){ 
				succFlag="1";
			}
		}
		request.setAttribute("orderNo",v_oid);
		request.setAttribute("successFlag",succFlag);
		request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
		request.setAttribute("amount",v_amount);
	}
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>
