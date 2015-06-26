<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.cartmatic.estore.common.model.order.SalesOrder,
com.cartmatic.estore.common.model.system.Store,
com.cartmatic.estore.common.helper.ConfigUtil,
com.cartmatic.estore.common.model.system.PaymentMethod,
java.text.DecimalFormat,
java.text.SimpleDateFormat,
com.hitrust.trustpay.client.b2c.*" %>
<%@ page import = "com.hitrust.trustpay.client.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% response.setHeader("Cache-Control", "no-cache"); %>

	<%
		//1、取得支付请求所需要的信息
		Store store = ConfigUtil.getInstance().getStore();
		SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
		PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
		
		String tOrderNo         = salesOrder.getOrderNo();									//订单编号
		String tExpiredDate     =  "3";																    //订单有效期（天数）
		
		//String tOrderDesc       = request.getParameter("OrderDesc"      );			//订单说明
		
		SimpleDateFormat sdfD = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat sdfT = new SimpleDateFormat("HH:mm:ss");
		String tOrderDate       = sdfD.format(salesOrder.getCreateTime());			//订单日期
		String tOrderTime       = sdfT.format(salesOrder.getCreateTime());			//订单时间
		
		DecimalFormat df=new java.text.DecimalFormat("0.00");
		String tOrderAmountStr  = df.format(salesOrder.getShouldPay());	//订单金额
		
		String tOrderURL        = store.getSiteUrl()+"/myaccount/order/list.html";			//订单查询网址
		//String tProductType     = request.getParameter("ProductType"    );		//商品类别
		
		String tPaymentType     = "1";	//支付类型 1为农行卡，2为国际卡，3未贷记卡，4为农行卡和国际卡合并，5为跨行
		String tNotifyType      = "0";			//支付结果通知方式，0页面通知和1服务器通知
		String tResultNotifyURL = store.getSiteUrl()+"/system/payment/abc_response.html";;	//支付结果返回地址
		
		//String tMerchantRemarks = request.getParameter("MerchantRemarks");//商户备注信息
		
		double  tOrderAmount    = Double.parseDouble(tOrderAmountStr);
		
		//String tPaymentLinkType = request.getParameter("PaymentLinkType");//支付接入方式，internet、mobile、数字电视网络
		
		String tBuyIP = salesOrder.getIpAddress();										//买方IP
		
		//2、生成订单对象
		Order tOrder = new Order();
		tOrder.setOrderNo    (tOrderNo    ); //设定订单编号 （必要信息）
		tOrder.setExpiredDate(new Integer(tExpiredDate).intValue()); //设定订单有效期 （必要信息）
		//tOrder.setOrderDesc  (tOrderDesc  ); //设定订单说明
		tOrder.setOrderDate  (tOrderDate  ); //设定订单日期 （必要信息 - YYYY/MM/DD）
		tOrder.setOrderTime  (tOrderTime  ); //设定订单时间 （必要信息 - HH:MM:SS）
		tOrder.setOrderAmount(tOrderAmount); //设定订单金额 （必要信息）
		tOrder.setOrderURL   (tOrderURL   ); //设定订单网址
		tOrder.setBuyIP   (tBuyIP   ); //设定订单IP
		
		//3、生成定单订单对象，并将订单明细加入定单中（可选信息）
		//tOrder.addOrderItem(new OrderItem("IP000001", "中国移动IP卡", 100.00f, 1));
		//tOrder.addOrderItem(new OrderItem("IP000002", "网通IP卡"    ,  90.00f, 2));
		
		//4、生成支付请求对象
		PaymentRequest tPaymentRequest = new PaymentRequest();
		tPaymentRequest.setOrder      (tOrder      ); //设定支付请求的订单 （必要信息）
		
		tPaymentRequest.setProductType(PaymentRequest.PRD_TYPE_TWO); //设定商品种类 （必要信息）
		                                              //PaymentRequest.PRD_TYPE_ONE：非实体商品，如服务、IP卡、下载MP3、...
		                                              //PaymentRequest.PRD_TYPE_TWO：实体商品
		                                              
		tPaymentRequest.setPaymentType(PaymentRequest.PAY_TYPE_ABC); //设定支付类型
		                                              //PaymentRequest.PAY_TYPE_ABC：农行卡支付
		                                              //PaymentRequest.PAY_TYPE_INT：国际卡支付
		                                              
		tPaymentRequest.setNotifyType("1");   //设定商户通知方式
		                                              //0：URL页面通知 , 弹出窗口可能会被拦截
		                                              //1：服务器通知
		tPaymentRequest.setResultNotifyURL(tResultNotifyURL); //设定支付结果回传网址 （必要信息）
		
		//tPaymentRequest.setMerchantRemarks(tMerchantRemarks); //设定商户备注信息
		
		//tPaymentRequest.setPaymentLinkType(tPaymentLinkType);//设定支付接入方式
		
		//5、传送支付请求并取得支付网址
		//TrxResponse tTrxResponse = tPaymentRequest.postRequest();
		TrxResponse tTrxResponse = tPaymentRequest.extendPostRequest(1);
		if (tTrxResponse.isSuccess()) {
		   //6、支付请求提交成功，将客户端导向支付页面
		   System.out.println("PaymentURL-->"+tTrxResponse.getValue("PaymentURL"));
		   response.sendRedirect(tTrxResponse.getValue("PaymentURL"));
		}
		else {
		   //7、支付请求提交失败，商户自定后续动作
		%>
<HTML>
		<HEAD><TITLE>农行网上支付平台-支付请求</TITLE></HEAD>
		
		<BODY>
		
		<%@ include file="./include/inc_common_request_js.jspf" %>
		
		<CENTER>
		<br/><br/>
		<%
		  //out.println("ReturnCode   = [" + tTrxResponse.getReturnCode  () + "]<br>");
		  out.println("支付请求失败：" + tTrxResponse.getErrorMessage() + "；");
		}
		%>
		<a href='${ctxPath}'>回商户首页</a>
		
		</CENTER>
	
	<%@ include file="./include/payOrderTips.jspf" %>
	
	</BODY>
	
</HTML>