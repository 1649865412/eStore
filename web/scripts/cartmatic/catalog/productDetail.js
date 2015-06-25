/**
 * 产品详细页面初始化
 */
$(document).ready(function(){
	fnChangePrice();
});
var dlgReview=null;   
function addReviewAction(isAllowAnonymousReview){
	var __addReview=function(){
		var customerId=getCurrentUserId();
		if (dlgReview ==null){
				dlgReview = fnCreateSimpleDialog("Review",__FMT.add_Review,null,{
				dialogWidth:"520px",
				dialogHeight:"350px"
				});
		}
		dlgReview.showDialog(__ctxPath+"/review/write/"+$("#productId").val()+".html?decorator=blank");
	}
	if(isAllowAnonymousReview){
		__addReview.call();
	}else{
		doRequiredLoginAction(__addReview);
	}
}
/***
 * 发表评论
 * @param {Object} form
 */
function doReviewAction(form,isAllowAnonymousReview){
	if (!validateProductReviewForm(form)) {
	}else{
		var __addReview=function(){
			var data=$("#productReviewForm").serialize();
			$.post("/review/write/"+$("#productId").val()+".html",data,fndoReviewAction,"json");
		};
		if(isAllowAnonymousReview){
			__addReview.call();
		}else{
			doRequiredLoginAction(__addReview);
		}
	}
}

function fndoReviewAction(data){
	if(data.action==1){
		if (dlgReview!=null)
			dlgReview.closeDialog();
		if($("#productReviewForm")){
			$("#productReviewForm").get(0).reset();
		}
		alert(__FMT.product_addReview_success);
		fnGetProductReviewList($("#productId").val());
	}else{
		alert("ERROR!");
	}
}

/**
 * 获取产品评论内容
 * @param {Object} productId
 */
function fnGetProductReviewList(productId,pageNum){
	var url=__ctxPath+'/review/product/'+productId+'.html';
	var pars='template=review/include/productReviewListContent&decorator=blank';
	if(pageNum){
		pars+="&PrmPageNo="+pageNum;
	}
	fillDivWithPage("productReviewContent", url, pars, null, "get", true);
}
/**
 * 产品评论表单验证
 * @param {Object} form
 */
function validateProductReviewForm(form){
	if(__fnIsEmptyOrOverMaxLength(form.productReview_username,__FMT.productReview_username_required)){
	}else if(__fnIsEmptyOrOverMaxLength(form.subject,__FMT.productReview_subject_required,128,__FMT.productReview_subject_maxlength)){
	}else if(__fnIsEmptyOrOverMaxLength(form.message,__FMT.productReview_message_required,1024,__FMT.productReview_message_maxlength)){
	}else {
		return true;
	}
	return false;
}
/***
 * 产品评论选择星
 * @param {Object} flag
 * @param {Object} index
 */
function fnChooseStar(flag, index){
	$("#rate_"+flag).val(flag+"_"+index);
	$("#star_"+flag).html(index);  
	var star=index;
	for (var i = 1; i <= 5; i++){
		if (i <= star)
			$("#star_"+flag+'_'+i).attr("class","star");
		else
			$("#star_"+flag+'_'+i).attr("class","star-gray");
	}
}
/**
 * 本评论是否对你有帮助
 * @param {Object} reviewId
 * @param {Object} voteFlag
 */
function fnVote(reviewId, voteFlag){
	doRequiredLoginAction(function(){
		if (!isLoginedAtServer()){
			window.location.reload();
			return;
		}
		$.post("/review/vote/"+reviewId+".html",{voteFlag:voteFlag},function($data){
				var info = $('#info_'+reviewId);
				if ($data.status == 1){
					info.removeClass("cRed").addClass("cGreen").html(__FMT.productReview_voteSuccess);
				}else if ($data.status == 2){
					info.removeClass("cRed").addClass("cGreen").html(__FMT.productReview_isVoted);
				}else if ($data.status == 3){
					info.removeClass("cGreen").addClass("cRed").html(__FMT.productReview_isSelfReview);
				}else if($data.status == -500){
					alert("系统错误了!");
				}
		},"json");
	});
}
function fnVoteCallback($data){
	var info = $('#info_'+reviewId);
	if ($data.status == 1){
		info.removeClass("cRed").addClass("cGreen").html(__FMT.productReview_voteSuccess);
	}else if ($data.status == 2){
		info.removeClass("cRed").addClass("cGreen").html(__FMT.productReview_isVoted);
	}else if ($data.status == 3){
		info.removeClass("cGreen").addClass("cRed").html(__FMT.productReview_isSelfReview);
	}
}

