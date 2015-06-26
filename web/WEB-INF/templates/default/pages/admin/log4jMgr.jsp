<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<%@ include file="../../decorators/include/styles.jspf"%>    
    <title>Log4j Manager</title>
<script type="text/javascript">
function fnConfirmSave(frm) 
{
	if(confirm("Save ?")){
		frm.doAction.value="save";
		return true;
	}
	return false;
}
function fnConfirmSomeAction(frm,ID,action,warningMsg,confirmMsg) 
{
	if(ID!=null){
        var len = ID.length; 
        var checked = false; 

        for (i = 0; i < len; i++) 
        { 
            if (ID[i].checked == true) 
            { 
                checked = true; 
                break; 
            } 
        } 
        if (!checked) 
        { 
            alert(warningMsg); 
            return false; 
        } 
    }
	if(confirm(confirmMsg)){		
		frm.doAction.value=action;
		return true;
	}
	return false;
}
</script>
</head>
<body>
<c:set var="buttons">
    <button type="submit" name="save" class="btn-update" style="margin-right: 5px" onclick="return fnConfirmSave(this.form);">
        <fmt:message key="button.save"/>
    </button>
</c:set>
<table width="100%">
	<tr>
		<td width="80%">
		<a href="${ctxPath}/admin/index.html">index</a>
		<a href="${ctxPath}/admin/log4jMgr.html">log4jMgr</a>
		</td>
		<td align="right">
		<a href="<c:url value="/j_acegi_logout"/>">logout</a>
		</td>
	</tr>
</table>
<hr/>
<form method="post">
<div id="list-btn-wrap" class="alignleft">
	<button type="submit" name="reset" class="btn-update" style="margin-right: 5px" onclick="return fnConfirmSomeAction(this.form,null,'resetAll',null,'Reset all setting from log4j.properties?');">
        Reload all
    </button>
	<button type="submit" class="btn-other" onclick="this.form.doAction.value='downloadLog';__lightboxDisableOnce=true;">
        Download log file
    </button>
</div>
<c:if test="${not empty extraLoggerList}">
<hr/>
<div id="list-btn-wrap" class="alignleft">
	<button type="submit" name="save" class="btn-update" style="margin-right: 5px" 
	onclick="this.form.doAction.value='mutilSaveExtraConfig'">
        Update temp log4j pattern
    </button>        
</div>
<display:table name="${extraLoggerList}" cellspacing="0" cellpadding="0"
	uid="loggerItem" class="data-table-wrap" 
	export="false" requestURI="" >
	<%--checkall column ycm 2006-04-28--%>	
	<display:column style="width: 5" title="${checkAll}" headerClass="data-table-title" media="html">
	    &nbsp;
	</display:column>
	<%--checkall column ycm 2006-04-28 end--%>
    <display:column sortable="false" headerClass="data-table-title" title="Pattern"
	decorator="com.cartmatic.estore.core.decorator.TblColumnDecorator">
       ${loggerItem}
	</display:column>
	<display:column sortable="false" headerClass="data-table-title"
        decorator="com.cartmatic.estore.core.decorator.TblColumnDecorator" title="Current Level">
		<select name="extra_${loggerItem}" id="extra_${loggerItem}" class="box-input">
		<option value="DEBUG" <c:if test="${applicationScope.extra_log4j_config[loggerItem] == 'DEBUG'}">selected</c:if>>DEBUG</option>
		<option value="INFO" <c:if test="${applicationScope.extra_log4j_config[loggerItem] == 'INFO'}">selected</c:if>>INFO</option>
		<option value="WARN" <c:if test="${applicationScope.extra_log4j_config[loggerItem] == 'WARN'}">selected</c:if>>WARN</option>
		<option value="ERROR" <c:if test="${applicationScope.extra_log4j_config[loggerItem] == 'ERROR'}">selected</c:if>>ERROR</option>
		<option value="FATAL" <c:if test="${applicationScope.extra_log4j_config[loggerItem] == 'FATAL'}">selected</c:if>>FATAL</option>
		<option value="OFF" <c:if test="${applicationScope.extra_log4j_config[loggerItem] == 'OFF'}">selected</c:if>>OFF</option>
		</select>		
	</display:column>
</display:table>

</c:if>
<TABLE class="data-table-wrap" cellSpacing=0 cellPadding=0 width="100%" border=0>
<tr>
	<td>&nbsp;Pattern <input size="40" type="text" name="newPattern" id="newPattern" class="box-input"/>
	&nbsp;&nbsp;
    Level 
	    <select name="newLevel" id="newLevel">
		<option value="DEBUG" selected>DEBUG</option>
		<option value="INFO" >INFO</option>
		<option value="WARN" >WARN</option>
		<option value="ERROR">ERROR</option>
		<option value="FATAL" >FATAL</option>
		<option value="OFF" >OFF</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;		
	<button type="submit" class="btn-other" onclick="this.form.doAction.value='addExtraConfig'">
        <fmt:message key="button.add"/>
    </button>
	Add a temp log4j pattern.
	</td>
</tr>
</table>
<hr/>
  <div id="list-btn-wrap" class="alignleft"><c:out value="${buttons}" escapeXml="false"/></div>
  <display:table name="${loggerList}" cellspacing="0" cellpadding="0" uid="loggerItem" class="data-table-wrap" export="false" requestURI="" >
	<display:column style="width: 5" title="${checkAll}" headerClass="data-table-title" media="html">&nbsp;</display:column>
    <display:column sortable="false" headerClass="data-table-title" title="Pattern"
	decorator="com.cartmatic.estore.core.decorator.TblColumnDecorator">
       ${loggerItem}
	</display:column>
    <display:column sortable="false" headerClass="data-table-title"
        decorator="com.cartmatic.estore.core.decorator.TblColumnDecorator" title="Original Setting">
		${configProp[loggerItem]}
	</display:column>
	<display:column sortable="false" headerClass="data-table-title"
        decorator="com.cartmatic.estore.core.decorator.TblColumnDecorator" title="Current Level">
		<select name="${loggerItem}" id="${loggerItem}">
		<option value="DEBUG" <c:if test="${currentProp[loggerItem] == 'DEBUG'}">selected</c:if>>DEBUG</option>
		<option value="INFO" <c:if test="${currentProp[loggerItem] == 'INFO'}">selected</c:if>>INFO</option>
		<option value="WARN" <c:if test="${currentProp[loggerItem] == 'WARN'}">selected</c:if>>WARN</option>
		<option value="ERROR" <c:if test="${currentProp[loggerItem] == 'ERROR'}">selected</c:if>>ERROR</option>
		<option value="FATAL" <c:if test="${currentProp[loggerItem] == 'FATAL'}">selected</c:if>>FATAL</option>
		<option value="OFF" <c:if test="${currentProp[loggerItem] == 'OFF'}">selected</c:if>>OFF</option>
		</select>		
	</display:column>
</display:table>
<div id="list-btn-wrap" class="alignleft"><c:out value="${buttons}" escapeXml="false"/></div>
<input type="hidden" name="doAction" value=""/>
</form>
</body>
</html>
