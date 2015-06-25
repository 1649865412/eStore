/*
 * Created on Sep 12, 2006
 * 
 */

package com.cartmatic.estoresf.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.cartmatic.estore.Constants;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.customer.CustomerEmail;
import com.cartmatic.estore.common.model.customer.ValidationSession;
import com.cartmatic.estore.common.model.order.OrderShipment;
import com.cartmatic.estore.common.model.order.SalesOrder;
import com.cartmatic.estore.common.model.sales.Coupon;
import com.cartmatic.estore.common.model.sales.GiftCertificate;
import com.cartmatic.estore.common.model.system.PaymentHistory;
import com.cartmatic.estore.common.service.GiftCertificateService;
import com.cartmatic.estore.core.util.I18nUtil;
import com.cartmatic.estore.core.view.MailEngine;
import com.cartmatic.estore.customer.CustomerConstants;
import com.cartmatic.estore.customer.service.CustomerManager;
import com.cartmatic.estore.customer.service.MembershipManager;
import com.cartmatic.estore.customer.service.ShopPointHistoryManager;
import com.cartmatic.estore.customer.service.ValidationSessionManager;
import com.cartmatic.estore.framework.test.BaseTransactionalTestCase;
import com.cartmatic.estore.order.OrderConstants;
import com.cartmatic.estore.order.service.SalesOrderManager;
import com.cartmatic.estore.sales.model.EmailModel;
import com.cartmatic.estore.sales.service.CouponManager;
import com.cartmatic.estore.sales.service.GiftCertificateManager;
import com.cartmatic.estore.system.service.AppUserManager;
import com.cartmatic.estore.system.service.PaymentHistoryManager;
import com.cartmatic.estore.system.service.SystemQueueManager;
import com.cartmatic.estoresf.customer.model.ContactUSModel;

/**
 * @author Ryan
 * 
 */
public class MailEngineTestCase extends BaseTransactionalTestCase {
	 private String from="";
    @Test
	public void test()throws Exception{

		from=configUtil.getStore().getEmailSender();
		mailEngine.setQueueDisabled(true);
		String email="kedou20@gmail.com";
		String orderNo="kedou101330002";
		
		email="lamedia2009@gmail.com";
		email="kedou@linkdigi.com";
		
		orderNo="YP122860002";
		orderNo="YP122860003";
		
		
		String coupon="MOTHERSDAY";
		SalesOrder salesOrder=salesOrderManager.getSalesOrderByOrderNo(orderNo);
		salesOrder.setCustomerEmail(email);
		//下单
		placeOrder(orderNo);
		//发货通知
		shipping(orderNo);
		//重新发送确认email
		reconfirm(orderNo);
		//发送优惠券
		sendCoupon(email,coupon);
		//赠送礼券
		exchangeGiftCertificateByRewardPoints(email);
		//注册成功
		registerSuccess(email);
		//取回密码
		passwordRecover(email);
		//联系我们
		contactus(email);
		//发送支付结果
		sendPaymentResult(orderNo);
		//会员升级邮件
		upgradeMembershipLevel(email);
		//Add Message时发邮件通知
		replyOrderMessage(email);
		//赠送礼券 
		giftcertificateForOrder(orderNo);
		//发送客户邮件
		sendToCustomer(email);

		mailEngine.setQueueDisabled(false);
	}

    @Autowired
	protected MailEngine		mailEngine	= null;
    @Autowired
	private SystemQueueManager	systemQueueManager;
    @Autowired
	private ShopPointHistoryManager shopPointHistoryManager=null;
    @Autowired
	private PaymentHistoryManager paymentHistoryManager=null;
    @Autowired
	private GiftCertificateManager giftCertificateManager=null;
    @Autowired
	private CustomerManager customerManager=null;
    @Autowired	
	private GiftCertificateService giftCertificateService=null;
    @Autowired
	private ValidationSessionManager validationSessionManager=null;
    @Autowired
    private CouponManager couponManager=null;
    @Autowired
	private SalesOrderManager salesOrderManager=null;
	private ConfigUtil configUtil=null;

	
	public void setConfigUtil(ConfigUtil configUtil) {
		this.configUtil = configUtil;
	}

	/**
	 * 下单
	 * placeOrder.vm
	 */
	public void placeOrder(String orderNo){
		SalesOrder salesOrder=salesOrderManager.getSalesOrderByOrderNo(orderNo);
		salesOrder.getOrderShipments().iterator().next();
		salesOrderManager.sendNotificationEmail(OrderConstants.MAIL_TYPE_PLACE_ORDER, salesOrder);
	}
	
