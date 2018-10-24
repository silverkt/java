<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<tbody>
<c:forEach items="${values}" var="v" varStatus="s">
	<tr class="${s.index % 2 eq 0 ? 'even' : 'odd' }">
			<td class="fnzpm_w20" style="text-align:center;">${v.nowsort}</td>
			<td class="fnzpm_w100 ellipsis" style="text-align:left;width:145px;" title="${v.projectname }">
				${v.projectname }
				<a style="float:right;font-family:Arial;width:40%;text-align:right;"></a>
			</td>
			<td class="fnzpm_w100" style="width:20px;">
				<span style="float:right;position:relative;" class="${empty v.tendency || v.tendency eq 0 ? '' : v.tendency > 0 ? 'up':'down' } ico-lift lift-none" title="相比前一时间周期名次变化">&nbsp;</span>
			</td>
			<td class="fnzpm_w100">
				<a style="float:right;font-family:Arial;text-align:right;">${v.datavalue1 }</a>
			</td>
	</tr>
</c:forEach>
</tbody>