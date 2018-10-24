﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!-- 环比分析 -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>远程能源管理系统</title>
		<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/demo.css'/>" rel="stylesheet" />
		<link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
		<script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
		<script src="<c:url value='/resources/js/common.js' />"></script>
		<script src="<c:url value='/resources/js/my.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
		<script src="<c:url value='/resources/js/base.js' />"></script>
		<script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
		<script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
		<script src="<c:url value='/resources/js/Highcharts-4.0.1/exporting.js' />"></script>

<script type="text/javascript">
$(document).ready(function () {
	var timeradio1 =$ ("input[name= 'timeradio']" ) ;
	//alert("pppppp-"+timeradio1.size());
	timeradio1.each(function(){
		$(this).attr("checked",false);
	});
	timeradio1.eq(0).attr("checked",true);
	$("#excelHuanId").css("display","none");
});
$(function(){
	var scrH=$(window).height()- 130;
	$("#energyLeftId").css("height",scrH);
	$("#dataListContentId").css("height",scrH-60);
	var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}};
	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />",
		success:function(data){
			$.fn.zTree.init($("#treeDemo"), setting, data);
			$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
		},error:function(){
			jAlert('加载失败!');
		}
	});
	function onClick(event,treeID,treeNode,clickFlag) {
		if(treeNode.isParent){return};
		var parentNode = treeNode.getParentNode();
		$("#curCity").empty().append("<span>"+parentNode.getParentNode().name+"</span>-<span>"+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
		$(".area_popup").hide();
		$("#curCity").removeClass("on");
		energyLeft(treeNode.id);
		setSession(treeNode.id);
		$("#fnzname").attr("value",parentNode.getParentNode().name+"-"+parentNode.name+"-"+treeNode.name);
	}
	function setSession(pid){
		$.ajax({type:"GET",url:"<c:url value='/analyse/run/session' />?date="+new Date().getTime(),data:{pid:pid}});
	}
	//提交表单数据生成列表
	$("#dateListduId").click(function(){
		var type = $('.tab-nav .on','#energyLeftId').attr('val')
		, $tab;
		//add by Y 2015-01-15 新增判断  begine
		switch(type){
			case '0': $tab = $("#tab1 input[name= 'classpropertyname']:checked" ) ; break;
			case '1': $tab = $("#tab2 input[name= 'classpropertyname']:checked" ) ; break;
			case '2': $tab = $("#tab3 input[name= 'radioClasspropertyname']:checked" ) ; break;
		}
		if($tab.size() == 0){
			jAlert("请勾选环比参数！");
			return false;
		}
		//add by Y 2015-01-15 新增判断  end
		$("#excelHuanId").css("display","block");
		var analyseData = getData($("#analyseForm"),type);
		$.ajax({ type:"POST",cache:false,data: analyseData,//$("#analyseForm").serialize(),
			url: "<c:url value='/analyse/energyHuanContent' />",
			success: function(data){
				$("#dataListContentId").empty().html(data);
				$("#excelHuanId").css("display","block");
			},error:function(){
				jAlert('加载失败!');
			}
		});
	});
	
	//提交表单数据生成柱状图
	$("#dateZhuId").click(function(){
		$("#excelHuanId").css("display","none");
		$.ajax({ type:"POST",data: $("#analyseForm").serialize(),
			url: "<c:url value='/analyse/energyHuanZhu' />",
			success: function(data){
				$("#dataListContentId").empty().html(data);
				$("#excelHuanId").css("display","none");
			},error:function(){
				jAlert('加载失败!');
			}
		});
	});
	//导出 -wq
	$('#excelHuanId').click(function(){
		var type = $('.tab-nav .on','#energyLeftId').attr('val')
		, linameText =  $('.tab-nav .on','#energyLeftId').find('> a').text()
		, $tab;
		//add by Y 2015-01-15 新增判断  begine
		switch(type){
			case '0': $tab = $("#tab1 input[name= 'classpropertyname']:checked" ) ; break;
			case '1': $tab = $("#tab2 input[name= 'classpropertyname']:checked" ) ; break;
			case '2': $tab = $("#tab3 input[name= 'radioClasspropertyname']:checked" ); break;
		}
		if(type == '2' || type == 2){
			linameText += "_"+$tab.parent().text().trim();
		}
		$("#liname").attr("value",linameText);
		if($tab.size() == 0){
			jAlert("提醒:先选择要查看的指标或设备，请重新选择！");
			return false;
		}
		var timechoice = $("input[name= 'timeradio']:checked" ) ;
		var timechoiceval= timechoice   .val();
		if (timechoiceval.localeCompare("days") == 0) {
			var d1=$("input[name= 'sday']").val();
			$("#linametime").attr("value",d1);
		} else  if (timechoiceval.localeCompare("mons") == 0) {
			var m1=$("input[name= 'smonth']").val();
			$("#linametime").attr("value",m1);
		} else {
			jAlert("时间范围，请重新选择！");return false;
		}
		//add by Y 2015-01-15 新增判断  end
		$("#excelHuanId").css("display","block");
		var analyseData = getData($("#analyseForm"),type);
		$.simDownload("<c:url value='/analyse/energyHuanExport' />",analyseData,'post');
	});
	//导出
	/*$("#excelHuanId").click(function(){
		if (!validdata()) {
			return; 
		}
		var url="<c:url value='/analyse/energyHuanExport' />";
		$("#analyseForm").attr("action",url);
		$("#analyseForm").submit();
	});
	*/
	
	function validdata(){
		var tabchoicenow=0;
		var tabchoice = $(".left-in li");
		tabchoice .each(function(){
			if($(this).hasClass("on")){
				tabchoicenow= $(this).attr("val");
			} else {
				
			}
		});
		
		$("#liname").attr("value",tabchoice.eq(tabchoicenow).text() );
		if (tabchoicenow==0) {
			var tabchoicenow1 = $("#tab1 input[name= 'classpropertyname']:checked" );
			if (tabchoicenow1.size()>0) {
				
			} else {
				jAlert("提醒:先选择要查看的指标或设备，请重新选择！");return false;
			}
		} else {
			
		}
		if (tabchoicenow==1) {
			var tabchoicenow2 = $("#tab2 input[name= 'classpropertyname']:checked" ) ;
			if (tabchoicenow2.size()>0) {
				
			} else {
				jAlert("提醒:先选择要查看的指标或设备，请重新选择！");return false;
			}
		} else {
			
		}
		
		if (tabchoicenow==2) {
			var tabchoicenow3 = $("#tab3 input[name= 'radioClasspropertyname']:checked" ) ;
			if (tabchoicenow3.size()>0) {
				
			} else {
				jAlert("提醒:先选择要查看的指标或设备，请重新选择！");return false;
			} 
		} else {
				
		}
		var timechoice = $("input[name= 'timeradio']:checked" ) ;
		var timechoiceval= timechoice   .val();
		if (timechoiceval.localeCompare("days") == 0) {
			var d1=$("input[name= 'sday']").val();
			$("#linametime").attr("value",d1);
		} else  if (timechoiceval.localeCompare("mons") == 0) {
			var m1=$("input[name= 'smonth']").val();
			$("#linametime").attr("value",m1);
		} else {
			jAlert("时间范围，请重新选择！");return false;
		}
		return true;
	}
	//异步查询左侧标签
	function energyLeft(propertyid){
		$("energyLeftId").empty();
		$.ajax({ type:"POST",data: {id:propertyid},
			url: "<c:url value='/analyse/energyLeftHuan' />",
			success: function(data){
				$("#energyLeftId").html(data);
				//增加标签事件
				Tab();
				selectToggle();
				//清除右侧查询内容
				$("#dataListContentId").empty();
			},error:function(){
				jAlert('加载失败!');
			}
		});
	}
	function getData(container,tCode){
		var $container = $(container)
		, $tab = $('#tab'+(parseInt(tCode)+1))
		, data={}
		, cpnames = '';
		$container.find('input').each(function(n,input){
			var $input = $(input)
			, name = $input.attr('name')
			, type = $input.attr('type')
			, value = $input.val();
			if(name != 'classpropertyname' && name != 'radioClasspropertyname'){
				if(type == 'radio'){
					var chk = $input.prop('checked');
					if(chk==true){
						data[name] = value;
					}
				}else{
					data[name] = value;
				}
			}
		});
		//处理左侧参数
		if(tCode != 2){
			$tab.find("input[name='classpropertyname']").each(function(n,input){
				var $cpname = $(input)
				, value = $cpname.val()
				, chk = $cpname.prop('checked');
				if(chk == true){
					cpnames += value+',';
				}
			});
			cpnames = cpnames.substring(0,cpnames.length-1);
			data['classpropertyname'] = (cpnames);
		}else{
			$tab.find("input[name='radioClasspropertyname']").each(function(n,input){
				var $rad = $(input)
					, value = $rad.val()
				, chk = $rad.prop('checked');
				if(chk == true){
					data['radioClasspropertyname'] = value;
				}
			});
		}
		return data;
	}
});

