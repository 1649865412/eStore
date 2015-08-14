package com.cartmatic.estoresf.catalog.web.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.sekillproduct.service.SekillProductManager;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.extend.catalog.util.CharacterSort;
/**
 * @TODO 暂时没有使用
 * @author kedou
 *
 */
@Controller
public class BrandFrontController  extends GenericStoreFrontController<Brand>{
	
	private BrandManager brandManager = null;

	
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
	@RequestMapping(value="/designer/index.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv=new ModelAndView("catalog/designer");
		List<Brand> brandList=brandManager.findAllBrands();
		//mv.addObject("mapResult",CharacterSort.listBrandSort(brandList));
		mv.addObject("brandList", brandList);
		return mv;
	}
		
	
	/**
	 * 设计师列表页字母筛选
	 */
	@RequestMapping(value="/designer/initialsSelect.html")
	public ModelAndView initialsSelect(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv=new ModelAndView("catalog/designer");
		String initials = request.getParameter("initials");
		List<Brand> brandList=brandManager.findByProperty("initials", initials);
		mv.addObject("mapResult",brandList);
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
    	//ProductSearchFrontController
    	// @RequestMapping(value="/search-prod.html")
    	//参考老的就可以获取到
    	ModelAndView mv = getModelAndView("designer/designerTemplate");
		Integer brandId=(Integer)request.getAttribute("brandId");
		if(brandId!=null){
			Brand brand=brandManager.getById(brandId);
//			List<Product> recommendProductList=
//			brandManager.getAllByIdArray(uio);
			mv.addObject("brand", brand);
		}
		return mv;
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
