<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--运行监测-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>远程能源管理系统</title>
<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
<script src="<c:url value='/resources/js/common_monitor.js ' />"></script>
<script src="<c:url value='/resources/js/my.js ' />"></script>
<script src="<c:url value='/resources/js/util.js ' />"></script>
<script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js ' />"></script>
<script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
<script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
<style>
body {
	margin: 0 auto;
	padding: 0px;
}
table td {
	text-indent: 0px;
	padding: 0px;
}
.td_controler img {
	min-width: 160px;
	min-height: 100px;
}
.td1, .td2, .td3, .td4, .td5, .td6, .td7, .td8, .td9, .td10, .td11, .td12 {
	text-align: center;
	align: center;
}
.td1 img, .td2 img, .td3 img {
	vertical-align: bottom;
}
.td10 img, .td11 img, .td12 img {
	vertical-align: right;
}
.td4 img, .td5 img, .td6 img {
	vertical-align: left;
}
.td7 img, .td8 img, .td9 img {
	margin-top: -1px;
	vertical-align: top;
}
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: none;
}
a:active {
	text-decoration: none;
}
p {
	padding-left: 10px;
}
.input_border {
	height: 13px;
	width: 42px;
	text-align: right;
	border-left: 0px;
	border-top: 0px;
	border-right: 0px;
	border-bottom: 0px
}
.time_border {
	text-align: right;
	border-left: 0px;
	border-top: 0px;
	border-right: 0px;
	border-bottom: 0px
}
.long_btn {
	background-color: #FFF;
	border: 1px solid #000000;
	height: 24px;
	width: 66px;
	font-size: 12px
}
.leftMCont {
	float: left;
	width: 195px;
	background: #fff;
	border: 1px solid #E4E4E4;
	-moz-box-shadow: 0 3px 3px #E3E3E3; /* Firefox */
	-webkit-box-shadow: 0 3px 3px #E3E3E3; /* Safari and Chrome */
	box-shadow: 3px 3px 3px #E3E3E3;
}
.main_head {
 BACKGROUND: url(<c:url value='/resources/img/monitorscreen/img3-5_2.png'/>) no-repeat;
 background-color:#329CE8;

}
* HTML .main_head {
 FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="<c:url value='/resources/img/monitorscreen/img3-5_2.png'/>", sizingMethod='crop');
	BACKGROUND: none transparent scroll repeat 0% 0%
}
* + HTML .main_head {
 BACKGROUND: url(<c:url value='/resources/img/monitorscreen/img3-5_2.png'/>) no-repeat
}
.Obtn {
	MARGIN-TOP: 104px;
	WIDTH: 32px;
BACKGROUND: url(<c:url value='/resources/img/monitorscreen/img3-5_1.png'/>) no-repeat;
	FLOAT: left;
	HEIGHT: 139px;
	MARGIN-LEFT: 0px;
	cursor: pointer;
}
* HTML .Obtn {
 FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="<c:url value='/resources/img/monitorscreen/img3-5_1.png'/>", sizingMethod='crop');
	WIDTH: 32px;
	BACKGROUND: none transparent scroll repeat 0% 0%;
	FLOAT: left;
	HEIGHT: 139px
}
* + HTML .Obtn {
	MARGIN-TOP: 104px;
	WIDTH: 32px;
BACKGROUND: url(<c:url value='/resources/img/monitorscreen/img3-5_1.png'/>) no-repeat;
	FLOAT: left;
	HEIGHT: 139px;
	MARGIN-LEFT: -5px
}
.left_nav ul {
	width: 250px;
	height: 500px;
	overflow: hidden;
	overflow-y: auto;
}
.left_nav ul li {
	width: 250px;
	height: 30px;
	line-height: 30px;
	border-bottom: 1px solid #E4E4E4;
	float: left;
}
.left_nav ul li.cur{
	background-color:#86CCFF;
}
.left_nav ul li a {
	margin-left: 10px;
	color: #728492;
	font-size: 12px;
	font-family: 微软雅黑;
}
.left_nav ul li.cur a{
	color:white;
}
html {
	overflow: hidden;
	
}
.xmgl_taba {
	display: block;
	text-align: center;
	color: #fff;
	float: left;
	width: 76px;
	height: 29px;
	line-height: 30px;
}
.xmgl_tabasel {
 background:url(<c:url value='/resources/img/xmgl_shwotab.png'/>) no-repeat;
	color: #2878c9;
}
.odd {
	border-top: 1px solid #E6E6E6;
	border-bottom: 1px solid #E6E6E6;
	background: #F3F3F3;
}
</style>

