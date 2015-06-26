/*
 *CreateTime 2006-6-22
 *This class provide publishing advertisements.
 *In the request client must provide AdPositionId,adType,promotionId,categoryId,productId
 *
 */
package com.cartmatic.estoresf.content.web.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.content.AdPositionType;
import com.cartmatic.estore.common.model.content.Advertisement;
import com.cartmatic.estore.content.service.AdPositionTypeManager;
import com.cartmatic.estore.content.service.AdvertisementManager;
import com.cartmatic.estore.core.controller.BaseStoreFrontController;
import com.cartmatic.estore.webapp.util.RequestContext;

/**
 * @author Luo Shunkui
 */

@Controller
public class AdvertisementPublishController extends BaseStoreFrontController{

	private AdvertisementManager advertisementManager = null;

	private AdPositionTypeManager adPositionTypeManager = null; 
	
	@Override
	protected void initController() throws Exception {
		super.initController();
		setCacheSecondsConfigurable(true);
	}

	public void setAdvertisementManager(AdvertisementManager advertisementManager) {
		this.advertisementManager = advertisementManager;
	}

	public void setAdPositionTypeManager(AdPositionTypeManager adPositionTypeManager) {
		this.adPositionTypeManager = adPositionTypeManager;
	}

    @RequestMapping(value={"/content/adPublish_dy.html","/content/adPublish.html"})
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		//-- get categoryPath
		String productPath = request.getParameter("categoryPath");
		//没有productPath的情况下,就设置为当前Store的根目录.
		/*if(StringUtils.isBlank(productPath)){
			productPath=ConfigUtil.getInstance().getStore().getCatalog().getCategoryId()+".";
		}*/
		
		String adPositionType = request.getParameter("adPositionType");
		if (StringUtils.isBlank(adPositionType)) {
			return null;
		}

		AdPositionType adp = (AdPositionType) adPositionTypeManager.getAllsForFront(RequestContext.getCurrentStoreCode()).get(adPositionType);
		if (adp == null) {
			return null;
		}
		String adViewTemplate = adp.getTemplatePath();
		Integer adPositionTypeId = adp.getAdPositionTypeId();		
	
		List<Advertisement> adDisplays = this.getDisplays(adPositionTypeId, productPath);
		int adDisplaysLen = (adDisplays == null || adDisplays.isEmpty())? 0 : adDisplays.size();
		//随机的
		if (adDisplaysLen > 1 
				&& Short.valueOf("2").equals(adp.getDisplayType()))
		{
			Random rd = new Random();
			Advertisement b= adDisplays.get(rd.nextInt(adDisplaysLen));
			adDisplays = new ArrayList<Advertisement>();
			adDisplays.add(b);
		}
		request.setAttribute("displayType", adp.getDisplayType());
		request.setAttribute("ads", adDisplays);
		request.setAttribute("positionWidth", adp.getWidth());
		request.setAttribute("positionHeight", adp.getHeight());
		String mv = this.getTemplatePath("advertisement/adViewDefault",adViewTemplate);
		return getModelAndView(mv);
	}


	private List<Advertisement> getDisplays(Integer adPositionTypeId,String productPath) {
		if (adPositionTypeId == null) {
			throw new RuntimeException("PositionId is null!!");
		}
		List<Advertisement> displays = new ArrayList<Advertisement>();
		if (productPath != null){
			displays = this.advertisementManager.getAvalidAdvertisements(productPath, adPositionTypeId);
		}
		return displays;
	}
}


