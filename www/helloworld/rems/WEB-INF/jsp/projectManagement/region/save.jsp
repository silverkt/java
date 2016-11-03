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
<script type="text/javascript">
 $(document).ready(function () {
	var elv = $("#elv").val()
	, flag = true;
	 if(elv == 'E' || elv == 'V'){
		var pro = $("#szqSelectId p").text();
		var city = $("#xzqSelectIdc p").text();
		 if(pro == city){
			 $("#xzqSelectIdc").hide();
		 }
	 }
	 /** 百度地图API功能 **/
	    var map = new BMap.Map("allmap");            // 创建Map实例
	   	map.centerAndZoom(new BMap.Point(105.357267,37.391597),5);                // 初始化地图,设置中心点坐标和地图级别。
	    map.enableScrollWheelZoom();                 //启用滚轮放大缩小
	    map.addEventListener("click",function(e){
	    	if(elv=="V"){
	    		jConfirm("在视图下您不能设置地图!","确定",function(r){
	    			if(r == true){
	    				jAlert('地图不可设置!');
	    				$("#allmap").css("display", "none");
	    				$("#xmgl_tbljxcx1").css("display", "block");
	    			}else{
	    				$("#allmap").css("display", "none");
	    				$("#xmgl_tbljxcx1").css("display", "block");
	    			}
	    		});
	    		
			}else{
		    	$("#latitude").val(e.point.lat);
				$("#longitude").val(e.point.lng);
				$("#allmap").css("display", "none");
	    		$("#xmgl_tbljxcx1").css("display", "block");
			}
		});
	    $("#allmap").css("display", "none");
	 //选择项目类别
	  $('#xmlbListId').simSelect({
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
<%--		 if(x !='北京' && x!='上海' && x !='天津' && x !='重庆'){--%>
<%--			 $("#xzqSelectIdc").show();--%>
<%--		 }--%>
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
	 initProjectState();
	  closeFancybox();//关闭fancybox
  if(elv=='V'){
	$("#pop-onupdate").simReadOnly();
  }else{
	  $("#projectSubmit").focus();
	  $("#projectBasdInfoFormId").find("input").focus();
	  $("#projectDesignloadForm").find("input").focus();
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
 });
	 
	 
	$("#projectDesignloadForm").find("input").each(function(){
	 var v = $(this);
	 var name = v.attr("name");
	 if(name == "configureid_lfh_v" || name == "configureid_zqfh_v" || name == "configureid_dfh_v" || name == "configureid_rfh_v" || name == "configureid_rsfh_v"){
		 v.blur(function(){
			 var value = v.val();
			 if(isNaN(value)){
				 v.parent().parent().next().children('td').eq(v.parent().index()).children('div').css("display","inline");
				 //$("#projectSubmit").off("click",saveProjectDesignload);
				 flag = false;
				 
			 }else{
				 v.next().css("display","none");
				 flag=true;
				// $("#projectSubmit").on("click",saveProjectDesignload);
			 }
		 });
	 }
 });
	  
 });
 function initProjectState(){
	var proState = $('#state').val();
	$('.project_state','#xmgl_tbljxcx1').find("input[type='radio']").each(function(){
		var $radio = $(this)
		, v = $radio.val();
		if(proState==null||proState==''){
	 		proState = 0;
	 	}
	 	if(v==parseInt(proState)){
	 		$radio.prop("checked",true);
	 	}else{
	 		$radio.prop("checked",false);
	 	}
	 });
}
  function showtabs(mark, _this) {
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
        }
        function showinfo(mark, _this) {
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
        }
   		 /**
         * 保存项目信息
         */
        function saveInfo() {
			if(validateBaseInfoForm()){
				if($("#industryclass").val()== ''){
					$("#industryclass_err").show();
					return false;
				}
				if($("#industrytype").val()==''){
					$("#industrytype_err").show();
					return false;
				}
				if($("#businesstype").val()==''){
					$("#businesstype_err").show();
					return false;
				}
				if($("#groupid").val()==''){
					$("#groupid_err").show();
					return false;
				}
				if($("#regionid").val()==''){
					$("#regionid_err").show();
					return false;
				}
				if($("#parkid").val()==''){
					$("#parkid_err").show();
					return false;
				}
				if($("#districtid").val()==''){
					$("#districtid_err").show();
					return false;
				}
				if($("#longitude").val()==''){
					$("#longitude_err").show();
					return false;
				}
				if($("#latitude").val()==''){
					$("#longitude_err").show();
					return false;
				}
				if(isNaN($('#supplyarea').val())){
					$('#supplyarea').parent().find('.inputerror').show();
					return false;
				}
				if(isNaN($('#buildingarea').val())){
					$('#buildingarea').parent().find('.inputerror').show();
					return false;
				}
				if(isNaN($('#investment').val())){
					$('#investment').parent().find('.inputerror').show();
					return false;
				}
				$('.inputerror').hide();
				var projectid = $("#projectid").val();
				var projectname = $("#projectnameId").val();
				var proabbreviation = $("#proabbreviation").val();
				var industryclass = $("#industryclass").val();
				var industrytype = $("#industrytype").val();
				var businesstype = $("#businesstype").val();
				var groupid = $("#groupid").val();
				var regionid = $("#regionid").val();
				var parkid = $("#parkid").val();
				var districtid = $("#districtid").val();
				var longitude = $("#longitude").val();
				var latitude = $("#latitude").val();
				var address = $("#address").val();
				var designcompany = $("#designcompany").val();
				var buildcompany = $("#buildcompany").val();
				var heatingstart = $("#heatingstart").val();
				var heatingend = $("#heatingend").val();
				var remarks = $("#remarks").val();
				var coldingstart = $("#coldingstart").val();
				var coldingend = $("#coldingend").val();
				var buildingarea = $("#buildingareaval").val();
				var investcompany = $("#investcompany").val();
				var investment = $("#investment").val();
				var supplyarea = $("#supplyareaval").val();
				var pictureptah = $("#pictureptah").val();
				var carrieroperator = $("#carrieroperator").val();
				var state = $("#state").val();
				
				var dt = {"projectid":projectid,"projectname":projectname,
					"proabbreviation":proabbreviation,
					"industryclass":industryclass,
					"industrytype":industrytype,
					"businesstype":businesstype,
					"groupid":groupid,
					"regionid":regionid,
					"parkid":parkid,
					"districtid":districtid,
					"longitude":longitude,
					"latitude":latitude,
					"address":address,
					"designcompany":designcompany,
					"buildcompany":buildcompany,
					"heatingstart":heatingstart,
					"heatingend":heatingend,
					"remarks":remarks,
					"coldingstart":coldingstart,
					"coldingend":coldingend,
					"buildingarea":buildingarea,
					"investcompany":investcompany,
					"investment":investment,
					"supplyarea":supplyarea,
					"pictureptah":pictureptah,
					"carrieroperator":carrieroperator,
					"state":state
					}
				$.ajaxFileUpload({ 
					url: "<c:url value='/projectmanagement/projectSave' />?new ="+new Date().getTime(),
					type:"POST",
					fileElementId:'myBlogImage',
					dataType: 'text',
					data: dt,
					success: function(data,state){
						if(data==''){
							jAlert('保存失败！');
						}else{
							$("#projectid").val(data);
							$("#projectid_zdy").val(data);
							$("#projectid_fh").val(data);
						if(elv == 'E'){
							jAlert("编辑成功!");
						}
						else if(elv == 'A'){
							jAlert("新增成功!");
						}
						initTree();
						getValue($("#lastClick").val(),0,elv);
						$.fancybox.close();	
						}
						
			      },error:function(data){
			      	if(elv == 'E'){
							jAlert("编辑失败!");
						}
						else if(elv == 'A'){
							jAlert("新增失败!");
						}
			      }});
			}
        }
        function checkProject(){
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
   } 
        //验证表单
        function validateBaseInfoForm(){
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
        }
        /**
         * 保存自定义信息
         */
        function saveSelfInfo() {
        	if ($("#projectid_zdy").val() == "") {
                jAlert("请保存项目信息。");
                return false;
            }
        	$.ajax({ 
					type:"POST",
					data: $("#projectselfInfoForm").serialize(),
					url: "<c:url value='/projectmanagement/selfInfoSave' />?new ="+new Date().getTime(),
					success: function(data){
						if($("#operate").val()=="edit"){
							jAlert("编辑成功!");
						}
						else{
							jAlert("新增成功!");
						}
						initTree();
						getValue($("#lastClick").val(),0,elv);
						$.fancybox.close();	
			      },error:function(data){
			    	 if(elv=="E"){
							jAlert("编辑失败!");
						}
						else{
							jAlert("新增失败!");
						}
			      }
					});
        }
        /**
         * 保存项目负荷信息
         */
        function saveProjectDesignload() {
        	$.ajax({ 
					type:"POST",
					data: $("#projectDesignloadForm").serialize(),
					url: "<c:url value='/projectmanagement/saveDesignload' />?new ="+new Date().getTime(),
					success: function(data){
						if(elv=="E"){
							jAlert("编辑成功!");
						}
						else{
							jAlert("新增成功!");
						}
						initTree();
						getValue($("#lastClick").val(),0,elv);
						$.fancybox.close();	
			      },error:function(data){
			    	  if(elv=="E"){
							jAlert("编辑失败!");
						}
						else{
							jAlert("新增失败 !");
						}
			      }
			      });
        }
   

    
</script>
<style>
	h2{width:200px;float:left;}
	tr.errors-tr td{height: auto !important;}
</style>
<!DOCTYPE html>
<div class="hd">
	<h2>项目信息</h2>
	<input type="hidden" value="${clickpark}" id="clickparkId"/>
	<p>
		<a class="xmgl_taba xmgl_tabasel" onclick="showinfo(1,this);">基础信息</a>
		<a class="xmgl_taba" onclick="showinfo(2,this);">自定义信息</a>
		<a class="xmgl_taba" onclick="showinfo(3,this);">设计负荷</a>
	</p>
</div>
<div id="allmap"></div>
<div class="bd bd2">

	<form action="<c:url value='/projectmanagement/projectSave' />
	" method="post" name="projectBasdInfoForm" id="projectBasdInfoFormId" enctype="multipart/form-data">
	<input name="projectid" type="hidden" id="projectid" value="${pbinfo.projectid}"/>
	<input name="pictureptah" type="hidden" id="pictureptah" value="${pbinfo.pictureptah}"/>
	<input name="operate" type="hidden" id="operate" value="${operate}"/>
	<table class="xmgl_tbladd" id="xmgl_tbljxcx1" style="display:block;">
		<tbody>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;目&nbsp;名&nbsp;称：
				</td>
				<td>
					<input class="xmgl_addinput" id="projectnameId" remote="<c:url value='/projectmanagement/checkProjectName'/>
					" name="projectname"  value="${pbinfo.projectname}" type="text" onblur="checkProject()">
					<div id="projectName_err" class="inputerror">同一园区下项目名称不能相同</div>
				</td>
				
				<td class="xmgl_lename" >&nbsp;项&nbsp;目&nbsp;图&nbsp;片：
				</td>
				<td class="xmgl_add_rig">
					<input name="file" id="myBlogImage"  type="file" onchange="preview(this)">
					<input class="xmgl_addinput" type="text">
					<img src="../resources/img/iconimg.png"></td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;目&nbsp;类&nbsp;别：
				</td>
				<td>
					<div class="mod-select xmgl_selct " id="xmlbListId">
						<p class="text">${dict.industryclassname}</p>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="industryclass" id="industryclass" value="${dict.industryclassid}"/>
						<div class="list">
							<ul>
								<c:forEach var="h" items="${hylbList}">
									<li val="${h.industryclassid}">
										<a href="">${h.industryclassname}</a>
									</li>
								</c:forEach>
							</ul>
						</div>

					</div>
					<div id="industryclass_err" class="inputerror">请选择项目类别</div>
				</td>
				<td class="xmgl_lename" rowspan="3"></td>
				<td rowspan="3">
					<div id="preview">
					<c:choose>
						<c:when test="${empty pbinfo.pictureptah||pbinfo.pictureptah==''}">
							<img src="<c:url value='/upload/empty.jpg' />" >
						</c:when>
						<c:otherwise>
							<img src="<c:url value='/${pbinfo.pictureptah}' />" >
						</c:otherwise>
					</c:choose>
					</div>
				</td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;所&nbsp;属&nbsp;行&nbsp;业：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="xhListId">
						<p class="text">${dtn.industrytypename}</p>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="industrytype" id="industrytype" value="${dtn.industrytypeid}"/>
						<div class="list">
						<ul>
							<c:forEach items="${projectLst}" var="i">
								<li val ="${i.industryclassid}"><a href>${i.industrytypename}</a></li>
							</c:forEach>
						</ul>
						</div>

					</div>
					<div id="industrytype_err" class="inputerror">请选择所属行业</div>
				</td>

			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;商&nbsp;业&nbsp;模&nbsp;式：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="symsSelectId">
						<p class="text">${dtype.businesstypename}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="businesstype" id="businesstype" value="${dtype.businesstypeid}"/>
						<div class="list">
							<ul>
								<c:forEach var="s" items="${symsList}">
									<li val="${s.businesstypeid}">
										<a href="">${s.businesstypename}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div id="businesstype_err" class="inputerror">请选择商业模式</div>
				</td>

			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;&nbsp;&nbsp;目&nbsp;&nbsp;组：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="xmzSelectId">
						<p class="text" class="ellipsis" title="${pgroup.groupname}">${pgroup.groupname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="groupid" id="groupid" value="${pgroup.groupid}"/>
						<div class="list">
							<ul>
								<c:forEach var="g" items="${groupList}">
									<li val="${g.groupid}">
										<a href="" class="ellipsis" title="${g.groupname}">${g.groupname}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div id="groupid_err" class="inputerror">请填写项目组</div>
				</td>
				<td class="xmgl_lename">&nbsp;供&nbsp;能&nbsp;面&nbsp;积：
				</td>
				<td>
					<input class="xmgl_addinput" name="supplyarea" id="supplyareaval" value="${pbinfo.supplyarea}" type="text">
					<span class="unit">m²</span>
					<div class="inputerror" id="supplyarea">必须为数字类型</div>
				</td>
			</tr>

			<tr>
				<td class="xmgl_lename">&nbsp;经&nbsp;&nbsp;&nbsp;济&nbsp;&nbsp;区：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="jjqSelectId">
						<p class="text ellipsis" title="${rinfo.regionname}">${rinfo.regionname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="regionid" id="regionid" value="${rinfo.regionid}"/>
						<div class="list" >
							<ul>
								<c:forEach items="${regionList}" var="r">
									<li val="${r.regionid}"><a href="" class="ellipsis" title="${r.regionname}">${r.regionname}</a></li>
								</c:forEach>
							</ul>
						</div>

					</div>
					<div id="regionid_err" class="inputerror">请选择经济区</div>
				</td>
				<td class="xmgl_lename">&nbsp;建&nbsp;筑&nbsp;面&nbsp;积：
				</td>
				<td>
					<input class="xmgl_addinput" name="buildingarea" id="buildingareaval"  value="${pbinfo.buildingarea}" type="text">
					<span class="unit">m²</span>
					<div class="inputerror" id="buildingarea">必须为数字类型</div>
				</td>
			</tr>
			<tr>
				<td class="xmgl_lename">园&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="yqSelectId">
						<p class="text" class="ellipsis" title="${pinfo.parkname}">${pinfo.parkname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" name="parkid" id="parkid" value="${pinfo.parkid}"/>
						<div class="list">
							<ul></ul>
						</div>
					</div>
					<div id="parkid_err" class="inputerror">请选择园区</div>
				</td>
				<td class="xmgl_lename">&nbsp;投&nbsp;资&nbsp;单&nbsp;位：
				</td>
				<td>
					<input class="xmgl_addinput" name="investcompany" id="investcompany"  value="${pbinfo.investcompany}" type="text"></td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;行&nbsp;&nbsp;&nbsp;政&nbsp;&nbsp;区：
				</td>
				<td>
					<div class="mod-select  mt5 xmgl_selct" id="szqSelectId" style="width:75px;float:left;">
						<p class="text">${ditfinfo.districtname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<div class="list limit-list">
							<ul>
								<c:forEach var="c" items="${dicList}">
									<li val="${c.districtid},${c.citytype}">
										<a href="">${c.districtname}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="mod-select  mt5 ml5 xmgl_selct xzq-select" id="xzqSelectIdc">
						<p class="text">${dinfo.districtname}</p>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<input type="hidden" id="districtid" name="districtid" value="${dinfo.districtid}"/>
						<div class="list limit-list">
							<ul></ul>
						</div>
					</div>
					<div id="districtid_err" class="inputerror">请选择行政区</div>
				</td>
				<td class="xmgl_lename">&nbsp;投&nbsp;资&nbsp;金&nbsp;额：
				</td>
				<td style="width:230px;">
					<input class="xmgl_addinput" name="investment" id="investment" value="${pbinfo.investment}" type="text">
					<span class="unit">元</span>
					<div class="inputerror" id="investment">必须为数字类型</div>
				</td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;目&nbsp;地&nbsp;址：
				</td>
				<td>
					<input class="xmgl_addinput" name="address" id="address" value="${pbinfo.address}" type="text"></td>
				<td class="xmgl_lename">&nbsp;设&nbsp;计&nbsp;单&nbsp;位：
				</td>
				<td>
					<input class="xmgl_addinput" name="designcompany" id="designcompany" value="${pbinfo.designcompany}" type="text"></td>
			</tr>
			<tr>
				<td class="xmgl_lename">经度&nbsp;/&nbsp;纬度：</td>
				<td>
					<input name="longitude" id="longitude" value="${pbinfo.longitude}" type="text" readonly="readonly">
					<span class="fl ml6 mr6">/</span>
					<input name="latitude" id="latitude" value="${pbinfo.latitude}" type="text" readonly="readonly">
					<img id="mapid" style="float:left; margin-left:3px; margin-top:3px;" src="../resources/img/iconweidu.png">
					<div id="longitude_err" style="display:none;float:left; width:218px;color:red;">请填写经纬度</div>
				</td>
				<td class="xmgl_lename">&nbsp;建&nbsp;设&nbsp;单&nbsp;位：
				</td>
				<td>
					<input name="buildcompany" value="${pbinfo.buildcompany}" id="buildcompany" class="xmgl_addinput" type="text"></td>
			</tr>

			<tr>
				<td class="xmgl_lename">&nbsp;供&nbsp;&nbsp;&nbsp;暖&nbsp;&nbsp;期：
				</td>
				<td>
					<input name="heatingstart" id="heatingstart" value="${pbinfo.heatingstart}" type="text" class="Wdate itxt mydate" onfocus="WdatePicker({dateFmt:'MM/dd'})" autocomplete="off">
					<span class="fl ml5 mr7">/</span>
					<input name="heatingend" id="heatingend" value="${pbinfo.heatingend}" type="text" class="Wdate itxt mydate" onfocus="WdatePicker({dateFmt:'MM/dd'})" autocomplete="off"></td>
				<td class="xmgl_lename">&nbsp;运&nbsp;&nbsp;&nbsp;营&nbsp;&nbsp;商：
				</td>
				<td>
					<input name="carrieroperator" value="${pbinfo.carrieroperator}" id="carrieroperator" class="xmgl_addinput" type="text"></td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;供&nbsp;&nbsp;&nbsp;冷&nbsp;&nbsp;期：
				</td>
				<td>
					<input name="coldingstart" id="coldingstart" value="${pbinfo.coldingstart}" type="text" class="Wdate itxt  mydate"onfocus="WdatePicker({dateFmt:'MM/dd'})" autocomplete="off">
					<span class="fl ml5 mr7">/</span>
					<input name="coldingend" id="coldingend" value="${pbinfo.coldingend}" type="text" class="Wdate itxt mydate" onfocus="WdatePicker({dateFmt:'MM/dd'})" autocomplete="off"></td>
				<td class="xmgl_lename">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：
				</td>
				<td class="textarea-fa">
					<textarea name="remarks" value="${pbinfo.remarks}" id="remarks" cols="20" rows="2">${pbinfo.remarks}</textarea>
				</td>
			</tr>
			<tr>
				<td class="xmgl_lename">&nbsp;项&nbsp;目&nbsp;状&nbsp;态：
				</td>
				<td class="project_state">
					<input type="radio" id="planing" name="projectstate" checked value="0"/>
					<label for="planing">规划</label>
					<input type="radio" id="constraction" name="projectstate" value="1"/>
					<label for="constraction">在建</label>
					<input type="radio" id="build" name="projectstate" value="2"/>
					<label for="build">已建</label>
					<input type="hidden" id="state" value="${pbinfo.state}"/>
				</td>
				<td class="xmgl_lename" rowspan="3"></td>
				<td>
					<!-- <textarea name="remarks" value="${pbinfo.remarks}" id="remarks" style=" display:block; width:229px;resize:none;height:60px;" cols="20" rows="2"></textarea>
				-->
			</td>
		</tr>
	</tbody>
</table>
</form>
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
<!--自定义信息新增按钮&隔行变色-->
<script type="text/javascript">
	$(function () {
		odd_even();
		function odd_even () {
			$("#projectselfInfoForm").find("tr:odd").attr("class","odd");
        	$("#projectselfInfoForm").find("tr:even").attr("class","even");
		}
        $("#zdy-add").click(function() {
        	var trlength = $("#projectselfInfoForm tbody tr").length;
        	var newtr = "<tr>" + 
							"<td>" +
								"<input name='selfdataKey" + (trlength + 1) +"'  class='xmgl_addinput' type='text' value=''>" +
							"</td>" +
							"<td>" +


								"<input name='selfdataValue" + (trlength + 1) + "' class='xmgl_addinput'  type='text' value=''>" +

							"</td>" +
						"</tr>"
			if(trlength < 10){
				$('#projectselfInfoForm table tbody').append(newtr);
			}else{
				jAlert("对不起，已超出限制自定义信息条数！")
			}
			odd_even();
        });
	})
</script>
<form action="" method="post" name="projectselfInfoForm" id="projectselfInfoForm">
<input type="hidden" name="projectid_zdy" id="projectid_zdy" value="${pbinfo.projectid}"/>
<input type="hidden" name="selfinfoid" value="${psfinfo.selfinfoid }"/>
<input name="operate" type="hidden" id="operate" value="${operate}"/>
<table class="xmgl_tbladd zdy w506" id="xmgl_tbljxcx2" style="display:none;">
	<thead>
		<tr>
			<td>标题</td>
			<td>内容</td>
		</tr>
	</thead>
	<tbody>
	<!-- <tr>
			<td>
				<input name="selfdataKey1"  class="xmgl_addinput" type="text" value="${selfdataKey1}">
			</td>
			<td>
				<input name="selfdataValue1" class="xmgl_addinput"  type="text" value=""  placeholder="内容">
			</td>
		</tr>-->
		<c:forEach var="g" items="${list}" varStatus="s" >
				<tr>
					<td>
						<input name="selfdataKey${s.index+1}"  class="xmgl_addinput ellipsis" type="text" title="${g.keys}" value="${g.keys}">
					</td>
					<td>
						<input name="selfdataValue${s.index+1}"  class="xmgl_addinput ellipsis"  type="text" title="${g.values}" value="${g.values}">
					</td>
				</tr>
		   	 </c:forEach>
	</tbody>
	<tfoot>
		<td></td>
		<!--modify by Y 2015-02-04 视图查看的时候不要新增按钮 begine  -->
<%--		<td><a type="button" class="tck-save fr mt5" id="zdy-add">新增</a></td>--%>
		<!--modify by Y 2015-02-04 视图查看的时候不要新增按钮 end  -->
	</tfoot>
</table>
</form>
<form action="" name="projectDesignloadForm" id="projectDesignloadForm" method="post">
<input type="hidden" name="projectid_fh" id="projectid_fh" value="${pbinfo.projectid}"/>
<input type="hidden" name="configureid_lfh" value="31"/>
<input type="hidden" name="configureid_rfh" value="32"/>
<input type="hidden" name="configureid_dfh" value="33"/>
<input type="hidden" name="configureid_zqfh" value="34"/>
<input type="hidden" name="configureid_rsfh" value="35"/>
<input type="hidden" name="unitid" value="8"/>
<input name="operate" type="hidden" id="operate" value="${operate}"/>
<table class="xmgl_tbladd sjfhtbl" id="xmgl_tbljxcx3" style="display:none;">
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
			<td><div class="inputerror">必须为数字类型!</div></td>
			<td></td>
			<td><div class="inputerror">必须为数字类型!</div></td>
			<td></td>
			<td><div class="inputerror">必须为数字类型!</div></td>
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
			<td><div class="inputerror">必须为数字类型!</div></td>
			<td></td>
			<td><div class="inputerror">必须为数字类型!</div></td>
			<td></td>
			<td></td>
		</tr>
	</tbody>
</table>
</form>
</div>
<!--基础信息-->
<div class="clear mr20">
<a title="Close" class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
<a id="projectSubmit" class="tck-save fr mt15">保存</a>
<input type="hidden" id="elv" value="${elv}"></div>
<!--定义信息-->
<div class="clear mr20" style="display:none;">
<a title="Close" class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
<a class="tck-save fr mt15" onclick="saveSelfInfo();">保存</a>
</div>
<!--设计负荷-->
<div class="clear mr20" style="display:none;">
<a class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
<a class="tck-save fr mt15" onclick="saveProjectDesignload();">保存</a>
</div>