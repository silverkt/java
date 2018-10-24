<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<link href="<c:url value='/resources/css/news.css' />" rel="stylesheet" />

<div class="news-title">${news.title}
</div>
<div class="news-publish">
发布人：${news.user.userShowName} &nbsp;<span class="news-publish-time">发布时间：
<fmt:formatDate value="${news.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
</div>
${news.newscontaint}