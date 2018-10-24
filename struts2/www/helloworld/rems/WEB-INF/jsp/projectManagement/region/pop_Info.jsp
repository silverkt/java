<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/include.inc.jsp"%>
<style>
label.error{color:red !important;padding-left:0 !important;}
label{background:none!important;}
</style>
<!-- 基础信息 -->
<script type="text/javascript">
$(document).ready(function(){
	var elv = $('#elv').val();
	var flag = true;
	if(elv == 'E'){
		var pro = $('#szqSelectId p').text();
		var city = $('#xzqSelectIdc p').text();
		if(pro == city){
			$('#xzqSelectIdc').hide();
		}
	}
	initProjectState();
	initBaiduMap();
	//选择项目类别
	$('#xmlbListId').simSelect({callback: function (x,v) {
		if(v){
			$('#industryclass_err').hide();
		}
		if(!x) return;
		$(this).find('input').val(v);
		//加载ajax请求参数内容
		$.ajax({type:"POST",url: "<c:url value='/projectmanagement/xmlbSelect' />?new ="+new Date().getTime(),data: {id:v},
			success: function(data){
				var $cs = $('#xhListId');
				$('ul',$cs).empty().append(data);//参数
				$('.text',$cs).text('选择参数...');
				$cs.simSelect({callback: function (x,v) {
					if(v){
						$('#industrytype_err').hide();
					}
					if(!x) return;
						$(this).find('input').val(v);
					}
				});
			},error:function(){
				jAlert('加载失败!');
			}
		});
	}});
	
	
	$('#xhListId').simSelect({callback: function (x,v) {
		if(v){
			$('#industrytype_err').hide();
		}
		if(!x) return;
			$(this).find("input").val(v);
	}});
	
	//选择商业模式
	$('#symsSelectId').simSelect({callback: function (x,v) {
		if(v){
			$('#businesstype_err').hide();
		}
		if(!x) return;
		$(this).find("input").val(v);
	}});

	//选择项目组
	$('#xmzSelectId').simSelect({callback: function (x,v) {
		if(v){
			$('#groupid_err').hide();
		}
		if(!x) return;
		$(this).find('input').val(v);
		//项目联动初始化经济区下拉框
		initRegionSelect(v,true);		
	}});
	//单独初始化经济区
	initRegionSelect($('#groupid').val(),false)
	//单独初始化园区
	initParkSelect($('#regionid').val(),false);
	//行政区
	$('#szqSelectId').simSelect({callback: function (x,v) {
		if(v){$("#districtid_err").hide();}
		if(!x) return;
		//$(this).find("input").val(v);
		//加载ajax请求参数内容
		var c = v.split(",");
		if(c.length==2){
			var b = c[1];//直辖市标记
			if(b=='MUNICIPALITY'||b=='OTHER'){
				$("#districtid").val(v);
				$("#xzqSelectIdc").css("display","none");
			}else{
				$("#xzqSelectIdc").show();
			}
			$.ajax({type:"POST",url: "<c:url value='/projectmanagement/citySelect' />?new="+new Date().getTime(),data: {id:c[0]},
			success: function(data){
				var $cs = $('#xzqSelectIdc');
				$('ul',$cs).empty().append(data);//参数
				$('.text',$cs).text('选择参数...');
				$cs.simSelect({callback: function (x,v) {
					if(v){
						$("#districtid_err").hide();
					}
					if(!x) return;
					$(this).find("input").val(v);
				}});
			},error:function(){
				jAlert('加载失败!');
			}});
		}else{
			jAlert("请选择行政区!");
		}
	}});

	//地图展示
	$("#mapid").click(function(){
		$("#allmap").css("display", "block");
		$("#xmgl_tbljxcx1").css("display", "none");
		$("#longitude_err").hide();
	});
	
	$('.project_state','#xmgl_tbljxcx1').find('> input').click(function(){
		var $ptd = $(this).parent('td');
		$ptd.find("#state").val($(this).val());
	});
	
	$("#projectBasdInfoFormId").find("input").each(function(){
		var v = $(this);
		var name = v.attr("name");
		if(name == "investment" || name == "buildingarea" || name == "supplyarea" ){
			v.blur(function(){
				var value = v.val();
				if(isNaN(value)){
					v.next().next().css("display","block");
					//$("#projectSubmit").off("click",saveInfo);
					flag = false;
				}else{
					v.next().next().css("display","none");
					flag = true;
					//$("#projectSubmit").on("click",saveInfo);
				}
			});
		}
	});
	
	$("#projectDesignloadForm").find("input").each(function(){
		var v = $(this);
		var name = v.attr("name");
		if(name == "configureid_lfh_v" || name == "configureid_zqfh_v" || name == "configureid_dfh_v" || name == "configureid_rfh_v" || name == "configureid_rsfh_v"){
			v.blur(function(){
				var value = v.val();
				if(isNaN(value)){
					v.parent().parent().next().children('td').eq(v.parent().index()).children('div').css("display","inline");
					//$("#projectSubmit").off("click",saveProjectDesignload);
					flag = false;
				}else{
					v.next().css("display","none");
					flag=true;
					// $("#projectSubmit").on("click",saveProjectDesignload);
				}
			});
		}
	});
	if(elv=='V'){
		$("#pop-onupdate").simReadOnly();
	}
	$("#projectnameId").on('blur',checkProject);
	$("#projectnameId").focus();
	closeFancybox();//关闭fancybox
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
	}else if (mark == "2") {
			$(".xmgl_set li:eq(0)").children("img").attr("src", "../resources/img/xmgl_add2.png");
			$(".xmgl_set li:eq(2)").children("img").attr("src", "../resources/img/xmgl_edt2.png");
			$(_this).children("img").attr("src", "../resources/img/xmgl_del1.png");
			$(_this).addClass("xmgl_sel");
			$(".xmlgl_left_shows:eq(1)").css("display", "block");
			$("#markIddu").val("2");
		}else {
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
		if(isNaN($('#supplyarea').val())){
			$('#supplyarea').parent().find('.inputerror').show();
			return false;
		}
		if(isNaN($('#buildingarea').val())){
			$('#buildingarea').parent().find('.inputerror').show();
			return false;
		}
		if(isNaN($('#investment').val())){
			$('#investment').parent().find('.inputerror').show();
			return false;
		}
		$('.inputerror').hide();
		var datas = getData();
		$.ajaxFileUpload({ 
			url: "<c:url value='/projectmanagement/projectSave' />?new ="+new Date().getTime(),
			type:"POST",
			fileElementId:'myBlogImage',
			dataType: 'text',
			data: datas,
			success: function(data,state){
				var elv = $('#elv').val();
				if(data=='' || data == undefined || data == 'undefined'){
					if(elv == 'E'){
						jAlert("编辑失败!");
					}else if(elv == 'A'){
						jAlert("新增失败!");
					}
				}else{
					$("#projectid").val(data);
					$("#projectid_zdy").val(data);
					$("#projectid_fh").val(data);
					if(elv == 'E'){
						jAlert("编辑成功!");
					}else if(elv == 'A'){
						jAlert("新增成功!");
					}
					initTree();
					getValue($("#lastClick").val(),0,elv);
					$.fancybox.close();
				}
			},error:function(data, status, e){
				var elv = $('#elv').val();
				if(elv == 'E'){
					jAlert("编辑失败!");
				}else if(elv == 'A'){
					jAlert("新增失败!");
				}
			}
		});
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
			required:true
			},
			proabbreviation:{
				required:true
			}
		},
		messages:{
			projectname:{
				required:"请填写项目名称",
				//remote:"项目名已存在"
			}
			//,proabbreviation:{required:"项目简称必填"}
		}
	}).form();
}
//数字类型校验- 陈
function check_number(obj){ 
	var reg = new RegExp("^[0-9]*$");
	if(reg.test(obj.val())){
		return true;
	}else {
		return false;
	}
} 
//验证项目名重复
function checkProject(){
	var projectnameId = $(this).val();
	var projectid = $("#projectid").val();
	var parkid = $("#parkid").val();
	$.ajax({
		url: "<c:url value='/projectmanagement/checkProjectName' />?new ="+new Date().getTime(),
		type:"POST",
		data:{projectnameId:projectnameId,projectid:projectid,parkid:parkid},
		success:function(data){
			if(data){
				//可以使用的项目名
				$("#projectSubmit").off('click',saveInfo).on("click",saveInfo);
				$("#projectName_err").css("display","none");
				return true;
			}else{
				//重复项目名
				$("#projectSubmit").off("click",saveInfo);
				$("#projectName_err").show();
				return false;
			}
		},error:function(){
			$("#projectSubmit").off("click",saveInfo);
			$("#projectName_err").text('请求服务器异常!请检查网络状态').show();
		}
	});   
}

