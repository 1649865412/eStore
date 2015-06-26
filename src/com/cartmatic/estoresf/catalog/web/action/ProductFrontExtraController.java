package com.cartmatic.estoresf.catalog.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.ProductMainManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.SearchProductModel;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.textsearch.model.SearchResult;
import com.cartmatic.estore.textsearch.query.QueryCriteria;

@Controller
public class ProductFrontExtraController extends GenericStoreFrontController<Product>{

	private ProductManager			productManager			= null;
	private ProductMainManager productMainManager=null;

	private SolrService solrService=null;
	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr = productManager;
	}
	
	public void setSolrService(SolrService solrService) {
		this.solrService = solrService;
	}
	
	/*@RequestMapping(value="/catalog/compare.html")
	private ModelAndView productCompare(HttpServletRequest request,
			HttpServletResponse response) {
		Integer productIds[]=RequestUtil.getIntegerArrayNullSafe(request, "productId");
		ProductCompareModel productCompareModel=productMainManager.getProductCompareModelForFront(productIds);
		ModelAndView mv = getModelAndView("catalog/compareResults");
		mv.addObject("productCompareModel",productCompareModel);
		return mv;
	}*/
	
	/*@RequestMapping(value="/catalog/emailYourFried.html")
	private ModelAndView emailYourFried(HttpServletRequest request,HttpServletResponse response) {
		Integer productId=RequestUtil.getInteger(request, "productId");
		Integer categoryId=RequestUtil.getInteger(request, "categoryId");
		Product product = this.productManager.getById(productId);
		String linkUrl=CatalogHelper.getInstance().getProductUrl(product, categoryId);
		ModelAndView mv = getModelAndView("catalog/emailYourFriends");
		AppUser appUser = (AppUser)RequestContext.getCurrentUser();
		mv.addObject("AppUser", appUser);
		mv.addObject("product", product);
		mv.addObject("LinkUrl", linkUrl);
		return mv;
	}
	*/
	

   /* @RequestMapping(value="/catalog/feedback.html")
	private ModelAndView feedback(HttpServletRequest request,HttpServletResponse response) {
		Integer productId=RequestUtil.getInteger(request, "productId");
		ModelAndView mv = getModelAndView("catalog/feedbackForm");
		Feedback feedback = new Feedback();
		feedback.setProductId(productId);
		AppUser appUser = (AppUser)RequestContext.getCurrentUser();
		mv.addObject("productId", productId);
		mv.addObject("appUser", appUser);
		mv.addObject("feedback", feedback);
		return mv;
	}*/
	
    @RequestMapping(value="/catalog/categoryPorductsJson.html")
	public ModelAndView categoryPorductsJson(HttpServletRequest request,HttpServletResponse response) {
    	AjaxView ajaxView = new AjaxView(response);
		Integer categoryId=ServletRequestUtils.getIntParameter(request, "categoryId",0);
		Integer pageSize=ServletRequestUtils.getIntParameter(request, "pageSize",10);
		Integer pageNo=ServletRequestUtils.getIntParameter(request, "pageNo",1);
		String sort=ServletRequestUtils.getStringParameter(request, "sort", "");
		SearchResult searchResult=solrService.queryProductByCategory(request,categoryId,pageSize,pageNo,sort);
		List<SearchProductModel> searchProductModel = searchResult.getResultList();
		
		//paging
		QueryCriteria sc=(QueryCriteria)request.getAttribute("sc");
		JSONObject paging=new JSONObject();
		paging.put("pageCount", sc.getPageCount());
		paging.put("pageNo", sc.getPageNo());
		paging.put("pageSize", pageSize);
		paging.put("totalCount", sc.getTotalCount());

		Map<String, Object>data=new HashMap<String, Object>();
		data.put("paging", paging);
		data.put("productList", searchProductModel);
		ajaxView.setData(data);
		return ajaxView;
	}
	
	
	
	public void setProductMainManager(ProductMainManager productMainManager) {
		this.productMainManager = productMainManager;
	}

	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}

}
