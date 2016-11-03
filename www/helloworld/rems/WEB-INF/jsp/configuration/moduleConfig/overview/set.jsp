<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<style type="text/css">
	.edi-homeio{width: 450px;height:320px;}
	.edi-homepage{width: 450px;height:250px;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	var projectId=$('#projectId').val();
	initPage(projectId);
});
function initPage(projectid){
	initSelections(projectid);
	initHomeIO(projectid,0);
	initHomeIO(projectid,1);
	initCircular(projectid);
	initSite3D(projectid);
	if($('#weatherCid').val()!=null){
		changeSelection($('#weatherSel'),$('#weatherCid').val())
	}
}
/*
 * 输入输出设置数据载入
 */
function initHomeIO(projectid,datatype){
$.ajax({type: "GET",url: "<c:url value='/moduleconfig/listHomeIO'/>",cache:false,
	data:{projectid:projectid,datatype:datatype},
	success: function (data) {
		var box;
		if(datatype=="0"){$box = $("#box-homeios-in");}
		if(datatype=="1"){$box = $("#box-homeios-out");}
		$box.empty().html(data);
		var classinstanceid = $box.find("input[name='classinstanceid']").val() || '';
		var $selection = $box.parent('div.mksjpzglszbInner').find('.mod-select');
		changeSelection($selection,classinstanceid);
	},error:function(){
		jAlert('加载失败！');
	}
});
}
/*
 * 环状图数据载入
 * modelid=1
 */
