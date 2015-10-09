package com.cartmatic.estoresf.catalog.web.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.cart.service.ShoppingcartManager;
import com.cartmatic.estore.catalog.CatalogConstants;
import com.cartmatic.estore.catalog.service.CategoryManager;
import com.cartmatic.estore.catalog.service.ProductCategoryManager;
import com.cartmatic.estore.catalog.service.ProductMainManager;
import com.cartmatic.estore.catalog.service.ProductManager;
import com.cartmatic.estore.catalog.service.ProductMediaManager;
import com.cartmatic.estore.catalog.service.ProductMediaUpManager;
import com.cartmatic.estore.catalog.service.ProductRateItemManager;
import com.cartmatic.estore.catalog.service.ProductSkuManager;
import com.cartmatic.estore.catalog.service.ProductStatManager;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.Accessory;
import com.cartmatic.estore.common.model.catalog.AccessoryGroup;
import com.cartmatic.estore.common.model.catalog.Category;
import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductAttGroup;
import com.cartmatic.estore.common.model.catalog.ProductCategory;
import com.cartmatic.estore.common.model.catalog.ProductMedia;
import com.cartmatic.estore.common.model.catalog.ProductMediaUp;
import com.cartmatic.estore.common.model.catalog.ProductRateItem;
import com.cartmatic.estore.common.model.catalog.ProductReview;
import com.cartmatic.estore.common.model.catalog.ProductSku;
import com.cartmatic.estore.common.model.catalog.ProductStat;
import com.cartmatic.estore.common.model.catalog.SkuOption;
import com.cartmatic.estore.common.model.catalog.SkuOptionValue;
import com.cartmatic.estore.common.model.catalog.WholesalePrice;
import com.cartmatic.estore.common.model.inventory.Inventory;
import com.cartmatic.estore.common.model.system.Store;
import com.cartmatic.estore.common.service.InventoryService;
import com.cartmatic.estore.common.service.PromoService;
import com.cartmatic.estore.common.util.DateUtil;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.view.RedirectView301;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.estore.webapp.util.SessionUtil;
import com.denglu.util.QrCodeTool;


@Controller
public class ProductFrontController extends GenericStoreFrontController<Product>{
	private ProductManager				productManager				= null;
    private ProductMediaManager productMediaManager = null;
    private ProductMediaUpManager productMediaUpManager = null;
	private ProductCategoryManager	productCategoryManager	= null;
	private ProductMainManager productMainManager=null;
    private InventoryService inventoryService=null;
    private ProductSkuManager productSkuManager=null;
	protected CategoryManager	categoryManager	= null;
	private PromoService promoService=null;
	private ProductRateItemManager productRateItemManager=null;
	private ProductStatManager productStatManager=null;
	private ShoppingcartManager shoppingcartManager = null;
	
	
	public ShoppingcartManager getShoppingcartManager() {
		return shoppingcartManager;
	}

	public void setShoppingcartManager(ShoppingcartManager shoppingcartManager) {
		this.shoppingcartManager = shoppingcartManager;
	}

	public void setProductStatManager(ProductStatManager productStatManager) {
		this.productStatManager = productStatManager;
	}

	public void setProductManager(ProductManager inMgr) {
		this.productManager = inMgr;
	}
	
	
	public void setProductRateItemManager(ProductRateItemManager productRateItemManager) {
		this.productRateItemManager = productRateItemManager;
	}


	/**
	 * 根据详细页面的URI获取产品目录code
	 * @param uri http://192.168.16.123:8080/eStore/mobile/nokia_5300/prod20.html
	 * @return 3 mobile
	 */
	private String getCategoryCodeByProductUri(String uri){
		String temp_uris[]=uri.split("/");
		try {
			return temp_uris[temp_uris.length-3];
		} catch (Exception e) {
			return null;
		}
	}

	
	private ModelAndView notFoundPage(HttpServletRequest request,HttpServletResponse response) {
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		return getModelAndView("catalog/categoryErrorPage");
	}
	
