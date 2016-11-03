<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script>
$(function(){
	var scrH=$(window).height()- 200;
	$(".datalist-div").css("height",scrH-17);
	if("${error}" == 'true'){
		jAlert('数据错误！');
		$('.datalist thead td:eq(1)').remove();
		$('.datalist tfoot').empty().hide();
		$('#exportExcel').empty().hide();
		$('#content1').css("display","none");
	}else
	if("${noDatas}" == 'true'){
		jAlert('查无相关数据！');
		$('.datalist thead td:eq(1)').remove();
		$('.datalist tfoot').empty().hide();
		$('#exportExcel').empty().hide();
		$('#content1').css("display","none");
	}else{
		$('#content1').css("display","block");
	}
	$("tbody td span").each(function(){
		$(this).text($(this).text().trim());
	})
})
</script>
<div class="datalist-div datalist-inner-cost" style="overflow-y: auto;" id="content1">
	<table class="datalist datalist2">
		<thead>
			<tr>
				<td>时间</td>
				<%--<td>${vo.usedProperty.classpropertyname }(${vo.useUnitname})</td> --%>
				<td>${vo.costProperty.classpropertyname }(${vo.costUnitname})</td>
			</tr>
		</thead>
		<tbody>
		
			<c:forEach items="${vo.datas}" var="d" varStatus="s">
				<tr class="${s.index % 2 eq 0 ? 'even':'odd' }">
					<td>
						<c:choose>
							<c:when test="${type eq '0'}">${fn:substring(d.rectime, 0, 16)}</c:when>
							<c:when test="${type eq '1'}">${fn:substring(d.rectime, 0, 10)}</c:when>
							<c:otherwise>${fn:substring(d.rectime, 0, 7)}</c:otherwise>
						</c:choose>
					</td>
					<%-- 
					<td style="color: #000;">
						<c:choose>
							<c:when test="${d.useData == null}">-</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${d.useData }" pattern=",###.##"/>
								<c:set var="useTotal" value="${useTotal + d.useData }"/>
							</c:otherwise>
						</c:choose>	
					</td>--%>
					<td style="color: #000;">
						<span class="ellipsis w75 dinlineblock tright por3" title="${d.costData }">
							<c:choose>
								<c:when test="${d.costData == null or d.costData == '-99999'}">-</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${d.costData}" pattern=",###.##"/>
									<c:set var="costTotal" value="${costTotal + d.costData }"/>
								</c:otherwise>
							</c:choose>
						</span>
					</td>
				</tr>
				
				
			</c:forEach>
			<tfoot>
				<tr>
					<td class="f-songti">总计</td>
					<%-- 
					<td>
						<c:choose>
							<c:when test="${useTotal == null}">-</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${useTotal}" pattern=",###.##"/>
							</c:otherwise>
						</c:choose>
					</td>--%>
					<td>
						<span class="ellipsis w75 dinlineblock tright por3">
							<c:choose>
								<c:when test="${costTotal == null}">-</c:when>
								<c:otherwise>
									<fmt:formatNumber value="${costTotal}" pattern=",###.##"/>
								</c:otherwise>
							</c:choose>
						</span>
					</td>
				</tr>
			</tfoot>
		</tbody>
	</table>
</div>