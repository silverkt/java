<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script>
$(function(){
	 var scrH=$(window).height()- 130;
	$("#LeftCol .left-nav").css("height",scrH);
})
</script>
<div class="left-nav left-nav3 tab">
<style>
.left-nav .tab-nav ul{}
.left-nav .tab-nav ul li{float:left;height:30px;margin-right:-1px;}
.left-nav .tab-nav ul li a{width:112px;text-align:center;color:#fff;float:left;height:30px;line-height:30px;background:url(../resources/img/tab-navli.png) right center no-repeat;}
.left-nav .tab-nav ul li.last a{background:none;}
.left-nav .tab-nav ul li.on a{color:#5b636c;background:url(<c:url value='/resources/img/leftnav-libg2.png' />) center top no-repeat;}

</style>
    <div class="left-in">
        <div class="tab-nav">
            <ul>
                <li val="0" class="on"><a>系统能源成本</a></li>
                <li  val="1" class="last"><a>设备能源成本</a></li> 
            </ul>
        </div>
                    <div id="tab1" class="tab-panel" style="display: block;">
            <div class="nyfx-item noClear">
                <div class="item-txt">
                <c:forEach var="c" items="${sys}">
                	<p><label><input type="radio" name="property" value="${c.classpropertyid }"/>${c.classpropertyname }</label></p>
                </c:forEach>
                </div>
            </div>
        </div>
        <div  id="tab2"  class="tab-panel">
             <div class="nyfx-item noClear">
                <div class="item-txt">
                	<c:forEach var="i" items="${instances}">
                		<p><label><input type="radio" name="instance" value="${i.classinstanceid }" />${i.classinstancename }</label></p>
                	</c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>