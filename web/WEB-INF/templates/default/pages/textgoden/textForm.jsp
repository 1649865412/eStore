<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<app:pageHeading entityName="${text.textName}" entityHeadingKey="textDetail.heading" />
<content tag="buttons">
	<cartmatic:cartmaticBtn btnType="save" onclick="return fnDoSave(this);" />
	<%--
	<cartmatic:cartmaticBtn btnType="saveAndNext" onclick="return fnDoSaveAndNext(this);" />
	--%>
    <c:if test="${text.textId!=null}">
		<cartmatic:cartmaticBtn btnType="delete" onclick="return fnDoDelete(this);" />
	</c:if>
	<cartmatic:cartmaticBtn btnType="cancel" onclick="return fnDoCancelForm(this);" />
</content>
<app:showBindErrors bindPath="text.*" />
	<form:form method="post" cssClass="mainForm" id="text" commandName="text"
			action="${ctxPath}/texctcodegen/text.html" onsubmit="return validateText(this);">
		<input type="hidden" name="textId" value="${text.textId}"/> 
		<table class="table-content" cellSpacing="0" cellPadding="0" width="100%" border="0">
		<app:input property="name" />
 		<app:input property="text" />
  	</table>
</form:form>

<v:javascript formName="text" staticJavascript="false" />
<script type="text/javascript">
    document.forms["text"].elements["name"].focus();
</script>
