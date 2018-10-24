<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
var $popEditor=$('.hd').parent('.mod-pop');//获取当前弹框主窗口
$(document).ready(function(){
	initEditor();
	$popEditor.find("#save").on('click',function(){
		var data = {};
		var submitFlag = true;
		$popEditor.find("input").each(function(){
			var $this = $(this)
			, name = $this.attr("name")
			, type = $this.attr('type')
			, value = $this.val();
			if(!(!name)){
				if(value==''&&name=='showname'&&name=='classpropertyid' && name=='unitname'){
					var msg = '该值不能为空！';
					var $parent = $this.parent('.popLine');
					if(type=='hidden'){
						$parent = $this.parent().parent('.popLine');
						msg = '请选择至少一个选项！';
					}
					$parent.find('.popCheckMsg').css({'display':'block'}).text(msg);
					console.log(submitFlag+"|"+name+"|"+value);
					submitFlag = false;
					return;
				}else{
					var $parent = $this.parent('.popLine');
					if(type=='hidden'){
						$parent = $this.parent().parent('.popLine');
					}
					$parent.find('.popCheckMsg').css({'display':'none'});
					data[name] = value;
				}
			}
			console.log(submitFlag+"|"+name+"|"+value);
		});
		if(!submitFlag){return;}
		$.ajax({url: "<c:url value='/moduleconfig/saveHomepage' />",type:"POST",data: data,cache:false,
			success: function(data){
				if(data=='true'){
					jAlert("编辑成功！");
				}else{
					if($("#edittype").val()=="A"){
						jAlert("添加失败！");
					}else{
						jAlert("修改失败！");
					}
				}
				initCircular($('#projectId').val());
				$.fancybox.close();
			},error:function(){
				jAlert('操作失败！');
			}
		});
	});
	
	closeFancybox();
});
function initEditor(){
	$selections = $popEditor.find('.mod-select');
	$.each($selections,function(n,item){
		var key = $(item).find("> input:first").val();
		if(key!=""){
			var text = $(item).find("ul > li[val='"+key+"'] > a").text();
			if(text!=""){
				$(item).find(".text").text(text);
			}
		}
	});
	$('#classpropertyId').simSelect({
		callback: function (x,v) {
		if(!x) return;
			$(this).find("input:first").val(v);
			$(this).find("input[name='classpropertyname']").val(x);
			var unitname = $(this).find('li[val='+v+']').find("input[class='hideText']").val();
			$popEditor.find("input[name='unitname']").val(unitname);
		}
    });
}
</script>
	<div class="hd">
		<h2>新增实时监测</h2>
		<input type="hidden" name="id" value="${homepage.id}" />
		<input type="hidden" name="modelid" value="${empty homepage.modelid ? 1 : homepage.modelid}" />
		<input type="hidden" name="projectid" value="${homepage.projectid}" />
		<input type="hidden" name="location" value="${homepage.location}" />
		<input type="hidden" name="classinstanceid" value="${homepage.classinstanceid}" />
		<input type="hidden" name="remarks" value="${homepage.remarks}" />
		<input type="hidden" name="classinstancename" value="${homepage.classinstancename}" />
	</div>
	<div class="popBg">
		<div class="popLine mt9">
			<span class="popLabelStyle w118">属性显示名：</span>
			<input class="popInputStyle w274" type="text" name="showname" value="${homepage.showname}">
			<span class="popCheckMsg"></span>
		</div>
		<div class="popLine mt9">
			<span class="popLabelStyle w118">属性：</span>
			<div class="mod-select popSelStyle w243" id="classpropertyId">
				<p class="text">${i.classpropertyname}</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name="classpropertyid" value="${homepage.classpropertyid}" />
				<input type="hidden" name="classpropertyname" value="${homepage.classpropertyname}" />
				<div class="list">
					<ul>
						<c:forEach var="i" items="${defaultProp}">
							<li val="${i.classpropertyid}">
								<a href="">${i.classpropertyname}
								<input type="hidden" class="hideText" value="${i.unitname}"/>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<span class="popCheckMsg"></span>
		</div>
		<div class="popLine mt9">
			<span class="popLabelStyle w118">单位：</span>
			<input class="popInputStyle w274" type="text" name="unitname" value="${homepage.unitname}">
			<span class="popCheckMsg"></span>
		</div>
	</div>
	<div class="popButtonArea clearfix">
		<span class="newButton newButtonCancel p425 right mr15 closeFancybox">取消</span>
		<span class="newButton p425 right mr15" id="save">保存</span>
	</div>
