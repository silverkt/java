<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 项目信息管理 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
   <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/demo.css'/>" rel="stylesheet" />
		<link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/pagination.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/nygl.css' />" rel="stylesheet" />
    	<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
		<script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.validate.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
		<script src="<c:url value='/resources/js/common.js' />"></script>
		<script src="<c:url value='/resources/js/my.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
		<script src="<c:url value='/resources/js/base.js' />"></script>
		<script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
		<script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
		<script src="<c:url value='/resources/js/Highcharts-4.0.1/exporting.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>
		<script src="<c:url value='/resources/js/zTree_v3/js/jquery.ztree.excheck-3.5.js' />"></script>
		<script src="<c:url value='/resources/js/areaNames.js' />"></script>
		<script src="<c:url value='/resources/js/ajaxfileupload.js' />"></script>
		<script src="http://api.map.baidu.com/api?v=2.0&services=false&ak=508d19135c7e834335c9fd942625c161" type="text/javascript"></script>
    	<script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
    <script type="text/javascript">
    var rating;
    var isFirst = true;
    var lastData;
    var onblue_park;
        $(document).ready(function () {
        	var scrH=$(window).height();
			$("#folderBtn").css("top",(scrH-136)/2);
			$("#tableDiv").css("height",scrH-97-60-52);
        	initTree();
        	add_btn_show();
        });
        	function initTree(){
        	var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},treeObj,pid;
        	$("#treeDemo a").each(function(){
        		if($(this).hasClass('curSelectedNode')){
        			onblue_park = $(this).attr("id");
        		}
        	});
        	//console.log(onblue_park)
        	$.ajax({
        		type:"GET",
        		url:"<c:url value='/projectmanagement/tree' />?new ="+new Date().getTime(),cache:false,
        		success:function(data){
					treeObj = $.fn.zTree.init($("#treeDemo"), setting, data);
					$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
					var treeH =$('#treeDemo').height();
					$('#treeDemo').find('a').children('span:odd').addClass('ellipsis')
					.css({'width':133,'display':'inherit'});
					if(onblue_park != undefined){
						//console.log(onblue_park.parent().html());
						$("#treeDemo a").each(function(){
							if($(this).attr("id") == onblue_park){
								$(this).addClass('curSelectedNode');
							}
						})
						//onblue_park.addClass('curSelectedNode');
						//console.log(onblue_park.parent().html());
						$("#treeDemo a").click(function(){
							$("#treeDemo a.curSelectedNode").removeClass('curSelectedNode');
						})
					}
			}});
			$("#treeFoot").click(function(){
        		rating=0;isFirst=true;pid=-1;
        		//点击全部时   移除所有level0中的curSelectedNode样式
				$(this).children('span').addClass('cur');
        		$(".curSelectedNode").removeClass("curSelectedNode");
        		$(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
        		getValue(pid,0);
        		add_btn_show(rating);
        	});
        	function onClick(event,treeID,treeNode,clickFlag) {
				pid = treeObj.getSelectedNodes()[0].id;
				$("#treeFoot").children('span').removeClass('cur');
				$("#Pagination").empty();
				if(pid == null || pid == "") return;
				rating=treeNode.level==0?1:2;
				$("#lastTreeClick").val(pid);
				$(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
				isFirst = true;
				if(rating==1){$("#clickRegion").val(pid);}
				if(rating==2){$("#clickPark").val(pid);}
				add_btn_show(rating);
				getValue(pid,0);
			}
        	}
        	//加载右侧列表
        	function getValue(pid,page,isH){
        		//console.log("get:["+pid+"|"+page+"|"+rating+"]");
        		data = {id:pid,page:page,rating:rating};
        		if(isH!=undefined){data=lastData;}
        		lastData=data;
        		$.ajax({type:"GET",url:"<c:url value='/projectmanagement/lists' />",
        			data:data,cache:false,
					success:function(data){
						$("#tableDiv").empty().html(data);
						if(isFirst) initPagination($("#tableDiv #count").val());
						//initEditor();
					}
				});
        	}
        	
        	function initPagination(pagers) {
        		var rows = $('table','#tableDiv').find('tr').length;
        		if(pagers == 'undefined' || pagers == 0 || (rows-1) <= 20){return;}
				$("#Pagination").pagination(pagers, {
					num_edge_entries: 1,
					num_display_entries: 4,
					callback: pageselectCallback,
					items_per_page: 1,
					prev_text: "上一页",
					next_text: "下一页"
				});
			 }
        	
        	function pageselectCallback(page_index, jq){
        		if(isFirst) {isFirst = false;return;}
				getValue(pid,page_index);
				return false;
			}
            $("#nyglinul li").bind("click", function () {
                $("#nyglinul li").removeClass("nyglinulsel");
                $(this).addClass("nyglinulsel");
            });
            $(".curSelectedNode span:first-child").css("background", "url(./img/img_23.png)");
            function initEditor(){
            	
            }
        //modify by Y 2015-02-03  新增参数，根据参数来跳转不同 的显示页面 begine
        //function edit(id,elv){
        function edit(id,elv,type){
        //modify by Y 2015-02-03  新增参数，根据参数来跳转不同 的显示页面 end
        	var clickPark = $('#clickPark').val();
        	if(typeof(rating)==undefined){return;}
        	var url = "<c:url value='/projectmanagement/operator'/>?new ="+new Date().getTime()+"&clickPark="+$('#clickPark').val();
        	switch(rating){
        		case 0:
        		case 1:$("#pop-onupdate").css({'width':'780px','height':'350px'});break;
        		case 2:$("#pop-onupdate").css({'width':'780px','height':'580px'});break;
        	}
        	$.ajax({type:"POST",data:{id:id,rating:rating,elv:elv,clickPark:clickPark,type:type},url: url,cache:false,
				success: function(data){
					$("#pop-onupdate").empty().html(data);
		      }
        	});
        }
        
        function add_btn_show(rating){
        	if(typeof(rating)==undefined){$(".add").css("display","none");return;}
        	switch(rating){
	    		case 0:$(".add").css("display","none");$("#region_add").css("display","block"); break;
	    		case 1:$(".add").css("display","none");$("#park_add").css("display","block"); break;
	    		case 2:$(".add").css("display","none");$("#pro_add").css("display","block"); break;
	    		default:$(".add").css("display","none");
    		}
        }
        function del(id){
	        if(id==undefined||rating==undefined){return;}
	        /*
	        var msg = "你真的要删除？请确认！";
	      //  switch(rating){
	       // 	case 0:msg="经济区下没有园区才可以删除\n\n请确认！";break;
	        //	case 1:msg="园区下没有项目才可以删除\n\n请确认！";break;
	       // }
	        jConfirm(msg,"确定",function(r){
	        	if(r == true){
	        		$.ajax({
			        	type:"POST",data:{id:id,rating:rating},cache:false,
			        	url:"<c:url value='/projectmanagement/delete' />?new ="+new Date().getTime(),
			        	success:function(data){
			        		if(data == "parent"){
			        			jAlert("当前园区下有项目记录，不能删除","确定",function(r){
									
									if(r == true){
										jAlert("删除失败");
									}
								});
			        		}else if(data == 'E'){
			        			jAlert("删除失败");
			        		}else{
			        			jAlert("删除成功！");
			        			initTree();
			        			getValue($("#lastTreeClick").val(),0,'D');
			        		}
			        	}
			        });
	        	}
	        });*/
	        if(rating==0||rating==1){
	    		$.ajax({
		        	type:"POST",data:{id:id,rating:rating},cache:false,
		        	url:"<c:url value='/projectmanagement/checkdelete' />?new ="+new Date().getTime(),
		        	success:function(data){
		        		if(data == "parent"){
		        			jAlert("当前园区下有项目记录，不能删除！");
		        		}else if(data == "parent_parent"){
		        			jAlert("当前经济区下有园区记录，不能删除！");
		        		}else if(data == 'E'){
		        			if(rating==0){
		        				jAlert("后台异常，经济区删除失败！");
		        			}else{
		        				jAlert("后台异常，园区删除失败！");
		        			}
		        		}else{
		        			_del_content(id);
		        		}
		        	},
		        	error : function(){
		        		if(rating==0){
	        				jAlert("后台异常，经济区删除失败！");
	        			}else{
	        				jAlert("后台异常，园区删除失败！");
	        			}
					}
		        });
	        }else{
	        	_del_content(id);
	        }
       	}
        
        function _del_content(id){
        	var msg = "确定要删除吗？";
	        jConfirm(msg,"确定",function(r){
	        	if(r == true){
	        		$.ajax({
			        	type:"POST",data:{id:id,rating:rating},cache:false,
			        	url:"<c:url value='/projectmanagement/delete' />?new ="+new Date().getTime(),
			        	success:function(data){
			        		if(data == 'E'){
			        			jAlert("删除失败！");
			        		}else{
			        			jAlert("删除成功！");
			        			initTree();
			        			getValue($("#lastTreeClick").val(),0,'D');
			        		}
			        	},
			        	error : function(){
			        		jAlert("删除失败！");
			        	}
			        });
	        	}
	        });
        }
    </script>
    <style type="text/css">
	    ul.ztree {
		    overflow-y: hidden;
	    }
    </style>
</head>
<body>
	<jsp:include page="../../header.jsp"></jsp:include>
    <div id="container">
        <div id="LeftCol" class="LeftCol LeftCol2 LeftCol-fafafa" style="overflow-x:hidden;">
				<p class="park-select-title mb5">园区选择</p>
				<a id = "treeFoot" href="javascript:;" style="background:url('<c:url value="/resources/img/select-img.png" />') no-repeat scroll left 4px; ">
				<span>全部</span></a>
				<ul id="treeDemo"  class="ztree" style="height:auto;"></ul>
        </div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft">
            </div>
            <div class="content contentTop">
                <div class="topFilter tab">
                    <table class="putform">
                        <tbody><tr>
                            <td class="w100">
                                <!-- <span class="">项目名称：</span></td> -->
                            <td class="tleft">
                                <!-- <div class="fl xmgl_sarch">
                                    <input name="searchname" type="text" class="xmgl_input">
                                    <a id="searchproId" class="xmgl_serch"></a>
                                </div> -->
                                <shiro:hasPermission name="projectmanagement:regionadd">
                                 <a id="region_add" class="fr xmgl_srear add" href="#pop-onupdate" style="background: url('<c:url value="/resources/img/xmgl_nadd.png" />');" onclick="edit('0','A');" href="javascript:;"></a>
                                 </shiro:hasPermission>
                                 <shiro:hasPermission name="projectmanagement:parkadd">
                                 <a id="park_add" class="fr xmgl_srear add" href="#pop-onupdate" style="background: url('<c:url value="/resources/img/xmgl_nadd.png" />');" onclick="edit('0','A');" href="javascript:;"></a>
                                 </shiro:hasPermission>
                                 <shiro:hasPermission name="projectmanagement:proadd">
                                 <a id="pro_add" class="fr xmgl_srear add" href="#pop-onupdate" style="background: url('<c:url value="/resources/img/xmgl_nadd.png" />');" onclick="edit('0','A','1');" href="javascript:;"></a>
                                 </shiro:hasPermission>
                                 </td>
                        </tr>
                    </tbody></table>
                </div>
                 <div class="wrap">
                    <div class="datalist-div datalist-content-xmxxgl">
                    	<div id="tableDiv" class="tablediv-inner"></div>
                    	<div class="page mt10">
							<div id="Pagination" class="pagination"></div>
						</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--弹出框 --%>
    <input type="hidden" id="clickRegion" value=""/>
    <input type="hidden" id="clickPark" value=""/>
    <input type="hidden" id="lastTreeClick" value=""/>
    <div class="mod-pop xmxxgl-mod-pop" id="pop-onupdate"></div>
    
</body>
</html>
