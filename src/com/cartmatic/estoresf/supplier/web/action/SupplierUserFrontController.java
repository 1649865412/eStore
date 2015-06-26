package com.cartmatic.estoresf.supplier.web.action;

import java.util.ArrayList;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Constraint;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springmodules.validation.bean.conf.loader.annotation.handler.ValidationMethod;
import org.springmodules.validation.bean.conf.loader.annotation.handler.ValidationRule;
import org.springmodules.validation.bean.conf.loader.annotation.handler.Validator;
import org.springmodules.validation.bean.conf.loader.annotation.handler.ValidatorRef;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.common.model.attribute.AttributeValue;
import com.cartmatic.estore.common.model.customer.Address;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.supplier.Supplier;
import com.cartmatic.estore.core.controller.GenericController;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.model.BaseObject;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.util.BeanUtils;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.supplier.service.SupplierManager;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.SessionUtil;
import com.cartmatic.estoresf.customer.model.SupplierUser;
import com.cartmatic.estoresf.customer.model.SupplierUser4Add;

@Controller
public class SupplierUserFrontController extends GenericStoreFrontController<Customer> {
    
    private AppUserManager appUserManager=null;
    private CustomerManager customerManager=null;

    public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

	public void setAppUserManager(AppUserManager appUserManager) {
		this.appUserManager = appUserManager;
	}

	
	@RequestMapping(value="/myaccount/supplierUser/add.html", method=RequestMethod.GET)
	public ModelAndView add(HttpServletRequest request,HttpServletResponse response) throws Exception {
		if(!checkIsAdmin()){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		Customer customer=new Customer();
		request.setAttribute("supplierUser",customer);
		request.setAttribute("couldEdit",true);
		return new ModelAndView("customer/supplierUserForm");
	}
	
	
	@RequestMapping(value="/myaccount/supplierUser/add.html", method=RequestMethod.POST)
	public ModelAndView add4Save(@Valid @ModelAttribute(value="supplierUser") SupplierUser4Add supplierUser,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Customer customer=new Customer();
		try {
			if(!checkIsAdmin()){
				//非法修改或访问
				return getRedirectView("/myaccount/invadeError.html");
			}
			BeanUtils.copyProperties(customer, supplierUser);
			
			if(StringUtils.isBlank(customer.getPassword())){
				result.rejectValue("password","customer.password.isRequired");
			}
			if(StringUtils.isBlank(customer.getConfirmPassword())||!customer.getPassword().equals(customer.getConfirmPassword())){
				result.rejectValue("confirmPassword","customer.confirmPassword.error");
			}
			
			if(appUserManager.isCustomerExist(customer.getUsername())){
				Object[] params={customer.getUsername()};
				result.rejectValue("username","appUser.username.isExist",params,"the user name has exist!");
			}
			Customer customer2=customerManager.getById(RequestContext.getCurrentUserId());
			Supplier supplier=customer2.getSupplier();
			customer.setSupplier(supplier);
			
			if(appUserManager.isEmailExist(customer)){
				result.rejectValue("email","appUser.email.isExist","the email has exist!");
			}
			
			if (!result.hasErrors()) {
				customer.setStatus(Constants.STATUS_ACTIVE);
				customerManager.saveCustomer(customer,new ArrayList<AttributeValue>());
				String msgKey = "common.added";
				saveMessage(Message.info(msgKey,"管理员",customer.getUsername()));
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			request.setAttribute("couldEdit",true);
			mav=new ModelAndView("customer/supplierUserForm");
		}else{
			mav=new ModelAndView(new RedirectView("/myaccount/supplierUser/edit/"+customer.getCustomerId()+".html"));
		}
		return mav;
	}
	
	@RequestMapping(value="/myaccount/supplierUser/edit/{id}.html", method=RequestMethod.GET)
	public ModelAndView edit(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
		
		Customer customer = mgr.loadById(id);
		if(customer==null||supplier==null||customer.getSupplierId()==null||customer.getSupplierId()!=supplier.getSupplierId().intValue()){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		//检查是否已删除，非常规处理
		if(customer!=null&&customer.getDeleted()!=null&&customer.getDeleted().intValue()==1){
			saveMessage(Message.error("supplier.error.user.deleted"));
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			return getRedirectView("/myaccount/supplierProfile.html");
		}
		request.setAttribute("couldEdit", supplier.getAdminId().intValue()==RequestContext.getCurrentUserId()||RequestContext.getCurrentUserId().intValue()==customer.getAppuserId());
		request.setAttribute("supplierUser",customer);
		return new ModelAndView("customer/supplierUserForm");
	}
	
	
	private boolean checkIsAdmin(){
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=customer.getSupplier();
		return supplier.getAdminId().intValue()==RequestContext.getCurrentUserId();
	}
	
	@RequestMapping(value="/myaccount/supplierUser/edit/{id}.html", method=RequestMethod.POST)
	public ModelAndView edit4save(@PathVariable Integer id,@Valid @ModelAttribute(value="supplierUser") SupplierUser supplierUser,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Customer currentCustomer=customerManager.getById(RequestContext.getCurrentUserId());
		Supplier supplier=currentCustomer.getSupplier();
		
		Customer entity = mgr.loadById(id);
		if(entity==null||supplier==null||entity.getSupplierId()==null||entity.getSupplierId()!=supplier.getSupplierId().intValue()){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		//检查是否已删除，非常规处理
		if(entity!=null&&entity.getDeleted()!=null&&entity.getDeleted().intValue()==1){
			saveMessage(Message.error("supplier.error.user.deleted"));
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			return getRedirectView("/myaccount/supplierProfile.html");
		}

		BeanUtils.copyProperties(supplierUser, entity, "email");
		if(appUserManager.isEmailExist(entity)){
			result.rejectValue("email","appUser.email.isExist","the email has exist!");
		}
		try {
			if (!result.hasErrors()) {
				BeanUtils.copyProperties(supplierUser, entity, "title","firstname","lastname","email","telephone","fax","note");
				customerManager.saveCustomer(entity,new ArrayList<AttributeValue>());
				String msgKey = "common.updated";
				saveMessage(Message.info(msgKey,"管理员",entity.getUsername()));
				//entity.setAddressType(Constants.ADDRESS_TYPE_SHIPPING);
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			request.setAttribute("couldEdit",true);
			mav=new ModelAndView("customer/supplierUserForm");
		}else{
			mav=new ModelAndView(new RedirectView("/myaccount/supplierUser/edit/"+id+".html"));
		}
		return mav;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cartmatic.estore.core.controller.BaseController#initController()
	 */
	@Override
	protected void initController() throws Exception {
		mgr = customerManager;
	}



	@RequestMapping(value="/myaccount/supplierUser/remove/{supplierUserId}.html")
	public ModelAndView removeUser(@PathVariable Integer supplierUserId,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Customer currentUser=customerManager.getById(RequestContext.getCurrentUserId());
		//检查是否本供应商的超级管理员
		Supplier supplier=currentUser.getSupplier();
		if(supplier.getAdminId().intValue()!=currentUser.getCustomerId()){
			saveMessage(Message.error("supplier.error.remove.user.no.authorities"));
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
		}else if(supplier.getAdminId().intValue()==supplierUserId.intValue()){
			saveMessage(Message.error("supplier.error.remove.oneself"));
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
		}else{
			Set<Customer>customers=supplier.getCustomers();
			boolean isExist=false;
			for (Customer customer : customers) {
				if(customer.getCustomerId().intValue()==supplierUserId.intValue()){
					isExist=true;
					break;
				}
			}
			if(isExist){
				Customer supplierUser=customerManager.getById(supplierUserId);
				if(supplierUser!=null){
					supplierUser.setSupplier(null);
					customerManager.save(supplierUser);
					saveMessage(Message.info("supplier.remove.user.success",supplierUser.getUsername()));
				}
			}else{
				saveMessage(Message.error("supplier.error.remove.user.no.authorities"));
				SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			}
		}
		return getRedirectView("/myaccount/supplierProfile.html");
	}
}
