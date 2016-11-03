<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 标准类管理    -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/global.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/frame.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/context.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/list.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/nygl.css" rel="stylesheet' />" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <%--<script src="<c:url value='/resources/js/jquery.validate.js' />"></script>--%>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <script src="<c:url value='/resources/js/ajaxfileupload.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
    <script type="text/javascript">
        $(document).ready(function () {
        	var scrH=$(window).height()- 170;
        	$("#test").css("height",scrH);
        	//隔行变色
        	$("#classTableId").find("tr:odd").attr("class","odd");
        	$("#classTableId").find("tr:even").attr("class","even");
            
            //所属父类
			$('#parentclassSel').simSelect({
				callback: function (x,v) {
					if(v){
				    	$("#searchParentclassid").val(v);
					}
				}
			});
			//所属组别
			$('#classtypeSel').simSelect({
				callback: function (x,v) {
					if(v){
				    	$("#searchClasstypeid").val(v);
				    }
				}
			});
		
            //添加页面
	    	$("#addBtn").click(function(){
	    		$.ajax({type:"get",url:"<c:url value='/classManage/addInput?id=${id}&menuid=${menuid}' />",cache:false,data:{},
	    			success:function(data){
	    				$("#pop-onupdate .bd").empty().html(data);
	    			}	
	    		});
	    	})
	    	//修改页面
	    	$(".updateBtn").click(function(){
        		var $this = $(this);
				var classid = $this.parent().find("input[name='classid']").val();
        		$.ajax({type:"get",url:"<c:url value='/classManage/updateInput/"+classid+"?id=${id}&menuid=${menuid}' />",cache:false,data:{classid:classid},
	    			success:function(data){
	    				$("#pop-onupdate .bd").empty().html(data);
	    			}	
	    		});
	    	});
	    	//高级查询
	    	$("#searchBtn").click(function(){
	    		$.ajax({type:"POST",cache:false,data:$("#searchForm").serialize(),
	    			url:"<c:url value='/classManage/findByForm' />",
	    			success:function(data){
	    				$("#dataTable").empty().html(data);
	    			}	
	    		});
	    		//$("#searchForm").submit();
	    	});
	    	//删除页面
	    	$(".xml_del2").click(function(){
	    		var $this = $(this);
	    		jConfirm("注意：该设备类下所含的类属性会被级联删除，确认删除？","确定",function(r){
	    			if (r==true) {
						var classid = $this.parent().find("input[name='classid']").val();
						//执行删除操作
						$.ajax({url: "<c:url value='/classManage/delete/"+classid+"'/>",cache: false,
						  success: function(data){
							  if (data.condition_failure){
									jAlert("删除失败，请确保该设备类下已没有设备！");
								}else if(data.success){
									jAlert("删除成功！","确定",function(r){
										if(r == true){
											//location.reload([true]);
											window.location.href="<c:url value='/classManage/list?id=${id}&menuid=${menuid}'/>";
										}
									});
								}else {
									jAlert("删除失败！");
								}
						  },error:function(XMLHttpRequest, textStatus, errorThrown){
							  jAlert("删除失败！");
						  }
						});
	                	// $.post("<c:url value='/classManage/delete/"+classid+"'/>"+"?temp="+Math.random(),function(data){
						//	if (data.condition_failure){
						//		jAlert("删除失败，请确保该设备类下已没有设备！");
						//	}else if(data.success){
						//		jAlert("删除成功");
				        //		window.location.href="<c:url value='/classManage/list?id=${id}&menuid=${menuid}'/>";
						//	}else {
						//		jAlert("删除失败");
						//	}
			        	//}); 
		            }
	    		});
	    	});
        });
         
    </script>
</head>
<body>
    <jsp:include page="../../header.jsp"></jsp:include>

    <div id="container" class="">

        <div class="content contentTop">
            <div class="topFilter tab">
            	<form id="searchForm" action="<c:url value='/classManage/findByForm'/>" method="POST">
            	<input type="hidden" name="id" value="${id}"/> 
            	<input type="hidden" name="menuid" value="${menuid}"/> 
                <table class="putform">
                    <tr>
                        <td class="w60" style="display:none">
                            <span class="" style="display:none">所属组别：</span></td>
                        <td class="tleft lbgl">
                            <div class="mod-select  mt5" id="classtypeSel" style="display:none">
                            	<input type="hidden" id="searchClasstypeid" value="" />
                                <p class="text">请选择所属组别</p>
                                <span class="arr-group hand">
                                    <i class="icon-mod icon-arr"></i>
                                </span>
                                <div class="list group-list">
                                    <ul>
                                        <c:forEach var="s" items="${formatList}">
											<li val="${s.formatid}">
												<a href="">${s.formatname}</a>
											</li>
										</c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <span class="lbglspan" style="display:none">所属父类：</span>
                            <div class="mod-select  mt5" id="parentclassSel" style="display:none">
								<input type="hidden" id="searchParentclassid" value=""  />
                                <p class="text">请选择所属父类</p>
                                <span class="arr-group hand">
                                    <i class="icon-mod icon-arr"></i>
                                </span>
                                <div class="list father-list">
                                    <ul>
                                        <li val="-1"><a href="">无父标准类</a></li>
                                        <c:forEach var="s" items="${parentlist}">
											<li val="${s.classid}">
												<a href="">${s.classname}</a>
											</li>
										</c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <span class="lbglspan">类名称：</span>
                            <input type="text" id="searchClassname" class="lbglname" name="classname" />
                            <a id="searchBtn" class="searchBtn viewbtn2 fl ml10">查看数据
                            </a>
                            <shiro:hasPermission name="classManage:add">
                            <a id="addBtn" class="fr fancybox xmgl_srear" href="#pop-onupdate"></a>
                            </shiro:hasPermission>
                        </td>
                    </tr>
                </table>
                </form>
            </div>
            <div class="wrap">
                <div id="dataTable" class="classManagement-datalist datalist-div">
                    <table id="classTableId" class="datalist datalist2 lbgltbl">
                        <thead>
                            <tr>
                                <td class="datalist-no">序号</td>
                                <td>类名称</td>
                                <td>所属父类</td>
                                <td>所属组别</td>
                                <td>类图片</td>
                                <td class="datalist-op">操作</td>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="c" items="${classList}" varStatus="s">
                        		<tr class="even">
	                                <td>${s.count}</td>
	                                <td>${c.classname}</td>
	                                <td>${c.parentclassname}</td>
	                                <td>${c.formatname}</td>
	                                <td>
	                                    <img src="<c:url value='${c.picturepath}' /> " class="datalist-classimg">
	                                </td>
	                                <td class="opper">
                                		<input type="hidden" name="classid" value="${c.classid}"/>
                                		<shiro:hasPermission name="classManage:update">
	                                	<a class="updateBtn fancybox xml_edite2" href="#pop-onupdate"></a>
	                                	</shiro:hasPermission>
	                                	<shiro:hasPermission name="classManage:delete">
	                                	<a class="xml_del2"></a>
	                                	</shiro:hasPermission>
	                                </td>
	                            </tr>
                        	</c:forEach>
                        </tbody>
                    </table>
                    <%--<div class="page mt10"></div>--%>
                </div>
            </div>
        </div>
    </div>

    <div class="area_popup">
        <div class="datalist-div restyle-datalist-div">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    <div class="mod-pop bzlgl-add" id="pop-onupdate">
        <div class="hd">
            <h2>标准类管理</h2>
        </div>
        <div class="bd"></div>
    </div>
</body>
</html>
