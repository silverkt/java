<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<input type="hidden" id="count" value="${count}"/>
	<table class="datalist datalist2 lbgltbl">
		<thead>
			<tr>
				<td class="proinfo-no">序号</td>
				<td>园区名称</td>
				<td>园区类型</td>
				<td>意识形态</td>
				<td>园区地址</td>
				<td>创园时间</td>
				<td class="proinfo-op">操作</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${parks.datas}" var="i" varStatus="s">
				<tr class="${s.index % 2 eq 0 ? 'even':'odd'}">
					<td>${s.index + 1}</td>
					<td class="ellipsis" title="${i.parkname}"><c:if test="${empty i.parkname}">    -    </c:if>${i.parkname}</td>
					<td><c:if test="${empty i.parktype}">    -    </c:if>${i.parktype}</td>
					<td><c:if test="${empty i.parkform}">    -    </c:if>${i.parkform}</td>
					<td class="ellipsis" title="${i.address}"><c:if test="${empty i.address}">    -    </c:if>${i.address}</td>
					<td><c:if test="${empty i.parktime}">    -    </c:if>${i.parktime}</td>
					<td class="opper">
					<shiro:hasPermission name="projectmanagement:parkdelete">
						<a class="xml_del" title="删除" onclick="del('${i.parkid }');"></a>
					</shiro:hasPermission>
					<shiro:hasPermission name="projectmanagement:parkupdate">
                		<a class="xml_edite fancybox" title="编辑" href="#pop-onupdate" onclick="edit('${i.parkid }','E');" ></a>
                	</shiro:hasPermission>
                	<shiro:hasPermission name="projectmanagement:parkinfo">
                		<a class="xml_view fancybox" title="查看" href="#pop-onupdate" onclick="edit('${i.parkid }','V');"  ></a>
                	</shiro:hasPermission>
					</td>
					<input type="hidden" value="${i.parkid }" id="parkid"/>
				</tr>
			</c:forEach>
		</tbody>
	</table>
