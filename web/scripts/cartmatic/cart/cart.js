/**
 * 购物车管理类,提供操作购物车的所有静态方法，不需要进行初始化
 * 1、每个方法成功执行，均返回字符串：ok
 * 2、依赖关系：依赖shoppingcartDwr,系统js框架的其他的JS库
 * 3、在页面上，请使用：$cm.XX() 来操作购物车,请不要直接使用ShoppingcartManager.XXX()
 * @author huang wenmin 2008-11-28
 */
var ShoppingcartManager = function(){
}
/**
 * 将产品加入购物车
 * @param skuCode
 *        产品skuCode
 * @param pSkuCodes
 *        子产品的skuCodes，多个子产品以,隔开，假如没有子产品，该参数请输入null值
 * @param quantity
 *        数量
 */
ShoppingcartManager.addToC=function(skuCode,pSkuCodes,quantity,accessories){
	this.$add(skuCode,pSkuCodes,quantity,1,accessories);
}
/**
 * 将产品加入收藏夹
 * @param skuCode
 *        产品skuCode
 * @param pSkuCodes
 *        子产品的skuCodes，多个子产品以,隔开,假如没有子产品，该参数请输入null值
 * @param quantity
 *        数量
 */
ShoppingcartManager.addToF=function(skuCode,pSkuCodes,quantity){
   this.$add(skuCode,pSkuCodes,quantity,0);
}
/**
 * 提交购物车
 */
ShoppingcartManager.submitCart=function(){
	$("#cart_form").submit();
}

/**
 * TO DEVELOPER:此方法不对页面公开
 * @param skuCode
 * @param pSkuCodes 子item
 * @param quantity
 * @param type
 *        1 购物车
 *        0 收藏夹
 * @accessories 是附件的ids,格式id1,id2....
 */
ShoppingcartManager.$add=function(skuCode,pSkuCodes,quantity,type,accessories){
	if (!accessories)
		accessories = "";
	if($cm.isBusy){
		return;
	}
	else{
		$cm.isBusy = true;
		setTimeout("$cm.isBusy=false",1000);
	}
	var obj = getEventSourceObject();
	if(type==0){
		if(pSkuCodes==null||pSkuCodes.length==0)
		{
			ajaxCall(__ctxPath+"/cart/shoppingcart.html", 
					"doAction=addProductToFavorite&productsku=" + skuCode + "&quantity=" + quantity + "&accessoryIds=" + accessories, 
					"POST", 
					true,
					function(data){
		    			if(data=="ok")
		    				ShoppingcartManager.alert(skuCode,0,obj);
		    			else
		    				alert(__FMT.notAnonymousF);
		     		});
		}
		else
		{
			ajaxCall(__ctxPath+"/cart/shoppingcart.html", 
					"doAction=addMultiProductToCart&productsku=" + skuCode + "&quantity=" + quantity + "&accessoryIds=" + accessories + "&childrenskus="+pSkuCodes + "&isSaved=true", 
					"POST", 
					true,
					function(data){
		    			if(data=="ok")
		    				ShoppingcartManager.alert(skuCode,0,obj);
		    			else
		    				alert(__FMT.notAnonymousF);
		     		});
		}
	}
	else if(type==1){
		$(obj).removeClass("addtocart-on").addClass("loading");
		if(pSkuCodes==null||pSkuCodes.length==0){
			var customMade=$("#customMadeForm:visible").find("input[name^='customMade_']").serialize();
			ajaxCall(__ctxPath+"/cart/shoppingcart.html", 
					"doAction=addProductToCart&productsku=" + skuCode + "&quantity=" + quantity + "&accessoryIds=" + accessories +"&"+customMade, 
					"POST", 
					true,
					function(data){
						var jdata=eval("(" + data + ")");
						var adata = jdata.message.split(":");
						if(adata[0]==__FMT.cannotMoveToC){
							alert(adata[1]+__FMT.update_stockNotEnough);
						}
						else if(adata[0]==__FMT.noMoreInvetory){
							alert(adata[1]+__FMT.update_noMoreInventory);
						}
						else{
							ShoppingcartManager.alert(skuCode,1,obj,jdata);	
						}
						$(obj).removeClass("loading").addClass("addtocart-on");
		     		});
		}
		else{
			ajaxCall(__ctxPath+"/cart/shoppingcart.html", 
					"doAction=addMultiProductToCart&productsku=" + skuCode + "&quantity=" + quantity + "&accessoryIds=" + accessories + "&childrenskus="+pSkuCodes , 
					"POST", 
					true,
					function(data){
						data = data.split(":");
						if(data[0]==__FMT.cannotMoveToC){
							alert(data[1]+__FMT.update_stockNotEnough);
						}
						else if(data[0]==__FMT.noMoreInvetory){
							alert(data[1]+__FMT.update_noMoreInventory);
						}
						else
							ShoppingcartManager.alert(skuCode,1,obj);	
						$(obj).removeClass("loading").addClass("addtocart-on");
		     		});
		}
	}
}

