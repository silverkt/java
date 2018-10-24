<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(document).ready(function () {
elv = $("#elv").val();
var flg = true;
if(elv=="A"){$("input[name='groupid']").val("1");$("input[name='state']").val("1");}
$("#savebut",'#regionform').click(function(){
	var data = {}
	,submitFlag = true;
		$('#regionform').find("input").each(function(){
			var $this = $(this)
			, name = $this.attr("name")
			, type = $this.attr('type')
			, needs = $this.attr('needs')//配置了该属性的是非空的选项
			, value = $this.val()
			, msg = '';
			var $msg = type == 'hidden'?$this.parents('td').find('.inputerror'):$this.parent('td').find('.inputerror');
			if(value=='' && needs =='true'){
				msg = '请填写经济区名称';
				if(type=='hidden'){
					msg = ' * 必选项';
				}
				$msg.css({'display':'block'}).text(msg);
				submitFlag = false;
				return false;
			}else{//清空提示并绑定数据
				if(!flg){
					submitFlag = false;
					return false;
				}else{
					submitFlag = true;
					$msg.empty().css({'display':'none'});
					data[name] = value;
					return true;
				}
			}
		});
 	if(!submitFlag){return;}
 
 		$.ajax({type:"POST",data: data,
		url: "<c:url value='/projectmanagement/saveRegion' />",
		success: function(data){
			if(data=="true"){
				if(elv=="A"){jAlert("新增成功！");}else{jAlert("编辑成功！");}
				initTree();
				getValue($("#lastTreeClick").val(),0,elv);
				$.fancybox.close();
			}else{
				if(elv=="A"){jAlert("新增失败！");}else{jAlert("编辑失败！");}
			}
		},error:function(data){
			if(elv=="A"){jAlert("新增失败！");}else{jAlert("编辑失败！");}
		}
	});
});
closeFancybox();
if(elv=='V'){$("#pop-onupdate").simReadOnly();}
//add by Y 2015-01-27 begine
//验证名称是否重复
$("#regionname").on('blur',checkRegionname);
function checkRegionname(){
	var regionname = $("#regionname").val();
	var regionid = $("#regionid").val();
	var grioupid =$("#grioupid").val();
	regionname={'regionname':regionname,'regionid':regionid,'grioupid':grioupid};
	$.ajax({type:"POST",url: "<c:url value='/projectmanagement/checkRegionname' />",
		data:regionname,cache:false,
		success: function(data){
			if(data){
				$('.inputerror').attr('style', 'display:none');
				$("#regionnameError").text("经济区名称不能相同").show();
				flg=false;
			}else{
				flg=true;
				$("#regionnameError").hide();
			}
		}});
}
 //校验占地面积、人口、年均温度 、年均降水、年均日照为非数字型值     
 $("#regionform").find("input").each(function(){
	 var v = $(this);
	 var name = v.attr("name");
	 if(name == "sunshine" || name == "precipitation" || name == "avgtemp" || name == "people" || name == "area"){
		 v.blur(function(){
			 var value = v.val();
			 if(isNaN(value)){
				 v.siblings('.inputerror').css("display","block");flg=false;
			 }else{
				 v.siblings('.inputerror').css("display","none");flg=true;
			 }
		 });
	 }
 });
//add by Y 2015-01-27 end
});
</script>
<div class="hd">
	<h2>经济区信息</h2>
</div>
<div class="bd">
<form id="regionform">
<input type="hidden" name="regionid" id="regionid" value="${prinfo.regionid}" />
<input type="hidden" name="groupid" id="grioupid"  value="${prinfo.groupid}" />
<input type="hidden" name="state" value="${prinfo.state}" />
	<table>
		<tr>
			<td>
				<table class="tblnygl">
					<tr>
						<td class="tright w80">经济区名称：</td>
						<td width="280px ">
							<input type="text" name="regionname" needs="true" class="w186 ttxt txtt2" id="regionname"
								value="${prinfo.regionname}" />
							<div class="inputerror" id="regionnameError"></div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">行政级别&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="citycategory" class="w186 ttxt txtt2"
								value="${prinfo.citycategory}" />
							<div class="inputerror">请填写行政级别!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">地理位置&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="position" class="w186 ttxt txtt2"
								value="${prinfo.position}" />
							<div class="inputerror">请填写地理位置!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">气候条件&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="climate" class="w186 ttxt txtt2"
								value="${prinfo.climate}" />
							<div class="inputerror">请填写气候条件!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">面&nbsp;&nbsp;&nbsp;&nbsp;积&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="area" class="w186 ttxt txtt2"
								value="${prinfo.area}" maxlength="20" />
							<span>m²</span>
							<div class="inputerror" id="area">必须为数字类型</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">人&nbsp;&nbsp;&nbsp;&nbsp;口&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="people" class="w186 ttxt txtt2"
								value="${prinfo.people}" maxlength="20" />
							<div class="inputerror" id="people">必须为数字类型</div>
						</td>
					</tr>
				</table>
			</td>
			<td>
				<table class="tblnygl">
					<tr>
						<td class="tright w80">年均温度&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="avgtemp" class="w186 ttxt txtt2"
								value="${prinfo.avgtemp}" maxlength="20" />
							<span>℃</span>
							<div class="inputerror" id="avgtemp">必须为数字类型</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">年均降水&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="precipitation" class="w186 ttxt txtt2"
								value="${prinfo.precipitation}" maxlength="20" />
							<span>mm</span>
							<div class="inputerror" id="precipitation">必须为数字类型</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">年均日照&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="sunshine" class="w186 ttxt txtt2"
								value="${prinfo.sunshine}" maxlength="20" />
							<span>lux</span>
							<div class="inputerror" id="sunshine">必须为数字类型</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">能源资源&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="resour" class="w186 ttxt txtt2"
								value="${prinfo.resour}" />
							<div class="inputerror">请填写能源资源!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">能源主供&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="supply" class="w186 ttxt txtt2"
								value="${prinfo.supply}" />
							<div class="inputerror">请填写能源主供!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">备&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;：</td>
						<td width="280px ">
							<input type="text" name="remarks" class="w186 ttxt txtt2"
								value="${prinfo.remarks}" title="${prinfo.remarks}" maxlength="30" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div class="clear">
		<a title="Close" class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
		<a class="tck-save fr mt15" id="savebut">保存</a>
		<input type="hidden" id="elv" name="elv" value="${elv}">
	</div>
</form>
</div>
