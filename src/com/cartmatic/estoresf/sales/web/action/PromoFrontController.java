package com.cartmatic.estoresf.sales.web.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.sales.PromoRule;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.sales.service.PromoRuleManager;
/**
 * 前台促销主页显示促销规则controller
 * 
 * @TODO 目前没有使用
 * @author CartMatic
 *
 */

@Controller
public class PromoFrontController extends GenericStoreFrontController<PromoRule> {
	private PromoRuleManager promoRuleManager;
	public void setPromoRuleManager(PromoRuleManager promoRuleManager) {
		this.promoRuleManager = promoRuleManager;
	}

	public PromoRuleManager getPromoRuleManager() {
		return promoRuleManager;
	}

	@RequestMapping(value="/sales/promotion*")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		logger.debug("entering 'PromoFrontController defaultAction' method...");
		ModelAndView mv = getModelAndView("sales/promotionList");
		
		List<PromoRule> promoListInProcess = promoRuleManager.getAllPromotionRulesInProcessForFront();
		List<PromoRule> promoListInFuture = promoRuleManager.getAllPromotionRulesInFutureForFront();
		mv.addObject("promoListInProcess", promoListInProcess);
		mv.addObject("promoListInFuture", promoListInFuture);
		return mv;
	}

	@Override
	protected void initController() throws Exception {
		mgr = promoRuleManager; 
		
	}

}
