<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<table id="hp" data-val="${size}" data-model="homepage" data-tcode ="p2">
	<thead>
		<tr>
            <th>序号</th>
            <th>绑定设备名</th>
            <th>属性显示名</th>
            <th>属性名</th>
            <th>属性单位</th>
            <th>操作</th>
        </tr>
	</thead>
	<tbody>
	    <c:forEach var="i" items="${homeList}" varStatus="c">
	       <tr>
	           <td>${c.index+1 }</td>
	           <td>
	           <input type="hidden" name="classinstanceid" value="${i.classinstanceid }"/>
	           ${i.classinstancename }
	           </td>
	           <td>${i.showname }</td>
	           <td>
	           <input type="hidden" name="classpropertyid" value="${i.classpropertyid }"/>
	           ${i.classpropertyname }
	           </td>
	           <td>${i.unitname }</td>
	           <td>
	           <input type="hidden" name="id" value="${i.id }"/>
	           <input type="hidden" name="location" value="${i.location }"/>
	               <span data-op="up" class="mksjpzIcon mksjpzArrU"></span>
	               <span data-op="down" class="mksjpzIcon mksjpzArrD"></span>
                   <span val="${i.location }" href="#xzxtzb" class="mksjpzIcon mksjpzEdi fancybox"></span>
                   <span val="${i.location }" class="mksjpzIcon mksjpzDel"></span>
	           </td>
	       </tr>
	    </c:forEach>
	</tbody>
</table>