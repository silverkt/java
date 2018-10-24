﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<style>
	.datalist thead td.higher{height:70px;background-size:100% 100%;}
</style>
<script type="text/javascript">
	//生成曲线图
	function charsImg(classpropertyid, name, type) {
		$("#classpropertyid_qu").val(classpropertyid);
		var instidId = $("#instidId").val();
		//var smins1id = $("#smins1id").val();
		//var smins2id = $("#smins2id").val();
		//var emins1id = $("#emins1id").val();
		//var emins2id = $("#emins2id").val();
		var sdayid = $("#sdayid").val();
		var edayid = $("#edayid").val();
		var smonthsid = $("#smonthsid").val();
		var emonthsid = $("#emonthsid").val();
		var syearid = $("#syearsid").val();
		var eyearid = $("#eyearsid").val();
		var timeradio = $("input[name='timeradio']:checked").val();
		var radioClasspropertyname = $(
				"input[name='radioClasspropertyname']:checked").val();
		$("#pop-ontime .bd").empty();
		popFancybox();
		$("#pop-ontime .hd h2").html(name);
		var data = {
				instid : instidId,
				sday : sdayid,
				eday : edayid,
				smonths : smonthsid,
				emonths : emonthsid,
				syear : syearid,
				eyear : eyearid,
				timeradio : timeradio,
				radioClasspropertyname : radioClasspropertyname
			};
		//console.log(data);
		$.ajax({
			type : "POST",
			data :data ,
			url : "<c:url value='/analyse/chartimg' />/" + type
					+ "?classpropertyid=" + classpropertyid + "&projectId="
					+ projectId,
			success : function(data) {
				$('#pop-ontime').parent().css({"min-height":"310px",'height':'auto'});
				$("#pop-ontime .bd").html(data);
			},error:function(){
			 $("#pop-ontime .bd").html("数据出错");
		
			}
		});
	}
	//生成饼状图
	function charsImgPie(datatime, timeradio) {
		var temp="";
		if(timeradio=="mons"){temp=datatime.substring(0,7);}
		else if(timeradio=="years"){ temp=datatime.substring(0,4);}
		else temp=datatime.substring(0,11);
		$("#pop-ontime2 h2").empty().append(temp+" 系统能效饼图分析");
		$("#pop-ontime2 .bd").empty();
		var projectid = $("#projectId").val(), property = "${property}";
		popFancybox();
		$.ajax({
			type : "POST",
			data : {
				"datatime" : datatime,
				"projectid" : projectid,
				"timeradio" : timeradio,
				property : property
			},
			url : "<c:url value='/analyse/chartimgpie' />",
			success : function(data) {
				
				$("#pop-ontime2 .bd").html(data);
			},error:function(){
			 $("#pop-ontime2 .bd").html("数据出错");
		
			}
		});
	}
	$(function() {
		$(".temp")
				.click(
						function() {
							$("#pop-ontime1 .bd").empty();
							var date = $(this).parent().find("span").text();
							$("#pop-ontime1").find("h2").html(date);
							var instance = $("#instidId").val(), pid = projectId, timeradio = $(
									"input[name='timeradio']:checked").val(), property = "${property}";
							$.ajax({
										type : "POST",
										data : {
											"date" : date,
											"instance" : instance,
											"timeradio" : timeradio,
											"pid" : pid,
											"property" : property
										},
										url : "<c:url value='/analyse/chartTable' />?_="
												+ new Date().getTime(),
										success : function(data) {
										 
									//	$("#pop-ontime1 .bd").html("数据出错");
									$("#pop-ontime1 .bd").html(data);
										},error:function(){
			 $("#pop-ontime1 .bd").html("数据出错");
		
			}
									});
						})
	})
