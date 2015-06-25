<script type="text/javascript" src="${pageContext.request.scheme}://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js" ></script>
<script type="text/javascript" src="${ctxPath}/scripts/jsp/global.js"></script>
<script type="text/javascript" src="${ctxPath}/scripts/cartmatic/recentView.js"></script>
<script type="text/javascript">
<%--填充recentView--%>
function fnFillHistoryInStoreFront(boxHolderId,cookieName) {
	var arrayViews = getRecentViews(cookieName);
	var htmlContent = "";
		if (arrayViews && arrayViews.length > 0) {
			for (i = 0; i < arrayViews.length; i++) {
				var viewDetails = getViewDetails(arrayViews[i]);				
				htmlContent = htmlContent + "<div class='product-list-c'>"+
					"<div class='photo'>"+
					"<a href='" + viewDetails[0] + "'>" +
					"<img width='70' height='70'  src='"+ viewDetails[2] +"' onerror=\"this.onerror='';this.src=__defaultImage\" />"+
					"</a>"+
					"</div>"+
					"<div class='right'>"+
					"<a href='" + viewDetails[0] + "'>" + viewDetails[1] + "</a>"+	
					"</div>"+
					"</div>";
			}
		}
	parent.document.getElementById(boxHolderId).innerHTML = htmlContent;
}
if (navigator.cookieEnabled) {
	if (parent.document.getElementById("boxRecentView")) {
		fnFillHistoryInStoreFront("boxRecentView","RPC");
	}
	var parentUrl = parent.document.URL;
	var pattern = new RegExp("^.*_p[1-9][0-9]*.html");
	if (pattern.test(parentUrl)) {
		var imgSrc = parent.document.getElementById("product_image")?parent.document.getElementById("product_image").value:"";
		var product_simpleName = parent.document.getElementById("product_simpleName")?parent.document.getElementById("product_simpleName").value:"";
		saveRecentView("RPC", [imgSrc],product_simpleName);		
	} 
}
</script>