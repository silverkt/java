<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 权限管理 -->
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
    <link href="<c:url value='/resources/css/Newcommon.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
    <script type="text/javascript">
    	        
        $(function(){
        	var scrH=$(window).height()- 95;
    		$(".wrap").css("height",scrH-20);
    		$(".isvalidBtn").click(function(){
    			var obj = $(this),thisurl = obj.attr("thisurl");
				jConfirm("您确定执行启用/禁用操作吗？","确定",function(r){
					if(r == true){
						$.get(thisurl+"&_="+new Date().getTime(),function(data){
		    				if(!data) {jAlert("操作失败！");return;}
		    				if(obj.hasClass("ico-statusError")){
			    				obj.removeClass("ico-statusError").addClass("ico-statusRight");
			    			}else{
			    				obj.removeClass("ico-statusRight").addClass("ico-statusError");
			    			}
		    			})
					}
				});
    		});
    		
    		//添加页面
	    	$("#addBtn").click(function(){
	    		$("#pop-onupdate .bd").empty();
	    		$.ajax({type:"get",url:"<c:url value='/projectrole/addInput' />?new ="+new Date().getTime(),data:{},
	    			success:function(data){
	    				$("#pop-onupdate .bd").empty().html(data);
	    			}	
	    		});
	    	})
	    	
	    	//修改页面
	    	$(".updateBtn").click(function(){
	    		$("#pop-onupdate .bd").empty();
	    		var obj = $(this),thisurl = obj.attr("thisurl");
	    		$.get(thisurl+new Date().getTime(),function(data){
	    				$("#pop-onupdate .bd").html(data);
	    		});
	    	})
    	});
    </script>
</head>
<body>
    <jsp:include page="../header.jsp"></jsp:include>
    <%--<div class="nav-nav clear">

        <div class="sel_nav ml10">
            <a title="修改城市" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>华东区</span>-<span>黄花机场</span>-<span>1号泛能站</span></a>
        </div>

    </div>
    --%>
    <div id="container" class="systemsManagement">

        <div class="content contentTop qxgl_contenttop">

            <div class="wrap wrap-sys" >
                <div class="datalist-div">
                    <table class="datalist">
                        <thead>
                            <tr>
                                <td>角色名称</td>
                                <td>描述</td>
                                <td>创建时间</td>
                                <td class="w80">状态</td>
                                <td class="w60">操作</td>

                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="p" items="${projectroleList}" varStatus="s">
                        		<tr class="${s.count%2==0 ? 'odd':'even'}">
	                                <td>${p.projectrolename }</td>
	                                <td>${p.projectroledescr }</td>
	
	
	                                <td>${p.createdate }</td>
	                                <td>
	                                	<shiro:hasPermission name="projectrole:update">
	                                		<a thisurl="<c:url value='/projectrole/isvalid?id=${p.projectroleid}' />&_=" class="isvalidBtn ${p.isvalid=='0' ? 'ico-status ico-statusError':'ico-status ico-statusRight'}" title="启用/禁用"></a>
	                                	</shiro:hasPermission>
	                                </td>
	                                <td>
	                                	<shiro:hasPermission name="projectrole:update">
	                                		<a thisurl="<c:url value='/projectrole/updateInput/${p.projectroleid}' />?_=" class="updateBtn ico-op ico-opUpdate fancybox" href="#pop-onupdate" title="编辑"></a>
	                                	</shiro:hasPermission>
	                                </td>
	                            </tr>
                        	</c:forEach>
                        </tbody>

                    </table>
                    <%--<div class="page mt10">
                        <a href="" class="pre disabled"><i class="icon-mod">&lt;上一页</i></a>
                        <a class="on" href="">1</a>
                        <a href="">2</a>


                        <span>...</span>
                        <a href="">4</a>
                        <a href="" class="next"><i class="icon-mod">下一页&gt;</i></a>
                    </div>
                    --%>
                    
                    <div class="clear qxgl_clear" >
                    	<shiro:hasPermission name="projectrole:add">
                        	<a id="addBtn" class="newAdd  fr fancybox" href="#pop-onupdate"><span>新增</span></a>
                    	</shiro:hasPermission>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="area_popup">
        <div class="datalist-div ">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>

    <div class="mod-pop qxgl_popmenu" id="pop-onupdate" >
        <div class="hd">
            <h2>新增/修改角色</h2>
        </div>
        <div class="bd">
            
        </div>
    </div>
</body>
</html>
