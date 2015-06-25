package com.cartmatic.estoresf.activity.web.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.activity.service.AwardService;
import com.cartmatic.estore.activity.service.UserAwardService;
import com.cartmatic.estore.common.helper.ConfigUtil;
import com.cartmatic.estore.common.model.activity.Award;
import com.cartmatic.estore.common.model.activity.UserAward;
import com.cartmatic.estore.common.model.customer.Customer;
import com.cartmatic.estore.common.model.order.SalesOrder;
import com.cartmatic.estore.common.util.DateUtil;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.order.OrderConstants;
import com.cartmatic.estore.order.service.SalesOrderManager;
import com.cartmatic.estore.webapp.util.RequestContext;

@Controller
public class AwardFrontController extends GenericStoreFrontController<Award> {
	
	private AwardService awardService;
	
	private UserAwardService userAwardService;
	
	private SalesOrderManager salesOrderManager;
	
	@RequestMapping(value={"/activity/index.html"})
	public ModelAndView showIndex(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv = getModelAndView("activity/index");
//		List<Award> list = this.awardService.getAll();
//		mv.addObject("awardList", list);
		return mv;
	}
	
	
	
	/**
	 * 功能:抽奖使用
	 * <p>作者 杨荣忠 2015-5-19 下午02:19:46
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/activity/lottery.html"})
	public ModelAndView awardAjax(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		UserAward ua = this.userAwardService.getUserAward(RequestContext.getCurrentUserId());
		Award award = new Award();
		if(ua != null){
			award.setLevel(-2);
		}else{
			String beginStr = ConfigUtil.getInstance().getAnniverysaryStartDate();	// "12/12/2000"; 
			String endStr = ConfigUtil.getInstance().getAnniverysaryEndDate(); //"12/12/2015";
			Date begin = DateUtil.convertStringToDate(beginStr);
			Date end = DateUtil.convertStringToDate(endStr);
			List<SalesOrder> soList = this.salesOrderManager.getSalesOrder(RequestContext.getCurrentUserId(), OrderConstants.PAYMENT_STATUS_PAID, begin, end);
			if(soList.size() <= 0){
				award.setLevel(-3);
			}else{
				List<Award> list = new ArrayList<Award>();
				list = this.awardService.getAllOrdered("level", true);
				
				int level = getGameWinningLevel(list);
				
				int[] mins = {136,  226,   1,   46,    91,    181,   271,   316 };
				int[] maxs ={ 179,  269,  44,  89,   134,   224,   314,   359};
				
				int index = -1;
				int angle = 48;
				
				Random ran = new Random();
				switch(level){
				case 1:
					index = 0;
					break;
				case 2:
					index = 1;
					break;
				case 3:
					index = 2;
					break;
				case -1:
					index = ran.nextInt(4) + 4;
					break;
				}
				angle = ran.nextInt(44) + mins[index];
				award.setLevel(level);
				for(Award a : list){
					if(a.getLevel().equals(level)){
						award.setPrize(a.getPrize());
						award.setTitle(a.getTitle());
						break;
					}
				}
				award.setAngle(angle);
				ua = new UserAward();
				ua.setCustomer((Customer)RequestContext.getCurrentUser());
				ua.setAwardLevel(level);
				ua.setAwardTitle(award.getTitle() == null ? "( 没有中奖 )" : award.getTitle());
				ua.setPrize(award.getPrize() == null ? "( 无奖品 )" : award.getPrize());
				ua.setCreateTime(new Date(System.currentTimeMillis()));
				ua.setUpdateTime(new Date(System.currentTimeMillis()));
				this.userAwardService.save(ua);
			}
		}
		JSONObject data=JSONObject.fromObject(award);
        PrintWriter out = response.getWriter();
        out.println(data);
		return null;
	}

	//中奖模拟
	private static int getGameWinningLevel(List<Award> list) {   
		  
	    // 中奖等级：未中奖   
	    int winningLevel = -1;   
	  
	    if (list == null || list.size() <= 0) {   
	        return winningLevel;   
	    }   
	  
	    // 中奖随机号   
	    int randomWinningNo = 0;   
	    int args[] = new int[list.size() * 2];   
	    int temp = (int) Math.round(Math.random() * 1000000000) % 1000000;   
	    int j = 0;   
	  
	    for (int i = 0; i < list.size(); i++) {   
	  
	        double tmpWinningPro = list.get(i).getChance();   
	  
	        if (j == 0) {   
	            args[j] = randomWinningNo;   
	        } else {   
	            args[j] = args[j - 1] + 1;   
	        }   
	        args[j + 1] = args[j] + (int) Math.round(tmpWinningPro * 10000) - 1;   
	  
	        if (temp >= args[j] && temp <= args[j + 1]) {   
	            winningLevel = i + 1;   
	            System.out.println(Arrays.toString(args) + "-->" + temp + "("+winningLevel+")");
	            return winningLevel;   
	        }   
	        j += 2;   
	    }   
	    System.out.println(Arrays.toString(args) + "-->" + temp + "("+winningLevel+")");
	    return winningLevel;   
	}
	
	@Override
	protected void initController() throws Exception {
		// TODO Auto-generated method stub
	}

	public AwardService getAwardService() {
		return awardService;
	}

	public void setAwardService(AwardService awardService) {
		this.awardService = awardService;
	}

	public UserAwardService getUserAwardService() {
		return userAwardService;
	}

	public void setUserAwardService(UserAwardService userAwardService) {
		this.userAwardService = userAwardService;
	}

	public SalesOrderManager getSalesOrderManager() {
		return salesOrderManager;
	}

	public void setSalesOrderManager(SalesOrderManager salesOrderManager) {
		this.salesOrderManager = salesOrderManager;
	}

}
