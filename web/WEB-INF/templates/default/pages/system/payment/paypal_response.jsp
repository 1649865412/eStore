<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ page language="java" import="com.cartmatic.estore.system.util.TranslateService,
								com.cartmatic.estore.common.model.order.SalesOrder,
								com.cartmatic.estore.common.service.OrderService,
								org.springframework.web.context.support.WebApplicationContextUtils,
								java.util.*,
								org.springframework.web.context.WebApplicationContext"
	contentType="text/html; charset=UTF-8"
	errorPage="/error.jsp"
%>
	<%
		response.setCharacterEncoding("UTF-8");
		String testModel=null;
		//store the order no in custom parameter when commit payment reuqest
		String orderNo=request.getParameter("custom");
		WebApplicationContext cxt=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
		PaymentMethodManager paymentMethodManager=(PaymentMethodManager)cxt.getBean("paymentMethodManager");
		PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("paypal");
		testModel=paymentMethod.getConfigData().get("testModel").toString();
		
		String host="";

		if(testModel==null||testModel.equals("N")){
			host="https://www.paypal.com:443/cgi-bin/webscr";
		}else{
			host="https://www.sandbox.paypal.com:443/cgi-bin/webscr";
		}
		
		String payment_status=request.getParameter("payment_status");

		String succFlag="0";

		if(payment_status!=null&&payment_status.equalsIgnoreCase("Completed")){
			Map dataMap=request.getParameterMap();
			Map sendData=new HashMap();
			Iterator i=dataMap.entrySet().iterator();
			while(i.hasNext()){
				Map.Entry en=(Map.Entry)i.next();
				sendData.put(en.getKey(),((String[])en.getValue())[0]);
			}			

			sendData.put("cmd","_notify-validate");
			
			String responseText=TranslateService.getResponseFromHttpsUrl(host,sendData);

			if(responseText.trim().equalsIgnoreCase("VERIFIED"))
			
			{//the data come from paypal
				succFlag="1";
				OrderService orderService = (OrderService)cxt.getBean("orderService");
				request.setAttribute("salesOrder",orderService.getSalesOrderByOrderNo(orderNo));
			}//else if(responseText.trim().equalsIgnoreCase("INVALID")){//Declined (invalid request)//}
		}else if("Pending".equals(payment_status)){//Queued
			succFlag="-1";
		}
  	request.setAttribute("amount",request.getParameter("mc_gross"));
	request.setAttribute("orderNo",orderNo);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
%>
<%@include file="include/finishPayResult.jspf"%>
<%@include file="include/inc_common_response.jspf"%>
<%--注意前台下单只有一个运输项,因此只取第一个运输项的数据，注意数字产品调整--%>
<c:if test="${appConfig.isTrackOrder and not empty salesOrder}">
		<cartmatic:collectionToList var="orderShipmentList" itmes="${salesOrder.orderShipments}"></cartmatic:collectionToList>
		<c:set var="ga_trackeer" scope="request">
		<%--Order ID,Affiliation,Total,Tax,Shipping,City,State,Country--%>
		_gaq.push(['_addTrans',"${salesOrder.orderNo}", "${salesOrder.customerTitle}${emptySpace}${salesOrder.customerFirstname}",  "${orderShipmentList[0].total}",  "0", "${orderShipmentList[0].shippingCost}", "${orderShipmentList[0].orderAddress.city}", "${orderShipmentList[0].orderAddress.state}", "${orderShipmentList[0].orderAddress.country}"]);
		<c:forEach items="${orderShipmentList[0].orderSkus}" var="os_item" >
		<%-- Order ID,SKU,Product Name,Category,Price,Quantity, --%>
		 _gaq.push(['_addItem', "${salesOrder.orderNo}","${os_item.productSkuCode}","${os_item.productName}","N/A","${empty os_item.discountPrice?os_item.price:os_item.discountPrice}","${os_item.quantity}"]);
		</c:forEach>
		_gaq.push(['_trackTrans']);			
		</c:set>
</c:if>