</script>
<div class="">
	<div class="datalist-div">
		<input type="hidden" id="countPageId" value="${countPage }">
		<table class="datalist">
			<thead>
				<tr>
					<td class="higher">日期</td>
					<c:forEach var="tl" items="${trList}" varStatus="s">
						<td class="higher">${tl.classpropertyname } <c:if test="${type ne 0 }">
								<c:if test="${dataContentList ne null}">
								<i class="ico ico-hd fancybox" href="#pop-ontime"
									onclick="charsImg('${tl.classpropertyid }','${tl.classpropertyname }',0);"></i></c:if>
							</c:if> <c:if test="${type eq 0 && s.last}">
								<c:if test="${not empty dataContentList}">
									<i class="ico ico-hd fancybox" href="#pop-ontime"
										onclick="charsImg('${tl.classpropertyid }','${tl.classpropertyname }',1);"></i>
								</c:if>
							</c:if> <i class="unit">${tl.unitname }</i></td>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dt" items="${dataContentList}" varStatus="s">
					<tr class="${s.index%2 eq 0 ? 'even' : 'odd'}">
						<c:if test="${not empty dt.data1 }">
							<td><c:if test="${type eq 1}">
									<i class="ico-time fancybox"
										onclick="charsImgPie('${dt.data1 }','${timeradio}');"
										href="#pop-ontime2"></i>
								</c:if> <c:if test="${type eq 0 && flag eq 1}">
									<i class="temp ico-time fancybox" href="#pop-ontime1"></i>
								</c:if> <span>
								<c:choose>
									<c:when test="${timeradio eq 'days'}">${fn:substring(dt.data1, 0, 10)}</c:when>
									<c:when test="${timeradio eq 'mons'}">${fn:substring(dt.data1, 0, 7)}</c:when>
									<c:otherwise>${fn:substring(dt.data1, 0, 4)}</c:otherwise>
								</c:choose>
								</span></td>
						</c:if>
						<c:if test="${not empty dt.data2 }">
							<c:set var="data2" value="${data2+dt.data2}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data2 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data2}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<c:if test="${not empty dt.data3 }">
							<c:set var="data3" value="${data3+dt.data3}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data3 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data3}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<c:if test="${not empty dt.data4 }">
							<c:set var="data4" value="${data4+dt.data4}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data4 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data4}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<c:if test="${not empty dt.data5 }">
							<c:set var="data5" value="${data5+dt.data5}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data5 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data5}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<c:if test="${not empty dt.data6 }">
							<c:set var="data6" value="${data6+dt.data6}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data6 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data6}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<c:if test="${not empty dt.data7 }">
							<c:set var="data7" value="${data7+dt.data7}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data7 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data7}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<c:if test="${not empty dt.data8 }">
							<c:set var="data8" value="${data8+dt.data8}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data8 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data8}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<c:if test="${not empty dt.data9 }">
							<c:set var="data9" value="${data9+dt.data9}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data9 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data9}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<c:if test="${not empty dt.data10 }">
							<c:set var="data10" value="${data10+dt.data10}"></c:set>
							<td>
							<c:choose>
								<c:when test="${dt.data10 == '-99999' }" >-</c:when>
								<c:otherwise><fmt:formatNumber value="${dt.data10}" pattern=",###.##" /></c:otherwise>
							</c:choose>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
			
			<c:if test="${not empty dataContentList && type==1&&page eq countPage}">
				<tfoot>
					<tr>
						<td class="f-songti">合计</td>
						<c:forEach var="sumv" items="${listSUM}">
							<c:if test="${not empty sumv.data1 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data1 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data1}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${not empty sumv.data2 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data2 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data2}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${not empty sumv.data3 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data3 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data3}" pattern=",###.##" /></c:otherwise>
								</c:choose>
									</td>
							</c:if>
							<c:if test="${not empty sumv.data4 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data4 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data4}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${not empty sumv.data5 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data5 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data5}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${not empty sumv.data6 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data6 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data6}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${not empty sumv.data7 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data7 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data7}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${not empty sumv.data8 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data8 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data8}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${not empty sumv.data9 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data9 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data9}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
							<c:if test="${not empty sumv.data10 }">
								<td>
								<c:choose>
									<c:when test="${sumv.data10 == '-99999' }" >-</c:when>
									<c:otherwise><fmt:formatNumber value="${sumv.data10}" pattern=",###.##" /></c:otherwise>
								</c:choose>
								</td>
							</c:if>
						</c:forEach>
					</tr>
				</tfoot>
			</c:if>
		</table>
	</div>
</div>
