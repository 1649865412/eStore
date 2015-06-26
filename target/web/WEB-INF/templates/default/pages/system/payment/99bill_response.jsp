<%@ page pageEncoding="UTF-8" import="com.cartmatic.estore.system.util.TranslateService,
		com.cartmatic.estore.system.util.PaymentUtil,
		com.cartmatic.estore.system.payment.bill99.VerifySignature,
		org.springframework.web.context.WebApplicationContext,
		org.springframework.web.context.support.WebApplicationContextUtils"
		errorPage="/error.jsp"
%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.apache.commons.logging.Log"%>
<%@page import="org.apache.commons.logging.LogFactory"%>
<%!private final static transient Log logger = LogFactory.getLog("com.cartmatic.estore.system.payment.bill99.99bill_response_jsp");%>
<%
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	String dealId=request.getParameter("dealId");
	String orderNo=request.getParameter("orderId");
	String successFlag=request.getParameter("payResult");
	String pricingAmount=request.getParameter("pricingAmount");
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("99bill");
	request.setAttribute("orderNo",orderNo);
	//verify the string
	String signMsg = "";	
	signMsg += PaymentUtil.getParamStr(signMsg, request, "merchantAcctId");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "termId");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "version");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "language");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "signType");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "payType");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "bankId");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "orderId");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "orderTime");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "pricingCurrency");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "pricingAmount");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "billingCurrency");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "billingAmount");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "exchangeRateFlag");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "exchangeRateDirection");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "exchangeRate");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "dealId");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "bankDealID");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "dealTime");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "payAmount");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "payCurrency");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "fee");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "payResult");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "errCode");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "ext1");
	signMsg += PaymentUtil.getParamStr(signMsg, request, "ext2");
	//PemKeySign pemKeySign=new PemKeySign("conf/99billPemKey.pem",
	//        paymentMethod.getConfigData().get("merchantAcctId").toString(),
	//        paymentMethod.getConfigData().get("merchantAcctPassword").toString());
	//String macSignMsg=pemKeySign.encrypt(signMsg);
	VerifySignature vs=VerifySignature.initVerifySignature();//初始化验签类
	vs.setVpos_cp_cer("conf/99billVpos_cp.cer");  //设置快钱公钥地址
	vs.setData_sign(signMsg);  //设置返回参数串
	vs.setSignature(request.getParameter("signMsg")); //设置返回的加密串
	boolean bill99Verify=vs.verifySign("UTF-8");//得到验签结果
	logger.debug(signMsg);
	logger.debug("bill99Verify:"+bill99Verify);
	if ("10".equals(successFlag) && bill99Verify)
	{
	    successFlag = "1";
	}
	else
	{
	    successFlag ="0";
	    request.setAttribute("errorCode",request.getParameter("errCode"));
	}
	
	request.setAttribute("successFlag",successFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	request.setAttribute("amount",(new BigDecimal(pricingAmount)).divide(new BigDecimal(100)));
%>
<%@include file="./include/inc_common_response.jspf"%>
<result>1</result><redirecturl><%=request.getScheme()+"://"+request.getHeader("host")+request.getContextPath()+"/system/payment/paymentFinish.html"%></redirecturl>