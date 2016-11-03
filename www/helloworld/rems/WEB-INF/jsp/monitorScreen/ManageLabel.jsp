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
/*-----------------------------------------------------------监测控件操作函数----------------------------------------------------------*/
var showList=new Array(); //存储所选设备动态属性数组
var unitsList=new Array();//存储单位数组
/*
	遍历在页面展示所有监测控件
*/
function  ergodicLabelWidget(){
	var path="<%=request.getContextPath()%>";
	var projectid=$("#select_project").val();
	var pageid=$("#select_page").val();
	$.getJSON("<c:url value='/monitorscreen/labellist'/>"+"?temp="+Math.random(),{projectid:projectid,pageid:pageid},function(data){
		 if(data!=null)	{
			$.each(data, function(i,item){
				var labelx=item.x;
				var labely=item.y;
				var labelwidth=item.width;
				var labelheight=item.height;
				var labelfontsize=item.fontsize;
				var labelfontcolor=item.fontcolor;
				var labelid="monitor_widget_"+item.widgetid;
				var labelborderid="label_border_"+item.widgetid;
				var classinstanceid=item.classinstanceid;					
				var labelborder="<div id=\""+labelborderid+"\" class=\"label_tag\" title=\""+item.title+"\" style=\"cursor:hand;width:"+labelwidth+"px\"></div>"
				var labelborder_style={"z-index": 3,"position": "absolute","left": labelx+"px","top": labely+"px"};	
				//"filter":"alpha(opacity = 50)","-moz-opacity": 0.5,"-khtml-opacity": 0.5,"opacity": 0.5
				var labeltable="<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\""+labelwidth+"px\">"+
					"<tr>"+
						"<td id=\""+labelid+"\"></td>"+
					"</tr>"+
				"</table>";
				var table_style={"width":labelwidth+"px","height":labelheight+"px","font-size":"12px","color":labelfontcolor};

				$(".label_tag").css("border","none");
				$(".label_tag").css("filter","none");
				$("#monitor_page").append(labelborder);
				
				$("#"+labelborderid).empty();
				$("#"+labelborderid).append(labeltable);
				$("#"+labelborderid).unbind();
				$("#"+labelborderid).bind("click",function(){
					 loadLabel(item.widgetid);
				});
				$("#"+labelborderid).css(labelborder_style);
				$("."+labelborderid).empty();
				
				$("#"+labelid).css(table_style);
				
				if(item.isshow=='1') {
					$("#"+labelborderid).css("display","block");
				}else{
					$("#"+labelborderid).css("display","none");
				}
				
				var labelproperties=new Array(); //控件设备属性
				var labelunits=new Array();      //控件单位
				if(item.units!=null){
					labelunits=item.units.split(",");
				}
				$.getJSON("<c:url value='/monitorscreen/labelproperties'/>"+"?temp="+Math.random(),{properties:item.properties},function(json){
					 if(json!=null)	{
						$.each(json, function(i,item){
							var element={
								id:item.classpropertyid,
								name:item.classpropertyname,
								unit:' '
							}
							labelproperties.push(element);
						});
						var labelinit=initWatchTable(classinstanceid,labelproperties,labelunits,labelid,table_style,labelfontsize);
					  }
				 });
			}); //each结束
		}//if结束
	});
}
/*
	载入设备控件标签列表
*/
function initSelectMonitorWidget(title){
	var projectid=$("#select_project").val();
	var pageid=$("#select_page").val();
	var id=0;
	$("#select_monitor_widget").empty();
	$("#select_monitor_widget").append("<option value='0'>--请选择表单控件--</option>");	
	$.getJSON("<c:url value='/monitorscreen/labellist'/>"+"?temp="+Math.random(),{projectid:projectid,pageid:pageid},function(data){
		 if(data!=null)	{
			$.each(data, function(i,item){
				$("#select_monitor_widget").append("<option value='"+item.widgetid+"'>"+item.title+"</option>");
				if(item.title==title){
					id=item.widgetid;
				}
			});
			if(title!=null){				
				$("#select_monitor_widget option").each( function() { 
					 if(title==$(this).text()){
							$("#select_monitor_widget").val($(this).val());
							var id=$("#select_monitor_widget").val();
							$("#label_show_id").val("monitor_widget_"+id);
							$("#label_border_0").remove();
							viewLabel();
					 }
				}); 
			}
		}
	});
}
/*
	新建监测表单控件
*/
function createLabel(){
	initEmptyLabelText();
	$(".label_control_btn").removeAttr("disabled");
	$(".label_init").removeAttr("disabled");
	$(".label_alert").css("display","none");
	$(".label_tag").css("border","none");
	$(".label_tag").css("filter","none");    
}
/*
	载入监测表单控件
*/
function loadLabel(labelwidgetid){
	if(typeof($("#label_border_0").html())!='undefined'){
		jAlert("请先保存新建表单控件！");
		return;
	}
	//var labelwidgetid=$("#select_monitor_widget").val();
	monitorTab('labelwidget');
	$("#select_monitor_widget").val(labelwidgetid);
	if(labelwidgetid=='0'){
		initLabelDisabled();
	}else{
		loadLabelWidgetData(labelwidgetid);
	}
}
/*
	删除监测表单控件
*/
function deleteLabel(){
	
	var labelwidgetid=$("#select_monitor_widget").val();
	if(labelwidgetid=='0'){
		jAlert("请选择表单控件");
		return;
	}else{
		jConfirm("确定要删除表单控件？","确定",function(r){
			if(r==true){
				$.post("<c:url value='/monitorscreen/deleteLabelWidgetOne'/>"+"?temp="+Math.random(),{labelwidgetid:labelwidgetid},function(){
					jAlert("删除成功！");
					$("#select_monitor_widget option[value='"+labelwidgetid+"']").remove();
					initEmptyLabelText();
					var divid="label_border_"+labelwidgetid;
					$("#"+divid).remove();
					$(".label_control_btn").attr("disabled",true);
					$(".class_label_adjust").attr("disabled",true);
					$(".label_init").attr("disabled",true);
					$(".label_alert").css("display","none");
				});		
			}
		});
		
	}
}
/*
	预览监测表单
*/
function viewLabel(){
	unitsList.length=0;
	$(".property_unit").each(
		function(){
			var val=$(this).attr("value");
			unitsList.push(val);
		}
	);
	
	var labelx=split_Px($("#labelx").val());
	var labely=split_Px($("#labely").val());
	var labelwidth=split_Px($("#labelwidth").val());
	var labelheight=split_Px($("#labelheight").val());
	var labeltitle=$("#labeltitle").val();
	var labelfontsize=$("#labelfontsize").val();
	var labelfontcolor=$("#labelfontcolor").val();
	var labelid="monitor_widget_"+$("#select_monitor_widget").val();
	var labelborderid="label_border_"+$("#select_monitor_widget").val();
	var classinstanceid=$("#classinstanceid").val();
	var widgetid=$("#select_monitor_widget").val();
	if(classinstanceid=='0'){
		$("#alert_label_instid").empty().append("请选择设备").css("display","block");
		return;
	}	
	if(labeltitle.trim()==""){
		$("#alert_label_title").empty().append("请输入标题").css("display","block");
		return;
	}	
	var flag_alert=0;//记录equ_alert是否显示
	$('.label_alert').each(
		function(){
		if($(this).css('display')=='block'){
			flag_alert=1;
		}
	});
	if(flag_alert!=0){
		jAlert("请录入正确信息！");
		return;
	}
	var flag=0;//记录label是否被展示
	$("#monitor_page div").each(function(){ 
		var id = $(this).attr("id");
		if(id==labelid){
			flag=1;
		}
	});
	
	var page_x=split_Px($("#monitor_page").css("width"));
	var page_y=split_Px($("#monitor_page").css("height"));
	
	if(labelx>=0&&(labelx+labelwidth)<page_x){
	}else{
		jAlert("表单标签X轴边界溢出");
		return;
	}
	if(labely>=0&&(labely+labelheight)<page_y){
	}else{
		jAlert("表单标签Y轴边界溢出");
		return;
	}
	var labelborder="<div id=\""+labelborderid+"\" class=\"label_tag\" title=\""+labeltitle+"\" style=\"cursor:hand;width:"+labelwidth+"px\"></div>"
	var labelborder_style={"z-index": 3,"position": "absolute","left": labelx+"px","top": labely+"px","width":labelwidth,"height":labelheight};	
	//"filter":"alpha(opacity = 70)","-moz-opacity": 0.7,"-khtml-opacity": 0.7,"opacity": 0.7
	var labeltable="<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\""+labelwidth+"px\">"+
					"<tr>"+
						"<td id=\""+labelid+"\"></td>"                                                                                                        +
					"</tr>"+
				"</table>";
	
	var table_style={"width":labelwidth+"px","height":labelheight+"px","font-size":"12px","color":labelfontcolor};
	$(".label_tag").css("border","none");
	$(".label_tag").css("filter","none");          
	if(flag==0){
		$("#monitor_page").append(labelborder);
		$("#"+labelborderid).empty();
		$("#"+labelborderid).append(labeltable);	
		$("#"+labelborderid).attr("title",labeltitle);
	}	
	$("#"+labelborderid).css(labelborder_style);
	$("#"+labelborderid).css("border","1px dotted #00FF00"); //标识被选中
	//$("#"+labelborderid).css("filter","Glow(color=#00FF00,strength=12)");
	$("."+labelborderid).empty();
	if(widgetid!=0){
		$("#"+labelborderid).unbind();
		$("#"+labelborderid).bind("click",function(){
			 loadLabel(widgetid);
		});
	}else{
		$("#"+labelborderid).unbind();
		$("#"+labelborderid).bind("click",function(){
			$("#"+labelborderid).easydrag();
			$("#"+labelborderid).css("z-index",50);
			if($("#"+labelborderid).css("top").split("px")[0]=="auto"||$("#"+labelborderid).css("left").split("px")[0]=="auto"){
				//$("#labelx").val(labelx);
				//$("#labely").val(labely);
			}else{
				var easy_y=1*$("#"+labelborderid).css("top").split("px")[0];
				var easy_x=1*$("#"+labelborderid).css("left").split("px")[0];
				if(easy_x<0||easy_y<0||(easy_x+1*split_Px($("#labelwidth").val()))>1600||(easy_y+1*split_Px($("#labelheight").val()))>1000){
					jAlert("表单标签轴边界溢出");
					$("#"+labelborderid).css("top","0px");
					$("#"+labelborderid).css("left","0px");
					$("#labelx").val(0);
					$("#labely").val(0);
					return;
				}else{
					$("#labelx").val(easy_x);
					$("#labely").val(easy_y);
				}
			}
		});
	}


	
	$("#"+labelid).css(table_style);
	var labelinit=initWatchTable(classinstanceid,showList,unitsList,labelid,table_style,labelfontsize);
	isLabelShow(null);
}
/*
	生成监测控件数据内容
*/
var initWatchTable = function(classinstanceid,showList,unitsList,labelid,style,labelfontsize){
	var str="<table id=\"data_"+labelid+"\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
	var showproperty=$("#showproperty").val();
	for(var i=0;i<showList.length;i++){
		str+="<tr>";
		if(showproperty=='0'){
			str+="<td align=\"right\">"+showList[i].name+"</td>";
		}
		str+="<td align=\"center\" width=\"45px\"><input id=\"data_"+classinstanceid+"_"+showList[i].id+"\" type=\"text\" readonly=\"readonly\" value=\"0.00\" class=\"input_border\" style=\"font-size:"+labelfontsize+"px;background-color:transparent;\"/></td>";
    	str+="<td align=\"left\" width=\"20px\">"+unitsList[i]+"</td></tr>";
	}
	str+="</table>";
	$("#"+labelid).html("").append(str);
	$("#data_"+labelid).css(style);
	$("#toolBox").css("z-index", 100);
	//alert($("#toolBox").css("z-index"));
};
/*
	提交表单数据
*/
function submitLabel(){
	var pageid=$("#select_page").val();
	if(pageid=='0'){
		jAlert("请先提交页面数据！");
		return;
	}else{
		$("#pageid_label").val(pageid);
	}
	unitsList.length=0;
	$(".property_unit").each(
		function(){
			var val=$(this).attr("value");
			unitsList.push(val);
		}
	);
	var properties=new Array();
	for(var i=0;i<showList.length;i++){
		properties.push(showList[i].id);
	}
	$("#properties").val(properties.toString());
	$("#units").val(unitsList.toString());
	var labelwidgetid=$("#select_monitor_widget").val();
	$("#labelwidgetid").val(labelwidgetid);
	
	var labeltitle=$("#labeltitle").val();
	var classinstanceid=$("#classinstanceid").val();
	if(classinstanceid=='0'){
		$("#alert_label_instid").empty().append("请选择设备").css("display","block");
		return;
	}
	checkLabelTitle(labeltitle.trim());
	var flag_alert=0;//记录label_alert是否显示
	$('.label_alert').each(
		function(){
		if($(this).css('display')=='block'){
			flag_alert=1;
		}
	});
	if(flag_alert!=0){
		jAlert("请录入正确信息！");
		return;
	}
	
	var labelx=split_Px($("#labelx").val());
	var labely=split_Px($("#labely").val());
	var labelwidth=split_Px($("#labelwidth").val());
	var labelheight=split_Px($("#labelheight").val());
	var page_x=split_Px($("#monitor_page").css("width"));
	var page_y=split_Px($("#monitor_page").css("height"));	

	if(labelx>=0&&(labelx+labelwidth)<page_x){
	}else{
		jAlert("表单标签X轴边界溢出");
		return;
	}
	if(labely>=0&&(labely+labelheight)<page_y){
	}else{
		jAlert("表单标签Y轴边界溢出");
		return;
	}
	
	$("#btn_submit_label").attr("disabled",true);
	$("#labelform").ajaxSubmit({
		type: 'post',
		data: $("#labelform").serialize(),
		url: "<c:url value='/monitorscreen/submitLabelWidgetData'/>"+"?temp="+Math.random(),
		success: function(flag){
			if(flag=="true"){
				jAlert("表单标签数据提交成功！");
				initSelectMonitorWidget(labeltitle);
				$("#btn_submit_label").attr("disabled",false);
			}else{
				jAlert("表单标签数据提交失败！");
				$("#btn_submit_label").attr("disabled",false);
			}
		},
		error: function(XmlResponse){
			jAlert(XmlResponse.responseText);
			$("#btn_submit_label").attr("disabled",false);
		}
	 });
}
/*
	初始化设备动态属性列表
*/
function initEquProperty(classinstanceid,propertyid,units) {
	if(classinstanceid=='0'){
		$("#alert_label_instid").empty().append("请选择设备").css("display","block");
		return;
	}else{
		$("#alert_label_instid").css("display","none");
	}

	$.getJSON("<c:url value='/monitorscreen/managePropertyList'/>"+"?temp="+Math.random(),{classinstanceid:classinstanceid}, function (data) {
		if (data.length>0) {
			var str="";
			$.each(data, function (i, item) {
				str+="<option value='"+item.classpropertyid+"'>"+item.classpropertyname+"</option>";
			});
			$("#equ_property").empty().append(str);
			showList.length=0;
			unitsList.length=0;
			$("#show_properties").empty();
			if(propertyid!=null&&units!=null){
				var id=new Array();
				id=propertyid.split(",");
				unitsList=units.split(",");
				for(i=0;i<id.length;i++){
					var text=$("#equ_property option[value='"+id[i]+"']").text();
					var item={
						id:id[i],
						name:text,
						unit:unitsList[i]
					}
					showList.push(item);
				}
				initPropertiesList();
			}
		}
	});
}

