﻿/*****首页地图里******/
function changeTab() {
	 var t = $("#selCityCityWd").val();
	    $("#selCityCityWd").focus(function () {
	        $(this).val('');
	    }).blur(function () {
	        if ($(this).val() == "")
	        { $(this).val(t); }
	    });

     $("#selCityProvince").click(function () {
        $(this).addClass("sel-city-btnl-sel").siblings().removeClass("sel-city-btnr-sel");
        $("#selCityPlaceListId").show();
        $("#selProvincePlaceListId").hide();
    });
    
    $("#selCityCity").click(function () {
        $(this).addClass("sel-city-btnr-sel").siblings().removeClass("sel-city-btnl-sel");
		$("#selCityPlaceListId").hide();
		$("#selProvincePlaceListId").show();
    });
}

$(function () {
    changeTab();//首页地图弹出框里切换
    $("#scrollbarc").tinyscrollbar();//首页地图滚动
	//autoInput();//首页搜索框自动结果
})