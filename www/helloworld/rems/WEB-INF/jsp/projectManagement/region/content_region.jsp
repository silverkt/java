<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<% String isView = getServletContext().getAttribute("isView") == null ? "false" : "true"; %>
<script type="text/javascript">
	var flag = <%=isView%>
</script>
<input type="hidden" id="count" value="${count}"/>
	<table class="datalist datalist2 lbgltbl">
		<thead>
			<tr>
				<td class="proinfo-no">序号</td>
				<td>经济区名称</td>
				<td>行政级别</td>
				<td>地理位置</td>
				<td>面积</td>
				<td>能源资源</td>
				<td class="porinfo-op">操作</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${regions.datas}" var="i" varStatus="s">
				<tr class="${s.index % 2 eq 0 ? 'even':'odd'}">
					<td>${s.index + 1}</td>
					<td class="ellipsis" title="${i.regionname}"><c:if test="${empty i.regionname}">    -    </c:if>${i.regionname}</td>
					<td class="ellipsis" title="${i.citycategory}"><c:if test="${empty i.citycategory}">    -    </c:if>${i.citycategory}</td>
					<td class="ellipsis" title="${i.position}"><c:if test="${empty i.position}">    -    </c:if>${i.position}</td>
					<td><c:if test="${empty i.area}">    -    </c:if>${i.area}</td>
					<td class="ellipsis" title="${i.resour}"><c:if test="${empty i.resour}">    -    </c:if>${i.resour}</td>
					<td class="opper">
					<shiro:hasPermission name="projectmanagement:regiondelete">
						<a class="xml_del" title="删除" onclick="del('${i.regionid }');"></a>
					</shiro:hasPermission>
					<shiro:hasPermission name="projectmanagement:regionupdate">
                		<a class="xml_edite fancybox" title="编辑" href="#pop-onupdate" onclick="edit('${i.regionid }','E');"></a>
                	</shiro:hasPermission>
                	<shiro:hasPermission name="projectmanagement:regioninfo">
                		<a class="xml_view fancybox" title="查看" href="#pop-onupdate" onclick="edit('${i.regionid }','V');"></a>
                	</shiro:hasPermission>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
