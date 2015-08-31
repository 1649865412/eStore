package com.cartmatic.estoresf.market.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.catalog.service.CatalogManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.catalog.Catalog;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.sales.RecommendedType;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.sales.service.EvalRecommendationManager;
import com.cartmatic.estore.sales.service.RecommendedProductManager;
import com.cartmatic.estore.sales.service.RecommendedTypeManager;
import com.cartmatic.estore.webapp.util.RequestUtil;



/**
 *  二版商场index首页数据组织
 *  <code>CulturalinformationFrontController.java</code>
 *  <p>
 *  <p>Copyright  2015 All right reserved.
 *  @author admin 时间 2015-6-8 下午02:19:51	
 *  @version 1.0 
 *  </br>最后修改人 无
 */
@Controller
public class MarketIndexFrontControler
{
	
	private BrandManager brandManager = null;
	
	private CatalogManager catalogManager = null;
	
	private ProductManager productManager = null;
	
	private RecommendedProductManager	recommendedProductManager = null;
	private RecommendedTypeManager		recommendedTypeManager = null;
	private EvalRecommendationManager	evalRecommendationManager = null;
	
	
	public RecommendedProductManager getRecommendedProductManager() {
		return recommendedProductManager;
	}


	public void setRecommendedProductManager(
			RecommendedProductManager recommendedProductManager) {
		this.recommendedProductManager = recommendedProductManager;
	}


	public RecommendedTypeManager getRecommendedTypeManager() {
		return recommendedTypeManager;
	}


	public void setRecommendedTypeManager(
			RecommendedTypeManager recommendedTypeManager) {
		this.recommendedTypeManager = recommendedTypeManager;
	}


	public EvalRecommendationManager getEvalRecommendationManager() {
		return evalRecommendationManager;
	}


	public void setEvalRecommendationManager(
			EvalRecommendationManager evalRecommendationManager) {
		this.evalRecommendationManager = evalRecommendationManager;
	}


	public ProductManager getProductManager() {
		return productManager;
	}


	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}


	public CatalogManager getCatalogManager()
	{
		return catalogManager;
	}


	public void setCatalogManager(CatalogManager catalogManager)
	{
		this.catalogManager = catalogManager;
	}


	public BrandManager getBrandManager()
	{
		return brandManager;
	}


	public void setBrandManager(BrandManager brandManager)
	{
		this.brandManager = brandManager;
	}


	/**
	 * 功能:商城首页跳转
	 * <p>作者 杨荣忠 2015-8-12 下午03:56:16
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 */
	@RequestMapping("/MarketIndex.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		ModelAndView mav = new ModelAndView("marketindex");
		//Store store=ConfigUtil.getInstance().getStore();
		Catalog tempCatalog=catalogManager.getByCode("default");
		mav.addObject("tempCatalog", tempCatalog);
		Brand brand = brandManager.getById(tempCatalog.getBrandId());
		mav.addObject("brand", brand);
		String recommendProductNum=brand.getProductRecommendId();
		List<Product> recommendProductList=productManager.getAllByIdArray(recommendProductNum);
		mav.addObject("recommendProductList", recommendProductList);
		return mav;
	}
	
	/**
	 * 每周主打产品列表页
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/weekly.html")
    public ModelAndView  weekly(HttpServletRequest request, HttpServletResponse response)	 
    {
    	ModelAndView mv=new ModelAndView("market/weekly");
    	Catalog tempCatalog=catalogManager.getByCode("default");
		mv.addObject("tempCatalog", tempCatalog);
        return mv;
    }
	
    
}
