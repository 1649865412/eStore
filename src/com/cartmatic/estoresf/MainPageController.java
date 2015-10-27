
package com.cartmatic.estoresf;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.beantool.ShopCartValueModel;
import com.cartmatic.estore.cart.CheckoutConstants;
import com.cartmatic.estore.cart.service.ShoppingcartManager;
import com.cartmatic.estore.cart.util.ShoppingCartUtil;
import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.model.cart.Shoppingcart;
import com.cartmatic.estore.common.model.cart.ShoppingcartItem;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductSku;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.system.AppUser;
import com.cartmatic.estore.common.service.ShoppingcartService;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.util.ContextUtil;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;

@Controller
public class MainPageController{
	private SolrService solrService = null;
	private ProductManager productManager=null;
	private BrandManager brandManager = null;
	private ShoppingcartManager shoppingcartManager = null;
	private AppUserManager	appUserManager	= null;
	@Autowired
	private ShoppingcartService shoppingcartService=null;
	
	private PasswordEncoder passwordEncoder;

	public void setAppUserManager(AppUserManager appUserManager) {
		this.appUserManager = appUserManager;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}


	@RequestMapping("/index.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		ModelAndView mav = new ModelAndView("index");
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
		mav.addObject("shoppingcart", shoppingcart);
		List<Brand> brandList=brandManager.getAllOrdered("sortOrder", true);
		mav.addObject("brandList", brandList);
/*		Cookie cookie = RequestUtil.getCookie(request, "IS_RUSH");
		if(cookie == null){
			request.setAttribute("isRush", 0);
			RequestUtil.setCookie(response, "IS_RUSH", "yes", request.getContextPath());
		}*/
		return mav;
	}
	
	
	
