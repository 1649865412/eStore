package com.cartmatic.estoresf.market.action;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.cart.CheckoutConstants;
import com.cartmatic.estore.cart.service.ShoppingcartManager;
import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.common.model.cart.Shoppingcart;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.sekillproduct.service.SekillProductManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.extend.catalog.util.CharacterSort;

/**
 * 商场设计师模块controller <code>MarketBrandFrontController.java</code>
 * <p>
 * <p>
 * Copyright 2015 All right reserved.
 * 
 * @author admin 时间 2015-8-12 下午05:23:49
 * @version 1.0 </br>最后修改人 无
 */
@Controller
public class MarketBrandFrontController extends
		GenericStoreFrontController<Brand> {

	private BrandManager brandManager = null;

	public ShoppingcartManager getShoppingcartManager() {
		return shoppingcartManager;
	}

	public void setShoppingcartManager(ShoppingcartManager shoppingcartManager) {
		this.shoppingcartManager = shoppingcartManager;
	}

	private ShoppingcartManager shoppingcartManager = null;

	public void setBrandManager(BrandManager inMgr) {
		this.brandManager = inMgr;
	}

	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr = brandManager;
		setCacheSecondsConfigurable(true);
	}

	/**
	 * 商城设计师列表页
	 */
	@Override
	@RequestMapping(value = "/marketDesignerList/index.html")
	public ModelAndView defaultAction(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.print("url:" + request.getContextPath());
		System.out.print("url2:" + request.getServletPath());

		ModelAndView mv = new ModelAndView("designer/marketDesignerList");
		List<Brand> brandList = brandManager.findAllBrands();
		mv.addObject("mapResult", CharacterSort.listBrandSort(brandList));
		// mv.addObject("brandList", brandList);
		RequestUtil.getShopCart(request, response, mv, shoppingcartManager);
		Cookie cookie = RequestUtil.getCookie(request,
				CheckoutConstants.SHOPPINGCART_COOKIE);
		Shoppingcart shoppingcart = null;
		String sUuid = "";
		if (cookie != null) {// 进入购物车页面时，假如cookie中没有购物车uuid，则初始化一辆购物车给用户
			sUuid = cookie.getValue();
			// shoppingcart = shoppingcartManager.loadShoppingcartByUuid(sUuid);
			shoppingcartManager.doNotUseCoupon(sUuid);
			shoppingcart = shoppingcartManager.refreshCart(sUuid, request,
					response);
			if (shoppingcart == null) {
				Customer customer = (Customer) RequestContext.getCurrentUser();
				shoppingcart = shoppingcartManager.initShoppingcart(customer);
			}
		} else {
			Customer customer = (Customer) RequestContext.getCurrentUser();
			shoppingcart = shoppingcartManager.initShoppingcart(customer);
		}
		mv.addObject("shoppingcart", shoppingcart);
		return mv;
	}

	/**
	 * 商城设计师列表页字母筛选
	 */
	@RequestMapping(value = "/marketDesigner/initialsSelect.html")
	public ModelAndView initialsSelect(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("designer/marketDesignerList");
		RequestUtil.getShopCart(request, response, mv, shoppingcartManager);
		String initials = request.getParameter("initials");
		List<Brand> brandList = brandManager.findByProperty("initials",
				initials);
		mv.addObject("mapResult", CharacterSort.listBrandSort(brandList));
		return mv;
	}

	/**
	 * 功能:商城设计师模块详情页
	 * <p>
	 * 作者 杨荣忠 2015-6-19 下午05:02:34
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/marketDesigner_Service/marketDesigner_datial.html")
	public ModelAndView marketDesignerDatialAction(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("catalog/marketDesigner");
		RequestUtil.getShopCart(request, response, mv, shoppingcartManager);
		String brandID = request.getParameter("brandID");
		Brand brand = brandManager.getById(Integer.parseInt(brandID));
		mv.addObject("brand", brand);
		return mv;
	}

	/**
	 * 功能:商城设计师模块搜索页，支持商城设计师名字与商城设计师品牌的模糊查询
	 * <p>
	 * 作者 杨荣忠 2015-6-19 下午05:02:34
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/marketDesigner_Service/search.html")
	public ModelAndView searchAction(HttpServletRequest request,
			HttpServletResponse response, String q) {
		ModelAndView mv = new ModelAndView("designer/marketDesignerList");
		RequestUtil.getShopCart(request, response, mv, shoppingcartManager);
		List<Brand> result = brandManager.getSearch(q);
		mv.addObject("mapResult", CharacterSort.listBrandSort(result));
		return mv;
	}

}