/**
 * 更新某个购物车Item
 * @param cItemId
 *        购物车item的id，即shoppingcartItemId
 * @param skuCode
 *        更新的skuCode，假如产品没变，则为更新之前的那个sku
 * @param quantity
 *        数量
 *        
 */
ShoppingcartManager.updateCartItem=function(){
	$("#doAction").val("updateShoppingcartItem");
	ShoppingcartManager.submitCart();
}
/**
 * 从收藏夹移动到购物车
 * @param itemId 需要移动的item的id
 */
ShoppingcartManager.moveToC=function(itemId){
	$("#selected_itemId").val(itemId);
	$("#doAction").val("moveFavoriteItemToCart");
	ShoppingcartManager.submitCart();
}
/**
 * 从购物车移动到收藏夹
 * @param itemId 需要移动的item的id
 */

ShoppingcartManager.moveToF=function(itemId){
	$("#selected_itemId").val(itemId);
	$("#doAction").val("moveCartItemToFavorite");
	ShoppingcartManager.submitCart();
}
/**
 * 删除某个Item,不管是购物车还是收藏夹中的，只要提供该Item的id即可
 * @param itemId
 *        要删除的itemId
 */
ShoppingcartManager.deleteItem=function(itemId){
	$("#selected_itemId").val(itemId);
	$("#doAction").val("deleteItem");
	ShoppingcartManager.submitCart();
}
/**
 * 清空购物车
 */
ShoppingcartManager.clearC=function(){
	$("#doAction").val("clearShoppingcart");
	ShoppingcartManager.submitCart();
}
/**
 * 清空收藏夹
 */
ShoppingcartManager.clearF=function(){
	$("#doAction").val("clearFavorite");
	ShoppingcartManager.submitCart();
}

ShoppingcartManager.useCoupon=function(){
	if($("#couponNo_input_id").val()==""){
		//alert(__FMT.couponNull);
		return false;
	 }else{
		//$("#doAction").val("useCoupon");
		//ShoppingcartManager.submitCart();
		 var dis = parseFloat($("#cart_dis_member").val());
		 $.post(__ctxPath+"/cart/shoppingcart.html?doAction=useCoupon",{couponNo_input_name:$("#couponNo_input_id").val()},function(result){
			 	var cartDiscountAmount = 0;
				if(result.status==1){
					var money=result.data;
					$("#cartDiscountAmount").text((money + dis).toFixed(2));
					cartDiscountAmount = parseFloat($("#cartDiscountAmount").text());
		   			$("#giftCertificateNo").attr("disabled",true);
				}else{
					alert(result.msg);
					cartDiscountAmount = 0;
					$("#cartDiscountAmount").text(dis.toFixed(2));
					$("#giftCertificateNo").attr("disabled",false);
				}
				var cart_sum = parseFloat($("#cart_sum_prev").val());
				cartDiscountAmount = parseFloat($("#cartDiscountAmount").text());
	   			var giftPay = parseFloat($("#giftPay").text());
	   			var shopPointMoney = parseFloat($("#shopPointMoney").text());
	   			var total = parseFloat(cart_sum - cartDiscountAmount - giftPay - shopPointMoney).toFixed(2);
	   			$("#cart_sum").text(total < 0 ? '0.00' : total);
	   			if(total < 300){
	   				$("#selectbasic").attr("disabled",true);
	   			}else{
	   				$("#selectbasic").attr("disabled",false);
	   			}
			},"json");
	 }	
}
//撤销优惠券的使用
ShoppingcartManager.notUseCoupon=function(){
	$("#doAction").val("notuseCoupon");
	ShoppingcartManager.submitCart();
}

