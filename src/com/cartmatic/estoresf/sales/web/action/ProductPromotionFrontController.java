
package com.cartmatic.estoresf.sales.web.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductSku;
import com.cartmatic.estore.common.service.PromoService;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.sales.engine.PRule;
import com.cartmatic.estore.webapp.util.RequestUtil;
/**
 * 前台产品促销规则显示controller
 * @author CartMatic
 *
 */
@Controller
public class ProductPromotionFrontController extends GenericStoreFrontController<Product> {
	private PromoService promoService;
	private ProductManager productManager;
	public void setPromoService(PromoService promoService) {
		this.promoService = promoService;
	}

	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}

	@RequestMapping(value="/sales/productPromotion*")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv = getModelAndView("catalog/include/productPromotion");
		String productId = RequestUtil.getParameterNullSafe(request, "productId");
		if(!productId.trim().equals("")){
			Product product = productManager.getById(Integer.parseInt(productId));
			Collection<ProductSku> promotionResults = new ArrayList<ProductSku>();
			Set<ProductSku> skus = product.getProductSkus();
			for(ProductSku sku : skus){
				Collection<ProductSku> result = promoService.getPromoInfoUsedInProductModule(sku);
				for(ProductSku item : result){
					promotionResults.add(item);
					
				}
			}
			//对结果唯一化和转换
			List<PRule> promotionList = convertAndDistinct(promotionResults);
			mv.addObject("promotionList", promotionList);
		}
		return mv;
	}

	

	private List<PRule> convertAndDistinct(
			Collection<ProductSku> promotionResults) {
		List<PRule> list = new ArrayList<PRule>();
		for(ProductSku sku: promotionResults){
			if(!list.contains(sku.getPrule())){
				list.add(sku.getPrule());
			}
		}
		return list;
		
	}

	protected void initController() throws Exception {
		mgr = productManager;
	}

	
}
