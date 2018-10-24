<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow-y:hidden;overflow-x:auto;min-width:1200px;">
<head>
	<!-- 能效监测 -->
	<title>远程能源管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
   	<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/xmgl.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/xmgl0917.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js ' />"></script>
    <script src="<c:url value='/resources/js/my.js ' />"></script>
    <script src="<c:url value='/resources/js/util.js ' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js ' />"></script>
    <script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
    <script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts-more.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
	<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
	<script type="text/javascript">
	function sizeSet(){
        var screenW=document.documentElement.clientWidth;
	    var screenH=$(window).height();
		var scrH=$(window).height()- 130;
		$("#folderBtn").css("top",scrH/2);
		$(".LeftCol").css("min-height",scrH);
		$(".LeftCol").css("height",scrH);
        /*
		if(screenW<1600){
			$("html").css("overflow-x","scroll");
			$(".head").css("width",1600);
			$(".index-slide-txt").css("width",1600);
			$("#container").css("width",1600);
			$("#container").css("min-width",1600);
			$(".nav-nav").css("width",1600);
			$(".nav-nav").css("min-width",1600);
	    }
        */
}
		function chartAuto() {

    var sreenH = $(window).height()-178
      , incont = $(".xmgl_list1 td .xmgl_list1_cont .xmgl_incont")
      , incontH = sreenH / 2 - 35
      //, xtzbW = Math.floor(incont.width()/3) - 3//3为最小间距
      , xtzbH = incontH 
	  //alert(incont.width())
    incont.css("height", incontH);
    incont.css("min-height",225+"px");
    $('.quota').height(xtzbH - 20);//表盘高度
	$(".quota").css("min-height",191+"px");//表盘最小高度
	$('#container').find('.xmgl_list1_cont').css(
		{"height":"auto"
		 ,"min-height":225
		 ,"overflow":"hidden"});//container高度最小高度溢出隐藏
	$('#myxmgl_incont').css("margin","0 auto");//去除系统指标margin-top
	$(".xmgl_incont").css("background","white");//每个表背景白色，否则会有前景白色背景渐变效果
 }
		$(function(){
			//sizeSet();
    chartAuto();
            $(window).resize(function(){
                  chartAuto();
                var scrW = document.documentElement.clientWidth;
                var scrH=$(window).height()- 130;
                $("#container").css({"height":scrH+"px"});
            });
            
            
			var scrW = document.documentElement.clientWidth;
			var scrH=$(window).height()- 130;
			$("#container").css("height",scrH+"px");
			
			var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},pid = ${pid},
			models = {},charts = {},colors=['#2f7ed8', '#0d233a', '#8bbc21', '#910000', '#1aadce', 
   											'#492970', '#f28f43', '#77a1e5', '#c42525', '#a6c96a'],
   			sreenH = $(window).height() - 130,speeds = {};
			var pieCid = "",piePid = "",pieHour = "";
		 	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />?new="+new Date().getTime(),success:function(data){
				$.fn.zTree.init($("#treeDemo"), setting, data);
				$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
			}});
			function onClick(event,treeID,treeNode,clickFlag) {
				if(treeNode.isParent){return};
				var parentNode = treeNode.getParentNode();
				pid = treeNode.id;
				$("#curCity").empty().append("<span>"+parentNode.getParentNode().name+"</span>-<span>"+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
				$(".area_popup").hide();
				$("#curCity").removeClass("on");
				models = {};charts = {};
				setSession(pid);
				getProject();
			}
			function setSession(pid){
				$.ajax({type:"GET",url:"<c:url value='/analyse/session' />?new="+new Date().getTime(),data:{pid:pid}});
			}
			
			getProject();
			//获得项目
			function getProject(){
				$.ajax({
					type:"GET",url:"<c:url value='/energymonitor/content' />?new="+new Date().getTime(),data:{id:pid},
					success:function(data){
						$("#container").empty().html(data);
						initTblinfo();
					}
				});
			}
			function initTblinfo(){//初始化表格
				initChartPie('hichartpie1',4);//
				initChartPie('hichartpie2',5);//
				var xc1 = getTime(24,1);
				getQuotaData();//系统指标
				initChart('hichart1',4,xc1,true,6,'spline',true,0);//当日能耗
				initChart('hichart2',5,xc1,true,6,'spline',true,0);//当日供能
				var xc2 = getTime(24,6);
				initChart('hichart3',7,xc2,true,36,'area',false,null);//实时气象
				popBox();
				   chartAuto();
			}
			//初始化HighChart参数
			function initChartOptions(container,x,y,model,type,marker){
				return {chart:{renderTo:container,type:type},
						credits:{enabled:true},legend:{enabled:true,verticalAlign: 'top'},
						tooltip:{
							crosshairs: true,shared: true,
							formatter: function() {
				                var s = '<b>'+ this.x +'</b>';
				                $.each(this.points, function(i, point) {
				                    s += '<br/>'+ point.series.name +': '+ point.y + point.point.u;
				                });
				                return s;
				            }
						},
						plotOptions:{series:{events: {
							                    click: function (e) {
							                       	pieCid = e.point.cid;
													piePid = e.point.pid;
													pieHour = e.point.category;
													if(pieCid && piePid) {
														$("#pop-xmg2 .hd").html(e.point.category+"时设备"+this.name+"结构分布");
														$("#test").trigger("click");
													}
							                    }
							                },marker:{enabled:marker}},
			            area: {
			                fillColor: {
			                    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
			                    stops: [
			                        [0, Highcharts.getOptions().colors[0]],
			                        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
			                    ]
			                },
			                lineWidth: 2,
			                shadow: false,
			                states: {
			                    hover: {
			                        lineWidth: 1
			                    }
			                },
			                threshold: null
			            }


						},
						title:{text:""},xAxis:x,yAxis:y};
			}
			function initChart(container,mid,xc,enabled,xt,type,marker,min){
				$.ajax({type:"GET",url:"<c:url value='/monitor/model' />?new="+new Date().getTime(),data:{project:pid,modelid:mid},
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
								},min:min,showEmpty:false
							});
						})
						if(enabled) mid = mid * 10;
						models[mid] = model;
						charts[mid] = new Highcharts.Chart(initChartOptions(container,x,y,models[mid],type,marker));
						if(mid != 7 && mid != 70) $.each(models[mid],function(i){getData(i,$(this)[0],charts[mid]);});
						else{
							if(model.length!=0){
								var classpropertyid=new Array();
								$.each(models[mid],function(i){classpropertyid.push(models[mid][i].classpropertyid)});
								//models[mid][0].classpropertyid=classpropertyid.toString();
								getTenMinData_line(classpropertyid,models[mid],charts[mid],0);
							}else return;
						}
					}
				})
			}
			//获得数据
			function getData(i,obj,chart){
				$.ajax({type:"GET",url:"<c:url value='/basedata/new' />?new="+new Date().getTime(),async: false,
					data:{instanceid:obj.classinstanceid,propertyid:obj.classpropertyid},
					success:function(data){
                		chart.addSeries({yAxis: i,name: obj.classpropertyname,data: data,u:obj.unitname});  
					}
				});
			}
			//获得10分钟数据 type 0:所有10*n 1:10*n数据
			function getTenMinData(i,obj,chart,type){
				$.ajax({type:"GET",url:"<c:url value='/basedata/min/ten' />?new="+new Date().getTime(),async: false,
					data:{instanceid:obj.classinstanceid,propertyid:obj.classpropertyid,type:type},
					success:function(data){
						if(data.length>0){
							var series = chart.series[i];
							var point=(series.points)[series.points.length-1];
							for(var j = 0,len = data.length;j < len; j++){
								//console.log(data[j].rectime+","+data[j].datavalue);
								series.addPoint([data[j].rectime,data[j].datavalue]);
								//设置曲线单位
								$.each(series.points, function(i, point) {
									point.u=obj.unitname;
				                });
							};
						}

					}
				});
			}
			
			//生成10分钟数据曲线
			function getTenMinData_line(classpropertyid,obj,chart,type){
				$.ajax({type:"GET",url:"<c:url value='/basedata/min/ten' />?new="+new Date().getTime(),async: false,
					data:{instanceid:obj[0].classinstanceid,propertyid:classpropertyid.toString(),type:type},
					success:function(data){
						$.each(classpropertyid,function(i){
							var datas = new Array();
							//time = (new Date()).getTime();
							for(var j = 0,len = data.length;j < len; j++) {
								if(data[j].classpropertyid==classpropertyid[i])
									datas.push({y:data[j].datavalue,u:obj[i].unitname});
							}
							chart.addSeries({yAxis: i,name: obj[i].classpropertyname,data: datas});
						});
					}
				});
			}
			//初始化饼状图
			function initChartPie(container,mid){
				//灰色#969696
				$.ajax({type:"GET",url:"<c:url value='/energymonitor/pie' />?new="+new Date().getTime(),data:{id:pid,mid:mid},
					success:function(data){
						if(data.length==1&&data[0].name=='暂无数据'){
							var chart =new Highcharts.Chart(initpie(container,['#969696'],false));
							chart.addSeries({type:'pie',data:data});
						}else {
							var chart =new Highcharts.Chart(initpie(container,['#492970','#f28f43','#77a1e5','#c42525','#a6c96a','blue'],true));
							chart.addSeries({type:'pie',data:data});
						}
						
					}
				})
			}
			//饼状图
			/* * 
			plotOptions: {
				pie: {
				allowPointSelect: true, //选中某块区域是否允许分离
				cursor: 'pointer',
				dataLabels: {
					enabled: true //是否直接呈现数据 也就是外围显示数据与否
				},
				showInLegend: true //是否显示图例
				}
			},
			
			*/
			function initpie(container,color,dataLabels){
				return {
					chart: {renderTo:container,plotBackgroundColor: null,plotBorderWidth: null,plotShadow: false},
					title: {text: ''},
					 colors:color,
					tooltip: {pointFormat: '<b>{point.original}</b>'},
					plotOptions: {
						pie: {
							events:{
								click:function(e){
									pieCid = e.point.cid;
									piePid = e.point.pid;
									if(pieCid && piePid) {
										$("#pop-xmg2 .hd").html("当日设备"+e.point.name+"结构分布");
										$("#test").trigger("click");
									}
								}
							},
						allowPointSelect: true,cursor: 'pointer',dataLabels: {enabled: dataLabels,color: '#000000', connectorColor: '#000000',format: '<b>{point.name}</b>: {point.percentage:.1f} %'}}}
				};				
			}
			//系统指标 speeds
			function getQuotaData(){
				$("#xt2 .quota").each(function(k){
					var obj = $(this);
					$.ajax({type:"GET",url:"<c:url value='/energymonitor/gauge' />?new="+new Date().getTime(),
						data:{instanceid:obj.attr("cid"),propertyid:obj.attr("pid")},
						success:function(data){
							var plotBands = [],min,max;
							$.each(data.set,function(k,v){
								if(k == 0) min = v.gfrom;
								max = v.gto;
								var plotBand = {from:v.gfrom,to:v.gto,color:v.color};
								plotBands.push(plotBand);
							})
							speeds[k] = new Highcharts.Chart(inintGaugeOptions("speed"+(k+1),obj.attr("sname"),obj.attr("uname"),min,max,plotBands));
							speeds[k].addSeries({name: 'Speed',data: [data.value]});
						}
					});
				})
			}
			function getQuotaData2(){
				$("#xt2 .quota").each(function(k){
					var obj = $(this);
					$.ajax({type:"GET",url:"<c:url value='/basedata/min' />?new="+new Date().getTime(),
						data:{instanceid:obj.attr("cid"),propertyid:obj.attr("pid")},
						success:function(data){
							var temp = 0,point = speeds[k].series[0].points[0];
							if(data.datavalue) temp = data.datavalue;
							point.update(temp);
						}
					});
				})
			}
			//速度仪
			function inintGaugeOptions(container,title,uname,min,max,plotBands){
				return {
					chart:{renderTo:container,type: 'gauge',plotBackgroundColor: null,plotBackgroundImage: null,plotBorderWidth: 0, plotShadow: false},
					title:{text:title,verticalAlign:"bottom",y:-10},
					pane: {
				        startAngle: -100,endAngle: 100,
				        background: [{
				            backgroundColor: {linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }, stops: [[0, '#FFF'],[1, '#333']]},
				            borderWidth: 0,outerRadius: '109%'
				        }, {
				            backgroundColor: {linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },stops: [[0, '#333'],[1, '#FFF']]},
				            borderWidth: 1,outerRadius: '107%'
				        }, {// default background
				        }, {
				            backgroundColor: '#DDD',borderWidth: 0,outerRadius: '105%',innerRadius: '103%'
				        }]
				    },
				     plotOptions: {
			            series: {
			                dataLabels: {
			                    enabled: true,
			                    y:35,
			                    borderWidth:0,
			                    color:'#000',
			                    style: {fontWeight: 'bold',fontSize:'18px'}
			                }
			            },
			            gauge:{dial:{backgroundColor:"#666"}}
			        },
			        tooltip:{enabled:false},
				    yAxis: {
				        min: min,max: max,//reversed: true,
				        minorTickInterval: 'auto',minorTickWidth: 1,minorTickLength: 10,minorTickPosition: 'inside',
				        minorTickColor: '#666',
				        tickPixelInterval: 30,tickWidth: 2,tickPosition: 'inside',tickLength: 15, tickColor: '#666',
				        labels: {step: 2,rotation: 'auto'}, title: {text: uname},
				        plotBands: plotBands
				    }
				};
			}
			//获得分钟数据
			function getMinData(obj){
				$.ajax({type:"GET",url:"<c:url value='/basedata/min' />?new="+new Date().getTime(),
					data:{instanceid:obj.attr("cid"),propertyid:obj.attr("pid")},
					success:function(data){
						//数据判断 by man
						if(data.datavalue) $(obj).text(data.datavalue);
						else $(obj).text(0);
					}
				});
			}
			function popBox(){
				$(".chart .fancybox").click(function(){
					$("#hichart").empty();
					var $this = $(this).parent().find(".fl"),
						mid = parseInt($this.attr("mid")),xc1,xt;
					$(".hd h2","#pop-xmgl").text($this.text());
					if(mid < 10){
						if(mid < 7 ) {xc1=getTime(24,1);xt=6;}
						else {xc1=getTime(24,6);xt=36;}
						initChart("hichart",mid,xc1,true,xt);
					}else if(mid > 10){
						//initChart2("hichart",mid/10,true);
					}
					popFancybox();
				})
				$("#test").click(function(){
					$("#hichartpie").empty();
					$.ajax({type:"GET",url:"<c:url value='/energymonitor/pie/child' />?new="+new Date().getTime(),
					    data:{id:pid,cid:pieCid,pid:piePid,hour:pieHour},
					 error:function(){
							var chart =new Highcharts.Chart(initpie("hichartpie",['#969696'],false));
							chart.addSeries({type:'pie',data:[{name:"暂无数据",original:" ",y:1}]}); 
					  },
				    success:function(data){
				    	if(data.length==1&&data[0].name=='暂无数据'){
							var chart =new Highcharts.Chart(initpie("hichartpie",['#969696'],false));
							chart.addSeries({type:'pie',data:data});
						}else {
							var chart =new Highcharts.Chart(initpie("hichartpie",['#492970','#f28f43','#77a1e5','#c42525','#a6c96a','blue'],true));
							chart.addSeries({type:'pie',data:data});
						}
				    	/*
						pieHour = "";
						var chart =new Highcharts.Chart(initpie("hichartpie"));
						chart.addSeries({type:'pie',data:data});*/
					}
					})
				})
			}
			var ten = 1000 * 60 * 10,//十分钟
			 	hour = 1000 * 60 * 60;//一小时
				one=1000*60;
			
			clearInterval($("#interval_1").val());
			$("#interval_1").val(setInterval(getQuotaData2,one));//系统指标
			
			clearInterval($("#interval_2").val());
			$("#interval_2").val(
				setInterval(function(){
					console.log(models[70]);
					if(models[70] == null) return;
					$.each(models[70],function(i){
						//console.log(i);
						getTenMinData(i,$(this)[0],charts[70],1);
					});
				},ten)
			);//实时天气
	
			clearInterval($("#interval_3").val());
			$("#interval_3").val(
					setInterval(function(){
						 
						if(models[50] == null) return;
						$.each(models[50],function(i){
							getHourData(i,$(this)[0],charts[50]);
						});
					},hour)
			);//当日耗能
			
			clearInterval($("#interval_4").val());
			$("#interval_4").val(
					setInterval(function(){
						if(models[40] == null) return;
						$.each(models[40],function(i){
							getHourData(i,$(this)[0],charts[40]);
						});
					},hour)
			);//当日供能
			

			//获得一小时数据
			function getHourData(i,obj,chart){
				$.ajax({type:"GET",url:"<c:url value='/basedata/hour' />?new="+new Date().getTime(),
					data:{instanceid:obj.classinstanceid,propertyid:obj.classpropertyid},
					success:function(data){
						var series = chart.series[i];
						var point=(series.points)[series.points.length-1];
						//console.log(point.x+"=="+data.rectime);
						if((point.x+":00")==data.rectime){
							return;
						}else{
							series.addPoint([data.rectime,data.datavalue]);
							//更新曲线单位
							$.each(series.points, function(i, point) {
								point.u=obj.unitname;
			                });
						}
					}
				});
			}
		})
	</script>
    <style>
	 html{ overflow:hidden;}
	</style>
</head>
<body>
	<input type='hidden' id="interval_1">
	<input type='hidden' id="interval_2">
	<input type='hidden' id="interval_3">
	<input type='hidden' id="interval_4">
 	<jsp:include page="../header.jsp"></jsp:include>
    <div class="nav-nav nav-secnav clear">
        <div class="sel_nav ml10">
            <a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span></a>
        </div>
    </div>
    
    <div id="container" style=" overflow:auto;" class="monitoring"></div>
    <div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
     <div class="mod-pop" id="pop-xmgl" style="height: 480px;">
        <div class="hd"><h2></h2></div>
        <div class="bd" id="hichart" style="vertical-align: middle;"></div>
    </div>
	<a href="#pop-xmg2" class="fancybox" id="test" style="display: none;"></a>
	<div class="mod-pop" id="pop-xmg2">
		<div class="hd"><h2></h2></div>
		<div class="bd" style="height: 400px;" id="hichartpie"></div>
	</div>
</body>
</html>
