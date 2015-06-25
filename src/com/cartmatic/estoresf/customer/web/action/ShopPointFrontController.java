package com.cartmatic.estoresf.customer.web.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Membership;
import com.cartmatic.estore.common.model.customer.ShopPoint;
import com.cartmatic.estore.common.model.customer.ShopPointHistory;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.search.SearchCriteria;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.customer.service.ShopPointHistoryManager;
import com.cartmatic.estore.customer.service.ShopPointManager;
import com.cartmatic.estore.webapp.util.RequestContext;

@Controller
public class ShopPointFrontController extends GenericStoreFrontController<ShopPointHistory> 
{

	private ShopPointHistoryManager shopPointHistoryManager=null;
	
	private ShopPointManager shopPointManager=null;
	
	@Autowired
	private CustomerManager customerManager;
	
	@Autowired
	private MembershipManager membershipManager;
	
	public void setShopPointHistoryManager(
			ShopPointHistoryManager shopPointHistoryManager) {
		this.shopPointHistoryManager = shopPointHistoryManager;
	}

	public void setShopPointManager(ShopPointManager shopPointManager) {
		this.shopPointManager = shopPointManager;
	}

	@RequestMapping("/myaccount/shopPoint.html")
	public ModelAndView defaultAction(HttpServletRequest req, HttpServletResponse resp)  {
		
		Integer customerId=RequestContext.getCurrentUserId();
		
		ShopPoint shopPoint=shopPointManager.getByCustomerId(customerId);
		
		SearchCriteria sc = this.createSearchCriteria(req, null);
		sc.addParamValue(customerId);
		List<ShopPointHistory> shopPointHistoryList=this.searchByCriteria(sc);
		
		req.setAttribute("shopPoint", shopPoint);
		
		req.setAttribute("shopPointHistoryList", shopPointHistoryList);
		
		 Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		req.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        req.setAttribute("membership", membership);
	        
		return new ModelAndView("customer/shopPoint");
	}

    @Override
    protected void initController() throws Exception
    {
        // TODO Auto-generated method stub
        mgr = shopPointHistoryManager;
    }
	
}
