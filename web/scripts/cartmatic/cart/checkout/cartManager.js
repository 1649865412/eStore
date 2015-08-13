//礼品卡使用
function fnUseGift(giftCertificateNo, type) {
	if (type == 1) { // 手动输入礼品卡
		if ($("#giftCertificateNo").val() == '') {
			$.post(__ctxPath
					+ "/checkout/paymentProcess.html?doAction=notuseGc", {
				giftCertificateNo : giftCertificateNo
			}, function(result) {
				var t = parseFloat('0.0');
				$("#giftPay").text(t.toFixed(2));
				$("#couponNo_input_id").attr("disabled", false);
				fnUpdatePrice();
			}, "json");
		}

		if (giftCertificateNo == $("#giftCertificateNo").val()) {
			return false;
		}

		else {
			giftCertificateNo = $("#giftCertificateNo").val();
			var cart_sum = parseFloat($("#cart_sum").text());
			$.post(
					__ctxPath
							+ "/checkout/paymentProcess.html?doAction=doUseGc",
					{
						giftCertificateNo : giftCertificateNo,
						money : cart_sum
					}, function(result) {
						if (result.status == 1) {
							var code = giftCertificateNo;
							var money = result.data;
							var giftPay_sum = parseFloat($("#giftPay").text());
							$("#giftPay").text(money.toFixed(2));
							// $("#cart_sum").text(cart_sum-money);
					/*
					 * var giftCertificateNos=''; if(giftCertificateNos!=""){
					 * giftCertificateNos+="#"; }
					 * giftCertificateNos+=code+":"+money;
					 * $("#giftCertificateNos").val(giftCertificateNos);
					 * $("#giftCertificate").val(true);
					 * $("#giftCertificateNo").val(giftCertificateNo);
					 */
					$("#couponNo_input_id").attr("disabled", true);
				} else {
					// if(giftCertificateNo &&
					// giftCertificateNo!=$("#giftCertificateNo").val())
					alert(result.msg);
					// $("#giftCertificateNo").val(giftCertificateNo);
					$("#giftPay").text("0.00");
					$("#couponNo_input_id").attr("disabled", false);
				}
				fnUpdatePrice();
			}, "json");
		}
	}
	if (type == 2) { // 点击已绑定礼品卡
		if (giftCertificateNo == $("#giftCertificateNo").val()) {
			return false;
		} else {
			$("#giftCertificateNo").val(giftCertificateNo);
			var cart_sum = parseFloat($("#cart_sum").text());
			$.post(
					__ctxPath
							+ "/checkout/paymentProcess.html?doAction=doUseGc",
					{
						giftCertificateNo : $("#giftCertificateNo").val(),
						money : cart_sum
					}, function(result) {
						if (result.status == 1) {
							var code = giftCertificateNo;
							var money = result.data;
							var giftPay_sum = parseFloat($("#giftPay").text());
							$("#giftPay").text(money.toFixed(2));
							// $("#cart_sum").text(cart_sum-money);
					var giftCertificateNos = $("#giftCertificateNos").val();
					if (giftCertificateNos != "") {
						giftCertificateNos += "#";
					}
					giftCertificateNos += code + ":" + money;
					$("#giftCertificateNos").val(giftCertificateNos);
					$("#giftCertificate").val(true);
					$("#giftCertificateNo").val(giftCertificateNo);
					$("#couponNo_input_id").attr("disabled", true);
				} else {
					// if(giftCertificateNo &&
					// giftCertificateNo!=$("#giftCertificateNo").val())
					alert(result.msg);
					// $("#giftCertificateNo").val(giftCertificateNo);
					$("#giftPay").text("0.00");
					$("#couponNo_input_id").attr("disabled", false);
				}
				fnUpdatePrice();
			}, "json");
		}
		hideTemlateList();
	}
}

// 优惠劵使用
function fnUseCoupon(couponId) {
	if ($("#couponNo_input_id").val() == couponId) {
		return false;
	} else if ($("#couponNo_input_id").val() == '') {
		$.post(__ctxPath + "/cart/shoppingcart.html?doAction=notuseCoupon", {
			couponNo_input_name : $("#couponNo_input_id").val()
		}, function(result) {
			var dis = parseFloat($("#cart_dis_member").val());
			// $("#cartDiscountAmount").text(dis.toFixed(2));
				$("#cartDiscountAmount").text("0.00");
				$("#giftCertificateNo").attr("disabled", false);
				fnUpdatePrice();
			}, "json");
	} else {
		var dis = parseFloat($("#cart_dis_member").val());
		$
				.post(
						__ctxPath
								+ "/cart/shoppingcart.html?doAction=useCoupon",
						{
							couponNo_input_name : $("#couponNo_input_id").val()
						},
						function(result) {
							var cartDiscountAmount = 0;
							if (result.status == 1) {
								var money = result.data;
								$("#cartDiscountAmount").text(
										(money).toFixed(2));
								cartDiscountAmount = parseFloat($(
										"#cartDiscountAmount").text());
								$("#giftCertificateNo").attr("disabled", true);
							} else {
								alert(result.msg);
								cartDiscountAmount = result.data;
								$("#cartDiscountAmount").text("0.00");
								$("#cart_dis_member").val(cartDiscountAmount);
								$("#giftCertificateNo").attr("disabled", false);
							}
							fnUpdatePrice();
						}, "json");
	}
}

