<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- Include common set of tag library declarations for each layout --%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
        <decorator:head/>
    </head>
<body <decorator:getProperty property="body.id" writeEntireProperty="true"/>
<decorator:getProperty property="body.onload" writeEntireProperty="true"/>
<decorator:getProperty property="body.onunload" writeEntireProperty="true"/>>
<table width="100%">
	<tr>
		<td width="80%" align="center">
		<a href="<c:url value="/admin/index.html"/>"><b>Administrator page</b></a>
		</td>
		<td align="right">
		<a href="<c:url value="/j_acegi_logout"/>">logout</a>
		</td>
	</tr>
</table>
<decorator:body/>
</body>
</html>
