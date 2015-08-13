package com.cartmatic.estoresf.denglu.action;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.cart.util.ShoppingCartUtil;
import com.cartmatic.estore.common.helper.AttributeUtil;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.attribute.AttributeValue;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estore.webapp.util.RequestUtil;

@Controller
public class dengluController extends BaseStoreFrontController {
	private AppUserManager appUserManager = null;
	private CustomerManager customerManager = null;

	@RequestMapping(value = { "/customer/dengluRegister.html" })
	public ModelAndView dengluRegister(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String email = (String) request.getParameter("useremail");
		String username = (String) request.getParameter("username");
		String suffix = "@qq.com";
		try {
			Customer customer = anonymousRegister(email + suffix, username,
					request, response);
			Authentication authRequest = new UsernamePasswordAuthenticationToken(
					customer.getUsername(), customer.getPassword());
			SecurityContext securityContext = SecurityContextHolder
					.getContext();
			if (securityContext != null) {
				securityContext.setAuthentication(authRequest);
			}
			RequestUtil.setUserInfoCookie(response, customer, (request)
					.getContextPath());
			// 合并购物车信息
			ShoppingCartUtil.getInstance().setShoppingcartInfo(request,
					response, customer);
		} catch (Exception e) {
			return getRedirectView("/index.html");
		}
		return getRedirectView("/index.html");
	}

	/**
	 * 功能:匿名用户（企业e家用户与社会化分享登录用户注册）
	 * <p>
	 * 作者 杨荣忠 2015-6-5 上午11:42:26
	 * 
	 * @param customer
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public Customer anonymousRegister(String email, String firstName,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String originalPass = "";
		Customer customer = (Customer) appUserManager.getUserByName(email);
		if (customer == null) {
			try {
				customer = new Customer();
				customer.setFirstname(firstName);
				customer.setEmail(email);
				customer.setPassword("1sifangstreet1");
				// 立即激活
				customer.setStatus(Constants.STATUS_ACTIVE);
				customer.setUsername(customer.getEmail());
				// 保存自定义属性值
				originalPass = customer.getPassword();
				customer.setNewPassword(originalPass);
				List<AttributeValue> attributeValueList = AttributeUtil
						.getInstance().getAttributeFromRequest(request);
				customer.setStore(ConfigUtil.getInstance().getStore());
				customer.setRegisterIpAddress(request.getRemoteAddr());
				// 注册成功后马上登陆，一起保存登录时间
				customer.setLastLoginTime(new Date());
				customerManager.saveCustomer(customer, attributeValueList);
			} catch (ApplicationException e) {
				System.out.println("匿名用户（企业e家用户与社会化分享登录用户注册）有错！用户名是：" + email);
			}
		}
		return customer;
	}
	
	public AppUserManager getAppUserManager() {
		return appUserManager;
	}

	public void setAppUserManager(AppUserManager appUserManager) {
		this.appUserManager = appUserManager;
	}

	public CustomerManager getCustomerManager() {
		return customerManager;
	}

	public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}
}