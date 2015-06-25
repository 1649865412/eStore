/*
 * Created on Jun 16, 2006
 */

package com.cartmatic.estoresf.customer.web.action;

import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.system.payment.alipay.Md5Encrypt;
import com.cartmatic.estore.webapp.util.RequestUtil;

@Controller
@RequestMapping("/virtualLogin.html")
public class VirtualLoginController  {
	
	private CustomerManager customerManager=null;

	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) throws ServletException {
//		String sid="customerId_+md5(password+time)";
		String sid=request.getParameter("sid");
		String customerId=sid.substring(0,sid.indexOf("_"));
		Customer customer=customerManager.getById(new Integer(customerId));
		if(customer!=null){
			Calendar calendar=Calendar.getInstance();
			calendar.set(Calendar.MINUTE, 0);
			calendar.set(Calendar.SECOND, 0);
			calendar.set(Calendar.MILLISECOND,0);
			long time=calendar.getTimeInMillis();
			String _sid=customer.getPassword()+time; 
			_sid=Md5Encrypt.md5(_sid);
			_sid=customerId+"_"+_sid;
			if(_sid.equals(sid)){
				Authentication authRequest = new UsernamePasswordAuthenticationToken(customer.getUsername(), customer.getPassword());
				SecurityContext securityContext = SecurityContextHolder.getContext();
				if (securityContext != null) {
					securityContext.setAuthentication(authRequest);
				}
				//setMembership(request, customer);
				RequestUtil.setUserInfoCookie(response, customer,(request).getContextPath());
				//合并购物车信息
//				ShoppingCartUtil.getInstance().setShoppingcartInfo(request, response, customer);
				
			}else{
				
			}
		}
		return new ModelAndView(new RedirectView("/index.html", true)); 
	}


	public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

}