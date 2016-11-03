<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- 新闻配置 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/nygl.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/pagination.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <script src="<c:url value='/resources/js/ueditor1_4_2-utf8-jsp/ueditor.config.js' />"></script>
    <script src="<c:url value='/resources/js/ueditor1_4_2-utf8-jsp/ueditor.all.min.js' />"></script>
    <script src="<c:url value='/resources/js/ueditor1_4_2-utf8-jsp/lang/zh-cn/zh-cn.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
    <script type="text/javascript">
    var isFirst = true;
    $(document).ready(function () {
    	var scrH=$(window).height();
    	$("#folderBtn").css("top",(scrH-136)/2);
		$("#tableDiv").css("height",scrH-97-60-52);
        var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},treeObj,pid;
        $.ajax({type:"GET",url:"<c:url value='/analyse/tree' />?new="+new Date().getTime(),cache:false,
        	success:function(data){
				treeObj = $.fn.zTree.init($("#treeDemo"), setting, data);
				$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
				$('#treeDemo').find('a').children('span:odd').addClass('ellipsis').css({'width':119,'display':'inherit'});
				$(".ul-xwgl").css("height",$(window).height()-136);
				$(".ul-xwgl").css("min-height",$(window).height()-136);
			},error:function(){
				jAlert('加载失败!');
			}
        });
        //modify by Y 2015-02-05 初始化绑定 begine
        //高级查询
        $("#searchBtn").click(function(){
		   	if(pid == undefined || pid == '' || $('#isParentClick').val()=='true'){
		   		jAlert("请选择指定泛能站!");
		   		return;
		   	}else{
		   		$("#serachPagePid").val(pid);
		   		$("#serachPage").val(0);
		   		isFirst = true;
		   		var vals = $("#searchForm").serialize();
		   		$.post("<c:url value='/project/news/findByForm'/>?new="+new Date().getTime(),vals,function(data){
					$("#tableDiv").empty().html(data);
					initDelbtn();
					if(isFirst) initPagination($("#tableDiv #count").val());
				});
	    	}
	    });
        //modify by Y 2015-02-05 初始化绑定 end
        $("#nyglinul li").bind("click", function () {
        	$("#nyglinul li").removeClass("nyglinulsel");
        	$(this).addClass("nyglinulsel");
        });
        $(".curSelectedNode span:first-child").css("background", "url(./img/img_23.png)");
        
        
        function onClick(event,treeID,treeNode,clickFlag) {
        	$('#isParentClick').val(treeNode.isParent);
			if(treeNode.isParent){
				//add by Y 2015-01-29 给出提示 begine
				//jAlert("请选择指定泛能站!");
				//$("#searchBtn").off('click').css("background","url(<c:url value='/resources/img/xmgl_btn2.png' />)");
				//add by Y 2015-01-29 给出提示 end
				$(".tleft .xmgl_srear").off('click').removeClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_nadd.png' />)");
				$("#tableDiv .datalist").empty()
				$("#Pagination").empty();
				return;
			}else{
				//add by Y 2015-01-29 取消查询失效 begine
				//$("#searchBtn").on('click').css("background","url(<c:url value='/resources/img/btn6427.png' />)");
				//add by Y 2015-01-29 取消查询失效 end
				pid = treeObj.getSelectedNodes()[0].id;
				if(pid == null || pid == "") return;
				$(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
				isFirst = true;
				$("#Pagination").empty();
				getValue(pid,0);
				$("input[name='searchTitle'],input[name='searchCreatetime']").attr("value","");
			}
		}
        function initPagination(pagers) {
        	//add by Y 2015-02-25 点击查询之后，重新绑定编辑事件 begine
        	toPop();
        	//add by Y 2015-02-25 点击查询之后，重新绑定编辑事件 end
        	var rows = $('table','#tableDiv').find('tr').length;
        	if(rows==1 || rows == 0){$("#Pagination").empty();return;}
        	if(pagers == undefined || pagers <= 1){$("#Pagination").empty();return;}
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
			getValue(pid,page_index);
			return false;
		}
        
        function initDelbtn(){
        	//删除
			$(".xml_del2").bind("click", function () {
				var obj = $(this);
				jConfirm("确认要删除？","确定",function(r){
					if (r==true) {
						var nid = obj.attr("val");
						$.ajax({type:"get",url:"<c:url value='/project/news/delete/"+nid+"' />?new="+new Date().getTime(),
							success:function(data){
								if (data.success){
									jAlert("删除成功！");
									isFirst = true;
									//modify by Y 2015-02-25 删除之后，显示之前的查询条件 begine
									$("#searchBtn").click();
									//getValue(pid,0);
									//modify by Y 2015-02-25 end
								}else {
									jAlert("删除失败！");
								}
							},error:function(data){
								jAlert("删除失败！");
							}
						});
	
					}
				});
			});
        }
        //查询、删除、添加、修改按钮，弹出编辑窗口
        function toPop(){
        	//添加、修改
        	$(".fancybox").click(function(){
        		if(pid == null || pid == "") return;
        		var pop = $(".bd","#pop-onupdate").empty();
	            var nid = $(this).attr("val");
	            $.ajax({type:"GET",url:"<c:url value='/project/news/edit' />?new="+new Date().getTime(),
	            	data:{pid:pid,newsid:nid},
					success:function(data){
						pop.html(data);
						//UE.getEditor('editor');
						initpop();
					},error:function(){
						jAlert('加载失败!');
					}
				});
	        });
        }
        //表单弹出页面的JS
        function initpop(){
        	//富文本编辑器
        	var editor = new baidu.editor.ui.Editor({  
        		
        	});  
        	//var URL="../js/ueditor/";  
        	editor.render("editor");  
			$(".edui-editor-bottomContainer table").css({
				"position": "absolute"
				,"bottom": -46
				,"height": "auto"
				,"width":270
			});
			$(".edui-editor-bottomContainer table td").css("border","none");
        	$('#submitLink').removeAttr("href").click(function() {
        		var title = $("#newsform").find("input[name='title']").val();
        		//modify by Y 2015-01-28 不为空和全部空格校验begine
        		//if(title.length==0){
        			if(title.length==0 || title.trim().length == 0){
        				//modify by Y 2015-01-28 不为空和全部空格校验end
        				jAlert('新闻标题不能为空!');
			    		return;
			    	}
        			var $wordsCountMsg  = $('#customWordsCount');
					var text=$("*[name='newscontaint']").val();
					//console.log(text.length);
					$wordsCountMsg.hide();
					if(text.length > 1400){
						$wordsCountMsg.show().text('字符长度超出限制，超出'+(text.length - 1400)+'个字符！');
						return;
					}
			        if(editor.hasContents()){  //提交条件满足时提交内容  
			        	editor.sync();           //此处的editor是页面实例化出来的编辑器对象  
			        	//$('#caseForm').submit();
			        	var newsid = $("#update_newsid").val();
						var url,vals = $("#newsform").serialize();
						if(newsid != ""){
							url = "<c:url value='/project/news/update' />?new="+new Date().getTime();
							$.ajax({url:url,type: 'POST',data:vals,
								success:function(data){
									if (data.success){
										$.fancybox.close();
										isFirst = true;
										if(newsid != ""){
											jAlert("编辑成功!");
										}
										//alert("保存成功");
										//modify by Y 2015-02-25 编辑之后，显示之前的查询条件 begine
										$("#searchBtn").click();
										//getValue(data.pageProjectid,0);
										//modify by Y 2015-02-25 end
									}else {
										jAlert("修改失败！");
									}
								},error:function(){
									//jAlert(data.msg);
									jAlert("修改失败！");
								}
							});
						}else{
							url = "<c:url value='/project/news/save' />?new="+new Date().getTime();
							$.ajax({url:url,type: 'POST',data:vals,
								success:function(data){
									if (data.success){
										$.fancybox.close();
										isFirst = true;
										jAlert("新增成功!");
										//alert("保存成功");
										//modify by Y 2015-02-25 新增之后，显示之前的查询条件 begine
										$("#searchBtn").click();
										//getValue(data.pageProjectid,0);
										//modify by Y 2015-02-25 end
									}else {
										jAlert("新增失败！");
									}
								},error:function(){
									//jAlert(data.msg);
									jAlert("新增失败！");
								}
							});
						}
						/**
						 * 
						$.post(url,vals,function(data){
									if (data.success){
										$.fancybox.close();
										isFirst = true;
										if(newsid != ""){
											jAlert("编辑成功!");
										}
										//alert("保存成功");
										getValue(data.pageProjectid,0);
									}else {
										jAlert(data.msg);
									}
				        			
				       	});*/
			        }else{  
			            jAlert("内容不能为空！ ");  
			        }  
			    }).css({  
			        'cursor' : 'pointer'  
			    });  
			    $('#cancelLink').removeAttr("href").click(function() {  
			        //$('#caseForm').submit();  
			    }).css({  
			        'cursor' : 'pointer'  
			    }); 
            }
         //加载右侧列表
        function getValue(pid,page){
        	$.ajax({type:"GET",url:"<c:url value='/project/news/list' />?new="+new Date().getTime(),
				data:{pid:pid,page:page},
				success:function(data){
					$("#tableDiv").empty().html(data);
					if(isFirst) initPagination($("#tableDiv #count").val());
					toPop();
					initDelbtn();
				},error:function(){
					jAlert('加载失败!');
				}
			});
        }
        });
       
    </script>
    <style type="text/css">
	    ul.ztree {
		    overflow-y: auto;
	    }
    </style>
