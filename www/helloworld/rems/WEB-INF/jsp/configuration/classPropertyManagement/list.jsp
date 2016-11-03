<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 类属性管理 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/global.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/frame.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/context.css" rel="stylesheet' />" />
    <link href="<c:url value='/resources/css/nygl.css" rel="stylesheet' />" />
     <link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
    <script type="text/javascript">
        $(document).ready(function () {
			var scrH=$(window).height()- 97;
			$("#folderBtn").css("top",scrH/2);
			$(".LeftCol").css("height",scrH);
			$("#test").css("height",scrH - 61);
            $(".curSelectedNode span:first-child").css("background", "url(./img/img_23.png)");
            //所属组别
			$('#selectCs').simSelect({
				callback: function (x,v) {
					if(v){
				    	listLeft(v);
					}
				}
			});
            //所属类型
			$('#selectSb').simSelect({
				callback: function (x,v) {
					if(v){
				    	$("#searchPropertytypeid").val(v);
					}
				}
			});
            //所属分类
			$('#xmgl_shi').simSelect({
				callback: function (x,v) {
					if(v){
				    	$("#searchIsdynamic").val(v);
					}
				}
			});
            function listLeft(classid){
            	if(classid == null || classid == "") return;
	    		$.ajax({type:"GET",url:"<c:url value='/classProperty/listLeft' />",cache:false,data:{id:classid},
	    			success:function(data){
					$("#classListDiv").empty().html(data);
					$(".wrap").empty();
					$("#addBtn").removeClass("fancybox").css("background","url(\'<c:url value='/resources/img/xmgl_nadd.png'/>\')");
					$(".nyglinul-lsxgl").css("height",$(window).height()-168);
					$(".nyglinul-lsxgl").css("min-height",$(window).height()-168);
	    			}
				});
	    	}
            
            //添加页面
	    	$("#addBtn").click(function(){
	    		var pageClassid = $("#pageClassid").val();
        		if(pageClassid == null || pageClassid == "") return;
	    		$.ajax({type:"get",url:"<c:url value='/classProperty/addInput?id=${id}&menuid=${menuid}' />",cache:false,data:{pageClassid:pageClassid},
	    			success:function(data){
	    				$("#pop-onupdate .bd").empty().html(data);
	    			}	
	    		});
	    	})
	    	
	    	//高级查询
	    	$("#searchBtn").click(function(){
	    		var pageClassid = $("#pageClassid").val();
	    		$("#searchPageClassid").val(pageClassid);
	    		if(typeof(pageClassid)=='undefined'){
	    			jAlert("请选择设备类！");
	    			return;
	    		}else{
	    			searchByFrom();
	    		}
	    	});
        });
        function searchByFrom(vals){
        	if($("#searchPropertytypeid").val()=='-1')$("#searchPropertytypeid").val('');
        	if($("#searchIsdynamic").val()=='-1')$("#searchIsdynamic").val('');
        	if(vals=='undefined'||vals==undefined){
        		
        		if($("#searchPageClassid").val()==''){    
        			$("#searchPageClassid").val(-99);
        			vals = $("#searchForm").serialize();   	        		
		        	$('#lastSearchData').val(vals);
		        }else{
		        	vals = $("#searchForm").serialize();   	        		
		        	$('#lastSearchData').val(vals);
		        }
        		
        	}
        	$.post("<c:url value='/classProperty/findByForm'/>",vals,function(data){
        		$(".wrap").empty().html(data);
        	});
        }
        function searchByUpdate(vals){
        	if(vals=='undefined'||vals==undefined){        		
        		if($("#searchPageClassid").val()==''){    
        			$("#searchPageClassid").val(-99);
        			vals = $("#searchForm").serialize();   	        		
		        	$('#lastSearchData').val(vals);
        		}else{
		        	vals = $("#searchForm").serialize();   	        		
		        	$('#lastSearchData').val(vals);
		        }
        	}
        	$.post("<c:url value='/classProperty/findByUpdate'/>",vals,function(data){
        		$(".wrap").empty().html(data);
        	});
        }
        function initSearchFrom(){
        	$.post("<c:url value='/classProperty/searchFrom'/>",function(data){
        		$(".topFilter .tab").empty().html(data);
        	});
        }
    </script>
