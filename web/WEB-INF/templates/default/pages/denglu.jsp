<%@page import="com.denglu.util.Constants"%>
<%@page import="com.denglu.util.SignUtil"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONTokener"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="/errorpage.jsp"%>
<%
String token = request.getParameter("token");
Map<String, String> map = new TreeMap<String, String>();	// 用于参数排序，仅作参考
String timestamp = "" + System.currentTimeMillis();			// 时间戳
String sign_type = "MD5";									// 签名方式
map.put("token", token);
map.put("timestamp", timestamp);
map.put("sign_type", sign_type);
String sign = SignUtil.signMD5(map, Constants.API_KEY);		// 生成签名
// 获取用户信息接口url
    String urlPath = Constants.DENGLU_URL + "/api/v3/user_info?token=" + token + "&timestamp=" + timestamp + "&sign_type=" + sign_type + "&sign=" + sign;
	String result = SignUtil.connect(urlPath);
	JSONTokener jsonTokener = new JSONTokener(result);			// 解析字符串为json格式，仅作参考
	Object o = jsonTokener.nextValue();
	JSONObject jsonObj = (JSONObject) o;
    String valueStr = jsonObj.toString();
    long mediaUserID = (Integer)jsonObj.get("mediaUserID");
    String username = (String) jsonObj.get("name");
  //  username = java.net.URLEncoder.encode(username.toString(),"UTF-8");
    String  webPath = request.getScheme()+"://"+request.getServerName();
    String  responsePath = "/customer/dengluRegister.html?useremail="+mediaUserID+"&username="+username;
    String path = webPath.concat(responsePath);
	response.sendRedirect(responsePath);
%>
<span><%=valueStr%></span><br><br><br>
<span><%=username%></span><br><br><br>
<span><%=mediaUserID%></span><br><br><br>
<span><%=token%></span><br><br>
<span><%=webPath%></span><br><br>
<span><%=responsePath %></span><br><br>
<span><%=path%></span><br><br>







