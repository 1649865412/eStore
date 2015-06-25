package com.cartmatic.estoresf.customer.web.action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.common.model.order.SalesOrder;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.order.service.SalesOrderManager;
import com.cartmatic.estore.webapp.util.RequestContext;

/**
 * @TODO 暂时没有使用
 * @author kedou
 *
 */
@Controller
@RequestMapping("/orderTracking.html")
public class AnonymousOrderController  extends BaseStoreFrontController
{
	private SalesOrderManager mgr = null;
    
    public void setSalesOrderManager(SalesOrderManager salesOrderManager) {
        this.mgr = salesOrderManager;
    }
    
    public ModelAndView defaultAction(HttpServletRequest request,
            HttpServletResponse response) throws ServletException {
    	//记录访问url,登录成功后直接放过原来页面
    	request.getSession().setAttribute(Constants.CHECKOUT_TARGET_URL,request.getRequestURL().toString());
    	if(RequestContext.getCurrentUser()==null)
    	{
    		return new ModelAndView("customer/orderSignup");
    	}
    	else
    	{
    		return new ModelAndView(new RedirectView("/myaccount/order/list.html",true));
    	}
    }
    
    /**
     * 根据订单号和Email来查询
     * @param request
     * @param response
     * @return
     * @throws ServletException
     */
    public ModelAndView anonymousOrderQuery(HttpServletRequest request,
			HttpServletResponse response) throws ServletException {
        
        String orderNo = request.getParameter("orderNo");
        String email = request.getParameter("email");
        SalesOrder salesOrder=null;
        if(!empty(orderNo) && !empty(email))
        {
        	orderNo = orderNo.trim();
        	email = email.trim();
        	//TODO query by orderNo and email.
            salesOrder=mgr.getSalesOrder(orderNo, email);
        }
        ModelAndView mv = new ModelAndView("customer/orderReview");
        if (salesOrder != null)
        {
        	mv.addObject("salesOrder",salesOrder);
        }
        return mv;
    }
}