//获取所有需要的数据
function getData(){
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
	var buildingarea = $("#buildingareaval").val();
	var investcompany = $("#investcompany").val();
	var investment = $("#investment").val();
	var supplyarea = $("#supplyareaval").val();
	var pictureptah = $("#pictureptah").val();
	var carrieroperator = $("#carrieroperator").val();
	var state = $("#state").val();
	var dt = {
		"projectid":projectid,"projectname":projectname,
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
		"pictureptah":pictureptah,
		"carrieroperator":carrieroperator,
		"state":state
	}
	return dt;
}
function initBaiduMap(){
	/** 百度地图API功能 **/
	var map = new BMap.Map("allmap");            // 创建Map实例
	map.centerAndZoom(new BMap.Point(105.357267,37.391597),5);                // 初始化地图,设置中心点坐标和地图级别。
	map.enableScrollWheelZoom();                 //启用滚轮放大缩小
	map.addEventListener("click",function(e){
		if(elv=="V"){
			jAlert("在视图下您不能设置地图！");
		}else{
			$("#latitude").val(e.point.lat);
			$("#longitude").val(e.point.lng);
		}
		$("#allmap").css("display", "none");
		$("#xmgl_tbljxcx1").css("display", "block");
	});
	$("#allmap").css("display", "none");
}
function initProjectState(){
	var proState = $('#state').val();
	$('.project_state','#xmgl_tbljxcx1').find("input[type='radio']").each(function(){
		var $radio = $(this)
		, v = $radio.val();
		if(proState==null||proState==''){
	 		proState = 0;
	 	}
	 	if(v==parseInt(proState)){
	 		$radio.prop("checked",true);
	 	}else{
	 		$radio.prop("checked",false);
	 	}
	 });
}
function initRegionSelect(id,isBase){
	$.ajax({type:"POST",url: "<c:url value='/projectmanagement/jjqSelect' />",data: {id:id},cache:false,
		success: function(data){
			var $cs = $('#jjqSelectId');
			var lis = "";
			$.each(data,function(key,val){
				var li = "<li val='"+val.regionid+"' >" +
							"<a title="+val.regionname+" class='ellipsis'> "+val.regionname+"</a>" +
						 "</li>";
				/*var $li = $('<li>');
				var $a = $('<a>');
				$a.attr('href','')
				.attr('title',val.regionname)
				.text(val.regionname);
				$li.attr('val',val.regionid).text($a);
				*/
				lis+=li;
			});
			$('ul',$cs).empty().append(lis);//参数
			if(isBase){
				$('.text',$cs).text('选择参数...');
			}
			$cs.simSelect({callback: function (x,v) {
				if(v){
					$('#regionid_err').hide();
				}
				if(!x) return;
				$(this).find("input").val(v);
				//联动初始化园区下拉框
				initParkSelect(v,true);
			}});
		},error:function(){
			jAlert('加载失败!');
		}
	});
}
function initParkSelect(id,isBase){
	$.ajax({ type:"POST",url: "<c:url value='/projectmanagement/yqSelect' />",data: {id:id},cache:false,
		success: function(data){
			var $cs = $('#yqSelectId');
			var lis = "";
			$.each(data,function(key,val){
				var li = "<li val='"+val.parkid+"' >" +
							"<a title="+val.parkname+" class='ellipsis'> "+val.parkname+"</a>" +
						 "</li>";
				/*
				var $li = $('<li>');
				var $a = $('<a>');
				$a.attr('href','')
				.attr('title',val.parkname)
				.text(val.parkname);
				$li.attr('val',val.parkid).text($a);
				*/
				lis+=li;
			});
			$('ul',$cs).empty().append(lis);//参数
			if(isBase){
				$('.text',$cs).text('选择参数...');
			}
			$cs.simSelect({callback: function (x,v) {
				if(v){$("#parkid_err").hide();}
				if(!x) return;
				$(this).find("input").val(v);
				$('#projectnameId').focus();
				$('#projectnameId').blur();
			}});
		},error:function(){
			jAlert('加载失败!');
		}
	});
}
</script>
<style>
	h2{width:200px;float:left;}
	tr.errors-tr td{height: auto !important;}
