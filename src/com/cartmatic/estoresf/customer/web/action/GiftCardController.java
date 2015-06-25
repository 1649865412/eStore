package com.cartmatic.estoresf.customer.web.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Membership;
import com.cartmatic.estore.common.model.sales.GiftCertificate;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.sales.service.GiftCertificateManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;

/**
 * 会员卡管理
 * @author Ryan
 *
 */
@Controller
public class GiftCardController extends  GenericStoreFrontController<GiftCertificate>
{

	@Autowired
	private GiftCertificateManager giftCertificateManager = null;
	
	@Autowired
	private CustomerManager customerManager;
	
	@Autowired
	private MembershipManager membershipManager;
	
	@RequestMapping(value="/myaccount/giftCard.html")
	public ModelAndView showGc(HttpServletRequest request,HttpServletResponse response)
	{
		ModelAndView mv = new ModelAndView("customer/giftCard");
		List<GiftCertificate> gc = giftCertificateManager.findByProperty("customerId", RequestContext.getCurrentUserId());
		mv.addObject("gcList", gc);
		
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
		
		return mv;
	}
	
	@RequestMapping(value="/myaccount/giftCard/active.html",method=RequestMethod.POST)
	public ModelAndView activeGc(HttpServletRequest request,HttpServletResponse response)
	{
		ModelAndView mv=new ModelAndView(new RedirectView("/myaccount/giftCard.html"));
		//String giftNo = request.getParameter("giftNo");
		String giftNo = RequestUtil.getParameterNullSafe(request, "giftNo").trim();
		
		GiftCertificate gc = giftCertificateManager.getGiftCertificate(giftNo);
		if (gc == null || GiftCertificate.GC_NORMAL.equals(gc.getGiftType()))
		{
			saveMessage(Message.info("giftCouponQuery.giftCertificate.state0", giftNo));
			return mv;
		}
		//已经有customerId或已经激活了的，就不可能再次绑定
		if (gc.getCustomerId() != null || GiftCertificate.STATUS_ACTIVE.equals(gc.getStatus()))
		{
			saveMessage(Message.info("giftCertificate.error.binded"));
			return mv;
		}
		gc.bindToCustomer(RequestContext.getCurrentUserId());
		mgr.save(gc);
		saveMessage(Message.info("giftCertificate.active.success"));
		return mv;
	} 
	
	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr = giftCertificateManager;
	}

}
