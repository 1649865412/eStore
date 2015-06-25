/**
 * 前台个人账号界面整体管理JS文件
 * @author huangwm210 2009-01-20
 */
 
cs = function(){}
cs.val = {
	addressList: __ctxPath+"/myaccount/csAddressList.html",
	addressForm:__ctxPath+"/myaccount/csEditAddress.html",
	feedBackForm:__ctxPath+"/myaccount/csFeedbackReplys.html",
	feedBackReply:__ctxPath+"/myaccount/csFeedback.html",
	wishListForm:__ctxPath+"/myaccount/wishlistEdit.html",
	wishList:__ctxPath+"/myaccount/wishlistManage.html",
	orderForm:__ctxPath+"/myaccount/account.html"
}
cs.util = {
  go:function(url){
	window.location.href = url
  }
}
cs.util.effect = {
	effectShow:function(jObj,w,h){
    	if(jObj.css("display")=="none"){
    	   jObj.height(0);jObj.width(0)
    	}
    	jObj.animate({width:w},{queue: true, duration: "fast"})
				.animate({height:h},{queue: true, duration: "fast"})
    },
	effectHide:function(jObj){
		var h = jObj.height();
		var w = jObj.width();
		if(jObj.css("display")=="none"){
    	   return ;
    	}
		jObj.animate({height:0},{queue: true, duration: "fast"})
			.animate({width:0},{queue: true, duration: "fast",complete:function(){
			    	jObj.hide();jObj.height(h);jObj.width(w);
			    }})
	},
	hideMsg:function(){
		return;
		var msg = $(".account-message");
		var _1 = msg.prev();
		var _2 = msg.next();
	    this.effectHide(msg);
	    this.effectHide(_1)
	    this.effectHide(_2)
	}
}

/**
 * 订单操作类
 */
cs.order = {
	showTimeDiv:function(div){
		var o = $("#timeDiv");
		if(div.value=="specify"){
			cs.util.effect.effectShow(o,370,30);
		}
		else{
			cs.util.effect.effectHide(o);
		}
	},
	query:function(form){
		if((form.startDate.value==""||form.endDate.value=="")&&form.createTimeType.value=="specify"){
			alert(__FMT.orderQueryTimeNull)
			$(form.startDate).focus();
			return false;
		}
	}	
}
/**
 * 反馈处理类
 */
cs.feedBack = {
	edit:function(id){
		$('<form style="display: none;" action="'+cs.val.feedBackForm+'" method="POST"><input name="feedbackId" class="box-input" type="text" value="'+id+'"><input name="doAction" value="feedbackReplyList"></form>').appendTo('body').submit();
	},
	reply:function(originalFbId,curFbId){
		$('<form style="display: none;" action="'+cs.val.feedBackReply+'" method="POST"><input name="curFbId" class="box-input" type="text" value="'+curFbId+'"><input name="originalFbId" type="text" value="'+originalFbId+'"><input name="from" value="list"></form>').appendTo('body').submit();
	}
}

$(document).ready(function(){
	var msg = $(".account-message");
	if(msg.length>0){
		setTimeout('cs.util.effect.hideMsg()',5000);
	}
})
