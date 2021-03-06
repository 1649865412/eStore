package com.cartmatic.estoresf.catalog.web.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.cart.service.ShoppingcartManager;
import com.cartmatic.estore.catalog.service.CategoryManager;
import com.cartmatic.estore.catalog.service.ProductMainManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Category;
import com.cartmatic.estore.common.model.catalog.CategoryTreeItem;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.SkuOption;
import com.cartmatic.estore.common.model.catalog.SkuOptionValue;
import com.cartmatic.estore.common.model.sekillproduct.SekillProduct;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.view.RedirectView301;
import com.cartmatic.estore.sekillproduct.service.SekillProductManager;
import com.cartmatic.estore.textsearch.model.SearchResult;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.estoresf.seckill.help.Constant;
import com.cartmatic.extend.catalog.util.ComparatorMapDown;
import com.cartmatic.extend.catalog.util.ComparatorMapNew;
import com.cartmatic.extend.catalog.util.ComparatorMapUp;

@Controller
public class CategoryFrontController extends
		GenericStoreFrontController<Category> {

	private ProductManager productManager = null;
	private CategoryManager categoryManager = null;
	private ProductMainManager productMainManager=null;
	private ShoppingcartManager shoppingcartManager = null;

	public ShoppingcartManager getShoppingcartManager() {
		return shoppingcartManager;
	}

	public void setShoppingcartManager(ShoppingcartManager shoppingcartManager) {
		this.shoppingcartManager = shoppingcartManager;
	}

	public ProductMainManager getProductMainManager() {
		return productMainManager;
	}

	public void setProductMainManager(ProductMainManager productMainManager) {
		this.productMainManager = productMainManager;
	}

	private SekillProductManager sekillProductManager = null;

	public void setSekillProductManager(
			SekillProductManager sekillProductManager) {
		this.sekillProductManager = sekillProductManager;
	}

	private SolrService solr = null;

	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr = categoryManager;
		setCacheSecondsConfigurable(true);
	}

	private ModelAndView getNotFoundView() {
		return getModelAndView("catalog/categoryErrorPage");
	}

	/**
	 * 产品列表页
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/**/*_catalog.html", "/**/*_catalog_pn*.html" })
	public ModelAndView defaultAction(HttpServletRequest request,
			HttpServletResponse response) {

		/*
		 * List<SekillProduct> sekillProductList =
		 * sekillProductManager.getAll();
		 * 
		 * List<SekillProduct> sekillProductListDay1 = new
		 * ArrayList<SekillProduct>();
		 * 
		 * List<SekillProduct> sekillProductListDay2 = new
		 * ArrayList<SekillProduct>();
		 * 
		 * List<SekillProduct> sekillProductListDay3 = new
		 * ArrayList<SekillProduct>();
		 * 
		 * List<SekillProduct> sekListAll = new ArrayList();
		 * 
		 * for (int i = 0; i < sekillProductList.size(); i++) { SekillProduct
		 * sekill = sekillProductList.get(i); String sekillTime =
		 * sekill.getSekillTime().toString(); if
		 * (sekillTime.equals(Constant.SEKILL_ONE_DAY)) {
		 * sekillProductListDay1.add(sekill); } else if
		 * (sekillTime.equals(Constant.SEKILL_TWO_DAY)) {
		 * sekillProductListDay2.add(sekill); } else if
		 * (sekillTime.equals(Constant.SEKILL_THRID_DAY)) {
		 * sekillProductListDay3.add(sekill); } }
		 * 
		 * SeckillTool.getStayDay( sekillProductListDay1, sekillProductListDay2,
		 * sekillProductListDay3);
		 * 
		 * sekListAll.addAll(sekillProductListDay1);
		 * sekListAll.addAll(sekillProductListDay2);
		 * sekListAll.addAll(sekillProductListDay3);
		 */

		String uri = request.getRequestURI();
		if (uri.contains("/aboutus/help")) {
			return new ModelAndView(new RedirectView(
					"/customer_service/_16.html"));
		}
		Store store = ConfigUtil.getInstance().getStore();

		CatalogHelper catalogHelper = CatalogHelper.getInstance();

		// CategoryTreeItem继承category
		CategoryTreeItem category = (CategoryTreeItem) catalogHelper
				.getProductCategoryByUri(uri);
		if (category == null) {
			String sort = request.getParameter("sort");
			List<Product> productList = productManager.getDefaultProduct(sort);
			String mv = "/market/marketList";
			ModelAndView modelAndView = getModelAndView(mv);
			modelAndView.addObject("productList", productList);
			return modelAndView;
		}
		// 检查请求的URI内的目录名称是否正确，不正确的重定向到正确的URI
		String categoryUri = category.getUrl();
		try {
			String start_categoryUri = categoryUri.substring(0, categoryUri
					.lastIndexOf("/") + 1);
			String start_uri = uri.substring(0, uri.lastIndexOf("/") + 1);
			String end_uri = uri.substring(uri.lastIndexOf("/") + 1);
			if (!URLDecoder.decode(start_uri, "UTF-8")
					.equals(start_categoryUri)) {
				return new ModelAndView(new RedirectView301(start_categoryUri
						+ end_uri));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		List<Category> navigatorCategorys = category.getNavigatorCategorys();

		String defaultMv = "/market/marketList";
		if (request.getRequestURI().indexOf("man") != -1) {
			defaultMv = "market/manCatalogTemplate";
		}else if (request.getRequestURI().indexOf("wen") != -1) {
			defaultMv = "market/wenCatalogTemplate";
		}else if (request.getRequestURI().indexOf("weekYearSale") != -1) {
			defaultMv = "market/weekYearSale";
		}

		// 没有指定模版，或指定的模版找不到的时候，使用的缺省模版

		//String mv = this.getTemplatePath(defaultMv, category.getTemplatePath());

		ModelAndView modelAndView = getModelAndView(defaultMv);
		RequestUtil.getShopCart(request,response,modelAndView,shoppingcartManager);
		modelAndView.addObject("category", category);
		modelAndView.addObject("navigatorCategorys", navigatorCategorys);

		// modelAndView.addObject("sekListAll", sekListAll);

		// 显示该目录的产品
		List<Product> productList = new ArrayList<Product>();
		SearchResult searchResult = solr.queryProductByCatalog(request,
				category.getCategoryId(), 12);
		// 通过搜索来查产品id

		List<Integer> solrRsp = searchResult.getResultList();
		for (Integer id : solrRsp) {
			Product product = productManager.getById(id);
			if (product != null) {
				productList.add(product);
			}
		}

		/*
		 * ListSortUtil<Product> sortList = new ListSortUtil<Product>();
		 * sortList.sort(productList, "hits", "asc");
		 */
		ComparatorMapNew comparatorNew = new ComparatorMapNew();
		ComparatorMapUp comparatorUp = new ComparatorMapUp();
		ComparatorMapDown comparatorDown = new ComparatorMapDown();
		String sort = request.getParameter("sort");
		if (sort != null && sort != "") {
			if (sort.equals("up")) {
				Collections.sort(productList, comparatorUp);
			} else if (sort.equals("down")) {
				Collections.sort(productList, comparatorDown);
			}else if(sort.equals("new")){
				Collections.sort(productList, comparatorNew);
			}
		}

		// SearchCriteria sc = createSearchCriteria(request,null);
		// productList = productManager.findProductByCategoryIdForShow(sc,
		// category.getCategoryId(), null);
		modelAndView.addObject("productList", productList);
		modelAndView.addObject("facetMap", searchResult.getFacetMap());
		Map<Integer, Map<SkuOption, List<SkuOptionValue>>> productMap = new HashMap<Integer, Map<SkuOption, List<SkuOptionValue>>>();
		for(int i=0;i<productList.size();i++){
			Integer productId=productList.get(i).getProductId();
			Map<SkuOption,List<SkuOptionValue>>productSkuOptionAndValues=productMainManager.findSkuOptionsByProduct(productId);
			productMap.put(productId, productSkuOptionAndValues);
		}
		request.setAttribute("productMap", productMap);

		return modelAndView;
	}

	public List<Product> productList(List<Product> productList,
			List<SekillProduct> sekListAll) {
		String a = null;
		if (productList != null) {
			for (int i = 0; i < productList.size(); i++) {
				Product product = productList.get(i);
				product.setSekillStatus(Constant.STATUS_OTHER);
				if (sekListAll != null) {
					for (int j = 0; j < sekListAll.size(); j++) {
						SekillProduct sekillProduct = sekListAll.get(j);
						if (product.getDefaultProductSkuId() == sekillProduct
								.getProduct().getDefaultProductSkuId()) {
							product.setSekillStatus(sekillProduct.getStatus());
							break;
						}
					}
				}
			}
		}
		return productList;
	}

	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}

	public void setCategoryManager(CategoryManager categoryManager) {
		this.categoryManager = categoryManager;
	}

	public void setSolrService(SolrService avalue) {
		this.solr = avalue;
	}
}
