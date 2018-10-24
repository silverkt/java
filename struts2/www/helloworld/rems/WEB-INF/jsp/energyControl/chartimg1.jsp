﻿﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<script type="text/javascript">
$(function () {
	
	$('#containerQuxian').highcharts({
	    chart: {type: 'line'},
	    title: {text: '${chartImgDate.classpropertyname}'},
	    subtitle: {text: '${chartImgDate.classpropertyname}'},
	    xAxis: {categories: ${categories},tickInterval: ${tickInterval},labels: {enabled: true}},
	    yAxis: {title: {text: '${chartImgDate.classpropertyname}'}},
	    tooltip:{crosshairs: true,shared: true},
	    series: [{name: '${alvo.classpropertyname}'+" ( "+'${alvo.unitname}'+" )",data: ${dataList},marker:{enabled:false}}]
	});
	var categories = ${categories}
	, tickInterval = ${tickInterval}
	, series = ${dataList2};
	//console.log(categories);
	//console.log(tickInterval);
	//console.log(series);
	if(categories.length == 0 || tickInterval == null || series.length == 0){
	}else{
		$('#container2').css({'height':'200px'});
		$('#container2').highcharts({
		    chart: {type: 'line'},title:{text:""},
		    xAxis: {categories: categories,tickInterval: tickInterval,labels: {enabled: true}},
		    yAxis: {title: {text: ''}},
		    tooltip:{crosshairs: true,shared: true},
		    series: series
		});
	}
});
    

		</script>
 <div style="height:auto;">
		<div id="containerQuxian" style="min-width: 310px; height: 200px; margin: 0 auto;"></div> 
        <div id="container2" style="margin:0 auto;"></div> 
</div>