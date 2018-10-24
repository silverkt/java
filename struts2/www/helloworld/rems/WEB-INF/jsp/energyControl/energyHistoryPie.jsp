﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
var maxTempA = 0;
var maxTempB = 0;
var maxTempC = 0;
	var maxA = 0;//获取最大值
		var minA =0;//获取最小值
		var maxB = 0;//
		var minB =0;//
			var maxC =0;//
		var minC = 0;//

$(function () {
    var chart2 = $('#energyYearCont').highcharts({
        chart: {
            zoomType: 'xy'
        },
        credits:{enabled:false},
        title: {
            text: ''
        },
      
        xAxis: [{
            categories: ${categories1},
                        plotLines:[{
                color:'black',            //线的颜色，定义为红色
               // dashStyle:'longdashdot',//标示线的样式，默认是solid（实线），这里定义为长虚线
                value:-1,                //定义在那个值上显示标示线，这里是在x轴上刻度为3的值处垂直化一条线
                width:2,                //标示线的宽度，2px
            }],
            tickInterval:${tickInterval}
        }],
        yAxis: [
        	
        	<c:if test="${title1!=''}">
        		{ // Primary yAxis
		            labels: {
		                formatter: function() {
		                    return this.value;
		                },
		                style: {
		                    color: '#4572A7'
		                }
		            },
		            title: {
		                text: '${title1}',
		                style: {
		                    color: '#4572A7'
		                }
		            },
		            opposite: false,
		            plotLines:[{
		                color:'red',            //线的颜色，定义为红色
		                dashStyle:'solid',     //默认是值，这里定义为长虚线
		                value:${middle},              //定义在那个值上显示标示线，这里是在x轴上刻度为3的值处垂直化一条线
		                width:2
		            }]
		        },
        	</c:if>
		   <c:if test="${title2!=''}">
        	 { // Secondary yAxis
            gridLineWidth: 0,
            title: {
                text: '${title2}',
                style: {
                    color: '#AA4643'
                }
            },
            opposite: true,
            labels: {
                formatter: function() {
                    return this.value;
                },
                style: {
                    color: '#AA4643'
                }
            },            

        },
        </c:if>
        <c:if test="${title3!=''}">
        { // Tertiary yAxis
            gridLineWidth: 0,
            title: {
                text: '${title3}',
                style: {
                    color: '#89A54E'
                }
            },
            labels: {
                formatter: function() {
                    return this.value;
                },
                style: {
                    color: '#89A54E'
                }
            },
            opposite: true
        }
        </c:if>
        ],
        tooltip: {
            shared: true,
            crosshairs: true,
        },
        
        series: [
        	<c:if test="${title1!=''}">
	        	{
	            name: '${title1}',
	            color: '#4572A7',
	            type: 'spline',
	            yAxis: 0,
	             data: ${series1},
	        },
        	</c:if>
	        <c:if test="${title2!=''}">
	        {
	            name: '${title2}',
	            type: 'spline',
	            color: '#AA4643',
	            yAxis: 1,
	             data: ${series2},
	            marker: {
	                enabled: false
	            },
	            dashStyle: 'shortdot',
	
	        },
	        </c:if>
	        <c:if test="${title3!=''}">
	        {
	            name: '${title3}',
	            yAxis: 2,
	            color: '#89A54E',
	            type: 'spline',
	           data: ${series3},
	        }
	        </c:if>
	        ],
        
    });
    
    var chart = $("#energyYearCont").highcharts();	
    <c:if test="${title1!=''}">
    maxA = chart.yAxis[0].max;//获取最大值
	minA = chart.yAxis[0].min;//获取最小值
	 </c:if>
	 <c:if test="${title2!=''}">
	maxB = chart.yAxis[1].max;
	minB = chart.yAxis[1].min;	
	 </c:if>
	 <c:if test="${title3!=''}">
	maxC = chart.yAxis[2].max;//
	minC = chart.yAxis[2].min;//
	 </c:if>
			
});	



