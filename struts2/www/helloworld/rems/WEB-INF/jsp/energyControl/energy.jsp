﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- 能效分析 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>远程能源管理系统</title>
<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/demo.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/pagination.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
<script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
<script src="<c:url value='/resources/js/common.js' />"></script>
<script src="<c:url value='/resources/js/my.js' />"></script>
<script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
<script src="<c:url value='/resources/js/base.js' />"></script>
<script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
<script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
<script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
<script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>
<script type="text/javascript">
var projectId = ${projectId};
$("#Pagination").hide();
$(function(){
 	var screenW=document.documentElement.clientWidth;
    var scrH=$(window).height()- 130;
	$("#energyLeftId").css("height",scrH);
	$("#dataListContentId").css("height",scrH-100);
	//加载项目列表
 	var setting = { data: {simpleData: {enable:true}}, callback: {onClick:onClick} };
 	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />?_="+new Date().getTime(),
 		success:function(data){
			$.fn.zTree.init($("#treeDemo"), setting, data);
			$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
		},error:function(){
			jAlert('加载失败！');
		}
	});
	function onClick(event,treeID,treeNode,clickFlag) {
		if(treeNode.isParent){return};
		var parentNode = treeNode.getParentNode();
		$("#curCity").empty().append("<span>"+parentNode.getParentNode().name+"</span>-<span>"+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
		$(".area_popup").hide();
		$("#curCity").removeClass("on");
		projectId = treeNode.id;
		$("#projectId").val(projectId);
		energyLeft(treeNode.id);
		setSession(projectId);
		$("#Pagination").hide();
	}
	//还原  查看方式
	var timeradio1 = $("input[name= 'timeradio']");
	timeradio1.each(function() {
		$(this).attr("checked", false);
	});
	timeradio1.eq(0).attr("checked", true);
	//提交表单数据
	$("#dateListduId").click(function(){
		var tabchoicenow=0;
		var tabchoice = $(".left-in li" ) ;
		tabchoice .each(function(){
	        if($(this).hasClass("on")){
	        	tabchoicenow= $(this).attr("val");
	        }
   		});
	   	if (tabchoicenow==0) {
	   		var tabchoicenow1 = $("#tab1 input[name= 'indexclasspropertyid']:checked" ) ;
	   		if (!(tabchoicenow1.size() > 0)) {
	   			jAlert("请选择要查看的指标！");return;
	   		}
		}
		if (tabchoicenow == 1) {
			var tabchoicenow2 = $("#tab2 input[name= 'classpropertyname']:checked" ) ;
			if (!(tabchoicenow2.size() > 0)) {
					jAlert("请选择要查看的能效！");return;
			}
		}
		if (tabchoicenow==2) {
			var tabchoicenow3=    $ ("#tab3 input[name= 'radioClasspropertyname']:checked" ) ;
			if (!(tabchoicenow3.size() > 0)) {
					jAlert("请选择要查看的设备！");return;
			}
		}
		$('#tabCode').val(tabchoicenow);
		var timechoice = $("input[name= 'timeradio']:checked" ) ;
		var timechoiceval = timechoice.val();
		if (timechoiceval.localeCompare("days") == 0) {
			var d1=$("#sdayid").val();
			var d2=$("#edayid").val();
			if (d1.localeCompare(d2)>0) {
				jAlert("时间范围错误，请重新修改！");
				return;
			}
		}
		if (timechoiceval.localeCompare("mons") == 0) {
			var m1=$("#smonthsid").val();
			var m2=$("#emonthsid").val();
			if (m1.localeCompare(m2)>0) {
				jAlert("时间范围错误，请重新修改！");
				return;
			}
		}
		if (timechoiceval.localeCompare("years") == 0) {
			var y1=$("#syearsid").val();
			var y2=$("#eyearsid").val();
			if (y1.localeCompare(y2)>0) {
		 		jAlert("时间范围错误，请重新修改！");
				return;
			}
		}
		$("#Pagination").hide();
		$("#dataListContentId").empty();
		var url = "<c:url value='/analyse/energyContent/' />" + tabchoicenow;
		$.ajax({type:"POST",data: $("#analyseForm").serialize(),url:url+"?page="+1,
			success: function(data){
				$("#dataListContentId").empty().html(data);
				var table2=$("#dataListContentId tbody tr").size();
				if (table2==0) {
					$("#Pagination").hide();
				} else {
					initPagination();
				}
			},error:function(){
				jAlert('加载失败！');
			}
		});
	});
});
	function setSession(pid){
		$.ajax({type:"GET",url:"<c:url value='/analyse/run/session' />?date="+new Date().getTime(),data:{pid:pid}});
	}
	function getType(){
		return $(".on","#energyLeftId").attr("val");
	}
	//异步查询左侧标签
	function energyLeft(projectId){
		$("energyLeftId").empty();
		$.ajax({type:"POST",url: "<c:url value='/analyse/energyLeft' />",data: {id:projectId},
			success: function(data){
				$("#energyLeftId").html(data);
				//增加标签事件
				Tab();
				selectToggle();
				//清楚右侧查询内容
				$("#dataListContentId").empty();
			},error:function(){
				jAlert('加载失败！');
			}
		});
	}
	//--------------------分页开始-----------------------
	function initPagination() {
		//var num_entries = $("#hiddenresult div.result").length;
		$("#Pagination").show();
		var countPage = $("#countPageId").val();
		//alert("poppppppppppp-"+countPage);
		if (countPage>1) {
			$("#Pagination").show();
		} else {
			$("#Pagination").hide();
		}
		// 创建分页
		$("#Pagination").pagination(countPage, {
			num_edge_entries: 1, //边缘页数
			num_display_entries: 4, //主体页数
			callback: pageselectCallback,
			items_per_page: 1, //每页显示1项
			prev_text: "上一页",
			next_text: "下一页"
		});
	}
	function pageselectCallback(page_index, jq){
		//var new_content = $("#hiddenresult div.result:eq("+page_index+")").clone();
		var data = $('#analyseForm').serialize()
		, tCode = $('#tabCode').val()
		, url = "<c:url value='/analyse/energyContent/' />" + tCode;
		$.ajax({type:"GET",url:url+"?page="+(page_index+1),data: data,
			success:function(data){
				$("#dataListContentId").empty().html(data);
			},error:function(){
				jAlert('刷新失败！');
			}
		});
		return false;
	}
	function getData(container,tCode){
				var $container = $(container)
				, $tab = $('#tab'+(parseInt(tCode)+1))
				, dates = '';
				var data={};
				$container.find('input').each(function(n,input){
					var $input = $(input)
					, name = $input.attr('name')
					, type = $input.attr('type')
					, value = $input.val();
					if(type != 'radio'){
						data[name] = value;
					}else{
						var chk = $input.prop('checked');
						if(chk==true){
							data[name] = value;
						}
					}
				});
				//处理日期参数
				$container.find("input[name='date']").each(function(n,input){
					var $date = $(input)
					, value = $date.val()
					dates += value+',';
				});
				dates = dates.substring(0,dates.length-1);
				data['date'] = (dates);
				console.log(data);
				return data;
			}
		//--------------------分页结束-----------------------
