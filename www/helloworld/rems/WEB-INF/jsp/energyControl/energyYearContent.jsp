﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<div class="">
     <div class="datalist-div">
         <table class="datalist newdatalist">
             <thead>
                 <tr>
                     <td>序号</td>
                     <td><span>名称</span></td>
                     <td>单位</td>
                     <td title="${nowtime}">本期数值</td>
                     <td title="${oldtime}">上期数值</td>
                     <td>增幅</td>

                 </tr>
             </thead>
             <tbody>
                <c:forEach var="n" items="${nergyHuanList}" varStatus="s">
					<tr class="${s.index%2 eq 0 ? 'even' : 'odd'}">
					 <td>${s.index+1}</td>
                     <td>${n.classpropertyname}</td>
                     <td>${n.unitname}</td>
                     <td>
                     	<c:choose>
	                     	<c:when test="${n.datavalue == '-' }">${n.datavalue}</c:when>
	                     	<c:otherwise><fmt:formatNumber value="${n.datavalue == '-'?0:n.datavalue}" pattern=",###.##"/></c:otherwise>
	                     </c:choose>
                     </td>
                     <td>
                     	 <c:choose>
	                     	<c:when test="${n.value == '-' }">${n.value}</c:when>
	                     	<c:otherwise><fmt:formatNumber value="${n.value=='-'?0:n.value}" pattern=",###.##"/></c:otherwise>
	                     </c:choose>
                     </td>
                     <td>
                     	<c:choose>
	                     	<c:when test="${n.add == '-' }">${n.add}</c:when>
	                     	<c:otherwise><fmt:formatNumber value="${n.add=='-'?0:n.add}" pattern=",###.##"/>%</c:otherwise>
	                     </c:choose>
                     	<i class="ico-lift ${n.differ} ml10"></i>
                     </td>
                	</tr>
			</c:forEach>
             </tbody>
         </table>
     </div>
 </div>