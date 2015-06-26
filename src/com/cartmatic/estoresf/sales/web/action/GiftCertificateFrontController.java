package com.cartmatic.estoresf.sales.web.action;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.sales.GiftCertificate;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.sales.service.GiftCertificateManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;

@Controller
public class GiftCertificateFrontController extends GenericStoreFrontController<GiftCertificate>{
	private GiftCertificateManager				giftCertificateManager				= null;
    
	public void setGiftCertificateManager(GiftCertificateManager inMgr) {
		this.giftCertificateManager = inMgr;
	}
	
	@Override
	@RequestMapping(value="/myaccount/exchangeGiftCertificate.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		Integer exchangePoint=RequestUtil.getInteger(request,"exchangePoint");
		Customer customer=(Customer)RequestContext.getCurrentUser();
		giftCertificateManager.exchangeGiftCertificateByRewardPoints(customer, exchangePoint);
        saveMessage(Message.info("shopPoint.exchange.giftCertificate.updated"));
        return new ModelAndView(new RedirectView("/myaccount/shopPoint.html"));
	}
	
	@Override
	protected void initController() throws Exception {
		mgr = giftCertificateManager; 
	}


}
