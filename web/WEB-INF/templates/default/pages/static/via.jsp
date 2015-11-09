<%@ page pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>

<html>
<head><title>四方街网</title>
  <link rel="icon" href="http://www.sifangstreet.comimages/favicon.ico" type="image/x-icon">
    <link rel="shortcut icon" href="http://www.sifangstreet.comimages/mindo.ico" type="image/x-icon">
    <!-<link href="${resPath}/styles/css1/head_foot.css" rel="stylesheet" type="text/css">->
    <link href="${resPath}/styles/css1/nav.css" rel="stylesheet" type="text/css">
    <link href="${resPath}/styles/css1/main.css" rel="stylesheet" type="text/css">
    <link href="${resPath}/styles/css1/chart.css" rel="stylesheet" type="text/css" />
    <link href="${resPath}/styles/css1/checkout.css" rel="stylesheet" type="text/css" />
    <link href="${resPath}/styles/css1/via.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctxPath}/scripts/jquery/jquery-1.8.2.min.js"></script>
		
    <script type="text/javascript">
	    $(document).ready(function () {
			//alert("我的第一个jQuery代码!");
		//	checkPhone("15999974425");
			});

	    function checkform(){
		//	alert("checkform");
			var name = $("#user_name").val();
			var phone = $("#phone").val();
			var company =$("#postcode").val();
			var email = $("#email").val();
			var img = $("#img").val();
			var info ="";
             if(!check(name)){
                   info ="姓名不能为空！";
                   alert(info); 
                   return false;
                 }
             else if(!check(phone)){
                 info ="电话不能为空！";
                 alert(info); 
                 return false;
               }
             else if(!checkPhone(phone)){
            	 info ="手机号码格式有误~";
                 alert(info); 
                 return false;
                 }
             else if(!check(email)){
                 info ="邮箱不能为空！";
                 alert(info); 
                 return false;
               }
             else if(!CheckEmail(email)){
                 info ="请输入正确的邮箱地址。";
                 alert(info); 
                 return false;
               }
             else if(!check(img)){
                 info ="请选择文件";
                 alert(info); 
                 return false;
               }
              $("#formid").submit();
            	   //add(name,phone,company,email,img) ;
			}

		function check(value){
			  var flag =true;
			  if(value.trim()==""||value ==null){
				  flag = false;
				  }
			  return flag;
			}

		
		function clearValue(){
			//alert("goodbye");
			$("#user_name").val("");
			$("#phone").val("");
			$("#postcode").val("");
			$("#email").val("");
			$("#img").val("");
		}
		
		
		function checkPhone(tel){
			 var flag =false;
			 var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
			 if (reg.test(tel)) {
				  flag = true;
			     // alert("号码正确~");
			 }else{
			    //  alert("号码有误~");
			 };
			 return flag;
			}

		function CheckEmail(email) {  
		    var pattern = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;  
		    if (!pattern.test(email)) {  
		      //  alert("请输入正确的邮箱地址。");  
		        return false;  
		    }  
		    return true;  
		} 

		
		function add(name,phone,company,email,img) {
			$.post("/StoreAdmin/viashow/via.html?doAction=addSave", {
				name  : name,
				phone : phone,
				company : company,
			    email   :email,
			    img :img
			}, function(result) {
				 // alert("result:"+result.status);
					if (result.status == 1) {
						alert("报名成功");
					}
					else if (result.status == 2) {
						alert("不可重复报名");
					}
					else {
						alert("报名失败,请联系管理员");
					}
				}, "json");
				clearValue();
		}
		
	
     </script>
</head>
		
