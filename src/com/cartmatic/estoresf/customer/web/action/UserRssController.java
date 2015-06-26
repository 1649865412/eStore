package com.cartmatic.estoresf.customer.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.customer.UserRss;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.customer.service.UserRssManager;

@Controller
public class UserRssController extends  GenericStoreFrontController<UserRss>
{

	@Autowired
	private UserRssManager userRssManager;
	
	
	@RequestMapping(value="/customer/addUserRss.html",method=RequestMethod.POST)
	public ModelAndView addUserRss(HttpServletRequest request,HttpServletResponse response)
	{
		AjaxView ajaxView = new AjaxView(response);
		String userName = request.getParameter("userName");
		String email = request.getParameter("email");
		UserRss ur = new UserRss();
		ur.setUserName(userName);
		ur.setEmail(email);
		ur.setStatus(1);
		this.userRssManager.save(ur);
		ajaxView.setStatus(new Short("1"));
		return ajaxView;
	}

	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
		
	}

	public UserRssManager getUserRssManager() {
		return userRssManager;
	}

	public void setUserRssManager(UserRssManager userRssManager) {
		this.userRssManager = userRssManager;
	}

}
