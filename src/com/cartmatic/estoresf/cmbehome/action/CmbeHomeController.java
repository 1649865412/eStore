package com.cartmatic.estoresf.cmbehome.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.cart.util.ShoppingCartUtil;
import com.cartmatic.estore.common.helper.AttributeUtil;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.attribute.AttributeValue;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.order.SalesOrder;
import com.cartmatic.estore.common.model.system.PaymentMethod;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.core.exception.ApplicationException;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.order.OrderConstants;
import com.cartmatic.estore.order.service.SalesOrderManager;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estore.system.service.PaymentHistoryManager;
import com.cartmatic.estore.system.service.PaymentMethodManager;
import com.cartmatic.estore.webapp.util.RequestUtil;
import com.cartmatic.estoresf.cmbehome.action.help.CmbeHomeHelp;
import com.cartmatic.estoresf.cmbehome.action.help.HttpServices;
import com.cartmatic.estoresf.cmbehome.action.help.UcsApiMessage;
import com.cartmatic.estoresf.cmbehome.action.security.CertificateVerifier;
import com.cartmatic.estoresf.cmbehome.action.security.PfxSigner;
import com.cartmatic.estoresf.cmbehome.action.security.SignatureFactory;

/**
 * 招商银行企业e家跳转路径 规则：来自e家的路径做跳转，一方面判断用户是不是，另一方面路径重跳转 <code>CmbeHome.java</code>
 * <p>
 * <p>
 * Copyright 2015 All right reserved.
 * 
 * @author admin 时间 2015-5-27 上午11:27:27
 * @version 1.0 </br>最后修改人 无
 */
@Controller
public class CmbeHomeController extends BaseStoreFrontController
{
	private CustomerManager customerManager = null;
	
	private AppUserManager appUserManager=null;
	
	private PaymentMethodManager paymentMethodManager=null;
	
