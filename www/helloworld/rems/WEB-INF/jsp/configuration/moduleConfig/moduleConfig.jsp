<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <!-- 模块数据配置 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/nygl.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/mksjpz.css'/>" rel="stylesheet" />
    <link href="<c:url value='/resources/css/colorpicker.css'/>" rel="stylesheet" />
    <link href="<c:url value='/resources/css/pagination.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.validate.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js'/>"></script>
    <script src="<c:url value='/resources/js/colorpicker.js'/>"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
	<script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
	<script src="<c:url value='/resources/js/ScreenMonitor/jquery.form.js' />"></script>
	<script src="<c:url value='/resources/js/ajaxfileupload.js' />"></script>
	<script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>
	<style type="text/css">
		.mod-select .list{max-height:200px;overflow-y: auto;}
	</style>
    <script type="text/javascript">
        $(document).ready(function () {
        	/*树状选择层级左侧开始*/
			$(".mksjpzBlock").css("overflow-y","auto");
			var scrH=$(window).height()- 130;
			$("#MainCol").css("height",scrH);
			$(".mksjpzBlock").css("height",scrH-65);
        	var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},year,type;
	    	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />",cache:false,
	    		success:function(data){
					$.fn.zTree.init($("#treeDemo"), setting, data);
					$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
				},error:function(){
					jAlert('加载失败！');
				}
	    	});
        	function onClick(event,treeID,treeNode,clickFlag) {
        		if(treeNode.getParentNode()==null) return;
				var parentNode = treeNode.getParentNode(),rootNode = parentNode.getParentNode();
				$("#curCity").empty().append((rootNode  == null ? '<span>' : '<span>'+rootNode.name+'</span>-<span>')+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
				$(".area_popup").hide();
				$("#curCity").removeClass("on");
				var $ul = $("#nyglinul").empty(),lis = "";
				if(treeNode.children.length == 0){
					lis = getLi(treeNode.id,treeNode.name,true);
					initConfigData(treeNode.id,treeNode.name);
				}
				else
					$.each(treeNode.children,function(i){
						if(i==0){
							initConfigData($(this)[0].id,$(this)[0].name);
						}
						var flag = i == 0 ? true : false;
						lis += getLi($(this)[0].id,$(this)[0].name,flag);	
					});
					
				$ul.append(lis);
				$("#nyglinul li").bind("click", function () {
	                $("#nyglinul li").removeClass("nyglinulsel");
	                $(this).addClass("nyglinulsel");
	            });
			}
        	function getLi(id,name,flag){
        		return '<li '+(flag ? 'class="nyglinulsel"':'')+' val="'+id+'" onclick="initConfigData('+id+',\''+name+'\')"><img src="<c:url value='/resources/img/iconleft.png'/>" />'+name+'</li>';
        	}
            $(".curSelectedNode span:first-child").css("background", "url(./img/img_23.png)");
            /*树状选择层级左侧结束*/
        });
    </script>
    
