package com.cartmatic.estoresf.catalog.web.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.catalog.service.BrandManager;
import com.cartmatic.estore.common.model.catalog.Brand;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductCategory;
import com.cartmatic.estore.common.model.sekillproduct.SekillProduct;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.sekillproduct.service.SekillProductManager;
import com.cartmatic.estoresf.seckill.help.Constant;
import com.cartmatic.estoresf.seckill.help.SeckillTool;
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
    
    private SekillProductManager sekillProductManager = null;
	
	public void setSekillProductManager(SekillProductManager sekillProductManager)
	{
		this.sekillProductManager = sekillProductManager;
	}
	
	
	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		mgr = brandManager;
		setCacheSecondsConfigurable(true);
	}
	
	
	
	/**
	 * 品牌列表页
	 */
	@Override
	@RequestMapping(value="/designer/index.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		//String template=request.getParameter("template");
		ModelAndView mv=new ModelAndView("catalog/designer");
		List<Brand> brandList=brandManager.findAllBrands();
		mv.addObject("brandList", brandList);
		return mv;
	}
	
	
	/*public List<Brand> getBrand(List<Brand> brandList){
		
		List<SekillProduct> sekillProductList = sekillProductManager.getAll();
		
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
		sekListAll.addAll(sekillProductListDay3);
		
		
		return  change(brandList,sekListAll);
	}	
	
	
	
	*//**
	 * 功能:
	 * <p>作者 杨荣忠 2015-5-7 下午08:38:57
	 * @param brandList
	 * @param sekListAll
	 * @return
	 *//*
	public List<Brand> change(List<Brand> brandList,List<SekillProduct>  sekListAll){
		if(brandList!=null){
			for(int i=0;i<brandList.size();i++){
				Brand brand = brandList.get(i);
				Set<Product>productList = brand.getProducts();
				if(productList!=null){
					 productList =productList(productList, sekListAll);
					 brand.setProducts(productList);
				}
			}
		}
		return brandList;
		
	}
	
	*//**
	 * 功能:
	 * <p>作者 杨荣忠 2015-5-7 下午08:39:11
	 * @param productList
	 * @param sekListAll
	 * @return
	 *//*
	public Set<Product> productList(Set<Product> productList,List<SekillProduct>  sekListAll ){
		if(productList!=null){
			for (Product product : productList) {
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
	}*/
	
}
