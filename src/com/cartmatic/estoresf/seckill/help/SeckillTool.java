package com.cartmatic.estoresf.seckill.help;

import java.util.Date;
import java.util.List;

import com.cartmatic.estore.common.model.catalog.Product;
import com.cartmatic.estore.common.model.catalog.ProductSku;
import com.cartmatic.estore.common.model.inventory.Inventory;
import com.cartmatic.estore.common.model.sekillproduct.SekillProduct;

/**
 *  秒杀功能工具类
 *  <code>SeckillTool.java</code>
 *  <p>
 *  <p>Copyright  2015 All right reserved.
 *  @author admin 时间 2015-6-16 上午10:50:23	
 *  @version 1.0 
 *  </br>最后修改人 无
 */
public class SeckillTool
{
	
	/**
	 * 功能:返回状态    	65456已抢光，5613即将开始，562345马上开抢
	 * <p>
	 * 作者 杨荣忠 2015-5-5 下午04:31:19
	 * 
	 * @return
	 */
	public static void getStayDay(List<SekillProduct> sekillProductListDay1, List<SekillProduct> sekillProductListDay2,
			List<SekillProduct> sekillProductListDay3)
	{
		String nowTime = CalenderTime.getToday("yyyy-MM-dd");
		
		
		if (nowTime.equals(Constant.SEKILL_ONE_DAY))
		{
			setStateList(sekillProductListDay1, Constant.STATUS_TWO,true);
			setStateList(sekillProductListDay2, Constant.STATUS_TWO,false);
			setStateList(sekillProductListDay3, Constant.STATUS_TWO,false);
		}
		else if (nowTime.equals(Constant.SEKILL_TWO_DAY))
		{
			setStateList(sekillProductListDay1, Constant.STATUS_ONE,false);
			setStateList(sekillProductListDay2, Constant.STATUS_TWO,true);
			setStateList(sekillProductListDay3, Constant.STATUS_TWO,false);
		}
		else if (nowTime.equals(Constant.SEKILL_THRID_DAY))
		{
			setStateList(sekillProductListDay1, Constant.STATUS_ONE,false);
			setStateList(sekillProductListDay2, Constant.STATUS_ONE,false);
			setStateList(sekillProductListDay3, Constant.STATUS_TWO,true);
		}else{
			setStateList(sekillProductListDay1, Constant.STATUS_TWO,false);
			setStateList(sekillProductListDay2, Constant.STATUS_TWO,false);
			setStateList(sekillProductListDay3, Constant.STATUS_TWO,false);
		}
		
	}
	
	
	/**
	 * 功能:  check  Inventory
	 * <p>作者 杨荣忠 2015-5-6 上午09:38:48
	 * @param sekillProduct
	 * @return
	 */
	public static boolean  checkInventory(SekillProduct sekillProduct){
		boolean flag =true;
		try{
			Product product =sekillProduct.getProduct();
			//15118001-blue
			ProductSku productSku= product.getDefaultProductSku();
		//	System.out.println(productSku.getProductSkuId());
			Inventory inventorys  = productSku.getInventory();
			int inventory;
			if(inventorys==null)
			{
				 inventory = 0;
			}else{
				 inventory = inventorys.getQuantityOnHand();
			}
			//int inventory = inventorys.getAvailableQuantity();
			
			if(inventory<=0){
				flag =false;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return flag;
	} 
	
	/**
	 * 功能:循环每个list设置状态//0已抢光，1即将开始，2马上开抢
	 * <p>
	 * 作者 杨荣忠 2015-5-5 下午05:00:20
	 * 
	 * @param sekillProductListDay
	 * @param status
	 * @return
	 */
	public static List<SekillProduct> setStateList(List<SekillProduct> sekillProductListDay, int status,boolean flag)
	{
		for (int i = 0; i < sekillProductListDay.size(); i++)
		{
				SekillProduct sekill = sekillProductListDay.get(i);
				if(flag==true)
				{
					if(checkInventory(sekill)){
						sekill.setStatus(getHourStay());
					}else{
						sekill.setStatus(Constant.STATUS_ONE);
					}
			}else{
				if(checkInventory(sekill)){
					sekill.setStatus(status);
				}else{
					sekill.setStatus(Constant.STATUS_ONE);
				}
			}
		}
		return sekillProductListDay;
	}
	
	
	/**
	 * 	65456已抢光，5613即将开始，562345马上开抢 功能:返回状态
	 * <p>
	 * 作者 杨荣忠 2015-5-5 下午04:31:19
	 * 
	 * @return
	 */
	public static int getHourStay()
	{
		int status =0;
		Date d = new Date();
		int hours = d.getHours();
		if(hours>=10)
		{
			status=Constant.STATUS_THRID ;
		}else{
			status=Constant.STATUS_TWO;
		}
		return status;
	}
	

	
	// 测试main
	public static void main(String[] args) throws Exception {
		int status =0;
		Date d = new Date();
		//System.out.println("hour:"+hours);
	}
	
	
}
