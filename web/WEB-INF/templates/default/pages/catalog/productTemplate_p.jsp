<%@ page pageEncoding="utf-8" %>
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

<c:if test="${product.status != 1}">
	<%response.setStatus(response.SC_GONE);%>
</c:if> 

<html>
<head>
<c:set var="productPrice"><system:CurrencyForRate value="${product.defaultProductSku.price}" /></c:set>
<c:set value="${empty product.title?product.productName:product.title}" var="pageTitle"></c:set>
<TITLE>${pageTitle}</TITLE>
<meta name="keywords" content="<c:out value="${product.metaKeyword}"/>" />
<meta name="description" content="<c:out value="${empty product.metaDescription ? product.productName : product.metaDescription}"/>" />
</head>
<body>
<content tag="heading"> <product:navigatorBar navigatorCategorys="${navigatorCategorys}" pageType="2"/></content>
<div class="hot-sell">
<div class="hproduct">
	<div class="brand-design">
    	<div class="left"><cartmatic:img url="${product.brand.icon}" mediaType="other" width="100" height="100"></cartmatic:img></div>
        <div class="left" style="padding:50px 0 0 10px;"><span style="font-size:18px; color:#5e5e5e;">${product.brand.brandName}</span><div class="blank10"></div><strong style="font-size:14px;">品牌故事</strong></div>
        <div class="blank10"></div>
        <h1 class="fn">${product.productName}</h1>
        <%-- ===================== 产品编号 =====================--%>
        <div class="identifier left">
            <span class="type">产品编号</span>:
            <span class="value" id="productSkuCodeSpan">${product.defaultProductSku.productSkuCode}</span>
        </div>
        <div class="blank6"></div>
        <div class="design-bg">
            <strong>产品亮点</strong><br/>
            <p>${product.productDescription.shortDescription}</p>
        </div>
        <div class="blank24"></div><div class="blank24"></div>
        <div>
            <product:productStat var="productStat" productId="${product.id}"></product:productStat>
        	<div class="left" style="margin:3px 4px 0 0;"><img src="${resPath}/images/icon/icon1.jpg" /></div>
            <div class="left">${productStat.favoriteCount}人喜欢</div>
            <div class="left" style="margin:3px 4px 0 20px;"><img src="${resPath}/images/icon/icon2.jpg" /></div>
            <div class="left">发送给好友</div>
        </div>
        <div class="blank10"></div>
        <div>
      
    </div>
   </div>
    <%-- ========= 产品图开始 ==========--%>
	<div class="big-photo">
		<%--product_image用于设置浏览回顾的产品图片--%>
		<input type="hidden" id="product_image" value="<product:productImg product="${product}" size="b" isUrlOnly="true"/>"/>
		<%-- <input type="hidden" id="productImage_original" value="<product:productImg product="${product}" size="v" isUrlOnly="true"/>"/>--%>
		<a id="productImgA" rel="nofollow" href="#" target="popup_larger_image">
			<img alt="${product.productName}" src="<product:productImg product="${product}" size="d" isUrlOnly="true"/>" width="400" height="400" id="productImg" class="photo">
		</a>
		<div class="blank10"></div>
		<div class="small-photo" id="imgContent">
			<c:forEach items="${productMoreImages}" var="productMoreImage">
				<a href="javascript:void(0);" onClick="$('#productImgA').click();" onmouseover="fnChangeProdImg($(this),$(this).children('img'),'a','d');" ><cartmatic:img url="${productMoreImage.mediaUrl}" mediaType="productMedia" size="a" alt="" width="46" height="46"/></a>
			</c:forEach>
		</div>
		<input type="hidden" value="0" id="productImgIndex">
        <div class="clear"></div>
	</div>
	<%-- ========= 产品图结束 ==========--%>
	<%-- ========= 产品内容详细开始 ==========--%>
	<div class="detail-right">
        <div class="content">
                <%@ include file="./include/productTemplate_priceArea.jspf"%>
                <%-- ===================== 顾客投票 =====================--%>
                <div class="reviewaggregate hreview-aggregate">
                    <product:productStat var="productStat" productId="${product.id}"></product:productStat>
                    <div class="left">评级:</div>
                    <div class="left" style="padding-top:6px;"><product:ratingStar value="${productStat.averageRate}" /></div><span class="rating">${productStat.averageRate}</span><span style="display:block; height:20px; line-height:20px; float:left;padding-top:6px;">(${productStat.reviewCount})</span>
                </div>
                <div class="clear"></div>
                <attribute:attributeValue attributeCode="fahuoshijian" attributeValueVar="fahuoshijian" entity="${product}"/>
				<div>发货时间:${fahuoshijian.attributeValue}</div>				
                <div class="clear"></div>
         		<div class="design-bg">
                	<div id="skuOptions">
	                
	                 <c:forEach items="${productSkuOptionAndValues}" var="productSkuOptionAndValue">
	                 	<dl class="tb-prop tm-clear">
							<dt class="tb-metatit">${productSkuOptionAndValue.key.skuOptionName} :</dt>
							<dd>
								<c:choose>
									<c:when test="${productSkuOptionAndValue.key.skuOptionCode=='color'}">
										<%--图片 --%>
										<ul class="tm-clear J_TSaleProp tb-img" data-property="${productSkuOptionAndValue.key.skuOptionName}">
											<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue">
												<li data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}">
													<a style="background: url(<product:productImg sku="${skuOptionValue.sku}" size="a" isUrlOnly="true"/>) center no-repeat;" href="#">
														<span>${skuOptionValue.skuOptionValueName}</span>
													</a>
												</li>
					                        </c:forEach>
										</ul>
									</c:when>
                                    
									<c:otherwise>
										<%--文本 --%>
                                        <ul class="tm-clear J_TSaleProp" data-property="${productSkuOptionAndValue.key.skuOptionName}">
											<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue">
												<li data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}"><a href="#"><span>${skuOptionValue.skuOptionValueName}</span></a></li>
					                        </c:forEach>
										</ul>
									</c:otherwise>
								</c:choose>
							</dd>
						</dl>
                        <div class="clear"></div>
	                 </c:forEach>
            	</div>
                <div class="clear"></div>
                <input type="hidden" id="productId" value="${product.productId}" />
                <input type="hidden" id="productCode" value="${product.productCode}" />
                <input type="hidden" id="productName" value="${product.productName}" />
                <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
                <input type="hidden" id="accessoriesSkuCodes" value="" />
                <input type="hidden" id="categoryId" value="${category.categoryId}" />
                <input type="hidden" id="product_simpleName" value="<app:interceptString str="${product.productName}" length="50"></app:interceptString>" />
                <input type="hidden" id="productLinkUrl" value="${uri}" />
                <input type="hidden" id="listPrice" value="${product.defaultProductSku.listPrice}" />
                <div class="clear"></div>
                <div class="left" style="margin:8px 10px 0 0;">
                    <c:forEach items="${productAccessoryList}" var="accessoryEntry" varStatus="varStatus">
                    <span class="fB">${accessoryEntry.key.groupName}:</span>
                    <select name="accessory" class="box-input" accessoryName="${accessoryEntry.key.groupName}">
                        <option value="0" price="0">Please Select</option>
                        <c:forEach items="${accessoryEntry.value}" var="accessory">
                            <option value="${accessory.accessoryId}" price="${empty accessory.price?0:accessory.price}">${accessory.accessoryName}<c:if test="${accessory.price>0}">(<system:CurrencyForRate value="${accessory.price}" />)</c:if></option>
                        </c:forEach>
                    </select>
                    <div class="blank10"></div>
                    </c:forEach>
                    <input id="selectAccessorys" type="hidden"/>
                    <div style="margin-bottom:10px;"><a href="${resPath}/images/layout/sizechart.jpg" target="_blank"><img src="${resPath}/images/layout/sizechart_table.jpg"/ ></a></div>
                    <strong>数量</strong> :<span id="quantitySelect"><product:productQuantity2 product="${product}" /></span>
                    <input id="quantity" name="quantity" type="text" class="box-input" value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3">
                    <div class="blank10"></div>
                </div>
             </div>
             <div class="left" style="margin:20px 0 0 6px;">
             	<div id="selectedProdMsg">&nbsp;&nbsp;<span class="red">现在有货</span></div>
                <div class="blank10"></div>
                <div class="btn-layer">
                <product:addToCart productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />&nbsp;&nbsp;
                <input type="image" border="0" align="absmiddle" onclick="addToFavorite(${product.id});return false;" systran="yes" alt="加入收藏夹" src="${resPath}/images/btn/btn_fav.jpg" >
                </div>
                <div class="blank6"></div>
                   	支付:在线付款 对公转帐
            </div>
        <div class="clear"></div>
        <%-- ===================== promotion start =====================--%>
        <jsp:include flush="true" page="/sales/productPromotionList.html">
            <jsp:param name="productId" value="${product.productId}" />
        </jsp:include>
        <%-- ===================== promotion end =====================--%>
		</div>
		<div class="blank24"></div>
       
	</div>
	<div class="blank24"></div>
	<%-- ========= 产品内容详细结束 ==========--%>