</head>
<body style="background-color:#fff;overflow-x:auto;overflow-y:hidden;">
<input name="hidden" type="hidden" id="cid"/>
<input name="hidden" type="hidden" id="pageid"/>
<input name="hidden" type="hidden" id="state"/>
<input name="hidden" type="hidden" id="data"/>
<input name="projectid" type="hidden" id="projectid"/>
<input name="hidden" type="hidden" id="rectime"/>
<input name="hidden" type="hidden" id="boxvalue"/>
<jsp:include page="../header.jsp"></jsp:include>
<div class="nav-nav nav-secnav clear">
  <div class="sel_nav ml10"> <a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span></a> </div>
</div>
<div class="area_popup">
  <div class="datalist-div" style="padding-bottom: 0px;">
    <div class="area-tit"> <a class="smalllogo"></a> </div>
    <ul id="treeDemo" class="ztree">
    </ul>
  </div>
</div>
<div id="container" style="overflow-x:hidden;overflow-y:scroll; background-color:#FFFFFF;display:block;">
  <div id="outmain" style=" position:relative; height:1000px; ">
    <div id="maincontent" style=" position:absolute;background-repeat: no-repeat; width: 1600px; height: 1000px; z-index:0; background-color:#fff"> </div>
  </div>
</div>
<!-- new add start -->
<div id="xixi" onclick="checkShow();" style="z-index: 999;width:285px;">
  <table style="float: left; width: 250px; background: #fff; border: 1px solid #E4E4E4; -moz-box-shadow: 0 3px 3px #E3E3E3; 
    -webkit-box-shadow: 0 3px 3px #E3E3E3;box-shadow: 3px 3px 3px #E3E3E3; " border="0">
    <tbody>
      <tr>
        <td class="main_head" height="32" valign="top"></td>
      </tr>
      <tr>
        <td class="left_nav">
			<ul id="menulist">
				<li><a>请选择项目</a></li>
			</ul>
		</td>
      </tr>
    </tbody>
  </table>
  <div class="Obtn"></div>
</div>
<script type="text/javascript">
    showleftMenu = function (id, _top, _left) {
        var me = id.charAt ? document.getElementById(id) : id, d1 = document.body, d2 = document.documentElement;
        d1.style.height = d2.style.height = '100%'; me.style.top = _top ? _top + 'px' : 0; me.style.left = _left + "px";//[(_left>0?'left':'left')]=_left?Math.abs(_left)+'px':0;
        me.style.position = 'absolute';
        setInterval(function () { me.style.top = parseInt(me.style.top) + (Math.max(d1.scrollTop, d2.scrollTop) + _top - parseInt(me.style.top)) * 0.1 + 'px'; }, 10 + parseInt(Math.random() * 20					));
        return arguments.callee;
    };
	
    window.onload = function () {
    	
		setSize();
		$("#xixi").mouseover(function () {
           
            toBig();
        })
        $("#xixi").mouseout(function () {
            toSmall();
            
        })
        showleftMenu('xixi', 128, -215);
		
    };
	function setSize()
	{
		var screenW=document.documentElement.clientWidth;
	    var screenH=$(window).height();
		var scrH=$(window).height()- 130;
		$("#container").css("height",scrH+"px");
		
		$(".head").css("min-width",1200);
		$("#container").css("min-width",1200);
		/*if(screenW<1200){
			$(".head").css("width",1200);
			$("#container").css("width",1200);
	    }else{
			$(".head").css("width",$(window).width());
			$("#container").css("width",$(window).width());
		}*/
        
    }
    lastScrollY = 0;
    var InterTime = 1;
    var maxWidth = -1;
    var minWidth = -250;
    var numInter = 8;
    var BigInter;
    var SmallInter;
    var temp = "show";
    var o = document.getElementById("xixi");
    var i = parseInt(o.style.left);
    function Big() {
        if (parseInt(o.style.left) < maxWidth) {
            i = parseInt(o.style.left);
            i += numInter;
            o.style.left = i + "px";
            if (i == maxWidth)
                clearInterval(BigInter);
        }
    }
    function checkShow() {
        if (temp == "show")
            toBig();                                                                                                                                                    
        else
            toSmall();
    }
    function toBig() {
        clearInterval(SmallInter);
        clearInterval(BigInter);
        BigInter = setInterval(Big, InterTime);
        temp = "hide";
    }
    function Small() {
        if (parseInt(o.style.left) > minWidth) {
            i = parseInt(o.style.left);
            i -= numInter;
            o.style.left = i + "px";

            if (i == minWidth)
                clearInterval(SmallInter);
        }
    }
    function toSmall() {
        clearInterval(SmallInter);
        clearInterval(BigInter);
        SmallInter = setInterval(Small, InterTime);
        temp = "show";
    }

    function showinfo(mark, _this) {
    	$(".info").css("display","none");
        $(".xmgl_tbladd").css("display", "none");
        $("#info_" + mark).css("display", "block");
        $(".xmgl_taba").removeClass("xmgl_tabasel");
        $(_this).addClass("xmgl_tabasel");
    }
    </script> 
