<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 用户管理 -->
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/zTree_v3/css/zTreeStyle/zTreeStyle.css' />"/>
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/ellipsis.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.validate.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/zTree_v3/js/jquery.ztree.excheck-3.5.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <link href="<c:url value='/resources/css/Newcommon.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
    <script type="text/javascript">
    	
    	$(function(){
    		var scrH=$(window).height()- 95;
    		$(".wrap").css("height",scrH-20);
			$(".yhgl_pop").hide();
    		//修改状态
    		$(".isvalidBtn").click(function(){
    			var obj = $(this),thisurl = obj.attr("thisurl");
				jConfirm("您确定执行启用/禁用操作吗？","确定",function(r){
					if(r==true){
	    				$.get(thisurl+"&_="+new Date().getTime(),function(data){
		    				if(!data) {jAlert("操作失败！");return;}
		    				else{
		    					if(obj.hasClass("ico-statusError")){
			    				obj.removeClass("ico-statusError").addClass("ico-statusRight");
			    			}else{
			    				obj.removeClass("ico-statusRight").addClass("ico-statusError");
			    			}
		    				}
		    				
		    			})
	    			}
				})
    			
    		});
    		
    		//添加页面
	    	$("#addBtn").click(function(){
	    		$("#pop-onupdate .bd").empty();
	    		$.ajax({type:"get",url:"<c:url value='/user/addInput?id=${id}&menuid=${menuid}' />&_="+new Date().getTime(),data:{},
	    			success:function(data){
	    				$("#pop-onupdate .bd").empty().html(data);
	    			}	
	    		});
	    	})
	    	
	    	//修改页面
	    	$(".updateBtn").click(function(){
	    		$("#pop-onupdate .bd").empty();
	    		var obj = $(this),thisurl = obj.attr("thisurl");
	    		$.get(thisurl+"&_="+new Date().getTime(),function(data){
	    				$("#pop-onupdate .bd").html(data);
	    		});
	    	})
    	

    	});
    	
    	
    </script>
</head>
<body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div id="container" class="systemsManagement">
            <div class="content contentTop yhgl_contenttop">
                <div class="wrap wrap-sys">
                    <div class="datalist-div">
                        <table class="datalist">
                            <thead>
                                <tr>
                                    <td>用户名</td>
                                    <td>昵称</td>
                                    <td>身份</td>
                                    <td>公司名称</td>
                                    <td>邮箱地址</td>
                                    <td>描述</td>
                                    <td>创建时间</td>
                                    <td class="w80">状态</td>
                                    <td class="w60">操作</td>
                                   
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="u" items="${userList}" varStatus="s">
                            		<tr class="${s.count%2==0 ? 'odd':'even'}">
	                                    <td class="ellipsis " title="${u.userName}">${u.userName }</td>
	                                    <td class="ellipsis " title="${u.userShowName}">${u.userShowName }</td>
	                                    <td>${u.sysrolename}</td>
	                                    <td class="ellipsis" title="${u.company}">${u.company }</td>
	                                    <td class="ellipsis" title="${u.emailAddress }">${u.emailAddress }</td>
	                                    <td  class="ellipsis" title="${u.remarks}">${u.remarks }</td>
	                                    <td>${u.createTime }</td>
	                                    <td>
                         					<shiro:hasPermission name="user:update">
	                                    		<a thisurl="<c:url value='/user/isvalid?id=${u.userId}' />"  class="isvalidBtn ${u.isvalId=='0' ? 'ico-status ico-statusError':'ico-status ico-statusRight'}" title="启用/禁用"></a>
	                                    	</shiro:hasPermission>
	                                    </td>
	                                    <td>
                         					<shiro:hasPermission name="user:update">
	                                    		<a thisurl="<c:url value='/user/updateInput/${u.userId}?id=${id}&menuid=${menuid}' />" class="updateBtn ico-op ico-opUpdate fancybox" href="#pop-onupdate" title="编辑"></a>
	                                    	</shiro:hasPermission>
	                                    </td>
	                                </tr>
                            	</c:forEach>
                            </tbody>
                            
                        </table>
                
                         <div class="clear yhgl_clear">
                         <%-- href="#pop-onupdate" --%>
                         <shiro:hasPermission name="user:add">
                          <a id="addBtn" class="newAdd fr fancybox" href="#pop-onupdate"><span>新增</span></a>
                         </shiro:hasPermission>
                    </div>
                    </div>
                </div>
            </div>
      
    </div>
    <div class="area_popup" >
        <div class="datalist-div">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    
	<%--<form id="userForm" action="<c:url value='/user/add'/>" method="post">
		<div class="wrap" style="height: 480px"></div>
	</form>

--%>
   <div class="mod-pop yhgl_pop" id="pop-onupdate">
        <div class="hd">
            <h2>新增/修改用户</h2>
        </div>
        <div class="bd"></div>
   </div>
   
</body>
</html>
