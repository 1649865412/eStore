package com.cartmatic.estoresf;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.cartmatic.estore.common.model.viashow.Via;
import com.cartmatic.estore.core.controller.GenericStoreFrontController;
import com.cartmatic.estore.core.view.AjaxView;
import com.cartmatic.estore.viashow.service.ViaManager;

@Controller
public class EnrollController extends GenericStoreFrontController<Via> {
	private MultipartResolver	multipartResolver = null;
	private ViaManager viaManager = null;

	public MultipartResolver getMultipartResolver() {
		return multipartResolver;
	}

	public void setMultipartResolver(MultipartResolver multipartResolver) {
		this.multipartResolver = multipartResolver;
	}

	public ViaManager getViaManager() {
		return viaManager;
	}

	public void setViaManager(ViaManager viaManager) {
		this.viaManager = viaManager;
	}
	
	public static final String ALLCHAR = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";  
    public static final String LETTERCHAR = "abcdefghijkllmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";  
    public static final String NUMBERCHAR = "0123456789";  

	@RequestMapping(value = "/enroll.html")
	public ModelAndView defaultAction(HttpServletRequest request,HttpServletResponse response) {
		ModelAndView mv =new ModelAndView("static/via");
		return mv;
	}
	
	@RequestMapping(value = "/enrollAdd.html")
	public ModelAndView addSave(HttpServletRequest request,	HttpServletResponse response,Via via,@RequestParam("file") MultipartFile file) throws Exception {
		ModelAndView mv =new ModelAndView("static/via");
		Integer tag = 1;
		// 判断文件是否为空  
        if (!file.isEmpty()) {  
            try {
            	StringBuffer sb = new StringBuffer();  
                Random random = new Random();  
                for (int i = 0; i < 10; i++) {  
                    sb.append(ALLCHAR.charAt(random.nextInt(LETTERCHAR.length())));  
                } 
            	String imgPath = getMessage("enroll.url")+"/"+sb.toString()+".png";
            	via.setImg(sb.toString()+".png");
            	File pfile = new File(imgPath);
        		file.transferTo(pfile);
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }
        
        boolean flag =false;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
   		via.setBark(df.format(new Date()).toString());
   		flag= doCheck(via);
   		if(flag==true){
   			saveAdd(via);
   		}else{
   			tag = 2;
   		}
   		mv.addObject("tag", tag);
		return mv;
	}
	
	/**
	 * 功能:邮箱检测是否已存在
	 * <p>作者 杨荣忠 2015-8-16 下午12:09:00
	 * @param via
	 * @return
	 */
    public boolean  doCheck(Via via){
 	   boolean flag= false;
 	   try{
 		  List<Via> value =    viaManager.findByProperty("email", via.getEmail());
 		  if(CollectionUtils.isEmpty(value)){
 			 flag=true;
 		  }
 	   }catch(Exception e){
 		   e.printStackTrace();
 	   }
 	   return flag;
    }
    
   /**
    * 功能:保存
    * <p>作者 杨荣忠 2015-8-16 下午12:09:21
    * @param via
    * @return
    */
   public boolean  saveAdd(Via via){
	   boolean flag= false;
	   try{
		   viaManager.save(via);
		   flag= true;
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return flag;
   }

@Override
protected void initController() throws Exception {
	// TODO Auto-generated method stub
	
}
}
