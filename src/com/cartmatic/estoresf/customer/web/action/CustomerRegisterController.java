package com.cartmatic.estoresf.customer.web.action;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.cart.util.ShoppingCartUtil;
import com.cartmatic.estore.common.helper.AttributeUtil;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.attribute.AttributeValue;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.core.view.MailEngine;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estore.webapp.util.RequestUtil;



@Controller
public class CustomerRegisterController extends GenericStoreFrontController<Customer>{
		private CustomerManager customerManager=null;
		private AppUserManager appUserManager=null;
	    private MailEngine mailEngine = null;
	    
	    public void setCustomerManager(CustomerManager customerManager) {
			this.customerManager = customerManager;
		}

		public void setAppUserManager(AppUserManager appUserManager) {
			this.appUserManager = appUserManager;
		}
		
		public void setMailEngine(MailEngine avalue)
		{
		    mailEngine = avalue;
		}
		
		private void newsletter(Customer customer,HttpServletRequest request){
			//订阅邮件 ,只有生产模式下才执行.
			if("1".equals(request.getParameter("newsletter")) && ConfigUtil.getInstance().getIsProductionMode()){
				HttpURLConnection connection=null;
				try {
					String mailMarketerUrl=ConfigUtil.getInstance().getMailMarketerUrl();
					URL newsletterUrl=new URL(mailMarketerUrl+"&email="+ customer.getEmail());
					connection=(HttpURLConnection)newsletterUrl.openConnection();
					connection.setRequestMethod("GET");            
					//connection.setDoInput(true); 
					//connection.setDoOutput(true);
					connection.connect();
		            //OutputStream out = connection.getOutputStream();
		            //out.write(("&email="+customer.getEmail()).getBytes());
		            //out.flush();
		            //out.close();
		            int code = connection.getResponseCode();
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					if(connection!=null)connection.disconnect(); 
				}
			}
		}

		
	    @RequestMapping(value="/signup.html",method=RequestMethod.GET)
		public ModelAndView signup(HttpServletRequest request,HttpServletResponse response) throws Exception {
			return new ModelAndView("signup");
		}
	    
	    
	    @RequestMapping(value={"/register.html", "/checkout/register.html"},method=RequestMethod.POST)
		public ModelAndView register(@Valid Customer customer,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
			String originalPass = "";
	    	//检查email是否已使用
			if (!result.hasErrors()) {
				if(appUserManager.isEmailExist(customer)){
					result.rejectValue("email","appUser.email.isExist","the email has exist!");
				}
			}
			ModelAndView mav = null;
			try {
				if (result.hasErrors()) {
					return new ModelAndView("signup");
				}else{
					//立即激活
					customer.setStatus(Constants.STATUS_ACTIVE);
					customer.setUsername(customer.getEmail());
					
					//保存自定义属性值
				    originalPass = customer.getPassword();
				    //setup newpassowrd
				    customer.setNewPassword(originalPass);
	                List<AttributeValue> attributeValueList = AttributeUtil.getInstance().getAttributeFromRequest(request);
	                customer.setStore(ConfigUtil.getInstance().getStore());
	                customer.setRegisterIpAddress(request.getRemoteAddr());
					//注册成功后马上登陆，一起保存登录时间
	                customer.setLastLoginTime(new Date());
					customerManager.saveCustomer(customer, attributeValueList);
					//订阅邮件 ,只有生产模式下才执行.
					newsletter(customer, request);
				}
			} catch (ApplicationException e) {
				handleApplicationException(result, e);
			}
			if (result.hasErrors()) {
				mav = signup(request, response);
			} else {
				//保存成功时进入的页面
				if(request.getRequestURI().indexOf("/checkout/")!=-1){
		        	//下单时，创建用户的直接跳到运输地址页面
					mav=new ModelAndView(new RedirectView("/checkout/login.html",true));
		        }else{
		        	mav=new ModelAndView(new RedirectView("/myaccount/account.html",true));
		        	//Send a email
		        	Map model = new HashMap();

					String from=ConfigUtil.getInstance().getStore().getEmailSender();
		        	mailEngine.sendSimpleTemplateMail("customer/registerSuccess.vm", model, null, from, new String[]{customer.getEmail()});
		        }
				//注册成功后马上登陆
		    	Authentication authRequest = new UsernamePasswordAuthenticationToken(customer.getUsername(), originalPass);
				SecurityContext securityContext = SecurityContextHolder.getContext();
				if (securityContext != null) {
					securityContext.setAuthentication(authRequest);
				}
				//setMembership(request, customer);
				RequestUtil.setUserInfoCookie(response, customer,(request).getContextPath());
				//合并购物车信息
				ShoppingCartUtil.getInstance().setShoppingcartInfo(request, response, customer);
			}
			return mav;
		}
	    
	    /**
	     * Ajax用户注册操作，使用customer实体接收参数。
	     * @param customer
	     * @param result
	     * @param request
	     * @param response
	     * @return
	     * @throws Exception
	     */
	    @RequestMapping(value={"/ajaxRegister.html"},method={RequestMethod.POST,RequestMethod.GET})
		public ModelAndView ajaxRegister(@Valid Customer customer,BindingResult result,HttpServletRequest request,HttpServletResponse response) throws Exception {
	    	AjaxView ajaxView=new AjaxView(response);
			String originalPass = "";
			
			if (result.hasErrors()) {
				ajaxView.setStatus(new Short("0"));//errors
			}
			
	    	//检查email是否已使用
			if (!result.hasErrors()) {
				if(appUserManager.isEmailExist(customer)){
					result.rejectValue("email","appUser.email.isExist","the email has exist!");
					ajaxView.setStatus(new Short("-1"));//用户email已经存在
				}
			}
			try {
				if (!result.hasErrors()) {
					//立即激活
					customer.setStatus(Constants.STATUS_ACTIVE);
					customer.setUsername(customer.getEmail());
					
					//保存自定义属性值
				    originalPass = customer.getPassword();
				    //setup newpassowrd
				    customer.setNewPassword(originalPass);
	                List<AttributeValue> attributeValueList = AttributeUtil.getInstance().getAttributeFromRequest(request);
	                customer.setStore(ConfigUtil.getInstance().getStore());
	                customer.setRegisterIpAddress(request.getRemoteAddr());
					//注册成功后马上登陆，一起保存登录时间
	                customer.setLastLoginTime(new Date());
					customerManager.saveCustomer(customer, attributeValueList);
					//订阅邮件 ,只有生产模式下才执行.
//					newsletter(customer, request);
					//注册成功后马上登陆
			    	Authentication authRequest = new UsernamePasswordAuthenticationToken(customer.getUsername(), originalPass);
					SecurityContext securityContext = SecurityContextHolder.getContext();
					if (securityContext != null) {
						securityContext.setAuthentication(authRequest);
					}
					//setMembership(request, customer);
					RequestUtil.setUserInfoCookie(response, customer,(request).getContextPath());
					Map<String, Object> user=new HashMap<String, Object>();
					user.put("appUserId", customer.getAppuserId());
					user.put("email", customer.getEmail());
					user.put("username", customer.getUsername());
					ajaxView.setData(user);
					ajaxView.setStatus(new Short("1"));//success
				}
			} catch (ApplicationException e) {
				handleApplicationException(result, e);
				ajaxView.setStatus(new Short("-2"));//exception
			}
			return ajaxView;
		}

		@Override
		protected void initController() throws Exception {
			mgr=customerManager;
		}

}
