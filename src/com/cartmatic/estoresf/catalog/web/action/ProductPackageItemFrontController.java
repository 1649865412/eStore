package com.cartmatic.estoresf.catalog.web.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.ProductPackageItemManager;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductPackageItem;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.webapp.util.RequestUtil;


@Controller
public class ProductPackageItemFrontController extends GenericStoreFrontController<ProductPackageItem> {
	private ProductPackageItemManager productPackageItemManager = null;

    public void setProductPackageItemManager(ProductPackageItemManager inMgr) {
        this.productPackageItemManager = inMgr;
    }
    
	@Override
	protected void initController() throws Exception {
		mgr = productPackageItemManager;
	}

	@Override
    @RequestMapping(value="/catalog/productPackageItems.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		/*Integer itemSkuId=RequestUtil.getInteger(request,"itemSkuId");
		List<ProductPackageItem>ProductPackageItemList=productPackageItemManager.findProductPackageItemListByItem(itemSkuId);

    	String template=request.getParameter("template");
    	if(StringUtils.isEmpty(template)){
    		template="catalog/productPackageItemList";
    	}
    	ModelAndView mv=new ModelAndView(template);
		mv.addObject("ProductPackageItemList",ProductPackageItemList);
		return mv;*/
		
		Integer itemProductId=RequestUtil.getInteger(request,"itemProductId");
		List<Product> productPackageList=productPackageItemManager.getProductPackageByItemProduct(itemProductId);
		String template=request.getParameter("template");
    	if(StringUtils.isEmpty(template)){
    		template="catalog/productPackageItemList";
    	}
    	ModelAndView mv=new ModelAndView(template);
		mv.addObject("productPackageList",productPackageList);
		return mv;
	}
}
