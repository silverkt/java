﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(function () {
	var colors=['#492970','#f28f43','#77a1e5','#c42525','#a6c96a','blue'];
	<c:if test="${hflag ne 1}">
	$('#containerPie1').highcharts({
        chart: { plotBackgroundColor: null,plotBorderWidth: null, plotShadow: false},
        title: {text: '耗能统计',
		        	style: {
		                fontWeight: 'bold',
		                fontSize: '13px'
		            }	
        		},
        tooltip: {pointFormat: '{series.name}: <b>{point.sy}</b>'},
        plotOptions: {
            pie: {
        	events:{
					click:function(e){
						var pieCid = e.point.cid;
						var piePid = e.point.pid;
						$.ajax({type:"GET",url:"<c:url value='/analyse/pie/child' />?new="+new Date().getTime(),
					    data:{id:${projectid},cid:pieCid,pid:piePid,date:'${datatimePie}',timeradio:'${timeradio}'},
						success:function(data){
							if(data.length==1&&data[0].y==1){
								var chart =new Highcharts.Chart(initpie("rightPie1",e.point.name," ",false,['#969696']));
								chart.addSeries({type:'pie',data:data});
							}else{
								var chart =new Highcharts.Chart(initpie("rightPie1",e.point.name,e.point.unit,true,colors));
								chart.addSeries({type:'pie',data:data});
							}
						}
					})
					}
				},
                allowPointSelect: false,cursor: 'pointer',
                dataLabels: {enabled: true,color: '#000000',connectorColor: '#000000',format: '<b>{point.name}</b>: {point.percentage:.1f} %'}
            }
        },
        series: [{type: 'pie',name: '耗能统计',data: ${dataListpie}}]
    });
    </c:if>
    <c:if test="${gflag ne 1}">
    $('#containerPie2').highcharts({
        chart: {plotBackgroundColor: null, plotBorderWidth: null,plotShadow: false},
        title: {text: '供能统计',
		        	style: {
		                fontWeight: 'bold',
		                fontSize: '13px'
		            }},
        tooltip: {pointFormat: '{series.name}: <b>{point.sy}</b>'},
        plotOptions: {
            pie: {
        	events:{
					click:function(e){
						var name=e.point.name;
						var pieCid = e.point.cid;
						var piePid = e.point.pid;
						$.ajax({type:"GET",url:"<c:url value='/analyse/pie/child' />?new="+new Date().getTime(),
					    data:{id:${projectid},cid:pieCid,pid:piePid,date:'${datatimePie}',timeradio:'${timeradio}'},
						success:function(data){
							if(data.length==1&&data[0].y==1){
								var chart =new Highcharts.Chart(initpie("rightPie2",e.point.name," ",false,['#969696']));
								chart.addSeries({type:'pie',data:data});
							}else{
								var chart =new Highcharts.Chart(initpie("rightPie2",e.point.name,e.point.unit,true,colors));
								chart.addSeries({type:'pie',data:data});
							}
							
						}
					})
					}
				},
                allowPointSelect: false,cursor: 'pointer',
                dataLabels: {enabled: true,color: '#000000',connectorColor: '#000000', format: '<b>{point.name}</b>: {point.percentage:.1f} %'}
            }
        },
        series: [{type: 'pie',name: '供能统计',data: ${dataListpie2}}]
    });
    </c:if>
    //初始化
			function initpie(container,name,unit,dataLabels,color){
				return {
					chart: {renderTo:container,plotBackgroundColor: null,plotBorderWidth: null,plotShadow: false},
					title: {text: name+"-能源结构分解",style: {fontWeight: 'bold',fontSize: '13px'}},
					colors:color,
					tooltip: {pointFormat: '<b>{point.sy}</b>'+'  <b>'+unit+'</b>'},
					plotOptions: {
						pie: {allowPointSelect: false,cursor: 'pointer',dataLabels: {enabled: dataLabels,color: '#000000', connectorColor: '#000000',format: '<b>{point.name}</b>: {point.percentage:.1f} %'}}}
				};				
			}
});
		</script>

<c:if test="${hflag ne 1}">
<div style="width:865px;">
	<div id="containerPie1" style="width: 363px; height:195px; margin: 0 auto;float:left;"></div>
	<div id="rightPie1" style=" width:500px; height:200px;float:left;"></div>
</div>
</c:if>
<c:if test="${gflag ne 1}">
<div style="width:865px;">
	<div id="containerPie2" style="width: 363px;margin-top:10px;  height:195px; margin: 0 auto;float:left;"></div>
	<div id="rightPie2" style=" width:500px; height:200px;float:left; margin-top:10px;"></div>
</div>
</c:if>