</head>
<body>
    <jsp:include page="../../header.jsp"></jsp:include>
    <div class="nav-nav clear">

        <div class="sel_nav ml10">
            <a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>请选择</span></a>
        </div>

    </div>
    <div id="container" class="">
        <div id="LeftCol" class="LeftCol LeftCol3" style="background:#fff;">
            <ul id="nyglinul" class="nyglinul"></ul>
        </div>
                
        <div id="MainCol" class="MainCol MainCol-moduleconfig" style="overflow-y: hidden;;">
			<div id="folderBtn" class="icoLeft"></div>
			<div class="mksjpzWrapper">
			    <div id="projectTitle" class="mksjpzHead clearfix"><span class="title"></span><input type="hidden" id="projectId" value=""/>
			        <div class="mksjpzhTabBlock">
			            <span data-tabs='1' class="mksjpzhtbSel">概览设置</span>
			            <span data-tabs='2'>能效监测</span>
			            <span data-tabs='3'>能效管理</span>
			        </div>
			    </div>
			    <div class="mksjpzSubHead">
			        <div data-subtabs='1' class="mksjpzshGlBlock mksjpzshBlock">
			            <a href="#c1b1" class="active">1耗能设置</a>
			            <a href="#c1b2">2供能设置</a>
			            <a href="#c1b3">3实时监测设置</a>
			            <a href="#c1b4">4气象数据</a>
			            <a href="#c1b5">5站点图设置/3D图</a>
			        </div>
			        <div  data-subtabs='2' class="mksjpzshNxBlock mksjpzshBlock hide">
			            <a href="#c2b1" class="active">1耗能结构设置</a>
			            <a href="#c2b2">2供能结构设置</a>
			            <a href="#c2b3">3耗能供能结构换算系数维护</a>
			            <a href="#c2b4">4能源结构分解</a>
			            <a href="#c2b5">5系统指标</a>
			        </div>
			        <div  data-subtabs='3' class="mksjpzshNxBlock mksjpzshBlock hide">
                        <a href="#c3b1" class="active">1系统能效</a>
                        <a href="#c3b2">2系统指标</a>
                        <a href="#c3b3">3设备能效</a>
                        <a href="#c3b4">4系统成本</a>
                        <a href="#c3b5">5设备成本</a>
                        <a href="#c3b6">6排名</a>
                    </div>
			    </div>
			    <div id="blockContainer" class="blockcontainer mksjpzBlock"></div>
			</div>
        </div>
    </div>
	<div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>      
