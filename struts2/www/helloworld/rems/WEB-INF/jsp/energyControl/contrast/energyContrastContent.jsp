﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<script type="text/javascript">
//生成曲线图
$(function(){
	var scrH=$(window).height()- 170;
		
		$("#ovid").css("height",scrH);
})
		function charsImg(cidId,cidname){
			$("#pop-ontime .bd").empty();
			 popFancybox();
			 $("#cidId").val(cidId);
			 
			
			 $.ajax({ 
				type:"POST",
				data: $("#contrastFormId").serialize(),	
				
				url: "<c:url value='/analyseContrast/lineView?cidname='/>"+ encodeURI(encodeURI(cidname)),
				success: function(data){
					$("#pop-ontime .bd").html(data);
		      }});
		}</script>
<div id="ovid" class="datalist-div" style="border-left: none;height:100px;">
     <table class="datalist newdatalist">
         <thead>
             <tr>
                 <td>参数</td>
                  <c:forEach var="trl" items="${contrastTr}" varStatus="s">
                 	<td>${trl.projectname}</td>
                  </c:forEach>
             </tr>
         </thead>
         <tbody>
         
         <c:forEach var="ct" items="${contrastListTd}" varStatus="s">
             <tr class="${s.index%2 eq 0 ? 'even' : 'odd'}">
                 <td onclick="charsImg('${ct.classpropertyid}','${ct.classpropertyname}')"><i class="ico ico-hd fancybox" href="#pop-ontime"></i>${ct.classpropertyname}</td>
                 <c:forEach var="cl" items="${contrastList}" >
                 	<td>
                 		<c:choose>
                 			<c:when test="${empty cl[s.index].datavalue}">-</c:when>
                 			<c:otherwise><fmt:formatNumber value="${cl[s.index].datavalue}" pattern=",###.##"/></c:otherwise>
                 		</c:choose>
                     	${cl[s.index].unitname}
                    </td>
                 </c:forEach>
             </tr>
         </c:forEach>
         </tbody>
         
     </table>
 </div>
 <div class="mod-pop" id="pop-ontime">
   	<div class="hd"><h2>曲线趋势分析</h2></div>
   	<div class="bd" style="height: 500px;"></div>
</div>
