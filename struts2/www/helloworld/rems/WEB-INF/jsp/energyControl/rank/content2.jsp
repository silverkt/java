﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<div class="fnzpm_td_cont" style="margin-bottom: 15px;">
	<div class="tblcomhead fnzpm_head">
		<span>${pro.classpropertyname }(${pro.unitname })排名</span>
		<input type="hidden" id="pro" value="${pro.classpropertyid }">
		<ul class="xmpm_tab" style="float: right;">
			<li class="${type eq 0 ? 'xmpm_tabsel' : '' }" val="0">年</li>
			<li class="${type eq 1 ? 'xmpm_tabsel' : '' }" val="1">月</li>
			<li class="${type eq 2 ? 'xmpm_tabsel' : '' }" val="2">日</li>
		</ul>
	</div>
	<div class="fnzpm_canl">
		<span id="datenow" class="datenow" style="">${date }</span>
		<a class="fancybox" href="#pop-onupdate">更多>></a>
	</div>
	<div class="filterdiv">
		<input type="text" style="" value="${year }" onchange="On_StartDateChange(this);" onfocus="WdatePicker({dateFmt:'yyyy'})" class="Wdate txtSeYear" />
		<input type="text" style="" value="${month }" onchange="On_StartDateChange(this);" onfocus="WdatePicker({dateFmt:'yyyy/MM'})" class="Wdate txtSeMon" />
		<input type="text" style="" value="${day }"  onchange="On_StartDateChange(this)" onfocus="WdatePicker({dateFmt:'yyyy/MM/dd'})" class="Wdate txtSeDay" />
	</div>
	<table class="fnzpm_innertbl datalist fnzpm_datalist">
		<jsp:include page="table2.jsp"></jsp:include>
	</table>
</div>
