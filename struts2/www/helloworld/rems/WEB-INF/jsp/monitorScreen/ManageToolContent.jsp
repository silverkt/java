<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>		
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#FFFFFF">
	<tr>
		<td width="6px"
			background="<c:url value='/resources/img/modeless/dialog_mlm.png'/>">&nbsp;</td>
		<td>
			<!--管理结束-->
			<div style=" width:360px; overflow-y:hidden; overflow-x:hidden;display:true">
				<div style=" width:360px; ">
					<table width="360" border="0" cellspacing="0" cellpadding="0"
						align="center">
						<tr>
							<td align="left" bgcolor="#FFFFFF" height="30px"><div
									class="tab-hd">
									<span class="tab-hd-con tab_current_con" id="tab_page"
										onClick="monitorTab('page')"> 页面管理 </span> <span
										class="tab-hd-con tab_hd_border" id="tab_equipwidget"
										onClick="monitorTab('equipwidget')"> 设备控件管理 </span> <span
										class="tab-hd-con tab_hd_border" id="tab_labelwidget"
										onClick="monitorTab('labelwidget')"> 表单控件管理 </span>
								</div></td>
						</tr>
						<tr>
							<td align="center">
								<div id="page" class="all_manage" style="display:block">
									<form id="pageform" name="pageform" action="" method="post"
										enctype="multipart/form-data">
										<input type="hidden" name="imgtype" id="imgtype" /> <input
											type="hidden" name="projectid" id="projectid" /> <input
											type="hidden" name="pageid" id="pageid" /> <input
											type="hidden" name="titleisshow" id="titleisshow"
											value=1 />
										<table width="350px" border="0" cellspacing="0"
											cellpadding="0" bgcolor="#FFFFFF"
											style="font-size:13px; margin-top:5px; margin-bottom:5px"
											class="border">
											<tr>
												<td height="5px" align="right" colspan="2"></td>
											</tr>
											<tr>
												<td height="25px" align="right" style="width:120px">项目列表：</td>
												<td align="left" style="width:230px"><select
													name="select_project" style="width:140px"
													onChange="initSelectPage(null);initSelectEqu();initEmptyPageText();"
													id="select_project">
														<option value="0">--请选择项目--</option>
												</select></td>
											</tr>
											<tr>
												<td height="25px" align="right">页面列表：</td>
												<td align="left"><select name="select_page"
													style="width:140px" id="select_page"
													onChange="initPageDisabled();initSelectEquWidget(null);initSelectMonitorWidget(null);">
														<option value="0">--请选择页面--</option>
												</select></td>
											</tr>
											<tr>
												<td height="35px" colspan="2" align="center"><input
													name="btn_create_page" type="button" value="新建页面"
													onClick="createPage();" class="long_btn" />&nbsp; <input
													name="btn_load_page" type="button" value="载入页面"
													onClick="loadPage();" class="long_btn" />&nbsp; <input
													name="btn_del_page" type="button" value="删除页面"
													onClick="deletePage();" class="long_btn" /></td>
											</tr>
										</table>
										<input type="text" style="width:140px;display:none"
											disabled="disabled" id="page_show_id" value="page_0" /> <input
											type="text" style="width:140px;display:none" value="1600"
											name="pagewidth" id="pagewidth" /> <input
											type="text" style="width:140px;display:none" value="1000"
											name="pageheight" id="pageheight" />
										<table width="350px" border="0" cellspacing="0"
											cellpadding="0" bgcolor="#FFFFFF"
											style="font-size:13px; margin-bottom:5px;" class="border">
											<tr>
												<td width="120px" height="5px" align="right" colspan="3"></td>
											</tr>
											<tr>
												<td class="td_1">供能季：</td>
												<td colspan="2" align="left">
												<select name="supplyseason"
													id="supplyseason" style="width:140px"
													class="page_init">
														<option value="0">不区分供能季</option>
														<option value="1">供冷季</option>
														<option value="2">供暖季</option>
												</select>
												</td>
											</tr>
											<tr>
												<td class="td_1">页面底图：</td>
												<td colspan="2">
													<div style="position:relative;width:230px;">
														<input type="text" style="width:140px" id="pageimage" title="底图推荐尺寸为1600*1000" name="pageimage" readonly value="请上传底图" class="page_init" />&nbsp; 
													    <input type='button' value='浏览' title="底图推荐尺寸为1600*1000" class="page_init upload_btn" /> 
														<input type="file" name="imgupload" id="imgupload" style="position:absolute; top:2; left:0px;width:185px;filter:alpha(opacity=50);-moz-opacity:0;-khtml-opacity: 0;opacity: 0;" size="14" onChange="document.getElementById('pageimage').value=this.value" title="底图推荐尺寸为1600*1000" class="page_init" /> 
														<input type="button" name="uploadimg" value="上传" onClick="uploadPageImg();" class="page_init upload_btn" />
													</div>
												</td>
											<tr>
												<td class="td_1">底图x轴坐标：</td>
												<td class="td_2"><input type="text"
													style="width:140px" name="pgimagex" id="pgimagex"
													value="0" onBlur="checkInteger(this.value,this.id);"
													title="必须为整数" class="page_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000;font-size:11px; display:none"
													id="alert_pgimagex" class="page_alert">必为整数</span></td>
											</tr>
											<tr>
												<td class="td_1">底图y轴坐标：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="pgimagey" id="pgimagey" value="0"
													onBlur="checkInteger(this.value,this.id);" title="必须为整数"
													class="page_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_pgimagey" class="page_alert">必为整数</span></td>
											</tr>
											<tr>
												<td class="td_1">底图位置微调：</td>
												<td colspan="2" align="left"><input name="left"
													type="button" value="左" disabled="disabled"
													class="class_pgima_adjust short_btn"
													onClick="pgimgAdjust('left');" title="向左调整2px" /> <input
													name="right" type="button" value="右" disabled="disabled"
													class="class_pgima_adjust short_btn"
													onClick="pgimgAdjust('right');" title="向右调整2px" /> <input
													name="up" type="button" value="上" disabled="disabled"
													class="class_pgima_adjust short_btn"
													onClick="pgimgAdjust('up');" title="向上调整2px" /> <input
													name="down" type="button" value="下" disabled="disabled"
													class="class_pgima_adjust short_btn"
													onClick="pgimgAdjust('down');" title="向下调整2px" /></td>
											</tr>
											<tr>
												<td class="td_1">页面标题：</td>
												<td class="td_2"><input name="title" id="title" type="text"
													style="width:140px" title="必填,且同项目下页面标题不可重复"
													onBlur="checkTitle(this.value,this.id);" value="请输入标题"
													class="page_init" maxlength=20/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_title" class="page_alert">标题重复</span></td>
											</tr>
											<tr>
												<td class="td_1">是否显示标题：</td>
												<td colspan="2" align="left"><input
													name="title_show" id="title_show" type="checkbox"
													checked="checked" onClick="isTitleShow();"
													class="page_init" /></td>
											</tr>
											<tr>
												<td class="td_1">标题X轴坐标：</td>
												<td class="td_2"><input type="text" style="width:140px"
													class="class_title_show page_init" name="titlex"
													id="titlex" value="500" maxlength=10
													onBlur="checkInteger(this.value,this.id);" title="必须为整数" /></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_titlex" class="page_alert">必为整数</span></td>
											</tr>
											<tr>
												<td class="td_1">标题Y轴坐标：</td>
												<td class="td_2"><input type="text" style="width:140px"
													class="class_title_show page_init" name="titley"
													id="titley" value="20" maxlength=10
													onBlur="checkInteger(this.value,this.id);" title="必须为整数" /></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_titley" class="page_alert">必为整数</span></td>
											</tr>
											<tr>
												<td class="td_1">标题字体尺寸：</td>
												<td colspan="2" align="left"><select name="fontsize"
													id="fontsize" style="width:140px"
													class="class_title_show page_init">
														<option value="20">20px</option>
														<option value="22">22px</option>
														<option value="24">24px</option>
														<option value="26">26px</option>
														<option value="28">28px</option>
														<option value="30">30px</option>
												</select></td>
											</tr>
											<tr>
												<td class="td_1">标题字体颜色：</td>
												<td colspan="2" align="left"><input name="fontcolor"
													id="fontcolor" type="text"
													style='width:140px;cursor:hand;10px;color:#000000;'
													onClick="pickColor('fontcolor')" value="#000000"
													class="class_title_show page_init"  maxlength=10/></td>
											</tr>
											<tr>
												<td class="td_1">标题框宽度：</td>
												<td class="td_2"><input type="text" style="width:140px"
													class="class_title_show page_init" name="titlewidth"
													id="titlewidth" value="300" maxlength=10
													onBlur="checkPositiveInteger(this.value,this.id);"
													title="必须为正整数" /></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_titlewidth" class="page_alert">必为正整数</span></td>
											</tr>
											<tr>
												<td class="td_1">标题框高度：</td>
												<td class="td_2"><input type="text" style="width:140px"
													class="class_title_show page_init" name="titleheight"
													id="titleheight" value="80" maxlength=10
													onBlur="checkPositiveInteger(this.value,this.id);"
													title="必须为正整数" /></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_titleheight" class="page_alert">必为正整数</span></td>
											</tr>
											<tr>
												<td class="td_1">标题框背景颜色：</td>
												<td colspan="2" align="left"><input
													name="titlebgcolor" id="titlebgcolor" type="text"
													style='width:140px;cursor:hand;10px;color:#000000;'
													onClick="pickColor('titlebgcolor')" value="#FFFFFF" maxlength=10
													class="class_title_show page_init" /></td>
												<!--onBlur="this.style.backgroundColor=this.value;window.color=this.value.replace('#','');"-->
											</tr>
											<tr>
												<td class="td_1">标题框边框颜色：</td>
												<td colspan="2" align="left"><input
													name="titlebordercolor" id="titlebordercolor"
													type="text"
													style='width:140px;cursor:hand;10px;color:#000000;'
													onClick="pickColor('titlebordercolor')" value="#FFFFFF" maxlength=10
													class="class_title_show page_init" /></td>
											</tr>
											<tr>
												<td class="td_1">标题位置微调：</td>
												<td colspan="2" align="left"><input name="left"
													type="button" value="左" disabled="disabled"
													class="class_title_adjust short_btn"
													onClick="titleAdjust('left');" title="向左调整2px" /> <input
													name="right" type="button" value="右" disabled="disabled"
													class="class_title_adjust short_btn"
													onClick="titleAdjust('right');" title="向右调整2px" /> <input
													name="up" type="button" value="上" disabled="disabled"
													class="class_title_adjust short_btn"
													onClick="titleAdjust('up');" title="向上调整2px" /> <input
													name="down" type="button" value="下" disabled="disabled"
													class="class_title_adjust short_btn"
													onClick="titleAdjust('down');" title="向下调整2px" /></td>
											</tr>
											<tr>
												<td class="td_1">是否显示属性名：</td>
												<td colspan="2" align="left">
												<select name="showproperty"
													id="showproperty" style="width:140px"
													class="page_init">
														<option value="0">显示属性名</option>
														<option value="1">不显示属性名</option>
												</select>
												</td>
											</tr>
											<tr>
												<td class="td_1">是否置顶：</td>
												<td colspan="2" align="left">
												<select name="isdefault"
													id="isdefault" style="width:140px"
													class="page_init">
														<option value="1">常规</option>
														<option value="0">置顶</option>
												</select>
												</td>
											</tr>
											<tr>
												<td class="td_1">是否启用页面：</td>
												<td colspan="2" align="left">
												<select name="flag"
													id="flag" style="width:140px"
													class="page_init">
														<option value="0">启用</option>
														<option value="1">停用</option>
												</select>
												</td>
											</tr>
											<tr>
												<td colspan="3" align="center" height="30px"><input
													name="btn_view_page" id="btn_view_page" type="button"
													value="预览页面" onClick="viewPage();"
													class="long_btn page_control_btn" disabled="disabled" />
													&nbsp;&nbsp;&nbsp;&nbsp; <input name="btn_submit_page"
													id="btn_submit_page" type="button" value="提交数据"
													onClick="submitPageData();"
													class="long_btn page_control_btn" disabled="disabled" /></td>
											</tr>
										</table>
									</form>
								</div> <!--在某一底页上建立，隐藏字段包括：页面id、项目id-->
								<div id="equipwidget" class="all_manage" style="display:none">
									<form id="equform" name="equform" action="" method="post">
										<input type="hidden" name="projectid" id="projectid_equ" />
										<input type="hidden" name="pageid" id="pageid_equ" /> 
										<input type="hidden" name="widgetid" id="equwidgetid" />
										<table width="350px" border="0" cellspacing="0"
											cellpadding="0" bgcolor="#FFFFFF"
											style="font-size:13px;margin-top:5px" class="border">
											<tr>
												<td width="130px" height="5px" align="right" colspan="2"></td>
											</tr>
											<tr>
												<td width="130" height="25px" align="right">设备控件列表：</td>
												<td align="left"><select 
													style="width:140px" id="select_equ_widget"
													onChange="loadEquWidget(this.value);"
													class="equ_manage_btn">
														<option value="0">--请选择设备控件--</option>
												</select></td>
											</tr>
											<tr>
												<td height="35px" colspan="2" align="center"><input
													name="btn_create_equ" type="button" value="新建控件"
													class="equ_manage_btn long_btn"
													onClick="createEquWidget();" disabled="disabled" />&nbsp;&nbsp;&nbsp;&nbsp;
													<input name="btn_delete_equ" type="button" value="删除控件"
													class="equ_manage_btn long_btn"
													onClick="deleteEquWidget();" disabled="disabled" /></td>
											</tr>
										</table>
										<table width="350px" border="0" cellspacing="0"
											cellpadding="0" bgcolor="#FFFFFF"
											style="font-size:13px; margin-bottom:5px; margin-top:5px"
											class="border">
											<tr>
												<td height="5px" align="right" colspan="3"></td>
											</tr>
											<tr style="display:none">
												<td width="130" height="25px" align="right">设备控件编号：</td>
												<td colspan="2"><input name="equ_show_id"
													type="text" disabled="disabled" id="equ_show_id"
													style="width:140px" value="equ_widget_0" /></td>
											</tr>
											<tr>
												<td class="td_1">控件绑定设备：</td>
												<td class="td_2"><select name="classinstanceid" id="equid"
													style="width:140px"
													onChange="initEquTitle();initEquImgSize(null,null);<!-- checkEquID(this.value); -->"
													class="classinstanceid equ_init">
														<option value="0">--请选择设备--</option>
												</select></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_equ_id" class="equ_alert">设备重复</span></td>
											</tr>
											<tr>
												<td class="td_1">设备控件标题：</td>
												<td class="td_2"><input name="title" id="equtitle"
													type="text" style="width:140px" title="必填,且同页面下设备标题不可重复"
													onBlur="checkEquTitle(this.value);" value="请输入标题"
													class="equ_init" maxlength=15/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_equ_title" class="equ_alert">标题重复</span></td>
											</tr>
											<tr>
												<td class="td_1">标题使用设备名：</td>
												<td colspan="2" align="left"><input type="checkbox"
													id="equal_equ_title"
													onClick="initEquTitle();" class="equ_init"
													checked="checked" /></td>
											</tr>
											<tr>
												<td class="td_1">X轴坐标：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="x" id="equx"
													onBlur="checkPositiveInteger(this.value,this.id);"
													value="100" class="equ_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_equx" class="equ_alert">必为正整数</span></td>
											</tr>
											<tr>
												<td class="td_1">Y轴坐标：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="y" id="equy"
													onBlur="checkPositiveInteger(this.value,this.id);"
													value="100" class="equ_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_equy" class="equ_alert">必为正整数</span></td>
											</tr>
	
											<tr>
												<td class="td_1">宽度：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="width" id="equwidth"
													onBlur="checkPositiveInteger(this.value,this.id);computeImgSize('w');"
													value="100" class="equ_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_equwidth" class="equ_alert">必为正整数</span></td>
											</tr>
											<tr>
												<td class="td_1">高度：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="height" id="equheight"
													onBlur="checkPositiveInteger(this.value,this.id);computeImgSize('h');"
													value="100" class="equ_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px; display:none"
													id="alert_equheight" class="equ_alert">必为正整数</span></td>
											</tr>
											<tr>
												<td class="td_1">是否响应点击事件：</td>
												<td colspan="2" align="left"><input type="checkbox"
													id="equ_click" checked="checked"
													onClick="isEquClick(null);" class="equ_init" /> <input
													type="hidden" name="isclick" id="equisclick"
													value="1" /></td>
											</tr>
											<tr>
												<td class="td_1">是否显示设备控件：</td>
												<td colspan="2" align="left"><input type="checkbox"
													id="equ_show" checked="checked"
													onClick="isEquShow(null);" class="equ_init" /> <input
													type="hidden" name="isshow" id="equisshow" value="1" />
												</td>
											</tr>
											<tr>
												<td class="td_1">是否显示启停：</td>
												<td colspan="2" align="left">
												<select name="ison"
													id="ison" style="width:140px"
													class="equ_init">
														<option value="0">显示启停状态</option>
														<option value="1">不显示启停状态</option>
												</select>
												</td>
											</tr>
											<tr>
												<td class="td_1">控件位置微调：</td>
												<td colspan="2" align="left"><input name="left" type="button"
													value="左" disabled="disabled"
													class="class_equ_adjust short_btn"
													onClick="equAdjust('left');" title="向左调整1px" /> <input
													name="right" type="button" value="右" disabled="disabled"
													class="class_equ_adjust short_btn"
													onClick="equAdjust('right');" title="向右调整1px" /> <input
													name="up" type="button" value="上" disabled="disabled"
													class="class_equ_adjust short_btn"
													onClick="equAdjust('up');" title="向上调整1px" /> <input
													name="down" type="button" value="下" disabled="disabled"
													class="class_equ_adjust short_btn"
													onClick="equAdjust('down');" title="向下调整1px" /></td>
											</tr>
											<tr>
												<td colspan="3" align="center" height="40px"><input
													name="btn_view_equ" type="button" id="btn_view_equ"
													value="预览控件" class="equ_control_btn long_btn"
													onClick="viewEquWidget();" disabled="disabled" />
													&nbsp;&nbsp;&nbsp;&nbsp;<input name="btn_submit_equ"
													type="button" value="提交数据"
													class="equ_control_btn long_btn"
													onClick="submitEquWidget();" disabled="disabled" /></td>
											</tr>
										</table>
									</form>
								</div>
								<div id="labelwidget" class="all_manage" style="display:none">
									<form id="labelform" name="labelform" action=""
										method="post">
										<input type="hidden" name="projectid" id="projectid_label" />
										<input type="hidden" name="pageid" id="pageid_label" /> <input
											type="hidden" name="widgetid" id="labelwidgetid" /> <input
											type="hidden" name="properties" id="properties"> <input
											type="hidden" name="units" id="units">
										<table width="350px" border="0" cellspacing="0"
											cellpadding="0" bgcolor="#FFFFFF"
											style="font-size:13px;margin-top:5px" class="border">
											<tr>
												<td width="120px" height="5px" align="right" colspan="2"></td>
											</tr>
											<tr>
												<td width="120" height="25px" align="right">控件列表：</td>
												<td align="left"><select name="select_monitor_widget"
													style="width:140px" id="select_monitor_widget"
													onChange="loadLabel(this.value);"
													class="label_manage_btn">
														<option value="0">--请选择表单控件--</option>
												</select></td>
											</tr>
											<tr>
												<td height="35px" colspan="2" align="center"><input
													name="btn_create_label" type="button" value="新建控件"
													class="label_manage_btn long_btn"
													onClick="createLabel();" disabled="disabled" />&nbsp;&nbsp;&nbsp;&nbsp;
													<input name="btn_delete_label" type="button"
													value="删除控件" class="label_manage_btn long_btn"
													onClick="deleteLabel();" disabled="disabled" /></td>
											</tr>
										</table>
										<table width="350px" border="0" cellspacing="0"
											cellpadding="0" bgcolor="#FFFFFF"
											style="font-size:13px; margin-bottom:5px; margin-top:5px"
											class="border">
											<tr>
												<td height="5px" align="right" colspan="3"></td>
											</tr>
											<tr style="display:none">
												<td width="120px" height="25px" align="right">表单控件编号：</td>
												<td colspan="2" width="230px"><input type="text"
													style="width:140px" disabled="disabled"
													value="monitor_widget_0" id="label_show_id" /></td>
											</tr>
											<tr>
												<td class="td_1">控件绑定设备：</td>
												<td class="td_2"><select name="classinstanceid"
													id="classinstanceid" style="width:140px"
													class="label_init classinstanceid"
													onChange="initEquProperty(this.value,null,null);initLabelTitle();">
														<option value="0">--请选择设备--</option>
												</select></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_label_instid" class="label_alert">设备重复</span></td>
											</tr>
											<tr>
												<td class="td_1">表单控件标题：</td>
												<td class="td_2"><input name="title" id="labeltitle"
													type="text" style="width:140px" title="必填,且同页面下表单标题不可重复"
													onChange="checkLabelTitle(this.value);" value="请输入标题"
													class="label_init" maxlength=20/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_label_title" class="label_alert">标题重复</span></td>
											</tr>
											<tr>
												<td class="td_1">标题使用设备名：</td>
												<td colspan="2" align="left"><input type="checkbox"
													 id="equal_label_title"
													onClick="initLabelTitle();" class="label_init"
													checked="checked" /></td>
											</tr>
	
											<tr>
												<td class="td_1">添加监测属性：</td>
												<td class="td_2"><select name="equ_property" id="equ_property"
													style="width:140px" class="label_init">
														<option value="0">--请选择设备属性--</option>
												</select></td>
												<td class="td_3">&nbsp;<input name="btn_add"
													type="button" value="添加" onClick="addProperties();"
													class="label_init add_btn" /></td>
											</tr>
											<tr>
												<td align="right" style="min-height:25px; height:25px">监测属性列表：</td>
												<td colspan="2" align="left">
													<table width="220px" border="0" cellspacing="0"
														cellpadding="0"
														style="font-size:13px; background-color:#FFFFFF; border:1px solid #7F9DB9">
														<tbody id="show_properties"></tbody>
													</table>
												</td>
											</tr>
											<tr>
												<td class="td_1">X轴坐标：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="x" id="labelx"
													onBlur="checkPositiveInteger(this.value,this.id);"
													value="100" class="label_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_labelx" class="label_alert">必为正整数</span></td>
											</tr>
											<tr>
												<td class="td_1">Y轴坐标：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="y" id="labely"
													onBlur="checkPositiveInteger(this.value,this.id);"
													value="100" class="label_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_labely" class="label_alert">必为正整数</span></td>
											</tr>
	
											<tr>
												<td class="td_1">宽度：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="width" id="labelwidth"
													onBlur="checkPositiveInteger(this.value,this.id);"
													value="150" class="label_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_labelwidth" class="label_alert">必为正整数</span></td>
											</tr>
											<tr>
												<td class="td_1">高度：</td>
												<td class="td_2"><input type="text" style="width:140px"
													name="height" id="labelheight"
													onBlur="checkPositiveInteger(this.value,this.id);"
													value="80" class="label_init" maxlength=10/></td>
												<td class="td_3"><span
													style="color:#FF0000; font-size:11px;display:none"
													id="alert_labelheight" class="label_alert">必为正整数</span></td>
											</tr>
											<tr>
												<td class="td_1">字体尺寸：</td>
												<td colspan="2" align="left"><select name="fontsize"
													id="labelfontsize" style="width:140px"
													class="label_init">
														<option value="10">10px</option>
														<option value="11" selected="selected">11px</option>
														<option value="12">12px</option>
														<option value="13">13px</option>
														<option value="14">14px</option>
												</select></td>
											</tr>
											<tr>
												<td class="td_1">字体颜色：</td>
												<td colspan="2" align="left"><input name="fontcolor"
													type="text"
													style='width:140px;cursor:hand;10px;color:#000000;'
													id='labelfontcolor'
													onClick="pickColor('labelfontcolor')" value="#000000"
													class="label_init" maxlength=10/></td>
											</tr>
											<tr>
												<td class="td_1">是否显示控件：</td>
												<td colspan="2" align="left"><input type="checkbox"
													id="label_show" checked="checked"
													onClick="isLabelShow(null);" class="label_init" /> <input
													type="hidden" name="isshow" id="labelisshow"
													value="1" /></td>
											</tr>
											<tr>
												<td class="td_1">位置微调：</td>
												<td colspan="2" align="left"><input name="left" type="button"
													value="左" disabled="disabled"
													class="class_label_adjust short_btn"
													onClick="labelAdjust('left');" title="向左调整1px" /> <input
													name="right" type="button" value="右" disabled="disabled"
													class="class_label_adjust short_btn"
													onClick="labelAdjust('right');" title="向右调整1px" /> <input
													name="up" type="button" value="上" disabled="disabled"
													class="class_label_adjust short_btn"
													onClick="labelAdjust('up');" title="向上调整1px" /> <input
													name="down" type="button" value="下" disabled="disabled"
													class="class_label_adjust short_btn"
													onClick="labelAdjust('down');" title="向下调整1px" /></td>
											</tr>
											<tr>
												<td colspan="3" align="center" height="40px"><input
													name="btn_view_label" type="button" id="btn_view_label"
													value="预览控件" class="label_control_btn long_btn"
													onClick="viewLabel();" disabled="disabled" />
													&nbsp;&nbsp;&nbsp;&nbsp; <input name="btn_submit_label"
													type="button" id="btn_submit_label" value="提交数据"
													class="label_control_btn long_btn"
													onClick="submitLabel();" disabled="disabled" /></td>
											</tr>
										</table>
									</form>
								</div>
							</td>
						</tr>
					</table>
									</div>
			</div> <!--管理结束-->
		</td>
		<td width="6px"
			background="<c:url value='/resources/img/modeless/dialog_mrm.png'/>">&nbsp;</td>
	</tr>
	<tr>
		<td width="6px" height="6px"
			background="<c:url value='/resources/img/modeless/dialog_lb.png'/>"></td>
		<td
			background="<c:url value='/resources/img/modeless/dialog_cb.png'/>"></td>
		<td width="6px"
			background="<c:url value='/resources/img/modeless/dialog_rb.png'/>"></td>
	</tr>
</table>
</body>
</html>