</div>
</div>
<div class="blank24"></div>
<a name="review"></a>
<div class="hot-sell">
	<ul class="tab cart_tabs">
    	<li name="productImages" class="selected"><a href="javascript:void(0)">产品写真</a></li>
        <li name="productDescription"><a href="javascript:void(0)">产品详情</a></li>
        <li name="productReviews"><a href="javascript:void(0)">商品评论</a></li>
    </ul>
    <div class="blank24"></div>
    <div>
    <div id="productImages" class="description" style="text-align:center;">
    	${product.productDescription.imageDescription}
        <%-- ===================== 产品写真  =====================--%>
        <c:forEach items="${productMoreImages}" var="productMoreImage">
            <p><cartmatic:img url="${productMoreImage.mediaUrl}" mediaType="productMedia" size="v" alt=""/></p>
        </c:forEach>
    </div>
    <div id="productDescription" class="description" style="display:none;">
		<ul>
			<li>商品名称：${product.productName }</li>
			<li>商品编码：${product.productCode }</li>
			<li>设计师：${product.brand.brandName }</li>
			<li>上架时间：<fmt:formatDate value="${product.publishTime}" pattern="yyyy-MM-dd"/></li>
			<c:if test="${not empty product.defaultProductSku.weight}">
				<li>商品毛重：${product.defaultProductSku.weight}${appConfig.weightUnit }</li>
			</c:if>
			<c:forEach items="${productAttGroups}" var="productAttGroup">
				<c:forEach items="${productAttGroup.productAttrValues}" var="productAttrValue">
					<c:if test="${not empty productAttrValue.attributeValue}">
						<li>${productAttrValue.attribute.attributeName}：
							<c:choose>
								<c:when test="${productAttrValue.attributeDataType==1}">
									${fn:replace(productAttrValue.attributeValue,",","，")}
								</c:when>
								<c:otherwise>${productAttrValue.attributeValue}</c:otherwise>
							</c:choose>
						</li>
					</c:if>
				</c:forEach>
			</c:forEach>
		</ul>    
    	<%-- ===================== 产品详情  =====================--%>
        <product:htmlConverter content="${product.productDescription.fullDescription}"></product:htmlConverter>
    </div>
    <div id="productReviews" class="description" style="display:none">
    	<%-- ===================== 商品评论  =====================--%>
        <div class="review-content">
            <jsp:include flush="true" page="/review/product/${product.productId}.html">
                <jsp:param name="PrmItemsPerPage" value="10" />
            </jsp:include>
            <div class="blank24"></div>
        </div>
    </div>
    </div>
	<script type="text/javascript">
		$(function(){
			$(".cart_tabs").children().mousemove(function(){
				var tabContent=$("#"+$(this).attr("name"));
				if(tabContent){
					$(this).addClass("selected").siblings().removeClass("selected");
					tabContent.show().siblings().hide();
				}
			});
		});
	</script>