</style>
<!DOCTYPE html>
<div class="hd">
	<h2>基础信息</h2>
	<input type="hidden" value="${clickpark}" id="clickparkId"/>
</div>
<div id="allmap"></div>
<div class="bd bd2">

	<form action="<c:url value='/projectmanagement/projectSave' />
	"method="post" name="projectBasdInfoForm" id="projectBasdInfoFormId" enctype="multipart/form-data">
	<input name="projectid" type="hidden" id="projectid" value="${pbinfo.projectid}"/>
	<input name="pictureptah" type="hidden" id="pictureptah" value="${pbinfo.pictureptah}"/>
	<input name="operate" type="hidden" id="operate" value="${operate}"/>
	<table class="xmgl_tbladd" id="xmgl_tbljxcx1" style="display:block;">
		<tbody>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;目&nbsp;名&nbsp;称：
				</td>
				<td>
					<input class="xmgl_addinput" id="projectnameId" name="projectname"  value="${pbinfo.projectname}" type="text" >
					<div id="projectName_err" class="inputerror">项目名称不能相同</div>
				</td>
				
				<td class="xmgl_lename" >&nbsp;项&nbsp;目&nbsp;图&nbsp;片：
				</td>
				<td class="xmgl_add_rig">
					<input name="file" id="myBlogImage"  type="file" onchange="preview(this)">
					<input class="xmgl_addinput" type="text">
					<img src="../resources/img/iconimg.png"></td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;目&nbsp;类&nbsp;别：
				</td>
				<td>
					<div class="mod-select xmgl_selct" id="xmlbListId">
						<p class="text ellipsis">${dict.industryclassname}</p>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="industryclass" id="industryclass" value="${dict.industryclassid}"/>
						<div class="list limit-list">
							<ul>
								<c:forEach var="h" items="${hylbList}">
									<li val="${h.industryclassid}">
										<a href="">${h.industryclassname}</a>
									</li>
								</c:forEach>
							</ul>
						</div>

					</div>
					<div id="industryclass_err" class="inputerror">请选择项目类别</div>
				</td>
				<td class="xmgl_lename" rowspan="3"></td>
				<td rowspan="3">
					<div id="preview">
					<c:choose>
						<c:when test="${empty pbinfo.pictureptah||pbinfo.pictureptah==''}">
							<img src="<c:url value='/upload/empty.jpg' />" >
						</c:when>
						<c:otherwise>
							<img src="<c:url value='/${pbinfo.pictureptah}' />" >
						</c:otherwise>
					</c:choose>
					</div>
				</td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;所&nbsp;属&nbsp;行&nbsp;业：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="xhListId">
						<p class="text ellipsis">${dtn.industrytypename}</p>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="industrytype" id="industrytype" value="${dtn.industrytypeid}"/>
						<div class="list limit-list">
						<ul>
							<c:forEach items="${projectLst}" var="i">
								<li val ="${i.industryclassid}"><a href>${i.industrytypename}</a></li>
							</c:forEach>
						</ul>
						</div>

					</div>
					<div id="industrytype_err" class="inputerror">请选择所属行业</div>
				</td>

			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;商&nbsp;业&nbsp;模&nbsp;式：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="symsSelectId">
						<p class="text ellipsis">${dtype.businesstypename}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="businesstype" id="businesstype" value="${dtype.businesstypeid}"/>
						<div class="list limit-list">
							<ul>
								<c:forEach var="s" items="${symsList}">
									<li val="${s.businesstypeid}">
										<a href="">${s.businesstypename}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div id="businesstype_err" class="inputerror">请选择商业模式</div>
				</td>

			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;&nbsp;&nbsp;目&nbsp;&nbsp;组：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="xmzSelectId">
						<p class="text ellipsis">${pgroup.groupname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="groupid" id="groupid" value="${pgroup.groupid}"/>
						<div class="list limit-list">
							<ul>
								<c:forEach var="g" items="${groupList}">
									<li val="${g.groupid}">
										<a href="" class="ellipsis" title="${g.groupname}">${g.groupname}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div id="groupid_err" class="inputerror">请选择项目组</div>
				</td>
				<td class="xmgl_lename">&nbsp;供&nbsp;能&nbsp;面&nbsp;积：
				</td>
				<td>
					<input class="xmgl_addinput" name="supplyarea" id="supplyareaval" value="${pbinfo.supplyarea}" type="text" maxlength="20">
					<span class="unit">m²</span>
					<div class="inputerror" id="supplyarea">必须为数字类型</div>
				</td>
			</tr>

			<tr>
				<td class="xmgl_lename">&nbsp;经&nbsp;&nbsp;&nbsp;济&nbsp;&nbsp;区：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="jjqSelectId">
						<p class="text ellipsis">${rinfo.regionname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="regionid" id="regionid" value="${rinfo.regionid}"/>
						<div class="list limit-list" >
							<ul>
								<c:forEach items="${regionList}" var="r">
									<li val="${r.regionid}"><a href="">${r.regionname}</a></li>
								</c:forEach>
							</ul>
						</div>

					</div>
					<div id="regionid_err" class="inputerror">请选择经济区</div>
				</td>
				<td class="xmgl_lename">&nbsp;建&nbsp;筑&nbsp;面&nbsp;积：
				</td>
				<td>
					<input class="xmgl_addinput" name="buildingarea" id="buildingareaval"  value="${pbinfo.buildingarea}" type="text" maxlength="20">
					<span class="unit">m²</span>
					<div class="inputerror" id="buildingarea">必须为数字类型</div>
				</td>
			</tr>
			<tr>
				<td class="xmgl_lename">园&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="yqSelectId">
						<p class="text ellipsis">${pinfo.parkname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="parkid" id="parkid" value="${pinfo.parkid}"/>
						<div class="list limit-list">
							<ul></ul>
						</div>
					</div>
					<div id="parkid_err" class="inputerror">请选择园区</div>
				</td>
				<td class="xmgl_lename">&nbsp;投&nbsp;资&nbsp;单&nbsp;位：
				</td>
				<td>
					<input class="xmgl_addinput" name="investcompany" id="investcompany"  value="${pbinfo.investcompany}" type="text"></td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;行&nbsp;&nbsp;&nbsp;政&nbsp;&nbsp;区：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="szqSelectId" style="width:75px;float:left;">
						<p class="text ellipsis">${ditfinfo.districtname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<div class="list limit-list">
							<ul>
								<c:forEach var="c" items="${dicList}">
									<li val="${c.districtid},${c.citytype}">
										<a href="">${c.districtname}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="mod-select  mt5 ml5 xmgl_selct xzq-select" id="xzqSelectIdc">
						<p class="text ellipsis">${dinfo.districtname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" id="districtid" name="districtid" value="${dinfo.districtid}"/>
						<div class="list limit-list">
							<ul></ul>
						</div>
					</div>
					<div id="districtid_err" class="inputerror">请选择行政区</div>
				</td>
				<td class="xmgl_lename">&nbsp;投&nbsp;资&nbsp;金&nbsp;额：
				</td>
				<td style="width:230px;">
					<input class="xmgl_addinput" name="investment" id="investment" value="${pbinfo.investment}" type="text" maxlength="20">
					<span class="unit">元</span>
					<div class="inputerror" id="investment">必须为数字类型</div>
				</td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;目&nbsp;地&nbsp;址：
				</td>
				<td>
					<input class="xmgl_addinput" name="address" id="address" value="${pbinfo.address}" type="text"></td>
				<td class="xmgl_lename">&nbsp;设&nbsp;计&nbsp;单&nbsp;位：
				</td>
				<td>
					<input class="xmgl_addinput" name="designcompany" id="designcompany" value="${pbinfo.designcompany}" type="text"></td>
			</tr>
			<tr>
				<td class="xmgl_lename">经度&nbsp;/&nbsp;纬度：</td>
				<td>
					<input name="longitude" id="longitude" value="${pbinfo.longitude}" type="text" readonly="readonly">
					<span class="fl ml6 mr6">/</span>
					<input name="latitude" id="latitude" value="${pbinfo.latitude}" type="text" readonly="readonly">
					<img id="mapid" style="float:left; margin-left:3px; margin-top:3px;" src="../resources/img/iconweidu.png">
					<div id="longitude_err" style="display:none;float:left; width:218px;color:red;">请选择经纬度</div>
				</td>
				<td class="xmgl_lename">&nbsp;建&nbsp;设&nbsp;单&nbsp;位：
				</td>
				<td>
					<input name="buildcompany" value="${pbinfo.buildcompany}" id="buildcompany" class="xmgl_addinput" type="text"></td>
			</tr>

			<tr>
				<td class="xmgl_lename">&nbsp;供&nbsp;&nbsp;&nbsp;暖&nbsp;&nbsp;期：
				</td>
				<td>
					<input name="heatingstart" id="heatingstart" value="${pbinfo.heatingstart}" type="text" class="Wdate itxt mydate" onfocus="WdatePicker({dateFmt:'MM/dd'})" autocomplete="off">
					<span class="fl ml5 mr7">/</span>
					<input name="heatingend" id="heatingend" value="${pbinfo.heatingend}" type="text" class="Wdate itxt mydate" onfocus="WdatePicker({dateFmt:'MM/dd'})" autocomplete="off"></td>
				<td class="xmgl_lename">&nbsp;运&nbsp;&nbsp;&nbsp;营&nbsp;&nbsp;商：
				</td>
				<td>
					<input name="carrieroperator" value="${pbinfo.carrieroperator}" id="carrieroperator" class="xmgl_addinput" type="text"></td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;供&nbsp;&nbsp;&nbsp;冷&nbsp;&nbsp;期：
				</td>
				<td>
					<input name="coldingstart" id="coldingstart" value="${pbinfo.coldingstart}" type="text" class="Wdate itxt  mydate"onfocus="WdatePicker({dateFmt:'MM/dd'})" autocomplete="off">
					<span class="fl ml5 mr7">/</span>
					<input name="coldingend" id="coldingend" value="${pbinfo.coldingend}" type="text" class="Wdate itxt mydate" onfocus="WdatePicker({dateFmt:'MM/dd'})" autocomplete="off"></td>
				<td class="xmgl_lename">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：
				</td>
				<td class="textarea-fa">
					<textarea name="remarks" maxlength=30 value="${pbinfo.remarks}" id="remarks" cols="20" rows="2">${pbinfo.remarks}</textarea>
				</td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;目&nbsp;状&nbsp;态：
				</td>
				<td class="project_state">
					<input type="radio" id="planing" name="projectstate" value="0"/>
					<label for="planing">规划</label>
					<input type="radio" id="constraction" name="projectstate" value="1"/>
					<label for="constraction">在建</label>
					<input type="radio" id="build" name="projectstate" value="2"/>
					<label for="build">已建</label>
					<input type="hidden" id="state" value="${pbinfo.state}"/>
				</td>
				<td class="xmgl_lename" rowspan="3"></td>
				<td>
					<!-- <textarea name="remarks" value="${pbinfo.remarks}" id="remarks" style=" display:block; width:229px;resize:none;height:60px;" cols="20" rows="2"></textarea>
				-->
			</td>
		</tr>
	</tbody>
</table>
</form>
<script type="text/javascript">
function checkLen(obj) {
	var maxChars = 200;//最多字符数
	if (obj.value.length > maxChars){
		obj.value = obj.value.substring(0, maxChars);
	}
	var curr = maxChars - obj.value.length;
	document.getElementById("count").innerHTML = curr.toString();
}
</script>
<script type="text/javascript">
function preview(file) {
	var prevDiv = document.getElementById('preview');
	if (file.files && file.files[0]) {
		var reader = new FileReader();
		reader.onload = function (evt) {
		prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
	}
		reader.readAsDataURL(file.files[0]);
	} else {
		prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
	}
}
</script>
</div>
<!--基础信息-->
<div class="clear mr20">
	<a title="Close" class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
	<a id="projectSubmit" class="tck-save fr mt15">保存</a>
	<input type="hidden" id="elv" value="${elv}">
</div>