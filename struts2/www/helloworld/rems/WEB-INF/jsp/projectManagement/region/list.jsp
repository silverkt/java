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
<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
    <script type="text/javascript">
        $(document).ready(function () {
        	//ztree加载
        	var ztree= null;
			$.ajax({type:"GET",url:"<c:url value='/projectmanagement/tree' />",success:function(data){
				ztree = $.fn.zTree.init($("#areaNames2"), setting, data);
				$.fn.zTree.getZTreeObj("areaNames2").expandAll(true);
			}});
			
            $("#nyglinul li").bind("click", function () {
                $("#nyglinul li").removeClass("nyglinulsel");
                $(this).addClass("nyglinulsel");
            });
            $(".area_choose li").bind("click", function () {
                $("#curArea").text(($(this).text()));
                $("#areaname span").text(($(this).text()));
                $(".area_choose").css("display", "none");
            });
            $("#xmgl_tbljxcx1 tr td:eq(2)").css("width","180px");
             //节点增加
            $("#btn_tjzj").click(function(){
            	 $.ajax({ 
					type:"POST",
					data: $("#projectmanagementFormId").serialize(),
					url: "<c:url value='/projectmanagement/add' />",
					success: function(data){
						ztree = $.fn.zTree.init($("#areaNames2"), setting, data);
						$.fn.zTree.getZTreeObj("areaNames2").expandAll(true);
			      }});
            });
             //节点增加
            $("#btn_xjzj").click(function(){
            	 $.ajax({ 
					type:"POST",
					data: $("#projectmanagementFormId").serialize(),
					url: "<c:url value='/projectmanagement/add' />?level=1",
					success: function(data){
						ztree = $.fn.zTree.init($("#areaNames2"), setting, data);
						$.fn.zTree.getZTreeObj("areaNames2").expandAll(true);
			      }});
            });
             //删除节点
              $("#deleteId").click(function(){
            	  var msg = "园区下没有项目才可以删除\n\n请确认！"; 
            	  jConfirm(msg,"确定",function(r){
            		  if (r==true){
						 $.ajax({ 
							type:"POST",
							data: $("#projectmanagementFormId").serialize(),
							url: "<c:url value='/projectmanagement/delete' />",
							success: function(data){
								ztree = $.fn.zTree.init($("#areaNames2"), setting, data);
								$.fn.zTree.getZTreeObj("areaNames2").expandAll(true);
					      }});
						}
            	  });
            });
              //修改节点
              $("#updateSelectId").click(function(){
            	 $.ajax({ 
					type:"POST",
					data: $("#projectmanagementFormId").serialize(),
					url: "<c:url value='/projectmanagement/update' />",
					success: function(data){
						ztree = $.fn.zTree.init($("#areaNames2"), setting, data);
						$.fn.zTree.getZTreeObj("areaNames2").expandAll(true);
			      }});
            });
              //根据节点查询项目list
              $("#detailListId").click(function(){
            	 $.ajax({ 
					type:"POST",
					data: $("#projectmanagementFormId").serialize(),
					url: "<c:url value='/projectmanagement/projectList' />",
					success: function(data){
						$("#projectbaseinfoListId").empty().html(data);
			      }});
            });
            //根据节点查询项目list
            $("#searchproId").click(function(){
            	searchTemp();
            });
            var screenH = $(window).height()-96;
            $("#LeftCol").height(screenH);
            $("#areaNames2").height(screenH-37);
            
        });
        function showtabs(mark, _this) {
            $(".xmlgl_left_shows").css("display", "none");
            $(".xmgl_set li").removeClass("xmgl_sel");
            if (mark == "1") {
                $(".xmgl_set li:eq(2)").children("img").attr("src", "../resources/img/xmgl_edt2.png");
                $(".xmgl_set li:eq(1)").children("img").attr("src", "../resources/img/xmgl_del2.png");
                $(_this).children("img").attr("src", "../resources/img/xmgl_add1.png");
                $(_this).addClass("xmgl_sel");
                $(".xmlgl_left_shows:eq(0)").css("display", "block");
                $("#markIddu").val("1");
            }
            else if (mark == "2") {
                $(".xmgl_set li:eq(0)").children("img").attr("src", "../resources/img/xmgl_add2.png");
                $(".xmgl_set li:eq(2)").children("img").attr("src", "../resources/img/xmgl_edt2.png");
                $(_this).children("img").attr("src", "../resources/img/xmgl_del1.png");
                $(_this).addClass("xmgl_sel");
                $(".xmlgl_left_shows:eq(1)").css("display", "block");
                 $("#markIddu").val("2");
            }
            else {
                $(".xmgl_set li:eq(0)").children("img").attr("src", "../resources/img/xmgl_add2.png");
                $(".xmgl_set li:eq(1)").children("img").attr("src", "../resources/img/xmgl_del2.png");
                $(_this).children("img").attr("src", "../resources/img/xmgl_edt1.png");
                $(_this).addClass("xmgl_sel");
                $(".xmlgl_left_shows:eq(2)").css("display", "block");
                 $("#markIddu").val("3");
            }
        }
        function showinfo(mark, _this) {
            if ($("#projectid").val() == "") {
                jAlert("请保存信息。");
                return false;
            }
            var changeNum = mark-1;
            $(".clear").css("display", "none");
            $(".clear:eq(" + changeNum + ")").css("display", "block");
            $(".xmgl_tbladd").css("display", "none");
            $("#xmgl_tbljxcx" + mark).css("display", "block");
            $(".xmgl_taba").removeClass("xmgl_tabasel");
            $(_this).addClass("xmgl_tabasel");
        }
        /**
         * 保存项目信息
         */
        function saveInfo() {
			if(validateBaseInfoForm()){
				if($("#industryclass").val()== ''){
					$("#industryclass_err").show();
					return false;
				}
				if($("#industrytype").val()==''){
					$("#industrytype_err").show();
					return false;
				}
				if($("#businesstype").val()==''){
					$("#businesstype_err").show();
					return false;
				}
				if($("#groupid").val()==''){
					$("#groupid_err").show();
					return false;
				}
				if($("#regionid").val()==''){
					$("#regionid_err").show();
					return false;
				}
				if($("#parkid").val()==''){
					$("#parkid_err").show();
					return false;
				}
				if($("#districtid").val()==''){
					$("#districtid_err").show();
					return false;
				}
				if($("#longitude").val()==''){
					$("#longitude_err").show();
					return false;
				}
				if($("#latitude").val()==''){
					$("#longitude_err").show();
					return false;
				}
				var projectid = $("#projectid").val();
				var projectname = $("#projectnameId").val();
				var proabbreviation = $("#proabbreviation").val();
				var industryclass = $("#industryclass").val();
				var industrytype = $("#industrytype").val();
				var businesstype = $("#businesstype").val();
				var groupid = $("#groupid").val();
				var regionid = $("#regionid").val();
				var parkid = $("#parkid").val();
				var districtid = $("#districtid").val();
				var longitude = $("#longitude").val();
				var latitude = $("#latitude").val();
				var address = $("#address").val();
				var designcompany = $("#designcompany").val();
				var buildcompany = $("#buildcompany").val();
				var heatingstart = $("#heatingstart").val();
				var heatingend = $("#heatingend").val();
				var remarks = $("#remarks").val();
				var coldingstart = $("#coldingstart").val();
				var coldingend = $("#coldingend").val();
				var buildingarea = $("#buildingarea").val();
				var investcompany = $("#investcompany").val();
				var investment = $("#investment").val();
				var supplyarea = $("#supplyarea").val();
				var pictureptah = $("#pictureptah").val();
				var dt = {"projectid":projectid,"projectname":projectname,
					"proabbreviation":proabbreviation,
					"industryclass":industryclass,
					"industrytype":industrytype,
					"businesstype":businesstype,
					"groupid":groupid,
					"regionid":regionid,
					"parkid":parkid,
					"districtid":districtid,
					"longitude":longitude,
					"latitude":latitude,
					"address":address,
					"designcompany":designcompany,
					"buildcompany":buildcompany,
					"heatingstart":heatingstart,
					"heatingend":heatingend,
					"remarks":remarks,
					"coldingstart":coldingstart,
					"coldingend":coldingend,
					"buildingarea":buildingarea,
					"investcompany":investcompany,
					"investment":investment,
					"supplyarea":supplyarea,
					"pictureptah":pictureptah
					}
				$.ajaxFileUpload({ 
					url: "<c:url value='/projectmanagement/projectSave' />",
					type:"POST",
					fileElementId:'myBlogImage',
					dataType: 'text',
					data: dt,
					success: function(data,state){
						$("#projectid").val(data);
						$("#projectid_zdy").val(data);
						$("#projectid_fh").val(data);
						if($("#operate").val()=="edit"){
							jAlert("项目信息编辑成功!");
						}
						else{
							jAlert("项目信息保存成功!");
						}
						
						
			      }});
			}
        }
        //验证表单
        function validateBaseInfoForm(){
        	//表单验证
        	var projectid = $("#projectid").val();
	        return $("#projectBasdInfoFormId").validate({
	        	wrapper:"div",
				rules:{
					projectname:{
						required:true,
						remote:"checkProjectName?projectid="+projectid
					},
	        		proabbreviation:{
						required:true
					}
				},
				messages:{
					projectname:{
						remote:"项目名已存在",
						required:"项目名必填"
					},
					proabbreviation:{
						required:"项目简称必填"
					}
				}
	        }).form();
        }
        /**
         * 保存自定义信息
         */
        function saveSelfInfo() {
        	if ($("#projectid_zdy").val() == "") {
                jAlert("请保存项目信息。");
                return false;
            }
        	$.ajax({ 
					type:"POST",
					data: $("#projectselfInfoForm").serialize(),
					url: "<c:url value='/projectmanagement/selfInfoSave' />",
					success: function(data){
						if($("#operate").val()=="edit"){
							jAlert("自定义信息编辑成功!");
						}
						else{
							jAlert("自定义信息保存成功!");
						}
						
			      }});
        }
        /**
         * 保存项目负荷信息
         */
        function saveProjectDesignload() {
        	$.ajax({ 
					type:"POST",
					data: $("#projectDesignloadForm").serialize(),
					url: "<c:url value='/projectmanagement/saveDesignload' />",
					success: function(data){
						if($("#operate").val()=="edit"){
							jAlert("项目负荷信息编辑成功!");
						}
						else{
							jAlert("项目负荷信息保存成功!");
						}
						$.fancybox.close();
						searchTemp();
			      }});
        }
        
        //删除项目
        function deleteProjectInfo(projectid) {
        	var msg = "你真的要删除？\n\n请确认！"; 
        	jConfirm(msg,"确定",function(r){
        		if (r==true){
					$.ajax({
			        	type:"POST",
			        	data:{projectid:projectid},
			        	url:"<c:url value='/projectmanagement/deleteProjectBaseInfo' />",
			        	success:function(data){
			        		jAlert("删除成功！");
			        		searchTemp();
			        	}
			        });
				}
        	});
			
        }
        //update项目
        function updateProjectTurn(projectId) {
        	$.ajax({ 
				type:"POST",
				data:{projectid:projectId},
				url: "<c:url value='/projectmanagement/updateProjectTurn' />",
				success: function(data){
					$("#pop-onupdate").html(data);
					
		      }});
        }
        //删除操作，添加，刷新
        function searchTemp(){
        	$.ajax({ 
					type:"POST",
					data: $("#projectmanagementFormId").serialize(),
					url: "<c:url value='/projectmanagement/projectSearch' />",
					success: function(data){
						$("#projectbaseinfoListId").empty().html(data);
			      }});
        }
        //新增按钮
        function addProjectBaseInfo(){
       		$.ajax({ 
				type:"POST",
				url: "<c:url value='/projectmanagement/addProjectTurn' />",
				success: function(data){
					$("#pop-onupdate").html(data);  
		      }});
        }
    </script>
    <style type="text/css">
	    .xmlgl_left_shows {
		    margin: 0px auto;
		}
    	.xmlgl_left_shows table tr td .btnset {
		    margin: 0 auto;
		}
    </style>
