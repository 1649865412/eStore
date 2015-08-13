package com.cartmatic.estoresf.market.action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.catalog.service.CatalogManager;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.catalog.Catalog;



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
		ModelAndView mav = new ModelAndView("Marketindex");
		//Store store=ConfigUtil.getInstance().getStore();
		Catalog tempCatalog=catalogManager.getByCode("default");
		Brand brand = brandManager.getById(tempCatalog.getBrandId());
		mav.addObject("brand", brand);
		return mav;
	}
	
    
}
