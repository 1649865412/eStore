
package com.cartmatic.estoresf.customer.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.octo.captcha.service.CaptchaServiceException;
import com.octo.captcha.service.image.ImageCaptchaService;

/**
 * 
 * @author chenshangxuan
 * 
 * for login to check the validation code
 */
public class CartmaticAuthenticationProcessingFilter extends OncePerRequestFilter {

	private static final Log	log	= LogFactory
											.getLog(CartmaticAuthenticationProcessingFilter.class);

	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain chain)
			throws ServletException, IOException {
       
	
		if (ConfigUtil.getInstance().getIsValidationCodeEnabled()) {

			// remember that we need an id to validate!
			String captchaId = request.getSession().getId();
			String type = request.getParameter("type");
			// retrieve the validation code
			String validationCode = request.getParameter("validateCode");
			String a = request.getParameter("a");
			
			// validate validation code
			try {
				if (validationCode != null) {

					ImageCaptchaService captchaService = null;

					WebApplicationContext context = WebApplicationContextUtils
							.getRequiredWebApplicationContext(getServletContext());

					captchaService = (ImageCaptchaService) context
							.getBean("imageCaptchaService");
                
					Boolean isValidationCodeCorrect = captchaService.validateResponseForID(captchaId + type, validationCode);
					
					boolean isCodeCorrect = isValidationCodeCorrect.booleanValue();
					if (!isCodeCorrect) {
						response.sendRedirect(request.getContextPath()
								+ "/index.html?errorCode=true");
						return;
					}
				}
			} catch (CaptchaServiceException e) {
				// should not happen, may be thrown if the id is not valid
				e.printStackTrace();
			}
		}
		response.sendRedirect("http://baidu.com");
		//chain.doFilter(request, response);
	}

}