<!-- new add end -->
<div class="mod-pop" id="pop-xmgl" style="height: 480px;width:940px">
  <div class="hd">
    <h2></h2>
    <p style="width:156px;height:33px;float:right ; z-index:100000;margin-top:-21px;margin-right:20px;"> <a class="xmgl_taba xmgl_tabasel a1" onclick="showinfo(1,this);">动态参数</a> <a class="xmgl_taba" onclick="showinfo(2,this);">静态参数</a> </p>
  </div>
  <div class="bd" id="hichart" >
    <table width="940px" border="0" cellspacing="0" cellpadding="0" align="center" id="info_1" style="display:block" class="info">
      <tr>
        <td width="310px" id="equinstancepropertylist" align="center" bgcolor="#FFFFFF" height="400px"></td>
        <td  align="left" bgcolor="#FFFFFF"><div id="property_container" style="margin-top: 10px; width:575px; height:400px;margin-bottom:10px"> </div></td>
      </tr>
    </table>
    <div style='overflow-y:auto;overflow-x:hidden; width:900px;height:402px;margin-top:12px;display:none;' id="info_2" class="info">
	    <table width="880px" border="0" cellspacing="0" cellpadding="0" align="center"  id="info_2_content" style="font-size:13px" >
	      <tbody>
	      </tbody>
	    </table>
    </div>
  </div>
</div>
</body>
</html>
<script>
var ajaxbg = $("#background,#progressBar");
ajaxbg.hide();
$(window).resize(function(){
	setSize();
});
$(document).ready(function () {
	pid=null;
	showmenulist();
 	var setting = {
    		data: {simpleData: {enable:true}},
    		callback: {onClick:onClick}
		};
 	
	 	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />",success:function(data){
			$.fn.zTree.init($("#treeDemo"), setting, data);
			$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
			toSmall();
		}});
		function onClick(event,treeID,treeNode,clickFlag) {
			if(treeNode.isParent){return;};
			var parentNode = treeNode.getParentNode();
			pid = treeNode.id;
			$("#curCity").empty().append("<span>"+parentNode.getParentNode().name+"</span>-<span>"+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
			$(".area_popup").hide();
			$("#curCity").removeClass("on");
			setSession(pid);
			showmenulist();
		}
		$("#curCity").bind("click",function(){
			toSmall();
		});
    	function setSession(pid){
			$.ajax({type:"GET",url:"<c:url value='/analyse/session' />",data:{pid:pid}});
		}
});
/*
 * 获取页面位移宽度 弃用
 */
function getHeight(){
	var height=0;
	winHeight = document.documentElement.clientHeight;
	if((winHeight*1-127-620)>0){
		height=(winHeight*1-620-127)/2;
	}else{
		height=0;
	}

	return height;
}
/*
 * 获取页面位移高度 弃用
 */
function getWidth(){
	var width=0;
	winWidth = document.documentElement.clientWidth;
	width=(winWidth*1-1280)/2;
	return width;
}

//菜单列表
function showmenulist(){
	if(pid==null){
		pid=${pid};
	}
	var width=0;
	var height=0;
	$.ajax({
		type:"GET",url:"<c:url value='/monitorscreen/pagemenu'/>",data:{projectid:pid,supply:1,flag:0,temp:Math.random()},
		success:function(data){
				if(data.length>0){
					$("#maincontent").css("display","block");
					var str="";
					for (i = 0; i < data.length; i++) {
						str+="<li><a onClick='querymonitorequparameter("+pid+","+data[i].pageid+","+height+","+width+","+data[i].showproperty+")'>"+data[i].title+"</a></li>";
					}
					$("#menulist").empty().append(str);
					querymonitorequparameter(pid,data[0].pageid,height,width,data[0].showproperty);
				}else{
					$(".graphlist").remove();
					$(".labellist").remove();
					$("#maincontent").css("display","none");
					$("#menulist").empty().append("<li><a>项目未配置运行监测</a></li>");
				}
				$('#menulist li a').click(function(){
					$(this).parent().addClass('cur').siblings().removeClass('cur');
				})
		}
	});
}
//test
var title_value = ''; 
function title_show(td,title,type) {
	var div=document.getElementById("title_show");	
	title_value = td.title;
	if(type==1){
		div.style.left = (td.offsetLeft+30)+"px";		
		div.style.top = (td.offsetTop+50)+"px";		
	}else{
		div.style.left = (td.offsetLeft+30)+"px";		
		div.style.top = (td.offsetTop+30)+"px";		
	}

	div.innerHTML = title;
	div.style.display = '';
	td.title = '';		//去掉原有title显示。
}