	private SalesOrderManager salesOrderManager =null;
	
	
	//http://localhost:8080/new-arrivals/new-week_catalog_cmbeHome.html
	//http://localhost:8080/Ucs.Creditpay.Demo
	/**
	 * 企业e家
	 */
	//http://www.sifangstreet.com/index_cmbeHome.html
	@RequestMapping(value ={"/product/*_cmbeHome.html" ,"/**/*_cmbeHome.html"})
	public ModelAndView changeUrl(HttpServletRequest request, HttpServletResponse response,String targetUrl) throws Exception
	{   
		String url="";
		System.out.println("targetUrl:==============="+targetUrl);
		PaymentMethod paymentMethod=paymentMethodManager.getById(29);
	    CertificateVerifier verifier = new CertificateVerifier(
	    paymentMethod.getConfigData().get("rootCertificatePath"));
	    SignatureFactory.addVerifier("verifier", verifier);
		url = request.getParameter("targetUrl");
	//	url=CmbeHomeHelp.changeUrl( request, url);
		url = targetUrl;
		String suffix ="@qq.com";
		try
		{   
			Response1000 response1000 = getResponseCmbeHome(request);
		    Customer customer  = anonymousRegister( response1000.getUSRNBR()+suffix ,response1000.getUSRName(), request, response);
			customer.setCmbeHome(response1000.getToken());
		 	customer.setCmbeHomeUser(response1000.getUSRNBR());
			System.out.println("getUSRName：====================================="+response1000.getUSRName());
			System.out.println("getUSRNBR：====================================="+response1000.getUSRNBR());
	        System.out.println("getToken：====================================="+response1000.getToken());
	        
			/*Customer customer  = anonymousRegister( "95623"+suffix ,"招行小企业e家" ,request, response);
		 	customer.setCmbeHome("a48d961a-9956-41f3-80fe-d65345ab1bf3");
		 	customer.setCmbeHomeUser("NW00003590");*/
        
        	Authentication authRequest = new UsernamePasswordAuthenticationToken(customer.getUsername(), customer
					.getPassword());
			SecurityContext securityContext = SecurityContextHolder.getContext();
			if (securityContext != null)
			{
				securityContext.setAuthentication(authRequest);
			}
			RequestUtil.setUserInfoCookieCMHOME(response, customer, (request).getContextPath());
			// 合并购物车信息
			ShoppingCartUtil.getInstance().setShoppingcartInfo(request, response, customer);
		}
		catch(Exception e){
			e.printStackTrace();
			System.out.println("招商那边过来进入报异常");
			return getRedirectView(url);
		}
		return getRedirectView(url);
	}
	
	

	 
	/**
	 * 功能:匿名用户（企业e家用户与社会化分享登录用户注册）
	 * <p>作者 杨荣忠 2015-6-5 上午11:42:26
	 * @param customer
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public Customer  anonymousRegister(String email ,String firstName,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String originalPass = "";
		Customer customer=(Customer) appUserManager.getUserByName(email);
		if(customer==null){
			try {   
				customer = new Customer();
			    customer.setFirstname(firstName);
			    customer.setEmail(email);
			    customer.setPassword("1sifangstreet1");
				//立即激活
				customer.setStatus(Constants.STATUS_ACTIVE);
				customer.setUsername(customer.getEmail());
				//保存自定义属性值
			    originalPass = customer.getPassword();
			    customer.setNewPassword(originalPass);
                List<AttributeValue> attributeValueList = AttributeUtil.getInstance().getAttributeFromRequest(request);
                customer.setStore(ConfigUtil.getInstance().getStore());
                customer.setRegisterIpAddress(request.getRemoteAddr());
				//注册成功后马上登陆，一起保存登录时间
                customer.setLastLoginTime(new Date());
				customerManager.saveCustomer(customer, attributeValueList);
		} catch (ApplicationException e) {
		     	System.out.println("匿名用户（企业e家用户与社会化分享登录用户注册）有错！用户名是："+email);
		 }
		}
		return customer;
	}
    
	
	
	/**
     * 功能:招商状态回复调用
     * <p>作者 杨荣忠 2015-6-8 下午04:10:28
     * @param request
     * @param response
     * @return
     */
	@RequestMapping(value="/cmbeHome/submitCallbacK.html")
	public void submitCallbacK(HttpServletRequest req, HttpServletResponse resp){
		String orderNumber ="";
		SalesOrder salesOrder =new SalesOrder();
		List<String> orderNos =new ArrayList();
		try {
			String data = req.getParameter("data");
			String signdata = req.getParameter("signdata");
			
			data = data.replace(' ', '+');
			signdata = signdata.replace(' ', '+');
			
			System.out.println("data=================="+data);
			System.out.println("signdata============"+signdata);
			
			PaymentMethod paymentMethod=paymentMethodManager.getById(29);
		    CertificateVerifier verifier = new CertificateVerifier(
		    paymentMethod.getConfigData().get("rootCertificatePath"));
		    SignatureFactory.addVerifier("verifier", verifier);
			PfxSigner signer = new PfxSigner(paymentMethod.getConfigData().get("keyStorePath"), 
			paymentMethod.getConfigData().get("keyPassword"));
			SignatureFactory.addSigner("signer", signer);
			
			UcsNoticeRequest noticeRequest = new UcsNoticeRequest(data,signdata);
			logger.debug("[data]         = " + data);
			logger.debug("[signdata]         = " + signdata);
			switch (noticeRequest.getOptType()) {
			case 1002:
				System.out.println("回调进入1002");
				UcsNoticeRequest1002 noticeRequest1002 =new UcsNoticeRequest1002(noticeRequest.getJsonResult());
				orderNumber = noticeRequest1002.getOrderNo();
				logger.debug("[OptType]         = [1002]");
				logger.debug("[CState]         = " + noticeRequest1002.getPayTime());
				logger.debug("[PayTime]         = " + noticeRequest1002.getCState());
				break;
			case 1005:
				System.out.println("回调进入1005");
				UcsNoticeRequest1005 noticeRequest1005 =new UcsNoticeRequest1005(noticeRequest.getJsonResult());
				orderNumber = noticeRequest1005.getOrderNo();
				logger.debug("[OptType]         = [1005]");
				logger.debug("[CState]         = " + noticeRequest1005.getCState());
				logger.debug("[RefundTime]         = " + noticeRequest1005.getRefundTime());
				break;
			}
			
			System.out.println(nowTime()+"支付订单状态更改是：========================="+orderNumber);
			PrintWriter out = resp.getWriter();
			UcsNoticeResponse noticeResponse =new UcsNoticeResponse(100,"成功处理了请求");
			System.out.println("回调返回值 ===========："+noticeResponse.getJsonResult());
            out.print(noticeResponse.getJsonResult());
            out.flush();
            out.close();
            logger.debug(noticeResponse.getJsonResult());
            logger.debug("---------- End [ReceiveNotice] process.");
            
			salesOrder= getSalesOrder(orderNumber);
			if(salesOrder!=null){
				salesOrder.setPaymentStatus(OrderConstants.PAYMENT_STATUS_PAID);
				salesOrder.setPaidAmount(salesOrder.getTotalAmount());
				salesOrderManager.save(salesOrder);
			}
			
		} catch (Exception ex) {
		    ex.printStackTrace();
			System.out.println("支付调用有错：============");
		}
	} 
	
	
	/**
	 * 功能:招商银行获取支付订单
	 * <p>作者 杨荣忠 2015-6-10 下午04:11:18
	 * @param orderNos
	 * @return
	 */
	public SalesOrder getSalesOrder(String orderNos){
		SalesOrder salesOrder =new SalesOrder();
		try{
		 salesOrder=salesOrderManager.getSalesOrderByOrderNo(orderNos);
		}catch(Exception e){
			return null;
		}
		return salesOrder;
	}
	
	
	
