
package com.cartmatic.estoresf;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.webapp.util.RequestUtil;

@Controller
public class MainPageController{
	private SolrService solrService = null;
	private ProductManager productManager=null;
	private BrandManager brandManager = null;

	@RequestMapping("/index.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		ModelAndView mav = new ModelAndView("index");
		List<Brand> brandList=brandManager.findAllBrands();
		mav.addObject("brandList", brandList);
/*		Cookie cookie = RequestUtil.getCookie(request, "IS_RUSH");
		if(cookie == null){
			request.setAttribute("isRush", 0);
			RequestUtil.setCookie(response, "IS_RUSH", "yes", request.getContextPath());
		}*/
		return mav;
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