	/**
	 * 发货通知
	 * shipping.vm
	 */
	public void shipping(String orderNo){
		SalesOrder salesOrder=salesOrderManager.getSalesOrderByOrderNo(orderNo);
		List<OrderShipment> list=new ArrayList<OrderShipment>();
		list.addAll(salesOrder.getOrderShipments());
		salesOrderManager.sendShipmentNotificationEmail(salesOrder, list.get(0));	
	}
	
	/**
	 * 重新发送确认email
	 * reConfirmOrder.vm
	 */
	public void reconfirm(String orderNo){
		SalesOrder salesOrder=salesOrderManager.getSalesOrderByOrderNo(orderNo);
		salesOrderManager.sendNotificationEmail(OrderConstants.MAIL_TYPE_RECONFIRM, salesOrder);
	}
	
	/**
	 * 发送优惠券
	 * @param salesOrder
	 * couponMail.vm
	 */
	public void sendCoupon(String email,String couponCode){
		EmailModel emailModel = new EmailModel();
		emailModel.setFirstName("kedou");
		emailModel.setLastName("abc");
		emailModel.setEmail(email);
		Coupon coupon=couponManager.getCouponByNo(couponCode);
		couponManager.doSendCoupon(coupon, emailModel);
	}
	
	/**
	 * 下单赠送积分
	 * @param salesOrder
	 */
	public void sendShopPoint(String orderNo){
		SalesOrder salesOrder=salesOrderManager.getSalesOrderByOrderNo(orderNo);
		salesOrder.setGainedPoint(100);
		if(salesOrder.getCustomerId()!=null &&salesOrder.getCustomerId()!=Constants.USERID_ANONYMOUS.intValue()&& salesOrder.getGainedPoint()!=null 
				&&salesOrder.getGainedPoint().intValue()>0){
			shopPointHistoryManager.saveNewShopPointHistory(CustomerConstants.ShopPoint_Type_Shopping, salesOrder.getCustomer(), salesOrder.getGainedPoint());
		}
	}
	
	/**
	 * 注册成功
	 * registerSuccess.vm
	 */
	public void registerSuccess(String email){
		mailEngine.sendSimpleTemplateMail("customer/registerSuccess.vm", new HashMap<String, Object>(), null, from, email);
	}
	
