package com.cartmatic.estoresf.cmbehome.action.help;

import com.cartmatic.estore.webapp.util.RequestUtil;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CmbeHomeHelp {
	
	

	/**
	 * 替换字符串
	 * @author User
	 *
	 */
	public static String replaceString(String a,String b) {
		try {
			a = a.replace(b, "");
			//System.out.println(a);
		} catch (Exception e) {
           return a;
		}
		return a;
	}
	
	
	
	/**
	 * 功能:来自招商银行用户路径转换
	 * <p>作者 杨荣忠 2015-5-28 下午04:29:50
	 * @param request
	 * @param url
	 * @return
	 */
	public static String changeUrl(HttpServletRequest request,String url)
	{  
		try{
		    url=RequestUtil.getAppURL(request)+request.getRequestURI();
			if(request.getQueryString()!=null)
			{
				url+="?"+request.getQueryString();
			}
			//转化为正常路径
			url = replaceString(url, CmbeHomeConstant.URL_REPLACE);
			
		}catch(Exception e){
			e.printStackTrace();
			return url;
		}
	
		return url;
	}

}



