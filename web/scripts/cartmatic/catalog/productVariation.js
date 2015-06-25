//global var
//3种状态样式及3种类型(文本,色块,图片)["a","b","c"];
var optional_class=["","box-txt","box-color","box-img"];
var block_class=["","block-txt","block-color","block-img"];
var selected_class=["","selected-txt","selected-color","selected-img"];
//undeterminedAttributes存储未选属性,
var undeterminedAttributes="";
var productVariationAttributes=new Array();
var productVariationAttributeNames=new Array();
var productVariations=new Array();
var productVariationOptions=new Array();
var jsonProductSkus=new Array();
var inited=false;
function variationChangeAction(in_attributeId,in_attributeOptionId,init){
	//防止未初始就选择
	if(!init){
		if(!inited){
			return;
		}
	}
	var selected_productVariationAttributeItem=$("#div_"+in_attributeId+"_"+in_attributeOptionId).get(0);
	var selected_optionValue=$("#option_value_"+in_attributeId).val();
	if(selected_productVariationAttributeItem.className==optional_class[getClassIndex(in_attributeId,in_attributeOptionId)]){//点击可选择
		$("#div_"+in_attributeId+"_"+in_attributeOptionId).attr("class",selected_class[getClassIndex(in_attributeId,in_attributeOptionId)]);
		$("#option_value_"+in_attributeId).get(0).value=in_attributeOptionId;
		if(selected_optionValue!=""){//将本属性原已选择的,去掉,转为optional_class可选择状态
			$("#div_"+in_attributeId+"_"+selected_optionValue).get(0).className=optional_class[getClassIndex(in_attributeId,selected_optionValue)];
		}
	}else if(selected_productVariationAttributeItem.className==selected_class[getClassIndex(in_attributeId,in_attributeOptionId)]){//选择已选择,即去除当前已选择状态,恢复为可选状态
		$("#div_"+in_attributeId+"_"+in_attributeOptionId).get(0).className=optional_class[getClassIndex(in_attributeId,in_attributeOptionId)];
		$("#option_value_"+in_attributeId).val("");
	}else{//点击block_class状态的,不作任务处理
		return;
	}
	var div_productVariationAttributes=document.getElementById("productVaritionAttributes");
	var div_productVariationAttributeItems=div_productVariationAttributes.getElementsByTagName("div");
	for (var i = 0; i < div_productVariationAttributeItems.length; i++) {
		var div_productVariationAttributeItem = div_productVariationAttributeItems[i];
		var productVariationAttributeTempId = div_productVariationAttributeItem.id;
		if (productVariationAttributeTempId.indexOf("div_") != -1) {
			var tempAttributeId=productVariationAttributeTempId.substring(productVariationAttributeTempId.indexOf("_")+1,productVariationAttributeTempId.lastIndexOf("_"));
			var tempAttributeOptionId=productVariationAttributeTempId.substring(productVariationAttributeTempId.lastIndexOf("_")+1,productVariationAttributeTempId.length);
			//非当前点击属性的其他属性的可选项全转为不可选状态block_class
			if(tempAttributeId != in_attributeId&&div_productVariationAttributeItem.className==optional_class[getClassIndex(tempAttributeId,tempAttributeOptionId)]){
				div_productVariationAttributeItem.className=block_class[getClassIndex(tempAttributeId,tempAttributeOptionId)];
			}
		}
	}
	//selectedOptionIds获取所有选项已选定的Id
	var selectedOptionIds=new Array();
	//undeterminedAttributes存储未选属性,
	undeterminedAttributes="";
	for(var i=0;i<productVariationAttributes.length;i++){
		var optionValue=$("#option_value_"+productVariationAttributes[i]).val();
		selectedOptionIds.push(optionValue);
		if(optionValue==""){
			undeterminedAttributes=undeterminedAttributes+productVariationAttributeNames[i]+","
		}
	}
	//tempProductVariations保存可能产生的productVariation(组合可能产生的)
	var tempProductVariations=new Array();
	for(var i=0;i<productVariations.length;i++){
		var flag=true;
		for(var j=0;j<selectedOptionIds.length;j++){
			flag=(selectedOptionIds[j]==""||selectedOptionIds[j]==productVariations[i][j]);
			if(!flag){
				break;
			}
		}
		if(flag){
			//todo可优化,消除重复
			tempProductVariations.push(productVariations[i]);
		}
	}
	//更新属性状态,转为可选
	for(var i=0;i<tempProductVariations.length;i++){
		for(var j=0;j<productVariationAttributes.length;j++){
			var attributeId=productVariationAttributes[j];
			var optionId=tempProductVariations[i][j];
			if($("#div_"+attributeId+"_"+optionId).get(0).className==block_class[getClassIndex(attributeId,optionId)]){
				$("#div_"+attributeId+"_"+optionId).get(0).className=optional_class[getClassIndex(attributeId,optionId)];
			}
		}
	}
	///更新单个属性选项(将已选定其他选项转为可选)
	var tempProductVariations2=new Array();
	for (var j = 0; j < selectedOptionIds.length; j++) {
		for (var i = 0; i < productVariations.length; i++) {
			if(selectedOptionIds[j]==""){
				break;
			}
			var flag=true;
			for (var k = 0; k < selectedOptionIds.length; k++) {
				flag=(selectedOptionIds[k]==""||selectedOptionIds[k]==productVariations[i][k]||selectedOptionIds[j]==selectedOptionIds[k]);
				if(!flag){
					break;
				}
			}
			if(flag){
			//todo可优化,消除重复
				tempProductVariations2.push(productVariations[i]);
			}
		}
	}
	//更新属性状态,转为可选(只更新已选定的属性)
	for(var i=0;i<tempProductVariations2.length;i++){
		for(var j=0;j<productVariationAttributes.length;j++){
			var attributeId=productVariationAttributes[j];
			var optionId=tempProductVariations2[i][j];
			var optionValue=$("#option_value_"+attributeId).val();
			if(optionValue!=""&&$("#div_"+attributeId+"_"+optionId).get(0).className==block_class[getClassIndex(attributeId,optionId)]){
				$("#div_"+attributeId+"_"+optionId).get(0).className=optional_class[getClassIndex(attributeId,optionId)];
			}
		}
	}
	if(undeterminedAttributes!=""){
		undeterminedAttributes=undeterminedAttributes.substring(0,undeterminedAttributes.length-1);
		$("#productSkuCode").val("");
		return ;
	}
	//获取相应的productVariation,更新页面信息
	var selectedProductVariation=null;
	for(var i=0;i<productVariations.length;i++){
		flag=true;
		for(var j=0;j<selectedOptionIds.length;j++){
			flag=(selectedOptionIds[j]==productVariations[i][j]);
			if(!flag){
				break;
			}
		}
		if(flag){
			selectedProductVariation=productVariations[i][selectedOptionIds.length];
			break;
		}
	}
	if(selectedProductVariation){
		var selectProductSku=null;
		for(var i=0;i<jsonProductSkus.length;i++){
			if(jsonProductSkus[i].productSkuId==selectedProductVariation){
				selectProductSku=jsonProductSkus[i];
				break;
			}
		}
		if(selectProductSku){
			fnChangeSku(selectProductSku);
		}else{
			log("jsonProductSkus 不存在该sku");
		}
		
	}else{
		log("没有相应的productVariation,暂时不存在(必须所有属性已选)");
	}
}
/*页面设置相应值*/
function getClassIndex(attributeId,optionId){
	var optionValueType=$("#option_value_type_"+attributeId+"_"+optionId).val();
	if(optionValueType==null||optionValueType==""){
		optionValueType=0;
	}
	return optionValueType;
}
function fnChangeSku(productSku){
	$("#productSkuCode").val(productSku.productSkuCode);
	$("#productSkuCodeSpan").html(productSku.productSkuCode);
	$("#priceSpan").html(__defaultCurrencySymbol+productSku.price);
	if(productSku.priceViewType==2){
		var salePriceSpanContent=__defaultCurrencySymbol+productSku.salePrice;
		salePriceSpanContent+="("+productSku.discountPercent+"%)";
		$("#salePriceSpan").html(salePriceSpanContent);
		$("#salePrice_content").show();
	}else{
		$("#salePriceSpan").html("");
		$("#salePrice_content").hide();
	}
	if(productSku.priceViewType==3){
		var discountPriceSpanContent=__defaultCurrencySymbol+productSku.discountPrice;
		discountPriceSpanContent+="("+productSku.discountPercent+"%)";
		$("#discountPriceSpan").html(discountPriceSpanContent);
		$("#discountPrice_content").show();
	}else{
		$("#discountPriceSpan").html("");
		$("#discountPrice_content").hide();
	}
	if(productSku.priceViewType==1){
		$("#listPriceSpan").html(__defaultCurrencySymbol+productSku.listPrice);
		$("#listPrice_content").show();
	}else{
		$("#listPriceSpan").html("");
		$("#listPrice_content").hide();
	}
	if(productSku.priceViewType==2||productSku.priceViewType==3){
		$("#priceSpan").attr("class","price");
	}else{
		$("#priceSpan").attr("class","ourPrice");
	}
	if(productSku.weight){
		$("#weightSpan").html(productSku.weight);
		$("#weight_content").show();
	}else{
		$("#weightSpan").html("");
		$("#weight_content").hide();
	}
	//批发价显示
	var wholesalePrices=productSku.wholesalePrices;
	var wholesalePrice_content='<table width="100%" border="0" cellspacing="0" cellpadding="0">';
	for(var i=0;i<wholesalePrices.length;i++){
		wholesalePrice_content+='<tr>';
		wholesalePrice_content+='<td width="100px;">';
		if(i==0){
			wholesalePrice_content+=__FMT.productDetail_wholesalePrices+"：";
		}else{
			wholesalePrice_content+='&nbsp;';
		}
		wholesalePrice_content+='</td>';
		wholesalePrice_content+='<td class="wholesalePrice" >';
		wholesalePrice_content+=wholesalePrices[i].minQuantity;
		if(i==wholesalePrices.length-1){
			wholesalePrice_content+=" +";
		}else{
			wholesalePrice_content+=" - "+(wholesalePrices[i+1].minQuantity-1);
		}
		wholesalePrice_content+='</td>';
		wholesalePrice_content+='<td class="wholesalePrice" >';
		wholesalePrice_content+=":"+__defaultCurrencySymbol+wholesalePrices[i].price;
		wholesalePrice_content+='</td>';
		wholesalePrice_content+='</tr>';
	}
	wholesalePrice_content+='</table>';
	$("#wholesalePrice_content").html(wholesalePrice_content);
	if(wholesalePrices.length>0){
		$("#wholesalePrice_content").show();
	}else{
		$("#wholesalePrice_content").hide();
	}
	if(jsonProduct.availabilityRule!=4)
		fnChangeAddToCartBtn(productSku.inventory);
	//切换图片
	if(productSku.image){
		originalPicURLs[0]=__mediaPath+productSku.image;
		standarPicURLs[0]=__mediaPath+fnGetProductImage(productSku.image,1);
		smallPicURLs[0]=__mediaPath+fnGetProductImage(productSku.image,2);
		if($("#smallpic_0"))
			$("#smallpic_0").attr("src",smallPicURLs[0]);
		$("#IMG_DIV").attr("src",standarPicURLs[0])
	}
}
function fnGetProductImage(imgUrl,type){
	var p1=imgUrl.substring(0,imgUrl.lastIndexOf("."));
	var p2=imgUrl.substring(imgUrl.lastIndexOf("."),imgUrl.length);
	if(type==1){
		return p1+"_md"+p2;
	}else if(type==2){
		return p1+"_mn"+p2;
	}
	return imgUrl;
}
function fnChangeAddToCartBtn(inventory){
	if(inventory.availableQuantity>0||jsonProduct.availabilityRule==4){
		$("#productStockSpan").html(inventory.availableQuantity);
		$("#addToCart").attr("src",__ctxPath+__FMT.image_btn_addtocart_on);
		$("#addToCart").attr("alt","Add To Cart");
		$("#addToCart").get(0).disabled=false;
	}else if(jsonProduct.availabilityRule==2&&(jsonProduct.preOrBackOrderLimit<1||inventory.preOrBackOrderedQty<jsonProduct.preOrBackOrderLimit)){
		var msg=__FMT.productDetail_inventory_preOrder;
		$("#productStockSpan").html(msg.replace("{0}",jsonProduct.expectedReleaseDate));
		$("#addToCart").attr("src",__ctxPath+__FMT.image_btn_addtocart_preOrder);
		$("#addToCart").attr("alt","Pre Order");
		$("#addToCart").get(0).disabled=false;
	}else if(jsonProduct.availabilityRule==3&&(jsonProduct.preOrBackOrderLimit<1||inventory.preOrBackOrderedQty<jsonProduct.preOrBackOrderLimit)){
		var msg;
		if(inventory.expectedRestockDate){
			msg=__FMT.productDetail_inventory_backOrder;
			msg=msg.replace("{0}",inventory.expectedRestockDate);
		}else{
			msg=__FMT.productDetail_inventory_will_ship;
		}
		$("#productStockSpan").html(msg);
		$("#addToCart").attr("src",__ctxPath+__FMT.image_btn_addtocart_backOrder);
		$("#addToCart").attr("alt","Back Order");
		$("#addToCart").get(0).disabled=false;
	}else{
		var msg;
		if(inventory.expectedRestockDate){
			msg=__FMT.productDetail_inventory_outof_stock_will_ship;
			msg=msg.replace("{0}",inventory.expectedRestockDate);
		}else{
			msg=__FMT.productDetail_inventory_outof_stock;
		}
		$("#productStockSpan").html(msg);
		$("#addToCart").attr("src",__ctxPath+__FMT.image_btn_addtocart_off);
		$("#addToCart").attr("alt","暂无库存！");
		$("#addToCart").get(0).disabled=true;
	}
}
