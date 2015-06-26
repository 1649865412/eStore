package com.cartmatic.estoresf.customer.web.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.cart.util.ShoppingCartUtil;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.core.util.StringUtil;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estore.webapp.util.RequestContext;
import com.cartmatic.estore.webapp.util.RequestUtil;

@Controller
public class LoginAjaxController extends BaseStoreFrontController{
	private AppUserManager appUserManager;
	
	private PasswordEncoder passwordEncoder;

	/**
	 * Ajax登录操作，接收username用户名和password密码。
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 */
    @RequestMapping(value="/ajaxLogin.html", method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView logion(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		AjaxView ajaxView=new AjaxView(response);
		try {
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			if(StringUtils.isBlank(username)||StringUtils.isBlank(password)){
				return ajaxView.setStatus(new Short("0"));
			}
			Customer customer = (Customer) appUserManager.getUserByName(username);
			if (customer == null) {
				return ajaxView.setStatus(new Short("0"));
			}
			if(Constants.STATUS_INACTIVE.equals(customer.getStatus())){
				return ajaxView.setStatus(new Short("0"));
			}
			//String enPassword = StringUtil.encodePassword(password, ConfigUtil.getInstance().getPasswordEncryptionAlgorithm());
			String enPassword = passwordEncoder.encodePassword(password, null);
			if (!enPassword.equals(customer.getPassword())){
				return ajaxView.setStatus(new Short("0"));
			}
			Authentication authRequest = new UsernamePasswordAuthenticationToken(username, password);
			SecurityContext securityContext = SecurityContextHolder
					.getContext();
			if (securityContext != null) {
				securityContext.setAuthentication(authRequest);
			}
			//setMembership(request, customer);
			RequestUtil.setUserInfoCookie(response, customer,(request).getContextPath());
			//合并购物车信息
			ShoppingCartUtil.getInstance().setShoppingcartInfo(request, response, customer);
			Map<String, Object> user=new HashMap<String, Object>();
			user.put("appUserId", customer.getAppuserId());
			user.put("email", customer.getEmail());
			user.put("username", customer.getUsername());
			ajaxView.setData(user);
			ajaxView.setStatus(new Short("1"));
		} catch (Exception e) {
			ajaxView.setStatus(new Short("-500"));
			e.printStackTrace();
		}
		return ajaxView;
	}

    /**
     * Ajax判断是否有当前用户。
     * @param request
     * @param response
     * @return
     * @throws ServletException
     */
    @RequestMapping(value="/ajaxCurrentUser.html", method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView getCurrentUser(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		AjaxView ajaxView=new AjaxView(response);
		Map<String, Object>user=new HashMap<String, Object>();
		ajaxView.setData(user);
		com.cartmatic.estore.core.model.AppUser appUser = RequestContext.getCurrentUser();
		user.put("appUserId", Constants.USERID_ANONYMOUS);
		ajaxView.setStatus(new Short("-1"));//未登录
		//非匿名用户（已经login的用户）才记录userid和username入cookies.
		if (appUser!=null){
			user.put("appUserId", appUser.getAppuserId());
			user.put("email", appUser.getEmail());
			user.put("username", appUser.getUsername());
			RequestUtil.setUserInfoCookie(response, appUser, (request).getContextPath());
			ajaxView.setStatus(new Short("1"));//已登录
		}
		return ajaxView;
	}
	
	public void setPasswordEncoder(PasswordEncoder avalue)
    {
    	passwordEncoder = avalue;
    }
	
	public void setAppUserManager(AppUserManager appUserManager) {
		this.appUserManager = appUserManager;
	}
}
