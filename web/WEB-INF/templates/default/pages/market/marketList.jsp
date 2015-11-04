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
    <script type="text/javascript" src="${ctxPath}/scripts/jquery/js/jquery-1.11.2.min.js"></script>
    <script src="${ctxPath}/scripts/jquery/js/global_brain.js"></script>
    <%@ include file="../../decorators/include/javascripts.jspf"%>
    <%@ include file="../../decorators/include/styles7.jspf"%>
    <link href="${ctxPath}/scripts/jquery/js/colorbox/colorbox.css" rel="stylesheet" />
    
    <link href="${resPath}/styles/css/lzw.css" rel="stylesheet">
    <link href="${resPath}/styles/css/mall_nav.css" rel="stylesheet">
    <link href="${resPath}/styles/css/shooping-list.css" rel="stylesheet">
    <script type="text/javascript" src="${ctxPath}/scripts/cartmatic/myaccount/loginDlg.js"></script>
	<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/catalog/productDetail.js"></script>
    <!--[if IE]>  <link rel="stylesheet" type="text/css" href="index2-ie-only.css/> <![endif]-->
    
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
	<%@ include file="../../decorators/include/headerMarket.jspf"%>
        <!--主体内容开始-->
        <content tag="heading"><product:navigatorBar navigatorCategorys="${navigatorCategorys}" /></content>
        <content:showAd adPositionType="category" />
		<div class="hot-sell">
        <form method="post" action="">
         <div class="w-shooping-list">
           <div  class="w-shooping-list-sort" id="sticky">
                <ul class="row">
                	<li>
                        <div class="sort-tit">排序方式<i class="fa fa-caret-down"></i></div>
                        <p><a href="?sort=s1" <c:if test="${fn:indexOf(pageContext.request.queryString,'sort=s1')!=-1}">class='active'</c:if>>最新上架</a></p>
                        <p><a href="?sort=s4" <c:if test="${fn:indexOf(pageContext.request.queryString,'sort=s4')!=-1}">class='active'</c:if>>价格由低到高</a></p>
                        <p><a href="?sort=s5" <c:if test="${fn:indexOf(pageContext.request.queryString,'sort=s5')!=-1}">class='active'</c:if>>价格由高到低</a></p>
                    </li>
                    <li>
                        <p><a href="/catalog_default_catalog.html" class="active">所有产品</a></p> 
                        <p><a href="/wen_catalog.html"><i class="fa fa-venus"></i>女士</a></p>
                        <p><a href="/man_catalog.html"><i class="fa fa-mars"></i>男士</a></p>
                    </li>
                </ul>
                <div class="sort-btn active">
                	<i class="fa fa-chevron-left"></i>
                    <p>分<br>类<br>筛<br>选</p>
                </div>           
           </div><!--w-shooping-list-sort-->
           <div class="w-shooping-list-box">
             <div class="product_box">
             <ul class="product list-unstyled col4 c sku_list" id="pinterestList">
             	<c:forEach items="${productList}" var="product" varStatus="varStatus">
             	<c:if test="${product.status ==1}">
					<li>
						<div class="li1">
	                        <a href="${ctxPath}/product/${product.productId}.html">
	                            <img class="imgo" src="${mediaPath}product/v/${product.defaultProductSku.image}" width="100%" />
	                            <%--<img class="imgt" src="${mediaPath}/productMedia/hd/${product.productHandDraw.mediaUrl}" width="100%"/>--%>
	                        </a>
	                    </div>
	                    <div class="li2">
	                        <div class="cutstr2">
	                            <a href="${ctxPath}/product/${product.productId}.html">
	                                ${product.productName}
	                            </a>
	                        </div>
	                        <span class="new">
	                        </span>
	                    </div>
	                    <p class="li3">
	                        ${product.brand.designer}
	                    </p>
	                    <p class="li4">
	                        ${product.brand.brandName}
	                    </p>
                        <div class="li5"><product:showPrice productSku="${product.defaultProductSku}" viewType="4"/></div>
                        <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
                        <div class="join_box">
	                        <c:forEach items="${productMap}" var="productMapItem">
		                    	<c:if test="${productMapItem.key == product.productId}">
				                 <c:forEach items="${productMapItem.value}" var="productSkuOptionAndValue">
											<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'color') > -1}">
												<div class="product_color">
													<ul class="tm-clear J_TSaleProp tb-img" data-property="${productSkuOptionAndValue.key.skuOptionName}">
														<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
															<li class="tb-selected"  data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}" style="display:none">
																	<a  id="color_${skuOptionValue.skuOptionValue }" class="imageSku"  href="#">
																		<span>${skuOptionValue.skuOptionValueName}</span>
																		<!--  background: url(<product:productImg sku="${skuOptionValue.sku}" size="a" isUrlOnly="true"/>) center no-repeat; -->
																	</a>
																	<i>selected</i>
															</li>
								                        </c:forEach>
													</ul>
												</div>
											</c:if>
				                                  
											<c:if test="${fn:indexOf(productSkuOptionAndValue.key.skuOptionCode,'size') > -1}">
												<div class="j1">尺码</div>
												<ul class="size" data-property="${productSkuOptionAndValue.key.skuOptionName}">
					                                 <p>
					                                 	<div class="j2">
															<c:forEach items="${productSkuOptionAndValue.value}" var="skuOptionValue" varStatus="status">
									                        	<span data-value="${productSkuOptionAndValue.key.id}:${skuOptionValue.id}">${skuOptionValue.skuOptionValueName}</span>
									                        </c:forEach>
								                        </div>
								                     </p>
												</ul>
											</c:if>
				                 </c:forEach>
				               </c:if>
				            </c:forEach>
				            <form id="myform" method="POST" action="#">
					               <input id="quantity" type="hidden" name="quantity" type="text"  value="${minOrderQuantity}" onKeyUp="value=value.replace(/[^\d]/g,'');fnChangePrice()" size="3" onblur="changeToOne(this);">
					             </form>
	                        <span class="cart_close">
	                            关闭
	                        </span>
	                        <product:addToCartSmall productSkuCode="${product.defaultProductSku.productSkuCode}" productSku="${product.defaultProductSku}" checkHandler="checkAddProductToCart" />
	                    </div>
	                    <input type="hidden" id="productSkuCode" value="${product.defaultProductSku.productSkuCode}" />
		                <p class="li6">
	                        <!-- JiaThis Button BEGIN -->
	                                            
	                                            <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"><i class="fa fa-share-alt"></i> 分享</a>
	                                           
	                                            <!-- JiaThis Button END -->
	                        <a href="javascript:" onClick="addToFavorite(${product.productId})"><i class="fa fa-heart-o"></i> 加入收藏</a>
	                        <a class="join" href="javascript:;"><i class="fa fa-cart-plus i3"></i> 加入购物车</a>
	                    </p>
                    </li>
                </c:if>
				</c:forEach>
             </ul>
            
          </div><!--product_box-->
                <%@ include file="./../../decorators/include/catalogPagingTopNew.jsp"%>
                <!--/分页-->
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
           </div><!--w-shooping-list-box-->
         </div><!--w-shooping-list-->
        </form>
        <!--主体内容结束-->
		<%@ include file="../../decorators/include/footerNew.jspf"%>
		
		
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
    <!--<style>.w-nav{height:94px;background:url(img/navbg.gif) 0 0 repeat-x}</style>-->
    <script>
			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				paginationClickable: '.swiper-pagination',
				nextButton: '.swiper-button-next',
				prevButton: '.swiper-button-prev',
				spaceBetween: 30
			});
		</script>
        <script>
			if($(window).width()>768){
					var swiper = new Swiper('.swiper2', {
						slidesPerView:4,
						paginationClickable: true,
						nextButton: '.swiper-button-next1',
						prevButton: '.swiper-button-prev1',
						spaceBetween: 30
					});
				}else{
						var swiper = new Swiper('.swiper2', {
							slidesPerView:2,
							paginationClickable: true,
							nextButton: '.swiper-button-next1',
							prevButton: '.swiper-button-prev1',
							spaceBetween: 30
						});
						$(function(){
							$(".w-pro-pic .swiper-slide img").width("100%")
						})
					}
				window.onresize=function(){
						if($(window).width()>768){
							var swiper = new Swiper('.swiper2', {
								slidesPerView:4,
								paginationClickable: true,
								nextButton: '.swiper-button-next1',
								prevButton: '.swiper-button-prev1',
								spaceBetween: 30
							});
						}else{
								var swiper = new Swiper('.swiper2', {
									slidesPerView:2,
									paginationClickable: true,
									nextButton: '.swiper-button-next1',
									prevButton: '.swiper-button-prev1',
									spaceBetween: 30
								});
								$(function(){
									$(".w-pro-pic .swiper-slide img").width("100%")
								})
							}
					}
		</script>
        <script type="text/javascript">
			function resetTabs(){
				$("#info-tabs-contents > div").hide();
				$("#tabs a").attr("id","");
			}
			
			var myUrl = window.location.href;
			var myUrlTab = myUrl.substring(myUrl.indexOf("#")); 
			var myUrlTabName = myUrlTab.substring(0,4);
			
			(function(){
				$("#info-tabs-contents > div").hide();
				$("#tabs li:first a").attr("id","current");
				$("#info-tabs-contents > div:first").fadeIn();
			
				$("#tabs a").on("click",function(e) {
					e.preventDefault();
					if ($(this).attr("id") == "current"){
						return       
					}else{             
						resetTabs();
						$(this).attr("id","current");
						$($(this).attr('name')).fadeIn();
					}
				});
			
				for (i = 1; i <= $("#tabs li").length; i++) {
					if(myUrlTab == myUrlTabName + i){
						resetTabs();
						$("a[name='"+myUrlTab+"']").attr("id","current");
						$(myUrlTab).fadeIn();
					}
				}
			})()
		</script>
        <script type="text/javascript">
        	$(function(){
				
					$(window).scroll(function(){
						$(".index-nav").addClass("w-nav-s")
					})
					
					$(".w-pro-info").height($(".swiper-container").height())
					
					
					$(".group1-pop").height($(".deta-bd-group1 ul li.center a img").height()).css("line-height",$(".deta-bd-group1 ul li.center a img").height()+"px")
					$(".deta-bd-group1 ul li.center .collocation-item").hover(function(){
							$(".group1-pop",this).fadeIn()
							$(".group1-bottom",this).fadeIn().css("visibility","visible")
						},function(){
								$(".group1-pop",this).fadeOut()
								$(".group1-bottom",this).css("visibility","hidden")
							}
						)
						
					$(".swiper2-mask").height($(".swiper2 .swiper-slide img").height())
					if($(window).width()<992){
							$(".w-pro-info").height("auto").css("padding-bottom","20px")
						}else{
							$(".w-pro-info").height($(".swiper-container").height())
							}
					$(".swiper2 .swiper-slide").hover(function(){
							$(".swiper2-mask",this).animate({top:0})
						},function(){
							$(".swiper2-mask",this).animate({top:100+"%"})
							}
						)
					$(".w-pro-info-btn a").click(function(){
							$(".w-pro-car").fadeIn()
							$(".w-pro-info-tabs").hide()
						})
					$(".w-pro-car em").click(function(){
							$(".w-pro-car").hide()
							$(".w-pro-info-tabs").fadeIn()
						})
						
					var H = $(window).height()
					$(".w-404").height(H)
					window.onresize=function(){
							var H = $(window).height()
							$(".w-404").height(H)
							$(".w-pro-info").height($(".swiper-container").height())
							if($(window).width()<992){
								$(".w-pro-info").height("auto").css("padding-bottom","20px")
							}else{
								$(".w-pro-info").height($(".swiper-container").height())
								}
							$(".group1-pop").height($(".deta-bd-group1 ul li.center a img").height()).css("line-height",$(".deta-bd-group1 ul li.center a img").height()+"px")
						}
				})
        </script>
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
      <script type="text/javascript">
        	$(function(){
				
					$(window).scroll(function(){
							$(".index-nav").addClass("w-nav-s")
						})
					if($(window).width()<993){
							$(".sort-btn p").html("分类筛选")
						}else{
							$(".sort-btn p").html("分<br>类<br>筛<br>选")
							}
				
					var H = $(window).height()
					$(".w-weekly-hd").height(H)
					if($(window).width()<992){
						$(".sort-btn p").html("分类筛选")
					}else{
						$(".sort-btn p").html("分<br>类<br>筛<br>选")
						}
					var MH = $(".weekly-hd-info").height()
					$(".weekly-hd-info").css("margin-top",-MH/2 - 30)
					$(".w-weekly-recomm ul li dl dd").click(function(){
							$(".w-buy-pop").fadeIn()
							$(".w-buy-pop-mask").fadeIn()
						})
					$(".w-buy-pop i").click(function(){
							$(".w-buy-pop").fadeOut()
							$(".w-buy-pop-mask").fadeOut()
						})
					
					
					if($(window).width()>992){
							$(".w-shooping-list-box").css({"margin-left":"290px","width":$(window).width()-290})
							$(".sort-btn").click(function(){
								if($(this).hasClass("active")){
										$(this).removeClass("active")
										$(".sort-btn i").removeClass("fa-chevron-left")
										$(".sort-btn i").addClass("fa-chevron-right")
										$(".w-shooping-list-box").animate({marginLeft:"60px","width":$(window).width()-60})
										$(".w-shooping-list-sort").animate({marginLeft:-230})
									}else{
										$(this).addClass("active")
										$(".sort-btn i").addClass("fa-chevron-left")
										$(".sort-btn i").removeClass("fa-chevron-right")
										$(".w-shooping-list-sort").animate({marginLeft:0})
										$(".w-shooping-list-box").animate({marginLeft:"290px","width":$(window).width()-290})
										}
							})
						}else{
								$(".sort-btn").removeClass("active")
								$(".sort-btn").click(function(){
										if($(this).hasClass("active")){
												$(".w-shooping-list-sort ul").css({height:"0"})
												$(this).removeClass("active")
											}else{
												$(".w-shooping-list-sort ul").css({height:"auto"})
												$(this).addClass("active")
												}
									})
							}
					window.onresize=function(){
							var H = $(window).height()
							$(".w-weekly-hd").height(H)
							if($(window).width()<992){
								$(".sort-btn p").html("分类筛选")
								$(".w-shooping-list-box").css({"margin-left":"0","width":"100%"})
								$(".sort-btn").removeClass("active")
							}else{
								$(".sort-btn p").html("分<br>类<br>筛<br>选")
								$(".w-shooping-list-box").css({"margin-left":"290px","width":$(window).width()-290})
								}
						}
				})
        </script>
        





	</body>

</html>