	/**
	 * 密码取回
	 * @throws Exception 
	 * passwordRecover.vm
	 */
	public void passwordRecover(String email) throws Exception{
        
        
        ValidationSession vs = validationSessionManager.doGenerateUrlByEmail(email, ValidationSession.TYPE_PASSWORD_RECOVER);
		String message = "";
		if (vs != null) {
			Map map = new HashMap();
			//new begin
			map.put("validationSession",vs);			
			// send email preparation.
			String emailTitle = I18nUtil.getInstance().getMessage("passwordRecover.email.title", new Object[]{email});
			// construct the full url.
			//String domain = ConfigUtil.getInstance().getStoreFrontSiteUrl();
			//request.getScheme() + "://" + request.getHeader("host") + request.getContextPath();
			String fullUrl = "/resetPassword.html?uid=" + vs.getUrl();
			map.put("email", vs.getEmail());
			map.put("url", fullUrl);
			map.put("expiredDate", vs.getExpiredDate());
			map.put("ip", "192.168.1.123");
			//map.put("domain", domain);
			//map.put("companInfo", RequestContext.getServletContext().getAttribute("companyInfo"));
			// send email
			mailEngine.sendSimpleTemplateMail("passwordRecover.vm", map, emailTitle, from, email);
		}
	}
	
	
	/**
	 * 联系我们
	 * contactus.vm
	 */
	public void contactus(String email){
		ContactUSModel contactUSModel=new ContactUSModel();
		contactUSModel.setSubject("Customer Service");
		contactUSModel.setFullName("kedou abc");
		contactUSModel.setEmail("kedou@linkdigi.com");
		contactUSModel.setComments("Comment ......We want to hear from you! We welcome all of your comments and suggestions so we may serve you better. You can reach us in the following ways.We want to hear from you! We welcome all of your comments and suggestions so we may serve you better. You can reach us in the following ways We want to hear from you! We welcome all of your comments and suggestions so we may serve you better. You can reach us in the following waysWe want to hear from you! We welcome all of your comments and suggestions so we may serve you better. You can reach us in the following ways");
		contactUSModel.setOrderNo("kedou092650001");
		contactUSModel.setCountry("United States of America");
		contactUSModel.setCity("West Covina");
		contactUSModel.setPhoneNumber("123456789");
		Map map = new HashMap();
		map.put("contactUSModel", contactUSModel);
		String mailFrom = contactUSModel.getEmail();
		mailEngine.sendSimpleTemplateMail("customer/contactus.vm", mailFrom, map, null, from, email);
	}
	
	
	/**
	 * 发送支付结果
	 * @param orderNo
	 * paymentSuccess.vm
	 */
	public void sendPaymentResult(String orderNo){
		SalesOrder salesOrder = this.salesOrderManager.getSalesOrderByOrderNo(orderNo);
		PaymentHistory paymentHistory=(PaymentHistory)paymentHistoryManager.getAllSuccessUnBrowsed().get(0);
		String mailTo = salesOrder.getCustomerEmail();
		Map dataMap = new HashMap();
		dataMap.put("salesOrder", salesOrder);
		dataMap.put("paymentHistory", paymentHistory);
		String from=ConfigUtil.getInstance().getStore(salesOrder.getStore().getCode()).getEmailSender();
		mailEngine.sendSimpleTemplateMail("order/paymentSuccess.vm", dataMap, null, from, mailTo);
	}
	
	
	/**
	 * 会员升级邮件
	 * @param email
	 * upgradeMembershipLevel.vm
	 */
	public void upgradeMembershipLevel(String email){
		/*Membership perMembership = membershipManager.getById(2);
		Membership memberShip=membershipManager.getById(3);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("upgradeShopPoint", memberShip.getUpgradeShopPoint());
		map.put("perMembershipName", perMembership.getMembershipName());
		map.put("aftMembershipName", memberShip.getMembershipName());
		map.put("newMembership", memberShip);
		map.put("userName", "Customer Name");
		mailEngine.sendSimpleTemplateMail("/customer/upgradeMembershipLevel.vm".intern(), map,null, null, email);*/
	}
	
	
	/**
	 * 赠送礼券
	 * @param email
	 * giftcertificateMail.vm
	 */
	public void exchangeGiftCertificateByRewardPoints(String email){
		Customer customer=customerManager.findByProperty("email", email).get(0);
		BigDecimal giftCertAmt=new BigDecimal(180);
		GiftCertificate certificate = new GiftCertificate();
		certificate.setExpireTime(giftCertificateManager.getDefaultGiftCertificateExpireTime());
		certificate.setStatus(GiftCertificate.STATUS_ACTIVE);
		certificate.setGiftCertAmt(giftCertAmt);
		certificate.setRemainedAmt(giftCertAmt);
		certificate.setMessage(I18nUtil.getInstance().getMessage("shopPoint.exchange.giftCertificate.message"));
		certificate.setGiftCertificateNo(giftCertificateManager.generateGiftCertificateNo());
		certificate.setPurchaser(ConfigUtil.getInstance().getStore().getName());
		certificate.setRecipient(customer.getUsername());
		certificate.setRecipientEmail(customer.getEmail());
		certificate.setIsSentByEmail(Constants.FLAG_TRUE);
		Map model = new HashMap();
		model.put("giftCertificate", certificate);
		mailEngine.sendSimpleTemplateMail("sales/giftcertificateMail.vm", model, null, from, certificate.getRecipientEmail());
		
	}
	
	/**
	 * Add Message时发邮件通知
	 * @param email
	 * replyOrderMessage.vm
	 */
	public void replyOrderMessage(String email){
		Map<String,Object>dataMap=new HashMap<String, Object>();
		dataMap.put("orderMessageSubject","test subject...");
		dataMap.put("orderMessageContent","test contetn.. ....Alibaba.com aims to provide you with accurate Sender Contact Details. However, Alibaba.com is neither responsible nor liable for the accuracy of the above information. ...");
		dataMap.put("isAnonymous",false); 
		mailEngine.sendSimpleTemplateMail("order/replyOrderMessage.vm",dataMap,null,from,email);
	}
	
	
	/**
	 * 赠送礼券
	 * @param email
	 * giftcertificateForOrder.vm
	 */
	public void giftcertificateForOrder(String orderNo){
		SalesOrder salesOrder=salesOrderManager.getSalesOrderByOrderNo(orderNo);
		BigDecimal amt = new BigDecimal(100);
		GiftCertificate gc = giftCertificateService.createForSalesOrder(salesOrder, amt);
		Map model = new HashMap();
		model.put("giftCertificate", gc);
		model.put("salesOrder", salesOrder);
		mailEngine.sendSimpleTemplateMail("sales/giftcertificateForOrder.vm", model, null, from, gc.getRecipientEmail());
	}
	
	
	
	
	