/*
	添加监测属性
*/
function addProperties(){
	var id=$("#equ_property").val();
	var name=$('#equ_property option:selected').text();
	var unit=' ';
	if(id=='0'){
		jAlert("请选择设备属性");
		return;
	}
	if(showList.length>=5){
		jAlert("一个表单控件最多监测5个属性");
		return;
	}
	for(var i=0;i<showList.length;i++){
		if(showList[i].id==id){
			jAlert("不能重复加入");
			return;
		}
	}
	$.getJSON("<c:url value='/monitorscreen/boxProperty'/>"+"?temp="+Math.random(),{classinstanceid:$("#classinstanceid").val()}, function (data) {
		if (data != ""&&data.length>0) {
			$.each(data, function (i, item) {
				if(item.classpropertyid==id){
					unit=item.unitname;
				}
			});
			var item={
					id:id,
					name:name,
					unit:unit
				};
			showList.push(item);
			initPropertiesList();
		}
	});

}
/*
	删除监测属性
*/
function deleteList(id){
	for(var i=0;i<showList.length;i++){
		if(showList[i].id==id){
			showList.splice(i,1);
			initPropertiesList();
		}
	}
}
/*
	生产监测列表
*/
function initPropertiesList(){
	var path="<%=request.getContextPath()%>";
	$("#show_properties").empty();
	var len=showList.length;
	showList.sort(function(a,b){return parseInt(a.id)-parseInt(b.id)>0?1:-1});
	var select=" style='width:50px; height:18px; font-size:10px' class='property_unit'><option value=' '> </option>";
	$.getJSON("<c:url value='/monitorscreen/unitlist'/>"+"?temp="+Math.random(), function (data) {
		if (data != ""&&data.length>0) {
			$.each(data, function (i, item) {
				select+="<option value='"+item.unitname+"'>"+item.unitname+"</option>";
			});
			select+="</select>";
			for(var i=0;i<len;i++){
				var id=showList[i].id;
				var unit=showList[i].unit;
				var str="";
				str+="<tr>";
				str+="<td height=\"19px\" width=\"140px\"><span style=\"margin-left:3px;\">"+showList[i].name+"</span></td>";
				str+="<td width=\"55px\" align=\"right\"><select id='unit_"+id+"' "+select+"</td>";
				str+="<td width=\"25px\" align=\"center\"><input type=\"button\" style=\"margin-left: 10px;float: left;background-repeat: no-repeat;background-image: url("+path+"/resources/img/monitorscreen/delete.gif);width: 13px;height: 13px;border: 0px;cursor: hand\" onclick=\"deleteList('"+id+"')\" title=\"删除该项\"/></td>";
				str+="</tr>";
				$("#show_properties").append(str);
				$("#unit_"+id).val(unit);
			}
		}
	});
}
/*
	初始化监测表单标题
*/
function initLabelTitle(){
	var text=$("#classinstanceid option:selected").text();
	var id=$("#classinstanceid").val();
	if(($("#equal_label_title").attr("checked")==true||$("#equal_label_title").attr("checked")=="checked")&&id!='0') {
		$("#labeltitle").val(text);
		checkLabelTitle(text);
	}
}
/*
	调整表单标签位置
*/
function labelAdjust(advance){
	var page_x=split_Px($("#monitor_page").css("width"));
	var page_y=split_Px($("#monitor_page").css("height"));
	var labelborderid="label_border_"+$("#select_monitor_widget").val();	
	var x=split_Px($("#"+labelborderid).css("left"));
	var y=split_Px($("#"+labelborderid).css("top"));
	var labelwidth=split_Px($("#"+labelborderid).css("width"))+x;
	var labelheight=split_Px($("#"+labelborderid).css("height"))+y;
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
	if(x>=0&&labelwidth<page_x){
		$("#"+labelborderid).css("left",x);
		$("#labelx").val(x);
	}else{
		jAlert("表单标签X轴边界溢出");
	}
	if(y>=0&&labelheight<page_y){
		$("#"+labelborderid).css("top",y);
		$("#labely").val(y);
	}else{
		jAlert("表单标签Y轴边界溢出");
	}
}
/*
	标签勾选控制是否显示
*/
function isLabelShow(id){
	var labelborderid;
	if(id==null){
		labelborderid="label_border_"+$("#select_monitor_widget").val();
	}else{
		labelborderid="label_border_"+id;
	}

	if($("#label_show").attr("checked")=="checked") {
		$("#"+labelborderid).css("display","block");
		$("#labelisshow").val('1')
		var flag=0;//记录equ是否被展示
		$("div").each(function(){ 
			var id = $(this).attr("id");
			if(id==labelborderid){
				flag=1;
			}
		});
		if(flag==1){
			$(".class_label_adjust").removeAttr("disabled");
		}
	}else{
		$(".class_label_adjust").attr("disabled","disabled");
		$("#"+labelborderid).css("display","none");
		$("#labelisshow").val('0');
	}
}
/*
	初始化页面表单
	置为初始值
*/
function initEmptyLabelText(){
	var showproperty=$("#showproperty").val();
	$("#select_monitor_widget").val('0');
	$("#label_show_id").val("monitor_widget_0");
	$("#classinstanceid").val('0');
	$("#labeltitle").val("请输入标题");
	$("#labelx").val(100);
	$("#labely").val(100);
	$("#arrowstyle").val('0');
	if(showproperty=='0'){
		$("#labelwidth").val(170);
	}else{
		$("#labelwidth").val(70);
	}
	$("#labelheight").val(20);
	$("#labelisshow").val("1");
	$("#label_show").attr("checked",true);
	$("#equal_label_title").attr("checked",true);
	isEquShow(null);
	isEquClick(null);
	showList.length=0;
	unitsList.length=0;
	$("#show_properties").empty();
	$("#equ_property").empty();
	$("#equ_property").append("<option value='0'>--请选择设备属性--</option>");
}
/*
	载入设备标签数据
*/
function loadLabelWidgetData(labelwidgetid){
	$.getJSON("<c:url value='/monitorscreen/manageLabelOne'/>"+"?temp="+Math.random(),{widgetid:labelwidgetid},function(data){
		 if(data.length==1)	{
			$.each(data, function(i,item){
				$("#label_show_id").val("monitor_widget_"+labelwidgetid);
				$("#classinstanceid").val(item.classinstanceid);
				$("#labeltitle").val(item.title);
				$("#labelx").val(item.x);
				$("#labely").val(item.y);
				$("#labelisshow").val(item.isshow);
				$("#labelwidth").val(item.width);
				$("#labelheight").val(item.height);
				$("#arrowstyle").val(item.arrowstyle);
				$("#properties").val(item.properties);
				$("#units").val(item.units);
				if(item.isshow=='1'){
					$("#label_show").attr("checked",true);
				}else{
					$("#label_show").attr("checked",false);
				}
				$("#labelfontsize").val(item.fontsize);
				$("#labelfontcolor").val(item.fontcolor);
				
				$(".label_control_btn").removeAttr("disabled");
				$(".class_label_adjust").removeAttr("disabled");
				$(".label_init").removeAttr("disabled");
				$(".label_alert").css("display","none");
				initEquProperty(item.classinstanceid,item.properties,item.units);//初始化属性列表并初始化选择区域
				var borderid="label_border_"+labelwidgetid;
				$(".label_tag").css("border","none"); 
				$(".label_tag").css("filter","none");          
				$("#"+borderid).css("border","1px dotted #00FF00"); //标识被选中
				$("#"+borderid).css("filter","Glow(color=#00FF00,strength=12)");
				
				$("#"+borderid).easydrag();
				$("#"+borderid).css("z-index",50);
				var easy_x=$("#"+borderid).css("left").split("px")[0];
				var easy_y=$("#"+borderid).css("top").split("px")[0];
				//alert(easy_x+"----"+easy_y);
				if(easy_y=="auto"|easy_x=="auto"){
					$("#labelx").val(item.x);
					$("#labely").val(item.y);
				}else{
					if(easy_x<0||(1*easy_x+1*item.width)>1600||easy_y<0||(1*easy_y+1*item.height)>1000){
						jAlert("表单标签轴边界溢出");
						$("#"+borderid).css("top",item.y);
						$("#"+borderid).css("left",item.x);
						$("#labelx").val(item.x);
						$("#labely").val(item.y);
						return;
					}else{
						$("#labelx").val(easy_x);
						$("#labely").val(easy_y);
					}
				}
			});
		}else{
			initEmptyLabelText();
		}
	});
}
/*
	检验页面表单标签名称是否重复
*/
function checkLabelTitle(value){
	if(value.trim()==""){
		$("#alert_label_title").empty().append("请输入标题").css("display","block");
		return;
	}else{
		$("#alert_label_title").css("display","none");
		
		if(value!=null){
			 $("#select_monitor_widget option").each( function() { 
				 if(value==$(this).text()){
					 if(("monitor_widget_"+$(this).val())!=$("#label_show_id").val()){
						 $("#alert_label_title").empty().append("标题重复").css("display","block");
						 return;
					 }
				 }
			} ); 
		}
	}
}
/*
	根据设备控件所绑定设备实例生成监测控件绑定设备实例
	暂时不启用 20140819
*/
function initLabelClassintanceid(){
	var instid=new Array();
	var instname=new Array();
	var projectid=$("#select_project").val();
	var pageid=$("#select_page").val();
	
	var url=path+"/proequ/queryMonitorEquList.action?projectid="+projectid+"&pageid="+pageid+"&temp="+Math.random();
	$.getJSON(url,function(data){
		 if(data.length>0)	{
			$.each(data, function(i,item){
				instid.push(item.classinstanceid);
				var text=$("#equid option[value='"+item.classinstanceid+"']").text();
				instname.push(text);
			});
			$("#classinstanceid").empty();
			$("#classinstanceid").append("<option value='0'>--请选择设备--</option>");
			for(var j=0;j<instid.length;j++){
				$("#classinstanceid").append("<option value='"+instid[j]+"'>"+instname[j]+"</option>");
			}
		}
	});	
}
/*-----------------------------------------------------------监测控件操作函数----------------------------------------------------------*/
</script>