function title_back(td) {
	var div=document.getElementById("title_show");	
	td.title = title_value;
	div.style.display = "none";
}
//test
//显示设备控件 graphlist
function querymonitorequparameter(projectid,pageid,height,width,showproperty) {
	/*
		显示遮罩开始
	*/
	var screenW=document.documentElement.clientWidth,temp;
	if(screenW < 1200) temp = 1200;
	else if(screenW < 1600) temp = 1600;
	$("#background").css("width",temp);
	$("#progressBar").css("left",screenW/2+$(document).scrollLeft()-50);
	ajaxbg.show();
	$('#container').css("overflow-x","scroll");
	/*
		显示遮罩结束
	*/
	
	$("#pageid").val(pageid);
	$("#container").css("display","block");
	$("#pageid").val(pageid);
	$(".graphlist").remove();
	$(".labellist").remove();
	$("#maincontent").empty();
	var path="<%=request.getContextPath()%>";
	showmenubg(pageid,height,width);
	//$("#maincontent1").empty();
	$.getJSON("<c:url value='/monitorscreen/graphlist'/>",{pageid:pageid,flag:0,temp:Math.random()},function (data) {
		if (data != null) {
			var str = "";
			$.each(data, function (i, item) {				
				var t = i + 1;
				str += "<div style='z-index: 2;' onmouseover=\"title_show(this,'"+item.title+"',1);\" onmouseout=\"title_back(this);\"  id='equ_widget_" + item.widgetid + "' class='graphlist'>"+
				   	   "<a id='equ_a_" + item.widgetid + "' class='fancybox' href='#pop-xmgl'>"+
				   	   "<img id='img_" + item.widgetid + "' src='"+path+item.picturepath+"'  alt='"+item.title+"' width='"+item.width+"' height='"+item.height+"'/>"+
				   	   "</a>"+
				   	   "</div>" +
				   	"<div id='title_show' style='position:absolute;display:none;border:solid 1px #999999;background:#edeef0;z-index:100000'></div>";
			});
			$("#maincontent").append(str);
			$.each(data, function (i, item) {
				var x=item.x*1;//+width*1;
				var y=item.y*1;//+height*1;
				var graph_style={"position":"absolute","left":x+ "px","top":y+ "px"};
				var a_style={"width":item.width + "px","height":item.height +"px","display":"block"};
				$("#equ_widget_"+item.widgetid).css(graph_style);
				$("#equ_a_"+item.widgetid).css(a_style);
				if(item.isshow=='0'){
					$("#equ_widget_"+item.widgetid).css("display","none");
				}
				if(Number(item.isclick)!=0){
					$("#equ_a_"+item.widgetid).attr("href","#pop-xmgl");
					$("#equ_widget_"+item.widgetid).bind('click',function(){
						$(".hd h2","#pop-xmgl").text(item.title);
						queryboxProperty(item.classinstancename,item.widgetid,item.classinstanceid);
						$("#property_container").empty();
					});
				}else{
					$("#equ_a_"+item.widgetid).attr("href","javascript:void(0);");
					$("#equ_widget_"+item.widgetid).unbind();
				}		
			});	
		}	
			ergodicLabelWidget(pid,pageid,height,width,showproperty);//生成监测
	});

}
/*
	遍历生成监测框
*/
var labelArray=new Array();
function  ergodicLabelWidget(projectid,pageid,height,width,showproperty){
	labelArray=[];
	var path="<%=request.getContextPath()%>";
	$.getJSON("<c:url value='/monitorscreen/labellist'/>",{projectid:pid,pageid:pageid,temp:Math.random()},function(data){
		 if(data!=null)	{
		 	labelArray=data;
			$.each(data, function(i,item){
				var labelx=item.x*1;
				var labely=item.y*1;
				var labelwidth=item.width*1;
				var labelheight=item.height*1;
				var labelfontsize=item.fontsize;
				var labelfontcolor=item.fontcolor;
				var labelid="monitor_widget_"+item.widgetid;
				var labelborderid="label_border_"+item.widgetid;
				var classinstanceid=item.classinstanceid;
				var labelborder="<div id=\""+labelborderid+"\" class=\"label_tag labellist\" onmouseover=\"title_show(this,'"+item.title+"',2);\" onmouseout=\"title_back(this);\" style=\"width:"+labelwidth+"px\"></div>"+
				"<div id='title_show' style='position:absolute;display:none;border:solid 1px #999999;background:#edeef0;z-index:100000'></div>";
				var labelborder_style={"z-index": 3,"position": "absolute","left": labelx+"px","top": labely+"px"};	
				var labeltable="<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\""+labelwidth+"px\">"+
									"<tr>"+
										"<td id=\""+labelid+"\"></td>"                                                                                                        +
									"</tr>"+
								"</table>";
				var table_style={"width":labelwidth+"px","height":labelheight+"px","font-size":"12px","color":labelfontcolor};
				
				$("#maincontent").append(labelborder);
				$("#"+labelborderid).append(labeltable);
				$("#"+labelborderid).css(labelborder_style);

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
				var propertyids=new Array();      //控件单位
				if(item.properties!=null){
					propertyids=item.properties.split(",");
				}

				if(showproperty==1){
					for(i=0;i<propertyids.length;i++){
						var element={
								id:propertyids[i],
								name:' ',
								unit:' '
							}
						labelproperties.push(element);
						var labelinit=initWatchTable(classinstanceid,labelproperties,labelunits,labelid,table_style,labelfontsize,showproperty);
					}
				}else{
					$.getJSON("<c:url value='/monitorscreen/labelproperties'/>",{properties:item.properties,temp:Math.random()},function(json){
						 if(json!=null)	{
							$.each(json, function(i,item){
								var element={
									id:item.classpropertyid,
									name:item.classpropertyname,
									unit:' '
								}
								labelproperties.push(element);
							});
							var labelinit=initWatchTable(classinstanceid,labelproperties,labelunits,labelid,table_style,labelfontsize,showproperty);
						  }
						 ajaxbg.hide();
					 });
				}
			}); //each结束
			setTimeout(initWatchDataNew,3000);//首次加载
			ajaxbg.hide();
			clearInterval($("#data").val());
			clearInterval($("#state").val());
			var data=setInterval(initWatchDataNew, 60000); //60S加载
			var state=setInterval(equState, 60000); //60S加载
			$("#data").val(data);
			$("#state").val(state);
		}//if结束
	});
}

