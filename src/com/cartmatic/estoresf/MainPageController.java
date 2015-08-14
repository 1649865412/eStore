
package com.cartmatic.estoresf;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.cart.CheckoutConstants;
import com.cartmatic.estore.cart.service.ShoppingcartManager;
import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.model.cart.Shoppingcart;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.system.AppUser;
import com.cartmatic.estore.common.service.SolrService;
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
	
	private PasswordEncoder passwordEncoder;

	public AppUserManager getAppUserManager() {
		return appUserManager;
	}


	public void setAppUserManager(AppUserManager appUserManager) {
		this.appUserManager = appUserManager;
	}


	public PasswordEncoder getPasswordEncoder() {
		return passwordEncoder;
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
		List<Brand> brandList=brandManager.findAllBrands();
		mav.addObject("brandList", brandList);
/*		Cookie cookie = RequestUtil.getCookie(request, "IS_RUSH");
		if(cookie == null){
			request.setAttribute("isRush", 0);
			RequestUtil.setCookie(response, "IS_RUSH", "yes", request.getContextPath());
		}*/
		return mav;
	}
	
	
	@RequestMapping("/index_check/*.html")
	public void index_check(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.print(request.getParameter("papeurl"));
		String url =request.getParameter("papeurl");
		response.sendRedirect(url);
	}
	
	   public boolean checkAppUser(HttpServletRequest request)
		{
			AppUser appUser = appUserManager.getUserByName(request.getParameter("eamil"));
			boolean tag = false;
			if(appUser!=null){
				String oldPassword = passwordEncoder.encodePassword(request.getParameter("password"), null);
				boolean isOldPasswordRight = appUserManager.getIsPasswordRight(appUser.getAppuserId(), oldPassword);
				if(isOldPasswordRight==true){
					//此处判断是不是登录成功
					tag = true;
					//可继续写其它代码，例如购物车与用户cookie
				}
			}
			return tag;
		}
	
	
	public ShoppingcartManager getShoppingcartManager() {
		return shoppingcartManager;
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
