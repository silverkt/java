<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>		
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
</head>
<body></body>
</html>
<script type="text/javascript">
/*
页面标签id命名规则：
	页面级标签：
		(1)页面:外部容器,id固定
		(2)标题:page_title_(数据库MonitorPageParameter)pageid
	设备图形标签:
	    (数据库MonitorEquWidgetParameter)widgetid
	表单控件标签：
		monitor_widget_(数据库MonitorWidgetParameter)widgetid
*/
/*-----------------------------------------------------------监测页面操作函数----------------------------------------------------------*/
/*
初始化页面表单
切换页面时表单置为disabled
*/
function initPageDisabled(){
$(".page_init").attr("disabled","disabled");
$(".page_control_btn").attr("disabled","disabled");
$(".class_title_adjust").attr("disabled","disabled");
$(".class_pgima_adjust").attr("disabled","disabled");
}
/*
初始化设备表单
切换设备时表单置为disabled
*/
function initEquDisabled(){
$(".equ_init").attr("disabled","disabled");
$(".equ_control_btn").attr("disabled","disabled");
$(".class_equ_adjust").attr("disabled","disabled");
$(":image").css("border","none");
$(":image").css("filter","none");
}
/*
初始化控件表单
切换控件时表单置为disabled
*/
function initLabelDisabled(){
$(".label_init").attr("disabled","disabled");
$(".label_control_btn").attr("disabled","disabled");
$(".class_label_adjust").attr("disabled","disabled");
$(".label_tag").css("border","none");  //取消被选中
$(".label_tag").css("filter","none");  //取消被选中
$("#show_properties").empty();
}
/*
初始化项目列表,加载所有项目名称列表
页面加载时进行初始化
*/
function initSelectProject(){
$("#select_project").empty();
$.getJSON("<c:url value='/monitorscreen/getProList'/>"+"?temp="+Math.random(),function(data){
	 if(data!=null)	{
		$.each(data, function(i,item){
			$("#select_project").append("<option value='"+item.projectid+"'>"+item.projectname+"</option>");
		});
		initSelectPage(null);
		initSelectEqu();
	}
});
}
/*
初始化页面列表,加载当前项目名称列表
页面加载时进行初始化
*/
function initSelectPage(val){	
var projectid=$("#select_project").val();
$("input[name='projectid']").val(projectid);
$("#select_page").empty();
$("#select_page").append("<option value='0'>--请选择页面--</option>");

$.getJSON("<c:url value='/monitorscreen/pagemenu'/>"+"?temp="+Math.random(),{projectid:projectid,supply:0,flag:1},function(data){
	 if(data!=null)	{
		$.each(data, function(i,item){
			$("#select_page").append("<option value='"+item.pageid+"'>"+item.title+"</option>");
		});
		if(val!=null){
			 $("#select_page option").each( function() { 
				 if(val==$(this).text()){
					 $("#select_page").val($(this).val());
						var id=$("#select_page").val();
						var titleid="page_title_"+id
						viewPage();	
						$(":input[name='pageid']").val(id);
				 }
			} ); 
		}
	}
});
}
/*
根据页面id加载页面数据
*/
function loadPageData(){
$(".class_title_adjust").attr("disabled","disabled");
$(".class_pgima_adjust").attr("disabled","disabled");
$(".page_alert").css("display","none");
$(".equ_alert").css("display","none");
$(".label_alert").css("display","none");

var pageid=$("#select_page").val();
$.getJSON("<c:url value='/monitorscreen/pagedata'/>"+"?temp="+Math.random(),{pageid:pageid},function(data){
	 if(data.length==1)	{
		$.each(data, function(i,item){
			$("input[name='projectid']").val(item.projectid);   //加载全局页面projectid
			$("input[name='pageid']").val(item.pageid);         //加载全局页面pageid
			$("#supplyseason").val(item.supplyseason);
			$("#showproperty").val(item.showproperty);
			$("#isdefault").val(item.isdefault);
			$("#flag").val(item.flag);
			$("#page_show_id").val("page_"+item.pageid);
			$("#title").val(item.title);
			$("#titlex").val(item.titlex);
			$("#titley").val(item.titley);
			$("#fontsize").val(item.fontsize);
			$("#fontcolor").val(item.fontcolor);
			$("#titlewidth").val(item.titlewidth);
			$("#titleheight").val(item.titleheight);
			$("#titlebgcolor").val(item.titlebgcolor);
			$("#titleisshow").val(item.titleisshow);
			$("#titlebordercolor").val(item.titlebordercolor);			
			$("#pagewidth").val(item.pagewidth);
			$("#pageheight").val(item.pageheight);
			$("#pageimage").val(item.pageimage);
			$("#pgimagex").val(item.pgimagex);
			$("#pgimagey").val(item.pgimagey);	
			$("#monitor_page").empty();
			$("#monitor_page").css({"width":"1600px","height":"1000px","z-index":"0","background-color":"#FFFFFF","background-repeat":"no-repeat"});
			viewPage();
			ergodicEquWidget();
			$(".page_init").removeAttr("disabled");
			$(".equ_manage_btn").removeAttr("disabled");
			$(".label_manage_btn").removeAttr("disabled");
			$(".page_control_btn").removeAttr("disabled");
			initEmptyEquText();
			initEmptyLabelText();
			$(".page_alert").css("display","none");
			$(".equ_alert").css("display","none");
			$(".label_alert").css("display","none");
			Number(item.titleisshow)==1?$("#title_show").attr("checked",true):$("#title_show").attr("checked",false);
		});
	}else{
		initEmptyPageText();
	}
});
}
/*
初始化页面表单
置为初始值
*/
function initEmptyPageText(){
$("#pageid").val(0);
$("#page_show_id").val("page_0");
$("#title").val("请输入标题");
$("#titlex").val(0);
$("#titley").val(0);
$("#fontsize").val('36');
$("#fontcolor").val("#000000");
$("#titlewidth").val(300);
$("#titleheight").val(80);
$("#titlebgcolor").val("#FFFFFF");
$("#titleisshow").val(1);
$("#titlebordercolor").val("#FFFFFF");
$("#title_show").attr("checked",true);
$("#pageimage").val("请上传底图");
$("#pgimagex").val(0);
$("pgimagey").val(0);
isTitleShow();
$(".class_title_adjust").attr("disabled","disabled");
$(".class_pgima_adjust").attr("disabled","disabled");
}
/*
创建页面
清空页面数据表单及右侧图形区域页面标签,将select_page的值置为0
*/
function createPage(){
$("#monitor_page").empty();
$("#monitor_page").removeAttr("style");
$("#monitor_page").css({"position":"absolute","width":"1600px","height":"1000px","z-index":"0","background-color":"#FFFFFF","background-repeat":"no-repeat"});
$("#select_page").val('0');
initEmptyPageText();
initEmptyEquText();
initEmptyLabelText();
$(".page_init").removeAttr("disabled");
$(".page_control_btn").removeAttr("disabled");
$(".equ_manage_btn").removeAttr("disabled");
$(".label_manage_btn").removeAttr("disabled");
$(".page_alert").css("display","none");
$(".equ_alert").css("display","none");
$(".label_alert").css("display","none");
$("#select_equ_widget").empty();
$("#select_equ_widget").append("<option value='0'>--请选择设备控件--</option>");
$("#select_monitor_widget").empty();
$("#select_monitor_widget").append("<option value='0'>--请选择设备控件--</option>");
$("#title").focus();
var file = $("#imgupload");
file.after(file.clone().val("")); 
file.remove(); 
return true;
}
/*
载入页面
根据select_page确定页面id,查询数据库,在页面右侧图形区域生成页面全套图形
*/
function loadPage(){
var pageid=$("#select_page").val();
if(pageid=='0'){
	jAlert("请选择页面！");
	return;
}
loadPageData();
}
/*
删除页面
根据select_page确定页面id,查询数据库,级联删除全套图形数据
*/
function deletePage(){

var pageid=$("#select_page").val();
if(pageid=='0'){
	jAlert("请选择页面！");
	return;
}else{
	jConfirm("确定删除页面及对应设备控件、表单控件数据?","确定",function(r){
		if(r==true){
			$.post("<c:url value='/monitorscreen/deletePageAndAll'/>"+"?temp="+Math.random(),{pageid:pageid},function(flag){
				if(flag=="true"){
					jAlert("删除成功！");
					createPage();
					$("#select_page option[value='"+pageid+"']").remove();
					$(".equ_manage_btn").attr("disabled","disabled");
					$(".label_manage_btn").attr("disabled","disabled");
					$(".page_control_btn").attr("disabled","disabled");
					$(".equ_control_btn").attr("disabled","disabled");
					$(".label_control_btn").attr("disabled","disabled");
					$(".page_init").attr("disabled","disabled");
					$(".label_init").attr("disabled","disabled");
					$(".equ_init").attr("disabled","disabled");
				}
			});
		}
	})
	
}
}
//页面标题显示勾选控制
function isTitleShow(){
	var titleid="page_title_"+$("#select_page").val();
	var flag=0;//记录title是否被展示
	$("div").each(function(){ 
		var id = $(this).attr("id");
		if(id==titleid){
			flag=1;
		}
	});
	if($("#title_show").is(":checked")) {
		//$(".class_title_show").removeAttr("disabled");
		$("#"+titleid).css("display","block");
		$("#titleisshow").val(1);
		if(flag==1){
			$(".class_title_adjust").removeAttr("disabled");
		}
	}else{
		//$(".class_title_show").attr("disabled","disabled");
		$(".class_title_adjust").attr("disabled","disabled");
		$("#"+titleid).css("display","none");
		$("#titleisshow").val(0);
	}
}
	/*
	预览页面,在右侧图形区域生成页面
	*/
	function viewPage(){
		var path="<%=request.getContextPath()%>";
		var imgpath=path+"/"+$("#pageimage").val();
		var pgimagex=split_Px($("#pgimagex").val());
		var pgimagey=split_Px($("#pgimagey").val());
		var pagewidth=split_Px($("#pagewidth").val());
		var pageheight=split_Px($("#pageheight").val());
		//||$("#pageimage").val().substring(0,1)!="i"  原逻辑 先不知原因
		if(imgpath==""||$("#pageimage").val()=="请上传底图"||$("#pageimage").val()==""){
			jAlert("请上传底图！");
			return;
		}
		var flag_alert=0;//记录page_alert是否显示
		$('.page_alert').each(
			function(){
			if($(this).css('display')=='block'){
				flag_alert=1;
			}
		});
		if(flag_alert!=0){
			jAlert("请录入正确信息！");
			return;
		}
		
		var pg="transparent  url("+imgpath+") scroll "+pgimagex+"px"+" "+pgimagey+"px";
		$("#monitor_page").css({"background":pg,"width":pagewidth+"px","height":pageheight+"px","z-index":0,"background-repeat":"no-repeat"});	
		$(".class_pgima_adjust").removeAttr("disabled");
		
		$("#page_title_0").remove();
		$(".class_title_adjust").removeAttr("disabled");
		var titleid="page_title_"+$("#select_page").val();
		var titlex=$("#titlex").val();
		var titley=$("#titley").val();	
		var titlewidth=$("#titlewidth").val();
		var titleheight=$("#titleheight").val();
		var fontsize=$("#fontsize").val();
		var fontcolor=$("#fontcolor").val();
		var titlebgcolor=$("#titlebgcolor").val();
		var titlebordercolor=$("#titlebordercolor").val();
		var title=$("#title").val();
		var flag=0;//记录title是否被展示
		$("div").each(function(){ 
		  		var id = $(this).attr("id");
			if(id==titleid){
				flag=1;
			}
		});
		if(titlex>=0&&(parseInt(titlex)+parseInt(titlewidth))<pagewidth*1){
			
		}else{
			jAlert("标题X轴边界溢出");
			return;
		}
		
		if(titley>=0&&(parseInt(titley)+parseInt(titleheight))<pageheight*1){
		}else{
			jAlert("标题Y轴边界溢出");
			return;
		}
		
		var title_style={"z-index": 10,"position": "absolute",
			    "left": titlex+"px","top": titley+"px","width": titlewidth+"px","height": titleheight+"px","line-height":titleheight+"px",
				"text-align":"center","font-size": fontsize+"px","color": fontcolor,"background-color":titlebgcolor,
				"border":"1px solid "+titlebordercolor,"font-weight":"bold","filter": "alpha(opacity = 70)","-moz-opacity": 0.7,"pacity": 0.7,"font-family":"微软雅黑"};
		
		if (flag == 0) {
			var str = "<div id='"+titleid+"' class='title_tag'>" + title+ "</div>";
			$("#monitor_page").append(str);
			$("#" + titleid).css(title_style);
		} else {
			$("#" + titleid).css(title_style);
		}
		Number($("#titleisshow").val())==1?$("#" + titleid).css("display", "block"):$("#" + titleid).css("display", "none");
	}
	/*
	 提交页面数据
	 */
	function submitPageData() {
		var path="<%=request.getContextPath()%>";
		$("#pageform").attr("action", "<c:url value='/monitorscreen/submitPageData'/>"+"?temp="+Math.random());
		var imgpath = path + "/" + $("#pageimage").val();
		var pageid = $("#select_page").val();
		$("#pageid").val(pageid);
		$("#page_show_id").val("page_" + pageid);
		var projectid = $("#select_project").val();
		$("#projectid").val(projectid);
		if (imgpath == "" ||($("#pageimage").val())=="请上传底图"){
			jAlert("请上传底图！");
			return;
		}
		var value = $("#title").val();
		var id = "title";
		if (value.trim() == "") {
			$("#alert_" + id).empty().append("请输入标题").css("display", "block");
			return;
		}
		var flag_alert = 0;//记录page_alert是否显示
		$('.page_alert').each(function() {
			if ($(this).css('display') == 'block') {
				flag_alert = 1;
			}
		});
		if (flag_alert != 0) {
			jAlert("请录入正确信息！");
			return;
		}

		var pagewidth = split_Px($("#pagewidth").val());
		var pageheight = split_Px($("#pageheight").val());
		var titleid = "page_title_" + $("#select_page").val();
		var titlex = $("#titlex").val();
		var titley = $("#titley").val();
		var titlewidth = $("#titlewidth").val();
		var titleheight = $("#titleheight").val();
		if (titlex >= 0
				&& (parseInt(titlex) + parseInt(titlewidth)) < pagewidth * 1) {
		} else {
			jAlert("标题X轴边界溢出");
			return;
		}
		if (titley >= 0
				&& (parseInt(titley) + parseInt(titleheight)) < pageheight * 1) {
		} else {
			jAlert("标题Y轴边界溢出");
			return;
		}
		$("#title_show").is(":checked")?$("#titleisshow").val(1):$("#titleisshow").val(0);
		checkTitle($("#title").val(),"title");
		$("#btn_submit_page").attr("disabled",true);
		$("#pageform").ajaxSubmit({
			type : 'post',
			data: $("#pageform").serialize(),
			url: "<c:url value='/monitorscreen/submitPageData'/>"+"?temp="+Math.random(),
			success : function(flag) {
				if (flag == "true") {
					jAlert("数据提交成功！");
					initSelectPage(value);
					$("#btn_submit_page").attr("disabled",false);
				} else {
					jAlert("数据提交失败！");
					$("#btn_submit_page").attr("disabled",false);
				}
			},
			error : function(XMLResponse) {
				jAlert(XMLResponse.responseText);
				$("#btn_submit_page").attr("disabled",false);
			}
		});
	}
	/*
	 标题微调函数
	 */
	function titleAdjust(advance) {
		var page_x = split_Px($("#monitor_page").css("width"));
		var page_y = split_Px($("#monitor_page").css("height"));
		var titleid = "page_title_" + $("#select_page").val();
		var x = split_Px($("#" + titleid).css("left"));
		var y = split_Px($("#" + titleid).css("top"));

		if (advance == 'up') {
			y = y - 2;
		} else if (advance == 'down') {
			y = y + 2;
		} else if (advance == 'left') {
			x = x - 2;
		} else {
			x = x + 2;
		}
		var width = split_Px($("#" + titleid).css('width')) + x;
		var height = split_Px($("#" + titleid).css('height')) + y;
		if (x >= 0 && width < page_x) {
			$("#" + titleid).css("left", x);
			$("#titlex").val(x);
		} else {
			jAlert("标题X轴边界溢出");
		}
		if (y >= 0 && height < page_y) {
			$("#" + titleid).css("top", y);
			$("#titley").val(y);
		} else {
			jAlert("标题Y轴边界溢出");
		}
	}

	/*
	 底图微调函数
	 */
	function pgimgAdjust(advance) {
		var path="<%=request.getContextPath()%>";
		var imgpath = path + "/" + $("#pageimage").val();
		var x = split_Px($("#pgimagex").val());
		var y = split_Px($("#pgimagey").val());
		if (advance == 'up') {
			y = y - 2;
		} else if (advance == 'down') {
			y = y + 2;
		} else if (advance == 'left') {
			x = x - 2;
		} else {
			x = x + 2;
		}
		$("#pgimagex").val(x);
		$("#pgimagey").val(y)
		var pg = "transparent  url(" + imgpath + ") scroll " + x + "px" + " "
				+ y + "px";
		$("#monitor_page").css({
			"background" : pg,
			"background-repeat" : "no-repeat"
		});
	}
	/*
	 上传底图
	 */
	function uploadPageImg() {
		var path="<%=request.getContextPath()%>";
		$("#pageform").attr("action", "<c:url value='/monitorscreen/uploadPageImage'/>"+"?temp="+Math.random());
		var pageimage = $("#pageimage").val();
		if (pageimage != "") {
			var temp = new Array();
			temp = pageimage.toString().split(".");
			type = temp[temp.length - 1].toLocaleLowerCase();
			if (type != "png" && type != "bmp" && type != "gif"
					&& type != "jpg" && type != "jpeg") {
				jAlert("请选用图片格式！");
				return;
			} else {
				$("#imgtype").val(type);
				$("#pageform").ajaxSubmit({
					type : 'post',
					url : "<c:url value='/monitorscreen/uploadPageImage'/>"+"?temp="+Math.random(),
					success : function(imgpath) {
						$("#pageimage").val(imgpath);
						//jAlert(path+"/"+imgpath);
						imgReady(path+"/"+imgpath, function() {
							var imgwidth = this.width;
							var imgheight = this.height;
							var x = parseInt((1600 - imgwidth) / 2);
							var y = parseInt((1000 - imgheight) / 2);
							$("#pgimagex").val(x);
							$("#pgimagey").val(y);
							/*
							if(x==0&&y==0){
								alert("底图上传成功，尺寸与页面匹配，无需调整。");
							}else{
								alert("底图上传成功，上传底图尺寸为"+imgwidth+"*"+imgheight+"，监测底页尺寸为1000*1000，如需底图位置居中，底图坐标需调整为(x:"+x+",y:"+y+")。");  
							}*/
						});
					},
					error : function(XmlHttpRequest, textStatus, errorThrown) {
						jAlert("error");
					}
				});
			}
		} else {
			jAlert("请选择图片文件！");
			return;
		}
	}
	/*
	 整数警告框显示
	 */
	function checkInteger(value, id) {
		if (!isInteger(value)) {
			$("#alert_" + id).css("display", "block");
		} else {
			$("#alert_" + id).css("display", "none");
		}
	}
	/*
	 正整数警告框显示
	 */
	function checkPositiveInteger(value, id) {
		if (!isPositiveInteger(value)) {
			$("#alert_" + id).css("display", "block");
		} else {
			$("#alert_" + id).css("display", "none");
		}
	}
	/*
	 检验页面合法标题
	 */
	function checkTitle(value, id) {
		if (value.trim() == "") {
			$("#alert_" + id).empty().append("请输入标题").css("display", "block");
			return;
		} else {
			$("#alert_" + id).css("display", "none");
			var projectid = $("#select_project").val();
			var pageid = $("#select_page").val();
			$.get("<c:url value='/monitorscreen/manageCheckTitle'/>"+"?temp="+Math.random(),{title:value}, function(
					data) {
				if (data.length != 0) {
					$.each(data, function(i, item) {
						if (item.projectid == projectid) {
							if (item.pageid != pageid) {
								$("#alert_" + id).empty().append("标题重复").css("display", "block");
								return;
							} else {
								$("#alert_" + id).css("display", "none");
							}
						} else {
							$("#alert_" + id).css("display", "none");
						}
					});
				} else {
					$("#alert_" + id).css("display", "none");
				}
			});
		}
	}
	/*-----------------------------------------------------------监测页面操作函数----------------------------------------------------------*/
</script>
