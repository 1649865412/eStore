<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>
<%@page import="com.cartmatic.estore.common.model.catalog.ProductReview"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.cartmatic.estore.common.model.catalog.ProductDescription"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<%@ taglib prefix="sales" tagdir="/WEB-INF/tags/sales"%>
<%@ taglib prefix="system" tagdir="/WEB-INF/tags/system"%>
<%@ taglib prefix="cartmatic" tagdir="/WEB-INF/tags/cartmatic"%>
<%@ taglib prefix="content" tagdir="/WEB-INF/tags/content"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags/app"%>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>四方街</title>
		<!-- Bootstrap -->
		<%@ include file="../../decorators/include/javascripts.jspf"%>
		<%@ include file="../../decorators/include/styles7.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/global_brain.js"></script>
        <link href="${ctxPath}/scripts/jquery/js/colorbox/colorbox.css" rel="stylesheet" />
        
        <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
        <link href="${resPath}/styles/css/mall_nav.css" rel="stylesheet">
        <link href="${resPath}/styles/css/weekly.css" rel="stylesheet">
        <link href="${resPath}/styles/css/shooping-list.css" rel="stylesheet">
        <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/cart/login.js"></script>
	</head>

	<body>
		<!--登陆注册-->
		<%@ include file="../../decorators/include/headerMarket.jspf"%>
        <!--end of 导航-->
        <!--主体内容开始-->

		<div class="w-weekly">
        	<div class="w-weekly-hd">
            	<content:showAdNew adPositionType="weeklyTitle" />
            </div>
            <div class="w-weekly-recomm">
            	<div class="bd-tit">“魅力万圣嘉年华搭配”</div>
                <div class="bd-tit1">Holloween Week四方街主推以下两个搭配，帅气骑士装and优雅魅力装令你在万圣节大放异彩！</div>
                <ul class="row">
                	<jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
							<jsp:param name="typeName" value="hot_sell" />
							<jsp:param name="firstResult" value="0" />
							<jsp:param name="maxResults" value="6" />
							<jsp:param name="template" value="sales/include/recommendProduct4MainPage13" />
							<jsp:param name="doAction" value="defaultAction" />
							<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
					</jsp:include>
                </ul>
            </div>
            
            
            <!-----购买弹窗----->
            <div style="display:none">
                    <div id="cart_box" class="after_addtocart">
                        <div class="w-cart-header">
                            <span><i class="fa fa-check-circle-o"></i>该产品已经成功加入您的购物车</span>
                            <hr class="aftercart_hr"/>
                        </div><!--w-cart-header-->
                        <div class="w-cart-body">
                            <div class="addcart_top">
                                    	<jsp:include flush="true" page="/sales/recommendedProduct.html">
								             <jsp:param name="typeName" value="also_buy" />
								             <jsp:param name="firstResult" value="0" />
								             <jsp:param name="maxResults" value="7" />
								             <jsp:param name="template" value="sales/include/recommendProductContentNew2"/>
								             <jsp:param name="doAction" value="defaultAction" />
								             <jsp:param name="sourceId" value="${product.productId}" />
								         </jsp:include>
                            </div><!--addcart_top-->
                        </div><!--w-cart-body-->
                    </div><!--cart_box-->
                </div>
            <!-----购买弹窗end----->
            
            <div class="w-weekly-bd">
            	<div class="bd-tit">“万圣时尚单品”</div>
                <div class="bd-tit1">Holloween Week还有以下各类精美单鞋和配饰等着你来淘！</div>
		                    <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
									<jsp:param name="typeName" value="new_arrival" />
									<jsp:param name="firstResult" value="0" />
									<jsp:param name="maxResults" value="100" />
									<jsp:param name="template" value="sales/include/recommendProduct4MainPage10" />
									<jsp:param name="doAction" value="defaultAction" />
									<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
							</jsp:include>
            </div>
        </div>
        
		 <!--主体内容结束-->
		<%@ include file="../../decorators/include/footerNew.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/pinterest.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/index.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/slider.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/colorbox/jquery.colorbox-min.js"></script>
	    <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
	    <script type="text/javascript" defer>

var skuWholesalePrices = new Array();
<c:if test="${product.status==1}">
<%--产品价格包括批发价--%>
skuWholesalePrices[0]=[1,"${defaultProductSkuPrice}"];
<c:forEach items="${skuWholesalePrices}" var="wholesalePrice" varStatus="varStatus">
	skuWholesalePrices[${varStatus.count}]=["${wholesalePrice.minQuantity}","${wholesalePrice.price}"];
