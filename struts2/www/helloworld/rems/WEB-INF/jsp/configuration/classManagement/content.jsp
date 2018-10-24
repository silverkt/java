<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<script type="text/javascript">
$(document).ready(function() {
	/*
	//隔行变色
	$("#classTableId").find("tr:odd").attr("class", "odd");
	$("#classTableId").find("tr:even").attr("class", "even");
	//修改页面
	$(".updateBtn").click(function(){
		console.log('update');
		var $this = $(this);
		var classid = $this.parent().find("input[name='classid']").val();
		var url = "<c:url value='/classManage/updateInput/"+ classid + "?id=${id}&menuid=${menuid}' />";
		$.ajax( {type : "GET" , cache : false , data : { classid : classid},
			url : url,
			success : function(data) {
				$("#pop-onupdate .bd").empty().html(data);
			},error : function(){
				jAlert('加载失败！');
			}
		});
	});
	//删除页面 
	$(".xml_del2").click(function(){
		var $this = $(this);
		jConfirm("注意：该设备类下所含的类属性会被级联删除，确认删除？","确定",function(r){
			if (r==true) {
				var classid = $this.parent().find("input[name='classid']").val();
				//执行删除操作
				$.ajax({cache: false,url: "<c:url value='/classManage/delete/"+classid+"'/>",
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
			}
		});
	});
	*/
});

</script>
<table id="classTableId" class="datalist datalist2 lbgltbl">
	<thead>
		<tr>
			<td class="datalist-no">
				序号
			</td>
			<td>
				类名称
			</td>
			<td>
				所属父类
			</td>
			<td>
				所属组别
			</td>
			<td>
				类图片
			</td>
			<td class="datalist-op">
				操作
			</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="c" items="${classList}" varStatus="s">
			<tr class="even">
				<td>
					${s.count}
				</td>
				<td>
					${c.classname}
				</td>
				<td>
					${c.parentclassname}
				</td>
				<td>
					${c.formatname}
				</td>
				<td>
					<img src="<c:url value='${c.picturepath}' /> "
						class="datalist-classimg">
				</td>
				<td class="opper">
					<input type="hidden" name="classid" value="${c.classid}" />
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