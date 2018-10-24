<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>远程能源管理系统</title>
<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
<link
	href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/global.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/common.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/context.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/leftwidth.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/nygl.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/pagination.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/sbssgl.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/jquery.alerts.css' />"
	rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
<script src="<c:url value='/resources/js/common.js' />"></script>
<script src="<c:url value='/resources/js/my.js' />"></script>
<script
	src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
<script src="<c:url value='/resources/js/base.js' />"></script>
<script
	src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
<script
	src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
<script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
<script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>
<script src="<c:url value='/resources/js/ajaxfileupload.js' />"></script>
<link href="<c:url value='/resources/css/jquery.alerts.css' />"
	rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>

<script type="text/javascript">
        $(document).ready(function () {
        	var scrH=$(window).height()- 130;
        	$("#tableDiv").css("height",scrH-100);
        	
        	var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}}
        	,pid,clazz = "",keyword = "",isFirst = true;
	    	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />?new="+new Date().getTime(),success:function(data){
					$.fn.zTree.init($("#treeDemo"), setting, data);
					$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
			}});
        	function onClick(event,treeID,treeNode,clickFlag) {
        		if(treeNode.getParentNode()==null) {
        			$("#tableDiv").empty();
        			$("#Pagination").empty();
        			var $fin = $("#classType1");
        			$fin.find("ul").empty().end().find('.list').hide();
        			$fin.find("p").text("设备种类");
        			$fin.off('click');
        			
				    $("#curCity").empty().append("<span>"+treeNode.name+"</span>")
				    $(".area_popup").hide();
				    
				    $("#curCity").removeClass("on");
				    var $ul = $("#nyglinul").empty(),lis = "";
				    if(treeNode.children.length == 0) {
					    lis = getLi(treeNode.id,treeNode.name,true);
					    pid = treeNode.id;
					     $(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
					    initClass();
					    getInstance(0);
				    }else{
					    $.each(treeNode.children,function(i){
						    $.each($(this)[0].children,function(k){
							    //lis += getLi($(this)[0].id,$(this)[0].name,i==0&&k==0?true:false);
							    lis += getLi($(this)[0].id,$(this)[0].name,false);
						    })
					    });
					    
				    }
					
				    $ul.append(lis);
					pid = $("#nyglinul .nyglinulsel").attr("val");
					isFirst = true;keyword = "";clazz = "";
					//initClass();
		            //getInstance(0);
		            
				    $("#nyglinul li").bind("click", function () {
	                    $("#nyglinul li").removeClass("nyglinulsel");
	                    $(this).addClass("nyglinulsel");
	                    $(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
	                    pid = $(this).attr("val");isFirst = true;keyword = "";clazz = "";
	                    
	                    initClass();
	                    getInstance(0);
	                });
        			
        		}
        		if(treeNode.level=='0'){ 
					$(".tleft .xmgl_srear").removeClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_nadd.png' />)").attr('href',"#pop-onupdate");
					$(".tleft .xmgl_srear").unbind('click');
					return false;
				}
				var parentNode = treeNode.getParentNode(),rootNode = parentNode.getParentNode();
				$("#curCity").empty().append((rootNode  == null ? '<span>' : '<span>'+rootNode.name+'</span>-<span>')+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
				$(".area_popup").hide();
				$("#curCity").removeClass("on");
				var $ul = $("#nyglinul").empty(),lis = "";
				if(treeNode.children.length == 0) {
					lis = getLi(treeNode.id,treeNode.name,true);
					pid = treeNode.id;
					 $(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
					initClass();
					getInstance(0);
				}else{
					$.each(treeNode.children,function(i){
						
						lis += getLi($(this)[0].id,$(this)[0].name,i==0 ? true:false);
					});
					$(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
				}
					
				$ul.append(lis);
				pid = $("#nyglinul .nyglinulsel").attr("val");
				isFirst = true;keyword = "";clazz = "";
				initClass();
	            getInstance(0);
				
				$("#nyglinul li").bind("click", function () {
	                $("#nyglinul li").removeClass("nyglinulsel");
	                $(this).addClass("nyglinulsel");
	                $(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
	                pid = $(this).attr("val");isFirst = true;keyword = "";clazz = "";
	                initClass();
	                getInstance(0);
	            });
			}
        	
        	function initClass(){
        		if(pid == null || pid == "") return;
        		$(".mod-select .list").hide();
        		$.ajax({type:"GET",url:"<c:url value='/instance/class' />?new="+new Date().getTime(),data:{pid:pid},
        			success:function(data){
        			var $fin = $("#classType1"),$ul = $fin.find("ul"),lis = "<li val=''><a href=''>所有类</a></li>";
	        		$.each(data,function(k,v){
	        			lis += "<li val='"+v.classid+"'><a href=''>"+v.classname+"</a></li>"
	        		})
	        		
	        		$fin.find("p").text("设备种类");
	        		$ul.empty().append(lis);
	        		$fin.simSelect({
						callback:function(x,v){
	        			clazz = v;
	        			isFirst = true;
	        			getInstance(0);
	        			if(typeof(x)=='undefined'&&typeof(v)=='undefined'){
	        				$fin.find("p").text("设备种类");
	        			}
	        				/*if(v=="") clazz=v;
							else if(v) {
								clazz = v;
								isFirst = true;
        						getInstance(0);
							}*/
						}
					});
				}});
        	}
        	function getLi(id,name,flag){
        		var s = flag ? "nyglinulsel" :"";
        		return '<li class="'+s+'" val="'+id+'"><img src="<c:url value='/resources/img/iconleft.png'/>" />'+name+'</li>';
        	}
        	
        	//搜索
        	$("#search").click(function(){
        		keyword = encodeURI($("#keyword").val());
        		isFirst = true;
        		getInstance(0);
        	})
        	
        	function getInstance(page){
        		if(pid == null || pid == "") return;
        		$.ajax({type:"GET",url:"<c:url value='/instance/right' />?new="+new Date().getTime(),
        			data:{pid:pid,page:page,clazz:clazz,keyword:encodeURI($("#keyword").val())},
        			success:function(data){
        				$("#tableDiv").empty().html(data);
        				if(isFirst) {
        					var count = $("#tableDiv #count").val();
        					if(count>1) initPagination(count);
        					else $("#Pagination").empty();
        				}
        				edit();
					}
        		});
        	}
        	function initPagination(pagers) {
				$("#Pagination").pagination(pagers, {
					num_edge_entries: 1,
					num_display_entries: 4,
					callback: pageselectCallback,
					items_per_page: 1,
					prev_text: "上一页",
					next_text: "下一页"
				});
			 }
        	
        	function pageselectCallback(page_index, jq){
        		if(isFirst) {isFirst = false;return;}
				getInstance(page_index);
				return false;
			}
        	
            $(".curSelectedNode span:first-child").css("background", "url(./img/img_23.png)");
            
			function edit(){
				$("#tableDiv .xml_del").unbind("click").click(function(){
					var obj = $(this);
					//判定是否是含有子设备的父设备，如是，不允许删除
					
					//判断是否配置了采集点
					$.ajax({type:"GET",url:"<c:url value='/instance/before'/>?new="+new Date().getTime(),data:{projectid:pid,id:obj.attr("val")},
						success:function(data){
						if(data=='false1'){
							jAlert("能源站级设备包含子设备情况时不允许删除，请先删除全部子设备！");
						}else{
							if(data=='false2'){
								jConfirm("该设备已配置采集点，请谨慎，删除可能导致系统数据出错，确定是否删除？","确定",function(r){
									if(r == true){
										del(obj.attr("val"));
									}
								});
							}
							else{
								jConfirm("确定要删除吗？","确定",function(r){
									if(r == true){
										del(obj.attr("val"));
									}
								});
							}
						  }
						},
					    error : function(){
							jAlert("删除失败！");
						}
					});
					
				});
				$(".fancybox").unbind("click").click(function(){
					$("#pop-onupdate").empty();
					var inid = $(this).attr("val");
					
					$.ajax({type:"GET",url:"<c:url value='/instance/edit'/>?new="+new Date().getTime(),data:{pid:pid,inid:inid},
	        			success:function(data){
	        				$("#pop-onupdate").empty().html(data);
	        				$("#operate").val(inid);
	        				
	        				//确定按钮
	        				$(".clear #savebut").unbind("click").click(function(){
	        					var oldName = $("#oldName").val();
				        		var dataArray = {},flag = false;
				        		
				        		$("#SBname_msg").hide();
				        		$("#SBname").text("");
				        		
				        		$("#SStype_msg").hide();
				        		$("#SStype").text("");
				        		
				        		$("#SSenergy_msg").hide();
				        		$("#SSenergy").text("");
				        		
				        		$("#popform input","#pop-onupdate").each(function(){
				        			var name = $(this).attr("name"),value = $(this).val();
				        			if(name == "classinstancename" && value == ""){
				        				$("#SBname_msg").show();
				        				$("#SBname").text("*设备名称必填");
				        				flag = true;
				        				
				        				return false;
				        			} else if(name == "classid" && value == ""){
				        				$("#SStype_msg").show();
				        				$("#SStype").text("*所属类必选");
				        				flag = true;
				        				
				        				return false;
				        			}else if(name == "fclassinstanceid" && value == ""){
				        				if($('#finistance').find('ul > li').length > 0){$("#SSenergy_msg").show();
				        					$("#SSenergy").text("*所属能源站必选");
				        					flag = true;
				        					return false;
				        				}
				        				
				        			}
				        			dataArray[name] = value;
				        		})
				        		if(flag) return;
				        		dataArray["remarks"] = $("#popform #TextArea1").val();
				        		$.ajaxFileUpload({url: "<c:url value='/instance/save' />?new="+new Date().getTime(),type:"POST",
									fileElementId:'myBlogImage',data: dataArray,dataType:"text",
									success: function(data){
										var id = eval(dataArray["classinstanceid"]);
										//alert(typeof(id));
										//console.log(data+"|"+id);
				        				if(data == "S"){
				        					if(typeof(id)=='number'){
				        						jAlert("编辑成功！");
				        					}else{
				        						jAlert("新增成功！");
				        					}
				        					isFirst = true;
											getInstance(0);
											$.fancybox.close();
				        				}else if(data == "D"){
				        					$("#SBname_msg").show();
				        				    $("#SBname").text("*该设备名称已存在，请重新输入");
				        				    $("#SBName").focus();
				        					//$("#popform input").next("span").text("*该设备名称已存在，请重新输入").css("display","inline");
				        				}else if(data == "E"||data == "F"){
				        					$("#SBname_msg").hide();
				        				    $("#SBname").text("");
				        				    if(typeof(id)=='number'){
				        				    	jAlert("编辑失败！");
				        				    }else{
				        				    	jAlert("新增失败！");
				        				    }
				        				}else if(data=='A'){
				        					  if(typeof(id)=='number'){
					        				    	jAlert("能源站级设备重复，编辑失败！");
					        				    }else{
					        				    	jAlert("能源站级设备重复，新增失败！");
					        				    }
				        				}
							      },
							      error: function (data, status, e)//服务器响应失败处理函数
			                    {
							    	  var id = eval(dataArray["classinstanceid"]);
							    	  if(typeof(id)=='number'){
			        				    	jAlert("编辑失败！");
			        				   }else{
			        				    	jAlert("新增失败！");
			        				   }
			                    }});
							});
						}
	        		});
				});
				
			}
			
			//删除
			function del(id){
				$.ajax({type:"GET",url:"<c:url value='/instance/delete' />?new="+new Date().getTime(),data:{id:id},
					success:function(data){
						if(data){
							jAlert("删除成功！");
							isFirst = true;
							getInstance(0);
						}
						else{
							jAlert("删除失败！");
							return false;
						}
					},
					error: function (data, status, e)//服务器响应失败处理函数
                    {
						jAlert("删除失败！");
                    }
				});
			}
        });
    </script>
</head>
<body>

	<jsp:include page="../header.jsp"></jsp:include>

	<div class="nav-nav clear">
		<div class="sel_nav ml10">
			<a title="" data-target=".area_popup" class="curcity-expand showdiv"
				id="curCity">请选择</a>
		</div>
	</div>
	<div id="container" class="AllCol">
		<div id="LeftCol" class="LeftCol LeftCol3">
			<ul id="nyglinul" class="nyglinul"></ul>
		</div>
		<div id="MainCol" class="MainCol">
			<div id="folderBtn" class="icoLeft"></div>
			<div class="content contentTop">
				<div class="topFilter tab">
					<table class="putform">
						<tr>
							<td class="w60">
								<div id="classType1" class="classType1 mod-select  mt5">
									<p class="text">设备种类</p>
									<span class="arr-group hand"> <i
										class="icon-mod icon-arr"></i>
									</span>
									<div class="list restyle-list">
										<ul></ul>
									</div>
								</div>
							</td>
							<td class="tleft">
								<div class="fl xmgl_sarch restyle-xmgl_sarch">
									<input type="text" class="xmgl_input" id="keyword" /> <a
										class="xmgl_serch" id="search"></a>
								</div> 
								<shiro:hasPermission name="instance:add">
								<a class="fr xmgl_srear"
								style="background: url('<c:url value="/resources/img/xmgl_nadd.png" />');" val="0" href="#pop-onupdate"></a>
								</shiro:hasPermission>
							</td>
						</tr>
					</table>
				</div>
				<div class="wrap">
					<div class="datalist-div datalist-content">
						<div id="tableDiv" class="tablediv-inner-sssbgl tableDiv"></div>
						<div class="page mt10">
							<div id="Pagination" class="pagination"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="area_popup">
		<div class="datalist-div">
			<div class="area-tit">
				<a class="smalllogo"></a>
			</div>
			<ul id="treeDemo" class="ztree"></ul>
		</div>
	</div>
	<div class="mod-pop" id="pop-onupdate"
		style="width: 384px; min-height: 318px;"></div>
</body>
</html>