</c:forEach>
<c:if test="${product.productKind==2}">
var jProduct=${jsonProduct};
$("#skuOptions").children("div.tb-prop").find("li[data-value]").click(function(){
	if($(this).hasClass("tb-out-of-stock")){return false;};
	if($(this).toggleClass("tb-selected").hasClass("tb-selected")){
		$(this).append("<i>selected</i>").siblings("li").removeClass("tb-selected").children("i").remove();
	}else{
		$(this).children("i").remove();
	}
	var selectedOptions=$("#skuOptions").children("div.tb-prop").find("li.tb-selected[data-value]");
	var selectOptions=$("#skuOptions").children("div.tb-prop").find("li[data-value]").not(".tb-selected");
	
	var aOptionValueIds=",";
	var skus=jProduct.productSkus;
	
	for(var i=0;i<selectOptions.length;i++){
		var selectOption=$(selectOptions[i]);
		var optionId=selectOption.attr("data-value").split(":")[0];
		var optionValueId=selectOption.attr("data-value").split(":")[1];
		var hasMatchSku=false;
		var sku=null;
		for (k in skus){
			sku=skus[k];
			var skuOptions=sku.skuOptions;
			var hasOptionValue=false;
			for(j in skuOptions){
				var skuOption=skuOptions[j];
				if(selectOption.attr("data-value")==(skuOption.id+":"+skuOption.vid)){
					hasOptionValue=true;
					break;
				}
			}
			if(hasOptionValue){
				hasMatchSku=true;
			}else{
				continue;
			}
			for(var j=0;j<selectedOptions.length;j++){
				var selectedOption=$(selectedOptions[j]);
				var selectedOptionId=selectedOption.attr("data-value").split(":")[0];
				if(optionId!=selectedOptionId){
					hasOptionValue=false;
					for(l in skuOptions){
						var skuOption=skuOptions[l];
						if(selectedOption.attr("data-value")==(skuOption.id+":"+skuOption.vid)){
							hasOptionValue=true;
							break;
						}
					}
					if(!hasOptionValue){
						hasMatchSku=false;
						break;
					}
				}
			}
			if(hasMatchSku){
				break;
			}
		}
		if(hasMatchSku){
			if(aOptionValueIds.indexOf(","+optionValueId+",")==-1){
				aOptionValueIds+=optionValueId+",";
			}
		}
	}
		
	for(var i=0;i<selectOptions.length;i++){
		var option=$(selectOptions.get(i));
		var optionV=option.attr("data-value").split(":");
		if(aOptionValueIds.indexOf(","+optionV[1]+",")==-1){
			option.addClass("tb-out-of-stock");
		}else{
			option.removeClass("tb-out-of-stock");
		}
	}
		
	var selectedSku=null;
	for (i in skus){
		var sku=skus[i];
		var skuOptions=sku.skuOptions;
		var isMatch=false;
		for(j in skuOptions){
			isMatch=false;
			var skuOption=skuOptions[j];
			for(var k=0;k<selectedOptions.length;k++){
				if($(selectedOptions[k]).attr("data-value")==(skuOption.id+":"+skuOption.vid)){
					isMatch=true;
					break;
				}
			}
			if(!isMatch){
				break;
			}
		}
		if(isMatch){
			selectedSku=sku;
			break;
		}
	}
	var add2CartBtn=$("#add2Cart"+${product.id});
	if(selectedSku){
		//更新图片
		$("#productImgA").find("img").attr("src",__mediaPath+"product/d/"+selectedSku.image);
		//价格
		var skuPrice=selectedSku.salePrice!=null?selectedSku.salePrice:selectedSku.discountPrice!=null?selectedSku.discountPrice:selectedSku.price;
		$("#priceSpan").attr("data-value",skuPrice).html(fnFormatPrice(skuPrice));
		$("#priceSpan").next("span[name='otherCurrency']").attr("defaultvalue",skuPrice);
		if(selectedSku.priceViewType==2||selectedSku.priceViewType==3){
			$("#listPriceSpan").html('<del>'+fnFormatPrice(selectedSku.price)+'</del>').show();
			$("#discountPercent").html("("+selectedSku.discountPercent+"% OFF)");
		}else{
			$("#listPriceSpan,#discountCount").hide();
		}
		$("#productSkuCodeSpan").html(selectedSku.productSkuCode);
		$("#productSkuCode").val(selectedSku.productSkuCode);
		$("#productSkuId").val(selectedSku.productSkuId);
		$("#productWeightSpan").attr("data-value",selectedSku.weight+"").html(selectedSku.weight);
		if(!selectedSku.inventory){
			$("#productStockSpan").html("有现货");
			add2CartBtn.removeClass("stock").removeClass("no-addtocart").removeAttr("disabled").attr("title",__FMT.minicart_addToCart).val(__FMT.minicart_addToCart);
		}else if(selectedSku.inventory.availableQuantity>0){
			$("#productStockSpan").html(selectedSku.inventory.availableQuantity+" 件");
			add2CartBtn.removeClass("stock").removeClass("no-addtocart").removeAttr("disabled").attr("title",__FMT.minicart_addToCart).val(__FMT.minicart_addToCart);
		}else{
			$("#productStockSpan").html(__FMT.outOfStock);
			add2CartBtn.addClass("stock").attr("disabled","disabled").attr("title",__FMT.outOfStock).val(__FMT.outOfStock);
		}
		
		$("#skuWholesalePriceTbl").find("tr").slice(1).remove();
		skuWholesalePrices=selectedSku.wholesalePrices.slice(0,selectedSku.wholesalePrices.length);
		skuWholesalePrices.unshift([1,skuPrice]);
		$("#skuWholesalePriceTbl").append('<tr><td>1-1</td><td>'+fnFormatPrice(skuPrice)+'<span defaultvalue="'+skuPrice+'" name="otherCurrency"></span></td></tr>');
		for(var i=1;i<skuWholesalePrices.length;i++){
			var ws_qty=skuWholesalePrices[i][0]+"+";
			if(i<skuWholesalePrices.length-1){
				ws_qty=skuWholesalePrices[i][0]+"-"+(skuWholesalePrices[i+1][0]-1);
			}
			$("#skuWholesalePriceTbl").append('<tr><td>'+ws_qty+'</td><td>'+fnFormatPrice(skuWholesalePrices[i][1])+'<span defaultvalue="'+skuWholesalePrices[i][1]+'" name="otherCurrency"></span></td></tr>');
		}
		fnChangePrice();
	}else{
		add2CartBtn.removeClass("stock").addClass("no-addtocart").removeAttr("disabled").val(__FMT.minicart_addToCart);
	}
	
	var skuOptions=$("#skuOptions").children("div.tb-prop").find("li.tb-selected");
	var name="";
	skuOptions.each(function(i){
		if($(this).find("span").length!=0){
			name+=$(this).find("span").text();
		}
	});
	var msg="";
	if(name!=""){
		msg="已选："+name;
		if(selectedSku&&((!selectedSku.inventory)||selectedSku.inventory.availableQuantity>0)){
			msg+='&nbsp;&nbsp;<span class="mark_co">现在有货</span>';
		}
	}
	$("#selectedProdMsg").html(msg);
	return false;
});

