package com.cartmatic.estoresf.catalog.web.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.catalog.service.CategoryManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Category;
import com.cartmatic.estore.common.model.catalog.CategoryTreeItem;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.sekillproduct.SekillProduct;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.common.service.SolrService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.search.SearchCriteria;
import com.cartmatic.estore.core.view.RedirectView301;
import com.cartmatic.estore.sekillproduct.service.SekillProductManager;
import com.cartmatic.estore.textsearch.model.SearchResult;
import com.cartmatic.estoresf.seckill.help.Constant;
import com.cartmatic.estoresf.seckill.help.SeckillTool;

@Controller
public class CategoryFrontController extends GenericStoreFrontController<Category> {

	private ProductManager	productManager	= null;
	private CategoryManager	categoryManager	= null;
	
	private SekillProductManager sekillProductManager = null;
	
	public void setSekillProductManager(SekillProductManager sekillProductManager)
	{
		this.sekillProductManager = sekillProductManager;
	}
	
	
	private SolrService solr = null;
	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr = categoryManager;
		setCacheSecondsConfigurable(true);
	}
	
	private ModelAndView getNotFoundView(){
		return getModelAndView("catalog/categoryErrorPage");
	}

	
	
	
	/**
	 * 产品列表页
	 */
	@RequestMapping(value={"/**/*_catalog.html","/**/*_catalog_pn*.html"})
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		
		/*List<SekillProduct> sekillProductList = sekillProductManager.getAll();
		
		List<SekillProduct> sekillProductListDay1 = new ArrayList<SekillProduct>();
		
		List<SekillProduct> sekillProductListDay2 = new ArrayList<SekillProduct>();
		
		List<SekillProduct> sekillProductListDay3 = new ArrayList<SekillProduct>();
		
		List<SekillProduct>    sekListAll = new ArrayList();
			
		for (int i = 0; i < sekillProductList.size(); i++)
		{
			SekillProduct sekill = sekillProductList.get(i);
			String sekillTime = sekill.getSekillTime().toString();
			if (sekillTime.equals(Constant.SEKILL_ONE_DAY))
			{
				sekillProductListDay1.add(sekill);
			}
			else if (sekillTime.equals(Constant.SEKILL_TWO_DAY))
			{
				sekillProductListDay2.add(sekill);
			}
			else if (sekillTime.equals(Constant.SEKILL_THRID_DAY))
			{
				sekillProductListDay3.add(sekill);
			}
		}
		
		SeckillTool.getStayDay( sekillProductListDay1, sekillProductListDay2,
				 sekillProductListDay3);
		
		sekListAll.addAll(sekillProductListDay1);
		sekListAll.addAll(sekillProductListDay2);
		sekListAll.addAll(sekillProductListDay3);*/
		
		String uri=request.getRequestURI();
		if(uri.contains("/aboutus/help")){
			return new ModelAndView(new RedirectView("/customer_service/_16.html"));
		}
		Store store=ConfigUtil.getInstance().getStore();
		
		CatalogHelper catalogHelper=CatalogHelper.getInstance();
		//CategoryTreeItem继承category
		CategoryTreeItem category=(CategoryTreeItem)catalogHelper.getProductCategoryByUri(uri);
		if(category==null){
			return getNotFoundView();
		}
		//检查请求的URI内的目录名称是否正确，不正确的重定向到正确的URI
		String categoryUri=category.getUrl();
		try {
			String start_categoryUri=categoryUri.substring(0,categoryUri.lastIndexOf("/")+1);
			String start_uri=uri.substring(0,uri.lastIndexOf("/")+1);
			String end_uri=uri.substring(uri.lastIndexOf("/")+1);
			if(!URLDecoder.decode(start_uri, "UTF-8").equals(start_categoryUri)){
				return new ModelAndView(new RedirectView301(start_categoryUri+end_uri));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		List<Category> navigatorCategorys=category.getNavigatorCategorys();
		
		
		// 没有指定模版，或指定的模版找不到的时候，使用的缺省模版
		String defaultMv="/catalog/categoryTemplate";
		String mv = this.getTemplatePath(defaultMv, category.getTemplatePath());
		
		ModelAndView modelAndView = getModelAndView(mv);
		modelAndView.addObject("category", category);
		modelAndView.addObject("navigatorCategorys", navigatorCategorys);
		
		//modelAndView.addObject("sekListAll", sekListAll);
		
		//显示该目录的产品
		List<Product> productList= new ArrayList<Product>();
		SearchResult searchResult=solr.queryProductByCatalog(request, category.getCategoryId(),store.getCategoryListPerSize());
		//通过搜索来查产品id
		
		List<Integer> solrRsp = searchResult.getResultList();
		for (Integer id : solrRsp)
		{
			Product product = productManager.getById(id);
			if(product != null){
				productList.add(product);
			}
		}
		//SearchCriteria sc = createSearchCriteria(request,null);
		// productList  = productManager.findProductByCategoryIdForShow(sc, category.getCategoryId(), null);
		modelAndView.addObject("productList",productList);
	 	modelAndView.addObject("facetMap", searchResult.getFacetMap());
		
		return modelAndView;
	}

	
	
	public List<Product> productList(List<Product> productList,List<SekillProduct>  sekListAll ){
		String a =null;
		if(productList!=null){
			for(int i=0;i<productList.size();i++){
				Product product =productList.get(i);
				product.setSekillStatus(Constant.STATUS_OTHER);
				if(sekListAll!=null){
				for(int j=0;j<sekListAll.size();j++){
					SekillProduct sekillProduct = sekListAll.get(j);
					if(product.getDefaultProductSkuId()==sekillProduct.getProduct().getDefaultProductSkuId()){
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
	
	public void setSolrService(SolrService avalue)
	{
		this.solr = avalue;
	}
}
