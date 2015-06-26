package com.cartmatic.estoresf.customer.web.action;

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

import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.catalog.service.ProductStatManager;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductStat;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Favorite;
import com.cartmatic.estore.common.model.customer.Membership;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.FavoriteManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;

@Controller
public class FavoriteController extends  GenericStoreFrontController<Favorite>
{

	@Autowired
	private FavoriteManager favoriteManager;
	@Autowired
	private CustomerManager customerManager;
	@Autowired
	private ProductManager productManager;
	@Autowired
	private ProductStatManager productStatManager;
	
	@Autowired
	private MembershipManager membershipManager;
	
	/**
	 * 添加收藏
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/ajaxFavorite.html")
	public ModelAndView addFavorite(HttpServletRequest request,HttpServletResponse response)
	{
		AjaxView ajaxView=new AjaxView(response);
		if(RequestContext.isAnonymousUser()){
			ajaxView.setStatus(new Short("-1"));
			return ajaxView;
		}
		String productId = request.getParameter("productId");
		Product p = null;
		if(StringUtils.isNotBlank(productId)){
			p = productManager.getActiveProduct(new Integer(productId));
		}
		if(p==null){
			ajaxView.setStatus(new Short("-2"));
			return ajaxView;
		}
		Store store=ConfigUtil.getInstance().getStore();
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		Favorite f = favoriteManager.loadFavorite(store.getStoreId(),customer.getAppuserId(), p.getProductId());
		ProductStat proStat = productStatManager.getProductStat(store.getStoreId(), p.getProductId());
		if(f!=null){
			//已经存在
			ajaxView.setStatus(new Short("2"));
			ajaxView.setMsg("该产品已添加过收藏夹！");
		}else{
			Favorite entity = new Favorite();
			entity.setStore(store);
			entity.setCustomer(customer);
			entity.setProduct(p);
			mgr.save(entity);
			favoriteManager.updateFavoriteStat(store.getStoreId(),p.getProductId());
			//更新索引
			CatalogHelper.getInstance().indexNotifyUpdateEvent(p.getProductId());
			ajaxView.setStatus(new Short("1"));
			ajaxView.setMsg("成功加入收藏夹");
		}
		ajaxView.setData(proStat.getFavoriteCount());
		return ajaxView;
	}
	
	
	
	@RequestMapping(value="/myaccount/favorites.html")
	public ModelAndView showFavorites(HttpServletRequest request,HttpServletResponse response)
	{
		ModelAndView mv = new ModelAndView("customer/favoriteList");
		com.cartmatic.estore.core.search.SearchCriteria sc = createSearchCriteria(request, "sf_myFavorites");
        sc.addParamValue(ConfigUtil.getInstance().getStore().getStoreId());
        sc.addParamValue(RequestContext.getCurrentUserId());
        List<Favorite> favoriteList = mgr.searchByCriteria(sc);
        mv.addObject("favoriteList", favoriteList);
        Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
		return mv;
	}
	
	@RequestMapping(value="/myaccount/favorite/delete/{id}.html", method=RequestMethod.GET)
	public ModelAndView delete(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Favorite entity = getFavorite(id);
		if(entity==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		Integer storeId=ConfigUtil.getInstance().getStore().getStoreId();
		Integer productId = entity.getProductId();
		favoriteManager.deleteById(entity.getId());
		favoriteManager.updateFavoriteStat(storeId,productId);
		//更新索引
		CatalogHelper.getInstance().indexNotifyUpdateEvent(productId);
        saveMessage(Message.info("product.favorite.deleted"));
		return getRedirectView("/myaccount/favorites.html");
	}
	
	  /**
     * Get productReview by id
     * 会判断客人是否有权限。
     * @param reviewId
     * @return
     */
    private Favorite getFavorite(final Integer favoriteId)
    {
    	Integer storeId =ConfigUtil.getInstance().getStore().getStoreId();
        if (favoriteId!=null)
        {
        	Favorite f = favoriteManager.getById(favoriteId);
            if (f!= null&& f.getStore()!=null&&f.getStore().getStoreId().intValue()==storeId && f.getCustomer()!=null&&f.getCustomerId().equals(RequestContext.getCurrentUserId())){
                return f;
            }
        }
        return null;
    }
	
	@Override
	protected void initController() throws Exception {
		mgr = favoriteManager;
	}



	public MembershipManager getMembershipManager() {
		return membershipManager;
	}



	public void setMembershipManager(MembershipManager membershipManager) {
		this.membershipManager = membershipManager;
	}

}
