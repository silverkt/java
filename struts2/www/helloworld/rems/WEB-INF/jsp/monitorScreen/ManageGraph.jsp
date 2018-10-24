<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>		
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
<style type="text/css">
.bordershow {
	border: 1px dotted #0033FF;
}
.borderhide {
	border: 0px dotted #FFFFFF;
}
</style>
</head>
<body></body>
</html>
<script type="text/javascript">
$(function(){
	$("#equid").change(function(){initEquImgSize(null,null);});
});
/*-----------------------------------------------------------监测设备操作函数----------------------------------------------------------*/
/*
	遍历在页面展示所有设备控件
*/
function  ergodicEquWidget(){
	var path="<%=request.getContextPath()%>";
	var pageid=$("#select_page").val();
	$.getJSON("<c:url value='/monitorscreen/graphlist'/>"+"?temp="+Math.random(),{pageid:pageid,flag:1},function (data) {
		if (data != null) {
			$.each(data, function (i, item) {
				var str = "";
				str += "<div title=\""+item.title+"\" style=\"z-index: 1;position: absolute;" + "left:" + item.x + "px;top:" + item.y + "px;height:" + item.height + "px;width:" + item.width + "px;\" id=\"equ_widget_" + item.widgetid  + "\" class=\"graph\">";
				str += "<input  type=\"image\" id=\"equ_img_"+item.widgetid+"\" src =\"" + path+item.picturepath + "\" style=\"width:" + item.width + "px;height:" + item.height + "px;\" ";  
				str+="/></div>";
				$("#monitor_page").append(str);
				
				var equwidgetid="equ_widget_" + item.widgetid;
				$("#"+equwidgetid).css("z-index",1);
				$("#"+equwidgetid).unbind();
				$("#"+equwidgetid).bind("click",function(){
					 loadEquWidget(item.widgetid);
				});
				
				if(item.isshow=='1') {
					$("#"+equwidgetid).css("display","block");
				}else{
					$("#"+equwidgetid).css("display","none");
				}
			});
		}
		ergodicLabelWidget();
	});
}
/*
	载入设备控件标签列表
*/
function initSelectEquWidget(title){
	var pageid=$("#select_page").val();
	$("#select_equ_widget").empty().append("<option value='0'>--请选择设备控件--</option>");//
	$.getJSON("<c:url value='/monitorscreen/manageGraphList'/>"+"?temp="+Math.random(),{projectid:$("#select_project").val(),pageid:$("#select_page").val()},function(data){
		 if(data!=null)	{
			 var str="";
			$.each(data, function(i,item){
				str+="<option value='"+item.widgetid+"'>"+item.title+"</option>";
			});
			$("#select_equ_widget").append(str);
			if(title!=null){
				$("#select_equ_widget option").each( function() { 
					 if(title==$(this).text()){
						$("#select_equ_widget").val($(this).val());
						var id=$("#select_equ_widget").val();
						$("#equ_show_id").val("equ_widget_"+id);
						$("#equ_widget_0").remove();
						viewEquWidget();
					 }
				}); 
			}
		}
	});
}
/*
	初始化树状关系设备列表
*/
var buf="";
function initSelectEqu(){
	$(".classinstanceid").empty().append("<option value='0'>--请选择设备--</option>");
	buf="";
	$.getJSON("<c:url value='/monitorscreen/manageInstList'/>"+"?temp="+Math.random(),{projectid:$("#select_project").val()},function(data){ 
		if(data.length!=0){
			equRecursion(data[0],data,-1);
			$(".classinstanceid").append(buf);
		}
	});
}
/*
	初始化树状关系设备列表
	关系解析迭代
*/
function equRecursion(item,totallist,padding_left){
	var totalsonlist = new Array(); 
	for(var i=0;i<totallist.length;i++){
		if(totallist[i].fclassinstanceid==item.classinstanceid){
			totalsonlist.push(totallist[i]);
		}
	}
	if(totalsonlist.length==0){  
		buf+="<option value='"+item.classinstanceid+"'>"+item.classinstancename+"</option>";
	}else{ 
		buf+="<option value='"+item.classinstanceid+"'>"+item.classinstancename+"</option>";
		for (var i=0;i<totalsonlist.length;i++){	
			equRecursion(totalsonlist[i],totallist,padding_left);
		}
	}
}
/*
	设备控件标题载入设备名称
*/
function initEquTitle(){
	var text=$("#equid").find("option:selected").text();
	var id=$("#equid").val();
	if($("#equal_equ_title").is(":checked")&&id!='0') {
		$("#equtitle").val(text);
		$("#alert_equ_title").css("display","none");
	}
}
/*
	载入设备图形尺寸
*/
var w_h=0; //记录图形宽高比
var h_w=0; //记录图形高宽比
var imgpath="";//记录设备图形路径
function initEquImgSize(width,height){
	var equid=$("#equid").val();
	var path="<%=request.getContextPath()%>";
	$.getJSON("<c:url value='/monitorscreen/manageClassInst'/>"+"?temp="+Math.random(),{classinstanceid:equid},function(data){ 
		if(data!=null){
			imgpath=path+data.picturepath;
			$("#imgpath").val(imgpath);
			console.log($("#imgpath").val());
			imgReady(path+data.picturepath, function () { 
				if(width==null){
					$("#equwidth").val(this.width);
				}else{
					$("#equwidth").val(width);
				}
				if(height==null){
					$("#equheight").val(this.height);
				}else{
					$("#equheight").val(height);
				}
				w_h=this.width/this.height;
				h_w=this.height/this.width;
			}); 
		}
	});
}
/*
	计算图形尺寸，根据图形原尺寸等比缩放设备图形
*/
function computeImgSize(val){
	var equwidth=$("#equwidth").val();
	var equheight=$("#equheight").val();
	if(val=='w'){
		$("#equheight").val(parseInt(equwidth/w_h));
	}else{
		$("#equwidth").val(parseInt(equheight/h_w));
	}
}
/*
	初始化页面表单
	置为初始值
*/
function initEmptyEquText(){
	$("#select_equ_widget").val('0');
	$("#equ_show_id").val("equ_widget_0");
	$("#equid").val('0');
	$("#equtitle").val("请输入标题");
	$("#equx").val(100);
	$("#equy").val(100);
	$("#equwidth").val(100);
	$("#equheight").val(100);
	$("#equisshow").val("1");
	$("#equisclick").val("1");	
	$("#equ_show").attr("checked",true)
	$("#equ_click").attr("checked",true)
	$("#equal_equ_title").attr("checked",false)
	isEquShow(null);
	isEquClick(null);
}
/*
	载入设备标签数据
*/
function loadEquWidgetData(equwidgetid){
	$("div.graph").removeClass("bordershow").addClass("borderhide");
	$("div.graph").css("filter","none");
	$.getJSON("<c:url value='/monitorscreen/manageGraphOne'/>"+"?temp="+Math.random(),{widgetid:equwidgetid},function(data){
		 if(data.length==1)	{
			$.each(data, function(i,item){
				$("#equ_show_id").val("equ_widget_"+equwidgetid);
				$("#equid").val(item.classinstanceid);
				$("#equtitle").val(item.title);
				$("#equx").val(item.x);
				$("#equy").val(item.y);
				$("#ison").val(item.ison);
				$("#equisshow").val(item.isshow);
				$("#equisclick").val(item.isclick);	
				if(item.isshow=='1'){
					$("#equ_show").attr("checked",true);
				}else{
					$("#equ_show").attr("checked",false);
				}
				if(item.isclick=='1'){
					$("#equ_click").attr("checked",true);
				}else{
					$("#equ_click").attr("checked",false);
				}
				initEquImgSize(item.width,item.height);
				$(".equ_control_btn").removeAttr("disabled");
				$(".equ_init").removeAttr("disabled");
				$(".equ_alert").css("display","none");
				isEquShow(null);
				isEquClick(null);
				var equimgid="equ_widget_"+equwidgetid;
				$(".graph").removeClass("bordershow").addClass("borderhide");
				$("#"+equimgid).removeClass("borderhide").addClass("bordershow");
				//$("#"+equimgid).css("filter","Glow(color=#4A7AC9,strength=12)");
				$("#"+equimgid).easydrag();
				//$("#"+equimgid).dragOff();
				$("#"+equimgid).css("z-index",50);
				var easy_x=$("#"+equimgid).css("left").split("px")[0];
				var easy_y=$("#"+equimgid).css("top").split("px")[0];
				//alert(1*item.x+"top:"+easy_y+" left:"+easy_x+" z-index:"+$("#"+equimgid).css("z-index")+" width:"+1*item.width);
				if(easy_y=="auto"||easy_x=="auto"){
					$("#equx").val(item.x);
					$("#equy").val(item.y);
				}else{
					if((1*easy_x)<0||(1*easy_x+1*item.width)>1600||(1*easy_y)<0||(1*easy_y+1*item.height)>1000){
						jAlert("设备标签轴边界溢出！");
						$("#"+equimgid).css("top",item.y);
						$("#"+equimgid).css("left",item.x);
						$("#equx").val(item.x);
						$("#equy").val(item.y);
						return;
					}else{
						$("#equx").val(1*easy_x);
						$("#equy").val(1*easy_y);
					}
					
				}
			});
		}else{
			initEmptyEquText();
		}
	});
}
/*
	新建设备控件
*/
function createEquWidget(){
	$(".graph").removeClass("bordershow").addClass("borderhide");
	initEmptyEquText();
	$(".equ_control_btn").removeAttr("disabled");
	$(".equ_init").removeAttr("disabled");
	$(".equ_alert").css("display","none");
}
/*
	载入设备控件
	在表单中载入当前设备控件数据，在页面上以红边框标识该控件位置
*/
function loadEquWidget(equwidgetid){
	if(typeof($("#equ_widget_0").html())!='undefined'){
		jAlert("请先保存新建设备控件！");
		return;
	}
	//var equwidgetid=$("#select_equ_widget").val();
	monitorTab("equipwidget");
	$("#select_equ_widget").val(equwidgetid);
	if(equwidgetid=='0'){
		initEquDisabled();
	}else{
		loadEquWidgetData(equwidgetid);
	}
}
/*
	删除设备控件
*/
function deleteEquWidget(){
	var equwidgetid=$("#select_equ_widget").val();
	if(equwidgetid=='0'){
		jAlert("请选择设备控件！");
		return;
	}else{
		jConfirm("确定要删除设备控件？","确定",function(r){
			if(r==true){
				$.post("<c:url value='/monitorscreen/deleteEquWidgetOne'/>"+"?temp="+Math.random(),{equwidgetid:equwidgetid},function(){
					jAlert("删除成功！");
					$("#select_equ_widget option[value='"+equwidgetid+"']").remove();
					initEmptyEquText();
					var divid="equ_widget_"+equwidgetid;
					$("#"+divid).remove();
					$(".equ_control_btn").attr("disabled",true);
					$(".equ_init").attr("disabled",true);
					$(".equ_alert").css("display","none");
				});
				
			}
		});
		
	}
}
/*
	预览设备控件
*/
function viewEquWidget(){
	var equx=split_Px($("#equx").val());
	var equy=split_Px($("#equy").val());
	var equwidth=split_Px($("#equwidth").val());
	var equheight=split_Px($("#equheight").val());
	var equtitle=$("#equtitle").val();
	var widgetid=$("#select_equ_widget").val();
	var equwidgetid="equ_widget_"+$("#select_equ_widget").val();
	var equimgid="equ_img_"+$("#select_equ_widget").val();
	var equid=$("#equid").val();
	var imgpath=$("#imgpath").val();
	if(equid=='0'){
		$("#alert_equ_id").empty().append("请选择设备").css("display","block");
		return;
	}
	
	if(equtitle.trim()==""){
		$("#alert_equ_title").empty().append("请输入标题").css("display","block");
		return;
	}
	var flag_alert=0;//记录equ_alert是否显示
	$('.equ_alert').each(
		function(){
		if($(this).css('display')=='block'){
			flag_alert=1;
		}
	});
	if(flag_alert!=0){
		jAlert("请录入正确信息！");
		return;
	}
	var flag=0;//记录equ是否被展示
	$("#monitor_page div").each(function(){ 
		var id = $(this).attr("id");
		console.log(id);
		if(id==equwidgetid){
			flag=1;
		}
	});
	console.log(flag);
	var page_x=split_Px($("#monitor_page").css("width"));
	var page_y=split_Px($("#monitor_page").css("height"));	

	if(equx>=0&&(equx+equwidth)<page_x){
	}else{
		jAlert("设备标签X轴边界溢出！");
		return;
	}
	if(equy>=0&&(equy+equheight)<page_y){
	}else{
		jAlert("设备标签Y轴边界溢出！");
		return;
	}
	$(".graph").removeClass("bordershow").addClass("borderhide");
	var style={"z-index": 1,"position": "absolute","left": equx+"px","top": equy+"px","width": equwidth+"px","height": equheight+"px"};
	var img_style={"width": equwidth+"px","height": equheight+"px"};
	var img="<input type=\"image\" id=\""+equimgid+"\"  src=\""+imgpath+"\" style=\"width:"+equwidth+"px; height:"+equheight+"px\"/>"
	if(flag==0){
		var str="<div id=\""+equwidgetid+"\" class=\"equ_tag graph\" title=\""+equtitle+"\"></div>";
		$("#monitor_page").append(str);
		$("#"+equwidgetid).empty();
		$("#"+equwidgetid).append(img);
		$("#"+equwidgetid).css(style);
		$("#"+equimgid).css(img_style);
		$("#"+equimgid).attr("src",imgpath);
		$("#"+equwidgetid).removeClass("borderhide").addClass("bordershow");
		$("#"+equwidgetid).attr("title",equtitle);
	}else{
		$("#"+equimgid).attr("src",imgpath);
		$("#"+equwidgetid).css(style);
		$("#"+equimgid).css(img_style);
		$("#"+equwidgetid).removeClass("borderhide").addClass("bordershow");
		$("#"+equwidgetid).attr("title",equtitle);
	}
	
	if(widgetid!=0){
		$("#"+equwidgetid).unbind();
		$("#"+equwidgetid).bind("click",function(){
			 loadEquWidget(widgetid);
		});
	}else{
		$("#"+equwidgetid).unbind();
		$("#"+equwidgetid).bind("click",function(){
			$("#"+equwidgetid).easydrag();
			$("#"+equwidgetid).css("z-index",50);
			if($("#"+equwidgetid).css("top").split("px")[0]!="auto"&&$("#"+equwidgetid).css("left").split("px")[0]!="auto"){
				var easy_y=1*$("#"+equwidgetid).css("top").split("px")[0];
				var easy_x=1*$("#"+equwidgetid).css("left").split("px")[0];
				if(easy_x<0||easy_y<0||(easy_x+1*split_Px($("#equwidth").val()))>1600||(easy_y+1*split_Px($("#equheight").val()))>1000){
					jAlert("设备标签轴边界溢出！");
					$("#"+equwidgetid).css("top","0px");
					$("#"+equwidgetid).css("left","0px");
					$("#equx").val(0);
					$("#equy").val(0);
					return;
				}else{
					$("#equx").val(easy_x);
					$("#equy").val(easy_y);
				}
			}
		});
	}
		

	isEquClick(null);
	isEquShow(null);
}
/*
	提交设备控件数据
*/
function submitEquWidget(){
	var pageid=$("#select_page").val();
	if(pageid=='0'){
		jAlert("请先提交页面数据！");
		return;
	}else{
		$("#pageid_equ").val(pageid);
	}
	var equwidgetid=$("#select_equ_widget").val();
	$("#equwidgetid").val(equwidgetid);
	
	var equtitle=$("#equtitle").val();
	var equid=$("#equid").val();
	if(equid=='0'){
		$("#alert_equ_id").empty().append("请选择设备").css("display","block");
		return;
	}	
	checkEquTitle(equtitle);
	
	var flag_alert=0;//记录equ_alert是否显示
	$('.equ_alert').each(
		function(){
		if($(this).css('display')=='block'){
			flag_alert=1;
		}
	});
	if(flag_alert!=0){
		jAlert("请录入正确信息！");
		return;
	}
	
	var equx=split_Px($("#equx").val());
	var equy=split_Px($("#equy").val());
	var equwidth=split_Px($("#equwidth").val());
	var equheight=split_Px($("#equheight").val());
	var page_x=split_Px($("#monitor_page").css("width"));
	var page_y=split_Px($("#monitor_page").css("height"));	

	if(equx>=0&&(equx+equwidth)<page_x){
	}else{
		jAlert("设备标签X轴边界溢出！");
		return;
	}
	if(equy>=0&&(equy+equheight)<page_y){
	}else{
		jAlert("设备标签Y轴边界溢出！");
		return;
	}
	
	$("input[name='btn_submit_equ']").attr("disabled",true);
	$("#equform").ajaxSubmit({
		type: 'post',
		data: $("#equform").serialize(),
		url: "<c:url value='/monitorscreen/submitEquWidgetData'/>"+"?temp="+Math.random(),
		success: function(flag){
			if(flag=="true"){
				jAlert("设备标签数据提交成功！");
				initSelectEquWidget(equtitle);
				$("input[name='btn_submit_equ']").attr("disabled",false);
			}else{
				jAlert("设备标签数据提交失败！");
				$("input[name='btn_submit_equ']").attr("disabled",false);
			}		 
		},
		error: function(XMLResponse){
			jAlert(XMLResponse.responseText);
			$("input[name='btn_submit_equ']").attr("disabled",false);
		}
	 });
}
/*
	设备勾选控制是否显示
*/
function isEquShow(id){
	var equwidgetid;
	if(id==null){
		equwidgetid="equ_widget_"+$("#select_equ_widget").val();
	}else{
		equwidgetid="equ_widget_"+id;
	}	
	if($("#equ_show").is(":checked")) {
		$("#"+equwidgetid).css("display","block");
		$("#equisshow").val('1');
		var flag=0;//记录equ是否被展示
		$("div").each(function(){ 
			var id = $(this).attr("id");
			if(id==equwidgetid){
				flag=1;
			}
		});
		if(flag==1){
			$(".class_equ_adjust").removeAttr("disabled");
		}
	}else{
		$(".class_equ_adjust").attr("disabled","disabled");
		$("#"+equwidgetid).css("display","none");
		$("#equisshow").val('0');
	}
}
/*
	设备勾选控制是否响应点击
*/
function isEquClick(id){
	var equwidgetid;
	if(id==null){
		equwidgetid="equ_widget_"+$("#select_equ_widget").val();
	}else{
		equwidgetid="equ_widget_"+id;
	}
	//$("#"+equwidgetid).unbind();
	if($("#equ_click").is(":checked")) {
		$("#equisclick").val('1')
		//$("#"+equwidgetid).bind("click",function(){
		//  alert("弹出设备详细动态属性页");
		//});
	}else{
		$("#equisclick").val('0')
		//$("#"+equwidgetid).unbind();
	}
}

