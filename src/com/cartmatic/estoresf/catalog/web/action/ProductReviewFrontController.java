package com.cartmatic.estoresf.catalog.web.action;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.catalog.service.ProductMainManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.catalog.service.ProductRateItemManager;
import com.cartmatic.estore.catalog.service.ProductReviewManager;
import com.cartmatic.estore.catalog.service.ProductStatManager;
import com.cartmatic.estore.catalog.service.ReviewVoteManager;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductRateItem;
import com.cartmatic.estore.common.model.catalog.ProductReview;
import com.cartmatic.estore.common.model.catalog.ProductStat;
import com.cartmatic.estore.common.model.catalog.ReviewVote;
import com.cartmatic.estore.common.model.system.AppUser;
import com.cartmatic.estore.common.service.CustomerService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.search.SearchCriteria;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.estore.webapp.util.SessionUtil;

@Controller
public class ProductReviewFrontController extends GenericStoreFrontController<ProductReview>{
	private ProductReviewManager productReviewManager = null;
    private ProductRateItemManager productRateItemManager = null;
	private ProductManager			productManager			= null;
    private ProductStatManager productStatManager = null;
    
    private ProductMainManager productMainManager=null;
    private ReviewVoteManager reviewVoteManager=null;
    
	public void setProductMainManager(ProductMainManager productMainManager) {
		this.productMainManager = productMainManager;
	}

	public void setReviewVoteManager(ReviewVoteManager reviewVoteManager) {
		this.reviewVoteManager = reviewVoteManager;
	}

    @RequestMapping(value="/review/write/{id}.html", method=RequestMethod.GET)
	public ModelAndView defaultAction(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response){
		ModelAndView mv=new ModelAndView("review/productReviewForm");
		Integer productId=id;
		Product product=productManager.getById(productId);
		mv.addObject("product", product);
		if(product.getIsAllowReview().intValue()==Constants.FLAG_TRUE.intValue()&&((!RequestContext.isAnonymousUser())||ConfigUtil.getInstance().getIsAllowAnonymousReview())){
			List<ProductRateItem>productRateItemList=productRateItemManager.findProductRateItemsByProductType(product.getProductTypeId());
			AppUser appUser = (AppUser)RequestContext.getCurrentUser();
			ProductReview productReview=new ProductReview();
			mv.addObject("productReview", productReview);
			mv.addObject("productRateItemList", productRateItemList);
			mv.addObject("appUser", appUser);
		}else{
			mv.addObject("isAllowAnonymousReview", ConfigUtil.getInstance().getIsAllowAnonymousReview());
		}
		return mv;
	}
    
    @RequestMapping(value="/review/write/{id}.html", method=RequestMethod.POST)
	public ModelAndView writeReview(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws IOException{
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("action",0);
		if(RequestContext.isAnonymousUser()&&!ConfigUtil.getInstance().getIsAllowAnonymousReview()){
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("common.loginConfirm"));
//			return new ModelAndView(new RedirectView(uri+"#review"))
			data.put("action",-1);;
		}
		Integer productId=id;
		String message=request.getParameter("message");
		String customerName=request.getParameter("customerName");
		String subject=request.getParameter("subject");
		String productRateStr = request.getParameter("productRate");
		if(productRateStr == null){
			productRateStr = "5";
		}
		Integer productRate=Integer.parseInt(productRateStr);;
		String attrRates[]=request.getParameterValues("rateItems");
		if(productId.intValue()!=0&&productId.intValue()!=0){
			ProductReview productReview=new ProductReview();
			productReview.setProductId(productId);
			productReview.setSubject(subject);
			productReview.setMessage(message);
			if(RequestContext.isAnonymousUser()){
				//TODO 设置匿名用户对象，系统必须存在Id为-2的匿名用户
				productReview.setReviewUserId(Constants.USERID_ANONYMOUS);
			}else{
				productReview.setReviewUserId(RequestContext.getCurrentUserId());
			}
			productReview.setCustomerName(customerName);
			productReview.setRate(productRate);
			productReview.setRemoteIp(request.getRemoteAddr());
			productReview.setStore(ConfigUtil.getInstance().getStore());
			if(attrRates==null)attrRates=new String[]{};
			productMainManager.saveProductReviewAction(productReview, attrRates);
//			saveMessage(request, getMessage("product.addReview.success"))
			data.put("action",1);;
		}
		JSONObject jsonMap = JSONObject.fromObject(data);
		PrintWriter out = response.getWriter();
		out.println(jsonMap.toString());
		return null;
	}
	
