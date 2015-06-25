
package com.cartmatic.estoresf.customer.web.action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Membership;
import com.cartmatic.estore.common.model.sales.Coupon;
import com.cartmatic.estore.common.model.sales.GiftCertificate;
import com.cartmatic.estore.common.service.GiftCertificateService;
import com.cartmatic.estore.common.service.PromoService;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;

/**
 * 前台礼券优惠券查询controller
 * @author CartMatic
 */
@Controller
@RequestMapping(value="/myaccount/giftCouponQuery.html")
public class GiftCouponFrontController extends BaseStoreFrontController {

    private PromoService promoService = null;
    
    private GiftCertificateService giftCertificateService  = null;
    
	@Autowired
	private CustomerManager customerManager;
	
	@Autowired
	private MembershipManager membershipManager;
    
    
    public PromoService getPromoService() {
		return promoService;
	}


	public void setPromoService(PromoService promoService) {
		this.promoService = promoService;
	}


	public GiftCertificateService getGiftCertificateService() {
		return giftCertificateService;
	}


	public void setGiftCertificateService(GiftCertificateService giftCertificateService) {
		this.giftCertificateService = giftCertificateService;
	}

    @RequestMapping(method=RequestMethod.GET)
	public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response) throws ServletException {
    	Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
        return new ModelAndView("customer/giftCouponQuery");
    }
    
    @RequestMapping(method=RequestMethod.POST)
    public ModelAndView queryGiftCouponAction(HttpServletRequest request,
            HttpServletResponse response){
        String giftCouponNo=RequestUtil.getParameterNullSafe(request, "giftCouponNo").trim();
          
        Coupon coupon = promoService.QueryCouponByNo(giftCouponNo);
		request.setAttribute("coupon",coupon);
        GiftCertificate giftCertificate = giftCertificateService.QueryGiftCertificateByNo(giftCouponNo);
		request.setAttribute("giftCertificate",giftCertificate);
        request.setAttribute("giftCouponNo",giftCouponNo);
        
        Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
        
        return new ModelAndView("customer/giftCouponQuery");
        
    }
}
