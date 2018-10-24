﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(function () {
    //var scrH=$(window).height()- 190;
	//$("#energyYearCont").css("height",scrH);
    $('#energyYearCont').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories:
                ${categories}
         
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        exporting: {
            enabled: false
        },
        series: ${series}
    });
});				
</script>

<div style="min-width: 310px; height: 400px; margin: 0 auto;border:1px solid #E5E5E5;">
      <div style="width:100%;height:30px;line-height:30px; background:url(<c:url value='/resources/img/datalist-thbg2.png'/>) repeat-x scroll left top ;">
	          <span style="float:left;margin:0 0 0 15px;">同比柱状图分析</span>
	  </div>
      <div  id="energyYearCont">
	  </div>
</div>