	/**
	 * 显示产品相关评论
	 * @param request
	 * @param response
	 * @return
	 */
    @RequestMapping(value="/review/product/{id}.html")
	public ModelAndView showProductReviews(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response){
		Integer productId=id;
		String template = request.getParameter("template");
		template=StringUtils.isNotBlank(template)?template:"review/productReviewList";
		Integer storeId=ConfigUtil.getInstance().getStore().getStoreId();
		
		SearchCriteria searchCriteria=createSearchCriteria(request,"sf_productReviewList");
		searchCriteria.addParamValue(storeId);
		searchCriteria.addParamValue(id);
		List<ProductReview>productReviewList=productReviewManager.searchByCriteria(searchCriteria);
		//获取产品相关统计信息
		ProductStat productStat=productStatManager.getProductStat(storeId, productId);
		ModelAndView mv=new ModelAndView(template);
		mv.addObject("productReviewList", productReviewList);
		mv.addObject("productStat", productStat);
		mv.addObject("productId", productId);
		return mv;
	}

	/**
	 * 显示所有评论
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	/*
	 * @TODO 现在没有使用了
	 public ModelAndView listReviews(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String template = request.getParameter("template");
		template=template!=null&&template!=""?template:"review/reviews_box";
		ModelAndView mv = new ModelAndView(template);
		
		Integer productId=RequestUtil.getInteger(request, "productId");
		Product product=productManager.getActiveProduct(productId);
		
		SearchCriteria searchCriteria=createSearchCriteria(request,"productReviewList");
		List<ProductReview>productReviewList=productReviewManager.findActiveProductReviewsByProduct(searchCriteria,productId);
		//获取产品相关统计信息
		ProductStat productStat=product.getProductStat();
		mv.addObject("productReviewList", productReviewList);
		mv.addObject("productStat", productStat);
		mv.addObject("product", product);
		
		return mv;
	}*/
    
    
	/**
	 * 显示回复列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

    @RequestMapping(value="/review/review/{id}.html")
	public ModelAndView listReviewReplys(@PathVariable Integer id,HttpServletRequest request, HttpServletResponse response){
		Integer productReviewId=id;
		List<ProductReview>reviewReplyList=productReviewManager.findReplyListByReview(productReviewId);
		ModelAndView mv = new ModelAndView("review/prouctReview_replyList");
		mv.addObject("reviewReplyList", reviewReplyList);
		return mv;
	}
	
	/**
	 * 对评论进行投票
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */

    @RequestMapping(value="/review/vote/{id}.html")
	public ModelAndView voteReview(@PathVariable Integer id,HttpServletRequest request, HttpServletResponse response) throws IOException {
		AjaxView ajaxView=new AjaxView(response);
		//status,-500系统错误;0 表示未登录 ;1 表示成功 ;2 表示重复投票; 3 表示不能对自己的评论进行投票
		try {
			if(RequestContext.isAnonymousUser()){
				return ajaxView.setStatus(new Short("0"));
			}
			Integer productReviewId=id;
			//voteFlag 1表示yes 0表示no
			Short voteFlag=new Short(request.getParameter("voteFlag"));
			ProductReview productReview=productReviewManager.getById(productReviewId);
			//检查用户是否对该评论已经进行了投票
			if(productReview.getReviewUserId().intValue()==RequestContext.getCurrentUserId().intValue()){
				return ajaxView.setStatus(new Short("3"));
			}
			//检查用户是否对该评论已经进行了投票
			if(reviewVoteManager.voteAlready(productReviewId, RequestContext.getCurrentUserId())){
				return ajaxView.setStatus(new Short("2"));
			}
			if (voteFlag.intValue()==1) {
				productReview.setUsefulCount(productReview.getUsefulCount()+1);
			}else{
				productReview.setUnusefulCount(productReview.getUnusefulCount()+1);
			}
			ReviewVote reviewVote=new ReviewVote();
			reviewVote.setCustomerId(RequestContext.getCurrentUserId());
			reviewVote.setProductReview(productReview);
			reviewVoteManager.save(reviewVote);
			ajaxView.setStatus(new Short("1"));
		} catch (Exception e) {
			ajaxView.setStatus(new Short("-500"));
			e.printStackTrace();
		}
		return ajaxView;
	}
	
    public void setProductReviewManager(ProductReviewManager inMgr) {
        this.productReviewManager = inMgr;
    }

	@Override
	protected void initController() throws Exception {
		mgr=productReviewManager;
	}


	public ProductRateItemManager getProductRateItemManager() {
		return productRateItemManager;
	}


	public void setProductRateItemManager(
			ProductRateItemManager productRateItemManager) {
		this.productRateItemManager = productRateItemManager;
	}

	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}


	public void setProductStatManager(ProductStatManager productStatManager) {
		this.productStatManager = productStatManager;
	}
	
	@RequestMapping(value="/review/new.html")
	public ModelAndView showNewReviews(HttpServletRequest request,HttpServletResponse response){
		String template = request.getParameter("template");
		template=StringUtils.isNotBlank(template)?template:"review/customerTestimonials";
		Integer storeId=ConfigUtil.getInstance().getStore().getStoreId();
		SearchCriteria searchCriteria=createSearchCriteria(request,"sf_newReviews");
		searchCriteria.addParamValue(storeId);
		List<ProductReview>productReviewList=productReviewManager.searchByCriteria(searchCriteria);
		ModelAndView mv=new ModelAndView(template);
		mv.addObject("productReviewList", productReviewList);
		return mv;
	}

}
