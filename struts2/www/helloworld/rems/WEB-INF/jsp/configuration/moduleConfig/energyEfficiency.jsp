<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	var projectid = $('#projectId').val();
	initEfficiency(projectid);
});
function initEfficiency(projectid){
var $selections = $('.mod-select');
var $devicesSels = new Array()
, $propertySels = new Array()
, $rankedsSel
, $equeesSel;
$.each($selections, function (n, item) {
	var $sel = $(item);
	var st = $sel.data('name');
	if(st == 'device'){
		$devicesSels.push($sel);
	}else{
		$propertySels.push($sel);
	}/*else if(st =='rankeds'){
		$rankedsSel = $sel;
	}else if(st == 'equees'){
		$equeesSel = $sel;
	}*/
});
//初始化设备下拉框
$.ajax({type: "GET",async:false,cache:false,url: "<c:url value='/moduleconfig/listClassInstByProjectid'/>",
	data:{projectid:projectid},dataType: "json",
	success: function (data) {
		if (data != null && data.length > 0) {
			var options = "";
			var option = "";
            $.each(data, function (n, item) {
                option = "<li checkid=\"" + item.classinstanceid + "\" val=\"" + item.classinstanceid + "\"><a class='w221 ellipsis' title=" + item.classinstancename + " href=\"\">" + item.classinstancename + "</a></li>";
				options += option;
			});
			$.each($devicesSels, function (n, item) {
			var $item = $(item);
				$item.find('ul').empty().html(options);
				$item.simSelect({
		        callback: function (x,v) {
		        	if($(this).data('add') == 'off'){
		        		$(this).find("input[name='device']").val(v);
		        		return ;
		        	}
		            var dataUl = $(this).siblings('.nxglDataBlock').children('ul')
		              , dataLI
		              , flag = true
		              if(x){
		                  dataUl.find('li').each(function(){
		                    var text = $(this).text();
		                    if(text.trim() == x.trim()){
		                        flag = false;
		                    } 
		                  });
		                  if(flag) {
		                  	dataLI = "<li val='"+v+"'>"+x+"</li>";
		                  	dataUl.append(dataLI);
		                  }
		              }
		        }
		    	});
			});
		}
	},error:function(){
		jAlert('加载失败！');
	}
});
$.each($propertySels, function (n, item) {
	var $item = $(item);
	$item.simSelect({
		callback: function (x,v) {
			var dataUl = $(this).siblings('.nxglDataBlock').children('ul')
			, dataLI
			, flag = true
			if(x){
				dataUl.find('li').each(function(){
					var text = $(this).text();
					if(text.trim() == x.trim()){
						flag = false;
					}
				});
				if(flag) {
					dataLI = "<li val='"+v+"'>"+x+"</li>";
					dataUl.append(dataLI);
				}
			}
		}
	});
});
//载入设备数据
$.ajax({type: "GET",async:false,cache:false,url: "<c:url value='/moduleconfig/listModelInstByCondition'/>",
	data:{projectid:projectid},dataType: "json",
	success: function (data) {
		if (data != null && data.length > 0) {
			initDevicesData(data,$devicesSels);
		}
	},error:function(){
		jAlert('加载失败！');
	}
});
//初始化属性动态属性
$.ajax({type: "GET",async:false,cache:false,url: "<c:url value='/moduleconfig/listPropertysByModel'/>",cache:false,
	data:{projectid:projectid},async: false,dataType: "json",
		success: function (data) {
		var equees = data.equees
		, rankeds =data.rankeds;
			$.each($propertySels,function(n,sel){
				var $sel = $(sel)
				, $show=$sel.find('p.text')
				, $block = $sel.parents('.mksjpzglszBlock')
				, $dataUl = $block.find('.propertys ul')
				, localMid = $block.find("input[name='modelid']").val();
				$sel.find('div.list').find('li a').each(function(aindex,acss){var $this = $(acss);$this.addClass('ellipsis').addClass('w221').attr('title',$this.text());});
				if(localMid == 12){
					$show.text('已选择属性');
					initPropertyData(equees,$dataUl);
				}else if(localMid == 15){
					$show.text('已选择属性');
					initPropertyData(rankeds,$dataUl);
				}
			});
		},error:function(){
			jAlert('加载失败！');
		}
});
}
function initPropertyData(data,ul){
	var li;
	$.each(data,function(n,item){
		li = "<li val='"+item.propertytype+"'>"+item.typename+"</li>";
		ul.append(li);
	});
}
function initDevicesData(data,selections){
	$.each(data,function(n,vo){
				var remoteMid = vo.modelid
				, remoteCid = vo.classinstanceid
				, remoteCname = vo.classinstancename
				, cid = "";
				$.each(selections,function(n,sel){
					var $sel = $(sel)
					, $show=$sel.find('p.text')
					, $device = $sel.find("input[name='device']")
					, $block = $sel.parents('.mksjpzglszBlock')
					, $dataUl = $block.find('.devices ul')
					, localMids = ($block.find("input[name='modelid']").val()).split(":")
					, $dataLi ="";
					if(localMids.length==3){
						if(localMids[0]==remoteMid||localMids[1]==remoteMid||localMids[2]==remoteMid){
							changeSelection($sel,remoteCid);
						}
					}else if(localMids.length==1){
						var isMatch = false;
						if(localMids[0]==remoteMid){
							isMatch = true;
						}else{
							isMatch = false;
						}
						if(!isMatch){return;}
						if(isMatch&&localMids[0]==12){
							$show.text('已选择设备');
							$dataLi = "<li val='"+remoteCid+"'>"+remoteCname+"</li>";
							$dataUl.append($dataLi);
						}else if(isMatch&&localMids[0]==14){
							$show.text('已选择设备');
							$dataLi = "<li val='"+remoteCid+"'>"+remoteCname+"</li>";
							$dataUl.append($dataLi);
						}else if(isMatch){
							$show.text(remoteCname).attr('title',remoteCname);
							$device.val(remoteCid);
						}
					}
				});
			});
}

