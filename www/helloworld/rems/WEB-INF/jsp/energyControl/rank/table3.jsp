<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<input type="hidden" name="count" value="${count }" id="count"/>
<tbody>
<c:forEach items="${values}" var="v" varStatus="s">
	<tr class="${s.index % 2 eq 0 ? 'even' : 'odd' }">
			<td class="fnzpm_w20" style="">${v.nowsort}</td>
			<td class="fnzpm_w100" style="text-align:left;" title="${v.projectname }">
				<span class="ellipsis dinlineblock por3 w140">${v.projectname }</span>
				<span class="${empty v.tendency || v.tendency eq 0 ? '' : v.tendency > 0 ? 'up':'down' }" style="float:right;position:relative;top:5px;height:9px;"></span>
			</td>
			<td class="fnzpm_w62"><span style="display:inline-block;width:120px;text-align:right;padding-right:40px;">${v.datavalue1 }</span></td>
	</tr>
</c:forEach>
</tbody>