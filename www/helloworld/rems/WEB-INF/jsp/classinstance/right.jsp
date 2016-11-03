<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script>
$(function(){
	var scrH=$(window).height()- 130;
    $("#tableDiv").css("height",scrH-112);
})


</script>
<input type="hidden" id="count" value="${count }"/>
<table class="datalist nxfx_sbnx" id="aas">
	<thead class="sssbgl_thead">
	    <tr>
	        <td class="sbssgl-table-hd">设备设施名称</td>
	        <td class="sbssgl-table-hd">设备种类</td>
	        <td class="sbssgl-table-hd">设备所属能源站</td>
	        <td class="sbssgl-table-hd">图标</td>
	        <td class="sbssgl-table-hd">备注</td>
	        <td class="sbssgl-table-hd">操作</td>
	    </tr>
	</thead>
	<tbody>
		<c:forEach items="${pager.datas}" var="i" varStatus="s">
			<tr class="${s.index % 2 eq 0 ? 'even':'odd' }">
				<td>${i[2] }</td>
                <td>${i[3] }</td>
                <td>${i[5] }</td>
                <td><img src="<c:url value='${i[4]}' /> " style="width: 15px;height: 15px;"></td>
                <td title="${i[7] }">
                
                   <c:choose>
				     <c:when test="${fn:length(i[7]) > 10}">
					     <c:out value="${fn:substring(i[7], 0, 10)}" />...
				     </c:when>
				     <c:otherwise>
					     ${i[7]}
				     </c:otherwise>
			       </c:choose>
                </td>
                <td>
                   <shiro:hasPermission name="instance:delete"><a class="xml_del" val="${i[0] }"></a></shiro:hasPermission>
                   <shiro:hasPermission name="instance:update"><a class="xml_edite fancybox" val="${i[0] }" href="#pop-onupdate"></a></shiro:hasPermission>&nbsp;&nbsp;
                </td>
			</tr>
		</c:forEach>
	</tbody>
</table>