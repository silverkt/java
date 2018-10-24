﻿﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<script type="text/javascript">
$(function () {
        $('#containerQuxian').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: '${chartImgDate.classpropertyname}'
            },
            subtitle: {
                text: '${chartImgDate.classpropertyname}'
            },
            xAxis: {
                categories: ${categories},
            	tickInterval: ${tickInterval},
            	labels: {
			        enabled: true
			    }
            	
            },
            yAxis: {
                title: {
                    text: '${chartImgDate.classpropertyname}'
                }
            },
            tooltip:{
    			crosshairs: true,shared: true},
            series: [{
                name: '${alvo.classpropertyname}'+" ( "+'${alvo.unitname}'+" )",
                data: ${dataList},
                marker:{enabled:false}
            }]
        });
    });
    

		</script>

<div id="containerQuxian" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