<script>
$(document).ready(function(){
    $(document).on('click', '.mksjpzhTabBlock > span', selfn);
    $(document).on('click','.mksjpzglszBlock .fakeFile',semiFile);
    $(document).on('click','.mksjpzIcon', arrowMove);
    $(document).on('click','.quickSub', quickSubmission);
    $(document).on('click','.mksjpzSubHead > div > a', subtabFocus);
    function selfn() {
	var projectId=$("#projectId").val();
	if(projectId==null||projectId==""){
		jAlert('请选择要配置的项目！');
		return;
	}
    var $this = $(this)
      , tabDex = $this.data('tabs') 
      , sub = $('.mksjpzshBlock')
      //, block = $('.mksjpzBlock')
     ;
    $this.siblings('span').removeClass('mksjpzhtbSel').end().addClass('mksjpzhtbSel');
    sub.each(function(){  
        var $this = $(this);
        $this.data('subtabs') == tabDex ? $this.show() : $this.hide();
        //切换subtab锚点复位 - 有视觉问题
        /*$this.find('a').removeClass('active');
        $this.find('a:eq(0)').addClass('active');*/
    });
    initContainer(tabDex);
   /* block.each(function(){
        var $this = $(this)
        $this.data('block') == num ? initHTMLData(num,$this) : $this.hide(); 
    })*/
}
});
function initConfigData(id,name){
	$('#projectId').val(id);
	$('span.title','.mksjpzHead').empty().append(name);

    /*
    initContainer(tabDex);
    */
    $('.mksjpzhTabBlock').find('span').eq(0).siblings('span').removeClass('mksjpzhtbSel').end().addClass('mksjpzhtbSel')
    $('.mksjpzSubHead').children('div').eq(0).siblings('div').hide().end().show()
    initContainer(1);
}
//initBlockContainerHTML
function initContainer(tabDex){
var $blockContainer = $('#blockContainer');
var projectid = $('#projectId').val();
$.ajax({type:"GET",url:"<c:url value='/moduleconfig/initBlockContainer'/>",cache:false,
   	data:{tabDex:tabDex,projectid:projectid},
   	success:function(data){
   	$blockContainer.empty().html(data);
   },error:function(){
   	jAlert('加载失败！');
   }});
}
function subtabFocus(){
	$this = $(this);
	$this.siblings('a').removeClass('active');
	$this.addClass('active');
}
//位移操作
function arrowMove() {
    var $this = $(this)
    var op = $this.data('op') || ''
    if(op!='up'&&op!='down'&&op!='del'){return;}
    var tr = $this.parents('tr')
      , table =$this.parents('table')
      , total = $this.parents('tbody').find('tr').length
      , index = tr.index()
      , ptr = tr.prev()
      , ntr = tr.next()
      , basicModel = {}
      , contrastModel = {}
      , module = table.data('model') || ''
      , tcode = table.data('tcode') || ''
      , projectid = $('#projectId').val();
      switch(op) {
          case 'up':
          	if(total<=1){
      			jAlert("单条不可移动！");
      			return;
      		}else if(index==0){
          		jAlert("已经是第一条记录！");
          		return;
          	}else{
          		basicModel = initInputData(tr);
          		contrastModel = initInputData(ptr);
          	}
            break;
          case 'down':
          	var last = tcode=='c'?total-2:total-1;
          	if(total<=1){
      			jAlert("单条不可移动！");
      			return;
      		}else if(index==last){
          		jAlert("已经是最后一条记录！");
          		return;
          	}else{
          		basicModel = initInputData(tr);
          		contrastModel = initInputData(ntr);
          	}
            break;
          case 'del':
          	var isChartBase = ((tcode=='c')&&(tr.attr('id')=='siteBase'));
          	if(isChartBase){
          		jConfirm("项目站点图不可被删除！<br/>你可以选择替换项目站点图。","确定",function(r){
          			if(r == true){
          				tr.find('.realFile').click();
          			}
          		});
          		return;
          	}else{
          		basicModel = initInputData(tr);
          		if(basicModel['bgpath']==''){
          			jAlert('该数据不存在！');
          			return;
          		}
          		break;
          	}
      }
      var bmid,cmid,data={};
      var fulsh = false;
      if(module=='homeio'){
      	bmid=basicModel['modelid'];
      	cmid=contrastModel['modelid'];
      }else{
      	bmid=basicModel['id'];
      	cmid=contrastModel['id'];
      }
      if(op == 'up'||op == 'down'){
	      var bmloc=basicModel['location'],cmloc=contrastModel['location'];
	      data={bmid:bmid,cmid:cmid,bmloc:bmloc,cmloc:cmloc,module:module,op:op};
	      $.ajax({type: "GET",url: "<c:url value='/moduleconfig/modifyLoc'/>",
		      data:data,success: function (data) {
		      	fulshByArrow(data,tcode,projectid);
		      },error:function(){
				jAlert('操作失败！');
			  }
	      });
      }
      if(op=='del'){
      	jConfirm("你真的要删除这条数据？\n请确认！",'删除',function(r){
      		if(r == true){
      			data = {bmid:bmid,module:module,op:op};
		      	$.ajax({type: "POST",url: "<c:url value='/moduleconfig/deleteModuleConfig'/>",cache:false,
		      		data:data,success: function (data) {
		      			fulshByArrow(data,tcode,projectid);
		      		},error:function(){
						jAlert('删除失败！');
					}
		      	});
      		}
      	});
      }
}
function fulshByArrow(flag,tcode,projectid){
	//console.log('fulshByArrow');
	if(flag=='true'){
		jAlert('操作成功！');
		switch(tcode){
      		case 'io0':initHomeIO(projectid,0);break;
      		case 'io1':initHomeIO(projectid,1);break;
      		case 'p1':initCircular(projectid);break;
      		case 'p2':initHomepage(projectid,2);break;
      		case 'c':initSite3D(projectid);break;
      	}
	}else{
		jAlert('操作失败！');
	}
}

/*暂时移动至此 man 20150130*/
function initHomepage(projectid,modelid){
	$.ajax({type:"GET",url:"<c:url value='/modulemonitor/listHomepage' />",data:{projectid:projectid,modelid:2},cache:false,
    success:function(data){	
	    $("#homepage").empty().html(data);
	    size=$("#hp").data('val');
	    if(size==4){
	    	$('#xtzbNew').hide();
	    }else{
	    	$('#xtzbNew').show();
	    }
	    if(size>0){
	    	max = $('#hp').find('tr:last-child').find('input[name="location"]').val();
	    }
    },error:function(){
		jAlert('加载失败！');
	}});
}

