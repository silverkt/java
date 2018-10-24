﻿﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(function(){

 $("#containerPie").html("请稍候");
	$.ajax({type:"GET",url:"<c:url value='/analyse/pie/table' />?_="+new Date().getTime(),
			data:{date:"${date}",pid:"${pid}",timeradio:"${timeradio}",property:"${property}",instance:"${instance}"},
			success:function(data){
			 
			$("containerPie").empty();
			$.each(data,function(i){
	 //alert(data[i].name+"-"+data[i].y+"-"+data[i].cid+"-"+data[i].pid+"-")
			});
				var chart =new Highcharts.Chart(initpie("containerPie"));
				chart.addSeries({type:'pie',data:data});
			},error:function(){
			 $("#containerPie").html("数据出错");
		
			}
		
	});
	function initpie(container){
		return {
			chart: {renderTo:container,plotBackgroundColor: null,plotBorderWidth: null,plotShadow: false},
			title: {text: ''},
			tooltip: {pointFormat: '<b>{point.percentage:.1f}%</b>'},
			plotOptions: {
				pie: {
					events:{
						click:function(e){
							var pieCid = e.point.cid;
							var piePid = e.point.pid;
							$.ajax({global:false,type:"GET",url:"<c:url value='/analyse/pie/table/child' />?new="+new Date().getTime(),
							    data:{id:'${pid}',cid:pieCid,pid:piePid,date:'${date}',timeradio:'${timeradio}'},
								success:function(data){
									var chart =new Highcharts.Chart(initpie1("rightPie"));
									chart.addSeries({type:'pie',data:data});
								},error:function(){
			 $("#rightPie").html("数据出错");
		
			}
							})
						}
					},
					allowPointSelect: true,cursor: 'pointer',dataLabels: {enabled: true,color: '#000000', connectorColor: '#000000',format: '<b>{point.name}</b>: {point.percentage:.1f} %'}}}
		};				
	}function initpie1(container){
		return {
			chart: {renderTo:container,plotBackgroundColor: null,plotBorderWidth: null,plotShadow: false},
			title: {text: ''},
			tooltip: {pointFormat: '<b>{point.percentage:.1f}%</b>'},
			plotOptions: {
				pie: {
					events:{
						click:function(e){
							var pieCid = e.point.cid;
							var piePid = e.point.pid;
					
						}
					},
					allowPointSelect: true,cursor: 'pointer',dataLabels: {enabled: true,color: '#000000', connectorColor: '#000000',format: '<b>{point.name}</b>: {point.percentage:.1f} %'}}}
		};				
	}
})
</script>
<div style="width:880px;">
	<div id="containerPie" style="width: 363px; height:195px; margin: 0 auto;float:left;"></div>
	<div id="rightPie" style=" width:500px; height:200px;float:left;"></div>
</div>