/*
	生成监测控件属性内容
*/
var initWatchTable = function(classinstanceid,showList,unitsList,labelid,style,labelfontsize,showproperty){
	var str="<table id=\"data_"+labelid+"\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
	for(var i=0;i<showList.length;i++){
		str+="<tr>";
		if(showproperty=='0'){
			str+="<td align=\"right\">"+showList[i].name+"</td>";
		}
		str+="<td align=\"center\" width=\"45px\"><input id=\"data_"+classinstanceid+"_"+showList[i].id+"\" type=\"text\" readonly=\"readonly\" value=\"0.00\" class=\"input_border data_"+classinstanceid+"_"+showList[i].id+"\" style=\"font-size:"+labelfontsize+"px;background-color:transparent\"/></td>";
    	str+="<td align=\"left\" width=\"20px\">"+unitsList[i]+"</td></tr>";
	}
	str+="</table>";
	$("#"+labelid).html("").append(str);
	$("#data_"+labelid).css(style);
};
/*
	生成监测数据
	更新：根据设备id分组，把同一设备属性归类统一提交
*/
function  initWatchData(){	
	if(labelArray.length>0){
	 var group = new Array();
	 $.each(labelArray,function(i,item){
		 group.push(item.classinstanceid);
	 });
	 var fgroup=uniq(group);
	 for(var j=0;j<fgroup.length;j++){
		 var songroup=new Array();
		 $.each(labelArray,function(i,item){
			 if(item.classinstanceid==fgroup[j]){
				 songroup.push(item.properties);
			 }
		 });
	 };
	}
	var state=equState();
}


/*
生成监测数据
更新：根据设备id分组，把同一设备属性归类统一提交
*/
function  initWatchDataNew(){	
	 $.getJSON("<c:url value='/monitorscreen/labeldataAll'/>",{projectid:pid,pageid:$("#pageid").val(),temp:Math.random()},function(json){
	 		if(json.length>0){
	 			$.each(json,function(j,item){
	 				var val=item.datavalue;
	 				if(isNaN(val)){
	 					val="0.00";
	 				}else{
	 					val=parseFloat(val).toFixed(2);
	 				}
	 				var old_val=$(".data_"+item.classinstanceid+"_"+item.classpropertyid).val();
	 				if(old_val!=val){
	 					$(".data_"+item.classinstanceid+"_"+item.classpropertyid).val(val)
	 					.queue(function(){$(this).css("color","#FF0000");$(this).dequeue();}).delay(300)
	 					.queue(function(){$(this).css("color","#000000");$(this).dequeue();}).delay(300)
	 					.queue(function(){$(this).css("color","#FF0000");$(this).dequeue();}).delay(300)
	 					.queue(function(){$(this).css("color","#000000");$(this).dequeue();}).delay(300)
	 					.queue(function(){$(this).css("color","#FF0000");$(this).dequeue();}).delay(300)
	 					.queue(function(){$(this).css("color","#000000");$(this).dequeue();});
	 				}
	 			});
	 			
	 		};
	 });
}
/*
	更新监测设备状态
*/
var equState = function (){
	var path="<%=request.getContextPath()%>";
	$.getJSON("<c:url value='/monitorscreen/graphlist'/>",{pageid:$("#pageid").val(),flag:0,temp:Math.random()},function (data) {
		if (data != null) {
			var str = "";
			$.each(data, function (i, item) {
				var old_path=$("#img_"+item.widgetid).attr("src");
				var new_path=path+item.picturepath;
				if(old_path!=new_path){
					$("#img_"+item.widgetid).attr("src",new_path);
				}
			});
		}
	});
};

