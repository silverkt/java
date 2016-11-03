<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<link href="<c:url value='/resources/css/list.css' />" rel="stylesheet" />

<script type="text/javascript">
$(function() {
	//隔行变色
	$("#listDataTable").find("tr:odd").attr("class", "odd");
	$("#listDataTable").find("tr:even").attr("class", "even");
	$(".xml_del2").on("click",function() {
		var $this = $(this);
		jConfirm("确认要删除？", "确定", function(r) {
			if (r == true) {
				var classpropertyid = $this.parent().find("input[name='classpropertyid']").val();
				$.ajax( {type : "GET",cache : false,
					url : "<c:url value='/classProperty/delete/" + classpropertyid + "' />",
					success : function(data) {
						if (data.success) {
							jAlert("删除成功！");
							var thisPageClassid = $("#pageClassid").val();
							refreshRight2(thisPageClassid);
						} else {
							jAlert("删除失败！");
						}
					},error:function(){
						jAlert('操作失败！');
					}
				});
			}
		});
	});

	//修改页面
	$(".updateBtn").click(function() {
		var $this = $(this);
		var classpropertyid = $this.parent().find("input[name='classpropertyid']").val();
		$.ajax( {type : "get",cache : false,
			url : "<c:url value='/classProperty/updateInput/" + classpropertyid + "?id=${id}&menuid=${menuid}' />",
			success : function(data) {
				$("#pop-onupdate .bd").empty().html(data);
			},error:function(){
				jALert('加载失败！');
			}
		});
	});

	function refreshRight2(sid) {
		$.ajax( {type : "GET",cache : false,data : {id : sid},
			url : "<c:url value='/classProperty/listRight' />",
			success : function(data) {
				$(".wrap").empty().html(data);
			}
		});
	}
})
</script>
<div class="datalist-div">
	<input type="hidden" id="pageClassid" value="${pageClassid}" />
	<table id="listDataTable" class="datalist datalist2 lbgltbl">
		<thead>
			<tr>
				<td class="datalist-no">序号</td>
				<td>属性名称</td>
				<td>所属类</td>
				<td>属性类型</td>
				<td>属性分类</td>
				<td>备注</td>
				<td class="datalist-op"> 操作 </td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="p" items="${propertyList}" varStatus="s">
				<tr class="even">
					<td>${s.count}</td>
					<td class="ellipsis" style="width: 100%;"title="${p.classpropertyname}"> ${p.classpropertyname} </td>
					<td>${p.classname}</td>
					<td>${p.typename}</td>
					<td>${p.isdynamic == 0 ? "静态属性" : "动态属性"}</td>
					<td title="${p.remarks}" align="left">
						<c:choose>
							<c:when test="${fn:length(p.remarks)<=20}">${p.remarks}</c:when>
							<c:otherwise>${fn:substring(p.remarks,0,20)}...</c:otherwise>
						</c:choose>
					</td>
					<td class="opper">
					<input type="hidden" name="classpropertyid" value="${p.classpropertyid}" />
						<shiro:hasPermission name="classProperty:update">
							<a class="updateBtn fancybox xml_edite2" href="#pop-onupdate"></a>
						</shiro:hasPermission>
						<shiro:hasPermission name="classProperty:delete">
							<a class="xml_del2"></a>
						</shiro:hasPermission>
					</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
	<%--
		<div class="page mt10">
			<a href="" class="pre disabled"><i class="icon-mod">&lt;上一页</i></a>
			<a class="on" href="">1</a><a href="">2</a>
			<span>...</span>
			<a href="">4</a>
			<a href="" class="next"><i class="icon-mod">下一页&gt;</i></a>
		</div>
	--%>
</div>
