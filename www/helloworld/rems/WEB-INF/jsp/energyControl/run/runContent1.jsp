<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>


<table id="dt" class="datalist_cdb">
	<tbody>
	    
	        <c:forEach var="c" items="${lists}" varStatus="s">
		        <tr class="${s.index % 2 eq 0 ? 'even':'odd' }">
			        <td>
				        ${c.datavalue} ${c.unitname}
			        </td>
		        </tr>
	        </c:forEach>
	</tbody>
</table>
<table id="jt" class="datalist_cdb" style="display: none;">
	<tbody>

	        <c:forEach var="c1" items="${staticLists}" varStatus="s1">
		        <tr class="${s1.index % 2 eq 0 ? 'even':'odd' }">
			        <td>
				        ${c1.datavalue} ${c1.unitname}
			        </td>
		        </tr>
	        </c:forEach>
	</tbody>
</table>