/*
	设备控件调整
*/
function equAdjust(advance){
	var page_x=split_Px($("#monitor_page").css("width"));
	var page_y=split_Px($("#monitor_page").css("height"));	
	var widgetid="equ_widget_"+$("#select_equ_widget").val();	
	var x=split_Px($("#"+widgetid).css("left"));
	var y=split_Px($("#"+widgetid).css("top"));
	if(advance=='up'){
		y=y-1;
	}else
	if(advance=='down'){
		y=y+1;
	}else
	if(advance=='left'){
		x=x-1;
	}else{
		x=x+1;
	}
	
	var width=split_Px($("#"+widgetid).css("width"))+x;
	var height=split_Px($("#"+widgetid).css("height"))+y;	
	
	if(x>=0&&width<page_x){
		$("#"+widgetid).css("left",x);
		$("#equx").val(x);
	}else{
		jAlert("设备标签X轴边界溢出！");
	}
	if(y>=0&&height<page_y){
		$("#"+widgetid).css("top",y);
		$("#equy").val(y);
	}else{
		jAlert("设备标签Y轴边界溢出！");
	}
}
/*
	检验页面设备绑定是否重复
*/
function checkEquID(value){
	if(value=="0"){
		$("#alert_equ_id").empty().append("请选择设备").css("display","block");
		return;
	}else{
		$("#alert_equ_id").css("display","none");
		var projectid=$("#select_project").val();
		var pageid=$("#select_page").val();
		var widgetid=$("#select_equ_widget").val();
		
		$.getJSON("<c:url value='/monitorscreen/queryMonitorEquid'/>"+"?temp="+Math.random(),{classinstanceid:value},function(data){
			if(data.length!=0)	{
				$.each(data,function(i,item){
					if(item.projectid==projectid){
						if(item.pageid==pageid){
							if(item.widgetid!=widgetid){
								$("#alert_equ_id").empty().append("设备重复").css("display","block");
								return;
							}else{
								$("#alert_equ_id").css("display","none");
							}
						}else{
							$("#alert_equ_id").css("display","none");
						}
					}else{
						$("#alert_equ_id").css("display","none");
					}
				});
			}else{
				$("#alert_equ_id").css("display","none");
			}
		});
	}
}
/*
	检验页面设备标签名称是否重复
*/
function checkEquTitle(value){
	if(value.trim()==""){
		$("#alert_equ_title").empty().append("请输入标题").css("display","block");
		return;
	}else{
		$("#alert_equ_title").css("display","none");
		if(value!=null){
			 $("#select_equ_widget option").each( function() { 
				 if(value==$(this).text()){
					 if(("equ_widget_"+$(this).val())!=$("#equ_show_id").val()){
						 $("#alert_equ_title").empty().append("标题重复").css("display","block");
						 return;
					 }
				 }
			} ); 
		}
	}
}
/*-----------------------------------------------------------监测设备操作函数----------------------------------------------------------*/
</script>