//文件名称显示
function semiFile() {
	var $td = $(this).parent('td');
    var $real = $td.find('.realFile')
      , $fake = $td.find('.fakeFile')
    $real.click();
    $real.on('change', function(){
         var v = $real.val();
         var d = v.lastIndexOf('\u005C');
         if( d != -1){
         	v = v.substring(d+1,v.length);
         }
         if($td.parent('tr').attr('id')!='siteBase'){
         	$fake.text(v+'').attr('title',v)
         }else{
         	$fake.text('站点图已选定').attr('title',v)
         }       
    })
}
function initInputData(obj){
var data = {};
obj.find("input").each(function(){
	var name = $(this).attr("name"),value = $(this).val();
	if(!(!name)){
		data[name] = value;
	}
});
return data;
}
/*
* 设备实例选择框数据载入
*/
function initSelections(projectid){
$.ajax({type: "GET",async:false,cache:false,url: "<c:url value='/moduleconfig/listClassInstByProjectid'/>",
	data:{projectid:projectid},dataType: "json",
	success: function (data) {
		if (data != null && data.length > 0) {
			var options = "";
			var option = "";
            $.each(data, function (n, item) {
                option = "<li checkid=\"" + item.classinstanceid + "\" val=\"" + item.classinstanceid + "\"><a class='w221 ellipsis' title="+item.classinstancename+" href=\"\">" + item.classinstancename + "</a></li>";
				options += option;
			});
			var $selections = $('.mod-select');
			$selections.find('ul').empty().html(options);
			$selections.simSelect({
	        		callback: function (x,v) {
	        			$(this).find(".modSelect").val(v);
					}
	    		});
		}
		return true;
	},error:function(){
		jAlert('加载失败！');
	}
});
}
/*
 * 切换下拉框属性值
 */
 function changeSelection(selection,classinstanceid){
 	var $show=selection.find('p.text');
 	if(!classinstanceid){
 		var text = $show.text();
 		$show.text(text).attr('title',text);
 	}else{
 		var text = selection.find("li[val='"+classinstanceid+"'] > a").text();
	 	$show.text(text).attr('title',text);;
	 	selection.find('.modSelect').val(classinstanceid);
 	}
 }
 
 function quickSubmission(){
 	var $box = $(this).parents('.mksjpzglszBlock');
 	var $selection = $box.find('.mod-select')
 	, $propertyArrs = $box.find('.propertys li')
 	, $deviceArrs = $box.find('.devices li')
 	, deviceType = $box.data('type')||'O'
 	, data = initInputData($box)
 	, projectid = $('#projectId').val()
 	, devices=""
 	, propertys="";
 	data['projectid'] = projectid;
 	if(data['flag']!='single'){
 		$.each($propertyArrs,function(n,i){
	 		propertys += $(i).attr('val')+":";
	 	});
	 	propertys=propertys.substring(0,propertys.length-1);
	 	data['propertytypeid'] = propertys;
 	}
 	if(deviceType=="N"){
 		$.each($deviceArrs,function(n,i){
	 		devices +=  $(i).attr('val')+":";
	 	});
	 	devices = devices.substring(0,devices.length-1);
	 	data['classinstanceid'] = devices;
 	}else{
 		data['classinstanceid'] = $selection.find("input[name='device']").val();
 	}
 	if(data['classinstanceid']==""){
 		jAlert("请选择设备！");
 		return;
 	}
 	if(data['propertytypeid']==""){
 		jAlert("请添加需要配置的属性");
 		return;
 	}
 	//console.log(data);
 	$.ajax({type: "POST",url: "<c:url value='/moduleconfig/submitSystemLineData'/>",data:data,cache:false,
 		success: function (flag) {
			if (flag == "true") {
				jAlert("数据提交成功！");
			} else {
				jAlert("数据提交失败！");
			}
		},error:function(){
			jAlert('提交失败！');
		}
	});
 }
</script> 
</body>
</html>