package com.cartmatic.estoresf.catalog.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.branddynamic.service.BrandDynamicManager;
import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.catalog.service.ProductMainManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.model.branddynamic.BrandDynamic;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.SkuOption;
import com.cartmatic.estore.common.model.catalog.SkuOptionValue;
import com.cartmatic.estore.common.model.culturalinformation.CulturalInformation;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.culturalinformation.service.CulturalInformationManager;
import com.cartmatic.extend.catalog.util.CharacterSort;
/**
 * @TODO 暂时没有使用
 * @author kedou
 *
 */
@Controller
public class BrandFrontController  extends GenericStoreFrontController<Brand>{
	
	private BrandManager brandManager = null;
	private ProductManager productManager = null;
	private CulturalInformationManager culturalInformationManager = null;
	private BrandDynamicManager brandDynamicManager = null;
	private ProductMainManager productMainManager=null;

	
    public ProductMainManager getProductMainManager() {
		return productMainManager;
	}

	public void setProductMainManager(ProductMainManager productMainManager) {
		this.productMainManager = productMainManager;
	}

	public BrandDynamicManager getBrandDynamicManager() {
		return brandDynamicManager;
	}

	public void setBrandDynamicManager(BrandDynamicManager brandDynamicManager) {
		this.brandDynamicManager = brandDynamicManager;
	}

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
	 * 设计师列表页
	 */
	@Override
	@RequestMapping(value="/designerList.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv=new ModelAndView("designer/designerList");
		List<Brand> brandList=brandManager.findAllBrands();
		mv.addObject("mapResult",CharacterSort.listBrandSort(brandList));
		//mv.addObject("brandList", brandList);
		return mv;
	}
	
	/**
	 * 设计师产品列表页
	 */
	@RequestMapping(value="/designerProductList.html")
	public ModelAndView designerProductList(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv=new ModelAndView("designer/designerProductList");
		Integer brandId=Integer.parseInt(request.getParameter("brandId"));
		Brand brand=brandManager.getById(brandId);
		mv.addObject("brand", brand);
		List<Product> productList = productManager.getByBrandId(brandId);
		mv.addObject("productList", productList);
		return mv;
	}
		
	
	/**
	 * 设计师列表页字母筛选
	 */
	@RequestMapping(value="/designer/initialsSelect.html")
	public ModelAndView initialsSelect(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv=new ModelAndView("designer/designerList");
		String initials = request.getParameter("initials");
		List<Brand> brandList=brandManager.findByProperty("initials", initials);
		mv.addObject("mapResult",CharacterSort.listBrandSort(brandList));
//		mv.addObject("mapResult",brandList);
		return mv;
	}
    
    
    /**
	 * 功能:设计师模块详情页
	 * <p>作者 杨荣忠 2015-6-19 下午05:02:34
	 * @param request
	 * @param response
	 * @return
	 */
    @RequestMapping(value="/Designer_Service/designer_datial.html")
    public ModelAndView designerDatialAction(HttpServletRequest request, HttpServletResponse response)	 
    {
    	ModelAndView mv = getModelAndView("designer/designerTemplate");
		Integer brandId=Integer.parseInt(request.getParameter("brandId"));
		if(brandId!=null){
			Brand brand=brandManager.getById(brandId);
			CulturalInformation culturalInformation=new CulturalInformation();
			mv.addObject("brand", brand);
			String recommendProductNum=brand.getProductRecommendId();
			List<Product> recommendProductList=productManager.getAllByIdArray(recommendProductNum);
			mv.addObject("recommendProductList", recommendProductList);
			List<Map<SkuOption,List<SkuOptionValue>>> productSkuOptionAndValuesList=new ArrayList();
			Map<Integer,	Map<SkuOption,List<SkuOptionValue>> >productSkuOptionValuesAndproductIdMap = new HashMap<Integer,Map<SkuOption,List<SkuOptionValue>>>(); 
			for(int i=0;i<recommendProductList.size();i++){
				Product Product=recommendProductList.get(i);
				Integer productId=Product.getId();
				Map<SkuOption,List<SkuOptionValue>> productSkuOptionAndValues=productMainManager.findSkuOptionsByProduct(productId);
				productSkuOptionValuesAndproductIdMap.put(productId, productSkuOptionAndValues);
				productSkuOptionAndValuesList.add(productSkuOptionAndValues);
			}
			mv.addObject("productSkuOptionValuesAndproductIdMap", productSkuOptionValuesAndproductIdMap);
			String culId=brand.getCulturalRecommendId();
			List<CulturalInformation> culturalInformationList=culturalInformationManager.getAllByIdArray(culId);
			if(!CollectionUtils.isEmpty(culturalInformationList)){
				 culturalInformation=culturalInformationList.get(0);
			}
			mv.addObject("culturalInformation",culturalInformation);
			List<BrandDynamic> brandDynamicList=brandDynamicManager.getResutlType(brandId);
			mv.addObject("brandDynamicList",brandDynamicList);
			
//			Map<SkuOption,List<SkuOptionValue>>productSkuOptionAndValues=productMainManager.findSkuOptionsByProduct(productId);
//			mv.addObject("productSkuOptionAndValues",productSkuOptionAndValues);
		}
		return mv;
    }
    
    
    public CulturalInformationManager getCulturalInformationManager() {
		return culturalInformationManager;
	}

	public void setCulturalInformationManager(
			CulturalInformationManager culturalInformationManager) {
		this.culturalInformationManager = culturalInformationManager;
	}

	public ProductManager getProductManager() {
		return productManager;
	}

	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}

	/**
	 * 功能:设计师模块搜索页，支持设计师名字与设计师品牌的模糊查询
	 * <p>作者 杨荣忠 2015-6-19 下午05:02:34
	 * @param request
	 * @param response
	 * @return
	 */
    @RequestMapping(value="/Designer_Service/search.html")
    public void searchAction(HttpServletRequest request, HttpServletResponse response,String tags)	 
    {  
		  List<Brand>  result =  brandManager.getSearch(tags);
    }
	

	
}
