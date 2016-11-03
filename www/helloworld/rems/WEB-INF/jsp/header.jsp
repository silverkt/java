<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script src="<c:url value='/resources/js/jquery.validate.js' />"></script>
<script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
<link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
<script type="text/javascript">
	$(function(){
		//修改用户信息页面
	    $("#toUpdateCurrentUserBtn").click(function(){
	    	$.ajax({type:"get",url:"<c:url value='/user/updateCurrentUserInput?id=${id}&menuid=${menuid}' />&_="+new Date().getTime(),data:{},
	    		success:function(data){
	    			$("#pop-onupdateCurrentUser .bd").empty().html(data);
	    		}	
	    	});
	    })
	});
</script>
<style>
.nav_selectli .txt{color:#262626;}
</style>
    <div class="head tab mb48">
        <a class="logo"></a>
        <div class="navbar tab-nav">
            <ul class="pdl">
            	<c:forEach items="${fns:listMenu(0)}" var="c">
            		<shiro:hasPermission name="${c.perssioncode}">
            		<c:set var="count" value="0"/>
            		<c:forEach items="${fns:listMenu(c.menuid)}" var="cl" varStatus="status">
            			<shiro:hasPermission name="${cl.perssioncode}">
            				<c:if test="${count==0}">
            					<li class="${id==c.menuid ? 'on':''}" test><a class="" href="<c:url value='${cl.accessurl }'/>">${c.menuname}</a></li>
            				</c:if>
            				<c:set var="count" value="${status.count}"/>
            			</shiro:hasPermission>
            		</c:forEach>
            		</shiro:hasPermission>
            	</c:forEach>
            	<li class="index no"><a class="" href="<c:url value='/index'/>">首页</a></li>
            </ul>
        </div>
        <div class="tab-panel menubg" style="display:block;">
        	<ul class="nygl" >
            	<c:forEach items="${fns:listMenu(id)}" var="cl">
<%--  --%>
         		<shiro:hasPermission name="${cl.perssioncode}">
         		 
	                	<li class="<c:if test='${menuid==cl.menuid }'>nav_sele${fn:length(cl.menuname)} nav_selectli</c:if>" 
	                			img="<c:url value='${cl.icon }'/>" hoverimg="<c:url value='${cl.iconhover }'/>">
	                	
	                		<%--?id=${id} 数据库路径存了id   --%>
	                		<a href="<c:url value='${cl.accessurl}'/>">
	                			<span class="nav_sepleft"></span>
	                			<span class="ico" style="background-image: url('<c:url value="${cl.icon }" />')"></span>
	                			<span class="txt">${cl.menuname}</span>
	                			<span  class="nav_seprigt"></span>
	                		</a>
	                	</li>
<%-- --%> 
	           	</shiro:hasPermission>
	           		
	        	</c:forEach>
	        </ul>
        </div>
		
        <div class="down-popup fr">
            ${loginUser.userShowName }
                            <div class="arr-group">
                            </div>
            <div class="list">

                <ul>
                    <li><a id="toUpdateCurrentUserBtn" class="a fancybox" href="#pop-onupdateCurrentUser">修改信息</a></li>
                    <li><a href="<c:url value='/logout' />">安全退出</a></li>
                </ul>
            </div>
        </div>
	
	<input id="sepleft" type="hidden" value="<c:url value='/resources/img/menu-left.png' />"/>
	<input id="seprigt" type="hidden" value="<c:url value='/resources/img/menu-right.png' />"/>
    </div>
    
    
    <div class="mod-pop" id="pop-onupdateCurrentUser" style="height:auto;min-height: 350px;width: 360px;">
        <div class="hd">
            <h2>修改信息</h2>
        </div>
        <div class="bd">

        </div>
    </div>
    
<div id='background' class='background'></div>
<div id='progressBar' class='progressBar'><img src="<c:url value='/resources/img/loading4.gif'/>" /></div>
    