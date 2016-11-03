<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
</script>
	<c:if test="${datatype == 0}">
		<table data-model = "homeio" data-tcode="io0">
			<thead>
				<tr>
					<th>属性显示名</th>
					<th>能源属性</th>
					<th>能源单位</th>
					<th>成本属性</th>
					<th>成本单位</th>
					<th>图片</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
					<c:forEach items="${homeiosIn}" var="i" varStatus="s">
					<!-- <tr class="${s.index % 2 eq 0 ? 'even':'odd'}"> -->
					<tr>
						<td>${i.showname}</td>
						<td>${i.energypvalue}</td>
						<td>${i.energyunit}</td>
						<td>${i.costValue}</td>
						<td>${i.costunit}</td>
                        <td><span class='${i.energyicon}  hnszArrowIcon'></span></td>
						<td>
							<input type="hidden" name="projectid" value="${i.projectid}"/>
							<input type="hidden" name="modelid" value="${i.modelid}"/>
							<c:if test="${empty i.location}">
								<input type="hidden" name="location" value="${s.index+1}"/>
							</c:if>
							<c:if test="${!empty i.location}">
								<input type="hidden" name="location" value="${i.location}"/>
							</c:if>
							<input type="hidden" name="classinstanceid" value="${i.classinstanceid}"/>
							<input type="hidden" name="iotype" value="${i.iotype}"/>
							
							<span data-op="up" class="mksjpzIcon mksjpzArrU"></span>
							<span data-op="down" class="mksjpzIcon mksjpzArrD"></span>
							<span data-op="edit" class="mksjpzIcon mksjpzEdi consBtn" href="#pop-ediCons"  onclick="popEditor(this,'1','E')"></span>
							<span data-op="del" class="mksjpzIcon mksjpzDel"></span>
						</td>
					</tr>
					</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${datatype == 1}">
		<table data-model = "homeio" data-tcode="io1">
			<thead>
				<tr>
					<th>属性显示名</th>
					<th>能源属性</th>
					<th>能源单位</th>
					<th>图片</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
					<c:forEach items="${homeiosOut}" var="i" varStatus="s">
					<!-- <tr class="${s.index % 2 eq 0 ? 'even':'odd'}"> -->
					<tr>
						<td>${i.showname}</td>
						<td>${i.energypvalue}</td>
						<td>${i.energyunit}</td>
                        <td><span class='${i.energyicon} gnszArrowIcon'></span></td>
						<td>
							<input type="hidden" name="projectid" value="${i.projectid}"/>
							<input type="hidden" name="modelid" value="${i.modelid}"/>
							<c:if test="${empty i.location}">
								<input type="hidden" name="location" value="${s.index+1}"/>
							</c:if>
							<c:if test="${!empty i.location}">
								<input type="hidden" name="location" value="${i.location}"/>
							</c:if>
							<input type="hidden" name="classinstanceid" value="${i.classinstanceid}"/>
							<input type="hidden" name="iotype" value="${i.iotype}"/>
							<span data-op="up" class="mksjpzIcon mksjpzArrU"></span>
							<span data-op="down" class="mksjpzIcon mksjpzArrD"></span>
							<span data-op="edit" class="mksjpzIcon mksjpzEdi supplyBtn" href="#pop-ediSupply"  onclick="popEditor(this,'2','E')"></span>
							<span data-op="del" class="mksjpzIcon mksjpzDel"></span>
						</td>
					</tr>
					</c:forEach>
			</tbody>
		</table>
	</c:if>
