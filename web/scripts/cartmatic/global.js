/**
 * 最常用、可重用、业务无关、技术无关、框架无关、最精简的JS方法集合
 * 
 * 合并了原来的storefront.js，简化本js,不提供对表单操作的相关方法.只是前台使用
 * 
 * 
 */
if (!eCom) {
	var eCom = new Object();
}

jQuery(document).ready(function(){
	jQuery("img[original]").lazyload({placeholder:__resPath+"/images/img/empty.gif",failurelimit:10});
});

/**String增加trim方法，去除头尾的空格*/
String.prototype.trim = function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

/**去除字符串头尾的空格*/
function trim(str) {
    return str==null?null:str.trim();
}

function fnAppendUrl(url,paramName,paramValue) {
	if (!url || !paramName || !paramValue) {
		return url;
	}
	var tmpUrl = removeParamFromUrl(url,paramName);
	return tmpUrl + (tmpUrl.indexOf('?') > -1 ? '&' : '?') + paramName+"="+paramValue;
}

function removeParamFromUrl(url, paramName) {
	return url.replace(new RegExp("("+paramName+"=[^&]*[&])|([?|&]"+paramName+"=[^&]*$)"), "");
}
/**
* 取到当前的事件对象,同时兼容ie和ff的写法 
*/
function getEvent(){
    if (document.all) {
    	return window.event;
    }         
    var func=getEvent.caller;             
    while(func!=null){     
        var arg0=func.arguments[0]; 
        if(arg0){ 
            if((arg0.constructor==Event || arg0.constructor ==MouseEvent) 
                || (typeof(arg0)=="object" && arg0.preventDefault && arg0.stopPropagation)){     
               return arg0; 
            } 
        } 
        func=func.caller; 
    } 
    return null; 
}

/**
	取到当前事件的源对象
**/
function getEventSourceObject(){
	var evt=getEvent();
    return evt.srcElement || evt.target;
}

function _defaultAjaxErrorHandler(errMsg,xhr) {
	alert(errMsg);
}
/*在Firebug记录调试信息的简便方法，但响应的log语句在调试通过后应删除以提高效率*/
function log(sMsg) {
	typeof console=='undefined'?alert(sMsg):console.log(sMsg);
}
/*Cookie管理注意事项：Cookie会被发到服务器因而占用带宽，要提高性能就要减少Cookie的消耗，有以下原则：
 *原则1：尽量不使用Cookie，而且一般也不应有非全局的Cookie，还需要限制Cookie的path的范围
 *原则2：尽量在服务器端处理Cookie而不是客户端，客户端只读
 *原则3：Cookie必须尽量简短，且不能存储敏感数据
 *原则4：尽量集中管理全局Cookie（如在一个隐藏Frame处理；统一不设置path，因为隐藏页面只能读本身URL匹配的path的Cookie，但需采用异步方式，较麻烦－－Cookie的读取和进一步处理一般是在onload里面，或onclick等事件，以保证这时隐藏frame已经准备好）；
 */