</head>
<body>
    <jsp:include page="../../header.jsp"></jsp:include>
    <div id="container" class="">
    	<form id="projectmanagementFormId" action="" method="post">
        <div id="LeftCol" class="LeftCol" style="min-height: 500px; background: #fff;">
	    <input name="regionidORparkid" type="hidden" id="select_addhidden"/>
	    <input name="table" type="hidden" id="tablenameID"/>
	    <input name="selectedId" type="hidden" id="selectedId"/>
	    <input type="hidden" id="markIddu" value="2"/>
            <div>
                <img src="../resources/img/xmglLeft.png" style="width: 100%;height: 28px;">
            </div>
            <ul id="areaNames2" class="ztree" style="width: auto;overflow: auto;"></ul>
            <%--<div class="left_foot_cont" style="width: 227px;">
                <div class="xmgl_left_head" style="width: 227px;">
                    <ul class="xmgl_set" style="width: 227px;">
                        <li onclick="showtabs(1,this);" style="margin-left: 24px;">
                            <img src="../resources/img/xmgl_add2.png">添加</li>
                        <li onclick="showtabs(2,this);" class="xmgl_sel" style="margin-left: 24px;">
                            <img src="../resources/img/xmgl_del1.png">删除</li>
                        <li onclick="showtabs(3,this);" style="margin-left: 24px;">
                            <img src="../resources/img/xmgl_edt2.png">修改</li>
                    </ul>
                </div>
                <div class="xmlgl_left_shows" style="display: none;width: 227px;">
                    <table>
                        <tbody><tr>
                            <td colspan="2">
                                <input type="text" name="name" id="select_add" class="xmgl_txt">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="xmgl_btn" id="btn_tjzj" type="button" value="同级增加"></td>
                                <td><input class="xmgl_btn" id="btn_xjzj" type="button" value="下级增加">
                             </td>
                        </tr>
                    </tbody></table>
                </div>
                <div class="xmlgl_left_shows" style="display: block;width: 227px;">
                    <table>
                        <tbody><tr>
                            <td id="select_del">请选择...</td>
                        </tr>
                        <tr>
                            <td>
                                <input class="xmgl_btn btnset" id="deleteId" type="button" value="确定删除"></td>
                        </tr>
                    </tbody></table>
                </div>
                <div class="xmlgl_left_shows xmlgl_left_edt" style="display: none;width: 227px;">
                    <table>
                        <tbody><tr>
                            <td>
                                <input name="nameUpdate" type="text" value="请选择..." id="select_edt" class="xmgl_txt"></td>
                        </tr>
                        <tr>
                            <td>
                                <input id="updateSelectId" class="xmgl_btn btnset" type="button" value="确定修改"></td>
                        </tr>
                    </tbody></table>
                </div>

            </div>
            <input id="detailListId" type="button" class="xmgl_detail" value="查看详细" style="margin: 0 auto;">
		
        --%></div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft">
            </div>
            <div class="content contentTop">
                <div class="topFilter tab">
                    <table class="putform">
                        <tbody><tr>
                            <td class="w100">
                                <span class="">项目名称：</span></td>
                            <td class="tleft">
                                <div class="fl xmgl_sarch">
                                    <input name="searchname" type="text" class="xmgl_input">
                                    <a id="searchproId" class="xmgl_serch"></a>
                                </div>
                                <a class="fr fancybox xmgl_srear" onclick="addProjectBaseInfo();" href="#pop-onupdate"></a></td>
                        </tr>
                    </tbody></table>
                </div>
                <div class="wrap" id="projectbaseinfoListId"></div>
            </div>
        </div>
    </div>
    </form>
    <div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    <div class="mod-pop" id="pop-onupdate" style="width: 780px; height:580px;"></div>
</body>
</html>
		