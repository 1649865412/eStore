<%@ tag import="java.util.regex.Matcher, 
				com.cartmatic.estore.core.util.UrlUtil,
				java.util.regex.Pattern"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><%@ 
	attribute name="url" type="java.lang.String" description="当前页面请求路径"%><%@ 
	attribute name="pageNum" type="java.lang.Integer" description="指定页数"%><%
	if (url.indexOf("search-prod.html") > 0 || url.indexOf("search.html") > 0)
	{
	    url = UrlUtil.removeParamFromUrl(url,"pageNo");
	    url = UrlUtil.appendParamToUrl(url, "pageNo", pageNum.toString());
	}
	else
	{
		Pattern pattern=Pattern.compile("^.*_pn\\d{0,}.html.*");
		Matcher matcher=pattern.matcher(url);
		if(matcher.matches()){
			pattern=Pattern.compile("_pn\\d{0,}.html");
			matcher=pattern.matcher(url);
			if(pageNum<2){
				url=matcher.replaceAll(".html");
			}else{
				url=matcher.replaceAll("_pn"+pageNum+".html");
			}
		}else{
			pattern=Pattern.compile(".html");
			matcher=pattern.matcher(url);
			if(pageNum>=2){
				url=matcher.replaceAll("_pn"+pageNum+".html");
			}
		}
	}
out.print(url);
%>