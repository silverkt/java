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
function exchangeToolBox(){
	//jAlert();
	if($("#toolBox").css("display")=='block')
		$("#toolBox").css("display","none");
	else
		$("#toolBox").css("display","block");
}

$("#menu_btn").click(function(){
	  $("#toolBox").hide();
	  $("#xixi").show();
});           
function showToolBox(){
	var ab = new AlertBox("toolBox"), box = ab.box, x, y, flag = "page";
	ab.show();
}

jQuery(function(){
	
})

/*
	工具函数
	获取系windows系统颜色选择器
*/
var isIE = (document.all && window.ActiveXObject) ? true : false;
function pickColor(id){
 if (!window.isIE) return;
 var sColor = document.getElementById('dlgHelper').ChooseColorDlg();
 var color = sColor.toString(16);
 while (color.length<6) color="0"+color;
 window.color = color;
 color = "#"+color;
 //document.getElementById(id).style.backgroundColor = color;
 document.getElementById(id).value = color;
}
/*
	工具函数
	以"px"分割字符串,返回像素值
*/
function split_Px(str){
	var num=str.split("px")[0];
	return num*1;
}
/*
	工具函数
	获取图片长宽
*/
var imgReady = (function () {
	var list = [], intervalId = null,
	// 用来执行队列
	tick = function () {
		var i = 0;
		for (; i < list.length; i++) {
			list[i].end ? list.splice(i--, 1) : list[i]();
		};
		!list.length && stop();
	},

	// 停止所有定时器队列
	stop = function () {
		clearInterval(intervalId);
		intervalId = null;
	};

	return function (url, ready, load, error) {
		var onready, width, height, newWidth, newHeight,
			img = new Image();
		
		img.src = url;

		// 如果图片被缓存，则直接返回缓存数据
		if (img.complete) {
			ready.call(img);
			load && load.call(img);
			return;
		};
		
		width = img.width;
		height = img.height;
		
		// 加载错误后的事件
		img.onerror = function () {
			error && error.call(img);
			onready.end = true;
			img = img.onload = img.onerror = null;
		};
		
		// 图片尺寸就绪
		onready = function () {
			newWidth = img.width;
			newHeight = img.height;
			if (newWidth !== width || newHeight !== height ||
				// 如果图片已经在其他地方加载可使用面积检测
				newWidth * newHeight > 1024
			) {
				ready.call(img);
				onready.end = true;
			};
		};
		onready();
		
		/*由于图片是本地加载，onload与onready时间顺序冲突，导致两次返回，故注释掉，by man 2013-10-10
		// 完全加载完毕的事件
		img.onload = function () {
			// onload在定时器时间差范围内可能比onready快
			// 这里进行检查并保证onready优先执行
			!onready.end && onready();
		
			load && load.call(img);
			
			// IE gif动画会循环执行onload，置空onload即可
			img = img.onload = img.onerror = null;
		};*/

		// 加入队列中定期执行
		if (!onready.end) {
			list.push(onready);
			// 无论何时只允许出现一个定时器，减少浏览器性能损耗
			if (intervalId === null) intervalId = setInterval(tick, 40);
		};
	};
})();

/*
	工具函数
	校验是否全由整数组成
*/
function isInteger(s) {
    var reg = /^-?\d+$/;
    if (reg.test(s)) return true
    return false
}
/*
	工具函数
	校验是否全由正整数组成
*/
function isPositiveInteger(s) {
    var reg = /^\d+$/;
    if (reg.test(s)) return true
    return false
}
/*
	工具函数
	trim封装
*/
String.prototype.trim=function(){  
   return this.replace(/(^\s*)|(\s*$)/g, "");  
}
/*
	左侧切换
*/
function monitorTab(id){
  $(".tab-hd-con").removeClass('tab_current_con');
  $("#tab_"+id).addClass('tab_current_con');
  $(".all_manage").css("display","none");
  $("#"+id).css("display","block");
}
/*
 * 获取页面位移宽度
 */
function getHeight(){
	var height=0;
	winHeight = document.documentElement.clientHeight;
	if((winHeight*1-96-1000)>0){
	   height=(winHeight*1-1000-96)/2+96;
	}else{
	   height=96;
	}
	return height;
}
/*
 * 获取页面位移高度
 */
function getWidth(){
	var width=0;
	winWidth = document.documentElement.clientWidth;
	if((winWidth*1-1600)>0){
	   width=(winWidth*1-1600)/2;
	} 
	return width;
}
</script>
