<%@ page pageEncoding="UTF-8" errorPage="/error.jsp"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder,
com.cartmatic.estore.common.model.system.Store,
com.cartmatic.estore.common.helper.ConfigUtil,
com.cartmatic.estore.common.model.system.PaymentMethod,
java.text.DecimalFormat,
java.text.SimpleDateFormat"%>
<%@ page import="com.alipay.config.*"%>
<%@ page import="com.alipay.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%!private final static transient org.apache.commons.logging.Log logger = org.apache.commons.logging.LogFactory.getLog("alipay_response");%>
<%
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("alipay");

	//检查该数据是否为支付网关的通知数据。
	String succFlag="0";
	AlipayConfig.key = paymentMethod.getConfigData().get("key").toString();
	AlipayConfig.partner = paymentMethod.getConfigData().get("partnerId").toString();
	//获取支付宝GET过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map requestParams = request.getParameterMap();
	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
			valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
		//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		params.put(name, valueStr);
	}
	
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	//商户订单号
	String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

	//支付宝交易号
	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
	String amount = request.getParameter("total_fee");
	
	//交易状态
	String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
	
	//计算得出通知验证结果
	boolean verify_result = AlipayNotify.verify(params);
	
	if(verify_result){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码
		
		//该页面可做页面美工编辑
		succFlag="1";
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{
		//该页面可做页面美工编辑
		succFlag="0";
	}
	//logger.error("key:"+AlipayConfig.key+" partner:"+AlipayConfig.partner+" params:"+params+" verify_result:"+verify_result+" succFlag:"+succFlag);
	String msg="";
			if("WAIT_BUYER_PAY".equals(trade_status)){
				msg="等待买家付款";
				succFlag="-1";
			}else if("WAIT_SELLER_CONFIRM_TRADE".equals(trade_status)){
				msg="交易已创建，等待卖家确认";
				succFlag="-1";
			}else if("WAIT_SYS_CONFIRM_PAY".equals(trade_status)){
				msg="确认买家付款中，暂勿发货";
				succFlag="-1";
			}else if("WAIT_SELLER_SEND_GOODS".equals(trade_status)){
				msg="支付宝收到买家付款，请卖家发货";
			}else if("WAIT_BUYER_CONFIRM_GOODS".equals(trade_status)){
				msg="卖家已发货，买家确认中";
				succFlag="-1";
			}else if("WAIT_SYS_PAY_SELLER".equals(trade_status)){
				msg="买家确认收到货，等待支付宝打款给卖家";
				succFlag="-1";
			}else if("TRADE_FINISHED".equals(trade_status)){
				msg="交易成功结束";
				succFlag="-1";
			}else if("TRADE_CLOSED".equals(trade_status)){
				msg="交易中途关闭（未完成）";
				succFlag="0";
			}
			
			if(!"".equals(msg)){
				request.setAttribute("errorMessage",msg);
			}
	//logger.error("succFlag:"+succFlag);
	request.setAttribute("amount",amount);
	request.setAttribute("orderNo",out_trade_no);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
 %>

<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>