function checkAddProductToCart(){
	var skuOptions=$("#skuOptions").children("div.tb-prop").find("ul[data-property]");
	var name="";
	skuOptions.each(function(i){
		if($(this).find("li.tb-selected").length==0){
			name+="."+$(this).attr("data-property");
		}
	});
	if(name!=""){
		alert("请选择 "+name);
	}
	return name=="";
}
</c:if>
</c:if>

//图片lightbox,稳定好移到js
function showLightbox(){
	var lightbox=$("#lightbox");
	var left=Math.round((($(document).width()||$(window).width())-lightbox.width())/2);
	var top=Math.round($("html").scrollTop()+($(window).height()-lightbox.height())/2);
	if(top<0)top=0;
	$("#lightboxOverlay").show();
	lightbox.css({ top: top, left: left }).show();
}

$("#lb-close,#lightboxOverlay").click(function(){
	$("#lightbox").hide();
	$("#lightboxOverlay").hide();
});
$("#lb-thumbnailContent").children().click(function(){
	$(this).addClass("selected").siblings().removeClass("selected");
	$("#lb-image").attr("src",__resPath+"/images/img/empty.gif");
	$("#lb-image").attr("src",__resPath+"/images/img/empty.gif").attr("src",$(this).children("img").attr("src").replace("/a/","/v/"));
});
$("#lb-previous").click(function(){
	$("#lb-thumbnailContent").children(".selected").prev().click();
});
$("#lb-next").click(function(){
	$("#lb-thumbnailContent").children(".selected").next().click();
});
$("a[target='popup_larger_image']").click(function(){
	var thumbImgUrl=$("#imgContent").children(".selected").children("img").attr("src");
	$("#lb-thumbnailContent").find("img[src='"+thumbImgUrl+"']").parent().click();
	showLightbox();
	return false;
});
</script>
        <script type="text/javascript">
            $(function () {
                $(".j3").colorbox({ inline: true, width: "50%" });
            })
        </script>
         <script type="text/javascript" >
          var jiathis_config={
              summary:"",
              shortUrl:true,
              hideMore:false
          }
          </script>
          <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
		
       
	</body>

</html>