</script>
<!--start-->
<div class="mksjpzglszBlock" id="c3b1">
	<div class="mksjpzglszbInner clearfix ">
		<p class="mksjpzTitle">系统能效设置</p><input type="hidden" name="modelid" value="8:9:10" /><input type="hidden" name="flag" value="multi_1" />
		<div class="nxglLines">
			<div data-add="off" class="mod-select mksjpzNxglMs inblock" data-name="device">
				<p class="text w205 ellipsis">选择设备</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name='device' value="" />
				<div class="list">
					<ul></ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock propertys">
				<ul class="clearfix">
					<li data-del='off' val='2'>系统供能</li>
					<li data-del='off' val='3'>系统耗能</li>
					<li data-del='off' val='4'>系统运行效率</li>
				</ul>
			</div>
		</div>
		<span class="newButton p410 right quickSub">保存</span>
	</div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c3b2">
	<div class="mksjpzglszbInner clearfix ">
		<p class="mksjpzTitle">系统指标设置</p><input type="hidden" name="modelid" value="11" /><input type="hidden" name="flag" value="multi_2" />
		<div class="nxglLines">
			<div data-add="off" class="mod-select mksjpzNxglMs inblock" data-name="device">
				<p class="text w205 ellipsis">选择设备</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name='device' value="" />
				<div class="list">
					<ul></ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock propertys">
				<ul class="clearfix">
					<li data-del='off' val='7'>系统指标（率）</li>
					<li data-del='off' val='15'>系统指标（量）</li>
				</ul>
			</div>
		</div>
		<span class="newButton p410 right quickSub">保存</span>
	</div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c3b3" data-type='N' >
	<div class="mksjpzglszbInner clearfix ">
		<p class="mksjpzTitle">设备能效设置</p><input type="hidden" name="modelid" value="12" /><input type="hidden" name="flag" value="multi_3" />
		<div class="nxglLines">
			<div class="mod-select mksjpzNxglMs inblock" data-name="device">
				<p class="text w205 ellipsis">选择设备</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name='device' value="" />
				<div class="list">
					<ul></ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock devices">
				<ul class="clearfix"></ul>
			</div>
		</div>
		<div class="nxglLines">
			<div class="mod-select mksjpzNxglMs inblock" data-name="equees">
				<p class="text w205 ellipsis">选择能效属性</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<div class="list">
					<ul>
						<li val="10"><a href="">单体供能</a></li>
						<li val="11"><a href="">单体耗能</a></li>
						<li val="12"><a href="">单体效率</a></li>
						<li val="14"><a href="">单体运行时长</a></li>
					</ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock propertys">
				<ul class="clearfix"></ul>
			</div>
		</div>
		<span class="newButton p410 right quickSub">保存</span>
	</div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c3b4">
	<div class="mksjpzglszbInner clearfix ">
		<p class="mksjpzTitle">系统成本设置</p><input type="hidden" name="modelid" value="13" /><input type="hidden" name="flag" value="multi_2" />
		<div class="nxglLines">
			<div data-add="off" class="mod-select mksjpzNxglMs inblock" data-name="device">
				<p class="text w205 ellipsis">选择设备</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name='device' value="" />
				<div class="list">
					<ul></ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock propertys">
				<ul class="clearfix">
					<li data-del='off' val='2'>系统耗能</li>
					<li data-del='off' val='5'>耗能成本</li>
				</ul>
			</div>
		</div>
		<span class="newButton p410 right quickSub">保存</span>
	</div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c3b5" data-type='N' >
	<div class="mksjpzglszbInner clearfix ">
		<p class="mksjpzTitle">设备成本设置</p><input type="hidden" name="modelid" value="14" /><input type="hidden" name="flag" value="multi_3" />
		<div class="nxglLines">
			<div class="mod-select mksjpzNxglMs inblock" data-name="device">
				<p class="text w205 ellipsis">选择设备</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name='device' value="" />
				<div class="list">
					<ul></ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock devices">
				<ul class="clearfix"></ul>
			</div>
		</div>
		<div class="nxglLines">
			<div class="mod-select mksjpzNxglMs inblock" data-name="">
				<p class="text w205 ellipsis">选择成本属性</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
				</span>
				<div class="list">
					<ul>
						<li val="11"><a href="">单体耗能</a></li>
						<li val="13"><a href="">单体耗能成本</a></li>
					</ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock propertys">
				<ul class="clearfix">
					<li data-del='off' val='11'>单体耗能</li>
					<li data-del='off' val='13'>单体耗能成本</li>
				</ul>
			</div>
		</div>
		<span class="newButton p410 right quickSub">保存</span>
	</div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c3b6" >
	<div class="mksjpzglszbInner clearfix ">
		<p class="mksjpzTitle">排名设置</p><input type="hidden" name="modelid" value="15" /><input type="hidden" name="flag" value="multi_2" />
		<div class="nxglLines">
			<div data-add="off" class="mod-select mksjpzNxglMs inblock" data-name="device">
				<p class="text w205 ellipsis">选择设备</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<input type="hidden" name='device' value="" />
				<div class="list">
					<ul></ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock devices">
				<ul class="clearfix"></ul>
			</div>
		</div>
		<div class="nxglLines">
			<div class="mod-select mksjpzNxglMs inblock" data-name="rankeds">
				<p class="text w205 ellipsis">选择排名属性</p>
				<span class="arr-group hand"> <i class="icon-mod icon-arr"></i></span>
				<div class="list">
					<ul>
						<li val="2"><a href="">系统耗能</a></li>
						<li val="3"><a href="">系统供能</a></li>
						<li val="4"><a href="">系统效率</a></li>
						<li val="6"><a href="">系统单位能耗</a></li>
						<li val="7"><a href="">系统指标(率)</a></li>
						<li val="15"><a href="">系统指标(量)</a></li>
					</ul>
				</div>
			</div>
			<div class="nxglDataBlock inblock propertys">
				<ul class="clearfix"></ul>
			</div>
		</div>
		<span class="newButton p410 right quickSub">保存</span>
	</div>
</div>
<!--end-->
<script type="text/javascript">
$(document).ready(function(){
// show or hide highlight
$(document).on('mouseover mouseleave', '.nxglDataBlock li',highlightLi );
// del li
$(document).on('click', '.delX', delLi);
});
function highlightLi(e) {
    var $this = $(this)
      , del = $('.delX')
      , dataLI
      if($this.data('del') == 'off') return
      if(e.type == 'mouseover') {
          if(del.length) return
          $this.addClass('delStyle')
          dataLI = '<span class="delX">x</span>'
          $this.append(dataLI)
      } else if(e.type == 'mouseleave') {
        $('.delX').remove() 
        $this.removeClass('delStyle')
      }
}
function delLi(e) {
    $(this).parent('li').remove();
}
</script>