function setCookie(name,value,expires,path,domain,secure) {
  document.cookie = name + "=" + escape (value) +
    ((expires) ? "; expires=" + expires.toGMTString() : "") +
    ((path) ? "; path=" + path : "") +
    ((domain) ? "; domain=" + domain : "") + ((secure) ? "; secure" : "");
}
function getCookie(name) {
	var prefix = name + "=" 
	var start = document.cookie.indexOf(prefix)
	if (start==-1) {
		return null;
	}
	start+=prefix.length;
	var end = document.cookie.indexOf(";", start) 
	if (end==-1) {
		end=document.cookie.length;
	}
	var cookieValue = document.cookie.substring(start, end);
	if (cookieValue) //把所有'"'去掉.
	{
		cookieValue = cookieValue.replace(/"/g,"");
		cookieValue =  decodeURI(cookieValue);
	}
		
	return unescape(cookieValue);
}

/**
* 按比例缩小图片。如图片实际大小比要求的小，无需调整；否则，只需要调整width或height（浏览器会自动调整）
* oImg image对象
* reqWidth 期望中的width
* reqHeight 期望中的height 
*/
function fnResizeImage(oImg, reqWidth, reqHeight) {
	if (reqWidth >= oImg.width && reqHeight >= oImg.height){
		return;
	}
	if ((oImg.width/oImg.height) > (reqWidth/reqHeight)) {
		oImg.width = reqWidth;
	} else {
		oImg.height = reqHeight;
	}
}








/**
 *在StoreAdmin和StoreFront都常用的脚本，其实里面大部分都只是在后台用，但可能以后在前台也使用。主要和框架相关。
 */
function getCurrentUserId(){
	return getCookie("UID")||-2;
}
/**不严格的简单判断用户是否登录的方法，性能较好，缺省设置为5分钟更新一次*/
function isLogined() {
	return getCurrentUserId()>0;
}
function getCurrentUserName(loginRequired) {
	return (!loginRequired||isLogined())&&getCookie("UNAME")||"";
}
function getLoginUserEmail(loginRequired) {
	return (!loginRequired||isLogined())&&getCookie("UEMAIL")||"";
}
/**
 *在StoreFront常用的脚本
 */
var bCancel=false;

function isIE()
{
	return (navigator.userAgent.toLowerCase().indexOf("msie") != -1);
}
/*以下为多个onload事件的简单处理框架，但无法像Ext.onReady那样完善和强大。注意：body以及JS不能再定义onload，应改用addOnload。*/
var onloadHandlers=[];
function addOnload(handler) {
	if (handler) {
		onloadHandlers.push(handler);
	}
}

$(document).ready(function(){
	for (var i = 0; i < onloadHandlers.length; ++i) {
		onloadHandlers[i].call(this);
	}
}); 

function fillLoginPrompt() {
	var _str='';
	if (!isLogined()) {
		_str=$("#loginPromptHolderTemplateLogout").html();
	} else {
		var uname=getCookie("UNAME");
		//emial的去掉@后的部分
		if(uname.indexOf("@")!=-1)
			uname=uname.substring(0,uname.indexOf("@"));
		_str=format_params($("#loginPromptHolderTemplateLogin").html(),uname);
	}
	if($("#loginPromptHolder")){
		$("#loginPromptHolderTemplateLogout").html(_str);
	}
}

/*为所有详细内容的tab写的公共方法，
 * 默认tab命名为tab_head_n，tab对应页面的div命名为tab_content_n。
 * $tabFlag = 'xx' 则必需有对应的xx_head_n和xx_content_n的对象
 * 只支持最多10个tab，数量可以修改。*/
function fnSelectTab(selectTabNumber, $tabFlag){
	var tab_flag = "tab_";
	if ($tabFlag)
	{
		tab_flag = $tabFlag;
	}
	var tab_count = 10;
	for(var d = 1; d <= tab_count; d++){
       var head =$("#"+tab_flag+ 'head_'+d) ; 
       var content = $("#"+tab_flag + "content_"+d);   
       if(head){
	       if (d == selectTabNumber)
	       {  
	    	  head.addClass("selected");
	          content.show();
	       }else{
		      head.removeClass("selected");
	          content.hide();
	       }
       }
	}
}







/**参加sample dialog 的code 移到本js  ssss***/
var _eComDialogs=new Array(); 
//currentDialog应永远指向dialog列表的最后一个或null，z-index总是递增10
var currentDialog=null;
var _dialogZIndex=10000;
var dialogIdPrefix="divDlg";
eCom.SimpleDialog = function(config){
	var dialogId=config.dialogId;
	var showTime=0;
	//创建dialog的外层 
	var dlgModalDom = document.createElement("div");
	dlgModalDom.id=dialogIdPrefix+dialogId;
	dlgModalDom.style.display="none";
	dlgModalDom.className="more-photo sifang";
	var dlgParentDom=config.parentDom||document.body;
	dlgParentDom.appendChild(dlgModalDom);
	var dlgOverlay=$('<div id="'+dlgModalDom.id+'Overlay" class="opipoverlay" style="display:none;"><div style="background: none repeat scroll 0% 0% rgb(63, 76, 88); opacity: 0.4;"></div></div>');
	$(dlgParentDom).prepend(dlgOverlay);
	dlgModalDom.innerHTML=_getDlgBoxHtml(dialogId,config.dialogTitle);
	dlgOverlay.click(function(){
		closeSimpleDialog(dialogId);
	});
	//如果指定dialogContent（可以是Loading...之类的）则填充
	var divContentDom=$("#_dlgContBox"+dialogId);
	var dialogContent=config.dialogContent;
	if (typeof dialogContent=="string" && dialogContent.trim().length>=0) {
		divContentDom.html(dialogContent);
	} else if (dialogContent!==null) {
		divContentDom.append(dialogContent);
	}
	//设置处理方法等
	var staticDialogUrl = config.staticDialogUrl;
	var cacheEnabled = config.cacheEnabled||true;
	var onshowHandler = config.onshowHandler;
	var _savedOnshowHandler=null;
	var fillContentDivId = config.fillContentDivId||divContentDom;
	var savedDialogPageUrl=null;
	
	var _fnOnshowHandlerProxy=function() {
		if (_savedOnshowHandler) {
			if (typeof _savedOnshowHandler=="function") {
				_savedOnshowHandler.call(this);
			} else {
				eval(_savedOnshowHandler+"()");
			}
		}
		//设置dialog的大小和位置
		dlgModalDom.style.left=config.left||Math.round(((parseInt(document.documentElement.clientWidth||document.body.clientwidth)-parseInt($(dlgModalDom).width()))/2))+"px";
		dlgModalDom.style.top=config.top||Math.round(((parseInt(document.documentElement.clientHeight||document.body.clientHeight)-parseInt($(dlgModalDom).height())-40)/2)+(document.documentElement.scrollTop||document.body.scrollTop))+"px";
		dlgModalDom.style.zIndex=_dialogZIndex+=10;
		dlgModalDom.style.display="block";
		currentDialog=this;
	};
	return {
		/**
		 * 显示窗口，如指定了url则先读取页面（异步）填充到指定位置，然后显示，接着调用onShowHandler（如果有），里面还可进行数据填充等处理。
		 */
		showDialog : function (dynamicPageUrl,dynamicOnshowHandler) {
			_savedOnshowHandler=dynamicOnshowHandler||onshowHandler;
			var _dialogPageUrl=dynamicPageUrl||staticDialogUrl;
			//对动态内容，每次都调用URL;如果是第一次（dialog不存在），或使用URL动态生成对话框模式并且是不可缓存的，就更新对话框的内容
			if (_dialogPageUrl && (!cacheEnabled || _dialogPageUrl!=savedDialogPageUrl)) {
				savedDialogPageUrl=_dialogPageUrl;
				//给login设置inDialog标记解决session过期问题
				_dialogPageUrl=fnAppendUrl(_dialogPageUrl,"inDialog","true");
				fillDivWithPage(fillContentDivId, _dialogPageUrl, null, _fnOnshowHandlerProxy,"GET",true); 
			} else {
				_fnOnshowHandlerProxy();
			}
			toggleBtn();
			showTime=new Date().valueOf();
			$("#"+dlgModalDom.id+"Overlay").show();
		},
		closeDialog : function() {
			dlgModalDom.style.display = "none";
			currentDialog=null;
			$("#"+dlgModalDom.id+"Overlay").hide();
		},
		getDialogId : function() {
			return dialogId;
		},
		getShowTime : function() {
			return showTime;
		}
	}
};
function getSimpleDialog(dialogId) {
	for (i=0;i<_eComDialogs.length;i++) {
		if (_eComDialogs[i].getDialogId()==dialogId) {
			return _eComDialogs[i];
		}
	}
	return null;
}

function _getDlgBoxHtml(dialogId,dialogTitle) {
	return ['<div class="more-title"><strong>',dialogTitle,'</strong><div class="m-close"><a href="javascript:void(0)" onclick="closeSimpleDialog(\'',dialogId,'\');return false;"></a></div></div><div class="blank10"></div><div class="more-content" id="_dlgContBox',dialogId,'"></div>'].join('');
}
/**
 * 方便的创建dialog的方法，需要指定id，title，config等；而dialogContent可选，可为null或""或
 * html字符串或div等的dom对象。如果非空，其值或对象直接作为dialog的内容。
 * config可以是eCom.SimpleDialog里面的所有配置。
 */
function fnCreateSimpleDialog(dialogId, dialogTitle, dialogContent, config){
	var _dlg = getSimpleDialog(dialogId);
	if (!_dlg) {
		config.dialogId=dialogId;
		config.dialogTitle=dialogTitle;
		config.dialogContent=dialogContent;
		_dlg=new eCom.SimpleDialog(config);
		_eComDialogs.push(_dlg);
	} 
	return _dlg;
}
function showSimpleDialog(dialogId) {
	var _dlg=getSimpleDialog(dialogId);
	if (_dlg) {
		_dlg.showDialog();
	}
}
function closeSimpleDialog(dialogId) {
	var _dlg=getSimpleDialog(dialogId);
	if (_dlg) {
		_dlg.closeDialog();
	}
}

/*框架内部用，兼容异步/同步方式的状态改变处理器，主要功能是调用正确的ajaxCallback来进行进一步处理。ajaxCallback不能为空。*/
function _ajaxReadyStateHandler(xhr,sUrl,ajaxCallback, ajaxErrorCallbackHandler) {
    var readyState = xhr.readyState;
    if (readyState == 4) {
        var httpStatus = xhr.status;
        if (httpStatus >= 200 && httpStatus < 300) {
            ajaxCallback.call(this,xhr.responseText);
        } else {
        	var errMsg = "ERROR request: " + sUrl + "\n\nReadyState: " + readyState + "\nStatus: " + httpStatus + "\nHeaders: " + xhr.getAllResponseHeaders();
            var _ajaxErrorHandler = ajaxErrorCallbackHandler||_defaultAjaxErrorHandler;
            _ajaxErrorHandler.call(this,errMsg,xhr);
        }
    }
}
/*如要发参数要用POST，否则应在调用前把参数序列化加入URL.还没有处理超时。ajaxCallback不能为空。*/
function ajaxCall(prmUrl, prms, postOrGet, async, ajaxCallback, ajaxErrorCallbackHandler) {
	var xhr = null;
	if (window.ActiveXObject) {
		xhr = new ActiveXObject("Msxml2.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	}
	if (xhr == null) {
		return alert("XMLHttpRequest is not supported!");
	}
    var sUrl=prmUrl;
    if ((prms && prms.length > 0) && (postOrGet != "POST")) {
          	sUrl += (sUrl.match(/\?/) ? '&' : '?') + prms;
	}
	var _async = async==null?true:async;
	if (_async) {
       	xhr.onreadystatechange = function() { 
       		_ajaxReadyStateHandler(xhr,sUrl,ajaxCallback,ajaxErrorCallbackHandler);
       	}
	}
    xhr.open(postOrGet, sUrl, _async);
    if (postOrGet == "POST")
    {
    	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    	xhr.send(prms);
    }
    else
    {
    	xhr.send(null);
    }
	if (!_async) {
		_ajaxReadyStateHandler(xhr,sUrl,ajaxCallback,ajaxErrorCallbackHandler);
	}
}


/**
 *还不成熟，不能控制同步，不能控制get或post（可用参数控制），nocache还未生效，要用disableCaching，会显示Loading...
 *JS比较方便可以用普通写法，但不能同步所以外窗口不能调用里面的JS；但通过callback可以调用load进来的JS
 */
function fillDivWithPage(prmDivId, prmUrl, prms, fillCallback, postOrGet, async) {
	if (prms == null || prms ==""){postOrGet = "GET";}
	ajaxCall(prmUrl, prms, postOrGet||"POST", async, function(responseText){
		var target=null;
		if(typeof(prmDivId)=="string"){
			target = $("#"+prmDivId).get(0);
		}else{
			target=prmDivId.get(0);
		}
	    if (document.createRange) {
	        var rng = document.createRange();
	        rng.setStartBefore(target);
	        var htmlFrag = rng.createContextualFragment(responseText);
	        while (target.hasChildNodes()) {
	        	target.removeChild(target.lastChild);
	        }
	        target.appendChild(htmlFrag);
	    } else {
	        target.innerHTML=responseText;
	    }
	    if (fillCallback) {
	    	fillCallback.call(this);
	    }
	});
}
function _isLoaded(url) {
	var ss = document.getElementsByTagName(url.toLowerCase().lastIndexOf(".css")>0?"link":"script");
	for (i = 0; i < ss.length; i++) {
		var _url=ss.href||ss[i].src||ss[i].syncUrl;
		if (_url && _url.indexOf(url) != -1) {
			return true;
		}
	}
	return false;
}




/**用同步方式载入JS（CSS不需要），慢网络会有停顿*/
function $importSync(url, defer) {
	if (_isLoaded(url)) {
		return;
	}
	ajaxCall(url.indexOf(__ctxPath)==0?url:(__ctxPath+url), null, "GET", false, function(responseText){
		if (responseText != null) {
			var oHead = document.getElementsByTagName("head")[0];
			var oScript = document.createElement("script");
			oScript.type = "text/javascript";
			oScript.defer = defer || true;
			oScript.text = responseText;
			oScript.syncUrl=url;
			oHead.appendChild(oScript);
		}
	},function(){
		alert("Failed to load script: "+url);
	});
}
function JsCssLoader() {
	this.load = function (url) {
		if (_isLoaded(url)) {
			this.onsuccess();
			return;
		}
        //动态创建script/link结点装入外联的.js/.css文件
		if (url.toLowerCase().lastIndexOf(".css")>0) {
			var s=document.createElement("link");
			s.setAttribute("rel", "stylesheet");
			s.setAttribute("type", "text/css");
			s.setAttribute("href",url);
		} else {
			var s = document.createElement("script");
			s.type = "text/javascript";
			s.src = url;
		}
        //获取head结点，并将script/link插入到其中
		var head = document.getElementsByTagName("head")[0];
		head.appendChild(s);
           
        //保存自身以便在事件中引用
		var self = this;
        //使用readystatechange(IE)或onload(FF等)事件在载入成功后进行处理
		s.onload = s.onreadystatechange = function () {
            //在此函数中this指针指的是s结点对象，而不是JsCssLoader实例,
            //所以必须用self来调用onsuccess事件，下同。
			if (s.readyState && s.readyState == "loading") {
				return;
			}
			self.onsuccess(url);
		};
		s.onerror = function () {
			head.removeChild(s);
			self.onfailure(url,arguments);
		};
	};
    //定义载入成功事件
	this.onsuccess = function (url) {
	};
	//定义失败事件
	this.onfailure = function (url,args) {
		alert("Error loading JavaScript/StyleSheet: "+args[0]+" -- "+args[1]+" -- "+args[2]);
	};
}
/**动态载入脚本并执行callback。如果没有callback，一般只适合不需要等待就可继续的情况。已知问题：FF下CSS没有事件处理。IE下ext事件处理部分必须先装入。*/
function $import(urls,callback) {
	if (!(urls instanceof Array)) {
		alert("Invalid $import call syntax, must be array.");
		return;
	}
	var _loader=new JsCssLoader();
	if (urls.length>1) {
		_loader.onsuccess=function() {
			$import(urls.slice(1,urls.length),callback);
		}
	} else if (callback) {
		_loader.onsuccess=callback;
	}
	//这里永远只是载入数组里的第一个，因为其他的会在callback处理
	_loader.load(urls[0].indexOf(__ctxPath)==0?urls[0]:(__ctxPath+urls[0]));
}




/**
 * 通过 HTTP GET 请求载入 JSON 数据（暂简单实现）
 * TODO 本ajax请求没有指定相应的头部信息（框架原因）
 * @param {Object} url
 * @param {Object} param
 * @param {Object} callback
 */
function getJSON(url, param, callback){
	ajaxCall(url.indexOf(__ctxPath)==0?url:(__ctxPath+url), param, "GET", false, function(responseText){
		callback.call(this,eval("(" + responseText + ")"));
	},function(){
		alert("Failed to get JSON: "+url);
	});
}
function fnValidateEmail(str){
	//var patn = /^[_a-zA-Z0-9\-]+(\.[_a-zA-Z0-9\-]*)*@[a-zA-Z0-9\-]+([\.][a-zA-Z0-9\-]+)+$/;
	var patn = /[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/i;
	if(patn.test(str)){
		return true;
	}else{
		return false; 
	}
}
function fnHidePop(e,id){
	e = e || window.event;
	o = e.relatedTarget||e.toElement;
	if(o==null)return;
	while(o.parentNode&&o.id!=id){	o=o.parentNode;}
	if(o.id!=id){
		$("#"+id).hide();
	}
}
function fnCheckSearchForm($frm)
{
	if ($frm.q.value == "")
	{
		alert("请输入要搜索的商品信息!");
		$frm.q.focus();
		return false;
	}
	return true;
}
function format_params(source, params) {
	if ( arguments.length == 1 ) 
		return function() {
			var args = $.makeArray(arguments);
			args.unshift(source);
			return format.apply( this, args );
		};
	if ( arguments.length > 2 && params.constructor != Array  ) {
		params = $.makeArray(arguments).slice(1);
	}
	if ( params.constructor != Array ) {
		params = [ params ];
	}
	$.each(params, function(i, n) {
		source = source.replace(new RegExp("\\{" + i + "\\}", "g"), n);
	});
	return source;
}

function fnFormatNumber(nStr) {
	if(nStr==null){
		return 0;
	}
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}
function fnFormatPrice(price){
	if(price==null){
		price=0;
	}else{
		price=fnFormatNumber(parseFloat(price).toFixed(2));
	}
	return "￥ "+price;
}


//初始化登录状态
//addOnload(fillLoginPrompt);
// Marquee
(function($){
	var methods = {
        marquee: function marquee(user_settings) {
            var self = $(this);            
			var sch = self.attr('scrollHeight');
			self.append(self.html());
            var settings = {
                timeout: null,
                events: {
                    play: function(evt) {
                        var self = $(this);						
						var sct = self.scrollTop();
						if(sct>=sch)self.scrollTop(sct=sct-sch);
						self.animate({scrollTop:sct+settings.step-sct%settings.step},2000,function(){
							if(settings.timeout) clearTimeout(settings.timeout);
							settings.timeout = setTimeout(function(){self.marqueePlay()},settings.time);
						});
                    },
                    stop: function(evt) {
                        var self = $(this);
                        clearTimeout(settings.timeout);self.stop();
                    }
                }
            };
            if(self.data("marquee.settings")) {
                settings = self.data("marquee.settings");
            }
            settings = $.extend(user_settings, settings);            
            for(var event in settings.events) {
                var evt = "marquee." + event;
                self.unbind(evt);
                self.bind(evt, settings.events[event]);
            }            
            self.data("marquee.settings", settings);
			self.marqueePlay();
            return self;
        },
        marqueePlay: function() {
            $(this).trigger("marquee.play");         
        },
        marqueeStop: function() {
            $(this).trigger("marquee.stop");
        }
    };
    $.each(methods, function(i) {
        $.fn[i] = this;
    });
})(jQuery);



//BookMark
var addthis_url    = location.href;   
var addthis_title  = document.title;  
var addthis_pub    = 'dressesheaven';
function at12Y( ){
	var CSSPagePath="";
	addthis_url=encodeURIComponent(addthis_url); addthis_title=encodeURIComponent(addthis_title); addthis_title=addthis_title.replace(/'/g,'\\\''); 
	var at12y='<a href="'+at12I('')+'\" onclick=\"return addthis_to();\"></a>';
	$("#bookMarkImg").wrap(at12y);
}
function at12I(at12r){return 'http://www.addthis.com/bookmark.php?v=12&winname=addthis&pub='+addthis_pub+'&s='+at12r+'&url='+addthis_url+'&title='+addthis_title; }
function addthis_to(at12r){if (at12r=='favorites'){addthis_url=decodeURIComponent(addthis_url); addthis_title=decodeURIComponent(addthis_title); if (document.all)window.external.AddFavorite(addthis_url,addthis_title); else window.sidebar.addPanel(addthis_title,addthis_url,''); return false; }window.open(at12I(at12r),'addthis','scrollbars=yes,menubar=no,width=620,height=400,resizable=yes,toolbar=no,location=no,status=no'); return false; }

function toggleBtn(){
	$("button[class*='toggle']").hover(function(){var btn=$(this);if(!_breakWitch(btn)){btn.addClass("on");}},function(){var btn = $(this);if(!_breakWitch(btn)) {btn.removeClass("on");}});
}
function _breakWitch(btn){
	return btn.hasClass("loading")||btn.hasClass("stock")||btn.hasClass("no-addtocart");
}

$(document).ready(function(){
	toggleBtn();
	at12Y();
});

$(function(){
	$(".cart_tabs").children().mousemove(function(){
		var tabContent=$("#"+$(this).attr("name"));
		if(tabContent){
			$(this).addClass("selected").siblings().removeClass("selected");
			tabContent.show().siblings().hide();
		}
	});
	$(".cart_mscroll").each(function(i){
		var cartMScroll=$(this);
		var data=jQuery.parseJSON(cartMScroll.attr("data-value"));
		var onePageLenght=parseFloat(data.onePageLenght);
		var maxLength=onePageLenght*cartMScroll.children().size();
		$("#"+data.next).click(function(){
			var left=parseFloat(cartMScroll.css("left"));
			left-=onePageLenght
			if(left<=-maxLength){
				left=0;
			}
			cartMScroll.css("left",left+"px");
		});
		$("#"+data.prev).click(function(){
			var left=parseFloat(cartMScroll.css("left"));
			left+=onePageLenght;
			if(left>0){
				left=maxLength*-1+onePageLenght;
			}
			cartMScroll.css("left",left+"px");
		});
	 });
});