</div>
<div class="blank24"></div>
<a name="productRecommend"></a>
<div class="tab-line">
    <ul class="tab3 cart_tabs">
        <li name="productRecommend1"><a href="javascript:void(0)">该设计师其他产品</a></li>
        <li name="productRecommend2" class="selected"><a href="javascript:void(0)">本类型热销产品</a></li>
    </ul>
</div>
<%-- ===================== 相关推荐  =====================--%>
<div id="shoe">
    <div class="hot-sell" id="productRecommend1">
       <jsp:include flush="true" page="/sales/recommendedProduct.html">
             <jsp:param name="typeName" value="same_brand" />
             <jsp:param name="firstResult" value="0" />
             <jsp:param name="maxResults" value="5" />
             <jsp:param name="template" value="sales/include/recommendProductContent" />
             <jsp:param name="doAction" value="defaultAction" />
             <jsp:param name="sourceId" value="${product.productId}" />
         </jsp:include>
    </div>
    <div class="hot-sell" id="productRecommend2" style="display:none;">
       <jsp:include flush="true" page="/sales/recommendedProduct.html">
             <jsp:param name="typeName" value="hot_sell" />
             <jsp:param name="firstResult" value="0" />
             <jsp:param name="maxResults" value="5" />
             <jsp:param name="template" value="sales/include/recommendProductContent" />
             <jsp:param name="doAction" value="defaultAction" />
             <jsp:param name="sourceId" value="${category.categoryId}" />
         </jsp:include>
    </div>