/**
 * 产品附件（指附件附加的推荐产品）
 * @param {Object} checkBoxName
 */
function fnGetSelectedCheckBoxValues(checkBoxName){
	var accessoriesCodes=new Array();
	var temp_checkBoxInputs=document.getElementsByName(checkBoxName);
	if(temp_checkBoxInputs){
		for(var i=0;i<temp_checkBoxInputs.length;i++){
			if(temp_checkBoxInputs[i].checked){
				accessoriesCodes.push(temp_checkBoxInputs[i].value);
			}
		}
	}
	return accessoriesCodes.join(",");
}
function __fnIsEmptyOrOverMaxLength(input,msg,maxLength,msg2){
	if(input.value==null||input.value.trim()==""){
		alert(msg);
		input.focus();
		return true;
	}else if(maxLength&&msg2){
		return __fnIsOverMaxLength(input,maxLength,msg2);
	}
	return false;
}
function __fnIsOverMaxLength(input,maxLength,msg){
	if(input.value.length>maxLength){
		alert(msg);
		input.focus();
		return true;
	}
	return false;
}
function __fnIsErrorEmail(input,msg){
	if(!fnValidateEmail(input.value)){
		alert(msg);
		input.focus();
		return true;
	}
	return false;
}

//产品详细页面，目录所有产品json对象
var productFlashBox=new Array();
var productFlashBox_pageSize=10;
var productFlashBox_pageCount=0;
var productFlashBox_pageNum=1;
var productFlashBox_productCount=0;
//初始化头部本目录产品分页数据
function initProductFlashBox(data){
	productFlashBox=data;
	productFlashBox_productCount=productFlashBox.length;
	productFlashBox_pageCount=Math.floor((productFlashBox_productCount/productFlashBox_pageSize))+((productFlashBox_productCount%productFlashBox_pageSize==0)?0:1);
	var productId=$("#productId").val();
	var temp_pageNum=1;
	for(var i=0;i<productFlashBox_productCount;i++){
		if(i>(temp_pageNum*productFlashBox_pageSize)){
			temp_pageNum++;
		}
		if(productFlashBox[i].productId==productId){
			productFlashBox_pageNum=temp_pageNum;
		}
	}
	showProductFlashBox();
}
/**
 * 产品详细页面上面的产品列表显示产品
 */