</head>
<body>
    <jsp:include page="../../header.jsp"></jsp:include>
    <div id="container" class="">
        <div id="LeftCol" class="LeftCol LeftCol2" style="background: #fff;">
            <div style="width:100%;height:40px; float:left; margin-left:6px;">
            	<div class="mod-select  mt5 xmgl_selct" id="selectCs">
                    <input type="hidden" id="searchClasstypeid" name="classtypeid" value="" />
	                <p class="text">选择项目类型</p>
	                <span class="arr-group hand">
	                    <i class="icon-mod icon-arr"></i>
	                </span>
	                <div class="list" style="z-index: 1001;">
	                    <ul>
	                        <c:forEach var="s" items="${formatList}">
								<li val="${s.formatid}">
									<a href="">${s.formatname}</a>
								</li>
							</c:forEach>
	                    </ul>
	                </div>

            	</div>
            </div>
            <div class="tab-nav" style="background: none repeat scroll 0 0 #3498db; float:left; width:100%; height: 30px; padding-top: 2px; color: #fff; line-height: 28px;">
                <ul class="ml10">
                    <li class="last"><a class="spec">选择设备类</a></li>
                </ul>
            </div>
            <div id="classListDiv"></div>
        </div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft">
            </div>
            <div class="content contentTop">
                <div class="topFilter tab">
            		<form id="searchForm" action="" method="post">
                    <input type="hidden" id="searchPageClassid" name="searchPageClassid" value="${pageClassid}" />
                    <table class="putform">
                        <tr>
                            <td class="w60">
                                <span class="">属性类型：</span></td>
                            <td class="tleft lbgl">
                                <div class="mod-select  mt5" id="selectSb" style="">
                    				<input type="hidden" id="searchPropertytypeid" name="searchPropertytypeid" value="" />
                                    <p class="text">请选择属性类型</p>
                                    <span class="arr-group hand">
                                        <i class="icon-mod icon-arr"></i>
                                    </span>
                                    <div class="list" style="height: 95px; overflow-y: auto;">
                                        <ul>
                                        	<li val='-1'><a href=''>全部属性类型</a></li>
                                        	<c:forEach var="s" items="${typeList}" varStatus="v">
	                                            <li val="${s.propertytypeid}"><a href="">${s.typename}</a></li>
											</c:forEach>
                                        </ul>
                                    </div>
                                </div>
                                <span class="lbglspan" style="">属性分类：</span>
                                <div class="mod-select  mt5" id="xmgl_shi">
                    				<input type="hidden" id="searchIsdynamic" name="searchIsdynamic" value="" />
                                    <p class="text">请选择属性分类</p>
                                    <span class="arr-group hand">
                                        <i class="icon-mod icon-arr"></i>
                                    </span>
                                    <div class="list" style="">
                                        <ul>
                                        	<li val='-1'><a href=''>全部属性分类</a></li>
                                            <li val="0"><a href="">静态属性</a></li>
                                            <li val="1"><a href="">动态属性</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <span class="lbglspan">属性名称：</span>
                                <input type="text" class="lbglname" id="searchPropertyname" name="searchPropertyname" />
                                <input type="hidden" id="lastSearchData" value=""/>
                                <a id="searchBtn" class="viewbtn2 fl ml10" style="margin-top: 5px;">查看数据</a>
                                <shiro:hasPermission name="classProperty:add">
                                <a id="addBtn" class="fr xmgl_srear" style="background: url('<c:url value="/resources/img/xmgl_nadd.png" />');" href="#pop-onupdate"></a>
                           		</shiro:hasPermission>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="test" class="wrap" style="overflow-y:auto;">
             
                </div>
            </div>
        </div>
    </div>
    <div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    <div class="mod-pop" id="pop-onupdate" style="width: 370px;min-height: 365px;">
        <div class="hd">
            <h2>属性管理</h2>
        </div>
        <div class="bd">
            
            
        </div>
    </div>
</body>
</html>
