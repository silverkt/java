<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script>
$(function(){
	$.ajax({type:"GET",url:"<c:url value='/analyse/cost/histogram/value/' />"+${pid},data:$("#qxform").serialize(),
				success:function(data){
				// add 2015年1月27日10:00:24 金尚彬 end
    				if(data.noDatas) {//数据为空
    					//$('#title_bg').css("display","none");
    					jAlert("查无相关数据！","确定",function(r){
						}); 
    				}else{
    					$('#title_bg').css("display","block");
    					var categories = [],series = [];
    					$.grep(data.vos,function(k,v){
    						categories = (k.categories);
    						series.push({'name':k.name,'data':k.data});
    					});
    					createHistogram(categories,series,'${unitname}');
    				}
    				$("#title").text("${hTitle}");
    				
   				},
   				error:function(){
   					jAlert('加载失败！');
   				}	
			});
	function createHistogram(categories,series,unitname){
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
                categories:categories
                 
            },
            yAxis: {
               	title:{text:""},
               	labels:{
               		formatter:function(){
               			return this.value + "" + unitname;
               		}
               	},
               	min:0,
               	showEmpty:false 
            },
            tooltip: {
               	xDateFormat: '%Y-%m-%d %H:%M:%S',
               	shared : true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            	series: series
        });
		}
})
</script>
<form id="qxform">
	<input type="hidden" name="type" value="${type}">
	<input type="hidden" name="date" value="${date}">
	<input type="hidden" name="propertyid" value="${property}">
	<input type="hidden" name="instanceid" value="${instance}">
	<input type="hidden" name="tab" value="${tab}">
</form>
<div >
    <div id="title_bg" style="width:100%;height:30px;line-height:30px; background:url(<c:url value='/resources/img/datalist-thbg2.png' />) repeat-x scroll left top ;display:none">
      <span id="title" style="float:left;margin:0 0 0 15px;"></span>
    </div>
	<div id="highchart1"></div>
</div>