</div>
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
$("#skuOptions").children("dl.tb-prop").find("li[data-value]").click(function(){
	if($(this).hasClass("tb-out-of-stock")){return false;};
	if($(this).toggleClass("tb-selected").hasClass("tb-selected")){
		$(this).append("<i>selected</i>").siblings("li").removeClass("tb-selected").children("i").remove();
	}else{
		$(this).children("i").remove();
	}
	var selectedOptions=$("#skuOptions").children("dl.tb-prop").find("li.tb-selected[data-value]");
	var selectOptions=$("#skuOptions").children("dl.tb-prop").find("li[data-value]").not(".tb-selected");
	
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
	
	var skuOptions=$("#skuOptions").children("dl.tb-prop").find("li.tb-selected");
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
			msg+='&nbsp;&nbsp;<span class="red">现在有货</span>';
		}
	}
	$("#selectedProdMsg").html(msg);
	return false;
});

function checkAddProductToCart(){
	var skuOptions=$("#skuOptions").children("dl.tb-prop").find("ul[data-property]");
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

<content tag="header">
<%--大图开始 --%>
<div id="lightboxOverlay" class="opipoverlay" style="display:none;"><div style="background: none repeat scroll 0% 0% rgb(63, 76, 88); opacity: 0.4;"></div></div>
<div id="lightbox" class="more-photo" style="display:none; width:900px; height:600px;">
	<div class="more-title">
		<strong>${product.productName}</strong>
		<div class="m-close">
			<a id="lb-close" href="javascript:void(0)" ></a>
		</div>
	</div>
	<div class="blank10"></div>
	<div class="more-content">
		<div class="photo">
			<c:forEach items="${productMoreImages}" var="productMoreImage" end="0">
				<cartmatic:img id="lb-image" url="${productMoreImage.mediaUrl}" mediaType="productMedia" size="v" alt="${empty productMoreImage.mediaDescription?product.productName:productMoreImage.mediaDescription}" />
			</c:forEach>
		</div>
		<div class="sphoto">
			<ul id="lb-thumbnailContent">
				<c:forEach items="${productMoreImages}" var="productMoreImage">
					<li>
						<cartmatic:img url="${productMoreImage.mediaUrl}" mediaType="productMedia" size="a" width="42" height="42" />
					</li>
				</c:forEach>
			</ul>
			<fmt:parseNumber integerOnly="true"
				value="${(fn:length(productMoreImages)+1)/5}" var="imgPageCount"></fmt:parseNumber>
			<fmt:parseNumber integerOnly="true"
				value="${(fn:length(productMoreImages)+1)%5}" var="imgPageTempMod"></fmt:parseNumber>
			<c:set var="imgPageCount"
				value="${(imgPageTempMod>0?1:0)+imgPageCount}" />
			<input type="hidden" id="imgPageCount" value="${imgPageCount}">
		</div>
	</div>
	<div class="blank24"></div>
</div>
<%--大图结束 --%>
</content>
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
	<a href="">您可以 查看收藏夹</a>
</div>
<%--收藏夹弹出层 end --%>
</body>
</html>