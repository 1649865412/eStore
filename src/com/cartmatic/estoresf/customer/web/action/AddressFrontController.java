package com.cartmatic.estoresf.customer.web.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.common.model.customer.Address;
import com.cartmatic.estore.common.model.customer.AddressModel;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.Membership;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.util.BeanUtils;
import com.cartmatic.estore.customer.service.AddressManager;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.system.service.RegionManager;
import com.cartmatic.estore.webapp.util.RequestContext;


@Controller
public class AddressFrontController extends GenericStoreFrontController<Address> {
    private AddressManager addressManager = null;
    private RegionManager regionManager=null;
    
	@Autowired
	private CustomerManager customerManager;
	
	@Autowired
	private MembershipManager membershipManager;

    public void setRegionManager(RegionManager regionManager) {
		this.regionManager = regionManager;
	}

	public void setAddressManager(AddressManager inMgr) {
        this.addressManager = inMgr;
    }

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cartmatic.estore.core.controller.BaseController#initController()
	 */
	@Override
	protected void initController() throws Exception {
		mgr = addressManager;
	}
	
	@RequestMapping(value="/myaccount/address.html",method=RequestMethod.GET)
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		//获取运输地址及发票地址
		Integer currentUserId=RequestContext.getCurrentUserId();
		List<Address> shippingAddressList=addressManager.getAllShippingAddressByAppuserId(currentUserId);
		Address billingAddress=addressManager.getDefBillingAddress(currentUserId);
		if(billingAddress==null){
			request.setAttribute("createShippingAndBilling", true);
		}
		request.setAttribute("shippingAddressList", shippingAddressList);
		request.setAttribute("billingAddress", billingAddress);
		request.setAttribute("address", new AddressModel());
        Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
		return new ModelAndView("/customer/addressList");
	}
	
	
	@RequestMapping(value="/myaccount/address/add.html", method=RequestMethod.GET)
	public ModelAndView add(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Address address=new Address();
		request.setAttribute("address",address);
		return new ModelAndView("/customer/addressForm");
	}
	
	@RequestMapping(value="/myaccount/address/add.html", method=RequestMethod.POST)
	public ModelAndView add4Save(@Valid Address address,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		try {
				address.setAddressType(Constants.ADDRESS_TYPE_SHIPPING);
	            address.setAppUser((Customer)RequestContext.getCurrentUser());
	            //设置区域名称
//	            address.setCountryName(regionManager.getById(address.getCountryId()).getRegionName());
//	            address.setStateName(regionManager.getById(address.getStateId()).getRegionName());
//	            address.setCityName(regionManager.getById(address.getCityId()).getRegionName());
	            
	            address.setLastname("");
	            address.setCountryName("中国");
	            
	            addressManager.save(address);
	            
	            Integer currentUserId=RequestContext.getCurrentUserId();
				Address billingAddress=addressManager.getDefBillingAddress(currentUserId);
				//不存在发票地址时，同时创建运输地址
				if(billingAddress==null){
					billingAddress=new Address();
					billingAddress.setAddress(address.getAddress());
					billingAddress.setAddress2(address.getAddress2());
					billingAddress.setAppUser(address.getAppUser());
//					billingAddress.setCityId(address.getCityId());
					billingAddress.setSectionName(address.getSectionName());
					billingAddress.setCityName(address.getCityName());
//					billingAddress.setStateId(address.getStateId());
					billingAddress.setStateName(address.getStateName());
//					billingAddress.setCountryId(address.getCountryId());
					billingAddress.setCountryName(address.getCountryName());
					billingAddress.setTelephone(address.getTelephone());
					billingAddress.setZip(address.getZip());
					billingAddress.setTitle(address.getTitle());
					billingAddress.setFirstname(address.getFirstname());
					billingAddress.setLastname(address.getLastname());
					billingAddress.setAddressType(Constants.ADDRESS_TYPE_BILLING);
					billingAddress.setIsDefaultBillingAddress(Constants.FLAG_TRUE);
					addressManager.save(billingAddress); 
				}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
//		if(result.hasErrors()){
//			mav=new ModelAndView("/customer/addressForm");
//		}else{
			saveMessage(Message.info("address.updated"));
			mav=new ModelAndView(new RedirectView("/myaccount/address.html"));
//		}
		return mav;
	}
	
	@RequestMapping(value="/myaccount/address/edit/{id}.html", method=RequestMethod.GET)
	public ModelAndView edit(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Address address = addressManager.getAddressByIdAndAppUserId(new Integer(id), RequestContext.getCurrentUserId());
		if(address==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		Customer customer=customerManager.getById(RequestContext.getCurrentUserId());
		request.setAttribute("customer", customer);
		Membership membership = membershipManager.getById(customer.getMembershipId());
        request.setAttribute("membership", membership);
		request.setAttribute("address",address);
		return new ModelAndView("/customer/addressForm");
	}
	
	@RequestMapping(value="/myaccount/address/edit/{id}.html", method=RequestMethod.POST)
	public ModelAndView edit4save(@PathVariable Integer id,@Valid Address address,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Address entity = addressManager.getAddressByIdAndAppUserId(new Integer(id), RequestContext.getCurrentUserId());
		if(entity==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		try {
			if (!result.hasErrors()) {
				BeanUtils.copyProperties(address, entity, "title","firstname","lastname","telephone","zip","address","address2","cityId","countryId","stateId");
				//entity.setAddressType(Constants.ADDRESS_TYPE_SHIPPING);
				entity.setAppUser((Customer)RequestContext.getCurrentUser());
	            //设置区域名称
				entity.setCountryName(regionManager.getById(entity.getCountryId()).getRegionName());
				entity.setStateName(regionManager.getById(entity.getStateId()).getRegionName());
				entity.setCityName(regionManager.getById(entity.getCityId()).getRegionName());
	            addressManager.save(entity);
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			mav=new ModelAndView("/customer/addressForm");
		}else{
			saveMessage(Message.info("address.updated"));
			mav=getRedirectView("/myaccount/address.html");
		}
		return mav;
	}
	
	@RequestMapping(value="/myaccount/address/delete/{id}.html", method=RequestMethod.GET)
	public ModelAndView delete(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Address address = addressManager.getAddressByIdAndAppUserId(new Integer(id), RequestContext.getCurrentUserId());
		if(address==null){
			//非法修改或访问
			return getRedirectView("/myaccount/invadeError.html");
		}
		if(address.getAddressType().intValue()!=Constants.ADDRESS_TYPE_BILLING){
			mgr.deleteById(address.getAddressId());
			saveMessage(Message.info("address.deleted"));
		}
		return getRedirectView("/myaccount/address.html");
	}
}
