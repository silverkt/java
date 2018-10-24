<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- 身份管理 -->
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>

    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <script src="<c:url value='/resources/js/rightsManagement.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
    <script type="text/javascript">
         	var onadd = 0;
		var onedit = 0;
		function add() {
        	var line = $("#sfManagement tr:last").attr("class");
        	var tr = $("#copyTr");
            var oTr = document.getElementById("sfManagement").rows[1];
            var newTr = oTr.cloneNode(true);
			var newTd = newTr.getElementsByTagName("td");
			var tdBr = '1px solid #e5e5e5';
			if(onadd == 0 && onedit == 0){
				newTr.style.display = 'table-row';
				if(line == 'odd'){
					$(newTr).attr("class","even");
				}else{
					$(newTr).attr("class","odd");
				}
				document.getElementById("sfManagement").getElementsByTagName("tbody")[0].appendChild(newTr);
				newTr.cells[0].firstChild.value = newTr.rowIndex;
				document.getElementById("b1").disabled = newTr.rowIndex == 5;
				initSelect($(newTr));
				$(newTd[0]).css("borderRight", tdBr); // plz using $ for ie support
			//	$(newTd[1].getElementsByTagName('span')).show();
				$(newTd[2]).css('borderRight', tdBr);
				$(newTd[2]).css('borderLeft' , tdBr);
				$(newTr).addClass('nohover');
				editSave();
				onadd += 1;
			}else{
				jAlert("请先保存编辑内容！");
			}
        }
        
        function initSelect(obj){
        	$(".sfgl_mod-select",obj).simSelect({
		        callback: function (x,v) {
            		if(v) $("#groupid",$(this)).val(v);
		        }
		    });
        }
        
        
        function editSave() {
		    $("#sfManagement tbody tr td .ico-op").unbind("click").toggle(function () {
		    	var id = $(this).attr("thisid"),obj = $(this).parent().parent();
		    	initSelect(obj);
		        if ($(this).hasClass("ico-opSave")) {
		        	
		            doSubmit(id,obj);
					onedit = 0;
					onadd = 0;
		            //$(this).removeClass("ico-opSave").addClass("ico-opUpdate");
		            //$(this).parent("td").siblings("td").find(".cengZindex").removeClass("hide").end().find(".sfgl_itxt").addClass("itxtNo").attr("disabled","disabled");
    				
    				
		        } else {
					if(onadd == 0 && onedit == 0){
		            $(this).parents('td').siblings().find('span').show();
		            $(this).parents('td').siblings('td').eq(0).children().css("border-right","1px solid #e5e5e5");
		            $(this).parents('td').siblings('td').eq(2).children().css(
		            	{
		            		"border-right":"1px solid #e5e5e5"
		            		,"border-left":"1px solid #e5e5e5"
		            	});
		            $(this).removeClass("ico-opUpdate").addClass("ico-opSave");
		            $(this).parent("td").siblings("td").find(".cengZindex").addClass("hide").end().find(".sfgl_itxt").removeClass("itxtNo").removeAttr("disabled");
					$(this).parents('td').parents('tr').addClass("nohover");
					onedit += 1;
					}else{
						jAlert("请先保存编辑内容！");
					}
		        }       
		    }, function () {
		    	var id = $(this).attr("thisid"),obj = $(this).parent().parent();
		    	initSelect(obj);
		        if ($(this).hasClass("ico-opUpdate")) {
		            if(onadd == 0 && onedit == 0){
		            $(this).removeClass("ico-opUpdate").addClass("ico-opSave");
		            $(this).parent("td").siblings("td").find(".cengZindex").addClass("hide").end().find(".sfgl_itxt").removeClass("itxtNo").removeAttr("disabled");
					$(this).parents("td").parents('tr').removeClass("nohover");
					onedit += 1;
					}else{
						jAlert("请先保存编辑内容！");
					}
		        }
		        else {
		        	doSubmit(id,obj);
		            //$(this).removeClass("ico-opSave").addClass("ico-opUpdate");
		            //$(this).parent("td").siblings("td").find(".cengZindex").removeClass("hide").end().find(".sfgl_itxt").addClass("itxtNo").attr("disabled", "disabled");
    				
		        }
		    }); 
		 }
        
        function doSubmit(id,obj){
        	var data = getDatas(obj);
        	if(data == 'noDatas') return;
        	if(id !== ''){
        		var vals = $("input",$(obj)).serialize();
        		$.post("<c:url value='/sysrole/update'/>?t="+new Date().getTime(),vals,function(data){
					if (data.success){
	        				jAlert("编辑成功！","确定",function(r){
	        					if(r == true){
	        						location.reload();
									//window.location.href="<c:url value='/sysrole/list?id=${id}&menuid=${menuid}'/>&t="+new Date().getTime();
	        					}
							});
					}else{
						jAlert(data.msg,"确定",function(r){
	        					if(r == true){
	        						location.reload();
									//window.location.href="<c:url value='/sysrole/list?id=${id}&menuid=${menuid}'/>&t="+new Date().getTime();
	        					}
						});
					}
        			
        		});
        	}else{
				var vals = $("input",$(obj)).serialize();
        		$.post("<c:url value='/sysrole/add'/>?t="+new Date().getTime(),vals,function(data){
					if (data.success){
        				jAlert("新增成功！","确定",function(r){
                        // 成功后可以新增
					onedit = 0;
					onadd = 0;
							if(r == true){
								location.reload();
								//window.location.href="<c:url value='/sysrole/list?id=${id}&menuid=${menuid}'/>&t="+new Date().getTime();
							}
						})
					}else {
                    // 失败后不能新增
                    onadd +=1;
						jAlert(data.msg,"确定",function(r){
	        					if(r == true){
	        						//modify by Y 2015-02-06 保存失败后不刷新页面 begine
	        						//location.reload();
	        						//modify by Y 2015-02-06 end
									//window.location.href="<c:url value='/sysrole/list?id=${id}&menuid=${menuid}'/>&t="+new Date().getTime();
	        					}
						});
					}
        		});
        	}
        }
        
        $(function(){
        	//隔行变色
        	$("#sfManagement").find("tr:odd").attr("class","odd");
        	$("#sfManagement").find("tr:even").attr("class","even");
        	var scrH=$(window).height()- 95;
    		$(".wrap").css("height",scrH-20);
        	editSave();
    		$(".isvalidBtn").click(function(){
    			var obj = $(this),thisurl = obj.attr("thisurl");
				jConfirm("您确定执行启用/禁用操作吗？","确定",function(r){
					if(r==true){
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
    		$("input[type='text']").on('keydown',function(){$(this).css('color','#5b636c');});
    	});
        function getDatas(container){
        	var $container = $(container)
        	, flag = true
        	, data = {};
        	$container.find("input").each(function(){
				var $this = $(this)
				, name = $this.attr("name")
				, type = $this.attr('type')
				, value = $this.val();
				if(value.length>32){
					jAlert('内容过长！');
					$this.css('color','#ff0000');
					flag = false;
				}else{
					$this.css('color','#5b636c');
					data[name] = value;
				}
			});
        	if(!flag)return 'noDatas';
        	return data;
        }
</script>
<style type="text/css">
</style>
</head>
<body>
    
    <jsp:include page="../header.jsp"></jsp:include>
    
    <form id="sysroleForm" action="" method="post">
    <div id="container" class="systemsManagement">

        <div class="content contentTop sfgl_contenttop">
			
            <div class="wrap wrap-sys" >
                <div class="datalist-div">
                    <table class="datalist datalist2 newdatalist sfgl_datalist2" id="sfManagement">
                        <thead>
                            <tr>
                                <td >身份名称</td>
                                <td>所属项目</td>
                                <td>描述</td>

                                <td>创建时间</td>
                                <td class="w80">状态</td>
                                <td class="w60">操作</td>

                            </tr>
                        </thead>
                        <tbody>
                        	<!-- 用于复制新增一行 -->
							<tr class="" id="sfgl_newline">
								<input type="hidden" value="" name="sysroleid" />
								<td style="text-align: left;">
									<input type="text" name="sysrolename" value="" class="sfgl_itxt ellipsis" maxlength="32" />
								</td>
								<td valign="top">
									<div class="cengDiv">
										<div class="mod-select mt5 mb5 sfgl_mt5 sfgl_mod-select" id="">
		                                    <input type="hidden" value="" id="groupid" name="groupid" />
											<p class="text">
												所属项目
											</p>
											<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
											</span>
											<div class="list sfgl_list">
												<ul>
													<c:forEach var="g" items="${projectGroupList}">
														<%--${g.groupid}--%>
														<li val="${g.groupid}">
															<a href="">${g.groupname}</a>
														</li>
													</c:forEach>
												</ul>
											</div>
										</div>
										<div class="cengZindex hide"></div>
										</div>
								</td>
								<td>
									<input type="text" name="sysroledescr" value="" class="sfgl_itxt ellipsis" maxlength="32"/>
								</td>
								<td></td>
								<td>
									<a class="isvalidBtn ico-status ico-statusRight" title="启用/禁用"></a>
								</td>
								<td>
									<a thisid="" class="submitBtn ico-op ico-opSave" title="编辑/保存"></a>
								</td>
							</tr>
							
                        	<c:forEach var="s" items="${sysroleList}" varStatus="v">
                        		<tr class="">
									<input type="hidden" value="${s.sysroleid}" name="sysroleid" />
	                                <td><input type="text" name="sysrolename" title='${s.sysrolename}' value="${s.sysrolename}" class="sfgl_itxt ellipsis" disabled="disabled" maxlength="32" /></td>
	                                <td valign="top">
	                                    <div class="cengDiv">
		                                    <div class="mod-select mt5 mb5 sfgl_mt5 sfgl_mod-select" id="">
		                                    	
		                                    	<input type="hidden" value="${s.groupid}" id="groupid" name="groupid" />
		                                        <p class="text">
												 ${s.groupname}
		                                        </p>
		                                        <span class="arr-group hand">
		                                            <i class="icon-mod icon-arr"></i>
		                                        </span>
		                                        <div class="list sfgl_list">
		                                        	<ul>
		                                        		<c:forEach var="g" items="${projectGroupList}" >
			                                                <li val="${g.groupid}"><a href="">${g.groupname}</a></li>
		                                        		</c:forEach>
			                                        </ul>
		                                        </div>
		                                    </div>
	                                    	<div class="cengZindex hide"></div>
	                                    </div>
	                                </td>
	                                <td>
	                                    <input type="text" name="sysroledescr" title="${s.sysroledescr}" value="${s.sysroledescr}" class="sfgl_itxt ellipsis" disabled="disabled" maxlength="32"/>
	                                </td>
	                                <td>${s.createdate}</td>
	                                <td>
                         				<shiro:hasPermission name="sysrole:update">
	                                		<a thisurl="<c:url value='/sysrole/isvalid?id=${s.sysroleid}' />" class="isvalidBtn ${s.isvalid=='0' ? 'ico-status ico-statusError':'ico-status ico-statusRight'}" title="启用/禁用"></a>
	                                	</shiro:hasPermission>
	                                </td>
	                                <td>
                         				<shiro:hasPermission name="sysrole:update">
	                                		<a thisid="${s.sysroleid}" class="submitBtn ico-op ico-opUpdate" title="编辑/保存" id="saveOrupdate"></a>
	                                	</shiro:hasPermission>
	                                </td>
	
	                            </tr>
                        	</c:forEach>
                            
                        </tbody>

                    </table>
                    <%--
                        <div class="page mt10">
                            <a href="" class="pre disabled"><i class="icon-mod">&lt;上一页</i></a>
                            <a class="on" href="">1</a>
                            <a href="">2</a>


                            <span>...</span>
                            <a href="">4</a>
                            <a href="" class="next"><i class="icon-mod">下一页&gt;</i></a>
                        </div>
                        --%>
                    <div class="clear sfgl_clear">
                    	<shiro:hasPermission name="sysrole:add">
                        <a class="newAdd  fr" onclick="add()" id="b1"><span>新增</span></a>
                        </shiro:hasPermission>
                    </div>
                </div>
            </div>
        </div>

    </div>
	</form>
		
</body>
</html>


