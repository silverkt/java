<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<title>远程能源管理系统</title>
<link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/common.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/global.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/context.css' />"
	rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
<script src="<c:url value='/resources/js/common.js ' />"></script>
<script src="<c:url value='/resources/js/my.js ' />"></script>
<script src="<c:url value='/resources/js/util.js ' />"></script>
<script src="<c:url value='/resources/js/common_monitor.js ' />"></script>



<script src="<c:url value='/resources/js/ScreenMonitor/jquery.easydrag.handler.js' />"></script>
<script src="<c:url value='/resources/js/ScreenMonitor/jquery.form.js' />"></script>

<style type="text/css">


.select_border {
	border: 2px dotted #0033FF;
}

table td {
	text-indent: 0px;
	padding: 0px;
}

.td_controler img {
	min-width: 160px;
	min-height: 100px;
}

.td1,.td2,.td3,.td4,.td5,.td6,.td7,.td8,.td9,.td10,.td11,.td12 {
	text-align: center;
	align: center;
}

.td1 img,.td2 img,.td3 img {
	vertical-align: bottom;
}

.td10 img,.td11 img,.td12 img {
	vertical-align: right;
}

.td4 img,.td5 img,.td6 img {
	vertical-align: left;
}

.td7 img,.td8 img,.td9 img {
	margin-top: -1px;
	vertical-align: top;
}

.long_btn {
	background-color: #FFF;
	border: 1px solid #000000;
	height: 24px;
	width: 66px;
	font-size: 12px;
	cursor: hand;
}

.short_btn {
	background-color: #FFF;
	border: 1px solid #000000;
	height: 22px;
	width: 22px;
	font-size: 11px;
	cursor: hand;
}

.high_btn {
	line-height: 100px;
	cursor: hand;
	border: none;
	background: url(<c:url value='/resources/img/modeless/btn.jpg'/>)
		no-repeat 0 0;
	height: 100px;
	width: 15px;
}

.box_btn {
	line-height: 60px;
	cursor: hand;
	border: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	top: 7px;
	right: 13px;
	width: 26px;
	height: 15px;
	background: url(<c:url value='/resources/img/modeless/asyncbox_bg.png'/>) no-repeat -28px 0;
}

.add_btn {
	background-color: #FFF;
	border: 1px solid #000000;
	height: 23px;
	width: 30px;
	font-size: 10px cursor:hand;
}

.upload_btn {
	background-color: #FFF;
	border: 1px solid #000000;
	height: 23px;
	width: 30px;
	font-size: 11px;
	cursor: hand;
}

.input_border {
	height: 14px;
	width: 45px;
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

.tab-hd {
	background-color: #CCCCCC;
	border-right: 1px solid #999999;
	height: 30px;
	line-height: 30px;
	overflow: hidden;
	font-size: 14px;
}

.tab-hd-con {
	height: 29px;
	width: 119px;
	text-align: center;
	float: left;
	cursor: hand;
}

.tab_hd_border {
	border-left: 1px solid #999999;
}

.tab_current_con {
	background-color: #FFFFFF;
}

.toolBoxCss {
	width: 374px;
	min-height: 120px;
	height: auto;
	background: #FFFFFF;
	line-height: 20px;
}

.border {
	border-bottom: 1px solid #333333;
	border-top: 1px solid #333333;
	border-right: 1px solid #333333;
	border-left: 1px solid #333333;
	border-collapse: collapse;
    border-spacing: 0;
    table-layout:auto; 
}

.td_1{
	text-align:right;
	vertical-align:middle;
	height:25px;
	width:125px;
}
.td_2{
	text-align:left;
	vertical-align:middle;
	height:25px;
	width:155px;
}
.td_3{
	text-align:left;
	vertical-align:middle;
	height:25px;
	width:80px;
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
	BACKGROUND: url(<c:url value='/resources/img/monitorscreen/img3-5_2.png'/>) no-repeat
}
* HTML .main_head {
	FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="<c:url value='/resources/img/monitorscreen/img3-5_2.png'/>",sizingMethod='crop'); BACKGROUND: none transparent scroll repeat 0% 0%
}
* + HTML .main_head {
	BACKGROUND: url(<c:url value='/resources/img/monitorscreen/img3-5_2.png'/>) no-repeat
}

.Obtn {
	MARGIN-TOP: 104px; WIDTH: 32px; BACKGROUND: url(<c:url value='/resources/img/monitorscreen/img3-5_1.png'/>) no-repeat; FLOAT: left; HEIGHT: 139px; MARGIN-LEFT: 0px;cursor:pointer;
}
* HTML .Obtn {
	FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="<c:url value='/resources/img/monitorscreen/img3-5_1.png'/>",sizingMethod='crop'); WIDTH: 32px; BACKGROUND: none transparent scroll repeat 0% 0%; FLOAT: left; HEIGHT: 139px
}
* + HTML .Obtn {
	MARGIN-TOP: 104px; WIDTH: 32px; BACKGROUND: url(<c:url value='/resources/img/monitorscreen/img3-5_1.png'/>) no-repeat; FLOAT: left; HEIGHT: 139px; MARGIN-LEFT: -5px
}
/* 显示滚动条 */
body { position: relative; }
</style>

