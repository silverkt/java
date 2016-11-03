<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
</script>
<table data-model = "homepage" data-tcode="p1">
	<thead>
		<tr>
			 <th>属性显示名</th>
             <th>属性</th>
             <th>单位属性</th>
             <th>操作</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${circulars}" var="i" varStatus="s">
			<!-- <tr class="${s.index % 2 eq 0 ? 'even':'odd'}"> -->
			<tr>
				<td>${i.showname}</td>
				<td>${i.classpropertyname}</td>
				<td>${i.unitname}</td>
				<td>
					<input type="hidden" name="id" value="${i.id}"/>
					<input type="hidden" name="projectid" value="${i.projectid}"/>
					<input type="hidden" name="modelid" value="${i.modelid}"/>
					<input type="hidden" name="location" value="${i.location}"/>
					<input type="hidden" name="classinstanceid" value="${i.classinstanceid}"/>
					<span data-op="up" class="mksjpzIcon mksjpzArrU"></span>
					<span data-op="down" class="mksjpzIcon mksjpzArrD"></span>
					<span class="mksjpzIcon mksjpzEdi circularBtn" href="#pop-ediPros"  onclick="popEditor(this,'3','E')"></span>
					<span data-op="del" class="mksjpzIcon mksjpzDel"></span>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
