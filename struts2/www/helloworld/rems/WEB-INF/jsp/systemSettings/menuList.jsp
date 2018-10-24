<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 导航管理 -->
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
    <link href="<c:url value='/resources/css/mksjpz.css'/>" rel="stylesheet" />
    <script src="<c:url value='/resources/js/zTree_v3/js/jquery.ztree.excheck-3.5.js' />"></script>
    <script src="<c:url value='/resources/js/rightsManagement.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <link href="<c:url value='/resources/css/Newcommon.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/ajaxfileuploads.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
    <script type="text/javascript">
    	        
        $(function(){
        	var scrH=$(window).height()- 113;
			$("#test").css("height",scrH);
    		$(".isvalidBtn").click(function(){
    			var obj = $(this),thisurl = obj.attr("thisurl");
				jConfirm("您确定执行启用/禁用操作吗？","确定",function(r){
					if(r == true){
	    				$.get(thisurl,function(data){
		    				if(!data) {jAlert("操作失败！");return;}
		    				if(obj.hasClass("ico-statusError")){
			    				obj.removeClass("ico-statusError").addClass("ico-statusRight");
			    			}else{
			    				obj.removeClass("ico-statusRight").addClass("ico-statusError");
			    			}
		    			})
	    			}
				})
    			
    		});
    		
    		//添加页面
	    	$("#addBtn").click(function(){
	    		$.ajax({type:"get",url:"<c:url value='/menu/addInput?id=${id}&menuid=${menuid}' />",data:{},
	    			success:function(data){
	    				$("#pop-onMenuUpdate .bd").empty().html(data);
	    			}	
	    		});
	    	})
	    	
	    	//修改页面
	    	$(".updateBtn").click(function(){
	    		$("#pop-onMenuUpdate .bd").empty();
	    		var obj = $(this),thisurl = obj.attr("thisurl");
	    		$.get(thisurl+new Date().getTime(),function(data){
	    				$("#pop-onMenuUpdate .bd").html(data);
	    		});
	    	})
    	});
        
    </script>
