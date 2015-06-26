package com.cartmatic.estoresf.cart.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.order.TransferRecord;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.model.Message;
import com.cartmatic.estore.other.service.TransferRecordManager;
import com.cartmatic.estore.system.service.RegionManager;

@Controller
@RequestMapping("/checkout/transferRecord.html")
public class TransferRecordFrontController extends GenericStoreFrontController<TransferRecord> {
    private TransferRecordManager transferRecordManager = null;
    private RegionManager regionManager=null;

    public void setRegionManager(RegionManager regionManager) {
    	
		this.regionManager = regionManager;
		
	}
	public void setTransferRecordManager(TransferRecordManager inMgr) {
        this.transferRecordManager = inMgr;
    }
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cartmatic.estore.core.controller.BaseController#initController()
	 */
	@Override
	protected void initController() throws Exception {
		mgr = transferRecordManager;
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("transferRecord",new TransferRecord());
		ModelAndView mv=getModelAndView("system/western_union_transfer_record",null);
		return mv;
	}

	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView saveWUTransferRecord(@Valid TransferRecord transferRecord,BindingResult result,HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("transferRecord",transferRecord);
		Integer countryId=ServletRequestUtils.getIntParameter(request, "countryId", -1);
		Integer stateId=ServletRequestUtils.getIntParameter(request, "stateId", -1);
		if(countryId>0){
			transferRecord.setCountry(regionManager.getById(countryId).getRegionName());
		}
		if(stateId>0){
			transferRecord.setState(regionManager.getById(stateId).getRegionName());
		}
		if(!result.hasErrors()){
			transferRecordManager.save(transferRecord);
			request.setAttribute("updateSuccess",true);
			saveMessage(Message.info("transferRecord.updated"));
		}
		ModelAndView mv=getModelAndView("system/western_union_transfer_record",null);
		return mv;
	}
	
}