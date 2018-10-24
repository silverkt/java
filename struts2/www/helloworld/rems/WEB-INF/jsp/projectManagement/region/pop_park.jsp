<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<style type="text/css">
	.xmgl_selct{width:161px;}
</style>
<script type="text/javascript">
 elv = $("#elv").val();
 $(document).ready(function () {
$("#savebut").on("click",save);
 if(elv=="A"){$("input[name='regionid']").val($("#clickRegion").val());$("input[name='groupid']").val('${groupid}');$("input[name='state']").val("1");}
$('#dpfSelId').simSelect({
		callback: function (x,v) {
		if(v){
			$("#parkform_err").hide();
		}
		if(!x) return;
			$(this).find("input").val(v);
		}
    });
    $('#dptSelId').simSelect({
		callback: function (x,v) {
		if(v){
			$("#parktype_err").hide();
		}
		if(!x) return;
			$(this).find("input").val(v);
		}
    });
    $('#pprSelId').simSelect({
		callback: function (x,v) {
		if(v){
			$("#parkregion_err").hide();
		}
		if(!x) return;
			$(this).find("input").val(v);
		}
    });
    closeFancybox();
	if(elv=='V'){$("#pop-onupdate").simReadOnly();}
	
	 //验证园区名称是否重复
	 $("#parkname",'#parkform').on('blur',checkParkname);
	 $("#parkname",'#parkform').focus();
	 
	 $("input[name='remarks']").change(function(){
		 var $this = $(this);
		 $this.attr("title",$this.val());
	  });
});
function checkParkname(){
	var parkname = $("#parkname").val();
	//var parkid = $("#parkid").val();
	var regionid = $("#regionid").val();
	var $msg = $("#parkname").siblings('.inputerror');
	var flag = false;
	var chkData = null;
	chkData = {'parkname':parkname.trim(),'regionid':regionid,'parkid':"${ppinfo.parkid}"};

		$.ajax({type:"POST",url: "<c:url value='/projectmanagement/checkParkName' />",
		data:chkData,cache:false,
		success: function(data){
			if(data){
				$msg.text('园区名称不能相同').show();
				//$("#savebut").off("click",save);
			}else{
				$msg.hide();
				//$("#savebut").on("click",save);
			}
		},error:function(){
			$msg.text('验证有误,请重新验证').show();
			//$("#savebut").off("click",save);
		}});
	
}
function save(){
	//console.log('save');
	//非空验证 2015年1月28日10:17:41 金尚彬
	if($("#parkname").val().trim() == ''){
		$("#parkname").siblings('.inputerror').text('请填写园区名称').show();
		return false;
	}
	//非法提示显示验证，如有非法提示存在时，save终止 
	if($("#parkname").siblings('.inputerror').css('display')!='none'){
		return;
	}
	var data = {}
	, commitFlag = true;
	$('#parkform').find("input").each(function(n,input){
		var $this = $(input)
		, name = $this.attr("name")
		, type = $this.attr('type')
		, chktype = $this.data('chk')
		, value = $this.val()
		, msg = '';
		var $msg = (type=='hidden')||(type=='text') ? $this.parent('.mod-select').siblings('.inputerror') : $this.siblings('.inputerror');
		$msg.hide();
		/*if(chktype == 'needs'){
			if(value == ''){
				$msg.show();
				commitFlag = false;
				return false;
			}else{
				data[name] = value;
			}
		}else */
		if(chktype == 'number'){
			if( value != '' && isNaN(value)){
				$msg.show();
				commitFlag = false;
				return false;
			}else{
				data[name] = value;
			}
		}else{
			data[name] = value;
		}
	});
	if(!commitFlag){return;}else{
		$.ajax({type:"POST",data: data,cache:false,
			url: "<c:url value='/projectmanagement/savePark' />",
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
	}
}
$("#parkform").find("input").each(function(){
	 var v = $(this);
	 var name = v.attr("name");
	 if(name == 'stationnumber' || name == 'supplyarea' || name == 'actualarea' || name == 'investment' || name == 'coverarea'){
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
</script>
<div class="hd">
	<h2>园区信息</h2>
</div>
<div class="bd">
<form id="parkform">
<input type="hidden" name="parkid" id="parkid" value="${ppinfo.parkid}" />
<input type="hidden" name="regionid" id="regionid" value="${ppinfo.regionid}" />
<input type="hidden" name="groupid" value="${ppinfo.groupid}" />
<input type="hidden" name="state" value="${ppinfo.state}" />
	<table>
		<tr>
			<td>
				<table class="tblnygl">
					<tr>
						<td class="tright w80">园区名称：</td>
						<td width="280px ">
							<input id="parkname" type="text" name="parkname" data-chk='needs' class="w186 ttxt txtt2"  maxlength="20"
								value="${ppinfo.parkname}" />
							<div class="inputerror" id="parkcong">请填写园区名称</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">意识形态：</td>
						<td width="280px ">
							<div class="mod-select  mt5 xmgl_selct" id="dpfSelId">
								<p class="text">${dpf.parkform}</p>
								<span class="arr-group hand"> <i class="icon-mod icon-arr"></i> </span>
								<input type="hidden" name="parkform"  data-chk='needs' id="parkform" value="${dpf.parkform}" />
								<div class="list">
									<ul>
										<c:forEach var="pf" items="${dpfs}">
											<li val="${pf.parkform}"> <a href="">${pf.parkform}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
							<div class="inputerror" style="float:left;">请填写意识形态!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">创园时间：</td>
						<td width="280px ">
							<input type="text" name="parktime"  data-chk='needs' class="Wdate w192 ttxt txtt2 datesel Wdate3" style="padding-left:0;"
								value="${ppinfo.parktime}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							<div class="inputerror">请填写创园时间!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">开园时间：</td>
						<td width="280px ">
							<input type="text" name="openTime"  data-chk='needs' class="Wdate w192 ttxt txtt2 datesel Wdate3" style="padding-left:0;"
								value="${ppinfo.openTime}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							<div class="inputerror">请填写开园时间!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">园区地址：</td>
						<td width="280px ">
							<input type="text" name="address" class="w186 ttxt txtt2"  maxlength="25"
								value="${ppinfo.address}" />
							<div class="inputerror">请填写园区地址!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">占地面积：</td>
						<td width="280px ">
							<input type="text" name="coverarea"  data-chk="number" class="w186 ttxt txtt2"  maxlength="20"
								value="${ppinfo.coverarea}" />
							<span>m²</span>
							<div class="inputerror" id="coverarea">必须为数字类型</div>
						</td>
					</tr>
				</table>
			</td>
			<td>
				<table class="tblnygl">
					<tr>
						<td class="tright w80">园区类型：</td>
						<td width="280px ">
							<div class="mod-select  mt5 xmgl_selct" id="dptSelId">
								<p class="text">${dpt.parktype}</p>
								<span class="arr-group hand"> <i class="icon-mod icon-arr"></i> </span>
								<input type="hidden" name="parktype"  data-chk='needs' id="parktype" value="${dpt.parktype}" />
								<div class="list">
									<ul>
										<c:forEach var="pt" items="${dpts}">
											<li val="${pt.parktype}"> <a href="">${pt.parktype}</a></li>
										</c:forEach>
									</ul>
								</div>
							</div>
							<div class="inputerror" style="float:left;">请填写园区类型!</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">泛能站数量：</td>
						<td width="280px ">
							<input type="text" name="stationnumber" data-chk="number" class="w186 ttxt txtt2"  maxlength="20"
								value="${ppinfo.stationnumber}" />
							<div class="inputerror" id="stationnumber">必须为数字类型</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">总供能面积：</td>
						<td width="280px ">
							<input type="text" name="supplyarea" data-chk="number"  class="w186 ttxt txtt2"  maxlength="20"
								value="${ppinfo.supplyarea}" />
							<span>m²</span>
							<div class="inputerror" id="supplyarea">必须为数字类型</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">实供能面积：</td>
						<td width="280px ">
							<input type="text" name="actualarea" data-chk="number"  class="w186 ttxt txtt2" maxlength="20"
								value="${ppinfo.actualarea}" />
							<span>m²</span>
							<div class="inputerror" id="actualarea">必须为数字类型</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">投资总额：</td>
						<td width="280px ">
							<input type="text" name="investment" data-chk="number" class="w186 ttxt txtt2" maxlength="20"
								value="${ppinfo.investment}" />
							<span>元</span>
							<div class="inputerror" id="investment">必须为数字类型</div>
						</td>
					</tr>
					<tr>
						<td class="tright w80">备注：</td>
						<td width="280px ">
							<input type="text" name="remarks" class="w186 ttxt txtt2" title="${ppinfo.remarks}" maxlength="30"
								value="${ppinfo.remarks}" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div class="clear">
		<a title="Close" class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
		<a class="tck-save fr mt15" id="savebut">保存</a>
		<input type="hidden" id="elv" value="${elv}">
	</div>
</form>
</div>
