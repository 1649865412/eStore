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
		
		<script type="text/javascript"
			src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
		<script type="text/javascript"
			src="${ctxPath}/scripts/cartmatic/cart/cart.js"></script>
		<script type="text/javascript"
			src="${ctxPath}/scripts/jquery/plugins/validation/jquery.validate.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/modernizr.custom.js"></script>
		<script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>

		<!-- Bootstrap -->
		<%@ include file="../decorators/include/javascripts.jspf"%>
		<script src="${ctxPath}/scripts/jquery/js/global_brain.js"></script>
	    <script src="${ctxPath}/scripts/jquery/js/css_browser_selector.js"></script>
	    <link href="${ctxPath}/scripts/jquery/js/colorbox/colorbox.css" rel="stylesheet" />
	    <%@ include file="../decorators/include/styles7.jspf"%>
	    <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
	    <link href="${resPath}/styles/css/mall_nav.css" rel="stylesheet">

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
	<%@ include file="../decorators/include/headerMarket.jspf"%>
		<div class="index_show c">
        	<div class="index_left">
                <div class="swiper-wrapper">
					<%--首页轮播图，目前数量为5，如需改动数量可在此修改 --%>
					<content:showAdNew adPositionType="mainadNewMarket1" />

					<content:showAdNew adPositionType="mainadNewMarket2" />
					
					<content:showAdNew adPositionType="mainadNewMarket4" />
					
					<content:showAdNew adPositionType="mainadNewMarket5" />
					
					<content:showAdNew adPositionType="mainadNewMarket6" />

				</div>
                <div class="pagination"></div>
            </div><!--index_left end--> 
            	<content:showAdNew adPositionType="mainadNewMarket3" />
        </div><!--index_show end-->
        <content:showAdNew adPositionType="mainadNewMarketLeft" />
        <%--<div class="mall c" style="background:url(../resources/styles/img/authors/3.jpg) no-repeat">
        <c:if test="${not empty brand}">
        	<div class="mall_left" style="background-image:url(../resources/styles/img/authors/3.jpg);">
            	<div class="mrzt">
                	<i></i>
                	<div class="title-font">每周主打<br/>初夏清新穿搭</div>
                </div>
            	<div class="mall_con">
                	<div class="designer">
                    	<a class="designer_left" href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}"><cartmatic:img isUrlOnly="false" url="${brand.icon}" mediaType="other" width="270" height="270" ></cartmatic:img></a>
                        <a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}">
                        <div class="designer_right">
                        	<div class="li1 title-font">每周主打品牌设计师</div>
                            <div class="li2">${brand.designer}</div>
                            <div class="li3">${brand.brandName}</div>
                        </div>
                        </a>
                    </div>
                    <a href="${ctxPath}/Designer_Service/designer_datial.html?brandId=${brand.brandId}">
                    	<div class="designer_info"><c:out value="${fn:substring(brand.story, 0, 230)}......" /></div>
                    </a>
                    <div class="carefully_title title-font">每周主打品牌产品精选</div>
                    <ul class="carefully_list list-unstyled c">
                    	
                    	<jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
							<jsp:param name="typeName" value="feature_product" />
							<jsp:param name="firstResult" value="0" />
							<jsp:param name="maxResults" value="6" />
							<jsp:param name="template" value="sales/include/recommendProduct4MainPage6" />
							<jsp:param name="doAction" value="defaultAction" />
							<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
						</jsp:include>
                    	
                    </ul>
                    <div class="carefully_more list-unstyled c">
	                    <a class="li3" href="${ctxPath}/weekly.html">点击查看更多每周主打产品 >></a>
	                </div>
                </div>
            </div>
            </c:if>
            <ul class="mall_right list-unstyled">
            
            	<jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
							<jsp:param name="typeName" value="feature_product" />
							<jsp:param name="firstResult" value="0" />
							<jsp:param name="maxResults" value="6" />
							<jsp:param name="template" value="sales/include/recommendProduct4MainPage7" />
							<jsp:param name="doAction" value="defaultAction" />
							<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
				</jsp:include>
            	
            </ul>
        </div>
        --%><div class="update_new">
        <div class="news_date">
        	<h3 class="li1"><a href="#" class="title-font">${tempCatalog.weekOnNewTitle}</a></h3>
            <p class="li2">${tempCatalog.weekOnNewContent}</p>
            <c:if test="${tempCatalog.weekOnNewUrl == null || tempCatalog.weekOnNewUrl == ''}">
            	<a class="li3" href="${ctxPath}/index.html">查看更多</a>
            </c:if>
            <c:if test="${tempCatalog.weekOnNewUrl != null && tempCatalog.weekOnNewUrl != ''}">
				<a class="li3" href="${tempCatalog.weekOnNewUrl}">查看更多</a>
			</c:if>
        </div>
	        <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
								<jsp:param name="typeName" value="best_wholesale_deals" />
								<jsp:param name="firstResult" value="0" />
								<jsp:param name="maxResults" value="12" />
								<jsp:param name="template" value="sales/include/recommendProduct4MainPage9" />
								<jsp:param name="doAction" value="defaultAction" />
								<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
			</jsp:include>
        </div>
        <div class="news_date">
        	<h3 class="li1 title-font">${tempCatalog.discountAreaTitle}</h3>
            <p class="li2">${tempCatalog.discountAreaContent}</p>
        </div>
        <div class="product_box">
            <ul class="product list-unstyled col4 c sku_list" id="pinterestList">
            
            <jsp:include flush="true" page="${ctxPath}/sales/recommendedProduct.html">
							<jsp:param name="typeName" value="hot_wholesale_products" />
							<jsp:param name="firstResult" value="0" />
							<jsp:param name="maxResults" value="8" />
							<jsp:param name="template" value="sales/include/recommendProduct4MainPage8" />
							<jsp:param name="doAction" value="defaultAction" />
							<jsp:param name="sourceId" value="${appConfig.store.catalog.categoryId}" />
			</jsp:include>
            
            </ul>
        </div>
        <!-- 加入购物车成功 -->
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
	     <!-- End 加入购物车成功 -->
		<%@ include file="../decorators/include/footerNew.jspf"%>
		
		<script type="text/javascript">
		  
		  function addToFavorite(productId){
      		    if(isLogined()){
      		  	$.post("/ajaxFavorite.html?doAction=addFavorite", {
          		  	productId : productId
        		  	}, function(result) {
        		  		    alert(result.msg);
        		  		}, "json");
          		    }else{
	              		 alert("此操作需要登陆");
	          		  	$(".w-login").show();
						$(".w-login-left").show();
						$(".w-login-right").hide();
              		    }
			}
         </script>
		<script src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/bootstrap.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.min.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/swiper.animate.min.js"></script>
        <script src="${ctxPath}/scripts/jquery/js/pinterest.js"></script>
		<script src="${ctxPath}/scripts/jquery/js/index.js"></script>
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

