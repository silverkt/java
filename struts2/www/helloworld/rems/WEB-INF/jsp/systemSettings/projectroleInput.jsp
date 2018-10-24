<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
<script type="text/javascript">
	var ztree= null;
	$(function(){
		closeFancybox();
		$.ajax({type:"GET",url:"<c:url value='/projectrole/tree' />?new ="+new Date().getTime(),
		success:function(data){
			ztree = $.fn.zTree.init($("#rightsManagement"), setting, data);
			$.fn.zTree.getZTreeObj("rightsManagement").expandAll(true);
			//修改时，选中用户原有的权限树
			var ids='${projectroleids}';
			if(ids!==""){
				var idArray=ids.split(",");
				for(var i=0;i<idArray.length;i++){
					id=idArray[i];
					var node = ztree.getNodeByParam("id",id, null);
					if(node !=null && node.children.length==0){
						ztree.checkNode(node, true, true,false);
					}
				}
			}
		}});
		//失去焦点触发事件
		$("#projectrolename").focus();
		//失去焦点触发事件
		$("#projectrolename").on('blur',checkName);
		/*//验证用户名
		$("#projectrolename").blur(function(){
			if($("#projectrolename").val() == ""){
				$("#errorMsg").css("display","block");
				$("#projectrolenameMsg").text("角色名必填");
				return false;
			}
			var vals = $("#projectroleForm").serialize();
			$.post("<c:url value='/projectrole/checkProjectRole'/>?new ="+new Date().getTime(),vals,function(msg){
					if(msg){
						$("#errorMsg").css("display","none");
						$("#submitBtn").on("click");
					}else{
						$("#errorMsg").css("display","block");
						$("#projectrolenameMsg").text("角色名已存在");
						$("#submitBtn").off("click");
					}
			});
		});*/
	});
	function checkName(){
		if($("#projectrolename").val() == ""){
			$("#errorMsg").css("display","block");
			$("#projectrolenameMsg").text("角色名必填");
			$("#errorMsg").parent().prev().html("角色名称：<div style='height:28px;'></div>");
			return false;
		}
		var vals = $("#projectroleForm").serialize();
		$.ajax({type : "post",data : vals,async : false,
			url : "<c:url value='/projectrole/checkProjectRole'/>?new ="+new Date().getTime(),
			success : function(data){
				if(data){
					$("#errorMsg").css("display","none");
					$("#errorMsg").parent().prev().html("角色名称：");
					$("#submitBtn").off('click').on('click',save);
				}else{
					$("#errorMsg").css("display","block");
					$("#errorMsg").parent().prev().html("角色名称：<div style='height:28px;'></div>");
					$("#projectrolenameMsg").text("角色名已存在");
					$("#submitBtn").off('click',save);
				}
				return data;
			}
		});
	}
	function save(){
			//功能权限树
			var ids = "";
			var nodes = ztree.getCheckedNodes();
			for(var i=0;i<nodes.length;i++){
					var id=nodes[i].id;
					ids=ids+id+",";
			}
			ids=ids.substring(0,ids.length-1);
			$("#ids").val(ids);
			var uprojectroleObjid = $("#uprojectroleObjid").val()
			, vals = $("#projectroleForm").serialize()
			, url = "";
			if(uprojectroleObjid != ""){
				url="<c:url value='/projectrole/update'/>?new ="+new Date().getTime();
			}else{
				url="<c:url value='/projectrole/add'/>?new ="+new Date().getTime();
			}
			//$("#projectroleForm").submit();
			$.post(url,vals,function(data){
				if (data!=''&&data == "true"){
					if(uprojectroleObjid != ""){
						jAlert("编辑成功！","确定",function(r){
							$.fancybox.close();
							if(r == true){
								location.replace(location.href);
							}
						}); 
					}else{
						jAlert("新增成功！","确定",function(r){
							$.fancybox.close();
							if(r == true){
								location.replace(location.href);
							}
						});
					}
				}else {
					if(uprojectroleObjid != ""){
						jAlert("编辑失败！");
					}else{
						jAlert("新增失败！");
					}
				}
			});
	}
</script>
<style>
<!--
form label.error{background: url(<c:url value='/resources/img/erroicon.png)'/> no-repeat;}
-->
</style>

<form id="projectroleForm" action="" method="post">
	<div class="fl">
    	<table class="putform fl">
        	<tr>
            	<td class="tright w80">角色名称：</td>
                <td class="tleft errordiv">
					<input type="hidden" value="${projectroleObj.projectroleid}" id="uprojectroleObjid" name="projectroleid" />
					<input type="hidden" value="${projectroleObj.isvalid}" name="isvalid" />
                	<input type="text" id="projectrolename" name="projectrolename" value="${projectroleObj.projectrolename}" class="w200 ttxt txtt2" maxlength="16" />
                	<div id="errorMsg" class="qxgl_errorMsg"><label class="error" id="projectrolenameMsg"></label></div>
                	
                </td>
        	</tr>
            <tr>
                <td class="tright w80">描述：</td>
                <td class="tleft">
                    <input type="text" id="projectroledescr" name="projectroledescr" value="${projectroleObj.projectroledescr}" class="w200 ttxt txtt2"  maxlength="32" />
                	<%--<div style="color: red"><label class="error" id="projectroledescrMsg"></label></div>--%>
                </td>
            </tr>
            <tr>
                <td class="tright w80 qxgl_gnqx_top" >功能权限：</td>
                <td class="tleft">
                    <div class="mt5 qxgl_gnqx_tleft">
                    	
						<input type="hidden" id="ids" name="accessids"/>
                    	<ul id="rightsManagement" class="ztree qxgl_rightsManagement" ></ul>
                        </div>
                    </td>
                </tr>

        </table>
    </div>
    <div class="clear">
        <a class="tck-cancel fr mt15 ml20 closeFancybox qxgl_cancel" href="javascript:;">取消</a>
        <a id="submitBtn" class="tck-save fr mt15">保存</a>
    </div>
</form>
