﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<div class="tblcomhead" style="height: 30px; border-top: 1px solid #E5E5E5; border-bottom: 1px solid #B5B5B5; margin-top: 1px;">
    <style>.datalist2 thead tr td {border-bottom: none;}</style>
    <table width="100%">
        <tr>
            <td style="text-align: left; width: 300px;">
                <ul class="xmpm_tab">
                    <li class="xmpm_tabsel" val="0">年</li>
					<li val="1">月</li>
					<li val="2">日</li>
                </ul>
            </td>
            <td class="tleft" style="text-align: right;">
                <div style="width:90px;height:30px;float:right;position: relative;">
                	<span id="datenow" style="font-size: 12px;float: right; background: url(<c:url value='/resources/img/iconcalender.png' />) no-repeat; padding-right: 23px; margin-right: 10px; background-position: right center; color: #fff; font-weight: bold; display: block; height: 30px; line-height: 30px;">
                		${year }</span>
	           		<div class="filterdiv" style=" float:left;width: 100px; height: 22px;position:absolute; top: 30px; display: block; margin-right:-20px;">
		               	<input type="text" value="${year }" style="display: block;" onchange="On_StartDateChange1(this)" id="txtSeYear" onfocus="WdatePicker({dateFmt:'yyyy'})" class="Wdate" />
		               	<input type="text" value="${month }" onchange="On_StartDateChange1(this)" id="txtSeMon" onfocus="WdatePicker({dateFmt:'yyyy/MM'})" class="Wdate" />
		               	<input type="text" value="${day }" onchange="On_StartDateChange1(this)"  id="txtSeDay" onfocus="WdatePicker({dateFmt:'yyyy/MM/dd'})" class="Wdate"/>
	           		</div>
           		</div>
            </td>
        </tr>
    </table>
</div>
<table class="datalist nxfx_sbnx datalist2 fnzpm_datalist" id="lbbuttable">
    <thead>
        <tr>
            <td style="width: 50px; border-right: solid 1px #ccc;">序号</td>
            <td style="width: 200px; border-right: solid 1px #ccc;">泛能站名称</td>
            <c:forEach items="${map.p}" var="p" varStatus="s">
            	<td style="min-width:99px;">
	            	<span style="padding-left: 5px;">${p.classpropertyname }(${p.unitname })</span></td>
	            <td  style="border-right: solid 1px #ccc; text-align: right;min-width:45px;width:45px;">	
	           
	            <div  ><span class="updown" style="margin-top: -2px; float:right;display: inline; " pid="${p.classpropertyid }">
	            		<a class="up ${s.index eq 0 ? 'upsel' : '' }" title="正序排名"></a><a class="down" title="倒序排名"></a>
	            	</span>
	            	</div>	
	            	 <span style=" float: right;display: inline;margin-top: 5px;margin-right:5px;">名次</span> 
            	</td>
            </c:forEach>
        </tr>
    </thead>
    <tbody>
    	<jsp:include page="table1.jsp"></jsp:include>
	</tbody>
</table>