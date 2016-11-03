<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(function(){
	if("${error}" == 'true'){
		jAlert('数据错误！');
		$('.datalist thead td:eq(1)').remove();
		$('.datalist tfoot').empty().hide();
		$('#exportExcel').empty().hide();
		$('#content2').css("display","none");
	}else if("${noDatas}" == 'true'){
		jAlert('查无相关数据！');
		$('.datalist thead td:eq(1)').remove();
		$('.datalist tfoot').empty().hide();
		$('#exportExcel').empty().hide();
		$('#content2').css("display","none");
	}else{
		$('#content2').css("display","block");
	}
});
</script>
<div class="datalist-div" id="content2">
	<table class="datalist datalist2">
		<thead>
			<tr>
				<td>时间</td>
				<c:forEach items="${vos}" var="vo">
					<!-- <td>${vo.usedProperty.classpropertyname } (${vo.useUnitname })</td> -->
					<td>${vo.costProperty.classpropertyname } (${vo.costUnitname })</td>
				</c:forEach>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${datas}" var="d" varStatus="s">
				<tr class="${s.index % 2 eq 0 ? 'even':'odd' }">
					<td>
						<c:choose>
							<c:when test="${type eq '0'}">${fn:substring(d.rectime, 0, 16)}</c:when>
							<c:when test="${type eq '1'}">${fn:substring(d.rectime, 0, 10)}</c:when>
							<c:otherwise>${fn:substring(d.rectime, 0, 7)}</c:otherwise>
						</c:choose>
					</td>
					<c:forEach items="${vos}" var="v">
						<!--<td style="color: #000;">${v.datas[s.index].useData }</td> -->
						<td style="color: #000;">
							<span class="ellipsis w75 dinlineblock tright por3">
								<c:choose>
								<c:when test="${empty v.datas[s.index].costData or v.datas[s.index].costData == '-99999'}">-</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${v.datas[s.index].costData}" pattern=",###.##"/>
								</c:otherwise>
								</c:choose>
							</span>
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
			<tfoot>
				<tr>
					<td class="f-songti">总计</td>
					<c:forEach items="${total}" var="d" varStatus="s">
						<td>
							<span class="ellipsis w75 dinlineblock tright por3">
							<c:choose>
								<c:when test="${d == null}">-</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${d}" pattern=",###.##"/>
								</c:otherwise>
							</c:choose>
							</span>
						</td>
					</c:forEach>
				</tr>
			</tfoot>
		</tbody>
	</table>
</div>