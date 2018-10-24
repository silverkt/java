<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 工艺属性配置 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/nygl.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
    <script type="text/javascript">
        $(document).ready(function () {
			 var screenW=document.documentElement.clientWidth-230;
			var scrH=$(window).height()- 130;
			$(".contentTop").css("height",scrH);
			
        	var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}};
	    	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />?_="+new Date().getTime(),success:function(data){	
					$.fn.zTree.init($("#treeDemo"), setting, data);
					$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
			}});
	    	
	    	function onClick(event,treeID,treeNode,clickFlag) {
				//if(treeNode.getParentNode()==null) return;
				if(treeNode.isParent){return};
				var parentNode = treeNode.getParentNode(),rootNode = parentNode.getParentNode();
				$("#curCity").empty().append((rootNode  == null ? '<span>' : '<span>'+rootNode.name+'</span>-<span>')+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
				$(".area_popup").hide();
				$("#curCity").removeClass("on");
				pid = treeNode.id;
				initLeft(pid);
			}
	    	function initLeft(pid){
	    		$.ajax({type:"GET",url:"<c:url value='/craftProperty/listLeft' />?new="+new Date().getTime(),data:{project:pid},
	    			success:function(data){
					$("#LeftCol").empty().html(data);
	    		}});
	    	}
            
            $(".curSelectedNode span:first-child").css("background", "url(<c:url value='/resources/img/img_23.png' />)");
            
        });
    </script>
    <style type="text/css">
    	.mod-select {
		    padding: 0px 30px 0px 10px;
		    width: auto;
		}
    </style>
</head>
<body>
   <input type="hidden" id="tr1">
   <input type="hidden" id="tr2">
   <input type="hidden" id="tr3">
    
    <jsp:include page="../../header.jsp"></jsp:include>
    
    <div class="nav-nav clear">

        <div class="sel_nav ml10">
            <a title="修改城市" data-target=".area_popup" class="curcity-expand showdiv" id="curCity">请选择</a>
        </div>

    </div>
    <div id="container" class="">
        <div id="LeftCol" class="LeftCol LeftCol3">
            
        </div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft">
			</div>
            <div class="content contentTop">
                <div class="topFilter tab" style="display:none;">
                    <table class="putform">
                        <tr>
                            <td class="w60">
                                <div class="mod-select  mt5 xmgl-mod-select" id="selectSb">
                                    <p class="text">设备类</p>
                                    <span class="arr-group hand">
                                        <i class="icon-mod icon-arr"></i>
                                    </span>
                                    <div class="list">
                                        <ul>
                                            <li><a href="">设备类</a></li>
                                            <li><a href="">设备类设备类设</a></li>
                                            <li><a href="">设备类</a></li>
                                            <li><a href="">设备类</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                            <td class="tleft">
                                <div class="fl xmgl_sarch">
                                    <input type="text" class="xmgl_input" />
                                    <a class="xmgl_serch"></a>
                                </div>
                                <a class="fr fancybox xmgl_srear" href="#pop-onupdate"></a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="wrap wrap-craft">
                	
                </div>
            </div>
        </div>
    </div>

	<div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
</body>
</html>
