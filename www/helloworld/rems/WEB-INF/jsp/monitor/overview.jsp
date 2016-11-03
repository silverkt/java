<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>远程能源管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   	<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js ' />"></script>
    <script src="<c:url value='/resources/js/my.js ' />"></script>
    <script src="<c:url value='/resources/js/util.js ' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js ' />"></script>
    <script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
	<script type="text/javascript">
		$(function(){
			
			var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},pid = ${pid},
			models = {},charts = {},colors=['#2f7ed8', '#0d233a', '#8bbc21', '#910000', '#1aadce', 
   											'#492970', '#f28f43', '#77a1e5', '#c42525', '#a6c96a'];
		 	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />",success:function(data){
				$.fn.zTree.init($("#treeDemo"), setting, data);
				$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
			}});
		 	//初始化HighChart参数
			function initChartOptions(container,x,y,model){
				return {chart:{renderTo:container,type:'spline'},
						credits:{enabled:false},legend:{enabled:true,verticalAlign: 'top'},
						tooltip:{
							crosshairs: true,shared: true,
							formatter: function() {
				                var s = '<b>'+ this.x +'</b>';
				                $.each(this.points, function(i, point) {
				                    s += '<br/>'+ point.series.name +': '+ point.y + model[i].unitname;
				                });
				                return s;
				            }
						},
						plotOptions:{series:{marker:{enabled:false}}},
						title:{text:""},xAxis:x,yAxis:y};
			}
			function onClick(event,treeID,treeNode,clickFlag) {
				if(treeNode.isParent){return};
				var parentNode = treeNode.getParentNode();
				$("#curCity").empty().append("<span>"+parentNode.getParentNode().name+"</span>-<span>"+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
				$(".area_popup").hide();
				$("#curCity").removeClass("on");
				pid = treeNode.id;
				models = {};charts = {};
				getProject();
			}
			getProject();
			//获得项目
			function getProject(){
				$.ajax({
					type:"GET",url:"<c:url value='/monitor/overview' />",data:{id:pid},
					success:function(data){
						$("#container").empty().html(data);
						mentType();mentWidth();
						getQuotaData();//系统指标
						getAnnularData();//环状指标
						var xc1 = getTime(24,1);
						initChart('hichart1',4,xc1,false,6);//当日能耗
						initChart('hichart2',5,xc1,false,6);//当日供能
						var xc2 = getTime(24,6);
						initChart('hichart3',7,xc2,false,36);//实时气象
						initChart2('hichart4',4,false);//累计能耗
						initChart2('hichart5',5,false);//累计供能
						//弹出框
						popBox();
					}
				});
			}
			
			function popBox(){
				$(".xmgl-item .fancybox").click(function(){
					$("#hichart").empty();
					var $this = $(this).parent().find(".fl"),
						mid = parseInt($this.attr("mid")),xc1,xt;
					$(".hd h2","#pop-xmgl").text($this.text());
					if(mid < 10){
						if(mid < 7 ) {xc1=getTime(24,1);xt=6;}
						else {xc1=getTime(24,6);xt=36;}
						initChart("hichart",mid,xc1,true,xt);
					}else if(mid > 10){
						initChart2("hichart",mid/10,true);
					}
					popFancybox();
				})
			}
			//初始化highchart type 0 小时级数据 1 分钟级数据 
			function initChart(container,mid,xc,enabled,xt){
				$.ajax({type:"GET",url:"<c:url value='/monitor/model' />",data:{project:pid,modelid:mid},
					success:function(data){
						var model = data.data;
						var x = {categories:xc,labels: {enabled:true},max:xc.length-1,tickLength:0, tickInterval: xt},
						 	y = [];
						$.each(model,function(i){
							var unitname = $(this)[0].unitname;
							var text = enabled ? $(this)[0].classpropertyname:"";
							y.push({
								title:{text:text},opposite:i==0?false:true,
								labels:{
									enabled:enabled,
									formatter:function(){return this.value + "" + unitname;},
									style:{color:colors[i]}
								}
							});
						})
						if(enabled) mid = mid * 10;
						models[mid] = model;
						charts[mid] = new Highcharts.Chart(initChartOptions(container,x,y,models[mid]));
						if(mid != 7 && mid != 70) $.each(models[mid],function(i){getData(i,$(this)[0],charts[mid]);});
						else $.each(models[mid],function(i){getTenMinData(i,$(this)[0],charts[mid],0);});
					}
				})
			}
			//柱状图
			function initChart2(container,mid,enabled){
				$.ajax({type:"GET",url:"<c:url value='/basedata/mon' />",data:{pid:pid,modelid:mid},
					success:function(data){
						var unitnames = [];
						$.each(data.l,function(k,v){
							unitnames.push(k.split(",")[1]);
						});
						$.each(data.l,function(k,v){
							unitnames.push(k.split(",")[1]);
						});
						var options = {
							chart:{renderTo:container,type:'column'},credits:{enabled:false},
							colors: colors,
							legend:{enabled:enabled,verticalAlign: 'top'},
							plotOptions:{column:{ stacking: 'normal' } },title:{text:""},
							xAxis:{categories:["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
									,max: 11,labels: {enabled:true},tickLength:0,tickInterval: 2},
							yAxis:{title:{text:""},labels:{enabled:enabled}},
							tooltip:{
									crosshairs: true,shared: true,
									formatter: function() {
						                var s = '<b>'+ this.x +'</b>';
						                $.each(this.points, function(i, point) {
						                    s += '<br/>'+ point.series.name +': '+ point.y + unitnames[i];
						                });
						                return s;
						            }
								},
						},chart = null;
						chart = new Highcharts.Chart(options);
						$.each(data.l,function(k,v){
							chart.addSeries({name:k.split(",")[0],data:v,stack:'l'});
						});
						$.each(data.y,function(k,v){
							chart.addSeries({name:k.split(",")[0],data:v,stack:'y'});
						});
					}	
				});
			}
			//获得数据
			function getData(i,obj,chart){
				$.ajax({type:"GET",url:"<c:url value='/basedata/new' />",async: false,
					data:{instanceid:obj.classinstanceid,propertyid:obj.classpropertyid},
					success:function(data){
                		chart.addSeries({yAxis: i,name: obj.classpropertyname,data: data});  
					}
				});
			}
			//获得10分钟数据 type 0:所有10*n 1:10*n数据
			function getTenMinData(i,obj,chart,type){
				$.ajax({type:"GET",url:"<c:url value='/basedata/min/ten' />",async: false,
					data:{instanceid:obj.classinstanceid,propertyid:obj.classpropertyid,type:type},
					success:function(data){
						if(type == 0){
							var datas = new Array();
							for(var j = 0,len = data.length;j < len; j++) datas.push(data[j].datavalue);
							chart.addSeries({yAxis: i,name: obj.classpropertyname,data: datas});
						}else{
							var series = chart.series[i];
							for(var j = 0,len = data.length;j < len; j++){
								series.addPoint([data[j].rectime,data[j].datavalue]);
							}
						}
					}
				});
			}
			//系统指标
			function getQuotaData(){
				$(".putform_xtzb .quota").each(function(){
					getMinData($(this));
				})
			}
			//环状指标
			function getAnnularData(){
				$(".tjt .annular").each(function(){
					getMinData($(this));
				})
			}
			//获得分钟数据
			function getMinData(obj){
				$.ajax({type:"GET",url:"<c:url value='/basedata/min' />",
					data:{instanceid:obj.attr("cid"),propertyid:obj.attr("pid")},
					success:function(data){
						//数据判断 by man
						if(data){
							$(obj).text(data.datavalue);
						}else{
							$(obj).text(0);
						}
					
					}
				});
			}
			var ten = 1000 * 60 * 10;//十分钟
			var hour = 1000 * 60 * 60;//一小时
			setInterval(getIos,hour);//输入输出
			setInterval(getQuotaData,ten);//系统指标
			setInterval(getAnnularData,ten);//环状指标
		
			function getIos(){
				$(".tjt-item","#mleft").each(function(){
					var model = $(this).attr("mid"),obj = $(this);
					$.ajax({type:"GET",url:"<c:url value='/monitor/data' />",data:{model:model},
						success:function(data){
							$(".ico",obj).removeClass().addClass("ico").addClass(data.icon);
							$("#cost",obj).text(data.costValue);
							$("#energy",obj).text(data.energypvalue);
						}
					});
				})
			}
			
			setInterval(function(){
				if(models[7] == null) return;
				$.each(models[7],function(i){
					getTenMinData(i,$(this)[0],charts[7],1);
				});
			},ten);//实时天气
			setInterval(function(){
				if(models[5] == null) return;
				$.each(models[5],function(i){
					getHourData(i,$(this)[0],charts[5]);
				});
			},hour);//当日耗能
			setInterval(function(){
				if(models[4] == null) return;
				$.each(model2.data,function(i){
					getHourData(i,$(this)[0],charts[4]);
				});
			},hour);//当日供能
			//获得一小时数据
			function getHourData(i,obj,chart){
				$.ajax({type:"GET",url:"<c:url value='/basedata/hour' />",
					data:{instanceid:obj.classinstanceid,propertyid:obj.classpropertyid},
					success:function(data){
						var series = chart.series[i];
						series.addPoint([data.rectime,data.datavalue]);
					}
				});
			}
		})
	</script>
</head>
<body>
 	<jsp:include page="../header.jsp"></jsp:include>
    <div class="nav-nav nav-secnav clear">
        <div class="sel_nav ml10">
            <a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span></a>
        </div>
    </div>
    <div id="container" class="monitoring p9">
        
    </div>
    <div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
     <div class="mod-pop" id="pop-xmgl" style="height: 480px;">
        <div class="hd">
            <h2></h2>
        </div>
        <div class="bd" id="hichart" style="vertical-align: middle;">
            
        </div>
    </div>
</body>
</html>
