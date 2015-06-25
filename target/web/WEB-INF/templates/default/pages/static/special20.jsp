<%@ page pageEncoding="utf-8"%>
<html>
<head>
	<title>四方街神秘礼品派送</title>
</head>
<body>
<div><img src="/images/special20.jpg" width="1000" height="1123" alt="" border="0" usemap="#Map" style="display:block;">
<map name="Map" id="Map">
    <area shape="rect" coords="629,460,823,516" href="javascript:void(0);" onclick="showTip();" />
    <area shape="rect" coords="434,1037,565,1079" href="${ctxPath }/index.html" />
  </map>
  </div>

 <div class="blank10"></div> 
<div class="blank10"></div> 
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
<script>
function showTip(){

	doRequiredLoginAction(function(){
		var popuw = function(skucode,type){
	    	this.skucode = skucode;
	    	this.type = type;
	    }
	    popuw.prototype={
	    	id:'tips_',
	    	skucode:'',
	    	type:1,//购物车,0,收藏夹
	    	messageDlgZIndex:1000,
			html:$("#tips").html(),
			show:function(){
				  var cartDlg=fnCreateSimpleDialog(this.id,'','',{});
				  $("#_dlgContBox"+this.id).html(this.html);
				  cartDlg.showDialog();
			}
	    }
		var win = new popuw('',1);
		win.show();
	});

}
</script>

<div id="tips" style="display: none;">
我们首次派送的神秘礼品是——四方街网价值30元现金券，券码是：

<span id="tips2"  style="color: red">sifangstreet08</span><br/>

 购全场任意产品时（部分指定折扣款除外），在结算时输入券号，
 
 系统将自动扣减礼<br/>券金额。这次活动只是8月份的一个开始，咱们的活动陆续有来哦！
<br/>TIPS：
	<br/>&nbsp;&nbsp;&nbsp;1.请您务必把优惠券复制保存好哦！
	<br/>&nbsp;&nbsp;&nbsp;2.现金券有效使用期于2014年9月8日 12:00 结束！
	<br/>&nbsp;&nbsp;&nbsp;3.现金券与礼品卡不能同时使用！
	<br/>&nbsp;&nbsp;&nbsp;4.现金券于同一张订单中无法叠加使用！
	<br/>
</div>

</body>
</html>