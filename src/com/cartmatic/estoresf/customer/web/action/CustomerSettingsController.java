package com.cartmatic.estoresf.customer.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Membership;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.util.StringUtil;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.estoresf.customer.model.CustomerSettingsAccountModel;
import com.cartmatic.estoresf.customer.model.CustomerSettingsInfoModel;
import com.cartmatic.estoresf.customer.model.CustomerSettingsPasswordModel;

@Controller
@RequestMapping("/myaccount/settings.html")
public class CustomerSettingsController extends  GenericStoreFrontController<Customer>{
	private CustomerManager customerManager=null;
	private AppUserManager appUserManager=null;
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private MembershipManager membershipManager;
	
	public void setPasswordEncoder(PasswordEncoder avalue)
    {
    	passwordEncoder = avalue;
    }
    public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

	public void setAppUserManager(AppUserManager appUserManager) {
		this.appUserManager = appUserManager;
	}

	//@RequestMapping(value={"/myaccount/settings.html", "/myaccount/settings/profile.html", "/myaccount/settings/email.html", "/myaccount/settings/password.html"},method=RequestMethod.GET)
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response) {
        if (logger.isDebugEnabled()) {
            logger.debug("entering 'CustomerSettingsController defaultAction' method...");
        }
        Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
        setModelData(request, customer);
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
    	return new ModelAndView("customer/settings");
    }
	

	private void setModelData(HttpServletRequest request,Customer customer){
		CustomerSettingsInfoModel customerSettingsInfoModel=new CustomerSettingsInfoModel();
		if(customerSettingsInfoModel.getTitle()==null){
			customerSettingsInfoModel.setTitle(customer.getTitle());
		}
		if(customerSettingsInfoModel.getFirstname()==null){
			customerSettingsInfoModel.setFirstname(customer.getFirstname());
		}
		if(customerSettingsInfoModel.getLastname()==null){
			customerSettingsInfoModel.setLastname(customer.getLastname());
		}
		request.setAttribute("customerSettingsInfoModel", customerSettingsInfoModel);
		
		CustomerSettingsAccountModel customerSettingsAccountModel=new CustomerSettingsAccountModel();
		if(customerSettingsAccountModel.getEmail()==null){
			customerSettingsAccountModel.setEmail(customer.getEmail());
		}
		request.setAttribute("customerSettingsAccountModel", customerSettingsAccountModel);
		CustomerSettingsPasswordModel customerSettingsPasswordModel=new CustomerSettingsPasswordModel();
		request.setAttribute("customerSettingsPasswordModel", customerSettingsPasswordModel);
	}
	
	@RequestMapping(params="doAction=changeProfile", method=RequestMethod.POST)
	public ModelAndView changeProfile(@Valid CustomerSettingsInfoModel customerSettingsInfoModel,BindingResult result,HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.getSession().setAttribute("settingsShowTab", "1");
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		try {
			if (!result.hasErrors()) {
				customer.setTitle(customerSettingsInfoModel.getTitle());
				customer.setFirstname(customerSettingsInfoModel.getFirstname());
				customer.setLastname(customerSettingsInfoModel.getLastname());
				customerManager.save(customer);
				RequestUtil.setUserInfoCookie(response, customer,(request).getContextPath());
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			setModelData(request,customer);
			mav=new ModelAndView("customer/settings");
		}else{
			saveMessage(Message.info("customer.information.modified"));
			mav=new ModelAndView(new RedirectView("/myaccount/settings.html"));
		}
		return mav;
	}
	
	@RequestMapping(params="doAction=changeEmail", method=RequestMethod.POST)
	public ModelAndView changeEmail(@Valid CustomerSettingsAccountModel customerSettingsAccountModel,BindingResult result,HttpServletRequest request, HttpServletResponse response) throws Exception{
		request.getSession().setAttribute("settingsShowTab", "2");
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		try {
			String password = passwordEncoder.encodePassword(customerSettingsAccountModel.getPassword(), null);
			//String password = StringUtil.encodePassword(customerSettingsAccountModel.getPassword(), ConfigUtil.getInstance().getPasswordEncryptionAlgorithm());
			if(!customer.getPassword().equals(password)){
				result.rejectValue("password","customer.password.error");
			}
			customer.setEmail(customerSettingsAccountModel.getEmail());
			if(appUserManager.isEmailExist(customer)){
				result.rejectValue("email","customer.email.exis");
			}
			
			if (!result.hasErrors()) {
				customerManager.save(customer);
				RequestUtil.setUserInfoCookie(response, customer,(request).getContextPath());
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			setModelData(request,customer);
			mav=new ModelAndView("customer/settings");
		}else{
			saveMessage(Message.info("customer.account.modified"));
			mav=new ModelAndView(new RedirectView("/myaccount/settings.html"));
		}
		return mav;
	}
	
	@RequestMapping(params="doAction=changePassword", method=RequestMethod.POST)
	public ModelAndView changePassword(@Valid CustomerSettingsPasswordModel customerSettingsPasswordModel,BindingResult result,HttpServletRequest request, HttpServletResponse response)throws Exception {
		request.getSession().setAttribute("settingsShowTab", "3");
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		try {
			//String password = StringUtil.encodePassword(customerSettingsPasswordModel.getPassword(), ConfigUtil.getInstance().getPasswordEncryptionAlgorithm());
			String password = passwordEncoder.encodePassword(customerSettingsPasswordModel.getPassword(), null);
			if((!result.hasErrors())&&!customer.getPassword().equals(password)){
				result.rejectValue("password","customer.password.error");
			}
			
			if (!result.hasErrors()) {
				customer.setNewPassword(customerSettingsPasswordModel.getNewPassword());
				customerManager.saveCustomer(customer, null);
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			setModelData(request,customer);
			mav=new ModelAndView("customer/settings");
		}else{
			saveMessage(Message.info("customer.password.modified",new Object[]{customer.getEmail()}));
			mav=new ModelAndView(new RedirectView("/myaccount/settings.html"));
		}
		return mav;
	}
    
	@Override
	protected void initController() throws Exception {
		mgr=customerManager;
	}
}