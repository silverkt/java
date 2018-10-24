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
<!-- 设计负荷 -->
<script type="text/javascript">
$(document).ready(function () {
	 elv = $("#elv").val();
	 flag = true;
	 if(elv == 'E'){
		var pro = $("#szqSelectId p").text();
		var city = $("#xzqSelectIdc p").text();
		 if(pro == city){
			 $("#xzqSelectIdc").hide();
		 }
	 }
	 /** 百度地图API功能 
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
		});**/
	    $("#allmap").css("display", "none");
	 //选择项目类别
/* 	  $('#xmlbListId').simSelect({
        	callback: function (x,v) {
					  if(v){
					    $("#industryclass_err").hide();
					  }
					if(!x) return;
					$(this).find("input").val(v);
					//加载ajax请求参数内容
					$.ajax({ 
					type:"POST",
					data: {id:v},
					url: "<c:url value='/projectmanagement/xmlbSelect' />?new ="+new Date().getTime(),
					success: function(data){
						var $cs = $('#xhListId');
						$('ul',$cs).empty().append(data);//参数
						$('.text',$cs).text('选择参数...');
						$cs.simSelect({
							callback: function (x,v) {
							if(v){
							    $("#industrytype_err").hide();
							  }
								if(!x) return;
								$(this).find("input").val(v);
							}
						});
			      	}});
				}
    	}); 
	 	$('#xhListId').simSelect({
							callback: function (x,v) {
							if(v){
							    $("#industrytype_err").hide();
							  }
								if(!x) return;
								$(this).find("input").val(v);
							}
						});
	 
	 //选择商业模式
	  $('#symsSelectId').simSelect({
        	callback: function (x,v) {
		  			if(v){
					    $("#businesstype_err").hide();
					  }
					if(!x) return;
					$(this).find("input").val(v);
				}
    	});
	 //选择项目组
	  $('#xmzSelectId').simSelect({
        	callback: function (x,v) {
		  			if(v){
					    $("#groupid_err").hide();
					  }
					if(!x) return;
					$(this).find("input").val(v);
					//加载ajax请求参数内容
					$.ajax({ 
					type:"POST",
					data: {id:v},
					url: "<c:url value='/projectmanagement/jjqSelect' />?new ="+new Date().getTime(),
					success: function(data){
						var $cs = $('#jjqSelectId');
						$('ul',$cs).empty().append(data);//参数
						$('.text',$cs).text('选择参数...');
						$cs.simSelect({
							callback: function (x,v) {
							if(v){
							    $("#regionid_err").hide();
							  }
								if(!x) return;
								$(this).find("input").val(v);
								$.ajax({ 
								type:"POST",
								data: {id:v},
								url: "<c:url value='/projectmanagement/yqSelect' />?new ="+new Date().getTime(),
								success: function(data){
									var $cs = $('#yqSelectId');
									$('ul',$cs).empty().append(data);//参数
									$('.text',$cs).text('选择参数...');
									$cs.simSelect({
										callback: function (x,v) {
										if(v){
										    $("#parkid_err").hide();
										  }
											if(!x) return;
											$(this).find("input").val(v);
										}
									});
						      	}});
							}
						});
			      	}});
				}
    	});
	 
	 $('#jjqSelectId').simSelect({
							callback: function (x,v) {
							if(v){
							    $("#regionid_err").hide();
							  }
								if(!x) return;
								$(this).find("input").val(v);
								$.ajax({ 
								type:"POST",
								data: {id:v},
								url: "<c:url value='/projectmanagement/yqSelect' />?new ="+new Date().getTime(),
								success: function(data){
									var $cs = $('#yqSelectId');
									$('ul',$cs).empty().append(data);//参数
									$('.text',$cs).text('选择参数...');
									$cs.simSelect({
										callback: function (x,v) {
										if(v){
										    $("#parkid_err").hide();
										  }
											if(!x) return;
											$(this).find("input").val(v);
										}
									});
						      	}});
							}
						});
	 //行政区
	 $('#szqSelectId').simSelect({
		
        	callback: function (x,v) {
		 			if(v){
				      $("#districtid_err").hide();
				    }
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
		 if(x !='北京' && x!='上海' && x !='天津' && x !='重庆'){
			 $("#xzqSelectIdc").show();
		 }
						$.ajax({ 
						type:"POST",
						data: {id:c[0]},
						url: "<c:url value='/projectmanagement/citySelect' />?new ="+new Date().getTime(),
						success: function(data){
							var $cs = $('#xzqSelectIdc');
							$('ul',$cs).empty().append(data);//参数
							$('.text',$cs).text('选择参数...');
							$cs.simSelect({
								callback: function (x,v) {
								if(v){
							      $("#districtid_err").hide();
							    }
									if(!x) return;
									$(this).find("input").val(v);
								}
							});
				      	}});
					}else{
						jAlert("请选择行政区!");
					}
				}
    	});
	 //地图展示
	 $("#mapid").click(function(){
		     $("#allmap").css("display", "block");
		     $("#xmgl_tbljxcx1").css("display", "none");
	 });
	 $('#xmgl_tbljxcx1').find('.project_state').find("input[type='radio']").each(function(){
	 	var $radio = $(this);
	 	var v = $radio.val();
	 	var proState = $('#state').val();
	 	if(proState==null||proState==''){
	 		proState = '0';
	 	}
	 	if(v==proState){
	 		$radio.attr("checked","checked");
	 	}else{
	 		$radio.removeAttr("checked");
	 	}
	 });
	  $('#xmgl_tbljxcx1').find('.project_state > input').click(function(){
	 	var $ptd = $(this).parent('td');
	 	$ptd.find("#state").val($(this).val());
	 });
	  
  if(elv=='V'){
	$("#pop-onupdate").simReadOnly();
  }else{
	  $("#projectSubmit").focus();
	  //$("#projectBasdInfoFormId").find("input").focus();
	  //$("#projectDesignloadForm").find("input").focus();
  }
	  
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
 });*/
	 
 	closeFancybox();//关闭fancybox
	$("#projectDesignloadForm").find("input").each(function(){
	 var v = $(this);
	 var name = v.attr("name");
	 if(name == "configureid_lfh_v" || name == "configureid_zqfh_v" || name == "configureid_dfh_v" || name == "configureid_rfh_v" || name == "configureid_rsfh_v"){
			 v.blur(function(){
				 var value = v.val();
				 if(parseInt(value)!=value){
					 v.parent().parent().next().children('td').eq(v.parent().index()).children('div').css("display","inline");
					 flag = false;
					 
				 }else{
					 v.parent().parent().next().children('td').eq(v.parent().index()).children('div').css("display","none");
					 flag=true;
				 }
			 });
		 }
	 });
	  
 });