	@RequestMapping("/index_check.html")
	public void index_check(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String url =request.getParameter("papeurl");
   try{
		//此处判断是不是登录成功
		if(checkAppUser(request,response)){
			//可继续写其它代码，例如购物车与用户cookie  
			Cookie cookie = RequestUtil.getCookie(request, CheckoutConstants.SHOPPINGCART_COOKIE);
			Shoppingcart shoppingcart = null;
			String sUuid = "";
			if(cookie!=null){//进入购物车页面时，假如cookie中没有购物车uuid，则初始化一辆购物车给用户
			    sUuid = cookie.getValue();
//			    shoppingcart = shoppingcartManager.loadShoppingcartByUuid(sUuid);
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
			request.setAttribute("shoppingcart",shoppingcart);
				Customer appUser = (Customer) appUserManager.getUserByName(request.getParameter("j_username"));
				RequestUtil.setUserInfoCookie(response, appUser, (request).getContextPath());
		}else{
					RequestUtil.setErrorResultCookie(response, "error", "0",(request).getContextPath());
					RequestUtil.setErrorResultCookie(response, "tag", "0",(request).getContextPath());
		}
   }
	   catch(Exception e){
			response.sendRedirect(url);
	   }
		response.sendRedirect(url);
	}
	
	
	
	/**
	 * 异步判断用户是否登陆，true为登陆,false为未登录
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/ajaxCheckUser.html")
	public ModelAndView ajaxCheckUser(HttpServletRequest request,
			HttpServletResponse response) {
		//AppUser appUser = (AppUser) RequestContext.getCurrentUser();
		boolean  flag =false;
		if(checkAppUser(request,response)){
			flag =true;
		}
		Customer customer = (Customer) appUserManager.getUserByName(request.getParameter("j_username"));
		Shoppingcart shoppingcart = ShoppingCartUtil.getInstance().getCurrentUserShoppingcart(customer);
		Map map = new HashMap();
		map.put("flag", flag);
		AjaxView ajaxView = new AjaxView(response);
		//map.put("shopCartValueModelList", shopCartValueModelList);
	   List<ShopCartValueModel> shopCartValueModelList = ChangeShopCartValue(shoppingcart );
	   map.put("shopCartValueModelList", shopCartValueModelList);
		
	   JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONObject json = JSONObject.fromObject(map,jsonConfig); 
		String result = json.toString();
		//System.out.print(result);
		ajaxView.setData(result);
		return ajaxView;
	}
	
	
	public List<ShopCartValueModel> ChangeShopCartValue(Shoppingcart shoppingcart ){
		Set<ShoppingcartItem> shoppingCartItems =shoppingcart.getCartItems();
		List<ShopCartValueModel> shopCartValueModelList = new ArrayList<ShopCartValueModel>();
		ShopCartValueModel shopCartValueModel =new ShopCartValueModel();
		Integer buyNowItemsCount = shoppingcart.getBuyNowItemsCount();
		shopCartValueModel.setBuyNowItemsCount(buyNowItemsCount);
		BigDecimal subtotal = shoppingcart.getSubtotal();
		shopCartValueModel.setSubtotal(subtotal);
		shopCartValueModelList.add(shopCartValueModel);
		for(ShoppingcartItem item : shoppingCartItems){
			ShopCartValueModel shopCartValueModel2 =new ShopCartValueModel();
			ProductSku productSku = item.getProductSku();
			Short isSaved = item.getIsSaved();
			shopCartValueModel2.setIsSaved(isSaved);
			ShoppingcartItem parent = item.getParent();
			Product product = productSku.getProduct();
			String productName = product.getProductName();
			shopCartValueModel2.setProductName(productName);
			String brandName = product.getBrand().getBrandName();
			shopCartValueModel2.setBrandName(brandName);
			BigDecimal price = item.getPrice();
			shopCartValueModel2.setPrice(price);
			String image = productSku.getImage();
			shopCartValueModel2.setImage(image);
			
			shopCartValueModelList.add(shopCartValueModel2);
		}
		
		
		return shopCartValueModelList;
		
	}
	
	
	@RequestMapping(value="/login_Error.html")
	public void loginError(HttpServletRequest req,HttpServletResponse resp) throws ServletException {
		try {
			String url =req.getParameter("url");
			if (ContextUtil.isStoreFront()) {
				req.setAttribute("error", 0);
				req.setAttribute("tag", 0);
			//	resp.sendRedirect("http://localhost:8080/MarketIndex.html");
				req.getRequestDispatcher("/MarketIndex.html").forward(req, resp);
			//	req.getRequestDispatcher("http://localhost:8080/MarketIndex.html").forward(req, resp);
			} else {
				req.getRequestDispatcher(url+"?error=1&tag=0").forward(req, resp);
			}
		} catch (Throwable ex) {
			//logger.error("Cannot forward to error login page: " + targetUrl, ex);
		}
	}
	
	@RequestMapping(value="/coming.html")
	public ModelAndView coming(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("coming");
		return mv;
	}
	
	
	
	  public boolean checkAppUser(HttpServletRequest request,HttpServletResponse response)
		{
			AppUser appUser = appUserManager.getUserByName(request.getParameter("j_username"));
			boolean tag = false;
			if(appUser!=null){
				String oldPassword = passwordEncoder.encodePassword(request.getParameter("j_password"), null);
				boolean isOldPasswordRight = appUserManager.getIsPasswordRight(appUser.getAppuserId(), oldPassword);
				if(isOldPasswordRight==true){
					//此处判断是不是登录成功
					tag = true;
					//可继续写其它代码，例如购物车与用户cookie
					Authentication authRequest = new UsernamePasswordAuthenticationToken(request.getParameter("j_username"), request.getParameter("j_password"));
					SecurityContext securityContext = SecurityContextHolder
							.getContext();
					if (securityContext != null) {
						securityContext.setAuthentication(authRequest);
					}
					Customer customer = (Customer) appUserManager.getUserByName(request.getParameter("j_username"));
					RequestUtil.setUserInfoCookie(response, customer,(request).getContextPath());
					//合并购物车信息
					ShoppingCartUtil.getInstance().setShoppingcartInfo(request, response, customer);
				}
			}
			return tag;
		}
	

	public void setShoppingcartManager(ShoppingcartManager shoppingcartManager) {
		this.shoppingcartManager = shoppingcartManager;
	}

	public void setSolrService(SolrService solrService) {
		this.solrService = solrService;
	}
	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}

	public void setBrandManager(BrandManager brandManager) {
		this.brandManager = brandManager;
	}
	
}