	/**
	 * 功能:社会化分享登录
	 * <p>作者 杨荣忠 2015-6-5 下午01:38:06
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value ={"/customer/anonymousRegister.html"})
	public ModelAndView anonymousRegisterUrl(HttpServletRequest request, HttpServletResponse response ) throws Exception
	{   
	    String email =(String) request.getParameter("useremail");
	    String username =(String) request.getParameter("username");
		String suffix ="@qq.com";
		try
		{   
			Customer customer  = anonymousRegister( email+suffix ,username ,request, response);
        	Authentication authRequest = new UsernamePasswordAuthenticationToken(customer.getUsername(), customer
					.getPassword());
			SecurityContext securityContext = SecurityContextHolder.getContext();
			if (securityContext != null)
			{
				securityContext.setAuthentication(authRequest);
			}
			RequestUtil.setUserInfoCookieCMHOME(response, customer, (request).getContextPath());
			// 合并购物车信息
			ShoppingCartUtil.getInstance().setShoppingcartInfo(request, response, customer);
		}
		catch(Exception e){
			return getRedirectView("/index.html");
		}
		return getRedirectView("/index.html");
	}
	
	
	/**
	 * 功能:当前时间
	 * <p>作者 杨荣忠 2015-6-10 下午02:39:43
	 * @param args
	 */
	public  String nowTime() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String nowTime = df.format(new Date());
		return nowTime;
		}
	
	
    /**
     * 功能:招商银行提交跳转
     * <p>作者 杨荣忠 2015-6-8 下午04:10:28
     * @param request
     * @param response
     * @param paymentMethodId
     * @return
     */
	@RequestMapping(value="/cmbeHome/submit.html", method=RequestMethod.POST)
	public ModelAndView getSubmit(HttpServletRequest request, HttpServletResponse response,int paymentMethodId){
		request.setAttribute("paymentMethod",paymentMethodManager.getById(paymentMethodId));
		ModelAndView mv = new ModelAndView("/system/payment/cmb_ehome_submit");
		return mv;
	} 
	
	
	/**
	 * 功能:异步获取招商银行最新token
	 * <p>作者 杨荣忠 2015-6-8 下午04:10:43
	 * @param address
	 * @param result
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 * @throws Exception
	 */
	@RequestMapping(value="/cmbeHome/getToken.html", method=RequestMethod.POST)
	public ModelAndView getToken(HttpServletRequest req, HttpServletResponse response,String juankongNo) throws Exception
    {
		String MallId = req.getParameter("MallId");
		String USRNBR = req.getParameter("USRNBR");
		int paymentMethodId =Integer.parseInt(req.getParameter("paymentMethodId"));
		
		
		System.out.println("进入getToken方法=========");
		System.out.println("MallId========="+ req.getParameter("MallId"));
		System.out.println("USRNBR========="+ req.getParameter("USRNBR"));
		
		
		Request1007 request = new Request1007();
		request.setMallId(MallId);
		request.setUSRNBR(USRNBR);

		PaymentMethod paymentMethod =paymentMethodManager.getById(paymentMethodId);
		
		PfxSigner signer = new PfxSigner(paymentMethod.getConfigData().get("keyStorePath"), 
				paymentMethod.getConfigData().get("keyPassword"));
		CertificateVerifier verifier = new CertificateVerifier(
				paymentMethod.getConfigData().get("rootCertificatePath"));
		
		SignatureFactory.addSigner("signer", signer);
		SignatureFactory.addVerifier("verifier", verifier);
		
		request.serialize();
		
		HttpServices httpServices = new HttpServices();
		
        //http://tcreditpay.cmbchinaucs.com/UcsCredit
		UcsApiMessage respMsg = httpServices.doPost(
				"http://creditpay.cmbchinaucs.com/UcsCredit", request.getRequestData(),
				request.getRequestSigndata());

		Response1007 response1007 = new Response1007(respMsg.getData(),
				respMsg.getSigndata());

		//req.setAttribute("response1007", response1007);
		System.out.println("token:==========="+response1007.getToken());
        AjaxView ajaxView = new AjaxView(response);
        ajaxView.setData(response1007.getToken());
        ajaxView.setStatus((short) 1);
        return ajaxView;
    }
	
	
	
	/**
	 * 功能:获取招商银行过来的用户信息
	 * <p>作者 杨荣忠 2015-5-28 下午04:26:31
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public Response1000 getResponseCmbeHome(HttpServletRequest request) throws Exception
	{
		System.out.println("进入方法：============getResponseCmbeHome");
		System.out.println("data：============"+request.getParameter("data"));
		System.out.println("signdata：============"+request.getParameter("signdata"));
		
		String data = request.getParameter("data");
		String signdata = request.getParameter("signdata");
		
		Response1000 responses = new Response1000(data, signdata);
		return responses;
	}
	
	

	public SalesOrderManager getSalesOrderManager()
	{
		return salesOrderManager;
	}

	public void setSalesOrderManager(SalesOrderManager salesOrderManager)
	{
		this.salesOrderManager = salesOrderManager;
	}

	public AppUserManager getAppUserManager()
	{
		return appUserManager;
	}

	public void setAppUserManager(AppUserManager appUserManager)
	{
		this.appUserManager = appUserManager;
	}

	public PaymentMethodManager getPaymentMethodManager()
	{
		return paymentMethodManager;
	}

	public void setPaymentMethodManager(PaymentMethodManager paymentMethodManager)
	{
		this.paymentMethodManager = paymentMethodManager;
	}

	public CustomerManager getCustomerManager()
	{
		return customerManager;
	}

	public void setCustomerManager(CustomerManager customerManager)
	{
		this.customerManager = customerManager;
	}
	
}