/*   function showtabs(mark, _this) {
            $(".xmlgl_left_shows").css("display", "none");
            $(".xmgl_set li").removeClass("xmgl_sel");
            if (mark == "1") {
                $(".xmgl_set li:eq(2)").children("img").attr("src", "../resources/img/xmgl_edt2.png");
                $(".xmgl_set li:eq(1)").children("img").attr("src", "../resources/img/xmgl_del2.png");
                $(_this).children("img").attr("src", "../resources/img/xmgl_add1.png");
                $(_this).addClass("xmgl_sel");
                $(".xmlgl_left_shows:eq(0)").css("display", "block");
                $("#markIddu").val("1");
            }
            else if (mark == "2") {
                $(".xmgl_set li:eq(0)").children("img").attr("src", "../resources/img/xmgl_add2.png");
                $(".xmgl_set li:eq(2)").children("img").attr("src", "../resources/img/xmgl_edt2.png");
                $(_this).children("img").attr("src", "../resources/img/xmgl_del1.png");
                $(_this).addClass("xmgl_sel");
                $(".xmlgl_left_shows:eq(1)").css("display", "block");
                 $("#markIddu").val("2");
            }
            else {
                $(".xmgl_set li:eq(0)").children("img").attr("src", "../resources/img/xmgl_add2.png");
                $(".xmgl_set li:eq(1)").children("img").attr("src", "../resources/img/xmgl_del2.png");
                $(_this).children("img").attr("src", "../resources/img/xmgl_edt1.png");
                $(_this).addClass("xmgl_sel");
                $(".xmlgl_left_shows:eq(2)").css("display", "block");
                 $("#markIddu").val("3");
            }
        } */
/*         function showinfo(mark, _this) {
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
        } */
