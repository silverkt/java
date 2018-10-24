﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script>
	$(function(){
		var $trs = $('.datalist-div table.datalist tbody tr');
		$trs.each(function(){
			var td0 = $(this).children('td').eq(0);
			var td3 = $(this).children('td').eq(3);
			td0.attr("title",td0.text());
			td3.attr("title",td3.text());
		});
	});
</script>
<div class="datalist-div" style="border-left: none;">
    <table class="datalist nxfx_sbnx">
        <thead>
            <tr style="height:30px; overflow:hidden;">
            	<td class="proinfo-no">序号</td>
                <td>项目名称</td>
                <td>建筑面积</td>
                <td>供能面积</td>
                <td>运营商</td>
                <td>供冷期</td>
                <td>供热期</td>
                <td>操作</td>
            </tr>
        </thead>
        <tbody>
        
        <c:forEach var="proinfo" items="${projectbaseinfoList}" varStatus="s">
            <tr class="${s.index%2 eq 0 ? 'even' : 'odd'}">
            	<td>${s.index+1}</td>
                <td class="ellipsis w10em">${proinfo.projectname }</td>
                <td><c:if test="${empty proinfo.buildingarea}">-</c:if>${proinfo.buildingarea}</td>
                <td><c:if test="${empty proinfo.supplyarea}">-</c:if>${proinfo.supplyarea}</td>
                <td class="ellipsis e10em"><c:if test="${empty proinfo.carrieroperator}">-</c:if>${proinfo.carrieroperator}</td>
                <td>${proinfo.coldingstart }-${proinfo.coldingend }</td>
                <td>${proinfo.heatingstart }-${proinfo.heatingend }</td>
                <td>
                <!--0.视图查看    1.基础信息     2.自定义信息   3.设计负荷  -->
                <shiro:hasPermission name="projectmanagement:prodelete">
                	<a class="xml_del" title="删除" onclick="del('${proinfo.projectid }');"></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="projectmanagement:proupdate">
                	<a class="xml_edite fancybox" title="基础信息" href="#pop-onupdate" onclick="edit('${proinfo.projectid }','E','1');"></a>
                </shiro:hasPermission>
				<shiro:hasPermission name="projectmanagement:proupdate">
                	<a class="design-load global-icon fancybox region-list-op" title="设计负荷" href="#pop-onupdate" onclick="edit('${proinfo.projectid }','E','3');"></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="projectmanagement:proupdate">
                	<a class="user-defined global-icon fancybox region-list-op" href="#pop-onupdate" title="自定义信息" onclick="edit('${proinfo.projectid }','E','2');"></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="projectmanagement:proinfo">
                	<a class="magnifier global-icon fancybox region-list-op" title="查看" href="#pop-onupdate" onclick="edit('${proinfo.projectid }','V','0');"></a>
                </shiro:hasPermission>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>