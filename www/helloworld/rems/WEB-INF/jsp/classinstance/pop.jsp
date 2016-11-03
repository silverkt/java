<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<link href="<c:url value='/resources/css/add_pop.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/formerror.css' />"
	rel="stylesheet" />

<script type="text/javascript">
$(function(){
	var cid = $("input[name='classid']","#popform").val();
		//判断设备名是否为空或者重复
		$("#SBName").blur(function(){
			
			var SBName = $("#SBName").val();
			if(SBName==""){
				$("#SBname_msg").show();
				$("#SBname").text("*设备名称必填");
				//$(".clear #savebut").unbind("click");
				return;
			}
			else{
				$.ajax({type:"GET",url:"<c:url value='/instance/checkSBname' />?new="+new Date().getTime(),data:{projectid:${pid},SBid:$("#operate").val(),SBname:SBName},
					success:function(data){
						if(data){
							$("#SBname_msg").hide();
							$("#SBname").text("");
						}
						else{
							$("#SBname_msg").show();
							$("#SBname").text("*该设备名称已存在，请重新输入");
							//$(".clear #savebut").unbind("click");
							return;
						}
					}	
				});
			}
		});
	var typeid="", fsbid="";
	$('#classType').simSelect({
		callback: function (x,v) {
		typeid = v ? v : typeid;
		fsbid="";
		$("#energy").val("");
			if(typeid==""&&$("#classType .text").text()==""){
				$("#SStype_msg").show();
				$("#SStype").text("*所属类必选");
				$(this).find("input").val("");
				return;
			}
			$("#SStype_msg").hide();
			$("#SStype").text("");
			var temp = typeid.split(";");
			if(temp==''){
				$("#SStype_msg").show();
				$("#SStype").text('*您未选择所属种类！');
				return;
			}
			$(this).find("input").val(temp[0]);
			$.ajax({type:"GET",url:"<c:url value='/instance/fclassinstance' />",data:{pid:${pid},cid:temp[1]},
	        	success:function(data){
	        		if(data.length>0){
	        			var $fin = $("#finistance"),$ul = $fin.find("ul"),lis = "";
		        		$.each(data,function(k,v){
		        			lis += "<li val='"+v.classinstanceid+"'><a href=''>"+v.classinstancename+"</a></li>"
		        		})
		        		//$fin.find("p").text("请选择");
		        		$fin.find("p").text("请选择").css('color','#747474');
		        		$ul.empty().append(lis);
		        		
		        		$fin.simSelect({
							callback:function(x,v){
		        			fsbid = v ? v : fsbid;
		        			if((fsbid==""&&$("#finistance .text").text()=="")||(fsbid==""&&$("#finistance .text").text()=="请选择")){
		        				$("#SSenergy_msg").show();
		        				$("#SSenergy").text("*所属能源站必选");
		        				$(this).find("input").val("");
		        			}
		        			else{
		        				$("#SSenergy_msg").hide();
		        				$("#SSenergy").text("");
		        				$(this).find("input").val(fsbid);
		        			}
								//if(v) $(this).find("input").val(v);
							}
						})
	        		}
	        		else{
	        			var $fin = $("#finistance");
	        			$fin.find("ul").empty().end().find('.list').hide();
	        			//$fin.find("p").text("设备种类");
	        			$fin.find("p").text("请选择").css('color','#ccc');
	        			$fin.off('click');
	        		}
				}
	        });
		}
	});
	if(cid!=''){
		var $selection = $('#classType');
		$selection.find("ul").empty().end().find('.list').hide();
		$selection.find("p").css({'color':'#747474'});
		$selection.off('click');
	}
	closeFancybox();
})
function fileChange(obj){
	if(!/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test($(obj).val())){
		jAlert("图片类型必须是.gif,jpeg,jpg,png中的一种");
		return false;
	}
	else{
		$("#myImageName").val($(obj).val());
	}
	
}
</script>
<div class="hd">
	<h2>
		设施设备管理
	</h2>
</div>
<div class="bd">
	<form id="popform">
		<input type="hidden" id="operate" value="" />
		<input type="hidden" id="oldName" value="${instance.classinstancename}" />
		<input type="hidden" name="classinstanceid" value="${instance.classinstanceid}">
		<input type="hidden" name="projectid" value="${pid}">
		<input type="hidden" name="picturepath" value="${instance.picturepath}">
		<table class="tblnygl">
			<tr>
				<td class="tright w80">
					设备名：
				</td>
				<td width="280px ">
					<input type="text" id="SBName" name="classinstancename"
						class="inputinstancename w200 ttxt txtt2"
						value="${instance.classinstancename}" />
				</td>
				<%--
	    <span class="requireditem">*设备名称必填</span></td>
	     --%>

			</tr>
			<tr id="SBname_msg" class="Msg_TR">
				<td></td>
				<td>
					<div class="error-box">
						<label id="SBname" class="error"></label>
					</div>
				</td>
			</tr>
			<tr>
				<td class="tright w80">
					所属种类：
				</td>
				<td>
					<div id="classType" class="classType mod-select  mt5 xmgl_selct">
						<p class="text">
							${instance.classname}
						</p>
						<input type="hidden" name="classid" value="${instance.classid}">
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<div class="list">
							<ul>
								<c:forEach items="${clazz}" var="c">
									<li val="${c.classid};${c.parentclassid}">
										<a href="">${c.classname}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<%--
             <span class="requireditem restyle-requireditem">*所属类必选</span>
              --%>
				</td>

			</tr>
			<tr id="SStype_msg" class="Msg_TR">
				<td></td>
				<td>
					<div class="error-box">
						<label id="SStype" class="error"></label>
					</div>
				</td>
			</tr>
			<tr>
				<td class="tright w80">
					所属能源站：
				</td>
				<td>
					<div class="finistance mod-select  mt5 xmgl_selct" id="finistance">
						<p class="text">
							${instance.fclassinstancename}
						</p>
						<input id="energy" type="hidden" name="fclassinstanceid"
							value="${instance.fclassinstanceid}">
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<div class="list restyle-list">
							<ul>
							</ul>
						</div>
					</div>
				</td>
			</tr>
			<tr id="SSenergy_msg" class="Msg_TR">
				<td></td>
				<td>
					<div class="error-box">
						<label id="SSenergy" class="error"></label>
					</div>
				</td>
			</tr>
			<tr>
				<td class="tright w80">
					设备图像：
				</td>
				<td>
					<%--<input id="myBlogImage" name="file" type="file" class="w200 ttxt"  style="width:186px;" />--%>
					<input name="file" id="myBlogImage" class="inputImage" type="file"
						onchange="fileChange(this);">
					<input id="myImageName" class="imageName w200 ttxt txtt2"
						type="text" placeholder="请选择文件">
				</td>
			</tr>
			<tr>
				<td class="tright w80">
					备注：
				</td>
				<td>
					<textarea id="TextArea1" class="TextArea1" name="remarks" cols="20"
						rows="2">${instance.remarks}</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="clear">
		<a
			class="closebtn tck-cancel fr mt15 ml20 closeFancybox"
			href="javascript:;">取消</a>
		<a class="tck-save fr mt15" id="savebut">保存</a>
	</div>
</div>