/*         function checkProject(){
        	var projectnameId = $("#projectnameId").val();
        	var projectid = $("#projectid").val();
        	var parkid = $("#clickparkId").val();
        		$.ajax({
        		url: "<c:url value='/projectmanagement/checkProjectName' />?new ="+new Date().getTime(),
				type:"POST",
				data:{projectnameId:projectnameId,projectid:projectid,parkid:parkid},
        		success:function(data){
					if(data){
        				//可以使用的项目名
        				$("#projectSubmit").on("click",saveInfo);
        				$("#projectName_err").css("display","none");
        				return true;
        			}else{
        				//重复项目名
        				$("#projectSubmit").off("click",saveInfo);
        				$("#projectName_err").show();
        				return false;
        			}
						
        		}
        	});	   		
   }  */
        //验证表单
/*         function validateBaseInfoForm(){
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
						required:"请填写项目名称!",
						//remote:"项目名已存在"

					}
					//,proabbreviation:{required:"项目简称必填"}
				}
	        }).form();
        } */
        
        /**
         * 保存项目负荷信息
         */
        function saveProjectDesignload() {
        	if(flag==true){
            	$.ajax({ 
    				type:"POST",
    				data: $("#projectDesignloadForm").serialize(),
    				url: "<c:url value='/projectmanagement/saveDesignload' />?new ="+new Date().getTime(),
    				success: function(data){
    					jAlert("编辑成功！");
    					$.fancybox.close();	
    		      	},error:function(data){
    					jAlert("编辑失败！");
    		      	}
    		    });
        	}else{
        		return;
        	}
        }
   

    
</script>
<style>
	h2{width:200px;float:left;}
	tr.errors-tr td{height: auto !important;}
</style>
<!DOCTYPE html>
<div class="hd">
	<h2>设计负荷</h2>
	<input type="hidden" value="${clickpark}" id="clickparkId"/>
</div>
<div id="allmap"></div>
<div class="bd bd2">

<script type="text/javascript">
	function checkLen(obj) {
		var maxChars = 200;//最多字符数
		if (obj.value.length > maxChars)
			obj.value = obj.value.substring(0, maxChars);
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
<form action="" name="projectDesignloadForm" id="projectDesignloadForm" method="post">
<input type="hidden" name="projectid_fh" id="projectid_fh" value="${pbinfo.projectid}"/>
<input type="hidden" name="configureid_lfh" value="31"/>
<input type="hidden" name="configureid_rfh" value="32"/>
<input type="hidden" name="configureid_dfh" value="33"/>
<input type="hidden" name="configureid_zqfh" value="34"/>
<input type="hidden" name="configureid_rsfh" value="35"/>
<input type="hidden" name="unitid" value="8"/>
<input name="operate" type="hidden" id="operate" value="${operate}"/>
<table class="xmgl_tbladd sjfhtbl" id="xmgl_tbljxcx3">
	<tbody>
		<tr>
			<td class="sjfh_name">冷负荷：</td>
			<td>
				<input name="configureid_lfh_v" value="${configureid_lfh_v}" type="text" class="xmgl_sjfh">kW
			</td>
			<td class="sjfh_name">蒸汽负荷：</td>
			<td class="w190">
				<input name="configureid_zqfh_v" value="${configureid_zqfh_v}" type="text" class="xmgl_sjfh">kW
			</td>	
			<td class="sjfh_name">电负荷：</td>
			<td class="w190">
				<input name="configureid_dfh_v" value="${configureid_dfh_v}" type="text" class="xmgl_sjfh">kW
			</td>	
		</tr>
		<tr>
			<td></td>
			<td><div class="inputerror">必须为整数类型</div></td>
			<td></td>
			<td><div class="inputerror">必须为整数类型</div></td>
			<td></td>
			<td><div class="inputerror">必须为整数类型</div></td>
		</tr>
		<tr>
			<td class="sjfh_name">热负荷：</td>
			<td class="w190">
				<input name="configureid_rfh_v" value="${configureid_rfh_v}" type="text" class="xmgl_sjfh">kW
			</td>	
			<td class="sjfh_name">热水负荷：</td>
			<td class="w190">
				<input name="configureid_rsfh_v" value="${configureid_rsfh_v}" type="text" class="xmgl_sjfh">kW
			</td>
			<td class="sjfh_name"></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td><div class="inputerror">必须为整数类型</div></td>
			<td></td>
			<td><div class="inputerror">必须为整数类型</div></td>
			<td></td>
			<td></td>
		</tr>
	</tbody>
</table>
</form>
</div>
<!--设计负荷-->
<div class="clear mr20">
<a class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;" >取消</a>
<a class="tck-save fr mt15" onclick="saveProjectDesignload();">保存</a>
</div>