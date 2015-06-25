package com.cartmatic.estoresf.customer.web.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.order.OrderMessage;
import com.cartmatic.estore.common.model.order.SalesOrder;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.search.SearchCriteria;
import com.cartmatic.estore.core.util.StringUtil;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.order.service.OrderMessageManager;
import com.cartmatic.estore.order.service.SalesOrderManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estoresf.customer.model.CustomerSettingsPasswordModel;

@Controller
public class OrderMessageFrontController extends GenericStoreFrontController<OrderMessage>{

	private OrderMessageManager orderMessageManager;
	private SalesOrderManager salesOrderManager;
	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr =orderMessageManager;
	}
	
	@Override
	@RequestMapping(value="/myaccount/orderMessage/list.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
        if (logger.isDebugEnabled()) {
            logger.debug("entering 'OrderMessageController defaultAction' method...");
        }
        //return a paging list
        //List results = mgr.g;
        SearchCriteria sc_orders = mgr.getSearchCriteriaBuilder("sf_allActiveOrders").buildSearchCriteria(new MockHttpServletRequest(), 50);
        sc_orders.addParamValue(RequestContext.getCurrentUserId());
        SearchCriteria sc = this.createSearchCriteria(request,"sf_customerMsg");
        sc.addParamValue(RequestContext.getCurrentUserId());
        ModelAndView mv = new ModelAndView("customer/orderMessageList");
        mv.addObject("orderMessageList", mgr.searchByCriteria(sc));
        mv.addObject("activeOrders", mgr.searchByCriteria(sc_orders));
        return mv;
    }

	@RequestMapping(value="/myaccount/orderMessage/add.html")
	public ModelAndView save(@Valid OrderMessage orderMessage,BindingResult result,HttpServletRequest request, HttpServletResponse response) {
        if (logger.isDebugEnabled()) {
            logger.debug("entering 'OrderMessageController save' method...");
        }
        SalesOrder order = salesOrderManager.getById(new Integer(request.getParameter("orderId")));
        if(order==null||order.getCustomerId().intValue()!=RequestContext.getCurrentUserId().intValue()){
        	//非法访问
			return new ModelAndView(new RedirectView("/myaccount/invadeError.html"));
        }
        try {
			if (!result.hasErrors()) {
				orderMessage.setCustomerId(RequestContext.getCurrentUserId());
				orderMessage.setStatus(Constants.STATUS_NOT_PUBLISHED);
		        orderMessage.setOrderNo(order.getOrderNo());
//		        orderMessage.setSalesOrderId(order.getSalesOrderId());
		        orderMessage.setSalesOrder(order);
		        mgr.save(orderMessage);
		        saveMessage(Message.info("orderMessage.send.message.success"));
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
        return getRedirectView("/myaccount/orderMessage/list.html");
    }

	@RequestMapping(value="/myaccount/orderMessage/delete/{messageId}.html")
	public ModelAndView delete(@PathVariable Integer messageId,HttpServletRequest request, HttpServletResponse response) {
        if (logger.isDebugEnabled()) {
            logger.debug("entering 'OrderMessageController delete' method...");
        }
        OrderMessage orderMessage=mgr.getById(messageId);
        if(orderMessage==null||orderMessage.getCustomerId().intValue()!=RequestContext.getCurrentUserId().intValue()){
        	//非法访问
			return new ModelAndView(new RedirectView("/myaccount/invadeError.html"));
        }
        mgr.deleteById(messageId);
        saveMessage(Message.info("orderMessage.delete.message.success"));
        return getRedirectView("/myaccount/orderMessage/list.html");
    }

	@RequestMapping(value="/myaccount/orderMessage/list.html",params="doAction=updateStatus", method=RequestMethod.POST)
	public ModelAndView updateStatus(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String ids = request.getParameter("ids");
		String messageIds[]=ids.split(",");
		for (String messageId : messageIds) {
			OrderMessage orderMessage=orderMessageManager.getById(new Integer(messageId));
			  if(orderMessage==null||orderMessage.getCustomerId().intValue()!=RequestContext.getCurrentUserId().intValue()){
				//非法访问
				  continue;
			  }
			orderMessage.setStatus(Constants.STATUS_ACTIVE);
			orderMessageManager.save(orderMessage);
		}
		return null;
	}

	public void setOrderMessageManager(OrderMessageManager avalue)
	{
		orderMessageManager = avalue;
	}
	
	public void setSalesOrderManager(SalesOrderManager avalue)
	{
		salesOrderManager = avalue;
	}

	@RequestMapping(value="/myaccount/orderMessage/list.html",params="doAction=getCountMsgs", method=RequestMethod.POST)
	public ModelAndView getCountMsgs(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AjaxView ajaxView=new AjaxView(response);
		try {
			Integer customerId=RequestContext.getCurrentUserId();
			Integer msgCount=orderMessageManager.getCountCustomerMsgs(customerId);
			ajaxView.setData(msgCount);
		} catch (Exception e) {
			ajaxView.setStatus(new Short("-500"));
			e.printStackTrace();
		}
		return ajaxView;
	}
}
