package com.cartmatic.estoresf.customer.web.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.catalog.service.ProductReviewManager;
import com.cartmatic.estore.catalog.service.ProductStatManager;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.ProductReview;
import com.cartmatic.estore.common.model.customer.Address;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Membership;
import com.cartmatic.estore.common.service.CustomerService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.util.BeanUtils;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.SessionUtil;

@Controller
public class CustomerReviewFrontController extends GenericStoreFrontController<ProductReview>
{
    private ProductReviewManager productReviewManager;
    
    private CustomerService customerService;
    
    public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
    
	@Autowired
	private CustomerManager customerManager;
	
	@Autowired
	private MembershipManager membershipManager;

	@RequestMapping(value="/myaccount/review/list.html")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) 
    {
        com.cartmatic.estore.core.search.SearchCriteria sc = createSearchCriteria(request, "sf_myReviews");
        sc.addParamValue(ConfigUtil.getInstance().getStore().getStoreId());
        sc.addParamValue(RequestContext.getCurrentUserId());
        List<ProductReview> rs = mgr.searchByCriteria(sc);
        ModelAndView mv = new ModelAndView("customer/productReviewList");
        mv.addObject("productReviewList", rs);
        Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
        return mv;
    }

	@RequestMapping(value="/myaccount/review/{id}.html", method=RequestMethod.GET)
	public ModelAndView edit(@PathVariable Integer id,HttpServletRequest request, HttpServletResponse response) {
		ProductReview rw = getProductReview(id);
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
		ModelAndView mv = new ModelAndView("customer/productReviewForm");
		if (rw != null) {
			mv.addObject("review", rw);
			return mv;
		} else {
			if (logger.isInfoEnabled())
				logger.info("ReviewId not found or this customer isn't the owner.");
			// return defaultAction(request, response);
			// 非法访问
			return new ModelAndView(new RedirectView("/myaccount/invadeError.html"));
		}
	}

	@RequestMapping(value="/myaccount/review/{id}.html", method=RequestMethod.POST)
    public ModelAndView edit4save(@PathVariable Integer id,@Valid ProductReview productReview,BindingResult result,HttpServletRequest request, HttpServletResponse response) throws Exception
    {     
		ProductReview entity = getProductReview(id);
		if(entity==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		try {
			if (!result.hasErrors()) {
				BeanUtils.copyProperties(productReview, entity, "subject","message");
				entity.setStatus(Constants.STATUS_NOT_PUBLISHED); // 未审核
				productReviewManager.save(entity);
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			mav=new ModelAndView("/customer/productReviewForm");
		}else{
			saveMessage(Message.info("product.addReview.success"));
			mav=getRedirectView("/myaccount/review/list.html");
		}
		return mav;
    }
	
	@RequestMapping(value="/myaccount/review/delete/{id}.html", method=RequestMethod.GET)
	public ModelAndView delete(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception {
		ProductReview entity = getProductReview(id);
		if(entity==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		Integer storeId=ConfigUtil.getInstance().getStore().getStoreId();
		Integer productId = entity.getProductId();
        productReviewManager.deleteById(entity.getId());
        productReviewManager.updateProductReviewStat(entity.getStoreId(),productId);
        saveMessage(Message.info("product.review.deleted"));
		return getRedirectView("/myaccount/review/list.html");
	}
    
    /**
     * Get productReview by id
     * 会判断客人是否有权限。
     * @param reviewId
     * @return
     */
    private ProductReview getProductReview(final Integer reviewId)
    {
    	Integer storeId =ConfigUtil.getInstance().getStore().getStoreId();
        if (reviewId!=null)
        {
            ProductReview rw = productReviewManager.getById(reviewId);
            if (rw!= null && rw.getStore()!=null&&rw.getStore().getStoreId().intValue()==storeId&& rw.getReviewUser() != null &&
                    rw.getReviewUser().getAppuserId().equals(RequestContext.getCurrentUserId())){
                return rw;
            }
        }
        return null;
    }

	@RequestMapping(value="/myaccount/review/reviewCount.html")
    public ModelAndView getCountCustomerReviews(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AjaxView ajaxView=new AjaxView(response);
		try {
	    	Integer storeId =ConfigUtil.getInstance().getStore().getStoreId();
			Integer customerId=RequestContext.getCurrentUserId();
			Integer msgCount=customerService.getCountCustomerReviews(storeId,customerId);
			ajaxView.setData(msgCount);
		} catch (Exception e) {
			ajaxView.setStatus(new Short("-500"));
			e.printStackTrace();
		}
		return ajaxView;
	}
	
    
    @Override
    protected void initController() throws Exception
    {
        // TODO Auto-generated method stub
        mgr = productReviewManager;
    }

    public void setProductReviewManager(ProductReviewManager avalue)
    {
        productReviewManager = avalue;
    }
    
}
