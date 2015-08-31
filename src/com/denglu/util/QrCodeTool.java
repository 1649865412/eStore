package com.denglu.util;


/**
 *  获取产品详情页二维码
 *  <code>QrCodeTool.java</code>
 *  <p>
 *  <p>Copyright  2015 All right reserved.
 *  @author admin 时间 2015-8-10 下午03:56:58	
 *  @version 1.0 
 *  </br>最后修改人 无
 */
public class QrCodeTool
{

	public   QrCodeTool(){
		
	}
	
	/**功能:
	 * <p>作者 杨荣忠 2015-8-10 下午03:50:47
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		getQrCodeImgUrl();

	}
	
	/**
	 * 功能:例子
	 * <p>作者 杨荣忠 2015-8-10 下午03:57:18
	 * @return
	 */
	public static String getQrCodeImgUrl(){
		TwoDimensionCode code = new TwoDimensionCode();
		String content="http://word.jw88.com";
		String imgPath="d://a.png";
		code.encoderQRCode( content,  imgPath,  "png", 7) ;
		return imgPath;
	}

	
	public static String getQrCodeImgUrl(String content,String imgPath){
		TwoDimensionCode code = new TwoDimensionCode();
		code.encoderQRCode( content,  imgPath,  "png", 7) ;
		return imgPath;
	}
}
