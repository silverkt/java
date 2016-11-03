﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/include.inc.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
        <!-- 能效指标对比 -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>远程能源管理系统</title>
	<link href="<c:url value='/resources/js/zTree_v3/css/zTreeStyle/zTreeStyle.css' />"/>
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/zTree_v3/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
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
    <script src="<c:url value='/resources/js/zTree_v3/js/jquery.ztree.excheck-3.5.js' />"></script>
    <script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <script src="<c:url value='/resources/js/areaNames.js' />"></script>
	<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>

<script type="text/javascript">
        $(document).ready(function () {
			var scrH=$(window).height()- 95;
		
			$(".left-nav").css("height",scrH-45);
			$("#areaNames").css("height","auto");
            $("#nyglinul li").bind("click", function () {
                $("#nyglinul li").removeClass("nyglinulsel");
                $(this).addClass("nyglinulsel");
            });
            $(".area_choose li").bind("click", function () {
            	val = $(this).attr("val");//当前选中值
                $("#curArea").text(($(this).text()));
                $("#areaname span").text(($(this).text()));
                $(".area_choose").css("display", "none");
            });
            //提交表单数据
		 $("#energyDataListId").click(function(){
			 //数据权限
			var ids = "";
			var nodes = ztree.getCheckedNodes();
			
			for(var i=0;i<nodes.length;i++){
				if(nodes[i].children.length==0){
					var id=nodes[i].id;
					ids=ids+id+",";
				}
			}
			ids=ids.substring(0,ids.length-1);
			$("#ids").val(ids);
			//异步之前需要选择能源站
			if ($("#ids").val() == "") {
                jAlert("请选择能源站。");
                return false;
            }
			//alert($("#ids").val());
			if($("#ids").val().split(",").length>6){				
				jAlert("最多只能选择5个能源站，请重新选择！");
				return false;
			}
			if($("#sDay").css("display")=="block"){
				if($("#sDay").val()>$("#temp_input1").val()){				
					jAlert("起止时间选择有误，请重新选择!");
					return false;				
				}
			}
			
			$.ajax({ 
				type:"POST",
				data: $("#contrastFormId").serialize(),
				url: "<c:url value='/analyseContrast/content' />",
				success: function(data){
					$("#dataListContentId").empty().html(data);
		      }});
			});
        });
        var ztree= null;
		$.ajax({type:"GET",url:"<c:url value='/analyseContrast/tree' />",success:function(data){
			ztree = $.fn.zTree.init($("#areaNames"), setting, data);
			$.fn.zTree.getZTreeObj("areaNames").expandAll(true);
			$('#areaNames').find('a').children('span:odd').addClass('ellipsis').css(
					{
						'width':119
						,'display':'inherit'
					});
		}});
		function hideDate(dp){
			jAlert(dp.$D('temp_input1'));
		}
        function isShow(val, _this) {
            if (val == "1") {
                if ($(_this).parent("p").attr("checkval") == "2") {
                	 $("#temp_span1").css("display","inline");
                  	$("#sDay").css("display","block");
                    $(_this).parent("p").attr("class", "is_can");
                    $("#is_can a").css("color", "#5b636c");
                    $(_this).css("color", "#fff");
                    $(_this).parent("p").attr("checkval", "1")
                }
                $('#radioSelectId').val("1");
            }
            else {
                if ($(_this).parent("p").attr("checkval") == "1") {
                  $("#temp_span1").css("display","none");
                  $("#sDay").css("display","none");
                  
                  $("#temp_input1").attr("onfocus","WdatePicker({dateFmt:'yyyy-M-dd',maxDate:'%y-%M-%d'})");
                  
                    $(_this).parent("p").attr("class", "is_no");
                    $("#is_can a").css("color", "#5b636c");
                    $(_this).css("color", "#fff");
                    $(_this).parent("p").attr("checkval", "2")
                }
                $('#radioSelectId').val("2");
            }
        }
    </script>
</head>
<body>
    <jsp:include page="../../header.jsp"></jsp:include>
    <div id="container" class="">
    <form id="contrastFormId" action="/analyseContrast/content" method="post">
    <input type="hidden" id="cidId" name="classpropertyid" value="0"/>
        <div id="LeftCol" class="LeftCol LeftCol2 left-nav" style="background: #fff; width:222px; position: relative;">
           <div class="left-nav">
	           <div class="area_head" style="width:222px;" id="areaname"><span>能源站点</span> </div>
	           <input type="hidden" id="ids" name="treePids" value="0"/>
               
	            <ul id="areaNames" class="ztree" style="width: 210px; overflow:auto;"></ul>
            </div>
        </div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft">
            </div>
            <input type="hidden" id="radioSelectId" name="radioSelect" value="1"/>
            <div class="content contentTop">
                <div class="topFilter tab">
                    <table class="putform">
                        <tr>
                            <td class="w60 w120" >
                               <p id="is_can" class="is_can" checkval="1"><a class="is_can_sel" onclick="isShow(1,this)">能效</a><a onclick="isShow(2,this)">指标</a></p> 
                            </td>
                            <td class="w100" >
                                <span class="">时间范围：</span></td>
                            <td class="tleft">
                                <div class="fl tab-panel" style="display: block;">
                                	<input id="sDay" name="sday" type="text" class="Wdate itxt Wdate2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"  style="width:126px; float:left; background:url('<c:url  value="/resources/img/datePicker2.png"/>')"  autocomplete="off" value="${yDay}"/>
                                    <span id="temp_span1" class="ml5 mr5" style="  float:left; line-height:30px;">到</span>
                                    <input id="temp_input1" name="eday" type="text" class="Wdate itxt Wdate2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'sDay\')}'})"  style="width:126px;  float:left;  background:url('<c:url  value="/resources/img/datePicker2.png"/>')"  autocomplete="off" value="${curDay}"/>
                                    
                                </div>
                                <a id="energyDataListId" class="viewbtn2 ml20" style="float:left; ">查看数据</a 
                            ></td>
                        </tr>
                    </table>
                </div>
                <div id="dataListContentId" class="datalist-content-contrast wrap" style="overflow-y:auto;"></div>
                </div>
            </div>
            </form>
        </div>
    </div>
    <div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
			<style>
				.ztree{overflow-x:hidden!important;overflow-y:auto !important;}
			</style>
        </div>
    </div>
</body>
</html>