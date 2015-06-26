
var _MAX_SAVED_ITEMS = 5;
var _HISTORY_MESSAGES_COOKIE = "SMC";
var _ITEM_SEPERATOR = "~~";

function addCookieItem(cookieName, oItem) {
	var cookieValue = getCookie(cookieName);
	if (!cookieValue || cookieValue == null) {
		cookieValue = oItem;
	} else {
		if (cookieValue.indexOf(oItem) >= 0) {
			return;//identical or refresh,do nothing
		} else {
			cookieValue = oItem + _ITEM_SEPERATOR + cookieValue;
		}
	}
	var idx = 1;
	var itemCount = 0;
	while ((idx > 0) && (itemCount < _MAX_SAVED_ITEMS)) {
		idx = cookieValue.indexOf(_ITEM_SEPERATOR, idx + 1);
		if (idx > 0) {
			itemCount++;
		}
	}
	if (idx > 0) {
		cookieValue = cookieValue.substring(0, idx);
	}
	setCookie(cookieName, cookieValue, null, null, null, null);
}
function stringToArray(strViews, seperator) {
	var arrayViews = null;
	if (strViews && strViews != "") {
		arrayViews = strViews.split(_ITEM_SEPERATOR, _MAX_SAVED_ITEMS);
	}
	return arrayViews;
}
function saveRecentView(cookieName, extraAttrs,viewName) {
	var _viewUrl=parent.document.URL;
	var viewUrl=_viewUrl.substring(_viewUrl.indexOf("/", 10), _viewUrl.length);
	var curView = composeNameAndUrlStrView(viewUrl, viewName);
	if (extraAttrs) for (var i=0;i<extraAttrs.length;i++){
		curView=curView+"~"+extraAttrs[i];
	}
	addCookieItem(cookieName, curView);
}
function composeNameAndUrlStrView(viewUrl, viewName) {
	var tmpStr=viewUrl + "~" +viewName;
	return tmpStr;
}
function getViewDetails(strView) {
	return strView.split("~");
}
function getRecentViews(cookieName) {
	return navigator.cookieEnabled ? stringToArray(getCookie(cookieName)) : null;
}
/**scripts for store admin*/
function fnSaveHistoryMsg(sMsg) {
	addCookieItem(_HISTORY_MESSAGES_COOKIE, sMsg);
}