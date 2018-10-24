<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<script type="text/javascript">
$(function(){
	closeFancybox();
	//排序
	$('#menusortDiv').simSelect({
		callback: function (x,v) {
			$("#menusort").val(v);
			$("#menusortMsg_TR").hide();
			$("#menusortMsg").text("");
		}
	});
	$("#submitBtn").on('click',checkMenuItemName);
});
function checkMenuItemName(){
	var $msg = $('#menuCheckMsg')
	, menuName = $('#menuname').val();
	//验证菜单名称
	if(menuName == ''){
		$msg.show().find("#projectrolenameMsg").text("菜单名称必填");
	}else{
		url = "<c:url value='/menu/checkMenuName' />";
		$.ajax({type:"POST",url:url,data:{'menuid':$('#menuid').val(),'menuname':menuName},async:false,
			success:function(data){
				if(data == 'true'){
					$msg.hide().find("#projectrolenameMsg").text("");
					saveMenuItem();
				}else{
					$msg.show().find("#projectrolenameMsg").text("菜单名称重复");
				}
			},error:function(){
				jAlert('加载失败!');
			}
		});
	}
}
function saveMenuItem(){
	var dataArray = {};
	$("#menuForm input").each(function(){
		var name = $(this).attr("name"),value = $(this).val();
		dataArray[name] = value;
	});
	var uprojectroleObjid = $("#menuid").val();
	var url;
	if(uprojectroleObjid != ""){
		//$("#menuForm").attr("action","<c:url value='/menu/update'/>");
		url="<c:url value='/menu/update'/>";
	}else{
		//$("#menuForm").attr("action","<c:url value='/menu/add'/>");
		url="<c:url value='/menu/add'/>";
	}
	//$("#menuForm").submit();
	$.ajaxFileUpload({url: url,type:"POST",dataType:"text",
		fileElementId:['icon','iconhover'],data:dataArray,
		success: function(data){
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
					jAlert("修改失败！");
					}else{
					jAlert("新增失败！");
				}
			}
		},error:function(){
			jAlert('操作失败！');
		}
	});
}
</script>
<style>
<!--
form label.error{background: url(<c:url value='/resources/img/erroicon.png)'/> no-repeat;}
-->
</style>

<form id="menuForm" action="" method="post">
	
    <input type="hidden" id="headerid" name="id" value="${id}"/>
    <input type="hidden" id="headermenuid" name="headermenuid" value="${menuid}"/>
	<div class="fl dhgl_allfl">
    	<table class="putform fl">
        	<tr>
            	<td class="tright w80">菜单名称：</td>
                <td class="tleft errordiv">
					<input type="hidden" value="${menuObj.menuid}" id="menuid" name="menuid" />
                	<input type="text" id="menuname" name="menuname" value="${menuObj.menuname}" maxlength="32" class="w200 ttxt txtt2" />
                	<div class="dhgl_menucheckmsg" id="menuCheckMsg"><label class="error" id="projectrolenameMsg"></label></div>
                	
                </td>
        	</tr>
            <tr>
                <td class="tright w80">备注：</td>
                <td class="tleft">
                    <input type="text" id="remarks" name="remarks" value="${menuObj.remarks}" maxlength="32" class="w200 ttxt txtt2" />
                	<%--<div style="color: red"><label class="error" id="projectroledescrMsg"></label></div>--%>
                </td>
            </tr>
            <c:if test="${menuObj.pmenuid != 0}">
            	<!-- 
            	<tr>
				<td class="tright w80" style="position: absolute;display: table;">
					排序：
				</td>
				<td class="tleft">
				  <div style="display:table;">
					<input type="hidden" value="${menuObj.menusort}" id="menusort" name="menusort" />
					<div class="mod-select mt5" id="menusortDiv"
						style="margin-right: 12px; float: left; margin-bottom: 4px; border: 1px solid #c9ced1; width: 159px; border-radius: 4px;">
						<p class="text">
							<c:if test="${menuObj.menusort == null}">排序</c:if>
							<c:if test="${menuObj.menusort != ''}">${menuObj.menusort}</c:if>
						</p>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<div class="list" style="height:60px;overflow-y:auto;">
							<ul>
								<li val="1"><a href="">1</a></li>
								<li val="2"><a href="">2</a></li>
								<li val="3"><a href="">3</a></li>
								<li val="4"><a href="">4</a></li>
								<li val="5"><a href="">5</a></li>
								<li val="6"><a href="">6</a></li>
								<li val="7"><a href="">7</a></li>
								<li val="8"><a href="">8</a></li>
								<li val="9"><a href="">9</a></li>
								<li val="10"><a href="">10</a></li>
							</ul>
						</div>
					</div> -->
			<tr>
                    <td class="tright w80">正常图标：</td>
                    <td class="errordiv">
						<input name="file" id="icon"  type="file"  class="inputImage">
                    </td>
            </tr>
            <tr>
                    <td class="tright w80">高亮图标：</td>
                    <td class="errordiv">
                        <input name="file" id="iconhover"  type="file"  class="inputImage">
                    </td>
            </tr>		
            </c:if>
			
			<tr id="menusortMsg_TR">
				<td></td>
				<td><div>
						<label id="menusortMsg" style="background: url(<c:url value='/resources/img/erroicon.png)'/> no-repeat;" class="error" ></label>
					</div>
				</td>
			</tr>
					<%--<div style="color: red" id="xmRoleidMsg"></div>--%>
				  
				 
				</td>
			</tr>
        </table>
    </div>
    <div class="clear">
        <a class="tck-cancel fr mt15 ml20 closeFancybox dhgl_cancel" href="javascript:;">取消</a>
        <a id="submitBtn" class="tck-save fr mt15">保存</a>
    </div>
</form>
