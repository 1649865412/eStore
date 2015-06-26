package com.cartmatic.estoresf.cart.web.action;

import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.cart.util.CheckoutUtil;
import com.cartmatic.estore.common.model.customer.Address;
import com.cartmatic.estore.common.model.customer.AddressModel;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.util.BeanUtils;
import com.cartmatic.estore.customer.service.AddressManager;
import com.cartmatic.estore.system.service.RegionManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.SessionUtil;

@Controller
public class CheckoutAddressFrontController  extends GenericStoreFrontController<Address>  {
	
    private AddressManager addressManager = null;
    private RegionManager regionManager=null;
    

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
	
	
	@RequestMapping(value="/checkout/address.html",method=RequestMethod.POST)
	public ModelAndView saveShippingAndBilling(@Valid AddressModel addressModel,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		try {
			if (!result.hasErrors()) {
				//设置区域名称
	    		if(addressModel.getCountryId()!=null){
	    			addressModel.setCountryName(regionManager.getById(addressModel.getCountryId()).getRegionName());
	        	}
	        	if(addressModel.getStateId()!=null){
	        		addressModel.setStateName(regionManager.getById(addressModel.getStateId()).getRegionName());
	        	}
	        	if(addressModel.getCityId()!=null){
	        		addressModel.setCityName(regionManager.getById(addressModel.getCityId()).getRegionName());
	        	}

	        	if(addressModel.getB_countryId()!=null){
	    			addressModel.setB_countryName(regionManager.getById(addressModel.getB_countryId()).getRegionName());
	        	}
	        	if(addressModel.getB_stateId()!=null){
	        		addressModel.setB_stateName(regionManager.getById(addressModel.getB_stateId()).getRegionName());
	        	}
	        	//城市改为手工输入
	        	if(addressModel.getB_cityId()!=null){
	        		addressModel.setB_cityName(regionManager.getById(addressModel.getB_cityId()).getRegionName());
	        	}
	        	addressModel.setAppUser((Customer)RequestContext.getCurrentUser());
	        	
	        	if(StringUtils.isBlank(addressModel.getB_firstname())){
	            	addressModel.setB_title(addressModel.getTitle());
	            	addressModel.setB_firstname(addressModel.getFirstname());
	            	addressModel.setB_lastname(addressModel.getLastname());
	            	addressModel.setB_address(addressModel.getAddress());
	            	addressModel.setB_address2(addressModel.getB_address2());
	            	addressModel.setB_countryId(addressModel.getCountryId());
	            	addressModel.setB_countryName(addressModel.getCountryName());
	            	addressModel.setB_stateId(addressModel.getStateId());
	            	addressModel.setB_stateName(addressModel.getStateName());
	            	addressModel.setB_cityId(addressModel.getCityId());
	            	addressModel.setB_cityName(addressModel.getCityName());
	            	addressModel.setB_zip(addressModel.getZip());
	            	addressModel.setB_telephone(addressModel.getTelephone());
	            }
	        	if(!RequestContext.isAnonymousUser()){
					addressManager.createShippingAndBilling(addressModel);
	        	}
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			mav=new ModelAndView("cart/checkout_shippingAddress");
    		mav.addObject("address",addressModel);
		}else{
			mav=new ModelAndView(new RedirectView("/checkout/paymentProcess.html"));
			//记录新增的地址作为下单的运输地址
    		request.getSession().setAttribute("checkout_shippingAddressId", addressModel.getAddressId());
    		CheckoutUtil.getInstance().getCheckoutPagingModel(request).setShippingAddressId(addressModel.getAddressId());
		}
		return mav;
	}
	
	
	@RequestMapping(value="/checkout/address/add.html", method=RequestMethod.POST)
	public ModelAndView add4Save(@Valid Address address,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		try {
			if (!result.hasErrors()) {
				address.setAddressType(Constants.ADDRESS_TYPE_SHIPPING);
	            address.setAppUser((Customer)RequestContext.getCurrentUser());
	            //设置区域名称
	            address.setCountryName(regionManager.getById(address.getCountryId()).getRegionName());
	            address.setStateName(regionManager.getById(address.getStateId()).getRegionName());
	            address.setCityName(regionManager.getById(address.getCityId()).getRegionName());
	            addressManager.save(address);
	            
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		ModelAndView mav = null;
		if(result.hasErrors()){
			mav=new ModelAndView("cart/checkout_shippingAddress");
		}else{
			//支付页 
    		mav=new ModelAndView(new RedirectView("/checkout/paymentProcess.html"));
    		//记录新增的运输地址作为下单的运输地址
    		if(address.getAddressType().intValue()==Constants.ADDRESS_TYPE_SHIPPING.intValue()){
    			CheckoutUtil.getInstance().getCheckoutPagingModel(request).setShippingAddressId(address.getAddressId());
    		}
    		saveMessage(Message.info("address.created"));
		}
		return mav;
	}
	
	@RequestMapping(value="/checkout/address/addAjax.html", method=RequestMethod.POST)
	public ModelAndView addAjax(@Valid Address address,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		address.setAddressType(Constants.ADDRESS_TYPE_SHIPPING);
        address.setAppUser((Customer)RequestContext.getCurrentUser());
        //设置区域名称
//	            address.setCountryName(regionManager.getById(address.getCountryId()).getRegionName());
//	            address.setStateName(regionManager.getById(address.getStateId()).getRegionName());
//	            address.setCityName(regionManager.getById(address.getCityId()).getRegionName());
        address.setLastname("");
        address.setCountryName("中国");
        addressManager.save(address);
        AddressModel am = new AddressModel();
        am.setId(address.getAddressId());
        am.setFirstname(address.getFirstname());
        am.setStateName(address.getStateName());
        am.setCityName(address.getCityName());
        am.setSectionName(address.getSectionName());
        am.setAddress(address.getAddress());
        am.setTelephone(address.getTelephone());
        JSONObject data=JSONObject.fromObject(am);
        PrintWriter out = response.getWriter();
        out.println(data);
		return null;
	}
	
	@RequestMapping(value="/checkout/address/addBillAddr.html", method=RequestMethod.GET)
	public ModelAndView addBillAddr(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Address address = addressManager.getDefBillingAddress(RequestContext.getCurrentUserId());
		if(address!=null){
			//非法修改或访问
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("address.billingAddress.exist"));
			return getRedirectView("/checkout/shippingAddress.html");
		}
		request.setAttribute("address",new Address());
		return new ModelAndView("cart/checkout_billingAddressForm");
	}
	
	@RequestMapping(value="/checkout/address/addBillAddr.html", method=RequestMethod.POST)
	public ModelAndView addBillAddr4Save(@Valid Address address,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		try {
			Address temp_address = addressManager.getDefBillingAddress(RequestContext.getCurrentUserId());
			if(temp_address!=null){
				//非法修改或访问
				SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
				saveMessage(Message.error("address.billingAddress.exist"));
				return getRedirectView("/checkout/shippingAddress.html");
			}
			if (!result.hasErrors()) {
	            address.setIsDefaultBillingAddress(Constants.FLAG_TRUE);
				address.setAddressType(Constants.ADDRESS_TYPE_BILLING);
	            address.setAppUser((Customer)RequestContext.getCurrentUser());
	            //设置区域名称
	            address.setCountryName(regionManager.getById(address.getCountryId()).getRegionName());
	            address.setStateName(regionManager.getById(address.getStateId()).getRegionName());
	            address.setCityName(regionManager.getById(address.getCityId()).getRegionName());
	            addressManager.save(address);
			}
		} catch (ApplicationException e) {
			handleApplicationException(result, e);
		}
		
		ModelAndView mav = null;
		if(result.hasErrors()){
			mav=new ModelAndView("cart/checkout_shippingAddress");
		}else{
    		saveMessage(Message.info("address.created"));
    		mav=getRedirectView("/checkout/shippingAddress.html");
		}
		return mav;
	}
	
	@RequestMapping(value="/checkout/address/edit/{id}.html", method=RequestMethod.GET)
	public ModelAndView edit(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Address address = addressManager.getAddressByIdAndAppUserId(new Integer(id), RequestContext.getCurrentUserId());
		if(address==null){
			//非法修改或访问
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("address.not.exist"));
			return getRedirectView("/checkout/shippingAddress.html");
		}
		request.setAttribute("address",address);
		return new ModelAndView("cart/checkout_shippingAddress");
	}
	
	@RequestMapping(value="/checkout/address/edit.html", method=RequestMethod.POST)
	public ModelAndView editAddress(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String id = request.getParameter("addressId");
		Address address = addressManager.getAddressByIdAndAppUserId(new Integer(id), RequestContext.getCurrentUserId());
		AddressModel am = new AddressModel();
		am.setId(address.getAddressId());
		am.setFirstname(address.getFirstname());
		am.setZip(address.getZip());
		am.setEmail(address.getEmail());
		am.setTelephone(address.getTelephone());
		am.setAddress(address.getAddress());
		am.setStateName(address.getStateName());
		am.setCityName(address.getCityName());
		am.setSectionName(address.getSectionName());
		am.setTitle(address.getTitle());
		JSONObject data=JSONObject.fromObject(am);
        PrintWriter out = response.getWriter();
        
        out.println(data);
        
		return null;
	}
	
	@RequestMapping(value="/checkout/address/edit/{id}.html", method=RequestMethod.POST)
	public ModelAndView edit4save(@PathVariable Integer id,@Valid Address address,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Address entity = addressManager.getAddressByIdAndAppUserId(new Integer(id), RequestContext.getCurrentUserId());
		if(entity==null){
			//非法修改或访问
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("address.not.exist"));
			return getRedirectView("/checkout/shippingAddress.html");
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
			mav=new ModelAndView("cart/checkout_shippingAddress");
		}else{
			//跳回下单地址页
    		if(StringUtils.isNotBlank(request.getParameter("url"))&&request.getParameter("url").equals("paymentProcess")){
    			//当从下单支付处理修改发票地址跳过来的，修改完毕后跳回支付页
    			mav=new ModelAndView(new RedirectView("/checkout/paymentProcess.html"));  
    		}else{
    			if(entity.getAddressType().intValue()==Constants.ADDRESS_TYPE_SHIPPING){
    				CheckoutUtil.getInstance().getCheckoutPagingModel(request).setShippingAddressId(address.getAddressId());
    			}
        		mav=new ModelAndView(new RedirectView("/checkout/shippingAddress.html"));
    		}
			//成功增加或修改信息提示
    		saveMessage(Message.info("address.updated"));
		}
		return mav;
	}
	
