<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<input type="hidden" id="count" value="${count }"/>
<table id="rTab">
	<thead>
		<tr>
			<th>序号</th>
			<th>能源属性</th>
			<th>换算系数</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
	    <c:forEach var="i" items="${pager.datas}" varStatus="c">
	       <tr>
	           <td>${c.index+1 }</td>
	           <td>${i[5] }</td>
	           <td>${i[4] }</td>
	           <td>
	               <span val="${i[0] }" href="#hsxs" class="mksjpzIcon mksjpzEdi fancybox"></span>
	               <span val="${i[0] }" class="mksjpzIcon mksjpzDel"></span>
	           </td>
	       </tr>
	    </c:forEach>
	</tbody>
</table>
<%--
<table id="rTab">
	<thead>
		<tr>
			<th>序号</th>
			<th>能源属性</th>
			<th>换算系数</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
	    <c:forEach var="i" items="${rationalList}" varStatus="c">
	       <tr>
	           <td>${c.index+1 }</td>
	           <td>${i.classpropertyname }</td>
	           <td>${i.ratio }</td>
	           <td>
	               <span val="${i.id }" href="#hsxs" class="mksjpzIcon mksjpzEdi fancybox"></span>
	               <span val="${i.id }" class="mksjpzIcon mksjpzDel"></span>
	           </td>
	       </tr>
	    </c:forEach>
	</tbody>
</table>
 --%>
