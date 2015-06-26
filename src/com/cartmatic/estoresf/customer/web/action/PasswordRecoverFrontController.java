package com.cartmatic.estoresf.customer.web.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.customer.ValidationSession;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.view.MailEngine;
import com.cartmatic.estore.customer.service.ValidationSessionManager;


@Controller
@RequestMapping("/forgetPassword.html")
public class PasswordRecoverFrontController extends BaseStoreFrontController{

	private ValidationSessionManager validationSessionManager = null;
	protected MailEngine mailEngine = null;

	@RequestMapping(method=RequestMethod.GET)
	public String form(HttpServletRequest request,HttpServletResponse response) throws ServletException {
	    return "forgetPassword";
	}

	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView requestEmailAction(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("enter PasswordRecoverFrontController requestEmailAction method...");
		}
		String email = request.getParameter("email");
		ValidationSession vs = validationSessionManager.doGenerateUrlByEmail(email.trim(), ValidationSession.TYPE_PASSWORD_RECOVER);
		String message = "";
		if (vs != null) {
			Map map = new HashMap();
			//new begin
			map.put("validationSession",vs);			
			// send email preparation.
			String emailTitle = this.getMessage("passwordRecover.email.title", new Object[]{email});
			String from = ConfigUtil.getInstance().getStore().getEmailSender();
			// construct the full url.
			//String domain = ConfigUtil.getInstance().getStoreFrontSiteUrl();
			//request.getScheme() + "://" + request.getHeader("host") + request.getContextPath();
			String fullUrl = "/resetPassword.html?uid=" + vs.getUrl();
			map.put("email", vs.getEmail());
			map.put("url", fullUrl);
			map.put("expiredDate", vs.getExpiredDate());
			map.put("ip", request.getRemoteAddr());
			//map.put("domain", domain);
			//map.put("companInfo", RequestContext.getServletContext().getAttribute("companyInfo"));
			// send email
			mailEngine.sendSimpleTemplateMail("passwordRecover.vm", map, emailTitle, from, email);
			saveMessage(Message.info("passwordRecover.email.emailSuccess",email));
			
		} else {
			saveMessage(Message.error("passwordRecover.error.emailWrong",email));
		}
		return new ModelAndView("/forgetPassword");
	}

	public void setValidationSessionManager(ValidationSessionManager validationSessionManager) {
		this.validationSessionManager = validationSessionManager;
	}
	
	public void setMailEngine(MailEngine mailEngine) {
        this.mailEngine = mailEngine;
    }
}
