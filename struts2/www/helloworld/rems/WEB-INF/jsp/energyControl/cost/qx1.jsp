<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script>
$(function(){
	$("#title").text("${vo.costProperty.classpropertyname}");
	$.ajax({type:"GET",url:"<c:url value='/analyse/cost/chart1/value/' />"+${pid},data:$("#qxform").serialize(),
				success:function(data){
				// add 2015年1月27日10:00:24 金尚彬 end
    				if(data == "") {
    					jAlert("查无相关数据！","确定",function(r){
							if(r == true){
								location.replace(location.href);
							}
						}); 
    					
    				}else{
    					var series = [],xAxis = [];
   					$.each(data,function(k,v){
   						xAxis[k] = v.rectime;
   						series[k] = v.costData;
   					});
   						//alert("data!"+series);
   					createChart(series,xAxis);
    				}
    				
   				}	
			});
	function createChart(data,x){
			$('#highchart1').highcharts({ 
				 chart: {
                type: 'column'
            },
            title: {
               text:""
            },
            subtitle: {
               text:""
            },
            xAxis: {
                categories: 
                 x
                 
            },
            yAxis: {
               	title:{text:""},
						labels:{
							formatter:function(){return this.value + "" + "${vo.costUnitname}";}
						},min:0,showEmpty:false 
            },
            tooltip: {
               	xDateFormat: '%Y-%m-%d %H:%M:%S'
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            	series: [{ name: '${vo.costProperty.classpropertyname}',data:data}]
        });
		}
})
</script>
<form id="qxform">
	<input type="hidden" name="type" value="${type}">
	<input type="hidden" name="date" value="${date}">
	<input type="hidden" name="property" value="${property}">
</form>
<div >
    <div style="width:100%;height:30px;line-height:30px; background:url(<c:url value='/resources/img/datalist-thbg2.png' />) repeat-x scroll left top ;">
      <span id="title" style="float:left;margin:0 0 0 15px;"></span>
    </div>
	<div id="highchart1"></div>
</div>
