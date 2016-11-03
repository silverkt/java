<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 日志管理 -->
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/zTree_v3/css/zTreeStyle/zTreeStyle.css' />"/>
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/pagination.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/zTree_v3/js/jquery.ztree.excheck-3.5.js' />"></script>
    <script src="<c:url value='/resources/js/rightsManagement.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>
    <link href="<c:url value='/resources/css/Newcommon.css' />" rel="stylesheet" />
	<script type="text/javascript">
	var isFirst = true
		,isSearch = false;
	$(function(){
		var scrH=$(window).height()- 95;
		$(".wrap").css("height",scrH-20);
		$("#tableDiv").css("height",scrH-102);
		getValue(0,isSearch);
		//SimSelect
		$('#userid').simSelect({callback: function (x,v) {
				if(!x) return;
				$(this).find('input').val(v);
			}
		});
		$('#type').simSelect({callback: function (x,v) {
				if(!x) return;
				$(this).find('input').val(v);
				if(v == "2" || v == ""){
					$('#logExport').removeClass('hideExcel').addClass('execl').on('click',exportLogs);//所有和业务可以导出
				}else{
					$('#logExport').removeClass('execl').addClass('hideExcel').off('click',exportLogs);
				}
			}
		});
		$('#logExport').on('click',exportLogs);//默认可以导出
		$('#operatetype').simSelect({callback: function (x,v) {
				if(!x) return;
				$(this).find('input').val(v);
			}
		});
		//添加页面
		$("#addBtn").click(function(){
			$.ajax({type:"GET",url:"<c:url value='/menu/addInput?id=${id}&menuid=${menuid}' />",data:{},
				success:function(data){
					$("#pop-onMenuUpdate .bd").empty().html(data);
				},error:function(){
					jAlert('加载失败！');
				}
			});
		});
		//修改页面
		$(".updateBtn").click(function(){
			$("#pop-onMenuUpdate .bd").empty();
			var obj = $(this),thisurl = obj.attr("thisurl");
			$.get(thisurl,function(data){
				$("#pop-onMenuUpdate .bd").html(data);
			});
		});
		//条件查询日志
		$('#searchBtn').click(function(){
			isSearch = true;
			isFirst = true;
			getValue(0,isSearch);
		});
	});
	function exportLogs(){
		if($('#count').val() == -999){
			jAlert('未查询到相关数据！');
			return;
		}else{
			jConfirm("你正在导出日志信息，日志类型仅限业务日志！\n 每个单独的数据文件最多保存30,000条数据！\n是否确认导出？","日志导出确认",function(r){
				if(r == true){
					//console.log($('#logform').serialize());
					$('#logform').attr('action',"<c:url value='/log/export' />");
					$('#logform').submit();
				}
			});
			/*$.ajax({type:"POST",url:"<c:url value='/log/exportCheck' />",data:$('#logform').serialize(),cache:false,
				success:function(data){
					jConfirm("你正在导出日志信息，日志类型仅限业务日志！\n"+data.more+"\n是否确认导出？",data.title,function(r){
						if(r == true){
							$('#logform').attr('action',"<c:url value='/log/export' />");
							//console.log($('#logform').serialize());
							$('#logform').submit();
						}
					});
				},error:function(){
					jAlert('加载失败！');
				}
			});*/
		}
	}
	function getValue(page,isSreach){
		if(isSreach){
			var data = $('#logform').serialize();
			data += "&page="+page;
			$.ajax({type:"POST",url:"<c:url value='/log/list' />",data:data,cache:false,
				success:function(data){
					$("#tableDiv").empty().html(data);
					if(isFirst) initSearchPagination($("#tableDiv #count").val());
				},error:function(){
					jAlert('加载失败！');
				}
			});
		}else{
			$.ajax({type:"GET",url:"<c:url value='/log/list' />",data:{page:page},cache:false,
				success:function(data){
					$("#tableDiv").empty().html(data);
					if(isFirst) initPagination($("#tableDiv #count").val());
				},error:function(){
					jAlert('加载失败！');
				}
			});
		}
	}
	function initPagination(pagers) {
		$("#searchPagination").empty();
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
		getValue(page_index,isSearch);
		return false;
	}
	function initSearchPagination(pagers) {
		$("#Pagination").empty();
		$("#searchPagination").pagination(pagers, {
			num_edge_entries: 1,
			num_display_entries: 4,
			callback: pageSearchSelectCallback,
			items_per_page: 1,
			prev_text: "上一页",
			next_text: "下一页"
		});
	}
	function pageSearchSelectCallback(page_index, jq){
		if(isFirst) {isFirst = false;return;}
		getValue(page_index,isSearch);
		return false;
	}
    </script>
