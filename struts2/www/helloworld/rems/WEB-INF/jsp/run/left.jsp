<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
var minInterval = null;
$(function(){
	initRight($("#nyglinul .nyglinulsel").attr("val"));
	$("#nyglinul li").bind("click", function () {
		$("#nyglinul li").removeClass("nyglinulsel");
		$(this).addClass("nyglinulsel");
		$(".wrap").empty();
		initRight($(this).attr("val"));
	});
	
	function initRight(sbid){
		var projectid = $("#nowProjectid").val(),equipment = projectid +";" + sbid;
		$.ajax({type:"GET",url:"<c:url value='/run/value' />?date="+new Date().getTime(),data:{equipment:equipment},
	    	success:function(data){
			if(minInterval) clearTimeout(minInterval);
			$(".wrap").empty().html(data);
	    }});
	}
})
</script>
<ul id="nyglinul" class="nyglinul">
	<input type="hidden" id="nowProjectid" name="projectid" value="${pid }"/>
	<c:forEach var="a" items="${sys}" varStatus="s">
		<li class="${s.index == 0 ? 'nyglinulsel':''}" val="${a.classinstanceid }">
			<img src="<c:url value='/resources/img/iconleft.png' />" />
			${a.classinstancename }
		</li>
	</c:forEach>
	
</ul>