function initCircular(projectid){
$.ajax({type: "GET",url: "<c:url value='/moduleconfig/listHomepage'/>",cache:false,
	data:{projectid:projectid,modelid:1},
	success: function (data) {
		var $box = $("#box-circular");
		$box.empty().html(data);
		var classinstanceid = $box.find("input[name='classinstanceid']").val();
		var $selection = $box.parent().find('.mod-select');
		changeSelection($selection,classinstanceid);
		var tCount = $box.find('table').find('tbody').find('tr').length;
		if(tCount>=4){
			$("#circularBtn").hide();
		}else{
			$("#circularBtn").show();
		}
	},error:function(){
		jAlert('加载失败！');
	}
});
}
function initSite3D(projectid){
$.ajax({type: "GET",url: "<c:url value='/moduleconfig/listSite3D'/>",cache:false,
	data:{projectid:projectid},
	success: function (data) {
		var $box = $("#box-site3d");
		$box.empty().html(data);
	},error:function(){
		jAlert('加载失败！');
	}
});
}
function popEditor(obj,poptype,edittype){
	var $editor
	, $btn;
	switch(poptype){
		case '1':$editor = $('#pop-ediCons');$btn = $('.consBtn');break;
		case '2':$editor = $('#pop-ediSupply');$btn = $('.supplyBtn');break;
		case '3':$editor = $('#pop-ediPros');$btn = $('.circularBtn');break;
	}
	$editor.empty();
	if(edittype == "A"){
		var $box = $(obj).parent().parent().parent().find('.mksjpzTableBox');
	}else if(edittype == "E"){
		var $box = $(obj).parent().parent().parent().parent().parent().parent().find('.mksjpzTableBox');
	}
	var modSelId=$box.parent().find(".modSelect").val();
	if(modSelId==""){
		jAlert('请选择设备！');
		return;
	}else{
		var t = $btn.fancybox({padding:0});
		var pid = $("#projectId").val();
		var modelid = $(obj).parent().find("input[name='modelid']").val();
		if(poptype=='3'){
			var id = $(obj).parent().find("input[name='id']").val();
		}
		var data = {pid:pid,poptype:poptype,classinstanceid:modSelId,edittype:edittype,modelid:modelid,id:id};
		/*$editor.empty();
		switch(poptype){
			case 1 : $editor.addClass('edi-homeio');break;
			case 2 : $editor.addClass('edi-homepage');break;
		}*/
		$.ajax({url: "<c:url value='/moduleconfig/operator' />",type:"GET",data: data,cache:false,
			success: function(data){
				$editor.empty().html(data);
				$btn.fancybox({padding:0});
				if(edittype == "A"){
					var location = $box.find('table').find('tr:last').find("input[name='location']").val();
					if(location == 'undefined' || location == undefined){location = 1;}else{location = (parseInt(location)+1);}
					$editor.find("input[name='projectid']").val(pid);
					$editor.find("input[name='classinstanceid']").val(modSelId);
					$editor.find("input[name='location']").val(location);
					$editor.find("#edittype").val(edittype);
				}
			},error:function(){
				jAlert('加载失败！');
			}
		});
	}
}
function tt(obj){$('.newButton').fancybox({padding:0});}
function delModuleConfig(obj){
	//if(confirm("你真的要删除这条数据？\n\n请确认！")==true){
		var $dataTD = $(obj).parent();
		var projectid = $dataTD.find("input[name='projectid']").val();
		var modelid = $dataTD.find("input[name='modelid']").val();
		var iotype = $dataTD.find("input[name='iotype']").val();
		var classinstanceid = $dataTD.find("input[name='classinstanceid']").val();
		
		var data = {modelid:modelid};
		$.ajax({url: "<c:url value='/moduleconfig/deleteModuleConfig' />",type:"POST",data: data,cache:false,
			success: function(data){
				jAlert(data);
			},error:function(){
				jAlert('删除失败！');
			}
		});
	/*}else{
		return false;
	}*/
}
</script>                    
 <div class="mksjpzglszBlock" id="c1b1">
     <div class="mksjpzglszbInner">
         <p class="mksjpzTitle">耗能设置</p>
         <div class="mksjpzLine clearfix">
             <div class="mod-select mksjpzMs">
                 <p class="text ellipsis w205">选择设备</p>
                 <span class="arr-group hand">
                     <i class="icon-mod icon-arr"></i>
                     <input type="hidden" class="modSelect" value="" />
                 </span>
                 <div class="list">
                     <ul></ul>
                 </div>
             </div>
             <span class="newButton p410 right consBtn" href="#pop-ediCons" onclick="popEditor(this,'1','A')">新增</span>
         </div>
         <div id="box-homeios-in" class="mksjpzTableBox">
         </div>
     </div>
 </div>
 <!--end-->
 <!--start-->
 <div class="mksjpzglszBlock" id="c1b2">
     <div class="mksjpzglszbInner">
         <p class="mksjpzTitle">供能设置</p>
         <div class="mksjpzLine clearfix">
             <div class="mod-select mksjpzMs">
                 <p class="text w205 ellipsis">选择设备</p>
                 <span class="arr-group hand">
                     <i class="icon-mod icon-arr"></i>
                     <input type="hidden" class="modSelect" value="" />
                 </span>
                 <div class="list">
                     <ul></ul>
                 </div>
             </div>
             <span class="newButton p410 right supplyBtn" href="#pop-ediSupply" onclick="popEditor(this,'2','A')">新增</span>
         </div>
         <div id="box-homeios-out" class="mksjpzTableBox">
         </div>
     </div>
 </div>
 <!--end-->
 <!--start-->
 <div class="mksjpzglszBlock" id="c1b3">
     <div class="mksjpzglszbInner">
         <p class="mksjpzTitle">实时监测设置</p><input type="hidden" id="before" value="项目状态设置"/>
         <div class="mksjpzLine clearfix">
             <div id="state" class="mod-select mksjpzMs">
                 <p class="text w205 ellipsis">选择设备</p>
                 <span class="arr-group hand">
                     <i class="icon-mod icon-arr"></i>
                     <input type="hidden" class="modSelect" value="" />
                 </span>
                 <div class="list">
                     <ul></ul>
                 </div>
             </div>
             <span id="circularBtn" class="newButton p410 right circularBtn" href="#pop-ediPros" onclick="popEditor(this,'3','A')">新增</span>
         </div>
         <div id="box-circular" class="mksjpzTableBox"></div>
     </div>
 </div>
 <!--end-->
 <!--start-->
 <div class="mksjpzglszBlock" id="c1b4">
 <input type="hidden" name="flag" value="single"/>
 <input type="hidden" name="modelid" value="7"/>
 <input type="hidden" name="propertytypeid" value="8"/>
 <input type="hidden" id="weatherCid" value="${weatherCid}" />
     <div class="mksjpzglszbInner">
         <p class="mksjpzTitle">气象数据设置</p>
         <div class="mksjpzLine clearfix">
             <div id="weatherSel" class="mod-select mksjpzMs">
                 <p class="text w205 ellipsis">选择设备</p>
                 <span class="arr-group hand">
                     <i class="icon-mod icon-arr"></i>
                     <input type="hidden" name='device' class="modSelect" value="" />
                 </span>
                 <div class="list">
                     <ul></ul>
                 </div>
             </div>
             <span class="newButton p410 right quickSub">保存</span>
         </div>
     </div>
 </div>
 <!--end-->
 <!--start-->
 <div class="mksjpzglszBlock" id="c1b5">
     <div class="mksjpzglszbInner">
         <p class="mksjpzTitle">站点图设置/3D图</p>
         <div id="box-site3d" class="mksjpzTableBox"></div>
     </div>
 </div>
 <!--end-->
 <div class="mod-pop xzxtzbBlock" id="pop-ediCons" style="min-height: 455px;"></div>
 <div class="mod-pop xzxtzbBlock" id="pop-ediSupply" style="min-height: 300px;"></div>
 <div class="mod-pop xzxtzbBlock" id="pop-ediPros" style="min-height: 214px;"></div>
