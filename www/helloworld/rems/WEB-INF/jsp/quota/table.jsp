<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<table class="datalist nxfx_sbnx datalist2" id="#limitTable">
		<thead>
			<tr>
				<td>月份</td><td>月指标</td><td>实际用量</td><td>差额</td><td>月预警</td><td>月报警</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${month}" var="m" varStatus="s">
				<tr class="${s.index % 2 == 0 ? 'even':'odd' }">
					<td>${m.bigMonth }</td>
					<c:choose>
						<c:when test="${!empty cm && m.month >= cm  }">
							<input type="hidden" name="idnum" value="${m.idnum}"/>
							<input type="hidden" name="period" value="${m.period}"/>
							<td><input class="monIndex txttblval" mid="${m.month }" name="limitvalue" value="${m.limitvalue }" /></td>
							<td>${m.datavalue }</td>
							<td><fmt:formatNumber type="number" pattern="#.##">${m.limitvalue - m.datavalue  }</fmt:formatNumber></td>
							<td><input class="monYuj txttblval" name="prewarnvalue" value="${m.prewarnvalue }" /></td>
							<td><input class="monBaoj txttblval" name="warnvalue" value="${m.warnvalue }" /></td>
						</c:when>
						<c:otherwise>
							<td>${m.limitvalue }</td>
							<td>${m.datavalue }</td>
							<td><fmt:formatNumber type="number" pattern="#.##">${m.limitvalue - m.datavalue  }</fmt:formatNumber></td>
							<td>${m.prewarnvalue }</td>
							<td>${m.warnvalue }</td>
							<c:set var="totalReadonly" value="${totalReadonly + m.limitvalue }"/>
						</c:otherwise>
					</c:choose>
					<c:set var="totalNnumber" value="${totalNnumber + m.limitvalue }"/>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td class="f-songti">
					<input id="totalReadonlyTag" type="hidden" value="${totalReadonly }"/>
					<span class="tfoottit">月指标合计:<span id="monIndexSum">${totalNnumber}</span></span>
				</td>
				<td colspan="5" style="text-align: left;">
					<span class="tfootval">差值：
						<font style="color: #e65b30; font-size: 14px;"><span id="chazhiValue">${year.limitvalue - totalNnumber}</span></font>
					</span>
					<span style="margin-left: 20px; color: #777778; font-size: 12px;">注：差值 = 年度指标 - 月指标合计</span>
				</td>
			</tr>
		</tfoot>
	</table>