//菜单列表
function showmenubg(pageid,height,width){
	var path="<%=request.getContextPath()%>";
	var str="";   
	var bgstr="";
	$.getJSON("<c:url value='/monitorscreen/pagedata'/>",{pageid:pageid,temp:Math.random()}, function (data) {
		if (data != null) {		
			bgstr=path+"/"+data[0].pageimage;
			$("#maincontent").css("left",width+160+"px"); // center in 1920
			$("#maincontent").css("top",height+"px");
			$("#maincontent").css("z-index","0");
			$("#maincontent").css("background","transparent url("+bgstr+") scroll "+data[0].pgimagex+"px "+data[0].pgimagey+"px");
			$("#maincontent").css("background-repeat","no-repeat");
			$("#maincontent").css("min-width",'1200px');
			$("#maincontent").css("height","1000px");
		}
		$("#page_title").remove();
		var titley=parseInt(data[0].titley);
		var style={"z-index": "4","position": "absolute","line-height":data[0].titleheight+"px",
	    "left": data[0].titlex+"px","top": titley+"px","width": data[0].titlewidth+"px","height": data[0].titleheight+"px",
		"text-align":"center","font-size": data[0].fontsize+"px","color": data[0].fontcolor,"background-color":data[0].titlebgcolor,
		"border":"1px solid "+data[0].titlebordercolor,"font-weight":"bold","filter": "alpha(opacity = 70)","-moz-opacity": 0.7,"pacity": 0.7,"font-family":"微软雅黑"};
		var titleid="page_title";
		var timefontsize=parseInt(data[0].fontsize)-5;
		var timewidth=parseInt(data[0].titlewidth)-40;
		var timeheight=parseInt(data[0].titleheight)/2;
	
		var titlecontent="<div id='"+titleid+"' style='width:"+ data[0].titlewidth+"px;height:"+data[0].titleheight+"px;z-index:4;position:absolute;left:"+data[0].titlex+"px;top:"+data[0].titley+"px;'>"+data[0].title+"</div>";
		$("#maincontent").append(titlecontent);
		//alert(titlecontent);
		$("#"+titleid).css(style);
		if(data[0].titleisshow=='0'){
			$("#"+titleid).css("display","none");
		}
	});
}
//点击设备控件事件
function queryboxProperty(instname,equid, classinstanceid) {
	ajaxbg.show();
    $(".xmgl_taba").removeClass("xmgl_tabasel");
    $(".a1").addClass("xmgl_tabasel");
	$("#info_1").css("display","block");
	$("#info_2").css("display","false");
	$("#cid").val(classinstanceid);
	$.getJSON("<c:url value='/monitorscreen/boxProperty'/>",{classinstanceid:classinstanceid,temp:Math.random()}, function (data) {
		if (data != "") {
			popFancybox();
			str1 ="";
			str1+="<div style='overflow-y:auto;overflow-x:hidden; width:305px;height:350px;margin-top:5px' ><div style='height:340px'>"
			str1 += "<table style='font-size:13px;margin-top:5px' width='280px' border='0'>";
			$.each(data, function (i, item) {
				var name=item.classpropertyname;
				if(name.length>8){
					name=name.substring(0,8)+"..";
				}
				var unit;
				item.unitname=="&nbsp;"?unit="":unit=item.unitname;
				if(item.propertytypeid==16){
					str1 += "<tr><td align='right' width='140px' height='23px' title='"+item.classpropertyname+"'>" + name+":&nbsp</td>"+
					 "<td width='55px' align='center'><input id='box_equ_state' type='image' src='<c:url value='/resources/img/equclass/stat_gray.png'/>'></td>"+
					 "<td align='left' width='40px'>&nbsp</td>"+								
					 "<td align='left' width='30px'><input type='checkbox' name='equproperty' value='" + item.classpropertyid + ","+ item.classpropertyname +"   "+unit+"' onClick='initLine(\""+classinstanceid+"\",\""+instname+"\");'>&nbsp</td></tr>";								
				}else{
					str1 += "<tr><td align='right' width='140px' height='23px' title='"+item.classpropertyname+"'>" + name+":&nbsp</td>"+
					 "<td width='55px'><input class='box_"+item.classinstanceid+"_"+item.classpropertyid+ "' value=' ' style='width:55px; text-align:right;' readonly = 'readonly'/></td>"+
					 "<td align='left' width='40px'>&nbsp"+item.unitname+"</td>"+								
					 "<td align='left' width='30px'><input type='checkbox' name='equproperty' value='" + item.classpropertyid + ","+ item.classpropertyname +"   "+unit+"' onClick='initLine(\""+classinstanceid+"\",\""+instname+"\");'>&nbsp</td></tr>";								
				}
			});
			str1 += "</table>";
			str1 += "</div></div>";
			$("#equinstancepropertylist").empty().append(str1);
			$("#classinstancename").val(data[0].classinstancename);
			$("#classinstanceid").val(data[0].classinstanceid);
			
			setTimeout(showpropertyvalue,5000);//首次加载
		
			clearInterval($("#boxvalue").val());
			var boxvalue=setInterval(showpropertyvalue, 60000); //60S加载	
			$("#boxvalue").val(boxvalue);
			
			var myDate=new Date();
			initEmptyLine(data[0].classinstancename,myDate.getTime());
			initStaticText(classinstanceid);
		}
		ajaxbg.hide();
	});
}
/*初始化静态属性*/
function initStaticText(classinstanceid){
	$.getJSON("<c:url value='/monitorscreen/initStaticInfo'/>",{classinstanceid:classinstanceid,temp:Math.random()}, function (data) {
		if (data.length>0) {
			var str="<tr>";
			$.each(data, function (i, item) {
				var text=item.datavalue;
				if(item.datavalue==null){
					text="暂无数据";
				}
				var style='';
				if((i+1)%2==0){
					style="border-left: 1px dotted #666";
				}
				str+="<td width='300px' height='30px' align='right' style='"+style+"'>"+item.classpropertyname+":&nbsp</td>";
				str+="<td width='140px'>"+text+"</td>";
				if((i+1)%2==0){
					str+="</tr><tr>";
				};
			});
			var num=data.length%2;
			if(num==1){
				str+="<td style='border-left: 1px dotted #666'></td><td></td>";
			}
			str+="</tr>";
			$("#info_2_content tbody").empty().append(str);
			$("#info_2_content tbody tr:even").addClass("odd");
		}else{
			$("#info_2_content tbody").empty().append("<tr><td>无静态数据</td></tr>");
		}
	});
}
/*初始化空曲线*/
function initEmptyLine(instname,mseconds){
	var e_line=new Array();
	var series=new Array();
	var ytick=[0,5,10,15,20];
	for(var i=0;i<60;i++){
		mseconds-=60000;
		e_line.push([Number(mseconds),null]);
	}
	var item={name:' ',data: e_line};
	series.push(item);
	propchartInit(instname+" 动态属性1h实时数据对比",series,null,false,ytick);
}
/*
初始化表单框属性
*/
function showpropertyvalue(){
var path="<%=request.getContextPath()%>";
var classinstanceid=$("#cid").val();
$.getJSON("<c:url value='/monitorscreen/boxValue'/>",{classinstanceid:classinstanceid,temp:Math.random(),},function(data){
	 if(data!=null)	{
	 	$.each(data,function(i,item){
	 		if(item.propertytypeid==16){
	 			var val=item.datavalue;
	 			if(val==0){
	 				$("#box_equ_state").attr("src",path+"/resources/img/equclass/stat_gray.png");
	 			}else{
	 				$("#box_equ_state").attr("src",path+"/resources/img/equclass/stat.png");
	 			}
	 		}else{
		 		var val=item.datavalue;
				if(isNaN(val)){
					val="0.00";
				}else{
					val=parseFloat(val).toFixed(2);
				}
 				var old_val=$(".box_"+item.classinstanceid+"_"+item.classpropertyid).val();
 				if(old_val!=val){
 					$(".box_"+item.classinstanceid+"_"+item.classpropertyid).val(val)
 					.queue(function(){$(this).css("color","#FF0000");$(this).dequeue();}).delay(300)
 					.queue(function(){$(this).css("color","#000000");$(this).dequeue();}).delay(300)
 					.queue(function(){$(this).css("color","#FF0000");$(this).dequeue();}).delay(300)
 					.queue(function(){$(this).css("color","#000000");$(this).dequeue();}).delay(300)
 					.queue(function(){$(this).css("color","#FF0000");$(this).dequeue();}).delay(300)
 					.queue(function(){$(this).css("color","#000000");$(this).dequeue();});
 				}
	 		}
	 	});
	  }
 });
}

