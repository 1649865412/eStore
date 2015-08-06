package com.cartmatic.estoresf.cart.web.action;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Enumeration;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.cart.CheckoutConstants;
import com.cartmatic.estore.cart.model.AddToCartResult;
import com.cartmatic.estore.cart.model.CheckoutPagingModel;
import com.cartmatic.estore.cart.service.ShoppingcartItemManager;
import com.cartmatic.estore.cart.service.ShoppingcartManager;
import com.cartmatic.estore.cart.util.CheckoutUtil;
import com.cartmatic.estore.cart.util.ShoppingCartUtil;
import com.cartmatic.estore.catalog.service.CategoryManager;
import com.cartmatic.estore.catalog.service.ProductCategoryManager;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.cart.Shoppingcart;
import com.cartmatic.estore.common.model.cart.ShoppingcartItem;
import com.cartmatic.estore.common.model.catalog.Category;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.customer.Address;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.ShopPoint;
import com.cartmatic.estore.common.model.inventory.Inventory;
import com.cartmatic.estore.common.model.sales.Coupon;
import com.cartmatic.estore.common.model.sales.GiftCertificate;
import com.cartmatic.estore.common.model.sales.PromoRule;
import com.cartmatic.estore.common.model.system.Region;
import com.cartmatic.estore.common.model.system.ShippingRate;
import com.cartmatic.estore.common.service.GiftCertificateService;
import com.cartmatic.estore.common.service.PromoService;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.customer.service.AddressManager;
import com.cartmatic.estore.customer.service.ShopPointManager;
import com.cartmatic.estore.system.service.RegionManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.estore.webapp.util.SessionUtil;

/**
 * /eStore/web/WEB-INF/templates/default/pages/cart/include/buyNow.jspf
 */

/**
 * 购物车数据组织控制类， buyNow.jspf
 *  <code>ShoppingcartController.java</code>
 *  <p>
 *  <p>Copyright  2015 All right reserved.
 *  @author admin 时间 2015-5-14 下午04:08:24	
 *  @version 1.0 
 *  </br>最后修改人 无
 */
@Controller
@RequestMapping("/cart/shoppingcart.html")
public class ShoppingcartController extends BaseStoreFrontController {
	
	// ---- Manager
	private ShoppingcartManager shoppingcartManager = null;
	private ShoppingcartItemManager shoppingcartItemManager=null;
	private PromoService promoService; 
	private final static Pattern item_quantity_pattern = Pattern.compile("^[1-9]\\d{0,2}$");
	
	private RegionManager regionManager;
	private AddressManager addressManager;
	
	private ShopPointManager shopPointManager=null;
	
	@Autowired
	private GiftCertificateService giftCertificateService=null;
	@Autowired
	private CategoryManager categoryManager;
	@Autowired
	private ProductCategoryManager productCategoryManager;
	
	public void setShopPointManager(ShopPointManager shopPointManager) {
		this.shopPointManager = shopPointManager;
	}

	public void setShoppingcartItemManager(
			ShoppingcartItemManager shoppingcartItemManager) {
		this.shoppingcartItemManager = shoppingcartItemManager;
	}

	public void setAddressManager(AddressManager addressManager) {
		this.addressManager = addressManager;
	}

	public void setRegionManager(RegionManager regionManager) {
		this.regionManager = regionManager;
	}

	//产品详细页面,和search页面才有add to cart,所以continue shopping只会重定向到这些页面.
	private final static Pattern[] referer_pattern = {
	    Pattern.compile("^http://(.+)_p(\\d+).html$"),
	    Pattern.compile("^http://(.+)/Catalog(.*).html.*$"),
	    Pattern.compile("^http://(.+)_p(\\d+)_(\\d+).html$"),
	    Pattern.compile("^http://(.+)/search-prod.html.*$")
	};
	/**
	 * 新版首页获取购物车列表
	 * @param request
	 * @param response
	 * @throws Exception
	 */
//	@RequestMapping(params="doAction=getHeadCart", method=RequestMethod.POST)
//	public void getHeadCart(HttpServletRequest request,HttpServletResponse response) throws Exception
//    {
//		if (logger.isDebugEnabled()) {
//			logger.debug("entering 'ShoppingcartController defaultAction' method...");
//		}
//		Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
//		Shoppingcart shoppingcart = null;
//		String sUuid = "";
//		if(cookie!=null){//进入购物车页面时，假如cookie中没有购物车uuid，则初始化一辆购物车给用户
//		    sUuid = cookie.getValue();
////		    shoppingcart = shoppingcartManager.loadShoppingcartByUuid(sUuid);
//		    shoppingcartManager.doNotUseCoupon(sUuid);
//		    shoppingcart = shoppingcartManager.refreshCart(sUuid, request, response);
//		    if(shoppingcart==null){
//		    	Customer customer = (Customer) RequestContext.getCurrentUser();
//		    	shoppingcart = shoppingcartManager.initShoppingcart(customer);
//		    }
//		}
//		else{
//			Customer customer = (Customer) RequestContext.getCurrentUser();
//			shoppingcart = shoppingcartManager.initShoppingcart(customer);
//		}
//			shoppingcartManager.save(shoppingcart);
//    }
	
