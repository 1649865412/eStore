function fnSelectWrap(){
	var wrapId=$("input[name='wrap_wrapId'][checked]").val();
	if(wrapId){
		var warpPrice=$("#wrapPrice_"+wrapId).val();
		var cost = parseFloat(warpPrice).toFixed(2);
		$("#cart_wrap").text(cost);
		if(warpPrice==0){
		$("#wrap_tr").hide();
		$("#wrap").val("false");
		}else{
			$("#wrap_tr").show();
			$("#wrap").val("true");
		}
		fnUpdatePrice();
		if(wrapId>0){
			$("#cardForm").show();
		}else{
			$("#cardForm").hide();
		}
	}
}
function fnSelectShipping(){
	/*
	var shippingPrice=0;
	if($("input[name='shippingMethodId'][checked]")){
		var shippingId=$("input[name='shippingMethodId'][checked]").val().split(",")[1];
		shippingPrice=$("#cartShipping_"+shippingId).val();
	}
	var cost = parseFloat(shippingPrice).toFixed(2);
	$("#cart_shipping").text(cost);
	if(shippingPrice==0){
		$("#shipping_tr").hide();
	}else{
		$("#shipping_tr").show();
	}
	*/
	fnUpdatePrice();
}

function fnUpdatePrice(){
	//parseFloat($("#cart_wrap").text())+parseFloat($("#cart_shipping").text())+parseFloat($("#cart_tax").text()
	var cartTotal = parseFloat($("#cart_total").text()); //${shoppingcart.subtotal }
	var saveTotal =  parseFloat($("#save").text());   //${shoppingcart.cartDiscountAmount }
	var giftTotal = parseFloat($("#giftPay").text());//${shoppingcart.giftCertificateNos}
	var pointTotal = parseFloat($("#point").text());//${shoppingcart.shopPoint * appConfig.shopPointUseGiftPercent}
	var fullCutTotal = parseFloat($("#full_cut").text());
	
	/*alert("cartTotal:"+cartTotal);
	alert("saveTotal:"+saveTotal);
	alert("giftTotal:"+giftTotal);
	alert("pointTotal:"+pointTotal);*/
	
	
	var discount = saveTotal + giftTotal + pointTotal+fullCutTotal;
	$("#discount").text(discount.toFixed(2));
	var total = parseFloat(cartTotal - discount);
	if(total < 0){
		total = 0;
	}
	if(total < 100){
		var ship = parseFloat($("#cart_shipping").text());
		total = total + ship;
		//$("#shipping_tr").show();
		$("#shippingRate").text(ship.toFixed(2));
	}
	$("#cart_sum").text(total.toFixed(2));
}
function fnCheckPlaceOrder(){
	if($("input[name='shippingMethodId'][checked]").length==0){
		alert(__FMT.checkou_noship);
		return false;
	}
	return true;
}
function showExplain(cp){
	var methodId=cp.value;
	var methodExplains=$("[name='pmd']");
	methodExplains.each(function(i){
	   if(this.id==("pmd_"+ methodId)){
	   		$(this).show();
		 }else{
		 	$(this).hide();
		 }
	 }); 
}
function fnUseGift(giftCertificateNo){
	var giftList=$("#giftPaymentData").data("giftList");
	if(!giftList){
		giftList=new Array();
	}
	if(!giftCertificateNo){
		giftCertificateNo=$("#giftCertificateNo").val();
		giftCertificateNo=giftCertificateNo.trim();
		for(var i=0;i<giftList.length;i++){
			if(giftList[i].code==giftCertificateNo){
				alert("This Gift Certificate has already been used.");
				return;
			}
		}
	}
	var cart_sum = parseFloat($("#cart_sum").text());
	var giftPay=0;
	$.post(__ctxPath+"/checkout/paymentProcess.html?doAction=doUseGc",{giftCertificateNo:giftCertificateNo,money:cart_sum},function(result){
		if(result.status==1){
			var code=giftCertificateNo;
			var money=result.data;
			giftList.push({code:code,money:money});
			$("#giftPaymentData").data("giftList",giftList);
			$("#usedGiftNoTab").append('<span id='+code+'>'+code+"&nbsp;&nbsp;&nbsp;&nbsp;¥"+money+'<a href="javascript:void(0)" onclick="fnRemoveGift(\''+code+'\')" title="'+__FMT.del+'">  [X]</a><br/></span>');
			$("#usedGiftNoDiv").show();
			var giftPay_sum = parseFloat($("#giftPay").text());
			$("#giftPay").text(giftPay_sum+money);
			$("#gift_tr").show();
			$("#cart_sum").text(cart_sum-money);
			var giftCertificateNos=$("#giftCertificateNos").val();
			if(giftCertificateNos!=""){
				giftCertificateNos+="#";
			}
			giftCertificateNos+=code+":"+money;
			$("#giftCertificateNos").val(giftCertificateNos);
			$("#giftCertificate").val(true);
			$("#giftCertificateNo").val('');
			$("#giftContent").hide();
		}else{
			alert(result.msg);
		}
	},"json");
}

function fnRemoveGift(no){
	var cart_sum = parseFloat($("#cart_sum").text());
	var giftPay_sum = parseFloat($("#giftPay").text());
	var giftList=$("#giftPaymentData").data("giftList");
	var giftPay=0;
	var removeGiftMoney=0;
	for(var i=0;i<giftList.length;i++){
		if(giftList[i].code==no){
			removeGiftMoney=giftList[i].money;
			giftList.splice(i,1);
			break;
		}
	}
	
	var giftCertificateNos="";
	for(var i=0;i<giftList.length;i++){
		if(i!=0){
			giftCertificateNos+="#";
		}
		giftCertificateNos+=giftList[i].code+":"+giftList[i].money;
	}
	$("#giftCertificateNos").val(giftCertificateNos);
	$("#giftPay").text(giftPay);
	$("#cart_sum").text(cart_sum+removeGiftMoney);
	$("#"+no).remove();
	if(giftList.length==0){
	 	$("#usedGiftNoDiv").hide();
		$("#giftCertificate").val(false);
	}
	else{
	 	$("#usedGiftNoDiv").show();
	}
	$("#giftContent").show();
}

//产品详情页
$(document).ready(function(){
	$("input[name='wrap_wrapId']").change(fnSelectWrap);
	$("input[name='shippingMethodId']").change(fnSelectShipping);
	fnSelectWrap();
	fnSelectShipping();
	$("#giftCertificateNos").val('');
	$("#giftCertificate").val(false);
	
	$("#myGiftList").find("a").click(function(){
		var giftNum=$(this).closest("tr").attr("giftNum");
		fnUseGift(giftNum);
	});
});