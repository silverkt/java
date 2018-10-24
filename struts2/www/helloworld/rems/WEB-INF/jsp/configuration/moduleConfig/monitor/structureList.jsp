<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<input type="hidden" id="count1" value="${count1 }"/>
<table id="sTab">
	<thead>
		<tr>
            <th>序号</th>
            <th>主设备</th>
            <th>主属性</th>
            <th>子设备</th>
            <th>子属性</th>
            <th>操作</th>
        </tr>
	</thead>
	<tbody>
	    <c:forEach var="i" items="${pager1.datas}" varStatus="c">
	       <tr>
	           <td>${c.index+1 }</td>
	           <td>${i[1] }</td>
	           <td>${i[3] }</td>
	           <td>${i[5] }</td>
	           <td>${i[7] }</td>
	           <td>
	               <span val="${i[0] }" href="#nyjgfj" class="mksjpzIcon mksjpzEdi fancybox"></span>
	               <span val="${i[0] }" class="mksjpzIcon mksjpzDel"></span>
	           </td>
	       </tr>
	    </c:forEach>
	</tbody>
</table>

<%--
<table id="sTab">
	<thead>
		<tr>
            <th>序号</th>
            <th>主设备</th>
            <th>主属性</th>
            <th>子设备</th>
            <th>子属性</th>
            <th>操作</th>
        </tr>
	</thead>
	<tbody>
	    <c:forEach var="i" items="${structureList}" varStatus="c">
	       <tr>
	           <td>${c.index+1 }</td>
	           <td>${i.fclassinstancename }</td>
	           <td>${i.fclasspropertyname }</td>
	           <td>${i.sclassinstancename }</td>
	           <td>${i.sclasspropertyname }</td>
	           <td>
	               <span val="${i.id }" href="#nyjgfj" class="mksjpzIcon mksjpzEdi fancybox"></span>
	               <span val="${i.id }" class="mksjpzIcon mksjpzDel"></span>
	           </td>
	       </tr>
	    </c:forEach>
	</tbody>
</table>
 --%>