	/**
	 * 购物车商品数量-1
	 * /eStore/web/scripts/cartmatic/cart/checkout/cartManager.js
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params="doAction=substractQuantity", method=RequestMethod.POST)
	public ModelAndView substractQuantity(HttpServletRequest request,HttpServletResponse response) throws Exception
    {
		String cartUuid=request.getParameter("cartUuid");
		String shoppingcartItemId=request.getParameter("shoppingcartItemId");
		Shoppingcart shoppingcart =	shoppingcartManager.doDeleteItemOne(cartUuid, shoppingcartItemId, request, response);
		System.out.println("购物车ID:"+shoppingcartItemId+"商品-1");
		defaultAction(request, response);
		String fullCutPrice=request.getAttribute("fullCutPrice").toString();
		AjaxView ajaxView = new AjaxView(response);
        	ajaxView.setMsg(fullCutPrice);
			shoppingcart.setFullCutSum(new BigDecimal(fullCutPrice));
//			shoppingcart.setTotal(shoppingcart.getTotal().subtract(new BigDecimal(fullCutPrice)));
			shoppingcartManager.save(shoppingcart);
        return ajaxView;
    }
	/**
	 * 购物车商品数量+1
	 * /eStore/web/scripts/cartmatic/cart/checkout/cartManager.js
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params="doAction=addQuantity", method=RequestMethod.POST)
	public ModelAndView addQuantity(HttpServletRequest request,HttpServletResponse response) throws Exception
    {
		String cartUuid=request.getParameter("cartUuid");
		String shoppingcartItemId=request.getParameter("shoppingcartItemId");
		Integer productSkuId=Integer.valueOf(request.getParameter("productSkuId"));
		Shoppingcart shoppingcart =	shoppingcartManager.addQuantityOne(cartUuid, productSkuId,"", request, response);
		System.out.println("购物车商品ID:"+productSkuId+"商品+1");
		defaultAction(request, response);
		String fullCutPrice=request.getAttribute("fullCutPrice").toString();
		AjaxView ajaxView = new AjaxView(response);
        	ajaxView.setMsg(fullCutPrice);
			shoppingcart.setFullCutSum(new BigDecimal(fullCutPrice));
//			shoppingcart.setTotal(shoppingcart.getTotal().subtract(new BigDecimal(fullCutPrice)));
			shoppingcartManager.save(shoppingcart);
        return ajaxView;
    }
	

    /**
     * 功能:卷控劵使用
	 * 返回结果
	 * 默认情况下
	 * 1表示成功
	 * 0表示失败
     * <p>作者 杨荣忠 2015-5-18 下午02:19:58
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params="doAction=juankongPay", method=RequestMethod.POST)
	public ModelAndView juankongPay(HttpServletRequest request, HttpServletResponse response,String juankongNo)
    {
        boolean flag =false;
        if (!juankongNo.trim().equals(""))
        {
        	flag= shoppingcartManager.doCheckJuankong(juankongNo);
        }
        AjaxView ajaxView = new AjaxView(response);
        if(flag==true)
        {
        	ajaxView.setStatus((short) 1);
        	changeDiscount( request,  response);
        }else{
        	ajaxView.setStatus((short) 0);
        }
        return ajaxView;
    }
    
    
    
    /**
     * 功能:更改购物车总折扣与价格
     * <p>作者 杨荣忠 2015-5-18 下午05:55:38
     * @param request
     * @param response
     */
    public void changeDiscount(HttpServletRequest request, HttpServletResponse response){
    	 
        Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
		Shoppingcart shoppingcart = null;
		String fullCutPrice=request.getAttribute("fullCutPrice").toString();
		String sUuid = "";
		if(cookie!=null){
		    sUuid = cookie.getValue();
		    shoppingcartManager.doNotUseCoupon(sUuid);
		    shoppingcart = shoppingcartManager.refreshCart(sUuid, request, response);
		    if(shoppingcart==null){
		    	Customer customer = (Customer) RequestContext.getCurrentUser();
		    	shoppingcart = shoppingcartManager.initShoppingcart(customer);
		    }
		}
		else{
			Customer customer = (Customer) RequestContext.getCurrentUser();
			shoppingcart = shoppingcartManager.initShoppingcart(customer);
		}
		
		if(shoppingcart!=null)
		{
			shoppingcart.setCartDiscountAmount(shoppingcart.getCartDiscountAmount().add(new BigDecimal(500)));//127为该增加的金额，2为本地测试
			shoppingcart.setTotal(shoppingcart.getTotal().add(new BigDecimal(-500)));
		}
		shoppingcartManager.save(shoppingcart);
    }

	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response)  
	{
		if (logger.isDebugEnabled()) {
			logger.debug("entering 'ShoppingcartController defaultAction' method...");
		}
		Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
		Shoppingcart shoppingcart = null;
		String sUuid = "";
		if(cookie!=null){//进入购物车页面时，假如cookie中没有购物车uuid，则初始化一辆购物车给用户
		    sUuid = cookie.getValue();
//		    shoppingcart = shoppingcartManager.loadShoppingcartByUuid(sUuid);
		    shoppingcartManager.doNotUseCoupon(sUuid);
		    shoppingcart = shoppingcartManager.refreshCart(sUuid, request, response);
		    if(shoppingcart==null){
		    	Customer customer = (Customer) RequestContext.getCurrentUser();
		    	shoppingcart = shoppingcartManager.initShoppingcart(customer);
		    }
		}
		else{
			Customer customer = (Customer) RequestContext.getCurrentUser();
			shoppingcart = shoppingcartManager.initShoppingcart(customer);
		}
	//	Set<ShoppingcartItem> items = shoppingcart.getCartItems();
		shoppingcart.setShopPoint(null);
		shoppingcartManager.save(shoppingcart);
		String pIds = "";
		boolean flag = false; //购物车内的产品是否全是“每日78折”目录下，false表示是
		flag = true;
		/*
		Category categoryDayoff78 = categoryManager.getProductCategoryByCode(Constants.ROOT_CATEGORY_CATALOG, "dayoff78");
		Category categoryOff50 = categoryManager.getProductCategoryByCode(Constants.ROOT_CATEGORY_CATALOG, "off50");
		for(ShoppingcartItem item:items){
			if(item.getItemType().equals(Constants.ITEM_TYPE_PRODUCT))
			pIds += item.getProductSku().getProductId() + "," ;
			//item.setMaxOrderQuantity(item.getProductSku().getInventory().getAvailableQuantity());
			Inventory inv  = item.getProductSku().getInventory();
			if(inv != null){
				Integer avQn = inv.getAvailableQuantity();
				item.setMaxOrderQuantity(avQn);
			}
			
			
			if (categoryDayoff78 != null
					&& !productCategoryManager.isInCategory(item
							.getProductSku().getProductId(), categoryDayoff78
							.getCategoryPath()
							+ categoryDayoff78.getCategoryId() + ".")) {
				
				if (categoryOff50 != null
						&& !productCategoryManager.isInCategory(item
								.getProductSku().getProductId(), categoryOff50
								.getCategoryPath()
								+ categoryOff50.getCategoryId() + ".")) {					
					flag = true; // 可使用优惠劵和礼品卡
					
				}
			}
		}*/
		if(!flag){
			if(cookie != null){
				shoppingcartManager.doNotUseCoupon(cookie.getValue());
				shoppingcart.setGiftCertificateNos(null);
//	        	shoppingcart = shoppingcartManager.refreshCart(cookie.getValue(), request, response);
	        	shoppingcartManager.save(shoppingcart);
			}
		}
		request.setAttribute("useAbled", flag);
		if(!pIds.equals("")){
			pIds = pIds.substring(0, pIds.length()-1);
		}
		request.setAttribute("isOutOfStock", shoppingcartManager.doCheckCartOutOfStock(shoppingcart));
		request.setAttribute("sourceIds", pIds);
		PromoRule promoRule = promoService.getCouponType(shoppingcart.getGainedCouponTypeId());
		request.setAttribute("coupone", promoRule);
		request.setAttribute("shoppingcart", shoppingcart);
		//设置referer,用于shoppingCart上的continue shopping
		String referer = request.getParameter("referer");
		if (empty(referer))
		{
		    referer = request.getHeader("referer");
		    boolean hasMatch = false;
		    if (!empty(referer))
		    {
		        for (Pattern p : referer_pattern) //在指定的url上才有referer
		        {
		            if (p.matcher(referer).matches())
		            {
		                hasMatch = true;
		                break;
		            }
		        }
		    }
		    if (!hasMatch)
		        referer = ConfigUtil.getInstance().getStore().getSiteUrl()+"/";
		}
		request.setAttribute("referer", referer);
		CheckoutPagingModel checkoutPagingModel=CheckoutUtil.getInstance().getCheckoutPagingModel(request);
		checkoutPagingModel.setCurrentStep(1);
		
		//估算运费
		if(StringUtils.isNotBlank(request.getParameter("addressId"))){
			checkoutPagingModel.setShippingAddressId(new Integer(request.getParameter("addressId")));
		}
		if(StringUtils.isNotBlank(request.getParameter("countryId"))){
			checkoutPagingModel.setCountryId(new Integer(request.getParameter("countryId")));
		}
		//匿名的列出所有国家/所有运输地址
		List<Address> shippingAddressList=null;
		if(!RequestContext.isAnonymousUser()){
			Integer currentUserId=RequestContext.getCurrentUserId();
			shippingAddressList=addressManager.getAllShippingAddressByAppuserId(currentUserId);
			request.setAttribute("shippingAddressList",shippingAddressList);
		}
		if(shippingAddressList==null||shippingAddressList.size()==0){
			List<Region>regionList=regionManager.getActiveRegionByType(1);
			request.setAttribute("regionList",regionList);
		}
		
		//指定估算运费的地址
		Address shippingAddress=null;
		if(!RequestContext.isAnonymousUser()){
			Integer shippingAddressId=checkoutPagingModel.getShippingAddressId();
			if(shippingAddressId!=null){
				shippingAddress=addressManager.getById(shippingAddressId);
			}else if(shippingAddressList!=null&&shippingAddressList.size()>0){
				shippingAddress=addressManager.getDefShippingAddr(RequestContext.getCurrentUserId());
			}
			if(shippingAddress==null&&shippingAddressList.size()>0){
				shippingAddress=shippingAddressList.get(0);
			}
			if(shippingAddress!=null){
				checkoutPagingModel.setShippingAddressId(shippingAddress.getAddressId());
			}
		} 
		
		if(shippingAddress==null){
			shippingAddress=new Address();
			shippingAddress.setCountryId(checkoutPagingModel.getCountryId());
			//默认设置上美国
			if(shippingAddress.getCountryId()==null){
				shippingAddress.setCountryId(24459);
				checkoutPagingModel.setCountryId(shippingAddress.getCountryId());
			}
		}
//		List<ShippingRate> shippingRateList=CheckoutUtil.getInstance().statCartShipping(shippingAddress, shoppingcart);
//		request.setAttribute("shippingRateList",shippingRateList);
		
		Integer customerId=RequestContext.getCurrentUserId();
		
		ShopPoint shopPoint=shopPointManager.getByCustomerId(customerId);
		
		request.setAttribute("shopPoint", shopPoint);
		
		//已绑定的礼券
		Integer currentUserId = RequestContext.getCurrentUserId();
		if(currentUserId > 0){
			List<GiftCertificate> gcList = giftCertificateService.getBindedGiftCard(RequestContext.getCurrentUserId());
			if (gcList != null && gcList.size() > 0)
			{
				for (GiftCertificate gc: gcList)
				{
					gc.setShoppingCartItems(shoppingcart.getBuyNowItemsCount());
				}
			}
			request.setAttribute("gcList", gcList);
		}
		
		//判断 显不显示卷控的输入框
		request.setAttribute("checkHaveJuankong",ShoppingCartUtil.checkHaveJuankong(shoppingcart)); 
		request.setAttribute("fullCutPrice",ShoppingCartUtil.fullCutPrice(shoppingcart)); 
		shoppingcart.setFullCutSum(new BigDecimal(ShoppingCartUtil.fullCutPrice(shoppingcart)));
		shoppingcart.setTotal(shoppingcart.getTotal().subtract(new BigDecimal(ShoppingCartUtil.fullCutPrice(shoppingcart))));
		shoppingcartManager.save(shoppingcart);
		return new ModelAndView("cart/shoppingcart");
	}
	

    @RequestMapping(params="doAction=moveFavoriteItemToCart", method=RequestMethod.POST)
	public ModelAndView moveFavoriteItemToCart(HttpServletRequest request, HttpServletResponse response)
	{
	    String itemId = request.getParameter("selected_itemId");
	    Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
    	ShoppingcartItem toDeleteItem = shoppingcartItemManager.getById(Integer.valueOf(itemId));
	    if (cookie != null&&toDeleteItem!=null)
	    {
	        boolean result = shoppingcartManager.doMoveFavoriteItemToCart(cookie.getValue(), new Integer(itemId), request, response);
	        if (!result)
	        {
	            SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
	            saveMessage(Message.error("shoppingcartItem.cannotUpdate_stockNotEnough"));
	        }else{
	            saveMessage(Message.info("shoppingcart.addedProductToCart",toDeleteItem.getProductSku().getProduct().getProductName()));
	        }
	    }
	    return defaultAction(request, response);
	}

    @RequestMapping(params="doAction=moveCartItemToFavorite", method=RequestMethod.POST)
	public ModelAndView moveCartItemToFavorite(HttpServletRequest request, HttpServletResponse response)
    {
        String itemId = request.getParameter("selected_itemId");
        Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
    	ShoppingcartItem toDeleteItem = shoppingcartItemManager.getById(Integer.valueOf(itemId));
        if (cookie != null&&toDeleteItem!=null)
        {
            shoppingcartManager.doMoveCartItemToFavorite(cookie.getValue(), new Integer(itemId), request, response);
            saveMessage(Message.info("shoppingcart.moveCartItemToFavorite",toDeleteItem.getProductSku().getProduct().getProductName()));
        }
        return defaultAction(request, response);
    }

    @RequestMapping(params="doAction=deleteItem", method=RequestMethod.POST)
	public ModelAndView deleteItem(HttpServletRequest request, HttpServletResponse response)
    {
        String itemId = request.getParameter("selected_itemId");
        Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
    	ShoppingcartItem toDeleteItem = shoppingcartItemManager.getById(Integer.valueOf(itemId));
        if (cookie != null&&toDeleteItem!=null)
        {	
            shoppingcartManager.doDeleteItem(cookie.getValue(), itemId, request,response);
            saveMessage(Message.info("shoppingcart.removedProductFormCart",toDeleteItem.getProductSku().getProduct().getProductName()));
        }
        return defaultAction(request, response);
    }

    @RequestMapping(params="doAction=clearShoppingcart", method=RequestMethod.POST)
	public ModelAndView clearShoppingcart(HttpServletRequest request, HttpServletResponse response)
    {
        Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
        if (cookie != null)
        {
            shoppingcartManager.doClearShoppingcart(cookie.getValue(), request,response);
        }
        return defaultAction(request, response);
    }

    @RequestMapping(params="doAction=clearFavorite", method=RequestMethod.POST)
	public ModelAndView clearFavorite(HttpServletRequest request, HttpServletResponse response)
    {
        Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
        if (cookie != null)
        {
            shoppingcartManager.doClearFavorite(cookie.getValue(), request,response);
        }
        return defaultAction(request, response);
    }
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
    @RequestMapping(params="doAction=updateShoppingcartItem", method=RequestMethod.POST)
	public ModelAndView updateShoppingcartItem(HttpServletRequest request, HttpServletResponse response)
    {
	    String[] itemIds = request.getParameterValues("buyNowItemId");
        for (String itemId : itemIds)
        {
            String sku = request.getParameter(itemId + "_sku");
            String quantity = request.getParameter(itemId+"_quantity");
            if (!empty(quantity) && item_quantity_pattern.matcher(quantity).matches())
            {
                Product product = CatalogHelper.getInstance().getProductSkuByCode(sku).getProduct();
                Integer minOrderQty = product.getMinOrderQuantity();
                Integer qty = new Integer(quantity);
                if (minOrderQty == null || qty >= minOrderQty)
                {
                    boolean pass=shoppingcartManager.updateShoppingcartItem(itemId, sku, qty, request, response);
                    if(!pass){
                    	SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
                    	saveMessage(Message.error("shoppingcartItem.error.qty.adjusted.maximun", product.getProductName()));
                    }
                }
                else
                {
                    SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
                	saveMessage(Message.error("shoppingcartItem.error.qty.must.max", product.getProductName(),minOrderQty));
                    break;
                }
            }
            else
            {
                SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
                saveMessage(Message.error("shoppingcartItem.cannotUpdate_quantityError"));
                break;
            }
        }
        return defaultAction(request, response);
    }

    
    
    /**
     * 功能:有优惠劵使用
     * <p>作者 杨荣忠 2015-5-18 下午02:20:31
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params="doAction=useCoupon", method=RequestMethod.POST)
	public ModelAndView useCoupon(HttpServletRequest request, HttpServletResponse response)
    {
    	AjaxView ajaxView = new AjaxView(response);
	    String no = request.getParameter("couponNo_input_name");
        Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
        if (cookie != null)
        {
            short result = shoppingcartManager.doUseCoupon(no, cookie.getValue());
            /*if (result != Coupon.STATE_VALID)
            {
                //设置错误信息.
                SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
            }
            if(result==Coupon.STATE_INVALID){
            	saveMessage(Message.error("shoppingcart.coupon_STATE_INVALID"));
            }
            else if(result==Coupon.STATE_INVALID_NOT_ACTIVE){
            	saveMessage(Message.error("shoppingcart.coupon_STATE_INVALID_NOT_ACTIVE"));
            }
            else if(result==Coupon.STATE_INVALID_IS_END){
            	saveMessage(Message.error("shoppingcart.coupon_STATE_INVALID_IS_END"));
            }
            else if(result==Coupon.STATE_INVALID_NOT_START){
            	saveMessage(Message.error("shoppingcart.coupon_STATE_INVALID_NOT_START"));
            }
            else if(result==Coupon.STATE_INVALID_REMAINEDTIMES_IS_ZERO){
            	saveMessage(Message.error("shoppingcart.coupon_STATE_INVALID_REMAINEDTIMES_IS_ZERO"));
            }
            else */
            if(result == Coupon.STATE_VALID){
        		Shoppingcart shoppingcart = null;
        		String sUuid = "";
        		if(cookie!=null){//进入购物车页面时，假如cookie中没有购物车uuid，则初始化一辆购物车给用户
        		    sUuid = cookie.getValue();
        		    Shoppingcart cart =  shoppingcartManager.loadShoppingcartByUuid(sUuid);
        		    BigDecimal dis_mem = cart.getCartDiscountAmount();
        		    
        		    shoppingcart = shoppingcartManager.refreshCart(sUuid, request, response);
        		    ajaxView.setData(shoppingcart.getCartDiscountAmount());
        		    
        		    shoppingcart.setCartDiscountAmount(shoppingcart.getCartDiscountAmount().add(dis_mem));
        		    
        		    shoppingcartManager.save(shoppingcart);
        		}
            }else{
            	Shoppingcart shoppingcart = null;
            	shoppingcartManager.doNotUseCoupon(cookie.getValue());
            	shoppingcart = shoppingcartManager.refreshCart(cookie.getValue(), request, response);
            	ajaxView.setData(new BigDecimal(0).setScale(2));
            	ajaxView.setMsg("此优惠劵无效！");
            }
            ajaxView.setStatus(result);
        }
        return ajaxView;
    }

    
    /**
     * 功能:无优惠劵使用
     * <p>作者 杨荣忠 2015-5-18 下午02:19:58
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params="doAction=notuseCoupon", method=RequestMethod.POST)
	public ModelAndView notuseCoupon(HttpServletRequest request, HttpServletResponse response)
    {
        Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
        if (cookie != null)
        {
            shoppingcartManager.doNotUseCoupon(cookie.getValue());
        }
        //return defaultAction(request, response);
        AjaxView ajaxView = new AjaxView(response);
        ajaxView.setData(0);
        return ajaxView;
    }
	
	// ------ 以下是 ajax调用的 ---//
	/**
	 * 添加产品到favorite
	 * 需要的参数有
	 * quantity 数量,必需
	 * productsku sku,必需
	 * accessoryIds 附件,可选
	 */
    @RequestMapping(params="doAction=addProductToFavorite", method=RequestMethod.POST)
	public ModelAndView addProductToFavorite(HttpServletRequest request,HttpServletResponse response) throws Exception
    {
	    String quantity = request.getParameter("quantity");
	    String productsku = request.getParameter("productsku");
        if(!empty(quantity) && !empty(productsku))
        {
            String cartUuid = "";
            String accessoryIds = request.getParameter("accessoryIds");
            if(!RequestContext.isAnonymousUser())
            {
                Shoppingcart cart = ShoppingCartUtil.getInstance().getCurrentUserShoppingcart();
                if(cart != null)
                   cartUuid = cart.getUuid();
             }
            shoppingcartManager.addProductToFavorite(cartUuid, productsku, new Integer(quantity), accessoryIds, request, response);
        }
        PrintWriter out = response.getWriter();
        out.println("ok");
        return null;
    }
	
	/**
     * 添加复合产品到购物车中
     * @param request
     * @param response
     * @param parensku
     *        主产品sku
     * @param childrenskus
     *        子产品，以英文,隔开
     * @param quantity
     *         数量
     * @param isSaved
     *         true 放入收藏夹；false  放入购物车
     * @return
     */
    @RequestMapping(params="doAction=addMultiProductToCart", method=RequestMethod.POST)
    public ModelAndView addMultiProductToCart(HttpServletRequest request,HttpServletResponse response) throws Exception
    {
        
        String result = "ok";
        String quantity = request.getParameter("quantity");
        String productsku = request.getParameter("productsku");
        
        if(!empty(quantity) && !empty(productsku))
        {
            String cartUuid = "";
            if(RequestContext.isAnonymousUser()){
                Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
                if(cookie != null)
                    cartUuid = cookie.getValue();
            }
            else{
                Shoppingcart cart = ShoppingCartUtil.getInstance().getCurrentUserShoppingcart();
                if(cart == null){
                    cartUuid = "";
                }
                else{
                    cartUuid = cart.getUuid();
                }
            }
            String childrenskus = request.getParameter("childrenskus");
            String accessoryIds = request.getParameter("accessoryIds");
            boolean isSaved = request.getParameter("isSaved")!= null && request.getParameter("isSaved").equals("true");            
            String[] children = childrenskus.split(",");
            try{
                shoppingcartManager.addMultiProductToCart(cartUuid, productsku, children, new Integer(quantity), accessoryIds, isSaved?ShoppingcartItem.ISSAVED_YES:ShoppingcartItem.ISSAVED_NO, request, response);
            }catch(Exception e){
                result = e.getMessage();
            }
        }
        PrintWriter out = response.getWriter();
        out.println(result);
        return null;
    }
    
    /**
     * 添加单一的产品到购物车中
     * @param request
     * @param response
     * @param productCode   product code
     * @param quantity
     * @param accessoryIds 附件的ID
     * @return
     */
    @RequestMapping(params="doAction=addProductToCart", method=RequestMethod.POST)
    public ModelAndView addProductToCart(HttpServletRequest request,HttpServletResponse response) throws Exception
    {
    	String method=ServletRequestUtils.getStringParameter(request, "method","ajax");
    	AddToCartResult addToCartResult=new AddToCartResult();
		Integer quantity=ServletRequestUtils.getIntParameter(request,"quantity",1);
        String productsku = request.getParameter("productsku");
		String result = "ok";
        if(!empty(productsku))
        {
            String cartUuid = "";
            if(RequestContext.isAnonymousUser()){
                Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
                if(cookie != null)
                    cartUuid = cookie.getValue();
            }
            else{
                Shoppingcart cart = ShoppingCartUtil.getInstance().getCurrentUserShoppingcart();
                if(cart!=null)
                    cartUuid = cart.getUuid();
            }
            String accessoryIds = request.getParameter("accessoryIds");
            String customMade=getCustomMadeString(request);
            try{
                Shoppingcart cart=shoppingcartManager.addProductToCart(cartUuid, productsku, new Integer(quantity), accessoryIds,customMade, request, response);
            	//设置最后添加该产品入购物车的信息
                setLastAddToCartItemInfo(addToCartResult, cart, productsku, new Integer(quantity));
                if(method.equals("ajax")){
                    addToCartResult.setMessage("ok");
                    addToCartResult.setResult(new Short("1"));
                }else{
                	//提示产品成功添加入购物车
                	saveMessage(Message.info("shoppingcart.addedProductToCart",addToCartResult.getLastAddToCartItemName()));
                }
            }catch(Exception e){
                addToCartResult.setMessage(e.getMessage());
                addToCartResult.setResult(new Short("0"));
                result = e.getMessage();
            }
        }
        if(method.equals("ajax")){
        	JSONObject data=JSONObject.fromObject(addToCartResult);
            PrintWriter out = response.getWriter();
            out.println(data);
            return null;
        }else{
        	//TODO 信息提示
    		if(result.equals("ok")){
    			return getRedirectView("/cart/shoppingcart.html");
    		}else{
    			if(result.equals(CheckoutConstants.CANNOTMOVE_C_NOINVENTORY)){
    				saveMessage(Message.error("shoppingcartItem.cannotMove_stockNotEnough"));
    			}else if(result.equals(CheckoutConstants.CANNOTMOVE_C_NOINVENTORY_NOMORE)){
    				saveMessage(Message.error("shoppingcartItem.cannotUpdate_noMoreInventory"));
    			}
    			return defaultAction(request, response);
    		}
        }
        
    }
    
  
    
    private String getCustomMadeString(HttpServletRequest request){
    	JSONObject obj = null;
    	Enumeration<String> parameterNames=request.getParameterNames();
    	while (parameterNames.hasMoreElements()) {
			String parameterName = (String) parameterNames.nextElement();
			if(parameterName.startsWith("customMade_")){
				if(obj==null){
					obj=new JSONObject();
				}
				String parameterValue=request.getParameter(parameterName);
				parameterName=parameterName.substring("customMade_".length());
				parameterName=parameterName.replaceAll("_"," ");
				obj.put(parameterName, parameterValue);
			}
		}
    	if(obj==null){
    		return "";
    	}else{
    		return obj.toString();
    	}
    }
    
    private void setLastAddToCartItemInfo(AddToCartResult addToCartResult,Shoppingcart cart,String skuCode,Integer lastAddToCartQty){
    	ShoppingcartItem lastAddToCartItem=null;
    	Set<ShoppingcartItem> shoppingcartItems=cart.getShoppingCartItems();
    	for (ShoppingcartItem shoppingcartItem : shoppingcartItems) {
			if(shoppingcartItem.getIsSaved().intValue()==Constants.FLAG_FALSE.intValue()&&shoppingcartItem.getParent()==null){
				if(skuCode.equals(shoppingcartItem.getProductSku().getProductSkuCode())){
					lastAddToCartItem=shoppingcartItem;
					break;
				}
			}
		}
    	if(lastAddToCartItem!=null){
    		addToCartResult.setLastAddToCartItemName(lastAddToCartItem.getProductSku().getProduct().getProductName());
    		addToCartResult.setLastAddToCartItemPrice(lastAddToCartItem.getDiscountPrice());
    		addToCartResult.setLastAddToCartItemQty(lastAddToCartQty);
    		addToCartResult.setLastAddToCartItemImage(lastAddToCartItem.getProductSku().getImage());
    		addToCartResult.setLastAddToCartItemQty(lastAddToCartQty);
    		addToCartResult.setCartItemQty(cart.getBuyNowItemsCount());
    		addToCartResult.setTotal(cart.getSubtotal());
    	}
    }
    
    /**
     * 刷新shoppingCart
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    /*public ModelAndView refresh(HttpServletRequest request,HttpServletResponse response) throws Exception
    {
        String cartUuid = "";
        if(RequestContext.isAnonymousUser()){
            Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
            if(cookie != null)
                cartUuid = cookie.getValue();
        }
        else{
            Shoppingcart cart = ShoppingCartUtil.getInstance().getCurrentUserShoppingcart();
            if(cart!=null)
                cartUuid = cart.getUuid();
        }
        shoppingcartManager.refreshCart(cartUuid, request, response);
        PrintWriter out = response.getWriter();
        out.println("ok");
        return null;
    }*/
	
	// ----------------------------- manager class setting methods ---------------------------------------
	public void setShoppingcartManager(ShoppingcartManager shoppingcartManager) {
		this.shoppingcartManager = shoppingcartManager;
	}
	public void setPromoService(PromoService promoService) {
        this.promoService = promoService;
    }

    @RequestMapping(params="doAction=estimateShippingCosts", method=RequestMethod.GET)
	public ModelAndView estimateShippingCosts(HttpServletRequest request, HttpServletResponse response){
		CheckoutPagingModel checkoutPagingModel=CheckoutUtil.getInstance().getCheckoutPagingModel(request);
		Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
		Shoppingcart shoppingcart = null;
		String sUuid = "";
		if(cookie!=null){//进入购物车页面时，假如cookie中没有购物车uuid，则初始化一辆购物车给用户
		    sUuid = cookie.getValue();
		    shoppingcart = shoppingcartManager.refreshCart(sUuid, request, response);
		    if(shoppingcart==null){
		    	Customer customer = (Customer) RequestContext.getCurrentUser();
		    	shoppingcart = shoppingcartManager.initShoppingcart(customer);
		    }
		}
		else{
			Customer customer = (Customer) RequestContext.getCurrentUser();
			shoppingcart = shoppingcartManager.initShoppingcart(customer);
		}
		request.setAttribute("shoppingcart", shoppingcart);
		Address shippingAddress=null;
		if(StringUtils.isNotBlank(request.getParameter("addressId"))){
			checkoutPagingModel.setShippingAddressId(new Integer(request.getParameter("addressId")));
			shippingAddress=addressManager.getById(checkoutPagingModel.getShippingAddressId());
		}
		if(StringUtils.isNotBlank(request.getParameter("countryId"))){
			checkoutPagingModel.setCountryId(new Integer(request.getParameter("countryId")));
			shippingAddress=new Address();
			shippingAddress.setCountryId(checkoutPagingModel.getCountryId());
		}
		if(shippingAddress==null){
			//默认设置上美国
			shippingAddress=new Address();
			shippingAddress.setCountryId(24459);
			checkoutPagingModel.setCountryId(checkoutPagingModel.getCountryId());
		}
		List<ShippingRate> shippingRateList=CheckoutUtil.getInstance().statCartShipping(shippingAddress, shoppingcart);
		request.setAttribute("shippingRateList",shippingRateList);
		return new ModelAndView("/cart/estimateShippingCostsShippingRate");
	}

	public CategoryManager getCategoryManager() {
		return categoryManager;
	}

	public void setCategoryManager(CategoryManager categoryManager) {
		this.categoryManager = categoryManager;
	}

	public ProductCategoryManager getProductCategoryManager() {
		return productCategoryManager;
	}

	public void setProductCategoryManager(
			ProductCategoryManager productCategoryManager) {
		this.productCategoryManager = productCategoryManager;
	}
}