</head>
<body>
    <jsp:include page="../header.jsp"></jsp:include>
    <div id="container" class="systemsManagement">
        <div  class="content contentTop dhgl_contenttop">
            <div id="test" class="wrap wrap-sys" >
                <div class="datalist-div" >
                    <table class="datalist">
                        <thead>
                            <tr>
                                <td >菜单名称</td>
                                <td >URL</td>
                                <td >图标</td>
                                <td class="w80">排序</td>
                                <td >备注</td>
                                <td class="w60">操作</td>

                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="p" items="${menuList}" varStatus="s">
                        		<tr class="${s.count%2==0 ? 'odd':'even'}">
                        			 <c:choose>
                        			 	<c:when test="${p.pmenuid != 0}">
	                                		<td class="dhgl_tdodd"><br>${p.menuname}</td>
                        				</c:when>
                        			 	<c:otherwise>
                        			 		<td class="dhgl_tdeven"><br> ${p.menuname } </td>
                        			 	</c:otherwise>
                        			 </c:choose>
	                                <td>${p.menuurl }</td>
                        			 <c:choose>
		                                <c:when test="${p.icon != null}">
		                               		<td>
		                               			<img alt="" src="../${p.icon}">
		                               			<img alt="" src="../${p.iconhover}">
		                               		</td>
				                                <td>
				                               		<shiro:hasPermission name="menu:update">
					                                	<input type="hidden" value = "${p.menuid}" name = "data"/>
					                                	<input type="hidden" value = "${p.pmenuid}" name = "data"/>
					                                	<input type="hidden" value = "${p.menusort}" name = "data"/>
					                                	<span data-op="up" class="mksjpzIcon mksjpzArrU"></span>
														<span data-op="down" class="mksjpzIcon mksjpzArrD"></span>
			                                		</shiro:hasPermission>
				                                </td>
		                                </c:when>
		                                <c:otherwise>
                        			 		<td></td>
                        			 		<td>
                        			 		<shiro:hasPermission name="menu:update">
                        			 		
                        			 		</shiro:hasPermission>
                        			 		</td><%--排序所占用的空td --%>
                        			 	</c:otherwise>
	                                 </c:choose>
	                                <td class="ellipsis" title="${p.remarks }">${p.remarks }</td>
	                                <td>
                         				<shiro:hasPermission name="menu:update">
	                                		<a thisurl="<c:url value='/menu/updateInput/${p.menuid}?id=${id}&menuid=${menuid}' />&_=" class="updateBtn ico-op ico-opUpdate fancybox" href="#pop-onMenuUpdate" title="编辑"></a>
		                                </shiro:hasPermission>
	                                </td>
                        		<input type="hidden" name="menuid" value="${p.menuid}"/>
                        		<input type="hidden" name="pmenuid" value="${p.pmenuid}"/>
	                            </tr>
                        	</c:forEach>
                        </tbody>

                    </table>
                    
                    <shiro:hasPermission name="menu:add">
                    <!-- 移除新增导航
                    <div class="clear dhgl_addline">
                        	<a id="addBtn" class="newAdd  fr fancybox" href="#pop-onMenuUpdate"><span>新增</span></a>
                    </div> 
                     -->
                    </shiro:hasPermission>
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

    <div class="mod-pop dhgl_popmenu" id="pop-onMenuUpdate">
        <div class="hd">
            <h2>新增/修改导航</h2>
        </div>
        <div class="bd">
        
        </div>
    </div>
    
    <script type="text/javascript">
    $(document).ready(function(){
    	$(document).on('click','.mksjpzIcon', resort);
    	
    });
    //位移操作
	function resort() {
    	var op = $(this).data('op') || '';
        var tr = $(this).parents('tr')
      	, ptr = tr.prev()
      	, basicModel = {}
        , contrastModel = {}
      	, ntr = tr.next();
        menuid = tr.find("input[name='data']")[0].value;
        pmenuid = tr.find("input[name='data']")[1].value;
        menusort = tr.find("input[name='data']")[2].value;
        nextPmenuid = ntr.find("input[name='pmenuid']").val();
        prevPmenuid = ptr.find("input[name='pmenuid']").val();
     switch(op) {
          case 'up':
          	if(menusort == 1){
          		jAlert("已经是第一条记录！");
      			return;
      		}else{
          		basicModel = initInputData(tr);
          		contrastModel = initInputData(ptr);
          	}
            break;
          case 'down':
          	if(typeof(nextPmenuid) == 'undefined' || nextPmenuid == 0){
          		jAlert("已经是最后一条记录！");
      			return;
      		}else{
          		basicModel = initInputData(tr);
          		contrastModel = initInputData(ntr);
          	}
            break;
      }
     var data={};
     var bmid=basicModel['menuid'];
     var cmid=contrastModel['menuid'];
     if(op == 'up'||op == 'down'){
	      var bmloc=basicModel['data'],cmloc=contrastModel['data'];
	      data={bmid:bmid,cmid:cmid,bmloc:bmloc,cmloc:cmloc,op:op};
	      $.ajax({type: "GET",url: "<c:url value='/menu/modifyLoc'/>",
		      data:data,success: function (data) {
	    	  	if(data == 'true'){
			      	location.reload();
	    	  	}else{
	    	  		jAlert('操作失败！');
	    	  	}
		      }
	      });
      }
  	}
    
    function flashTable(obj){
    	$.ajax({type:"get",url:"<c:url value='/menu/list?id=${id}&menuid=${menuid}' />",data:{},
	    	success:function(data){}	
	    	});
    }
    
    function initInputData(obj){
		var data = {};
		obj.find("input").each(function(){
			var name = $(this).attr("name"),value = $(this).val();
			if(!(!name)){
				data[name] = value;
			}
		});
		return data;
	}
    
    </script>
</body>
</html>
