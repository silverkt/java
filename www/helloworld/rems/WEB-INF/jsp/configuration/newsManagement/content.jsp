<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<input type="hidden" id="count" value="${count}"/>
<script type="text/javascript">
<!--
	$(function(){
		$(".isvalidBtn").click(function(){
			var obj = $(this)
			, id = $(this).attr("val")
			, aid=$(this).attr("id")
			, url;
			if(aid=="state"){
				url = "<c:url value='/project/news/state/' />"+id;
			}
			else{
				url = "<c:url value='/project/news/top/' />"+id;
			}
			var t = new Date().getTime();
			if(obj.hasClass("ico-statusError")){
				$.get(url,{state:1,time:t},function(data){
					obj.removeClass("ico-statusError").addClass("ico-statusRight");
				});
			}else{
				$.get(url,{state:0,time:t},function(data){
					obj.removeClass("ico-statusRight").addClass("ico-statusError");
				});
				
			}
		});
	});
//-->
</script>

	<table class="datalist datalist2 lbgltbl">
		<thead>
			<tr>
				<td style="width: 60px;">序号</td>
				<td style="width: 300px;">新闻标题</td>
				<td>发布时间</td>
				<td>发布人</td>
				<td style="width: 45px;">状态</td>
				<td style="width: 45px;">置顶</td>
				<td style="width: 90px;">操作</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${news.datas}" var="n" varStatus="s">
				<tr class="${s.index % 2 eq 0 ? 'even':'odd'}">
					<td>${(index*20)+s.index+1}</td>
					<td class="ellipsis tleft" title="${n.title}">${n.title}</td>
					<td><fmt:formatDate value="${n.createtime}" pattern="yyyy-MM-dd  HH:mm:ss" /></td>
					<td>${n.user.userShowName}</td>
					<td>
						<shiro:hasPermission name="news:publish">
					   <c:if test="${n.publish==1}">
					      <a val=${n.newsid } class="isvalidBtn ico-status ico-statusRight" id="state" title="发布/禁用"></a>
					   </c:if>
					   <c:if test="${n.publish==0}">
					      <a val=${n.newsid } class="isvalidBtn ico-status ico-statusError" id="state" title="发布/禁用"></a>
					   </c:if>
					   </shiro:hasPermission>
					   
					</td>
					<td>
						<shiro:hasPermission name="news:top">
					   <c:if test="${n.top==1}">
					      <a val=${n.newsid } class="isvalidBtn ico-status ico-statusRight" id="top" title="是/否"></a>
					   </c:if>
					   <c:if test="${n.top==0}">
					      <a val=${n.newsid } class="isvalidBtn ico-status ico-statusError" id="top" title="是/否"></a>
					   </c:if>
					   </shiro:hasPermission>
					</td>
					<td class="opper">
						<shiro:hasPermission name="news:update">
						<a class="fancybox xml_edite2" href="#pop-onupdate" val="${n.newsid}"></a>
						</shiro:hasPermission>
						<shiro:hasPermission name="news:delete">
						<a class="xml_del2" val="${n.newsid}"></a>
						</shiro:hasPermission>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