<%--购物车弹出层 begin --%>
<textarea id="shoppingCartTemplate" style="display: none;">
	<h2>
		已将{0}件商品加入购物车！
	</h2>
	<div class="left">
		<div class="wrap-line">
			<div class="photo">
				<img src="${appConfig.store.mediaUrlPath}/product/e/{1}" width="165" height="165" alt="" onerror="$(this).attr('originsrc',this.src).attr('src',__defaultImage).removeAttr('onerror');" originsrc=""/>
			</div>
			<div class="txt">
				{2}
				<div class="blank10"></div>
				<strong class="red f13px">{3}</strong>
				<br>
					<strong class="f13px">数量:{4}</strong>
			</div>
		</div>
	</div>
	<div class="right">
		{5}件商品在您的购物车内
		<br>
		<strong class="f18px">小计: <span class="red">{6}</span>
		</strong>
		<div class="blank10"></div>
		<div class="out">
			<button class="toggle1 checkout" title="CheckOut" type="button"
				value="CheckOut"
				onclick="window.location.href='/cart/shoppingcart.html'">
				去结算
			</button>
		</div>
		<div class="shop">
			<a onclick="closeSimpleDialog('shoppingcartAlertWId_');return false;" href="#">继续购物</a>
		</div>
	</div>
</textarea>
<%--购物车弹出层 end --%>
<%--收藏夹弹出层 begin --%>
<div id="favoriteTemplate" style="display: none;">
	<h2>
		{0}
	</h2>
	<a href="/myaccount/favorites.html">您可以 查看收藏夹</a>
</div>
<%--收藏夹弹出层 end --%>
<%--收藏夹弹出层 begin --%>
<div id="favoriteTemplate" style="display: none;">
	<h2>
		{0}
	</h2>
	<a href="/myaccount/favorites.html">您可以 查看收藏夹</a>
</div>
<%--收藏夹弹出层 end --%>
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