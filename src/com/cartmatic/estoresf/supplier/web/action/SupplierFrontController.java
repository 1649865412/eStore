package com.cartmatic.estoresf.supplier.web.action;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.supplier.Supplier;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.util.BeanUtils;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.supplier.service.SupplierManager;
import com.cartmatic.estore.webapp.util.RequestContext;

@Controller
public class SupplierFrontController extends GenericStoreFrontController<Supplier> {
	private SupplierManager supplierManager=null;
	
	private CustomerManager customerManager=null;
	
	public void setSupplierManager(SupplierManager supplierManager) {
		this.supplierManager = supplierManager;
	}
	
	public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

	@Override
	protected void initController() throws Exception {
		this.mgr=supplierManager;
	}
	
	@RequestMapping(value="/myaccount/supplierProfile.html", method=RequestMethod.GET)
    public ModelAndView view(HttpServletRequest request, HttpServletResponse response) 
    {
		ModelAndView mv=new ModelAndView("customer/supplierProfile");
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=customer.getSupplier();
		if(supplier==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		mv.addObject("supplier", supplier);
		
		Customer supplierAdmin=customerManager.getById(supplier.getAdminId());
		request.setAttribute("supplierAdmin",supplierAdmin);
		request.setAttribute("couldEdit", supplier.getAdminId().intValue()==customer.getAppuserId());
		Set<Customer> supplierUserList=supplier.getCustomers();
		Set<Customer>temp_supplier_set=new HashSet<Customer>();
		for (Customer customer2 : supplierUserList) {
			if(customer2.getDeleted()==null||customer2.getDeleted().intValue()!=1)
				temp_supplier_set.add(customer2);
		}
		supplierUserList=temp_supplier_set;
		request.setAttribute("supplierUserList",supplierUserList);
        return mv;
    }

	@RequestMapping(value="/myaccount/supplierProfile.html", method=RequestMethod.POST)
	public ModelAndView save(@Valid Supplier supplier,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		// 取得Form对应的Model
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier entity=customer.getSupplier();
		if(entity==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		try {
			if (!result.hasErrors()) {
				BeanUtils.copyProperties(supplier, entity, "address","comments","email","zip","fax","webSite","contacts");
				mgr.save(entity);
//				saveMessage(Message.info("common.updated",getEntityTypeMessage(), getEntityName(entity)));
				saveMessage(Message.info("common.updated"," 供应商详细信息",entity.getSupplierName()));
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			mav=new ModelAndView("customer/supplierProfile");
		}else{
			mav=getRedirectView("/myaccount/supplierProfile.html");
		}
		return mav;
	}
}