	public void cleanExpiredEmails() throws Exception {
		logger.debug("cleaning...");
		long startTime = System.currentTimeMillis();
		// mailQueueManager.setDaysToKeep(1);
		systemQueueManager.cleanExpiredQueue();
		
		logger.warn("Clean time:" + (System.currentTimeMillis() - startTime));
	}

	
	/*public void testComposeMail1() throws Exception {
		logger.debug("Compose and queue mail...");
		long startTime = System.currentTimeMillis();
		Map model = new HashMap();
		model.put("url","If you can read this url, it means it really works now.");
		mailEngine.sendSimpleTemplateMail("!/velocity/passwordRecover.vm", model, null, null,"kedou@linkdigi.com");
		setComplete();
		logger.warn("Compose and queue time:"+ (System.currentTimeMillis() - startTime));
	}
*/
	public void resetEmails() throws Exception {
		logger.debug("reset...");
		long startTime = System.currentTimeMillis();
		systemQueueManager.resetIncorrectQueue();
		
		logger.warn("reset time:" + (System.currentTimeMillis() - startTime));
	}
	
	public void sendQueuedEmails() throws Exception {
		/*int numOfEmailsPerTime = 3; logger.debug("sending..." +
		 numOfEmailsPerTime + " emails."); long startTime =
		 System.currentTimeMillis();
		 mailEngine.setNumOfEmailsPerTime(numOfEmailsPerTime);
		 mailEngine.sendQueuedEmails(); setComplete(); logger.warn("sent. time:" + (System.currentTimeMillis() - startTime));*/
	}
	
	/**
	 * Add Message时发邮件通知
	 * @param email
	 * replyOrderMessage.vm
	 */
	public void sendToCustomer(String email){
		CustomerEmail customerEmail = new CustomerEmail();
		customerEmail.setTitle("send to customer titile.....");
		customerEmail.setContent("send to customer content.....using any logo, and/or layout which may be calculated to falsely advertise the services or products of sofiasreplica.com, 7starhandbags.com, amatory.biz, amatorywatches.com, basicreplica.com, copyhandbags.com, doctorreplica.com, grandjewellery.com, mysilvercity.com, mysilvercity.net, replicawatchcity.com, replicasunglasses.net, ereplica.net, replicadream.net, timereplica.net, marsele.com, and dreamjewelery.net, and/or any other website or business, as being sponsored by, authorized by, endorsed by, or in any way associated with Chanel and Louis Vuitton");
		Map map = new HashMap();
		map.put("customerEmail", customerEmail);
		mailEngine.sendSimpleTemplateMail("customer/feedbackEmail.vm", map, null, from, email);
	}

	public void setMailEngine(MailEngine mailEngine) {
		this.mailEngine = mailEngine;
	}

	public void setSystemQueueManager(SystemQueueManager systemQueueManager) {
		this.systemQueueManager = systemQueueManager;
	}

	public void setShopPointHistoryManager(
			ShopPointHistoryManager shopPointHistoryManager) {
		this.shopPointHistoryManager = shopPointHistoryManager;
	}

	public void setPaymentHistoryManager(PaymentHistoryManager paymentHistoryManager) {
		this.paymentHistoryManager = paymentHistoryManager;
	}

	public void setGiftCertificateManager(
			GiftCertificateManager giftCertificateManager) {
		this.giftCertificateManager = giftCertificateManager;
	}

	public void setCustomerManager(CustomerManager customerManager) {
		this.customerManager = customerManager;
	}

	public void setGiftCertificateService(
			GiftCertificateService giftCertificateService) {
		this.giftCertificateService = giftCertificateService;
	}

	public void setValidationSessionManager(
			ValidationSessionManager validationSessionManager) {
		this.validationSessionManager = validationSessionManager;
	}

	public void setCouponManager(CouponManager couponManager) {
		this.couponManager = couponManager;
	}

	public void setSalesOrderManager(SalesOrderManager salesOrderManager) {
		this.salesOrderManager = salesOrderManager;
	}
	
}
