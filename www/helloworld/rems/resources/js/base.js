
$(function () { 
    sizeSet();
    $(window).resize(
        function() {
            sizeSet();
        }
    );
    $("#folderBtn").click(function () {
        var btn = $(this);
        if (btn.hasClass("icoLeft")) {
            $("#container").addClass("containerHideLeft");
            btn[0].className = "icoRight";
            $.cookies.set("showLeft", "false");
        }
        else {
            $("#container").removeClass("containerHideLeft");
            btn[0].className = "icoLeft";
            $.cookies.set("showLeft", "true");
        }
      
    });
  

    if ($.cookies.get("showLeft") == "false") {
        var ico = document.getElementById("folderBtn");
        ico.className = "icoRight";
    }


});
function sizeSet(){
        var screenW=document.documentElement.clientWidth;
        var screenH=$(window).height();
        var datalistH=screenH-202;
        var leftH3=screenH-127;
        var indexH=screenH-127;
        var scrH=$(window).height()- 130;
        $("#folderBtn").css("top",scrH/2);
        
        if(screenW<1200){
            $("html").css("overflow-x","visible");
            $(".head").css("width",1200);
            $(".index-slide-txt").css("width",1200);
            // 系统页面出滚动条
            $("#container").css("width",1200);
            $("#container").css("min-width",1200);
            $(".nav-nav").css("width",1200);
            $(".nav-nav").css("min-width",1200);
            $(".scrollH").css("height",scrH-206);
        }else{
            $("html").css("overflow-x","visible");
            $(".head").css("width",screenW);
            $(".index-slide-txt").css("width",screenW);
            // 系统页面出滚动条
            $("#container").css("width",screenW);
            $("#container").css("min-width",screenW);
            $(".nav-nav").css("width",screenW);
            $(".nav-nav").css("min-width",screenW);
            $(".scrollH").css("height",scrH-206);
        }
		$(".LeftCol").css({
			"overflow-y":"auto"
			,"overflow-x":"hidden"
		});
        $(".LeftCol-index").css("height",screenH-62);
        $(".LeftCol-index").css("min-height",screenH-77);
        $(".LeftCol2").css("height",screenH-80);
        $(".LeftCol2").css("min-height",screenH-80);
		$(".LeftCol-fafafa").css("height",screenH-97);
        $(".LeftCol-fafafa").css("min-height",screenH-97);
        $(".tablediv-inner").css("height",screenH-214);
        $(".tablediv-inner").css("min-height",screenH-214);
        $(".tablediv-inner-log").css("height",screenH-220);
        $(".tablediv-inner-log").css("min-height",screenH-220);
        $(".tablediv-inner-sssbgl").css("height",screenH-240);
        $(".tablediv-inner-sssbgl").css("min-height",screenH-240);
        $(".yxcsdb-tablebody").css("height",screenH-281);
        $(".yxcsdb-tablebody").css("min-height",screenH-281);
        $(".LeftCol3").css("height",leftH3);
        $(".LeftCol3").css("min-height",leftH3);
        $(".nyglinul-lsxgl").css("height",leftH3-41);
        $(".nyglinul-lsxgl").css("min-height",leftH3-41);
        $(".MainCol-moduleconfig").css("height",leftH3);
        $(".MainCol-moduleconfig").css("min-height",leftH3);
        $(".blockcontainer").css("height",leftH3-69);
        $(".blockcontainer").css("min-height",leftH3-69);
        $("#energyLeftId").css("height",leftH3);
        $("#energyLeftId").css("min-height",leftH3);
        // 新闻配置侧边栏
        $(".ul-xwgl").css("height",screenH-136); 
        $(".ul-xwgl").css("min-height",screenH-136);
            // 系统页面出滚动条
        $("#container").css("height",screenH-142);
        $("#container").css("min-height",screenH-142);
        $(".wrap").css("height",screenH-156);
        $(".wrap").css("min-height",screenH-156);
        $(".wrap-index").css("height",screenH-112);
        $(".wrap-index").css("min-height",screenH-112);
        $(".wrap-craft").css("height",leftH3);
        $(".wrap-craft").css("min-height",leftH3);
        $(".wrap-sys").css("height",screenH-126);
        $(".wrap-sys").css("min-height",screenH-126);
        $(".wrap-rank").css("height",datalistH+44);
        $(".wrap-rank").css("min-height",datalistH+44);
        $(".wrap-energy").css("height",screenH-192);
        $(".wrap-energy").css("min-height",screenH-192);
        $(".datalist-content").css("height",datalistH);
        $(".datalist-content").css("min-height",datalistH);
        $(".datalist-content-contrast").css("height",datalistH+47);
        $(".datalist-content-contrast").css("min-height",datalistH+47);
        $(".datalist-inner-cost").css("height",datalistH-17);
        $(".datalist-inner-cost").css("min-height",datalistH-17);
        $(".datalist-content-news").css("height",datalistH+27);
        $(".datalist-content-news").css("min-height",datalistH+27);
        $(".datalist-content-lsxgl").css("height",datalistH+47);
        $(".datalist-content-lsxgl").css("min-height",datalistH+47);
        $(".datalist-content-xmxxgl").css("height",datalistH+25);
        $(".datalist-content-xmxxgl").css("min-height",datalistH+25);
        $(".datalist-content-sbsxjc").css("height",screenH-170);
        $(".datalist-content-sbsxjc").css("min-height",screenH-170);
        $(".datalist-content-rank").css("height",datalistH+45);
        $(".datalist-content-rank").css("min-height",datalistH+45);
        $(".datalist-content-history").css("height",datalistH-31);
        $(".datalist-content-history").css("min-height",datalistH-31);
        $(".csdb_datalist").css("height",datalistH+60);
        $(".csdb_datalist").css("min-height",datalistH+60);
        $(".datalist-content-energy").css("height",datalistH-32);
        $(".datalist-content-energy").css("min-height",datalistH-32);
        $(".AllCol-index").css("height",screenH-77);
        $(".AllCol-index").css("min-height",screenH-77);
        $("#instance").css("height",scrH-59);
        $(".classManagement-datalist").css("height",scrH-59);
}
