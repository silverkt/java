<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/include.inc.jsp"%>
<style>
label.error{color:red !important;padding-left:0 !important;}
label{background:none!important;}
</style>
<!-- 自定义页面 -->
<script type="text/javascript">
 $(document).ready(function () {
	  closeFancybox();//关闭fancybox
 });
/**
 * 保存自定义信息
 */
function saveSelfInfo() {
     var flag = true;
	$("#projectselfInfoForm").find("input").each(function(){
		var v = $(this);
	 	var name = v.attr("name").substring(0,11);
	 	if(name == 'selfdataKey'){
	 		if(v.val()==''){
	 			var temp=v.parent().parent().find("input").eq(1).val();
	 			if(temp!=''){
	 				flag = false;
	 			}
	 		}
	 	}
	});
	if(flag == true){
		$.ajax({type:"POST",url: "<c:url value='/projectmanagement/selfInfoSave' />?new ="+new Date().getTime(),
		data: $("#projectselfInfoForm").serialize(),
		success: function(data){
			jAlert('编辑成功！');
			$.fancybox.close();	
		},error:function(data){
			jAlert('编辑失败！');
		}
	});
	}else{
		jAlert("标题不能为空！");
	}
	
}
        
        
</script>
<style>
	h2{width:200px;float:left;}
	tr.errors-tr td{height: auto !important;}
</style>
<!DOCTYPE html>
<div class="hd">
	<h2>自定义信息</h2>
	<input type="hidden" value="${clickpark}" id="clickparkId"/>
</div>
<div class="bd bd2">
<script type="text/javascript">
	function checkLen(obj) {
		var maxChars = 200;//最多字符数
		if (obj.value.length > maxChars)
			obj.value = obj.value.substring(0, maxChars);
		var curr = maxChars - obj.value.length;
		document.getElementById("count").innerHTML = curr.toString();
	}
</script>
<script type="text/javascript">
	 function preview(file) {
		 var prevDiv = document.getElementById('preview');
		 if (file.files && file.files[0]) {
			 var reader = new FileReader();
			 reader.onload = function (evt) {
				 prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';
			 }
			 reader.readAsDataURL(file.files[0]);
		 } else {
			 prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
		 }
	 }
 </script>
<!--自定义信息新增按钮&隔行变色-->
<script type="text/javascript">
	$(function () {
		odd_even();
		function odd_even () {
			$("#projectselfInfoForm").find("tr:odd").attr("class","odd");
        	$("#projectselfInfoForm").find("tr:even").attr("class","even");
		}
        $("#zdy-add").click(function() {
        	var trlength = $("#projectselfInfoForm tbody tr").length;
        	var newtr = "<tr>" + 
							"<td>" +
								"<input name='selfdataKey" + (trlength + 1) +"'  class='xmgl_addinput' type='text' value=''>" +
							"</td>" +
							"<td>" +


								"<input name='selfdataValue" + (trlength + 1) + "' class='xmgl_addinput'  type='text' value=''>" +

							"</td>" +
						"</tr>"
			if(trlength < 10){
				$('#projectselfInfoForm table tbody').append(newtr);
			}else{
				jAlert("最多可添加10条自定义信息！");
			}
			odd_even();
        });
	})
</script>
<form action="" method="post" name="projectselfInfoForm" id="projectselfInfoForm">
<input type="hidden" name="projectid_zdy" id="projectid_zdy" value="${pbinfo.projectid}"/>
<input type="hidden" name="selfinfoid" value="${psfinfo.selfinfoid }"/>
<input name="operate" type="hidden" id="operate" value="${operate}"/>
<table class="xmgl_tbladd zdy w506" id="xmgl_tbljxcx2" >
	<thead>
		<tr>
			<td>标题</td>
			<td>内容</td>
		</tr>
	</thead>
	<tbody>
	<!-- <tr>
			<td>
				<input name="selfdataKey1"  class="xmgl_addinput" type="text" value="${selfdataKey1}">
			</td>
			<td>
				<input name="selfdataValue1" class="xmgl_addinput"  type="text" value=""  placeholder="内容">
			</td>
		</tr>-->
		<c:forEach var="g" items="${list}" varStatus="s" >
				<tr>
					<td>
						<input name="selfdataKey${s.index+1}"  class="xmgl_addinput ellipsis" type="text" title="${g.keys}" value="${g.keys}">
					</td>
					<td>
						<input name="selfdataValue${s.index+1}"  class="xmgl_addinput ellipsis"  type="text" title="${g.values}" value="${g.values}">
					</td>
				</tr>
		   	 </c:forEach>
	</tbody>
	<tfoot>
		<td></td>
		<td><a type="button" class="tck-save fr mt5" id="zdy-add">新增</a></td>
	</tfoot>
</table>
</form>
</div>
<!--自定义信息-->
<div class="clear mr20">
	<a title="Close" class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
	<a class="tck-save fr mt15" onclick="saveSelfInfo();">保存</a>
</div>