

//autoHeight('.arrangement ul li', '.div-head', '.xtnxjcChart');
//6分图
$(document).ready(function(){
    chartAuto();
    $(window).resize(function(){
        chartAuto();
        }
    );//2014-12-18 liuhanshen
});

function chartAuto() {
    var sreenH = $(window).height()-128
      , incont = $(".xmgl_list1 td .xmgl_list1_cont .xmgl_incont")
      , incontH = sreenH / 2 - 35
      //, xtzbW = Math.floor(incont.width()/3) - 3//3为最小间距
      , xtzbH = incontH 
	  //alert(incont.width())
    incont.css("height", incontH);
    incont.css("min-height",225+"px");
    $('.quota').height(xtzbH - 20);//表盘高度
	$(".quota").css("min-height",191+"px");//表盘最小高度
	$('#container').find('.xmgl_list1_cont').css(
		{"height":"auto"
		 ,"min-height":225
		 ,"overflow":"hidden"});//container高度最小高度溢出隐藏
	$('#myxmgl_incont').css("margin","0 auto");//去除系统指标margin-top
	$(".xmgl_incont").css("background","white");//每个表背景白色，否则会有前景白色背景渐变效果
 }
