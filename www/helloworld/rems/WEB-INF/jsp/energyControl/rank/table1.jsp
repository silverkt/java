<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<c:forEach items="${(map.d)[0]}" var="d" varStatus="s">
	<tr class="${s.index % 2 == 0 ? 'even':'odd' }">
		<td style="border-right: solid 1px #ccc;">${s.index+1 }</td>
		<td class="tleft pl20 ellipsis"
			style="color: #000;border-right: solid 1px #ccc; white-space:nowrap;" title="${d.projectname
			}">${d.projectname
			}</td>
		<c:forEach items="${map.d}" var="mp" varStatus="s1">
			<td><span class="ellipsis dinlineblock w75 tright"   title = "${mp[s.index].datavalue1 }" style="position:relative;top:4px;">${mp[s.index].datavalue1 }</span>
			</td>

			<td class="tright" style="border-right: solid 1px #ccc;">
				<div>
					
 
					<span style="margin-top: 4px;width: 7px;height: 9px;"
						class="fr dblock mr0 ${empty mp[s.index].tendency || mp[s.index].tendency eq 0 ? '' : mp[s.index].tendency > 0 ? 'iconup':'icondown' } ico-lift lift-none"
						 title="相比前一时间周期名次变化">
					</span>
					<span class="fr dinline" style="right:12px;position: relative;">${mp[s.index].nowsort}</span>  
				</div></td>
		</c:forEach>
	</tr>
</c:forEach>
<input type="hidden" id="ascOrdesc" value="${asc}"/>