
package com.cartmatic.estoresf.customer.web.action;

import java.io.Serializable;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Membership;
import com.cartmatic.estore.common.model.order.SalesOrder;
import com.cartmatic.estore.common.model.system.PaymentMethod;
import com.cartmatic.estore.common.service.OrderService;
import com.cartmatic.estore.common.service.PaymentMethodService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.search.SearchCriteria;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.order.OrderConstants;
import com.cartmatic.estore.order.service.SalesOrderManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.SessionUtil;

/**
 * Salse Order Front Page Controller
 *  
 */

@Controller
public class OrderController extends GenericStoreFrontController<SalesOrder> {
    @Autowired
	private SalesOrderManager salesOrderManager;
    @Autowired
    private OrderService orderService;
    @Autowired
    private PaymentMethodService paymentMethodService;
    @Autowired
    private CustomerManager customerManager;
    @Autowired
    private MembershipManager membershipManager;
   

	@Override
	@RequestMapping("/myaccount/account.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
        if (logger.isDebugEnabled()) {
            logger.debug("entering 'OrderController defaultAction' method...");
        }
        return getRedirectView("/myaccount/order/list.html");
    }    
	/**
	 * 订单列表
	 *  /eStore/web/WEB-INF/templates/default/pages/customer/orderList.jsp
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/myaccount/order/list.html")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response) {
        if (logger.isDebugEnabled()) {
            logger.debug("entering 'OrderController list' method...");
        }
        //return a paging list
        List results =queryAndSetAttributes(request);
        ModelAndView mv = new ModelAndView("customer/orderList", "salesOrderList", results);
        Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
        mv.addObject("customer", customer);
        Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
        return mv;
    }
    /**
     * 订单详情
     * /eStore/web/WEB-INF/templates/default/pages/customer/orderReview.jsp
     * get sales order detail
     * @param request
     * @param response
     * @return
     */

	@RequestMapping(value="/myaccount/order/{orderId}.html", method=RequestMethod.GET)
	public ModelAndView viewOrder(@PathVariable Integer orderId,HttpServletRequest request,HttpServletResponse response) {
		if (logger.isDebugEnabled()) {
			logger.debug("entering 'SalesOrderController viewOrderDetail' method...");
		}
		SalesOrder salesOrder = orderService.getSalesOrder(ConfigUtil.getInstance().getStore().getStoreId(),orderId, RequestContext.getCurrentUserId());
		if(salesOrder==null){
			//非法访问
			return new ModelAndView(new RedirectView("/myaccount/invadeError.html"));
		}
		if(salesOrder.getPaymentMethodId() != null){
			PaymentMethod paymentMethod=paymentMethodService.getPaymentById(salesOrder.getPaymentMethodId());
			request.setAttribute("paymentMethod",paymentMethod);
		}
        Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
        request.setAttribute("customer", customer);
        Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
		return new ModelAndView("customer/orderReview", "salesOrder",salesOrder);
	}
	/**
	 * 根据指定条件查询订单
	 * @param request
	 * @return
	 */
    private List queryAndSetAttributes(HttpServletRequest request) {
    	
    	String filter = request.getParameter("orderFilter");
    	String orderNo = request.getParameter("orderNo");
    	SearchCriteria sc = null;
    	if (empty(filter)) filter = "default";
    	
    	if (filter.equals("default"))
    	{
    		sc = this.createSearchCriteria(request,"sf_default");
    		//14天内
    		Calendar cal = Calendar.getInstance();
    		cal.add(Calendar.DATE, -14);
    		sc.addParamValue(RequestContext.getCurrentUserId());
    		sc.addParamValue(cal.getTime());
    	}
    	else if (filter.equals("months-6"))
    	{
    		sc = this.createSearchCriteria(request,"sf_default");
    		//6个月前
    		Calendar cal = Calendar.getInstance();
    		cal.add(Calendar.MONTH, -6);
    		sc.addParamValue(RequestContext.getCurrentUserId());
    		sc.addParamValue(cal.getTime());
    	}
    	else if (filter.equals("all"))
    	{
    		//所有的订单
    		sc = this.createSearchCriteria(request,"sf_all");
    		sc.addParamValue(RequestContext.getCurrentUserId());
    		
    	}
    	else if (filter.equals("all_cancel"))
    	{
    		//所有已取消的订单
    		sc = this.createSearchCriteria(request,"sf_cancel");
    		sc.addParamValue(RequestContext.getCurrentUserId());
    	}
    	else if (filter.equals("special"))
    	{
    		//所有已取消的订单
    		sc = this.createSearchCriteria(request,"sf_specialNo");
    		sc.addParamValue(RequestContext.getCurrentUserId());
    		sc.addParamValue(orderNo);
    	}
    	if (sc == null)
    		return null;
    	sc.addParamValue(ConfigUtil.getInstance().getStore().getStoreId());
    	return this.searchByCriteria(sc);
	}


	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr =salesOrderManager;
	}
	
	/**
	 * 对已支付的订单使用礼券
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value="/myaccount/order/{orderId}.html",params="doAction=useGc", method=RequestMethod.POST)
	public ModelAndView  useGc(@PathVariable Integer orderId,HttpServletRequest request,HttpServletResponse response) {
		String gcNO = request.getParameter("gcNO");
		SalesOrder salesOrder = orderService.getSalesOrder(ConfigUtil.getInstance().getStore().getStoreId(),orderId, RequestContext.getCurrentUserId());
		if (StringUtils.isBlank(gcNO))
		{
			//String msg = getText("salesOrder.cancel.success", pa);
			saveMessage(Message.error("giftCertificate.error.empty"));
			ModelAndView mv = new ModelAndView("customer/orderReview", "salesOrder",salesOrder);
			return mv;
		}
		gcNO = gcNO.trim();
		boolean result = orderService.doUseSalesOrderGiftCertificate(salesOrder, gcNO, request.getRemoteAddr());
		if (result){
			saveMessage(Message.info("checkout.message.giftcertificate.used.success"));
			return new ModelAndView(new RedirectView("/myaccount/order/"+salesOrder.getSalesOrderId()+".html",true));
		}else{
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("giftCertificate.error.invaild",gcNO));
			ModelAndView mv = new ModelAndView("customer/orderReview", "salesOrder",salesOrder);
			return mv;
		}
	}
	
	//csCancelOrderForm.jsp
	/**
	 * 取消订单
	 */
	@RequestMapping(value="/myaccount/order/{orderId}.html",params="doAction=cancelOrder", method=RequestMethod.POST)
	public ModelAndView  cancelOrder(@PathVariable Integer orderId,HttpServletRequest request,HttpServletResponse response) {
		String userId = ""; 
		if(!RequestContext.isAnonymousUser())
			userId = String.valueOf(RequestContext.getCurrentUserId());
		String note = request.getParameter("note");
		short type = Short.valueOf(request.getParameter("cancleType")).shortValue();
		if(type!=OrderConstants.ORDER_CANCELTYPE_OTHER){
			note = getText("order.cancle."+type);
		}
		Integer storeId=ConfigUtil.getInstance().getStore().getStoreId();
		SalesOrder order = orderService.getSalesOrder(storeId,(Serializable)orderId, (Serializable)userId);
		if(order!=null&&order.getCancelOrderPermission4Customer()){
		    orderService.doCancelOrder(storeId,orderId, type, note, userId);
		    saveMessage(Message.info("salesOrder.cancel.success", order.getOrderNo()));
		}
		else{
			if(order!=null){
				saveMessage(Message.error("salesOrder.cancel.error", order.getOrderNo()));
			}
		}
		return getRedirectView("/myaccount/order/list.html");
	}

	
}