﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(function () {
    $('#contrastLineView').highcharts({
        chart: {
            type: 'line'
        },
         credits:{enabled:false},
        title: {
            text: '曲线分析图'
        },
        xAxis: {
            categories: ${categories1},
        	//tickInterval:240
        	labels: {
			        enabled: false
			    },
	              tickWidth: 0, 
	              lineColor : '#fff'
         },
        yAxis: {
            title: {
                text: '分析对比'
            },
            //min:0
        },
        tooltip:{
			crosshairs: true,shared: true},
        series: ${series},
        plotOptions:{series:{marker:{enabled:false}}}
    });
});
</script>
<div id="contrastLineView" style="min-width: 310px; height: 500px; margin: 0 auto"></div>