// 进入卷控使用
function fnjuankongPay() {
	// alert("进入卷控使用方法");
	// alert("value:"+$("#juankongPayNo").val());
	$.post(__ctxPath + "/cart/shoppingcart.html?doAction=juankongPay", {
		juankongNo : $("#juankongPayNo").val()
	}, function(result) {
		// alert("result:"+result.status);
			if (result.status == 1) {
				$("#juankongPay").text("500"); 
			} else {
				alert("验证不通过");
			}
			fnUpdatePrice();
		}, "json");
}

// 价格刷新
/*
 * cart_dis_member 惠员优惠 CartDiscountAmount 优惠卷优惠 giftPay 礼品卡礼卷 cart_sum_prev
 * 所有的原先总价格 shopPointMoney 积分优惠 juankongPay 卷控优惠 cart_sum 最终价格
 */
function fnUpdatePrice() {
	// alert("fnUpdatePrice");
	var cartTotal = parseFloat($("#cart_sum_prev").val());// 所有的原先总价格
	var cart_dis_member = parseFloat($("#cart_dis_member").text());// 惠员优惠
	var cart_full_cut = parseFloat($("#cart_full_cut").text());// 满减优惠
	var discount = parseFloat($("#cartDiscountAmount").text());// 优惠卷优惠
	var giftTotal = parseFloat($("#giftPay").text());// 礼品卡礼卷
	var pointTotal = parseFloat($("#shopPointMoney").text());// 积分优惠
	var juankongPay = "";
	var total = "";

	// alert("object:"+$("#juankongPay").text());
	// alert("object:"+$("#juankongPay"));
	if ($("#juankongPay").text().trim() != "") {
		// alert("it is not null")
		juankongPay = parseFloat($("#juankongPay").text()); // 卷控优惠
		total = parseFloat(
				cartTotal - cart_dis_member - discount - giftTotal - pointTotal
						- juankongPay).toFixed(2);
	} else if ($("#cart_full_cut").text() != 0) {
		total = parseFloat(
				cartTotal - cart_dis_member - cart_full_cut - discount
						- giftTotal - pointTotal).toFixed(2);
	} else {
		// alert("it is null")
		total = parseFloat(
				cartTotal - cart_dis_member - discount - giftTotal - pointTotal)
				.toFixed(2);
	}

	$("#cart_sum").text(total < 0 ? '0.00' : total);

	// 隐藏积分优惠下拉框触发
	if (total < 300 || discount != 0 || giftTotal !=0) {
		$("#selectbasic").attr("disabled", true);
	} else {
		$("#selectbasic").attr("disabled", false);
	}
}

// 显示用户绑定的礼品卡
function showGiftList() {
	var giftCertificateNo = $("#giftCertificateNo");
	var giftCertificateNoOffset = giftCertificateNo.offset();
	$("#giftList").css(
			{
				left : giftCertificateNoOffset.left + "px",
				top : giftCertificateNoOffset.top
						+ giftCertificateNo.outerHeight() + "px"
			}).slideDown("fast");

	$("body").bind("mousedown", onBodyDown);
}

function hideTemlateList() {
	$("#giftList").fadeOut("fast");
	$("body").unbind("mousedown", onBodyDown);
}