<body>
<div class="maincontent">
        <div class="large-banner">
            <h1 class="title_part">
                VIA--四方街2016春夏独立设计品牌发布会
            </h1>
            <h2 class="title_part2">
                邀您带上朋友一起来感受至IN秀场
            </h2>
            <div class="brand_list">
            <h3>发布品牌:</h3>
            <img src="/images/via/nu.png"/>
            <img src="/images/via/jw.png"/>
            <img src="/images/via/wy.png"/>
            <img src="/images/via/lz.png"/>
            <img src="/images/via/sr.png"/>
            </div>
            <!--brand_list-->
        </div>
        <!--large-->
        <div class="bg-s">
            <div class="runway_info">
                <div class="left_info">
                  <p class="infor_title_1">VIA—四方街2016春夏独立设计品牌发布会</p>
                  <p>2015.08.23/16:15—17:00</p>
                  <p>广州轻纺交易园D区国际时尚发布中心一楼</p>
                </div>
                <!--left_info-->
                <div class="right_info">
                  <p class="infor_title_1">SHOWROOM开放</p>
                  <p>2015.08.22-08.24/10:00—17:30</p>
                  <p>广州轻纺交易园D区国际时尚发布中心二楼</p>
                </div>
                <!--right_info-->
            </div>
            <!--runway_info-->
              
            <div class="form_bg">
                <span class="checkout_user_info form_position"  id="signupForm" >
                    <h2 class="title_part2">
                        申请报名
                    </h2>
                    <h2 class="title_part2" style="color:red">
                        <span <c:if test="${tag != 1 }">style='display:none'</c:if>>报名成功</span>
                        <span <c:if test="${tag != 2 }">style='display:none'</c:if>>邮箱已被注册</span>
                    </h2>
                    <form id="formid" name="formid" method ="post"   action = "/enrollAdd.html"  enctype="multipart/form-data">
	                    <div class="span6 margin_left50 margin_top15">
	                        <div class="control-group">
	                            <label for="first_name" class="control-label">
	                                姓名
	                                <span class="text-error">
	                                    *
	                                </span>
	                            </label>
	                            <input class="span6 required" type="text" value="" name="name" id="user_name" />
	                        </div>
	                        <div class="control-group">
	                            <label for="phone" class="control-label">
	                                联系电话
	                                <span class="text-error">
	                                    *
	                                </span>
	                            </label>
	                            <input class="span6 required" type="text" value="" name="phone" id="phone" />
	                        </div>
	                        <div class="control-group">
	                            <label for="company" class="control-label">
	                                公司
	                            </label>
	                            <input class="span6" type="text" value="" name="company" id="postcode"
	                            />
	                        </div>
	                        <div class="control-group">
	                            <label for="email" class="control-label">
	                                电子邮件
	                                <span class="text-error">
	                                    *
	                                </span>
	                            </label>
	                            <input class="span6 required" type="text" value="" name="email" id="email" />
	                        </div>
	                        <div class="control-group">
	                            <label for="email" class="control-label">
	                                照片
	                                <span class="text-error">
	                                    *
	                                </span>
	                            </label>
	                       
							选择文件:<input type="file" name="file">  
							  
	                        </div><%--
	                        <div class="control-group padding_top10">
	                            <button id="buttonsave_info"  onClick="checkform()"; name="buttonsave_info" class="btn btn-gold infor_form_button"
	                            type="button"  value=" 提交申请"/>
	                            <button id="clearbutton_info"   onClick="clearValue()"  name="clearbutton_info" class="btn btn-black infor_form_button"
	                            type="button"   value="清除"/>
	                        </div>
                        --%>
                          <input type="submit" value="提交">   
                          
                          </form>
                    </div>
                    <!--span6-->
                </span>
            </div>
            <!--form_bg-->
            <div class="support_com">
            <p>支持媒体：</p>
            <p><span>Zaviar-SF、ladymax、瑞丽、vogue、新浪时尚、海报网、Yoka时尚网、网易时尚、搜狐时尚、凤凰时尚、南方都市报、精品生活、新现代画报、羊城晚报、新快报、优家画报、城市画报、风尚中国、时尚中国等</span></p>
            </div>
            <!--support_com-->
        </div>
        <!--bg-s-->
    </div>

</body>
</html>