//曲线图Y轴按钮
function changeVal(ids,type)
{
	var chart = $("#energyYearCont").highcharts();
    if (type == "add"&&ids=="A") {
    	if (maxA==null ||minA==null) {
			return;
		}
		console.log("A+");
		console.log(maxA);
   	 	chart.yAxis[0].update({
		max:maxA+Number('${ad1}'),
		min:minA,
		});
   	    maxA +=Number('${ad1}');//获取最大值
   	 	console.log(maxA);
    }
    if(type == "min"&&ids=="A-") {
		if (maxA==null ||minA==null||maxA<=minA) {
			return;
		}
		console.log("A-");
		console.log(maxA);
   	 	chart.yAxis[0].update({
		max:maxA-Number('${ad1}'),
		min:minA,
		});
   	 	maxA -=Number('${ad1}');//获取最大值
   	 	console.log(maxA);
    }
	
	if (type == "add"&&ids=="B") {
		if (maxB==null ||minB==null) {
			return;
		}
		console.log("B+");
		console.log(maxB);
		chart.yAxis[1].update({
		max:maxB+Number('${ad2}'),
		min:minB,});
		maxB +=Number('${ad2}');//获取最大值
   	 	console.log(maxB);
    }
    if(type == "min"&&ids=="B-") {
		if (maxB==null ||minB==null|maxB<=minB) {
			return;
		}
		console.log("B-");
		console.log(maxB);
		chart.yAxis[1].update({
		max:maxB-Number('${ad2}'),
		min:minB,});
		maxB -=Number('${ad2}');//获取最大值
   	 	console.log(maxB);
    }
	
	if (type == "add"&&ids=="C") {
		if (maxC==null ||minC==null) {
			return;
		}
		console.log("C+");
		console.log(maxC);
		chart.yAxis[2].update({
		max:maxC+Number('${ad3}'),
		min:minC,});
		maxC +=Number('${ad3}');//获取最大值
   	 	console.log(maxC);
    }
    if (type == "min"&&ids=="C-")  {
		//maxC = chart.yAxis[2].max;//
		//minC = chart.yAxis[2].min;//
		 if (maxC==null ||minC==null||maxC<=minC) {
			return;
		}
		console.log("C-");
		console.log(maxC);
		chart.yAxis[2].update({
		max:maxC-Number('${ad3}'),
		min:minC,});
		maxC -=Number('${ad3}');//获取最大值
   	 	console.log(maxC);
    }
}
</script>
<style>
    .datalist tbody tr:hover td {
        background:white;
    }
</style>

<div class="datalist-div">
    <table class="datalist datalistSec nxfx_xtzb">
        <thead>
            <tr>
                <td class="tleft pl20">已选运行参数曲线示例</td>
            </tr>
        </thead>
        <tbody>
            <tr class="shuxingset">
                <td style="text-align:left;">
                    <ul class="setvalul" style=" display:block; width:100%;height:30px;  margin-left:20px; margin-top:16px;">
                        <li style="display:block; float:left;height:30px;text-align:right;">
                            Y轴设置:
                        </li>
                        <c:if test="${title1!=''}">
                        <li style="display:block;float:left;height:30px;text-align:left;">
                            <span style="display:block;color:#4572A7;float:left;">${title1}</span>
                            <span style="display:block; width:50px; margin-left:5px;height:20px;float:left; background:url(../resources/img/nygl_lscx_num.png) no-repeat;">
	                            <a onclick="changeVal('A','add');" style="cursor:pointer; display:block; float:left;width:19px;height:20px;"></a>
	                            <a onclick="changeVal('A-','min');" style="cursor:pointer; display:block; float:left;width:19px;height:20px;"></a>
                            </span>
                        </li>
                        </c:if>
                         <c:if test="${title2!=''}">
                        <li style="display:block;float:left;height:30px;margin-left:17px;text-align:left;">
                            <span style="display:block;color:#AA4643;float:left;">${title2}</span>
                             <span style="display:block; margin-left:5px; float:left; width:50px;height:20px; background:url(../resources/img/nygl_lscx_num.png) no-repeat;">
	                             <a onclick="changeVal('B','add');" style="cursor:pointer; display:block; float:left;width:19px;height:20px;"></a>
	                             <a onclick="changeVal('B-','min');" style="cursor:pointer; display:block; float:left;width:19px;height:20px;"></a>
                             </span>
                        </li>
                        </c:if>
                         <c:if test="${title3!=''}">
                        <li style="display:block;float:left;margin-left:17px;height:30px;text-align:left;">
                            <span style="display:block;color:#89A54E;float:left;">${title3}</span>
                             <span style="display:block; float:left; margin-left:5px;width:50px;height:20px; background:url(../resources/img/nygl_lscx_num.png) no-repeat;">
	                             <a onclick="changeVal('C','add');" style="cursor:pointer; display:block; float:left;width:19px;height:20px;"></a>
	                             <a onclick="changeVal('C-','min');" style="cursor:pointer; display:block; float:left;width:19px;height:20px;"></a>
                             </span>
                        </li>
                        </c:if>
                    </ul>
                </td>
            </tr>
            <tr class="">
                <td>
                    <div style="background-color:#fff">
                    	<div id="energyYearCont" style="min-width: 310px; height: 500px; margin: 0 auto"></div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</div>

