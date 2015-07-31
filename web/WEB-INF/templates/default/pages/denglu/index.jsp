<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String  webPath = request.getScheme()+"://"+request.getServerName();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=webPath%>">
    
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  
  <body>
    This is my JSP page.哈哈<br>
<script id='denglu_login_js' type='text/javascript' charset='utf-8'></script>
<script type='text/javascript' charset='utf-8'>
	(function() {
		var _dl_time = new Date().getTime();
		var _dl_login = document.getElementById('denglu_login_js');
		_dl_login.id = _dl_login.id + '_' + _dl_time;
		_dl_login.src = 'http://static.denglu.cc/connect/logincode?appid=81558denzZPfOeAVcIrX4exa790E83&v=1.0.2&widget=3&styletype=1&size=348_214&asyn=true&time=' + 

_dl_time;
	})();
</script>



<br><br><br>
<!--jiaThis评论 UY BEGIN -->
<div id="uyan_frame"></div>
<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=2038562"></script>
<!-- UY END -->


<br><br><br>


<!-- JiaThis分享页面链接 BEGIN -->
<div class="jiathis_style_32x32">
	<a class="jiathis_button_qzone"></a>
	<a class="jiathis_button_tsina"></a>
	<a class="jiathis_button_tqq"></a>
	<a class="jiathis_button_weixin"></a>
	<a class="jiathis_button_renren"></a>
	<a href="http://www.jiathis.com/share?uid=2038562" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
	<a class="jiathis_counter_style"></a>
</div>
<script type="text/javascript">
var jiathis_config = {data_track_clickback:'true'};
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=2038562" charset="utf-8"></script>
<!-- JiaThis Button END -->





  </body>
</html>
