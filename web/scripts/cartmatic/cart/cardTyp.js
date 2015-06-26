$(document).ready(function(){
	/*
	$(".paymentMethod:radio").change(function(){
		var $this = $(this);
		var $paySubmit = $("#paySubmit");
		var $payMsg = $("#payMsg");
		var code = $this.next().val();
		var cardStr = "";
		cardStr += "您选择的支付方式为：<label style='color:red;'>";
		if(code=="alipay"){
			cardStr += "支付宝</label>";
			$payMsg.html(cardStr);
			$payMsg.show();
			$paySubmit.show();
			var $cardTypChoose = $("#cardTypChoose");
			$cardTypChoose.hide();
		}else if(code == "unionpay"){
			cardStr += "银联在线支付</label>";
			$payMsg.html(cardStr);
			$payMsg.show();
			$paySubmit.show();
			var $cardTypChoose = $("#cardTypChoose");
			$cardTypChoose.hide();
		}else{
			$payMsg.hide();
			$paySubmit.hide();
			var $cardTypChoose = $("#cardTypChoose");
			$cardTypChoose.val("下一步");
			$cardTypChoose.show();
		}
	});
	*/
});

	function showPay(){
		var $cardTypDiv = $("#divDlgcardTypIIII");
		var typeVal = $cardTypDiv.find("input[type='radio']:checked").val();
		var cardStr = "";
		cardStr += "您选择的支付方式为：<label style='color:red;'>";

		var $paymentMethodList = $("#paymentMethodList");
		var $method = $paymentMethodList.find("input[type='radio']:checked");
		var code = $method.next().val();
		cardStr += returnTyp(code,typeVal);
		cardStr += "</label>";
		cardStr += "";
		closeSimpleDialog('cardTypIIII');
		var $payMsg = $("#payMsg");
		$payMsg.html(cardStr);
		$payMsg.show();
		var $paySubmit = $("#paySubmit");
		$paySubmit.show();
		var $cardTypChoose = $("#cardTypChoose");
		$cardTypChoose.val("其他支付类型");
	}

	function returnTyp(code,typeVal){
		var isAlipay = false;
		var cardStr = "";
		switch(code){
		case "alipay":
			cardStr += "支付宝";
			isAlipay = true;
			break;
		case "boc":
			cardStr += "中国银行";
			break;
		case "abc":
			cardStr += "农业银行";
			break;
		case "cmb":
			cardStr += "招商银行";
			break;
		}
		if(isAlipay){
			return cardStr;
		}else{
			switch(typeVal){
			case "1":
				cardStr += "储蓄卡";
				break;
			case "2":
				cardStr += "信用卡";
				break;
			case "3":
				cardStr += "网银";
				break;
			}
			return cardStr;
		}
	}

	function chooseCardTyp(skucode,type,$obj){
	    var popuw = function(skucode,type){
	    	this.skucode = skucode;
	    	this.type = type;
	    	this.$obj = $obj;
	    }
	    popuw.prototype={
	    	id:'cardTypIIII',
	    	skucode:'',
	    	type:1,//购物车,0,收藏夹
	    	messageDlgZIndex:1000,
	    	$obj:"",
			html:$("#cardTypDiv").html(),
			show:function(){
				  var cartDlg=fnCreateSimpleDialog(this.id,'','',{});
				  $("#_dlgContBox"+this.id).html(this.html);
				  cartDlg.showDialog();
			}
	    }
		var win = new popuw(skucode,type);
		win.show();
	}