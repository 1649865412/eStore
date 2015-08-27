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
		
		
		Store store=ConfigUtil.getInstance().getStore();
		String typeName = "hot_wholesale_products"; // 推荐类型
		String firstResultString = "0"; // 起始序号
		String maxResultsString = "8"; // 最大数量
		String sourceFormat = RequestUtil.getParameterNullSafe(request,
				"sourceFormat"); // 标示是用sourceId还是用sourceIds,默认用sourceId
		String sourceIdString = "1"; // sourceId 可以是categoryId 也可以是productId
		String sourceIdsString = RequestUtil.getParameterNullSafe(request,
				"sourceIds"); // sourceIds 可以是categoryIds 也可以是productIds
		// 由typeName决定
		//String template = RequestUtil.getParameterNullSafe(request, "template"); // 模板
		// ----------------------初始化参数 开始------------------------------//
		int firstResult;
		int maxResults;
		Integer sourceId;
		List<Integer> sourceIds = new ArrayList<Integer>();
		if (firstResultString.equals("")) {
			firstResult = 0;
		} else {
			firstResult = Integer.parseInt(firstResultString);
		}
		if (maxResultsString.equals("")) {
			maxResults = -1;
		} else {
			maxResults = Integer.parseInt(maxResultsString);
		}
		if (sourceIdString.equals("")) {
			sourceId = ConfigUtil.getInstance().getStore().getCatalog().getCategoryId();
		} else {
			sourceId = new Integer(sourceIdString);
		}
		if (sourceFormat.equals("list")) {
			if (!sourceIdsString.trim().equals("")) {
				String[] temps = sourceIdsString.split(",");
				for (String temp : temps) {
					sourceIds.add(new Integer(temp));
				}
			}
		}
		RecommendedType recommendedType = recommendedTypeManager
				.getRecommendedTypeByName(typeName);

		// ----------------------初始化参数 结束------------------------------//
		List<Product> list;
		if (!sourceFormat.equals("list")) {
		    if (Constants.FLAG_TRUE.equals(recommendedType.getIsApplyToCategory()))
		    { 
		        list = evalRecommendationManager.getProductsByRecommendedTypeNameByCategoryId(store,typeName, sourceId, firstResult, maxResults);
		    }
		    else
		    {
		        list = evalRecommendationManager.getProductsByRecommendedTypeNameByProductId(store,typeName, sourceId, firstResult, maxResults);
		    }
		} else {
			//目前只是做了AlsoBuy部分
			list = evalRecommendationManager.getProductsByRecommendedTypeNameBySourceIdList(store,typeName, sourceIds, firstResult, maxResults);
		}

		mav.addObject("productList", list);
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
