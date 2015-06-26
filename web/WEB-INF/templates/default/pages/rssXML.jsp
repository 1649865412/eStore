<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/css" media="screen" href="http://feeds.feedburner.com/~d/styles/itemcontent.css"?>
<%@ page language="java" contentType="application/rss+xml; charset=UTF-8" isELIgnored="false" buffer="24kb" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/catalog"%>
<c:set var="mediaPath" value="${appConfig.store.mediaUrlPath}" scope="request"/>
<rss version="2.0"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:wfw="http://wellformedweb.org/CommentAPI/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
	xmlns:slash="http://purl.org/rss/1.0/modules/slash/">
    <channel>
        <title>${appConfig.store.title}</title>
        <atom:link href="${appConfig.store.siteUrl}/rss" rel="self" type="application/rss+xml" />
        <link>${appConfig.store.siteUrl}</link>        
        <description>
            <![CDATA[wholesale - Wholesale - China wholesale - Professional Chinese wholesaler - Dropship from China]]>
        </description>
        <language>en</language>
		<%--
        <lastBuildDate>
            <![CDATA[Wed, 04 Nov 2009 16:57:46 -0800]]>
        </lastBuildDate>
		--%>
        <copyright>
            Copyright (C) 2008-2013 ${appConfig.store.name} Ltd.
        </copyright>
        <managingEditor>
            sales@handbagsmama.com (${appConfig.store.name})
        </managingEditor>
        <ttl>
            <![CDATA[1440]]>
        </ttl>
		<%--
        <pubDate>
            <![CDATA[Wed, 04 Nov 2009 10:00:07 -0800]]>
        </pubDate>
		--%>
        <image>
            <link>${appConfig.store.siteUrl}</link>
            <title>${appConfig.store.title}</title>
            <url>
                ${appConfig.store.siteUrl}/images/layout/mall_logo.jpg
            </url>
            
        </image>
		<c:forEach items="${productList}" var="productItem">
			<item>
	            <title>
	                <![CDATA[${productItem.productName}]]>
	            </title>
	            <guid isPermaLink="true">
	                ${appConfig.store.siteUrl}<product:productUrl product="${productItem}"/>
	            </guid>
	            <link>
	            	${appConfig.store.siteUrl}<product:productUrl product="${productItem}"/>
	            </link>
	            <description>
	                <![CDATA[
					<product:productImg product="${productItem}" size="b" width="130" height="130"/>
					${productItem.productDescription.fullDescription}
					]]>
	            </description>
	            <pubDate>
	                <fmt:formatDate value="${productItem.updateTime}" 
	                pattern="E, dd MMM yyyy hh:mm:ss z" timeZone="EST" />
	            </pubDate>
	            <author>
	                <![CDATA[${appConfig.store.email} (${appConfig.store.name} Ltd.)]]>
	            </author>
	        </item>
		</c:forEach>
    </channel>
</rss>
