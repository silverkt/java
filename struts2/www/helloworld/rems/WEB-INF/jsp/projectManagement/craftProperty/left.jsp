<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
	$("#nyglinul li").bind("click", function () {
		$("#nyglinul li").removeClass("nyglinulsel");
		$(this).addClass("nyglinulsel");
		$(".wrap").empty();
		var sbid = $(this).find("input[name='classinstanceid']").val();
		initRight(sbid);
	});
	
	function initRight(sbid){
		var projectid = $("#nowProjectid").val();
		$.ajax({type:"GET",url:"<c:url value='/craftProperty/listRight' />?new="+new Date().getTime(),data:{id:sbid,projectid:projectid},
	    	success:function(data){
			$(".wrap").empty().html(data);
	    }});
	}
</script>
<ul id="nyglinul" class="nyglinul">
	<input type="hidden" id="nowProjectid" name="projectid" value="${projectid }"/>
	<c:forEach var="a" items="${sys}" varStatus="s">
		<li class="">
			<input type="hidden" name="classinstanceid" value="${a.classinstanceid }"/>
			<img src="<c:url value='/resources/img/iconleft.png' />" />
			${a.classinstancename }
		</li>
	</c:forEach>
	
</ul>