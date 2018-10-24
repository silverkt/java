<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
    <script type="text/javascript">
<!--
	$(function(){
		var screenW=document.documentElement.clientWidth;
	    var screenH=screen.height;
	    /**if(screenW<2800){
	    	if(screenH>=1200){
		    	$("#myxmgl_incont").css("width","520px");
		    	$("#myxmgl_incont").css("margin-top","34px");
		    	$(".xmgl_xtzb tr td").css("background","url('<c:url value="/resources/img/yuan16002800.png" />') no-repeat");
	    	}
	    	$("#xt2").hide();
	    	$("#xt1").show();	
	    	
	    }else{
	    	if(screenH>=1050){
	    		
	    	}
	    	$("#xt1").hide();
	    	$("#xt2").show();
	    	$("#xt2").css("margin-top","80px");
	    } **/
	    $("#myxmgl_incont").css("width","100%");
		//$("#xt2").css("margin-top","90px");
		$(".xmgl_xtzb tr td").css("background","url('<c:url value="/resources/img/yuan16002800.png"  /> ') center top no-repeat");
	})
//-->
</script>
<style>
<!--
.xtzbval {
    margin-top: 90px;
}
-->
</style>
         <table style="width: 100%;" id="tbllist" class="yc" >
         <tr class="xmgl_list1 pie">
                <td>
                    <div class="xmgl_list1_cont" style=" height:300px;">    
                        <p class="xmgl_list1_head"><span class="fl" mid="4">能源结构-耗</span></p>
                        <div class="xmgl_incont" id="hichartpie1" style=" height:265px;"></div>
                    </div>
                </td>
                <td>
                    <div class="xmgl_list1_cont" style=" height:300px;">
                        <p class="xmgl_list1_head"><span class="fl" mid="5">能源结构-供</span></p>
                        <div class="xmgl_incont" id="hichartpie2" style="height: 265px;"></div>
                    </div>
                </td>
                </tr>
            <tr class="xmgl_list1 chart">
                <td>
                    <div class="xmgl_list1_cont">
                        <p class="xmgl_list1_head"><span class="fl" mid="4">当日耗能</span><!-- a class="fancybox" href="#pop-xmgl"></a> --></p>
                        <div class="xmgl_incont" id="hichart1"></div>
                    </div>
                </td>
                <td>
                    <div class="xmgl_list1_cont">
                        <p class="xmgl_list1_head"><span class="fl" mid="5">当日供能</span><%--<a class="fancybox" href="#pop-xmgl"></a>--%></p>
                        <div class="xmgl_incont" id="hichart2"></div>
                    </div>
                </td>
            </tr>
            <tr class="xmgl_list1 xmgl_list2 chart">
                <td>
                    <div class="xmgl_list1_cont" style="margin-bottom:20px;background: #fff">
                        <p class="xmgl_list1_head"><span>系统指标</span></p>
                        <div class="xmgl_incont"  id="myxmgl_incont" style=" margin:0 auto; margin-top:30px;height:260px;width: 100%;">
                            <table class="xmgl_xtzb" style="display: none; " id="xt1">
                            	<c:forEach items="${quotas}" var="d" varStatus="s">
									${s.index % 2 eq 0 ? '<tr>':'' }
										<td>
											<span class="xtzbval">
												<span class="quota" cid="${d.classinstanceid }" pid="${d.classpropertyid }"></span>
											<font style="font-size:12px;">${d.unitname }</font></span>
                                        	<span class="xtzbname">${d.showname }</span>
										</td>
									${s.index + 1 % 2 eq 0 || s.last ? '</tr>':'' }
								</c:forEach>
                            </table>
							<table class="" style="" id="xt2">
                            	<tr>
	                            	<c:forEach items="${quotas}" var="d" varStatus="s">
											<td>
												<div id="speed${s.index+1}" class="quota" style="height: 270px;"
													cid="${d.classinstanceid }" pid="${d.classpropertyid }" 
													sname="${d.showname }" uname="${d.unitname }" ></div>
												</td>
									</c:forEach>
								</tr>
                          </table>                        
                        </div>
                    </div>
                </td>
                <td>
                    <div class="xmgl_list1_cont" style="margin-bottom:20px;">
                        <p class="xmgl_list1_head"><span class="fl" mid="7">实时气象</span><%--<a class="fancybox" href="#pop-xmgl"></a>--%></p>
                        <div class="xmgl_incont" id="hichart3">
                        </div>
                    </div>
                </td>
            </tr>
        </table>