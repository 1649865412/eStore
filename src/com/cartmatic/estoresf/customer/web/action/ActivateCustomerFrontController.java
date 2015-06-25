package com.cartmatic.estoresf.customer.web.action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.customer.ValidationSession;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.customer.service.ValidationSessionManager;
import com.cartmatic.estore.system.service.AppUserManager;
/**
 * @TODO 目前不需要激活，没有使用
 * @author csx
 * for customer activate his account
 */
@Controller
public class ActivateCustomerFrontController extends BaseStoreFrontController {

    private ValidationSessionManager validationSessionManager=null;
    private AppUserManager appUserManager=null;
    
    public void setValidationSessionManager(
            ValidationSessionManager validationSessionManager) {
        this.validationSessionManager = validationSessionManager;
    }
    
    public void setAppUserManager(AppUserManager appUserManager) {
        this.appUserManager = appUserManager;
    }
    
	@RequestMapping(value="/activateUser.html")
    public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) throws ServletException {
       String uid=request.getParameter("uid");
       if(uid!=null&&!"".equals(uid)){
           ValidationSession vs=validationSessionManager.getByUrlType(uid,ValidationSession.TYPE_CUSTOMER_ACTIVE);
           if(vs!=null){//validate,the update customer validate
               appUserManager.doActiceUserStatusByEmail(vs.getEmail());
               request.setAttribute("isRight","true");
           }else{
               //no validate
               request.setAttribute("isRight","false");
           }
       }else{
           request.setAttribute("isRight","false");
       }
        return new ModelAndView("/customer/activateUser");
    }
}
