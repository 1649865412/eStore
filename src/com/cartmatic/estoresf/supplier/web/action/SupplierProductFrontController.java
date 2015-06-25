package com.cartmatic.estoresf.supplier.web.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.catalog.service.CategoryManager;
import com.cartmatic.estore.catalog.service.ProductMainManager;
import com.cartmatic.estore.common.helper.CatalogHelper;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.catalog.CategoryTreeItem;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.supplier.Supplier;
import com.cartmatic.estore.common.model.supplier.SupplierProduct;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.search.SearchCriteria;
import com.cartmatic.estore.core.util.BeanUtils;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.supplier.service.SupplierProductManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.opensymphony.module.sitemesh.RequestConstants;

@Controller
public class SupplierProductFrontController extends GenericStoreFrontController<SupplierProduct> {
    private SupplierProductManager supplierProductManager = null;
    private CustomerManager customerManager=null;
    private CategoryManager categoryManager=null;
    private ProductMainManager productMainManager=null;
    
    public void setProductMainManager(ProductMainManager productMainManager) {
		this.productMainManager = productMainManager;
	}

	@Override
	@RequestMapping(value="/myaccount/supplierProduct.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
    	Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
		SearchCriteria sc = createSearchCriteria(request,"supplierProduct");
		sc.addParamValue(supplier.getSupplierId());
		sc.lockParamValues();
		List results = searchByCriteria(sc);
		return getModelAndView("/customer/supplierProductList", "supplierProductList", results);
	}
    
    @RequestMapping(value="/myaccount/supplierProduct/add.html",method=RequestMethod.GET)
	public ModelAndView add(HttpServletRequest request,HttpServletResponse response) {
    	SupplierProduct supplierProduct=new SupplierProduct();
		request.setAttribute("supplierProduct",supplierProduct);
    	
    	Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
    	if(supplier==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
    	}
		return getModelAndView("/customer/supplierProductForm");
	}
    