var line_data=new Array();
var energy_chart;
var timestamp=null;
var interval_temp;

/*
	初始化曲线数据
*/
function initLine(classinstanceid,classinstancename) {
	classpropertyname=[];
	classpropertyid=[];
	objName1 = $("input[name='equproperty']:checked");
	objName = $("input[name='equproperty']");

	for (i = 0; i < objName.length; i++) {
		if (objName[i].checked) {				
			var objval =objName[i].value.split(","); 
			classpropertyid.push(objval[0]);
			classpropertyname.push(objval[1]);
		}
	}
	if(classpropertyid.length>0){
		propLineInit(classinstanceid,classinstancename,classpropertyid);
	}else{
		var myDate=new Date();
		initEmptyLine(classinstancename,myDate.getTime());
	}
}


/*
	初始化曲线
*/
function propLineInit(classinstanceid,classinstancename,classpropertyid){
	var series=new Array();
	
	for(var i=0;i<classpropertyid.length;i++){
		line_data[i]=new Array();  
	}	
	ajaxbg.show();
   	$.getJSON("<c:url value='/monitorscreen/boxLine'/>",{classinstanceid:classinstanceid,classpropertyid:classpropertyid.toString(),temp:Math.random(),},function(data){
   		if(data.length>0){	
   			$.each(data, function(i,item){
   					for(var j=0;j<classpropertyid.length;j++){
						if(classpropertyid[j]==item.classpropertyid){
							var val=checkNullandFixN(item.datavalue,2);
							line_data[j].push([dateInit(item.rectime),parseFloat(val)]);
						}
					}
					if(i=data.length-1){
               			timestamp=dateInit(item.rectime);
               		}
   			});
   			
 					for(var j=0;j<classpropertyid.length;j++){
 						if(line_data[j].length>0){
						var name=classpropertyname[j];	
  						var item={
  							name: name,
		                	data: line_data[j],
		               	 marker: {
		                    enabled: false
		                }
  						};
					series.push(item);
				}
			}
   			propchartInit(classinstancename+" 动态属性1h实时数据对比",series,classinstanceid,true,null);
   		}else{
   			var myDate=new Date();
   			initEmptyLine(classinstancename,myDate.getTime());
   		}
   		ajaxbg.hide();
   	});
}		

