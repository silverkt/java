<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<pg:pager maxPageItems="${param.pageSize}" items="${param.items }" export="curPage=pageNumber" url="${param.url }" maxIndexPages="5">
<c:forEach items="${param.params }" var="p">
	<pg:param name="${p }"/>
</c:forEach>
 <!--    <div class="num_info">
<pg:last>
    共${param.items }条记录&nbsp;&nbsp;共${pageNumber }页&nbsp;&nbsp;
</pg:last>
当前第${curPage }页&nbsp;&nbsp;
</div>-->
<div class="pager mg_b40">
<pg:first>
    <a href="${pageUrl }" <c:if test="${curPage eq 1}">class="disabled"</c:if>>首页</a>
</pg:first>
<pg:prev>
	<a href="${pageUrl }">上一页</a>
</pg:prev>
<pg:pages>

<c:if test="${curPage eq pageNumber }">
    <a class="disabled">${pageNumber }</a>
</c:if>
<c:if test="${curPage ne pageNumber }">
	<a href="${pageUrl }">${pageNumber }</a>
</c:if>
</pg:pages>
<pg:next>
	<a href="${pageUrl }">下一页</a>
</pg:next>
<pg:last>
	<a href="${pageUrl }" <c:if test="${curPage ge (param.items/param.pageSize) }">class="disabled"</c:if>>尾页</a>
</pg:last>
        </div>
</pg:pager>