function showProductFlashBox(){
	if($("#productFlashBoxContent_Page")){
		$("#productFlashBoxContent_Page").html(productFlashBox_pageNum+"/"+productFlashBox_pageCount);
		var index=(productFlashBox_pageNum-1)*productFlashBox_pageSize;
		if(index>0)index-1;
		var end=index+productFlashBox_pageSize;
		var htmlContent="<ul>";
		var productId=$("#productId").val();
		for(var i=index;i<end;i++){
			if(i<productFlashBox_productCount){
				if(productFlashBox[i].productId==productId){
					htmlContent+='<li class="selected">';
				}else{
					htmlContent+='<li>';
				}
				htmlContent+='<a href="'+productFlashBox[i].url+'" title="'+productFlashBox[i].productName.replace(/"/g,"&quot;")+'"><img width="72" height="72" src="'+__mediaPath+"product/b/"+(productFlashBox[i].image)+'" /></a><br/>'+__defaultCurrencySymbol+(productFlashBox[i].price)+'</li>';
			}else{
				htmlContent+='<li>&nbsp;</li>';
			}
		}
		htmlContent+='</ul>';
		$("#productFlashBoxContent").html(htmlContent);
		fnLoadingImg();
	}
}
/**
 * 下一页产品
 */
function movePR(){
	productFlashBox_pageNum++;
	if(productFlashBox_pageNum>productFlashBox_pageCount)
		productFlashBox_pageNum=1;
	showProductFlashBox();
}
/**
 * 上一页产品
 */
function movePL(){
	productFlashBox_pageNum--;
	if(productFlashBox_pageNum<1)
		productFlashBox_pageNum=productFlashBox_pageCount;
	showProductFlashBox();
}
/**
 * 刷新更改价格
 */
function fnChangePrice() {
	var qty = $('#quantity').val();
	if(qty){
		var priceSum;
		var accessoryPrice=0;
		var accessorys=$("select[name='accessory']");
		for(var i=0;i<accessorys.length;i++){
			var selectedaccessory=$(accessorys[i]).children(":selected");
			if(parseFloat(selectedaccessory.attr("price"))>0){
				accessoryPrice+=parseFloat(selectedaccessory.attr("price"));
			}
		}
		var priceViewType=$("#priceViewType").val();
		for(var i=skuWholesalePrices.length-1;i>=0;i--){
			if(qty >= parseInt(skuWholesalePrices[i][0])){
				priceSum=(parseFloat(skuWholesalePrices[i][1])+accessoryPrice)*qty;
				if(priceViewType==2||priceViewType==3){
					$("#salesPriceSpan").html(__defaultCurrencySymbol+(parseFloat(skuWholesalePrices[i][1])+accessoryPrice).toFixed(2));
				}else{
					$("#priceSpan").html(__defaultCurrencySymbol+(parseFloat(skuWholesalePrices[i][1])+accessoryPrice).toFixed(2));
					if($("#savedSpan")){
						var listPrice=$("#listPrice").val();
						$("#savedSpan").html("&nbsp;"+__defaultCurrencySymbol+(listPrice-(parseFloat(skuWholesalePrices[i][1])+accessoryPrice)).toFixed(2)+"&nbsp;("+((listPrice-(parseFloat(skuWholesalePrices[i][1])+accessoryPrice))/listPrice*100).toFixed(0)+"%)");
					}
					$("#products_price_all").html(__defaultCurrencySymbol+priceSum.toFixed(2));
				}
				break;
			}
		}
	}
}
$("select[name='accessory']").change(fnChangePrice);
/***
 * 检查产品是否可以添加入购物车
 */
function checkAddProductToCart(){
	var isOk=true;
	if($("#productSkuCode").val()==""){
		alert(undeterminedAttributes+__FMT.unselected+"!");
		isOk=false;
	}
	if(isOk&&$("select[name='accessory']").length>0){
		//产品附件选项（新添加的），如color,size
		var accessorys=$("select[name='accessory']");
		var msg="";
		var accessoryIds="";
		for(var i=0;i<accessorys.length;i++){
			if($(accessorys[i]).val()==0){
				if(msg!="")
					msg+=" and ";
				msg+=$(accessorys[i]).attr("accessoryName");
			}else{
				if(accessoryIds!=""){
					accessoryIds+=",";
				}
				accessoryIds+=$(accessorys[i]).val();
			}
		}
		if(msg!=""){
			msg="Please Select "+msg;
			alert(msg);
			isOk=false;
		}else{
			$("#selectAccessorys").val(accessoryIds);
			isOk=true;
		}
	}
	if(isOk&&(parseInt($("#quantity").val()) < parseInt($("#minOrderQuantity").val()))){
		isOk=false;
		alert("Starting from:"+$("#minOrderQuantity").val()+" Unit(s).");
	}
	return isOk;;
}

/**
 * 
 * @param a 事件触发
 * @param img 图片
 * @param s_size 小尺寸
 * @param b_size 大尺寸
 */
function fnChangeProdImg(a,img,s_size,b_size){
	a.addClass("selected").siblings().removeClass("selected");
	var imgsrc=img.attr("src").replace("/"+s_size+"/","/"+b_size+"/");
	$("#productImg").attr("src",__resPath+"/images/img/empty.gif");
	var newBigImage = document.createElement("IMG");
    newBigImage.src = imgsrc;
	newBigImage.onload=function(){$("#productImg").attr("src",imgsrc);};
}

//产品详细页面图片下面的小图分页处理
if($("#imgPageCount")){
	var imgPageCount=$("#imgPageCount").val();
	var imgOnePageLenght=265;
	var imgMaxLenght=imgPageCount*imgOnePageLenght;
	var imgPageNum=1;
}
/**
 * 产品小图列表下一页
 */
function moveR(){
	imgPageNum++;
	var pageIndex=imgPageNum-1;
	var leftPx=pageIndex*imgOnePageLenght;
	if(leftPx>=imgMaxLenght){
		$("#imgContent").css("left",0+"px");
		imgPageNum=1;
	}else{
		$("#imgContent").css("left",-leftPx+"px");
	}
	$("#imgPageShow").html(imgPageNum+"/"+imgPageCount);
}
/**
 * 产品小图列表上一页
 */
function moveL(){
	imgPageNum--;
	var pageIndex=imgPageNum-1;
	var leftPx=pageIndex*imgOnePageLenght;
	if(leftPx<0){
		$("#imgContent").css("left",-(imgMaxLenght-imgOnePageLenght)+"px");
		imgPageNum=imgPageCount;
	}else{
		$("#imgContent").css("left",-leftPx+"px");
	}
	$("#imgPageShow").html(imgPageNum+"/"+imgPageCount);
}


jQuery.fn.loadingImg = function(image) {
	if(image.complete)return;
	var url=image.src;
	var w = image.getAttribute("width");
	var h = image.getAttribute("height");
	var w = image.getAttribute("width");
	var h = image.getAttribute("height");
	if(w)
		$(image).attr('width',w);
	if(h)
		$(image).attr('height',h);
	$(image).attr({'src':__ctxPath+'/images/img/imgBox_s.gif'});
	$(image).css('background', 'url('+__ctxPath+'/images/img/loading_img_s.gif) 50% 50% no-repeat');
	var img = new Image(); //new img obj
	$(img).attr("t",1);
	$(img).load(function(){
		var __imgload=function(){
			if(img.complete)
				$(image).attr('src',url);
			else{
				var t=parseInt($(img).attr("t"));
				if(t<=3){
					t++;
					$(img).attr("t",t);
					setTimeout(__imgload,100);
				}else{
					$(image).attr({'src':__ctxPath+'/images/default/00.jpg','originsrc':url});
				}
			}
		}
		__imgload.call();
	}); 
	$(img).error(function(){
		$(image).attr({'src':__ctxPath+'/images/default/00.jpg','originsrc':url});
	});
	img.src = url;	//set src either absolute or rel to css dir
};
function fnLoadingImg(){
	$("img[src*='/media/'][src$='.jpg'],img[src*='/media/'][src$='.gif'],img[src*='/media/'][src$='/']").each(function(){
		$(this).loadingImg(this);
	});
}
function popupwin(url,name,width,height,options){if($.browser.msie){var win=window.showModelessDialog(url,window,"status:false;dialogWidth:"+(width)+"px;dialogHeight:"+(height+30)+"px;edge:Raised; help: 0; resizable: 0; status: 0;scroll:0;");}
else{xposition=0;yposition=0;if((parseInt(navigator.appVersion)>=4)){xposition=(screen.width-width)/2;yposition=(screen.height-height)/2;}
theproperty="width="+width+","+"height="+height+","+"screenx="+xposition+","+"screeny="+yposition+","+"left="+xposition+","+"top="+yposition+","+options;
var win=window.open(url,name,theproperty);win.focus();}
return false;}
//询价
var dlgInquiry=null;
var dlgInquiry_r="";
function fnShowInquiryDialog() {
	if (dlgInquiry==null) {
		$.getScript(__ctxPath+"/scripts/jquery/plugins/validation/jquery.validate.js",function(){
				dlgInquiry = fnCreateSimpleDialog("Inquiry","",null,{
				dialogWidth:"400px",
				dialogHeight:"180px"
			});
			dlgInquiry.showDialog(__ctxPath + "/inquiry.html?decorator=blank&"+dlgInquiry_r);
		});
	}else{
		dlgInquiry.showDialog(__ctxPath + "/inquiry.html?decorator=blank&"+dlgInquiry_r);
	}
}

function showBox(id){
	var boxs=["payment_option","shipping_info","costs_info"];
	for(var i=0;i<boxs.length;i++){
		if(boxs[i]==id){
			$("#"+boxs[i]).show();
		}else{
			$("#"+boxs[i]).hide();
		}
	}
}