	//@RequestMapping(value={"/*_p{pId}_{cId}.html","/*_p{pId}.html",})
	@RequestMapping(value="/product/*.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		Store store=ConfigUtil.getInstance().getStore();
		String uri=request.getRequestURI();
		request.setAttribute("uri",uri);
		CatalogHelper catalogHelper=CatalogHelper.getInstance();
		Integer pIdcId[]=catalogHelper.getProductIdByUri(uri);
		Integer productId= pIdcId[0];
		Integer categoryId= pIdcId[1];
		//查找产品
		Product product=productManager.getById(productId);
		//没有找到相应产品或草稿状态的不能访问,直接进入找不到或已删除页面
		if(product==null){
			return notFoundPage(request, response);
		}
		//获取导航目录
		//获取产品主目录
		Category category=null;
		if(categoryId!=null){
			Category temp_category=catalogHelper.getCategoryById4Front(Constants.CATEGORY_TYPE_CATALOG,categoryId);
			if(temp_category!=null){
				Set<ProductCategory>productCategorySet=product.getProductCategorys();
				for (ProductCategory productCategory : productCategorySet) {
					if(productCategory.getCategory().getCatalogId().intValue()==store.getCatalogId()&&productCategory.getCategory().getId().intValue()==temp_category.getId()){
						category=temp_category;
						break;
					}
				}
			}
		}
		//指定目录不存在的直接获取产品主目录
		if(category==null){
			Category mainCategory=product.getMainCategory();
			//任何时候都从所以目录中查找，因为产品任何状态在前台都是可见的，
/*			if(mainCategory!=null)
				category=catalogHelper.getCategoryById4Front(Constants.CATEGORY_TYPE_CATALOG,mainCategory.getCategoryId());*/
			//缓存不存在该目录的，直接获取数据库的目录
			if(category==null&&mainCategory!=null){
				category=catalogHelper.getCategoryById4Front(Constants.CATEGORY_TYPE_CATALOG, mainCategory.getCategoryId());
			}
		}
		//检查请求的URI内的产品名是否正确，不正确的重定向到正确的URI
		//目录已删除的不需要检查
		if(category!=null){
			String productUri=catalogHelper.getProductUrl(product,store.getCatalogId(), category.getCategoryId());
			try {
				if(!URLDecoder.decode(uri, "UTF-8").equals(request.getContextPath()+productUri)){
					return new ModelAndView(new RedirectView301(productUri,true));
				}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(category==null){
			return notFoundPage(request, response);
		}
		
		List<Category> navigatorCategorys=null;
		//当目录为空的就不显示该目录相关信息，只显示产品数据
		if(category!=null){
			//获取产品导航目录
			navigatorCategorys=category.getNavigatorCategorys();
		}
		
		//获取产品媒体
		List<ProductMedia>productMoreImages=productMediaManager.findProductMediaByProductIdAndType(product.getProductId(), CatalogConstants.PRODUCT_MEDIA_TYPE_MORE_IMAGE);
		
		List<ProductMediaUp>productMoreImagesUp=productMediaUpManager.findProductMediaByProductIdAndType(product.getProductId(), CatalogConstants.PRODUCT_MEDIA_TYPE_MORE_IMAGE);
		
		//产品媒体附件
		List<ProductMedia>productaccessories=productMediaManager.findProductMediaByProductIdAndType(product.getProductId(), CatalogConstants.PRODUCT_MEDIA_TYPE_ACCESSORIES);
		
		//获取自定义属性组及值
		List<ProductAttGroup>productAttGroups=productMainManager.findAttGroupAndProductAttrValueByProduct(product);
		//获取库存信息
//		Inventory inventory=inventoryService.getInventoryBySku(product.getDefaultProductSkuId());
		Inventory inventory=product.getDefaultProductSku().getInventory();
		
		
		ModelAndView modelAndView=null;
		
		//激活状态下完整显示产品
		String defaultView="catalog/productTemplate";
		if(product.getStatus().intValue()==Constants.STATUS_ACTIVE.intValue()){
			String view = this.getTemplatePath(defaultView, product.getTemplatePath());
			modelAndView = getModelAndView(view);

			JSONObject jsonProductModel=new JSONObject();
			//是否变种产品，变种产品时，显示带有sku选项
			if(product.getProductKind().intValue()==CatalogConstants.PRODUCT_KIND_VARIATION.intValue()){
				//SkuOption及值
				Map<SkuOption,List<SkuOptionValue>>productSkuOptionAndValues=productMainManager.findSkuOptionsByProduct(productId);
				modelAndView.addObject("productSkuOptionAndValues",productSkuOptionAndValues);
				//变种信息
				List<ProductSku>  productSkuList=productSkuManager.findActiveProductSkusByProductId(productId);
				//为productSku设置促销价
				promoService.appendPromoInfo(productSkuList);

				JSONArray jsonOptionAndSkuList=new JSONArray();
				JSONArray jsonSkuOptionList=new JSONArray();
				JSONArray jsonSkuOptionNameList=new JSONArray();
				//获取shu产品相关信息
				for (ProductSku productSku : productSkuList) {
					//设置价格显示方式
					catalogHelper.setPriceViewType(productSku);
					//获取sku的选项及值，SkuOption及SkuOptionValue
					Map<SkuOption, SkuOptionValue> skuOptionAndValues=productMainManager.findSkuOptionAndValuesByProductSku(productSku.getId());
					Set<Entry<SkuOption, SkuOptionValue>>skuOptionAndValue=skuOptionAndValues.entrySet();
					JSONArray temp_jsonSkuData=new JSONArray();
					for (Entry<SkuOption, SkuOptionValue> entry : skuOptionAndValue) {
						temp_jsonSkuData.add(entry.getValue().getSkuOptionValueId());
					}
					temp_jsonSkuData.add(productSku.getId());
					jsonOptionAndSkuList.add(temp_jsonSkuData);
					if(jsonSkuOptionList.size()<1){
						Set<SkuOption> skuOptions=skuOptionAndValues.keySet();
						for (SkuOption skuOption : skuOptions) {
							jsonSkuOptionList.add(skuOption.getId());
							jsonSkuOptionNameList.add(skuOption.getSkuOptionName());
						}
					}
				}
				jsonProductModel.put("jsonOptionAndSkuList", jsonOptionAndSkuList);
				jsonProductModel.put("jsonSkuOptionList", jsonSkuOptionList);
				jsonProductModel.put("jsonSkuOptionNameList", jsonSkuOptionNameList);
				jsonProductModel.put("jsonProduct", productJSONData(product,productSkuList));
				modelAndView.addObject("jsonProductModel",jsonProductModel.toString());
				modelAndView.addObject("jsonProduct",productJSONData(product,productSkuList));
			}else{
				//普通产品或产品包
				//为productSku设置促销价
				ProductSku defaultProductSku=product.getDefaultProductSku();
				promoService.appendPromoInfo(defaultProductSku);
				//设置价格显示方式
				catalogHelper.setPriceViewType(defaultProductSku);
			}
		}else if(product.getStatus().intValue()==Constants.STATUS_INACTIVE){
			//非激活状态下，简单显示产品
			modelAndView = getModelAndView(defaultView);
		}else{
			response.setStatus(HttpServletResponse.SC_GONE);
			return getModelAndView("catalog/categoryErrorPage");
		}
		//获取产品评论项
		List<ProductRateItem>productRateItemList=productRateItemManager.findProductRateItemsByProductType(product.getProductTypeId());
		modelAndView.addObject("productRateItemList", productRateItemList);
		
		//获取产品附件组，及相应的附件项
		List<Map.Entry<AccessoryGroup, List<Accessory>>> productAccessoryList=productManager.getProductAccessoryMap(product.getProductId());
		modelAndView.addObject("productAccessoryList",productAccessoryList);
		
		
		
		//获取商品二维码
		modelAndView.addObject("encoderContent",getImgCode(	 product , request));
		RequestUtil.getShopCart(request,response,modelAndView,shoppingcartManager);
		modelAndView.addObject("product",product);
		modelAndView.addObject("category",category);
		modelAndView.addObject("navigatorCategorys",navigatorCategorys);
		modelAndView.addObject("productMoreImages",productMoreImages);
		modelAndView.addObject("productMoreImagesUp",productMoreImagesUp);
		modelAndView.addObject("productaccessories",productaccessories);
		modelAndView.addObject("productAttGroups",productAttGroups);
		modelAndView.addObject("inventory",inventory);
		
		return modelAndView;
	}
	
	
	//获取商品二维码
	public String getImgCode(	Product product ,HttpServletRequest request){
		String imgPath = getMessage("dimension.url")+"/"+product.getProductId()+".png";
		StringBuffer url = request.getRequestURL();  
		String encoderContent = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString()+"product/"+product.getProductId()+".html"; 
		QrCodeTool.getQrCodeImgUrl(encoderContent,imgPath);
		return   (product.getProductId()+".png");
	}
	
	
	
	
	private JSONObject skuToJson(ProductSku productSku,Map<SkuOption, SkuOptionValue> skuOptionAndValues){
		ConfigUtil configUtil=ConfigUtil.getInstance();
		JSONObject jsonProductSku=new JSONObject();
		jsonProductSku.put("productSkuId", productSku.getProductSkuId());
		jsonProductSku.put("productSkuCode", productSku.getProductSkuCode());
		jsonProductSku.put("image", productSku.getImage());
		jsonProductSku.put("weight",productSku.getWeight()==null?null:productSku.getWeight().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
		//相应的价格等
		jsonProductSku.put("priceViewType", productSku.getPriceViewType());
		jsonProductSku.put("price", productSku.getPrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
		jsonProductSku.put("salePrice",productSku.getSalePrice()==null?null:productSku.getSalePrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
		jsonProductSku.put("discountPrice", productSku.getDiscountPrice()==null?null:productSku.getDiscountPrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
		jsonProductSku.put("listPrice", productSku.getListPrice()==null?null:productSku.getListPrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
		jsonProductSku.put("discountPercent", productSku.getDiscountPercent());
		
		//获取批发价
		Set<WholesalePrice> wholesalePrices=productSku.getWholesalePrices();
		List<JSONArray> jsonWholesalePrices=new ArrayList<JSONArray>();
		for (WholesalePrice wholesalePrice : wholesalePrices) {
			JSONArray jsonWholesalePrice=new JSONArray();
			jsonWholesalePrice.add(wholesalePrice.getMinQuantity());
			jsonWholesalePrice.add(wholesalePrice.getPrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
			jsonWholesalePrices.add(jsonWholesalePrice);
		}
		jsonProductSku.put("wholesalePrices",jsonWholesalePrices);
		//获取库存信息
		if(productSku.getProduct().getAvailabilityRule().intValue()!=CatalogConstants.PRODUCT_AVAILABILITY_ALWAYS_SELL.intValue()&&productSku.getProduct().getAvailabilityRule().intValue()!=CatalogConstants.PRODUCT_AVAILABILITY_NOT_IN_STOCK_SELL){
			Inventory inventory=productSku.getInventory();
			//TODO 没有库存的全设置为0
			if(inventory==null){
				inventory=new Inventory();
				inventory.setProductSku(productSku);
				inventory.setQuantityOnHand(0);
				inventory.setAllocatedQuantity(0);
				inventory.setReservedQuantity(0);
				inventory.setPreOrBackOrderedQty(0);
			}
			Map<String,Object> jsonInventory=new HashMap<String, Object>();
			jsonInventory.put("productSkuId", inventory.getProductSkuId());
			jsonInventory.put("quantityOnHand", inventory.getQuantityOnHand());
			jsonInventory.put("allocatedQuantity", inventory.getAllocatedQuantity());
			jsonInventory.put("availableQuantity", inventory.getAvailableQuantity());
			jsonInventory.put("expectedRestockDate", inventory.getExpectedRestockDate()==null?"":DateUtil.convertDateToString(inventory.getExpectedRestockDate()));
			jsonInventory.put("preOrBackOrderedQty", inventory.getPreOrBackOrderedQty());
			jsonProductSku.put("inventory", jsonInventory);
		}
		if(skuOptionAndValues!=null&&skuOptionAndValues.size()>0){
			JSONArray jsonSkuOptions=new JSONArray();
			Set<SkuOption> skuOptions=skuOptionAndValues.keySet();
			for (SkuOption skuOption : skuOptions) {
				JSONObject jsonSkuOption=new JSONObject();
				jsonSkuOption.put("id", skuOption.getId());
				jsonSkuOption.put("vid", skuOptionAndValues.get(skuOption).getId());
				jsonSkuOptions.add(jsonSkuOption);
			}
			jsonProductSku.put("skuOptions",jsonSkuOptions);
		}
		return jsonProductSku;
	}
	
	
	private JSONObject productJSONData(Product product,List<ProductSku>  productSkuList){
		Integer storeId=ConfigUtil.getInstance().getStore().getStoreId();
		ProductStat productStat=productStatManager.getProductStat(storeId, product.getId());
		//TODO 是否只检查已激活的Sku信息
		JSONObject jsonProduct=new JSONObject();
		jsonProduct.put("productId",product.getProductId());
		jsonProduct.put("productName",product.getProductName());
		jsonProduct.put("productCode", product.getProductCode());
		jsonProduct.put("availabilityRule",product.getAvailabilityRule());
		jsonProduct.put("expectedReleaseDate",product.getExpectedReleaseDate()==null?"":DateUtil.convertDateToString(product.getExpectedReleaseDate()));
		jsonProduct.put("preOrBackOrderLimit",product.getPreOrBackOrderLimit());
		Map<String,Object> jsonProductStat=new HashMap<String, Object>();
		jsonProductStat.put("buyCount",productStat.getBuyCount());
		jsonProductStat.put("averageRate",productStat.getAverageRate());
		jsonProductStat.put("reviewCount",productStat.getReviewCount());
		jsonProduct.put("productStat",jsonProductStat);
		if(product.getProductKind().intValue()==CatalogConstants.PRODUCT_KIND_VARIATION.intValue()){
			List<Map<String,Object>> jsonProductSkus=new ArrayList<Map<String,Object>>();
			for (ProductSku productSku : productSkuList) {
				//获取sku的选项及值，SkuOption及SkuOptionValue
				Map<SkuOption, SkuOptionValue> skuOptionAndValues=productMainManager.findSkuOptionAndValuesByProductSku(productSku.getId());
				JSONObject jsonProductSku=skuToJson(productSku,skuOptionAndValues);
				jsonProductSkus.add(jsonProductSku);
				if(productSku.getId().intValue()==product.getDefaultProductSkuId().intValue()){
					jsonProduct.put("defaultProductSku",jsonProductSku);
				}
			}
			jsonProduct.put("productSkus",jsonProductSkus);
		}
		return jsonProduct;
	}
	
	
	/**
	 * TODO 暂没有用上
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ModelAndView productJSONData(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		Integer productId=RequestUtil.getInteger(request, "productId");
		Product product=productManager.getById(productId);
		Integer storeId=ConfigUtil.getInstance().getStore().getStoreId();
		ProductStat productStat=productStatManager.getProductStat(storeId, product.getId());
		//TODO 是否只检查已激活的Sku信息
		List<ProductSku>  productSkuList=productSkuManager.findActiveProductSkusByProductId(productId);
		
		JSONObject jsonProduct=new JSONObject();
		jsonProduct.put("productId",product.getProductId());
		jsonProduct.put("productName",product.getProductName());
		jsonProduct.put("productCode", product.getProductCode());
		jsonProduct.put("availabilityRule",product.getAvailabilityRule());
		Map<String,Object> jsonProductStat=new HashMap<String, Object>();
		jsonProductStat.put("buyCount",productStat.getBuyCount());
		jsonProductStat.put("averageRate",productStat.getAverageRate());
		jsonProductStat.put("reviewCount",productStat.getReviewCount());
		jsonProduct.put("productStat",jsonProductStat);
		List<Map<String,Object>> jsonProductSkus=new ArrayList<Map<String,Object>>();
		for (ProductSku productSku : productSkuList) {
			Map<String,Object> jsonProductSku=new HashMap<String, Object>();
			jsonProductSku.put("productSkuId", productSku.getProductSkuId());
			jsonProductSku.put("productSkuCode", productSku.getProductSkuCode());
			//相应的价格等
			Inventory inventory=inventoryService.getInventoryBySku(productSku.getId());
			Map<String,Object> jsonInventory=new HashMap<String, Object>();
			jsonInventory.put("productSkuId", inventory.getProductSkuId());
			jsonInventory.put("quantityOnHand", inventory.getQuantityOnHand());
			jsonInventory.put("allocatedQuantity", inventory.getAllocatedQuantity());
			jsonInventory.put("availableQuantity", inventory.getAvailableQuantity());
			jsonProductSku.put("inventory", jsonInventory);
			jsonProductSkus.add(jsonProductSku);
			if(productSku.getId().intValue()==product.getDefaultProductSkuId().intValue()){
				jsonProduct.put("defaultProductSku",jsonProductSku);
			}
		}
		jsonProduct.put("productSkus",jsonProductSkus);
		PrintWriter out = response.getWriter();
		out.println(jsonProduct.toString());
		return null;
	}

	@RequestMapping(value="/view-image.html")
	public ModelAndView viewImages(HttpServletRequest request,HttpServletResponse response){
		//request.setAttribute(RequestConstants.DECORATOR,"blank");
		ModelAndView mv = getModelAndView("catalog/viewImages");
		Integer productId=ServletRequestUtils.getIntParameter(request,"pid",0);
		Product product=productManager.getById(productId);
		if(product==null){
			return notFoundPage(request, response);
		}
		mv.addObject("product",product);
		//获取产品媒体
		List<ProductMedia>productMoreImages=productMediaManager.findProductMediaByProductIdAndType(productId, CatalogConstants.PRODUCT_MEDIA_TYPE_MORE_IMAGE);
		//添加上产品默认图片
		mv.addObject("productMoreImages",productMoreImages); 
		//获取目录导航
		//获取目录code
		CatalogHelper catalogHelper=CatalogHelper.getInstance();
		String categoryCode=request.getParameter("cc");
		Category category=null;
		if(StringUtils.isNotBlank(categoryCode)){
			category=catalogHelper.getCategoryByCode4Front(Constants.CATEGORY_TYPE_CATALOG,categoryCode);
		}
		//指定的code不存在相应的目录时，直接获取该产品的主目录
		if(category==null){
			Category mainCategory=product.getMainCategory();
			if(mainCategory!=null)
				category=catalogHelper.getCategoryById4Front(Constants.CATEGORY_TYPE_CATALOG,mainCategory.getCategoryId());
			//缓存不存在该目录的，直接获取数据库的目录
			if(category==null)
				category=mainCategory;
		}
		
		List<Category> navigatorCategorys=null;
		//当目录为空的就不显示该目录相关信息，只显示产品数据
		if(category!=null){
			//获取产品导航目录
			navigatorCategorys=category.getNavigatorCategorys();
		}
		mv.addObject("navigatorCategorys", navigatorCategorys);
		return mv;
	}
	
	
	public ModelAndView review(HttpServletRequest request,HttpServletResponse response) {
		String uri=request.getRequestURI();
		if(RequestContext.isAnonymousUser()&&!ConfigUtil.getInstance().getIsAllowAnonymousReview()){
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("common.loginConfirm"));
			return new ModelAndView(new RedirectView(uri+"#review"));
		}
		Integer pIdcId[]=CatalogHelper.getInstance().getProductIdByUri(uri);
		Integer productId= pIdcId[0];
		String message=request.getParameter("message");
		String customerName=request.getParameter("customerName");
		String subject=request.getParameter("subject");
		Integer productRate=Integer.parseInt(request.getParameter("productRate").split("_")[1]);;
		String attrRates[]=request.getParameterValues("rateItems");
		if(productId.intValue()!=0&&productId.intValue()!=0){
			ProductReview productReview=new ProductReview();
			productReview.setProductId(productId);
			productReview.setSubject(subject);
			productReview.setMessage(message);
			if(RequestContext.isAnonymousUser()){
				//TODO 设置匿名用户对象，系统必须存在Id为-2的匿名用户
				productReview.setReviewUserId(Constants.USERID_ANONYMOUS);
			}else{
				productReview.setReviewUserId(RequestContext.getCurrentUserId());
			}
			productReview.setCustomerName(customerName);
			productReview.setRate(productRate);
			productReview.setRemoteIp(request.getRemoteAddr());
			productReview.setStore(ConfigUtil.getInstance().getStore());
			if(attrRates==null)attrRates=new String[]{};
			productMainManager.saveProductReviewAction(productReview, attrRates);
			saveMessage(Message.info("product.addReview.success"));
		}
		return new ModelAndView(new RedirectView(uri+"#review"));
	}
	
	


	@Override
	protected void initController() throws Exception {
		mgr = productManager; 
	}

	public void setProductMediaManager(ProductMediaManager productMediaManager) {
		this.productMediaManager = productMediaManager;
	}

	public void setProductCategoryManager(
			ProductCategoryManager productCategoryManager) {
		this.productCategoryManager = productCategoryManager;
	}

	public void setProductMainManager(ProductMainManager productMainManager) {
		this.productMainManager = productMainManager;
	}


	public void setInventoryService(InventoryService inventoryService) {
		this.inventoryService = inventoryService;
	}

	public void setProductSkuManager(ProductSkuManager productSkuManager) {
		this.productSkuManager = productSkuManager;
	}
	public void setCategoryManager(CategoryManager categoryManager) {
		this.categoryManager = categoryManager;
	}
	public void setPromoService(PromoService promoService) {
		this.promoService = promoService;
	}

	public void setProductMediaUpManager(ProductMediaUpManager productMediaUpManager) {
		this.productMediaUpManager = productMediaUpManager;
	}

}
