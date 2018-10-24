<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<style>
	#siteBase .default{cursor: default;}
	.fakeFile{cursor: pointer;}
</style>
<script type="text/javascript">
function saveSite3D(obj){
var $row = $(obj).parent().parent("tr");
if($row.find("input[name='file']").val()==''){
	jAlert('请选择要上传的图片！');
	return;
}
var data={};
var imgname = $row.find(".fakeFile").text();
var isBase = ($row.attr("id") == 'siteBase');
var fileId = $row.find("input[type='file']").attr("id");
if(!isBase){
	var $baseRow = $("#siteBase");
	var basePid = $baseRow.find("input[name='projectid']").val();
	if(basePid==""){
		alert("请先上传并保存项目站点图");
		return;
	}else{
		if(data['id']==""){
			data['base_bgpath'] = $baseRow.find("input[name='baseBgpath']").val();
		}
		data['imgname'] = imgname;
	}
}else{
	data['base_projectid'] = $("#projectId").val();
}
$row.find("input").each(function(){
	var name = $(this).attr("name"),value = $(this).val();
	if(!(!name)){
		data[name] = value;
	}
});
data['count'] = $("#chartsCount").val();
data['isBase'] = isBase;
//console.log(data);
$.ajaxFileUpload({url: "<c:url value='/moduleconfig/saveSite3D' />",type:"POST",
	fileElementId:fileId,dataType:'text',data:data,
	success: function(data){
		if(data=='true'){
			if(isBase){
				jAlert("修改站点图成功！");
			}else{
				jAlert("上传成功！");
			}
			initSite3D($('#projectId').val());
		}else{
			jAlert("修改失败！");
		}
	}
});
}
</script>
<input type="hidden" name="chartsCount" id="chartsCount" value="${chartsCount}"/>
<table data-model = "chart" data-tcode="c">
	<thead>
		<tr>
			<th>对应图片</th>
			<th>图片名称</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
		<tr id="siteBase">
			<td>项目站点图</td>
			<td>
				<span class="fakeFile">
					项目站点图<c:if test="${empty charts[0].bgpath}"> - 暂无</c:if>
				</span>
				<input name="file" id="baseChart" type="file" class="realFile hide">
			</td>
			<td>
				<input type="hidden" name="projectid" value="${charts[0].projectid}" />
				<input type="hidden" name="baseBgpath" value="${charts[0].bgpath}" />
				<span class="mksjpzIcon"></span>
				<span class="mksjpzIcon"></span>
				<span class="mksjpzIcon mksjpzSav" onclick="saveSite3D(this)"></span>
				<span data-op="del" class="mksjpzIcon mksjpzDel"></span>
			</td>
		</tr>
		<c:forEach items="${charts}" var="i" varStatus="s">
			<!-- <tr class="${s.index % 2 eq 0 ? 'even':'odd'}"> -->
			<tr>
				<td>
					<c:if test="${s.index == 0}"> 3D图 ① </c:if>
					<c:if test="${s.index == 1}"> 3D图 ② </c:if>
					<c:if test="${s.index == 2}"> 3D图 ③ </c:if>
					<c:if test="${s.index == 3}"> 3D图 ④ </c:if>
				</td>
				<td>
					<span class="fakeFile"><c:if test="${empty charts[s.index].imgname}">请选择图片</c:if>${charts[s.index].imgname}</span>
					<input name="file" id="charts${s.index+1}" type="file" class="realFile hide"">
				</td>
				<td>
					<input type="hidden" name="id" value="${charts[s.index].id}" />
					<input type="hidden" name="projectid" value="${charts[s.index].projectid}" />
					<input type="hidden" name="location" value="${charts[s.index].location}" />
					<input type="hidden" name="bgpath" value="${charts[s.index].bgpath}" />
					<span data-op="up" class="mksjpzIcon mksjpzArrU"></span>
					<span data-op="down" class="mksjpzIcon mksjpzArrD"></span>
					<span class="mksjpzIcon mksjpzSav" onclick="saveSite3D(this)"></span>
					<span data-op="del" class="mksjpzIcon mksjpzDel"></span>
				</td>
			</tr>
			</c:forEach>
	</tbody>
</table>
