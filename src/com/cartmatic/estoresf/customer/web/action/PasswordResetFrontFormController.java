package com.cartmatic.estoresf.customer.web.action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.customer.ValidationSession;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.core.util.StringUtil;
import com.cartmatic.estore.customer.service.ValidationSessionManager;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estoresf.customer.model.PasswordModel;
/**
 * 
 * @author Ryan
 *
 * Form Controller for customer to reset password.
 */
@Controller
@RequestMapping("/resetPassword.html")
public class PasswordResetFrontFormController extends BaseStoreFrontController {

    private ValidationSessionManager validationSessionManager=null;
    
    private AppUserManager appUserManager=null;
       
    private PasswordEncoder passwordEncoder;
    
    public void setPasswordEncoder(PasswordEncoder avalue)
    {
    	passwordEncoder = avalue;
    }
    public void setValidationSessionManager(
            ValidationSessionManager validationSessionManager) {
        this.validationSessionManager = validationSessionManager;
    }
    public void setAppUserManager(AppUserManager appUserManager) {
        this.appUserManager = appUserManager;
    }
    
	public PasswordResetFrontFormController() {
		super();
		formView="customer/resetPassword";
		successView="/signup.html";
	}
	@RequestMapping(method=RequestMethod.GET)
    public ModelAndView defaultAction(HttpServletRequest request, HttpServletResponse response) throws ServletException 
    {
        PasswordModel pm=new PasswordModel();
        String uid=request.getParameter("uid");
        if(uid!=null)pm.setUrl(uid);
        request.setAttribute("passwordModel",pm);
        return getModelAndView(formView);
    }
    
	@RequestMapping(method=RequestMethod.POST)
    public ModelAndView resetPassword(@Valid PasswordModel passwordModel,BindingResult result,HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (result.hasErrors()) {
        	 return new ModelAndView(this.formView);
        }else if(validationSessionManager.isUrlValid(passwordModel.getEmail(),passwordModel.getUrl(),ValidationSession.TYPE_PASSWORD_RECOVER)){
        	//get the proper password (may be encrypted) 
            //newPassword=StringUtil.encodePassword(passwordModel.getPassword(), ConfigUtil.getInstance().getPasswordEncryptionAlgorithm());
            String newPassword=passwordEncoder.encodePassword(passwordModel.getPassword(), null);
            //the reset password by email
         	 appUserManager.saveModifyPassword(passwordModel.getEmail(),newPassword);    		
             String loginUrl=request.getContextPath() + "/signup.html" ;            
             saveMessage(Message.info("passwordRecover.success.finish",loginUrl));  
             return new ModelAndView(new RedirectView(this.successView, true));
        }else{
        	result.rejectValue("email","passwordRecover.error.emailWrong");
             return new ModelAndView(this.formView,result.getModel());
        }
    }
}
