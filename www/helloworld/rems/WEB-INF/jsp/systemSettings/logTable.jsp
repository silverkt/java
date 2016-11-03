<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<input type="hidden" id="count" value="${count }" />
<script type="text/javascript">
$(function(){
});
</script>
<table class="datalist">
	<thead>
		<tr>
			<td style="height: 32px !important;">
				操作人
			</td>
			<td style="height: 32px !important;">
				日志类型
			</td>
			<td style="height: 32px !important;">
				模块
			</td>
			<td style="height: 32px !important;">
				操作类型
			</td>
			<td style="height: 32px !important;">
				IP
			</td>
			<td style="height: 32px !important;">
				日志信息
			</td>
			<td style="height: 32px !important;">
				创建时间
			</td>

			<%--<td>状态</td>--%>
			<%--<td>操作</td>--%>

		</tr>
	</thead>
	<tbody>
		<c:if test="${count == -999}" >
			<tr>
				<td colspan="7" align="center" style="color:red;">未查询到相关数据</td>
			</tr>
		</c:if>
		<c:forEach var="p" items="${logs.datas}" varStatus="s">
			<input type="hidden" name="useid" value="${p.userid}" />
			<tr class="${s.count%2==0 ? 'odd':'even'}">
				<td>
					${p.usershowname }
				</td>
				<td>
					<c:if test="${p.type == 1 }">登录日志</c:if>
					<c:if test="${p.type == 2 }">业务日志</c:if>
					<c:if test="${p.type == 3 }">错误日志</c:if>

				</td>
				<td class="ellipsis" title="${p.module }">
					${p.showModule }
				</td>
				<td>
					${p.operatetype }
				</td>
				<td>
					${p.userip }
				</td>
				<td class="ellipsis" title="${p.message }">
					${p.showMessage }
				</td>
				<td>
					<fmt:formatDate value="${p.createdate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>


				<%--<td>
                         				<shiro:hasPermission name="menu:update">
	                                		<a thisurl="#" class="isvalidBtn ico-status ico-statusRight"></a>
	                                	</shiro:hasPermission>
	                                </td>--%>
				<%--<td>
                         				<shiro:hasPermission name="menu:update">
	                                		<a thisurl="<c:url value='/menu/updateInput/${p.menuid}?id=${id}&menuid=${menuid}' />" class="updateBtn ico-op ico-opUpdate fancybox" href="#pop-onMenuUpdate" title="编辑"></a>
	                                	</shiro:hasPermission>
	                                </td>--%>

			</tr>
		</c:forEach>
	</tbody>

</table>