function onBodyDown(event) {
	if (!(event.target.id == "giftList" || $(event.target).parents("#giftList").length > 0)) {
		hideTemlateList();
	}
}
// 购物车商品-1
function substractQuantity(obj, shoppingcartItemId, cartUuid, price,
		discountPrice, oldSubtotal, cartDiscountAmount) {
	var $this = $(obj);
	var $next = $this.next();
	if ($("#subtotal").text().trim() != "") {
		var subtotal = $("#subtotal").text();
	} else {
		var subtotal = 0;
	}
	if ($("#sum").text().trim() != "") {
		var buyNowItemsCount = $("#sum").text();
	} else {
		var buyNowItemsCount = 0;
	}
	var memberDiscount = cartDiscountAmount / oldSubtotal;
	var newSubtotal = parseFloat(Number(subtotal) - Number(discountPrice))
			.toFixed(2);
	var newMemberDiscount = parseFloat(
			((newSubtotal * 100) * (memberDiscount * 100)) / 10000).toFixed(2);
	if (parseInt($next.val()) != 1) {
		$next.val(parseInt($next.val()) - 1);
		$
				.post(
						__ctxPath
								+ "/cart/shoppingcart.html?doAction=substractQuantity",
						{
							shoppingcartItemId : shoppingcartItemId,
							cartUuid : cartUuid
						},
						function(result) {
							if (result.msg != 0) {
								$("#cart_full_cut").text(result.msg);
								fnUpdatePrice();
							} else {
								$("#cart_full_cut").text(0);
								document.getElementById("full_cut").style.display = "none";
								fnUpdatePrice();
							}
						}, "json");

		$("span[id='discountPrice_" + shoppingcartItemId + "']").each(
				function() {
					$(this).html(
							"￥"
									+ parseFloat(
											(price - discountPrice)
													* $next.val()).toFixed(2));
				});
		$("span[id='oneTotalPrice_" + shoppingcartItemId + "']").each(
				function() {
					$(this).html(
							"￥"
									+ parseFloat(discountPrice * $next.val())
											.toFixed(2));
				});
		$("#sum").text(Number(buyNowItemsCount) - 1);
		// $("span[id='sum']").each(function() {
		// $(this).html(Number(buyNowItemsCount) - 1);
		// });
		$("#cart_sum_prev").val(newSubtotal);
		$("#subtotal").text(newSubtotal);
		// $("span[id='subtotal']").each(function() {
		// $(this).html(newSubtotal);
		// });
		$("#cart_dis_member").text(newMemberDiscount);
		// $("span[id='cart_dis_member']").each(function() {
		// $(this).html(newMemberDiscount);
		// });
		fnUpdatePrice();
	}
}

// 购物车商品+1
function addQuantity(obj, shoppingcartItemId, cartUuid, price, discountPrice,
		oldSubtotal, cartDiscountAmount, productSkuId, quantityOnHand) {
	var $this = $(obj);
	var $prev = $this.prev();
	if ($prev.val() != quantityOnHand) {
		if ($("#subtotal").text().trim() != "") {
			var subtotal = $("#subtotal").text();
		} else {
			var subtotal = 0;
		}
		if ($("#sum").text().trim() != "") {
			var buyNowItemsCount = $("#sum").text();
		} else {
			var buyNowItemsCount = 0;
		}
		var memberDiscount = cartDiscountAmount / oldSubtotal;
		var newSubtotal = parseFloat(Number(subtotal) + Number(discountPrice))
				.toFixed(2);
		var newMemberDiscount = parseFloat(
				((newSubtotal * 100) * (memberDiscount * 100)) / 10000)
				.toFixed(2);
		$prev.val(parseInt($prev.val()) + 1);
		$.post(__ctxPath + "/cart/shoppingcart.html?doAction=addQuantity", {
			shoppingcartItemId : shoppingcartItemId,
			cartUuid : cartUuid,
			productSkuId : productSkuId
		}, function(result) {
			// alert("result.msg"+result.msg);
				if (result.msg != 0) {
					$("#cart_full_cut").text(result.msg);
					document.getElementById("full_cut").style.display = "";
					// $("#full_cut").attr("display","");
				fnUpdatePrice();
			}
		}, "json");

		$("span[id='discountPrice_" + shoppingcartItemId + "']").each(
				function() {
					$(this).html(
							"￥"
									+ parseFloat(
											(price - discountPrice)
													* $prev.val()).toFixed(2));
				});
		$("span[id='oneTotalPrice_" + shoppingcartItemId + "']").each(
				function() {
					$(this).html(
							"￥"
									+ parseFloat(discountPrice * $prev.val())
											.toFixed(2));
				});
		$("#sum").text(Number(buyNowItemsCount) + 1);
		// $("span[id='sum']").each(function() {
		// $(this).html(Number(buyNowItemsCount) + 1);
		// });
		$("#cart_sum_prev").val(newSubtotal);
		$("#subtotal").text(newSubtotal);
		// $("span[id='subtotal']").each(function() {
		// $(this).html(newSubtotal);
		// });
		$("#cart_dis_member").text(newMemberDiscount);
		// $("span[id='cart_dis_member']").each(function() {
		// $(this).html(newMemberDiscount);
		// });

		fnUpdatePrice();
	} else {
		alert("只剩" + quantityOnHand + "件!");
	}
}

// 积分使用
function fnSelectChangeGift(selectPoint) {
	var shopPointUseGiftPercent = "${appConfig.shopPointUseGiftPercent}";
	var pointDis = (shopPointUseGiftPercent * selectPoint).toFixed(2);
	$("#shopPointMoney").text(pointDis);
	fnUpdatePrice();
	$.post(__ctxPath + "/checkout/paymentProcess.html?doAction=doUseShopPoint",
			{
				selectPoint : selectPoint
			}, function(result) {
			}, "json");

}