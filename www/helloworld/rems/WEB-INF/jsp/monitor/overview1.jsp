<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- 项目概览 -->
	<title>远程能源管理系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
   	<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />

    <link href="<c:url value='/resources/css/xmgl0917.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    
    <script src="<c:url value='/resources/js/common.js ' />"></script>
    <script src="<c:url value='/resources/js/my.js ' />"></script>
    <script src="<c:url value='/resources/js/util.js ' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js ' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.slimscroll.min.js' />"></script>
	<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
	<script type="text/javascript">
    /*
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
	function sizeSet(){
        var screenW=document.documentElement.clientWidth;
	    var screenH=$(window).height();
		var scrH=$(window).height()- 130;
		$("#folderBtn").css("top",scrH/2);
		//$(".LeftCol").css("min-height",scrH);
		//$(".LeftCol").css("height",scrH);
		if(screenW<1600){
			$("html").css("overflow-x","scroll");
			$(".head").css("width",1600);
			$(".index-slide-txt").css("width",1600);
			$("#container").css("width",1600);
			$("#container").css("min-width",1600);
			$(".nav-nav").css("width",1600);
			$(".nav-nav").css("min-width",1600);
			
	    }
	}
    */
		$(function(){
		//	sizeSet();
			var scrW = document.documentElement.clientWidth;
			//var scrH=$(window).height()- 130;
			//$("#container").css("height",scrH+"px");
			var annularTime = null,iosiTime = null,iosoTime = null;
			var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},pid = ${pid},
   			sreenH = $(window).height() - 130;
		 	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />?date="+new Date().getTime(),success:function(data){
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
				$.ajax({type:"GET",url:"<c:url value='/analyse/session' />?date="+new Date().getTime(),data:{pid:pid}});
			}
			
			getProject();
			//获得项目
			function getProject(){
				$.ajax({
					type:"GET",url:"<c:url value='/monitor/overview1' />?date="+new Date().getTime(),data:{id:pid},
					success:function(data){
						if(annularTime) clearTimeout(annularTime);
						if(iosiTime) clearTimeout(iosiTime);
						if(iosoTime) clearTimeout(iosoTime);
						$("#container").empty().html(data);
						getAnnularData();//环状指标
					}
				});
			}
			//环状指标及气象
			function getAnnularData(){
				$("#tblinfo .annular").each(function(){
					getMinData($(this));
				})
			}
			//获得分钟数据
			function getMinData(obj){
				$.ajax({type:"GET",url:"<c:url value='/basedata/min' />?date="+new Date().getTime(),
					data:{instanceid:obj.attr("cid"),propertyid:obj.attr("pid")},
					success:function(data){
						//数据判断 by man
						if(data.datavalue) $(obj).text(data.datavalue1);
						else $(obj).text('0');
					}
				});
			}
			
			var ten = 1000 * 60 * 10,//十分钟
			 	hour = 1000 * 60 * 60;//一小时
			annularTime = setInterval(getAnnularData,1000*60);//环状指标
			iosiTime = setInterval(getIosI,hour);//耗能
			iosoTime = setInterval(getIosO,hour);//功能
			function getIosI(){
				$(".ios_i").each(function(){
					var model = $(this).attr("mid"),obj = $(this);
					$.ajax({type:"GET",url:"<c:url value='/monitor/data' />",data:{model:model},
						success:function(data){
							$("#energy",obj).text(data.energypvalue);
							$("#cost",obj).attr("title",data.showname2 + ":" + data.costValue + "" + data.costunit);
						}
					});
				})
			}
			function getIosO(){
				$(".ios_o").each(function(){
					var model = $(this).attr("mid"),obj = $(this);
					$.ajax({type:"GET",url:"<c:url value='/monitor/data' />",data:{model:model},
						success:function(data){
							$("#energy",obj).text(data.energypvalue);
						}
					});
				})
			}
		})
		function hideInfo() {$(".rigdata_zz").hide();}
        function showInfo() {$(".rigdata_zz").show();}
        
	</script>
</head>
<body>
 	<jsp:include page="../header.jsp"></jsp:include>
    <div class="nav-nav nav-secnav clear">
        <div class="sel_nav ml10">
            <a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span></a>
        </div>
    </div>
    
    <div id="container" style="" class="monitoring"></div>
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
</body>
</html>
