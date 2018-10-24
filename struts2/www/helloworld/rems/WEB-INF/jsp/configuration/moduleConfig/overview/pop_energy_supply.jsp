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
				if(value==''&&name!='modelid'){
					var msg = '该值不能为空！';
					var $parent = $this.parent('.popLine');
					if(type=='hidden'){
						$parent = $this.parent().parent('.popLine');
						msg = '请选择至少一个选项！';
					}
					$parent.find('.popCheckMsg').css({'display':'block'}).text(msg);
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
		$.ajax({url: "<c:url value='/moduleconfig/saveHomeIO' />",type:"POST",data: data,cache:false,
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
				initHomeIO($('#projectId').val(),1);
				$.fancybox.close();
			},error:function(){
				jAlert('操作失败！');
			}
		});
//		console.log(data);
	});
	closeFancybox();
});
function initEditor(){
	$selections = $popEditor.find('.mod-select');
	$.each($selections,function(n,item){
		var $sel = $(item)
		, key = $sel.find("> input:first").val()
		, id = $sel.attr('id')
		, text = '';
		if(key!=""){
			text = $sel.find("ul > li[val='"+key+"']").text();
			$sel.find(".text").text(text);
		}
	});
	$popEditor.find('#energypId').simSelect({
		callback: function (x,v) {
		if(!x) return;
			$(this).find("input:first").val(v);
			var energyunit = $(this).find('li[val='+v+']').find("input[class='hideText']").val();
			$popEditor.find("input[name='energyunit']").val(energyunit);
		}
    });
    $popEditor.find('#supplyIcons').simSelect({
		callback: function (x,v) {
			if(!x) return;
			var $this = $(this);
			$this.find("input:first").val(v);
            $this.parent('.popLine').siblings('.xznhIconBox').find('.gnPic').removeClass().addClass('gnPic '+v+''); 
		}
    });
}
</script>
	<div class="hd">
		<h2>新增能供</h2>
		<input type="hidden" name="modelid" value="${homeio.modelid}" />
		<input type="hidden" name="iotype" value="1" />
		<input type="hidden" name="projectid" value="${homeio.projectid}" />
		<input type="hidden" name="classinstanceid" value="${homeio.classinstanceid}" />
		<input type="hidden" name="location" value="${homeio.location}" />
		<input type="hidden" id="edittype" value="" />
	</div>
	<div class="popBg">
		<div class="popLine mtb4">
			<span class="popLabelStyle w118">属性显示名：</span>
			<input class="popInputStyle w274" type="text" name="showname" value="${homeio.showname}">
			<span class="popCheckMsg"></span>
		</div>
		<div class="popLine mtb4">
			<span class="popLabelStyle w118">能源属性：</span>
			<div class="mod-select popSelStyle w243" id="energypId">
				<p class="text">选择能源</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name="energypid" value="${homeio.energypid}" />
				<div class="list">
					<ul>
						<c:forEach var="i" items="${energyps}">
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
		<div class="popLine mtb4">
			<span class="popLabelStyle w118">能源单位：</span>
			<input class="popInputStyle w274" type="text" name="energyunit" value="${homeio.energyunit}">
			<span class="popCheckMsg"></span>
		</div>
		<div class="popLine mtb4 xznhIconBox">
			<span class="popLabelStyle w118">图片：</span>
			<div class="mod-select popSelStyle w243" id="supplyIcons">
				<p class="text">选择图片</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name="energyicon" value="${homeio.energyicon}" />
				<div class="list">
					<ul class="esList clearfix">
						<c:forEach var="i" items="${energyIcons}">
							<li val="${i.value}"> <span class="${i.value}" title="${i.key}">${i.key}</span></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<span class="popCheckMsg"></span>
		</div>
		<div class="popLine mtb4 xznhIconBox">
            <div class="gnPic ${homeio.energyicon}"></div>
		</div>
	</div>
	<div class="popButtonArea clearfix">
		<span class="newButton newButtonCancel p425 right mr15 closeFancybox">取消</span>
		<span class="newButton p425 right mr15" id="save">保存</span>
	</div>