</head>
<body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div id="container" class="systemsManagement">
        <div class="content contentTop rzgl_contenttop">
			<div class="search-rules" style="clear:both;zoom:1;height:40px;min-width:1160px;">
				<form id="logform" target="" method="post">
					<p class="fl mr5 ml5">操作人:</p>
					<div class="mod-select mr5 mt5" id="userid" style="width: 81px;">
						<p class="text">请选择</p>
						<input type="hidden" name="userid" value="0"/>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<div class="list" >
							<ul>
								<li val='0'><a href=''>所有人</a></li>
								<c:forEach items="${operators}" var="u">
									<li val='${u.userId}'><a href=''>${u.userShowName}</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<p class="fl mr5 ml5">日志类型:</p>
					<div class="mod-select mr5 mt5" id="type" style="width: 66px;">
						<p class="text">请选择</p>
						<input type="hidden" name="type" value=""/>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<div class="list" >
							<ul>
								<li val=''><a href=''>所有类型</a></li>
								<li val='1'><a href=''>登录日志</a></li>
								<li val='2'><a href=''>业务日志</a></li>
								<li val='3'><a href=''>错误日志</a></li>
							</ul>
						</div>
					</div>
					<p class="fl mr5 ml5">模块:
						<input type="text" name="module" value="" maxlength="60"/>
					</p>
					<p class="fl mr5 ml5">操作类型:</p>
					<div class="mod-select mr5 mt5" id="operatetype" style="width: 80px;">
						<p class="text">请选择</p>
						<input type="hidden" name="operatetype" value=""/>
						<span class="arr-group hand">
							<i class="icon-mod icon-arr"></i>
						</span>
						<div class="list" >
							<ul>
								<li val=''><a href=''>所有类型</a></li>
								<li val='登录系统'><a href=''>登录系统</a></li>
								<li val='退出系统'><a href=''>退出系统</a></li>
								<li val='数据监测'><a href=''>数据监测</a></li>
								<li val='数据分析'><a href=''>数据分析</a></li>
								<li val='数据更新'><a href=''>数据更新</a></li>
								<li val='数据导出'><a href=''>数据导出</a></li>
								<li val='系统异常'><a href=''>系统异常</a></li>
								<li val='未定义类型'><a href=''>未定义类型</a></li>
							</ul>
						</div>
					</div>
					<p class="fl mr5">创建时间:
						<input id="smins1h" type="text" name="beginTime" class="Wdate itxt w80" value="${today}" style="width: 90px;" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'emins1h\')}'})" autocomplete="off">
						到
						<input id="emins1h" type="text" name="endTime" class="Wdate itxt w80" value="${today}" style="width: 90px;" onfocus="WdatePicker({maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'smins1h\')}'})" autocomplete="off">
					</p>
					<a id="searchBtn" class="viewbtn2 fl ml10 mt3">搜索</a>
					<a id="logExport" class="fr execl mt5" style="display: block;" href="javascript:void(0);" title="只可导出业务日志！"></a>
				</form>
			</div>
			<div class="clear h5"></div>
            <div class="wrap wrap-sys">
                <div class="datalist-div">
                	<div id="tableDiv" class="tablediv-inner-log" >
                		<!-- 这里显示列表内容 -->
                	</div>
                	
                    <div class="page mt10">
						<div id="Pagination" class="pagination"><!-- 这里显示分页 --></div>
						<div id="searchPagination" class="pagination"><!-- 这里显示分页 --></div>
					</div>
                    
                    <%--<div class="clear" style="padding: 30px 20px;">
                    	<shiro:hasPermission name="menu:add">
                        	<a id="addBtn" class="newAdd  fr fancybox" href="#pop-onMenuUpdate"><span>新增</span></a>
                    	</shiro:hasPermission>
                    </div>--%>
                </div>
            </div>
        </div>

    </div>
    <div class="area_popup">
        <div class="datalist-div" >
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>

    <div class="mod-pop rzgl_popmenu" id="pop-onMenuUpdate" >
        <div class="hd">
            <h2>新增/修改导航</h2>
        </div>
        <div class="bd">
        
        </div>
    </div>
</body>
</html>
