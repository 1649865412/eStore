<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>周年庆活动</title>

<style>
	*{padding:0;margin:0}
	body{
		text-align:center
	}
	.ly-plate{
		position:relative;
		width:509px;
		height:509px;
		margin: 50px auto;
	}
	.rotate-bg{
		width:509px;
		height:509px;
		background:url(${resPath}/images/ly-plate.png);
		position:absolute;
		top:0;
		left:0
	}
	.ly-plate div.lottery-star{
		width:214px;
		height:214px;
		position:absolute;
		top:150px;
		left:147px;
		/*text-indent:-999em;
		overflow:hidden;
		background:url(rotate-static.png);
		-webkit-transform:rotate(0deg);*/
		outline:none
	}
	.ly-plate div.lottery-star #lotteryBtn{
		cursor: pointer;
		position: absolute;
		top:0;
		left:0;
		*left:-107px
	}
.opipoverlay{height: 100%;left: 0;position: fixed;top: 0;width: 100%;z-index: 999;background:url(${resPath}/images/icon/overlay.png) repeat;}
.more-photo{background-clip:padding-box;border-radius: 6px 6px 6px 6px; box-shadow: 0 3px 7px rgba(0, 0, 0, 0.3);float: left;padding: 0;position:absolute;z-index: 2000;width:900px;background:url(../images/layout/more_photo.gif) right repeat-y #fff; display:block;}
.more-title{border-bottom: 1px solid #DDDDDD;color: #333333; width:100%; height:30px;}
.more-title strong{ display:block; float:left;font-size:16px;padding: 10px 40px 10px 10px;}
.more-title .m-close a{ float:right; margin:-15px -15px 0 0; display:block; width:35px; height:35px;background:url(${resPath}/images/icon/fancybox_sprite.png) no-repeat;}
.more-title .m-close a:hover{background:url(${resPath}/images/icon/fancybox_sprite.png) no-repeat;}
.pre-arrow a{background:url(../images/icon/l_1.gif) no-repeat;display:block;width:18px; height:27px;float:left; margin:300px 10px 0 10px;}
.pre-arrow a:hover{background:url(../images/icon/l_2.gif) no-repeat; }
.more-photo .photo{ width:720px; float:left; text-align:center;}
.next-arrow a{background:url(../images/icon/r_1.gif) no-repeat; display:block;float:left; margin:300px 10px 0 10px;width:18px; height:27px;}
.next-arrow a:hover{background:url(../images/icon/r_2.gif) no-repeat;}
.sphoto{ width:172px; float:right;}
.sphoto li{float:left;width:44px;height:44px;padding-left:10px;cursor:pointer; margin-top:10px;}
.sphoto li img{cursor:pointer;border:1px solid #ccc;}
.sphoto li.selected img{ border:1px solid #f00;}
.sifang{ width:600px;}
.sifang .more-content{padding:10px; line-height:180%;}
.sifang .left {
	width:350px;
	display:inline
}
.sifang h2 {
	color:#000;
	font-size:18px;
	font-weight:bold;
}
.sifang .wrap-line {
	background-color:#fff;
	padding:0 10px;
	margin:10px 0;
	overflow:hidden;
	width:350px;
	float:left
}
.sifang .photo {
	float:left;
	width:170px
}
.sifang .txt {
	float:right;
	width:180px;
	padding-top:8px;
}
.sifang .right {
	margin:10px 0 0 0;
	line-height:180%;
	font-size:14px;
	display:inline;
	width:200px;
	background-color:#FFFEE0;
	padding:4px 0 6px 15px;
}
.sifang .right h2 {
	color:#818181;
	font-size:14px;
	text-indent:0
}
</style>
<script src="${ctxPath }/scripts/activity/jQueryRotate.2.2.js"></script>
<script src="${ctxPath }/scripts/activity/jquery.easing.min.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>

</head>

<body>

	<div class="ly-plate">
		<div class="rotate-bg"></div>
		<div class="lottery-star">
			<img src="${resPath }/images/rotate-static.png" id="startbtn" />
		</div>
	</div>
	
	
<script>
$(function(){

	$("#startbtn").click(function(){ 
		doRequiredLoginAction(function(){
			lottery(); 
		} , 1);
    }); 
	
});

function lottery(){ 

	/*
	$.post(__ctxPath+"/activity/lottery.html",function(result){
		if(result.status==-500){
			alert("系统错误了!");
		}else{
			var count=result.data;
			if (count > 0)
				$("#reviews_count").append("("+count+")");
			else
				$("#reviews_count").append("(0)");
		}
	},"json");
	*/
    $.ajax({ 
        type: 'POST', 
        url: __ctxPath+"/activity/lottery.html", 
        dataType: 'json', 
        cache: false, 
        error: function(){ 
            alert('抱歉，服务器繁忙，请稍后再试！'); 
            return false; 
        }, 
        success:function(json){ 
            debugger;
            //$("#startbtn").unbind('click').css("cursor","default"); 
            var l = json.level; //等级
            if(l == -2){
                alert("抱歉，您已进行过抽奖，每个用户只能参加一次抽奖！");
            }
            else if(l == -3){
                alert("抱歉 , 您必须在周年庆活动时间内购买了本站商品才能参加此奖活动！");
            }
            else{
            	var a = json.angle; //角度 
                var p = json.prize;
                $("#startbtn").rotate({ 
                    duration:3000, //转动时间 
                    angle: 0, 
                    animateTo:1800+a, //转动角度 
                    easing: $.easing.easeOutSine, 
                    callback: function(){ 
                       show(l,p);
                    } 
                }); 
            }
        } 
    }); 
}

function show(level,prize){
	switch(level){
	case 1:
		alert("恭喜您，您抽到了一等奖，奖品为 "+ prize +"！");
		break;
	case 2:
		alert("恭喜您，您抽到了二等奖，奖品为 "+ prize +"！");
		break;
	case 3:
		alert("恭喜您，您抽到了三等奖，奖品为 "+ prize +"！");
		break;
	case -1:
		alert("很遗憾，您这次没有抽到奖品！");
		break;
	}
}
</script>
	
</body>
</html>
