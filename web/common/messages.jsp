
<!-- error or success message -->
<style>
.lyt-maincontent {
	width:1000px;
	margin:0 auto;
	overflow:hidden;
	background-color:#fff
}
.productlist-wrap {
	float:left;
	width:100%;
	margin-top:10px;
	background-color:#fff
}
.error_box,.success_box,.warning_box,.caution_box {
	font-size:14px;
	font-weight:bold;
	padding:15px 10px 15px 60px;
	margin:10px 0
}
.error_box,.warning_box,.caution_box {
	background:#fedfdf url(../images/icon/icon_error.gif) 20px 10px no-repeat;
	border:1px solid #bf0000;
	color:#bf0000
}
.success_box {
	background:#ebfedf url(../images/icon/icon_right.gif) 20px 10px no-repeat;
	border:1px solid #859802;
	color:#666
}
</style>

<c:if test="${not empty errors}">
	<div class="error_box">
		<c:forEach var="error" items="${errors}">
			<li class="succeed">
				<c:out value="${error}" escapeXml="false" />
			</li>
		</c:forEach>
	</div>
	<c:remove var="messages" scope="session" />
</c:if>
<c:if test="${not empty messages}">
	<div class="${HAS_ERRORS?'error_box':'success_box'}">
		<c:forEach var="message" items="${messages}">
			<li class="succeed">
				<c:out value="${message.information}" escapeXml="false" />
			</li>
		</c:forEach>
	</div>
	<c:remove var="messages" scope="session" />
	<c:remove var="HAS_ERRORS" scope="session" />
</c:if>