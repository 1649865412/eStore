<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<HTML>
<HEAD>
<%@ page language="java" contentType="text/html; charset=GB18030" import="java.util.*"
	pageEncoding="GB18030"%>
<META http-equiv="Content-Type" content="text/html; charset=GB18030">
<META name="GENERATOR" content="IBM Software Development Platform">
<TITLE>verisign_payflow_link_back_response.jsp</TITLE>
</HEAD>
<BODY>
	<%
			java.io.FileWriter fw=null;
	try{
		
		fw=new java.io.FileWriter("E:\\Programs\\Tomcat\\webapps\\ROOT\\payment\\record.txt");
		java.io.PrintWriter pw=new java.io.PrintWriter(fw);
		pw.println("sdfs dddd begin");
		Map map=request.getParameterMap();
		Iterator i=map.entrySet().iterator();
		while(i.hasNext())
		{
				Map.Entry en=(Map.Entry)i.next();
				try{
				String[]value=(String[])en.getValue();
				pw.println("Name:" + en.getKey() + " Value:" + value[0] + "<br>");
				}catch(Exception rrrrx){}
		}
		pw.println("end end-----------------");
		pw.close();
		fw.close();
	}catch(Exception ex){
		try{
		out.println("error" + ex.toString());}catch(Exception eee){}
	}


	 %>
</BODY>
</HTML>