</head>

<body style="background-color:#fff;">
	<input type="hidden" name="imgpath" id="imgpath" />
	<jsp:include page="../header.jsp"></jsp:include>
	<OBJECT id=dlgHelper CLASSID="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" WIDTH="0px" HEIGHT="0px"></OBJECT>
 <div id="xixi" onclick="checkShow();" style="z-index: 132323433423423424;">
        
        <div class="Obtn"></div>
    </div>
    <script type="text/javascript">
        showleftMenu = function (id, _top) {
            var me = id.charAt ? document.getElementById(id) : id, d1 = document.body, d2 = document.documentElement;
            d1.style.height = d2.style.height = '100%'; me.style.top = _top ? _top + 'px' : 0; 
            me.style.position = 'absolute';
            setInterval(function () { me.style.top = parseInt(me.style.top) + (Math.max(d1.scrollTop, d2.scrollTop) + _top - parseInt(me.style.top)) * 0.1 + 'px'; }, 10 + parseInt(Math.random() * 20));
            return arguments.callee;
        };
        window.onload = function () {

            // 设置导航最小宽度
            $(".head.tab.mb48").parent().css("overflow","auto").end().css("min-width","1200px");

        	 var sheit = (document.documentElement.clientHeight-96)/2-96;
            showleftMenu('xixi', sheit);
            $("#toolBox").hide();
        }
        function checkShow() {
        	 $("#toolBox").show();
        	 $("#xixi").hide();
        }
       
    </script>
	<div id="toolBox" class="toolBoxCss" style="z-index:100;position:absolute;left:0px;top:96px;">
		<div id="toolTitle" style="height:25px">
			<table width="100%">
				<tr>
					<td width="6px"
						background="<c:url value='/resources/img/modeless/dialog_lt.png'/>">&nbsp;</td>
					<td height="26px"
						background="<c:url value='/resources/img/modeless/dialog_ct.png'/>">
						<strong
						style="margin-left:10px; color:#FFFFFF; font-size:13px; line-height:center">监测配置工具</strong>
						<input type="button" class="box_btn" id="menu_btn"
						style="float:right">
					</td>
					<td width="6px"
						background="<c:url value='/resources/img/modeless/dialog_rt.png'/>">&nbsp;</td>
				</tr>
			</table>
		</div>
		<div>
			<jsp:include page="ManageToolContent.jsp"></jsp:include>
		</div>
	</div>
	<div id="monitor_page"
		style="position: absolute;background-repeat: no-repeat; height: 1000px; z-index:-100; background-color:#FFF;display:block;"></div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$("#toolBox").hide();
	$(".all_manage").css("display","none");
	monitorTab("page");
	initSelectProject();
	$(".equ_manage_btn").attr("disabled","disabled");
	$(".label_manage_btn").attr("disabled","disabled");
	$(".page_init").attr("disabled","disabled");
	$(".equ_init").attr("disabled","disabled");
	$(".label_init").attr("disabled","disabled");

	//showToolBox();
	
	var width=getWidth();
	var height=getHeight();
    // for monitor header width
    $('.head').css('min-width',1600+width+'px')

	$("#monitor_page").css("left",width+"px");
	$("#monitor_page").css("top",height+"px");
	$("#monitor_page").css("z-index","0");
	
	$("#monitor_page").css("z-index", -100);
	$("#toolBox").easydrag();//给指定的标签绑定拖动效果，也可以是Class
	$("#toolBox").setHandler('toolTitle');//指定触发拖动的元素，toolTitle是该元素的id

	$("#toolBox").bind("click",function(){
		var left=$("#toolBox").css("left");
		var top=$("#toolBox").css("top");
		var width=$("#toolBox").css("width");
		var height=$("#toolBox").css("height");
		winHeight = document.documentElement.clientHeight;
		winWidth = document.documentElement.clientWidth;
		//alert(left+":"+top+"----"+width+":"+height);
		if(split_Px(left)+split_Px(width)>winWidth){
			$("#toolBox").css("left",winWidth-split_Px(width));
		}
		/*alert(split_Px(top)+"+"+split_Px(height)+">"+winHeight);
		if(split_Px(top)+split_Px(height)>winHeight){
			alert(split_Px(top));
			if(split_Px(top)>=100){
				$("#toolBox").css("top",winHeight-split_Px(height));
			}
		}*/
		if(split_Px(left)<0){
			$("#toolBox").css("left","0px");
		}
		if(split_Px(top)<100){
			$("#toolBox").css("top","96px");
		}
		
	});
});


</script>
<jsp:include page="ManageTool.jsp"></jsp:include>
<jsp:include page="ManagePage.jsp"></jsp:include>
<jsp:include page="ManageGraph.jsp"></jsp:include>
<jsp:include page="ManageLabel.jsp"></jsp:include>
</html>