</head>
<body>
	<jsp:include page="../../header.jsp"></jsp:include>
    <div id="container">
        <div id="LeftCol" class="LeftCol LeftCol2" style="background: #fff;">
            <p style="height:30px;width:222px;background:#3498db; text-indent:10px; color: #fff; line-height: 28px;">园区选择</p>
            <ul id="treeDemo"  class="ztree ul-xwgl"></ul>
        </div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft">
            </div>
            <div class="content contentTop">
                <div class="topFilter tab">
                	<form id="searchForm" action="" method="post">
	                	<input type="hidden" id="serachPagePid" name="serachPagePid" value=""/>
	                	<input type="hidden" id="serachPage" name="serachPage" value=""/>
	                    <table class="putform">
	                        <tr>
	                            <td class="w60">
	                                <span class="">新闻标题：</span></td>
	                            <td class="tleft lbgl">
	                                <input type="text" name="searchTitle" class="lbglname" />
	                                <span class="lbglspan" style="">发布时间：</span>
	
	                                <input type="text" name="searchCreatetime" style="float: left; margin-top: 5px;" class="Wdate itxt w80" onfocus="WdatePicker({isShowClear:true})" autocomplete="off" />
	                                <a id="searchBtn" class="viewbtn2 fl ml10" style="margin-top: 5px;">查看数据</a>
	                                <shiro:hasPermission name="news:add">
	                                <a class="fr xmgl_srear" style="background: url('<c:url value="/resources/img/xmgl_nadd.png" />');" href="#pop-onupdate" val="0"></a>
	                                </shiro:hasPermission>
	                            </td>
	                        </tr>
	                    </table>
                    </form>
                </div>
                <div class="wrap" style="overflow-y:auto;">
                    <div class="datalist-div datalist-content-news" style="border-left: none; border-top: none;">
                    	<div id="tableDiv" class="tablediv-inner" style="background-color: #fff;overflow-y:auto;"></div>
                    	<div class="page mt10">
							<div id="Pagination" class="pagination"></div>
						</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--<div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    --%>
    <%--弹出框 --%>
    <input id="isParentClick" type="hidden" value="true"/>
    <div class="mod-pop" id="pop-onupdate" style="width: 706px; height: 537px;">
        <div class="hd">
            <h2>新闻内容</h2>
        </div>
        <div class="bd">
            
        </div>
    </div>
</body>
</html>