function propchartInit(title,series,classinstanceid,legend,ytick){
    Highcharts.setOptions({
        global: {
            useUTC: false
        }
    });
    if(energy_chart!=null){
    	energy_chart.destroy();
    	$("#property_container").empty();
    }
	//var classinstanceid=$("#classinstanceid").val();	
    energy_chart= new Highcharts.Chart({
		colors: ["#CE0000","#FF0080","#E800E8","#921AFF","#0000E3","#0066CC","#00AEAE","#02C874","#00BB00","#E1E100","#EAC100","#FF9224","#FF5809","#949449","#4F9D9D","#7373B9","#9F4D95"],
        chart: {
        	renderTo:'property_container',
            type: 'line',
            animation: Highcharts.svg, // don't animate in old IE
            marginLeft: 60,
            marginTop:40,
            marginRight:10 ,
            events: {
                load: function() {  //load函数是chart初始化之后执行的
                	if(classinstanceid!=null){
			        clearInterval(interval_temp);
			        interval_temp=setInterval(function() {
						$.get("<c:url value='/monitorscreen/boxCurrent'/>",{classinstanceid:classinstanceid,classpropertyid:classpropertyid.toString(),temp:Math.random(),},function(data){ 
			               if(data.length>0){
				               $.each(data, function(i,item){
				               		if(data.length==energy_chart.series.length){
				               			var series=energy_chart.series[i];
				               			series.addPoint([Number(dateInit(item.rectime)),Number(parseFloat(item.datavalue).toFixed(2))], true, true);
				               		}
						    	});
					    	}
						});
			       }, 60000);  
                   }
                }
            }
        },
        title: {
           text: title,
           style: {
                    fontSize:'13px'
                }
        },
        xAxis: {
            type: 'datetime',
            tickPixelInterval: 100,
            dateTimeLabelFormats: {
           	 	minute: '%H:%M'
       		}
        },
        yAxis: {
            title: {
                text: '',
                style: {
                    fontSize:'13px'
                }
            },
            tickPositions: ytick
        },
        tooltip: {
            shared: true,
             dateTimeLabelFormats: {
                minute:"%H:%M"
            },
            valueSuffix: '',
            crosshairs: true
        },
        legend: {
			enabled: legend,
            borderWidth: 0
        },
        exporting: {
            enabled: false
        },
        series: series
    });
}
/*
function SelectAll() {
	var checkboxs = $("input[name='equproperty']");
	for (var i = 0; i < checkboxs.length; i++) {
		var e = checkboxs[i];
		e.checked = !e.checked;
	}
}*/
/*
用途:检验字符串是否为null
返回：为null返回为空，否则非空返回1位小数
*/
function checkNullandFixN(param,n){
	if(param==null||param=="null"){
		return '';
	}else
	{
		param=param*1;
		if(n=='1'){
		param=param.toFixed(1);
		}else
		if(n=='2'){
		param=param.toFixed(2);
		}else
		{
		param=param.toFixed(3);
		}
		return param;
	}
}
/**项目运营 时间解析处理**/
function dateInit(rectime){
	var a=[];
	var b=[];
	var c=[];
	a=rectime.split(" ");
	b=a[0].split("-");
	c=a[1].split(":");
	var myDate=null;
	if(c.length==3){
		myDate=new Date(b[0], b[1]-1, b[2]*1, c[0]*1, c[1]*1, c[2]*1);
	}else{
		myDate=new Date(b[0], b[1]-1, b[2]*1, c[0]*1, c[1]*1,0);
	}
	
	return myDate.getTime();
}
/*array 去重*/
function uniq(array) {
	var map={};
	var re=[];
	for(var i=0,l=array.length;i<l;i++) {
		if(typeof map[array[i]] == "undefined"){
			map[array[i]]=1;
			re.push(array[i]);
		}
	}
	return re;
}
</script>
