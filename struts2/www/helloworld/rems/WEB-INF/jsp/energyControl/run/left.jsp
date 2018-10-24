<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<table id="table1" class="datalist_cdb">
	<tbody>
	        <c:forEach var="c" items="${list}" varStatus="s">
		        <tr class="${s.index % 2 eq 0 ? 'even':'odd' }">
			        <td>
				        ${c.classpropertyname}
			        </td>
		        </tr>
	        </c:forEach>
	</tbody>
</table>
<table id="table2" class="datalist_cdb" style="display: none;">
	<tbody>
		<c:forEach var="c1" items="${staticList}" varStatus="s1">
			<tr class="${s1.index % 2 eq 0 ? 'even':'odd' }">
			        <td>
				        ${c1.classpropertyname}
			        </td>
		    </tr>
	   </c:forEach>
	</tbody>
</table>