/**
 * 弹出提示框。
 * TO DEVELOPER:
 * 此方法一般不对外公开使用
 */
ShoppingcartManager.alert=function(skucode,type,$obj,addToCartResult){
    if(addToCartResult.result==0){
    	alert(addToCartResult.message);
    	return;
    }
    var popuw = function(skucode,type){
    	this.skucode = skucode;
    	this.type = type;
    	this.$obj = $obj;
    }
    popuw.prototype={
    	id:'shoppingcartAlertWId_',
    	skucode:'',
    	type:1,//购物车,0,收藏夹
    	messageDlgZIndex:1000,
    	$obj:"",
		html:format_params($("#shoppingCartTemplate").val(),addToCartResult.lastAddToCartItemQty,addToCartResult.lastAddToCartItemImage,addToCartResult.lastAddToCartItemName,__defaultCurrencySymbol+addToCartResult.lastAddToCartItemPrice,addToCartResult.lastAddToCartItemQty,addToCartResult.cartItemQty,__defaultCurrencySymbol+addToCartResult.total),
		show:function(){
			  if(this.type==1){
			  	
			  }else{
			  	 this.html = this.html.replace("?Icount?",getCookie(__FMT.f_itemcount_cookie));
			  	 this.html = this.html.replace("?type?",__FMT.favorite_);
			  }
			  var cartDlg=fnCreateSimpleDialog(this.id,'','',{});
			  $("#_dlgContBox"+this.id).html(this.html);
			  cartDlg.showDialog();
			  if($mnc)
			  	$mnc.refresh();//refresh the minicart
			
		}
    }
	var win = new popuw(skucode,type);
	win.show();
}

/**
 * minicart管理类
 */
ShoppingcartManager.minicart=function(){
	
}
ShoppingcartManager.minicart.prototype={
	div:"minicartDiv",
	refresh:function(){
		if($("#"+this.div)){
			var itemcount = getCookie(__FMT.c_itemcount_cookie);
			itemcount = itemcount==null?'0':itemcount;
			var subtotal = getCookie(__FMT.minicart_totalprice_cookie);
			subtotal = subtotal==null?fnFormatPrice(0):fnFormatPrice(subtotal);
			$("#"+this.div).html(format_params($("#minicartDivTemplate").html(),itemcount,subtotal));
		}
	}
}
var $mnc = new ShoppingcartManager.minicart();

addOnload(function(){
$cm.isBusy = false;
});
$cm = ShoppingcartManager;
//$cm.isBusy = true;
function moveCartBtn(b){
	if(!($(b).hasClass("loading")||$(b).hasClass("stock")||$(b).hasClass("no-addtocart"))){
		if ($(b).hasClass("addtocart-on")){$(b).removeClass("addtocart-on");}else {$(b).addClass("addtocart-on");}
	}
}

function addToFavorite(productId){
	doRequiredLoginAction(function(){
		$.post(__ctxPath+"/ajaxFavorite.html?doAction=addFavorite&productId="+productId,function(result){
			var count = 0;
			count = result.data == 0 ? "1" : result.data;
			$("#love_count").html("<span>" + count + "</span>" + "个人喜欢");
			var popuw = function(){}
		    popuw.prototype={
		    	id:'favoriteAlertWId_'+productId,
		    	messageDlgZIndex:1000,
				html:format_params($("#favoriteTemplate").html(),result.msg),
				show:function(){
					  var favoriteDlg=fnCreateSimpleDialog(this.id,'','',{});
					  $("#_dlgContBox"+this.id).html(this.html);
					  favoriteDlg.showDialog();
				}
		    }
			var win = new popuw();
			win.show();
		});
	});
}