    @RequestMapping(value="/myaccount/supplierProduct/add.html",method=RequestMethod.POST)
	public ModelAndView edit4Add(@Valid SupplierProduct supplierProduct,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
    	if(supplier==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		try {
			Long tbCId=supplierProduct.getTbCId();
			if(tbCId==null&&supplierProduct.getCategoryId()==null){
				result.rejectValue("categoryId", "supplierProduct.msg.categoryId.required", "Please enter a valid 目录!");
			}
			supplierProduct.setSupplier(supplier);
			supplierProduct.setStatus(Constants.STATUS_NOT_PUBLISHED);
			
			if (!result.hasErrors()) {
				//检查修改内容
				supplierProduct.setTbSellCatProps("");
				supplierProductManager.save(supplierProduct);
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			mav=new ModelAndView("/customer/supplierProductForm");
		}else{
			saveMessage(Message.info("supplier.product.add.approve"));
			mav=getRedirectView("/myaccount/supplierProduct/edit/"+supplierProduct.getSupplierProductId()+".html");
		}
		return mav;
	}
    
    @RequestMapping(value="/myaccount/supplierProduct/edit/{id}.html",method=RequestMethod.GET)
	public ModelAndView edit(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) {
    	Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
    	SupplierProduct supplierProduct=supplierProductManager.getById(id);
    	if(supplierProduct==null||supplier==null||supplierProduct.getSupplier().getSupplierId().intValue()!=supplier.getSupplierId()){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
    	}
		return getModelAndView("/customer/supplierProductForm", "supplierProduct", supplierProduct);
	}
    
    
    @RequestMapping(value="/myaccount/supplierProduct/edit/{id}.html",method=RequestMethod.POST)
	public ModelAndView edit4Save(@PathVariable Integer id,@Valid SupplierProduct supplierProduct,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
		
    	SupplierProduct entity=supplierProductManager.getById(id);
    	if(entity==null||supplier==null||entity.getSupplier().getSupplierId().intValue()!=supplier.getSupplierId()){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		try {
			Long tbCId=supplierProduct.getTbCId();
			if(tbCId==null&&supplierProduct.getCategoryId()==null){
				result.rejectValue("categoryId", "supplierProduct.msg.categoryId.required", "Please enter a valid 目录!");
			}
			//前台所以保存过的都修改为pending状态
			if(entity.getStatus().intValue()==Constants.STATUS_ACTIVE||entity.getStatus().intValue()==Constants.STATUS_PENDING){
				entity.setStatus(Constants.STATUS_NOT_PUBLISHED);
			}
			
			if (!result.hasErrors()) {
				//检查修改内容
				supplierProductManager.setUploadLogs(entity);
				
				BeanUtils.copyProperties(supplierProduct, entity, "productName","productCode","categoryId","wholesalePrice","mediaUrl","productDesc","modifyLogs");
				supplierProductManager.save(entity);
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			mav=new ModelAndView("/customer/supplierProductForm");
		}else{
			saveMessage(Message.info("supplier.product.update.approve"));
			mav=getRedirectView("/myaccount/supplierProduct/edit/"+id+".html");
		}
		return mav;
	}

	public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

	public void setSupplierProductManager(SupplierProductManager inMgr) {
        this.supplierProductManager = inMgr;
    }


	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cartmatic.estore.core.controller.BaseController#initController()
	 */
	@Override
	protected void initController() throws Exception {
		mgr = supplierProductManager;
	}

	public void setCategoryManager(CategoryManager categoryManager) {
		this.categoryManager = categoryManager;
	}

	
	@RequestMapping(value="/myaccount/supplierProduct/product_cat_iframe.html")
	public ModelAndView selectCategoryIframe(HttpServletRequest request,HttpServletResponse response)  {
		request.setAttribute(RequestConstants.DECORATOR, "blank");
		Integer catalogId=ConfigUtil.getInstance().getStore().getCatalogId();
		List<CategoryTreeItem> categoryList=categoryManager.getCatalogTreeItemList4Front(catalogId);
		request.setAttribute("categoryList",categoryList);
		return new ModelAndView("/customer/categoryJSONObject");
	}
	
    @RequestMapping(value="/myaccount/supplierProduct/applyUpdate/{id}.html",method=RequestMethod.GET)
	public ModelAndView applyUpdate(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) {
    	SupplierProduct supplierProduct=supplierProductManager.getById(id);
    	Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
    	if(supplierProduct==null||supplier==null||supplierProduct.getSupplier().getSupplierId().intValue()!=supplier.getSupplierId()){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
    	if(supplierProduct.getStatus()!=null&&supplierProduct.getStatus().intValue()==Constants.STATUS_NOT_PUBLISHED){
    		supplierProduct.setStatus(Constants.STATUS_PENDING);
        	supplierProductManager.save(supplierProduct);
        	saveMessage(Message.info("supplier.product.update.approve"));
    	}
    	return getRedirectView("/myaccount/supplierProduct/edit/"+id+".html");
	}
    
    
    @RequestMapping(value="/myaccount/supplierProduct/delete/{id}.html", method=RequestMethod.GET)
	public ModelAndView delete(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception {
    	SupplierProduct supplierProduct=supplierProductManager.getById(id);
    	Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
    	if(supplierProduct==null||supplier==null||supplierProduct.getSupplier().getSupplierId().intValue()!=supplier.getSupplierId()){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		if(supplierProduct.getStatus()!=Constants.STATUS_DELETED){
			supplierProduct.setStatus(Constants.STATUS_DELETED);
			supplierProductManager.save(supplierProduct);
			//@TODO 同时删除产品???
			if(supplierProduct.getProduct()!=null){
				productMainManager.delete(supplierProduct.getProductId());
				//更新索引
				CatalogHelper.getInstance().indexNotifyDeleteEvent(supplierProduct.getProductId());
	        	saveMessage(Message.info("supplier.product.delete"));
			}
		}
		return getRedirectView("/myaccount/supplierProduct.html");
	}

}
