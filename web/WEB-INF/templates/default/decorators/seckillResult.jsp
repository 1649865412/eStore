<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<title><decorator:title /></title>
		<%@ include file="./include/meta.jspf"%>
		<%@ include file="./include/styles.jspf"%>
		<%@ include file="./include/styles3.jspf"%>
		<%@ include file="./include/javascripts.jspf"%>
		<decorator:head />
		

	</head>
	
	<script type="text/javascript" defer="defer">

	$(function(){
		  //  checkTime();
			changeStay();
			})
		
    //判断到秒杀时间是不是在1个小时内		
	function checkTime(){
		//alert("checkTime"+setTime());
		var flag = true;
		var how =  new Date(setTime());
		var today = new Date();
		var hourCha = parseInt(( how.getTime() - today.getTime()) / 1000 / 60 / 60);
		//alert("相差多少小时：" + hourCha);
		return hourCha;
		}

	
	  //判断是哪一天的秒杀
	   function setDifferant()
	   {
             var number="";
			 var time =getdayTime();
                  if(time=="2015年5月8日"){
                     number="1"
                  }else if(time=="2015年5月9日"){
                     number="2"
                  }else if(time=="2015年5月10日"){
                     number="3"
                  }  
          //     alert("number:"+number);
                  return number;
	   }


	  
     //秒杀状态切换
		function changeStay(){
		      var number =setDifferant();
		    //  alert(number);
		      var willbegin="<div class='times' ><p><span>即将开始</span></p></div>";
		      var gameover="<div class='times' ><p><span>秒杀已结束</span></p></div>";
                 if(number=="1")
                 {
                    $("#time2,#time3").html(willbegin);
                 }
                 else if(number=="2")
                 {
                   $("#time1").html(gameover);
                   $("#time3").html(willbegin);
                 }
                 else if(number=="3")
                 {
                  $("#time1,#time2").html(gameover);
                 } else
		   {
			    $("#time1,#time2,#time3").html(willbegin);
		    } 
		}


     
     //获取当前时间	（仅做前期判断是哪一天的秒杀）	 
      function getdayTime()
      {
	      var a = new Date(); 
          a =a.getFullYear()+ "年"+(a.getMonth()+1)+"月"+a.getDate()+"日";
          //测试
         //  a="2015年5月9日"
		   return a;
	  }
     
	  
	//倒计时时间动态设置 ，以早上10点为准
	     function setTime()
	     {
	       	var a = new Date(); 
	       	var hour =" 10:00:00";
            a =a.getFullYear()+ "/"+(a.getMonth()+1)+"/"+a.getDate()+hour;
          //测试
       //     a="2015/5/5 17:60:00"
			return a;
	   }

		   
		   
	 	
	//重置为0;	   10点之后，显示秒杀已开始;
    function resetZero(number){
        //   alert("resetZero")
    	//   document.getElementById("t_h"+number).innerHTML = "00时"; 
	    //   document.getElementById("t_m"+number).innerHTML =  "00分"; 
		//	 document.getElementById("t_s"+number).innerHTML =  "00秒"; 
        //	 alert("number:"+number);
		//   10点之后，显示秒杀已开始;
			$("#time"+number).html("<p><span>秒杀已开始</span></p>");
        }
	  setInterval(getRTime,1000); 	


	  
	  	 
	//倒计时开始	  
		function getRTime(){
			//alert(checkTime());
			var check = checkTime();
			//alert("check:"+check);
			if(check>=1)
			{ 
				//alert("hello");
				number =setDifferant();
			  $("#time"+number).html("<p><span>即将开始</span></p>");
		}else{
			 var EndTime= new Date(setTime()); //截止时间 
				var NowTime = new Date(); 
				var t =EndTime.getTime() - NowTime.getTime(); 
				var d=Math.floor(t/1000/60/60/24); 
				var h=Math.floor(t/1000/60/60%24); 
				var m=Math.floor(t/1000/60%60); 
				var s=Math.floor(t/1000%60);
				number =setDifferant();
				//alert("number:"+number);
				if(h=="0"&&m=="0"&&s=="0")
		  {
				 resetZero(number);
			  
		   } else if(h<="0"&&m<="0"&&s<="0")
			   {
			   resetZero(number)
			   } 
			 else
		   {
			    document.getElementById("t_h"+number).innerHTML = h + "时"; 
				document.getElementById("t_m"+number).innerHTML = m + "分"; 
				document.getElementById("t_s"+number).innerHTML = s + "秒"; 
		   }
				
			}
	}
       </script> 
       
	<body 
			<%-- ========== 头部开始 ========= --%>
			
				<%@ include file="./include/header.jspf"%>

			<%-- ========== 头部结束 ========= --%>
			<%-- ========== 内容开始 ========= --%>
			<div class="lyt-maincontent">
				<div class="position-wrap">
					<%@ include file="include/navigatorBar.jspf"%>
				</div>
                <div class="blank10"></div>
                <decorator:body />
                <div class="blank10"></div>
			</div>
			<%-- ========== 内容结束 ========= --%>
     
			<%-- ========== 底部开始 ========= --%>
		
				<%@ include file="./include/footer.jspf"%>
	
			<%-- ========== 底部结束 ========= --%>
	
	</body>
</html>
