package com.cartmatic.estoresf.customer.web.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.customer.TextMessage;
import com.cartmatic.estore.core.view.MailEngine;
import com.cartmatic.estore.customer.service.TextMessageManager;
import com.cartmatic.estoresf.customer.model.ContactUSModel;
import com.octo.captcha.service.CaptchaServiceException;
import com.octo.captcha.service.image.ImageCaptchaService;
import common.Logger;

@Controller
public class ContactUsController 
{
	private Logger logger = Logger.getLogger(getClass());
    protected MailEngine mailEngine = null;	
    private ImageCaptchaService imageCaptchaService=null;
    private TextMessageManager textMessageManager=null;
    
	
	public void setTextMessageManager(TextMessageManager textMessageManager) {
		this.textMessageManager = textMessageManager;
	}
	public void setImageCaptchaService(ImageCaptchaService imageCaptchaService) {
		this.imageCaptchaService = imageCaptchaService;
	}
	@RequestMapping(value="/contactUsForm.html",method={RequestMethod.GET,RequestMethod.POST})
	public String defaultAction(HttpServletRequest request, HttpServletResponse response) throws ServletException 
	{
		return "contactus";
	}

    private String getNullSafeParameter(HttpServletRequest request,
			String paramName) {
		if (request.getParameter(paramName) == null) {
			return "";
		} else {
			return request.getParameter(paramName).toString().trim();
		}
	}
    @RequestMapping(value="/contactUsForm.html",params="doAction=sendContact", method=RequestMethod.POST)
	public ModelAndView sendContact(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		ContactUSModel contactUSModel=this.buildContactUSModel(request);        
        String captchaId = request.getSession().getId();
        String validationCode = request.getParameter("validationCode");
		// validate validation code
		try {
		    boolean isValidationCodeCorrect = false;
			if (validationCode != null) {
				isValidationCodeCorrect = imageCaptchaService.validateResponseForID(captchaId, validationCode).booleanValue();
			}
			
			if (isValidationCodeCorrect)
			{
			    Map map = new HashMap();
                map.put("contactUSModel", contactUSModel);
                String x_f = request.getHeader("HTTP_X_FORWARDED_FOR");
                if (x_f != null)
                {
                    map.put("clientIP", x_f);
                    map.put("proxyIP", request.getRemoteAddr());
                }
                else
                {
                    map.put("clientIP", request.getRemoteAddr());
                    map.put("proxyIP", "N/A");
                }
                String mailFrom = contactUSModel.getFullName()+ "<"+contactUSModel.getEmail()+">";
                String mailTo = ConfigUtil.getInstance().getStore().getEmail();
                mailEngine.sendSimpleTemplateMail("customer/contactus.vm", mailFrom, map, null, mailFrom, mailTo);
			}
			else {
				request.setAttribute("contactUSModel", contactUSModel);
				request.setAttribute("info","error");
				return new ModelAndView("contactus");
			}
			//this.mailTemplateSpecifyService.sendContactUS(contactUSModel);
			
		} catch (CaptchaServiceException e) {
			logger.error(e);
			// should not happen, may be thrown if the id is not valid
		}
        return new ModelAndView("redirect:contactus.html?info=Success&fullName="+contactUSModel.getFullName());
	}
	
	private ContactUSModel buildContactUSModel(HttpServletRequest request){
		ContactUSModel contactUSModel=new ContactUSModel();
		contactUSModel.setFullName(this.getNullSafeParameter(request, "fullName"));
		contactUSModel.setEmail(this.getNullSafeParameter(request, "email"));
		contactUSModel.setPhoneNumber(this.getNullSafeParameter(request, "phoneNumber"));
		contactUSModel.setCity(this.getNullSafeParameter(request, "city"));
		contactUSModel.setCountry(this.getNullSafeParameter(request, "country"));
		contactUSModel.setOrderNo(this.getNullSafeParameter(request, "orderNo"));
		contactUSModel.setSubject(this.getNullSafeParameter(request, "subject"));
		contactUSModel.setComments(this.getNullSafeParameter(request, "comments"));
		return contactUSModel;
	}
	

    @RequestMapping(value="/contactUsForm.html",params="doAction=inquiry", method=RequestMethod.POST)
	public ModelAndView inquiry(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		Map<String,Object> result=new HashMap<String, Object>();
		ContactUSModel contactUSModel=this.buildContactUSModel(request);        
        String captchaId = request.getSession().getId();
        String validationCode = request.getParameter("validationCode");
		// validate validation code
		try {
			if (validationCode != null) {
				boolean isValidationCodeCorrect = imageCaptchaService.validateResponseForID(captchaId, validationCode).booleanValue();
				if (!isValidationCodeCorrect) {
					result.put("info", "error");
//					return getModelAndView("contactus");
				}else{
					Map map = new HashMap();
					contactUSModel.setComments(contactUSModel.getComments()+"<br />Site:<br /><a href=\""+ConfigUtil.getInstance().getStore().getSiteUrl()+request.getParameter("productLinkUrl")+"\">"+ConfigUtil.getInstance().getStore().getSiteUrl()+request.getParameter("productLinkUrl")+"</a>");
					map.put("contactUSModel", contactUSModel);
					String mailFrom = contactUSModel.getEmail();
					String mailTo = ConfigUtil.getInstance().getStore().getEmail();
					mailEngine.sendSimpleTemplateMail("customer/contactus.vm", mailFrom, map, "Inquiry", mailFrom, mailTo);
					result.put("info", "ok");
				}
			}
		} catch (CaptchaServiceException e) {
			logger.error(e);
//			e.printStackTrace();
			result.put("info", "error");
		}
		result.put("action", "1");
		try {
			response.getWriter().print(JSONObject.fromObject(result).toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void setMailEngine(MailEngine mailEngine) {
        this.mailEngine = mailEngine;
    }
	
	@RequestMapping(value="/text-message.html",method=RequestMethod.GET)
	public String textMessege(HttpServletRequest request, HttpServletResponse response) throws ServletException 
	{
		return "textMessege";
	}
	
	@RequestMapping(value="/text-message.html",method=RequestMethod.POST)
	public ModelAndView postTextMessege(HttpServletRequest request, HttpServletResponse response) throws ServletException 
	{
		String tel1=request.getParameter("tel1");
		tel1=tel1==null?"":tel1;
		String tel2=request.getParameter("tel2");
		tel2=tel2==null?"":tel2;
		String tel3=request.getParameter("tel3");
		tel3=tel3==null?"":tel3;
		String email=request.getParameter("email");
		TextMessage textMessage=new TextMessage();
		textMessage.setPhone(tel1+"-"+tel2+"-"+tel3);
		textMessage.setEmail(email);
		String mailFrom=email;
		textMessageManager.save(textMessage);
        return new ModelAndView("redirect:text-message.html?info=Success");
	}
}
