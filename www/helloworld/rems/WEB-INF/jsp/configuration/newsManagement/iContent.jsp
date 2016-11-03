<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<input type="hidden" id="iCount" value="${iCount}"/>
<ul>
	<c:forEach items="${iNews.datas}" var = "n" varStatus="s">
		<c:choose>
			<c:when test="${s.index % 2 eq 0}"><li class="dan"></c:when>
			<c:otherwise><li></c:otherwise>
		</c:choose>
			<span><fmt:formatDate value="${n.createtime}" pattern="MM-dd"/></span>
			<a href="javascript:;" title="${n.title}" onclick="flushNews(${n.newsid})">
			<c:choose>
				<c:when test="${fn:length(n.title) > 15}">
					<c:out value="${fn:substring(n.title, 0, 15)}" />...
				</c:when>
				<c:otherwise>
					${n.title}
				</c:otherwise>
			</c:choose>
			</a>
		</li>
	</c:forEach>
</ul>
	
