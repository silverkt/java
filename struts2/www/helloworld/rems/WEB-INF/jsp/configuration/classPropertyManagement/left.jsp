<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
	var scrH=$(window).height()- 97;
	$("#nyglinul li").bind("click", function () {
    	$("#nyglinul li").removeClass("nyglinulsel");
        $(this).addClass("nyglinulsel");
		//initSearchFrom();
		$(".wrap").empty();
		var sid = $(this).find("input[name='classid']").val();
		initRight(sid);
		//alert($("#selectCs p").text());
		$("#selectSb p").text("请选择属性类型");
		$("#searchPropertytypeid").val('');
		$("#xmgl_shi p").text("请选择属性分类");
		$("#searchIsdynamic").val('');
		$("#searchPropertyname").val("");
		$('#lastSearchData').val('');

	});
	
	function initRight(sid){
        if(sid == null || sid == "") return;
		$(".tleft .xmgl_srear").addClass("fancybox").css("background","url(<c:url value='/resources/img/xmgl_add.png' />)");
		$.ajax({type:"GET",url:"<c:url value='/classProperty/listRight' />",data:{id:sid},cache:false,
	    	success:function(data){
			$(".wrap").empty().html(data);
	    }});
	}
</script>
            <ul id="nyglinul" class="nyglinul nyglinul-lsxgl" style="float:left;overflow-y:auto;width: 213px;">
            	<c:forEach var="s" items="${classList}" varStatus="v">
	            	<li val="${s.classid}" class="">
						<input type="hidden" name="classid" value="${s.classid }"/>
	                    <img src="<c:url value='/resources/img/iconleft.png'/>" />${s.classname}
	                </li>
				</c:forEach>
            </ul>