	@RequestMapping(value="/checkout/address/delete/{id}.html", method=RequestMethod.POST)
	public ModelAndView delete(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Address address = addressManager.getAddressByIdAndAppUserId(new Integer(id), RequestContext.getCurrentUserId());
		if(address==null){
			//非法修改或访问
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("address.not.exist"));
			return getRedirectView("/checkout/shippingAddress.html");
		}
		if(address.getAddressType().intValue()!=Constants.ADDRESS_TYPE_BILLING){
			mgr.deleteById(address.getAddressId());
//			saveMessage(Message.info("address.deleted"));
		}
		return null;//getRedirectView("/checkout/shippingAddress.html");
	}

	//@RequestMapping(value="/checkout/shippingAddress/selected/{id}.html", method=RequestMethod.GET)
	@RequestMapping(value="/checkout/address.html",params="doAction=selectShippingAddress",method=RequestMethod.POST)
	public ModelAndView selectShippingAddress(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		Address address = addressManager.getAddressByIdAndAppUserId(new Integer(request.getParameter("shippingAddressId")), RequestContext.getCurrentUserId());
		if(address==null){
			//非法修改或访问
			SessionUtil.setAttribute(request.getSession(), "HAS_ERRORS", Boolean.TRUE);
			saveMessage(Message.error("address.not.exist"));
			return getRedirectView("/checkout/shippingAddress.html");
		}
		CheckoutUtil.getInstance().getCheckoutPagingModel(request).setShippingAddressId(address.getAddressId());
//		Integer shippingAddressId=CheckoutUtil.getInstance().getCheckoutPagingModel(request).getShippingAddressId();
		return new ModelAndView(new RedirectView("/checkout/paymentProcess.html"));
	}
	
}