</script>
	</head>
	<body>
		<jsp:include page="../header.jsp"></jsp:include>
		<div class="nav-nav clear">
			<div class="sel_nav ml10">
				<a title="" data-target=".area_popup" class="curcity-expand showdiv"
					id="curCity"><span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span>
				</a>
			</div>
		</div>
		<form id="analyseForm" action="/analyse/energyContent" method="post">
			<input type="hidden" id="projectId" name="projectId"
				value="${projectId}" />
			<input type="hidden" id="classpropertyid_qu" value="">
			<div id="container" class="AllCol">
				<div id="LeftCol" class="LeftCol">
					<div id="energyLeftId" class="left-nav left-nav3 tab">
						<input type="hidden" id="instidId" name="instid" value="${instid}" />
						<div class="left-in">
							<div class="tab-nav">
								<ul>
									<li val="0" class="on active"> <a>系统指标</a> </li>
									<li val="1" class=""> <a>系统能效</a> </li>
									<li val="2" class="last"> <a>设备能效</a> </li>
								</ul>
							</div>
							<div id="tab1" class="tab-panel" style="display: block;">
								<c:if test="${not empty energyList_4}">
									<div class="nyfx-item select-item">
										<div class="item-tit">
											<label> 指标 </label>
										</div>
										<div class="item-txt">
											<c:forEach var="energyList_4" items="${energyList_4}">
												<p>
													<label>
														<input name="indexclasspropertyid" value="${energyList_4.classpropertyid}" type="radio" />
														${energyList_4.classpropertyname}
													</label>
												</p>
											</c:forEach>
										</div>
									</div>
								</c:if>
							</div>
							<div id="tab2" class="tab-panel" style="display: none;">
								<c:if test="${not empty energyList_1}">
									<div class="nyfx-item select-item">
										<div class="item-tit">
											<label>
												<input type="checkbox" class="selectToggle">
												耗能
											</label>
										</div>
										<div class="item-txt">
											<c:forEach var="energyList_1" items="${energyList_1}">
												<p>
													<label>
														<input name="classpropertyname"
															value="${energyList_1.classpropertyid}" type="checkbox" />
														${energyList_1.classpropertyname}
													</label>
												</p>
											</c:forEach>
										</div>
									</div>
								</c:if>
								<c:if test="${not empty energyList_2}">
									<div class="nyfx-item select-item">
										<div class="item-tit">
											<label>
												<input type="checkbox" class="selectToggle">
												供能
											</label>
										</div>
										<div class="item-txt">
											<c:forEach var="energyList_2" items="${energyList_2}">
												<p>
													<label>
														<input name="classpropertyname"
															value="${energyList_2.classpropertyid}" type="checkbox" />
														${energyList_2.classpropertyname}
													</label>
												</p>
											</c:forEach>
										</div>
									</div>
								</c:if>
								<%--  <c:if test="${not empty energyList_3}">
                        <div class="nyfx-item select-item">
                            <div class="item-tit" >
                                <label>
                                    <input type="checkbox" class="selectToggle">运行效率</label>
                            </div>
                            <div class="item-txt" >
                                <c:forEach var="energyList_3" items="${energyList_3}">
									<p>
										<label>
											<input  name="classpropertyname" value="${energyList_3.classpropertyid}" type="checkbox" />
											${energyList_3.classpropertyname}
										</label>
									</p>
								</c:forEach>
                            </div>
                        </div>
                        </c:if>--%>
							</div>
							<div id="tab3" class="tab-panel" style="display: none;">

								<c:if test="${not empty energyList_5}">
									<div class="nyfx-item">
										<div class="item-txt"
											style="margin-left: 7px; padding-left: 0;">
											<c:forEach var="energyList_5" items="${energyList_5}">
												<p>
													<label>
														<input style="margin-right: 1px;"
															name="radioClasspropertyname"
															value="${energyList_5.classinstanceid}" type="radio" />
														${energyList_5.classinstancename}
													</label>
												</p>
											</c:forEach>
										</div>
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
				<div id="MainCol" class="MainCol">
					<div id="folderBtn" class="icoLeft"></div>
					<div class="content">
						<div class="topFilter tab">
							<table class="putform">
								<tbody>
									<tr>
										<td class="tleft w60"> 查看方式： </td>
										<td class="tleft w120">
											<div class="tab-nav">
												<ul class="fiterTime">
													<li class="">
														<label>
															<input type="radio" name="timeradio" value="days" checked="checked">天
														</label>
													</li>
													<li class="">
														<label>
															<input type="radio" name="timeradio" value="mons">月 
														</label>
													</li>
													<li class="">
														<label>
															<input type="radio" name="timeradio" value="years">年
														</label>
													</li>
												</ul>
											</div>
										</td>
										<td class="w60">
											<span class="">时间范围：</span>
										</td>
										<td class="tleft">
											<%--<div class="fl tab-panel" style="display: block;">
                                    <input name="smins1" id="smins1id" type="text" value="${yDay}" class="Wdate itxt w80" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'emins1id\')}'})" autocomplete="off" />
                                    <input name="smins2" id="smins2id" type="text" value="0:00" class="Wdate itxt w60 ml10 WdateHour" onfocus="WdatePicker({dateFmt:'H:00',maxDate:'#F{$dp.$D(\'emins2id\')}'})" autocomplete="off" />
                                    <span class="ml5 mr5">到</span>
                                    <input name="emins1" id="emins1id" type="text" value="${curDay}" class="Wdate itxt w80" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'smins1id\')}'})" autocomplete="off" />
                                    <input name="emins2" id="emins2id" type="text" value="23:59" class="Wdate itxt w60 ml10 WdateHour" onfocus="WdatePicker({dateFmt:'H:00',minDate:'#F{$dp.$D(\'smins2id\')}'})" autocomplete="off" />
                                </div>
                                --%>
											<div class="fl tab-panel" style="display: block;">
												<input name="sday" id="sdayid" type="text" value="${yDay}"
													class="Wdate itxt w80"
													onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'edayid\')}'})"
													autocomplete="off" />
												<span class="ml5 mr5">到</span>
												<input name="eday" id="edayid" type="text" value="${curDay}"
													class="Wdate itxt w80"
													onfocus="WdatePicker({minDate:'#F{$dp.$D(\'sdayid\')}'})"
													autocomplete="off" />
											</div>
											<div class="fl tab-panel" style="">
												<input name="smonths" id="smonthsid" type="text"
													value="${yMon}" class="Wdate itxt w80"
													onfocus="WdatePicker({dateFmt:'yyyy-MM'})"
													autocomplete="off" />
												<span class="ml5 mr5">到</span>
												<input name="emonths" id="emonthsid" type="text"
													value="${curMon}" class="Wdate itxt w80"
													onfocus="WdatePicker({dateFmt:'yyyy-MM'})"
													autocomplete="off" />
											</div>
											<div class="fl tab-panel" style="">
												<input name="syear" id="syearsid" type="text"
													value="${curYear}" class="Wdate itxt w80"
													onfocus="WdatePicker({dateFmt:'yyyy'})" autocomplete="off" />
												<span class="ml5 mr5">到</span>
												<input name="eyear" id="eyearsid" type="text"
													value="${curYear}" class="Wdate itxt w80"
													onfocus="WdatePicker({dateFmt:'yyyy'})" autocomplete="off" />
											</div>
											<a id="dateListduId" class="viewbtn2 ml20" style="margin-top: 3px;">查看数据</a>
											<input type="hidden" id="tabCode"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="wrap wrap-energy">
							<div id="dataListContentId" class="datalist-content-energy"
								style="overflow-y: auto;"></div>
							<div class="page mt10">
								<div id="Pagination" class="pagination"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div class="area_popup">
			<div class="datalist-div" style="padding-bottom: 0px;">
				<div class="area-tit">
					<a class="smalllogo"></a>
				</div>
				<ul id="treeDemo" class="ztree"></ul>
			</div>
		</div>
		<div class="mod-pop" id="pop-ontime" style="border:none;">
			<div class="hd">
				<h2></h2>
			</div>
			<div class="bd" style="overflow: auto;"></div>
		</div>
		<div class="mod-pop" id="pop-ontime2" style="width: 920px;">
			<div class="hd">
				<h2></h2>
			</div>
			<div class="bd" style="height: 400px;"></div>
		</div>
		<div class="mod-pop" id="pop-ontime1" style="width: 900px;">
			<div class="hd">
				<h2></h2>
			</div>
			<div class="bd" style="height: 240px;"></div>
		</div>
	</body>
</html>