</script>
	</head>
	<body>
		<jsp:include page="../header.jsp"></jsp:include>
		<div class="nav-nav clear">
			<div class="sel_nav ml10">
				<a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span></a>
			</div>
		</div>
		<form id="analyseForm" action="" method="post">
		<input type="hidden"  id="fnzname" name="fnzname" value="${pvo.regionname}-${pvo.parkname}-${pvo.projectname}"/>
		<input type="hidden" id="liname" name="liname" value=""/>
		<input type="hidden" id="linametime" name="linametime" value=""/>
		<div id="container" class="">
			<div id="LeftCol" class="LeftCol">
				<div id="energyLeftId" class="left-nav left-nav3 tab">
				<input type="hidden" name="instid" value="${instid}"/>
					<div class="left-in">
                    <div class="tab-nav">
                       <ul>
                        	<li val="0" class="on"><a>系统指标</a></li>
                            <li val="1" class=""><a>系统能效</a></li>
                            <li val="2" class="last"><a>设备能效</a></li>
                        </ul>
                    </div>
                    
                    <div id="tab1" class="tab-panel" style="display: block;">
                        <c:if test="${not empty energyList_4}">
                        <div class="nyfx-item select-item">
                            <div class="item-tit">
                                <label>
                                    <input type="checkbox" class="selectToggle">指标</label>
                            </div>
                            <div class="item-txt">
                                <c:forEach var="energyList_4" items="${energyList_4}">
									<p>
										<label>
											<input name="classpropertyname" value="${energyList_4.classpropertyid}" type="checkbox" />
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
                                    <input type="checkbox" class="selectToggle">耗能</label>
                            </div>
                            <div class="item-txt">
                                <c:forEach var="energyList_1" items="${energyList_1}">
									<p>
										<label>
											<input name="classpropertyname"  value="${energyList_1.classpropertyid}" type="checkbox" />
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
                                    <input type="checkbox" class="selectToggle">供能</label>
                            </div>
                            <div class="item-txt">
                                <c:forEach var="energyList_2" items="${energyList_2}">
									<p>
										<label>
											<input name="classpropertyname" value="${energyList_2.classpropertyid}" type="checkbox" />
											${energyList_2.classpropertyname}
										</label>
									</p>
								</c:forEach>
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${not empty energyList_3}">
                        <div class="nyfx-item select-item">
                            <div class="item-tit">
                                <label>
                                    <input type="checkbox" class="selectToggle">运行效率</label>
                            </div>
                            <div class="item-txt">
                                <c:forEach var="energyList_3" items="${energyList_3}">
									<p>
										<label>
											<input name="classpropertyname" value="${energyList_3.classpropertyid}" type="checkbox" />
											${energyList_3.classpropertyname}
										</label>
									</p>
								</c:forEach>
                            </div>
                        </div>
                        </c:if>
                    </div>
                    <div id="tab3" class="tab-panel" style="display: none;">
                    
                    <c:if test="${not empty energyList_5}">
							<div class="nyfx-item">
								<div class="item-txt" style="margin-left:7px;padding-left: 0;">
									<c:forEach var="energyList_5" items="${energyList_5}">
									<p>
										<label>
											<input name="radioClasspropertyname" value="${energyList_5.classinstanceid}" type="radio" />
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
				<div id="folderBtn" class="icoLeft">
				</div>
				<div class="content">
                <div class="topFilter tab">
                    <table class="putform">
                        <tbody><tr>
                            <td class="tleft w60">查看方式：</td>
                            <td class="tleft w100">

                                <div class="tab-nav">
                                    <ul class="fiterTime">
                                        <li>
                                            <label>
                                                <input type="radio" name="timeradio" value="days" checked="checked">天</label></li>

                                        <li>
                                            <label>
                                                <input type="radio" name="timeradio" value="mons">月</label></li>
                                    </ul>
                                </div>
                            </td>
                            <td class="w60">
                                <span class="">时间范围：</span></td>
                            <td class="tleft">
                                <div class="fl tab-panel" style="display: block;">
                                    <input type="text" name="sday" class="Wdate itxt w80" onfocus="WdatePicker()" autocomplete="off" value="${curDay}">
                                </div>
                                <div class="fl tab-panel" style="">
                                    <input name="smonth" type="text" class="Wdate itxt w80" onfocus="WdatePicker({dateFmt:'yyyy-MM'})" autocomplete="off" value="${curMonth}">
                                </div>
                               
                                <a id="dateListduId" class="viewbtn2 ml20"
										style="margin-top:2px;">查看数据</a>
                                <a id="excelHuanId" class="fr execl mt5">
                                <input type="hidden" id="tCode" />
                                <input type="hidden" id="lastData" />
                            </td>
                        </tr>
                    </tbody></table>
                </div>
                <div id="dataListContentId" class="datalist-content wrap" style="overflow-y:auto;"></div>
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
		<div class="mod-pop" id="pop-ontime">
        	<div class="hd"><h2>单击日期出现的数据表</h2></div>
        	<div class="bd"> <img src="img/sjimg.jpg" /></div>
    	</div>
	</body>
</html>
