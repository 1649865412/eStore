package com.denglu.util;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TwoDimensionAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("image/png; charset=UTF-8");
		OutputStream out=response.getOutputStream();
		TwoDimensionCode code = new TwoDimensionCode();
		//String content = "标题：二维码web应用"+"\n作者：蔺彦慧"+"\n时间："+new SimpleDateFormat("yyyy-MM-dd HH:ss").format(new Date());
		
		//String content="http://word.jw88.com";
		//获取原触发路径
		StringBuffer content =request.getRequestURL();
		code.encoderQRCode(content.toString(), out, "png");
		out.close();
	}

}
