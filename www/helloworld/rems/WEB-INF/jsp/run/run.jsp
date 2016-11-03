<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 设备属性监测 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/nygl.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
     <script src="<c:url value='/resources/js/Highcharts-4.0.1/highstock.js' />"></script>
   <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
    <script type="text/javascript">
   		
        $(document).ready(function () {
	        var screenW=document.documentElement.clientWidth-230;
			var scrH=$(window).height()- 130;
			$("#folderBtn").css("top",scrH/2);
			$(".LeftCol").css("height",scrH-60);
			$("#instance").css("height",scrH-60);
			//$(".datalist-div").css("min-height",scrH-100);
			//$(".wrap").css("min-height",scrH-50);
			//$("#container .content .wrap").css("min-height",scrH);
            var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},pid = ${pid};
	    	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />?new="+new Date().getTime(),success:function(data){
					$.fn.zTree.init($("#treeDemo"), setting, data);
					$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
			}});
	    	
	    	function onClick(event,treeID,treeNode,clickFlag) {
				if(treeNode.getParentNode()==null) return;
				var parentNode = treeNode.getParentNode(),rootNode = parentNode.getParentNode();
				pid = treeNode.id;
				$("#curCity").empty().append((rootNode  == null ? '<span>' : '<span>'+rootNode.name+'</span>-<span>')+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
				$(".area_popup").hide();
				$("#curCity").removeClass("on");
				setSession(pid);
				initLeft(pid,-1);
				$("#selectsBtype .text").empty().append("选择设备类型");
			}
	    	function setSession(pid){
				$.ajax({type:"GET",url:"<c:url value='/analyse/session' />?new="+new Date().getTime(),data:{pid:pid}});
			}
	    	function initLeft(pid,classid){
	    		$.ajax({type:"GET",url:"<c:url value='/run/listLeft' />?new="+new Date().getTime(),data:{project:pid,classid:classid},
	    			success:function(data){
						$("#LeftCol #instance").empty().html(data);
		    		}
	    		});
	    	}
	    	$('#selectsBtype').simSelect({
		        callback: function (x,v) {
	    			if(!v) return;
	    			initLeft(pid,v);
		        }
		    });//设备类型
            $(".curSelectedNode span:first-child").css("background", "url(./img/img_23.png)");
        });
    </script>
    <style>
	html{ overflow:hidden;} 
	
#container .content .wrap {
    min-width: 830px;
    overflow:auto;
}
	</style>
</head>
<body>
	<input type='hidden' id="unit">
	<input type='hidden' id="interval">
   <jsp:include page="../header.jsp"></jsp:include>
    <div class="nav-nav clear">
        <div class="sel_nav ml10">
            <a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span></a>
        </div>
    </div>
    <div id="container" class="energyManagement-lssjcx">
        <%--<div id="LeftCol" class="LeftCol" style="background: #fff; overflow-y:scroll;">
        <jsp:include page="left.jsp"></jsp:include>
        </div>
        --%>
        <div id="LeftCol" class="LeftCol LeftCol3">
        	<div class="left-nav tab">
        		<div class="left-in" style="">
        			<div class="sbsx_contain">
        				<div class="mod-select mt5 select-sbsx" id="selectsBtype" >
                            <p class="text">选择设备类型</p>
                            <span class="arr-group hand">
                                <i class="icon-mod icon-arr"></i>
                            </span>
                            <div class="list sbsx_list" >
                                <ul>
                                	<li val="-1"><a href="">全部类型设备</a></li>
                                	<c:forEach items="${standards}" var="c">
                                		<li val="${c.classid}"><a href="">${c.classname}</a></li>
                                	</c:forEach>
                                </ul>
                            </div>
                        </div>
        			</div>
        			<div id="instance" class="sbsx_instance" >
        				<jsp:include page="left.jsp"></jsp:include>
        			</div>
        		</div>
        	</div>
        </div>
       	<div id="MainCol" class="MainCol sbsx_maincol">
            <div id="folderBtn" class="icoLeft"></div>
                <div class="wrap">
                	 
                
                </div>
        </div>
    </div>
    <div class="area_popup">
        <div class="datalist-div" style="height:auto !important;padding-bottom:0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
</body>
</html>
