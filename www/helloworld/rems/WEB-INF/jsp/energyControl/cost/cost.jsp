<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!-- 成本 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title> 
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
    <script type="text/javascript">
    $(document).ready(function () {
	    var timeradio1 =$ ("input[name='type']" ) ;
		timeradio1.each(function(){
			$(this).attr("checked",false);
		});
		timeradio1.eq(0).attr("checked",true);
	});
    $(function(){
    	var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},pid=${pid};
    	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />",success:function(data){
				$.fn.zTree.init($("#treeDemo"), setting, data);
				$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
		},error:function(){jAlert('加载失败!');}});
		function onClick(event,treeID,treeNode,clickFlag) {
			if(treeNode.isParent){return};
			var parentNode = treeNode.getParentNode();
			$("#curCity").empty().append("<span>"+parentNode.getParentNode().name+"</span>-<span>"+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
			$(".area_popup").hide();
			$("#curCity").removeClass("on");
			//energyLeft(treeNode.id);
			pid = treeNode.id;
			setSession(treeNode.id);
			$("#fnzname").attr("value",treeNode.name);
			initLeft();
			$("#project").val(treeNode.id);
		}
		function setSession(pid){
			$.ajax({type:"GET",url:"<c:url value='/analyse/run/session' />?date="+new Date().getTime(),data:{pid:pid}});
		}
    	initLeft();
    	function initLeft(){
    		$("#exportExcel").hide();
    		$(".wrap").empty();
    		$.ajax({type:"GET",url:"<c:url value='/analyse/cost/left' />",data:{project:pid},
    			success:function(data){
				$("#LeftCol").empty().html(data);
				Tab();
    		}});
    	}
    	var url;
    	$("#sjbut").click(function(){
    		$("#temp").val(Math.random());
    		$("#tabType").val(($('.tab-nav .on','#LeftCol').attr('val')));
    		//add by Y 2015-01-15 新增判断  begine
    		var type = $('.tab-nav .on','#LeftCol').attr('val')
		 	, $tab;
			  //add by Y 2015-01-15 新增判断  begine
			 switch(type){
			 	case '0': $tab = $("#tab1 input[name= 'property']:checked" ) ; break;
			 	case '1': $tab = $("#tab2 input[name= 'instance']:checked" ); break;
			 	case '2': $tab = $("#tab3 input[name= 'radioClasspropertyname']:checked" ) ; break;
			 }
			 if(type=='0'&&$tab.size() == 0){
				 jAlert("请选择系统能源成本！");
				 return false;
			 }
			 if(type=='1'&&$tab.size() == 0){
				 jAlert("请选择设备能源成本！");
				 return false;
			 }
			 //add by Y 2015-01-15 新增判断  end
    		if($(".on","#LeftCol").hasClass("last")){
    			url = "<c:url value='/analyse/cost/value2/' />";
    		}else{
    			url = "<c:url value='/analyse/cost/value1/' />";
    		}
			console.log("表格："+$("#costForm").serialize());
			//$("#qxform").empty();
    		getValue(url,type);
    		$("#exportExcel").show();
    	});
    	function getValue(curl,tCode){
    		curl += pid;
    		var data = getData($("#costForm"),tCode);
    		$.ajax({type:"GET",url:curl,data:$("#costForm").serialize(),cache:false,
    			success:function(data){
				$(".wrap").empty().html(data);
    		}});
    	}
		$("#xxbut").click(function(){
			$("#temp").val(Math.random());
			//console.log("test:"+$('.tab-nav .on','#LeftCol').attr('val'));
			$("#tabType").val(($('.tab-nav .on','#LeftCol').attr('val')));
			//add by Y 2015-01-15 新增判断  begine
			var tab = $('.tab-nav .on','#LeftCol').attr('val'),$tab;
			switch(tab){
				case '0' : $tab = $("#tab1 input[name= 'property']:checked" );break;
				case '1' : $tab = $("#tab2 input[name= 'instance']:checked" );break;
			}
			//console.log("$tab:"+$tab);
			$("#exportExcel").hide();//隐藏excel导出按钮
			$('#tabType').val(tab);
			//modify by Y 2015-01-23 begine
			if(tab == '0' && $tab.size() ==  0){
				jAlert("请选择系统能源成本!");
				return false;
			}
			if(tab == '1' && $tab.size() ==  0){
				jAlert("请选择设备能源成本！");
				return false;
			}
			
			console.log("线图："+$("#costForm").serialize());
			$.ajax({type:"GET",url:"<c:url value='/analyse/cost/histogram/' />"+pid,data:$("#costForm").serialize(),cache:false,
				success:function(data){
					$(".wrap").empty().html(data);
				},
				error:function(){
					jAlert('加载失败！');
				}
			});
    	});
		
		//add 2015-01-06 begine
		//导出
		$("#exportExcel").click(function(){
			$("#temp").val(Math.random());
			$("#tabType").val(($('.tab-nav .on','#LeftCol').attr('val')));
			if (!validdata()) {
				return;
			}
			if(Number($("#tabType").val())==0){
				$("#showname").val($("input[name= 'property']:checked").parent().text().trim());
			}else{
				$("#showname").val($("input[name= 'instance']:checked").parent().text().trim());
			}
			var url="<c:url value='/analyse/cost/export' />";
			$("#costForm").attr("action",url);
			$("#costForm").submit();
		});
		
		//add 2015-01-06 end
		function validdata(){
			var tabchoicenow=0;
			var tabchoice=$(".left-in li" ) ;
			tabchoice .each(function(){
				if($(this).hasClass("on")){
					tabchoicenow= $(this).attr("val");
				} else {
				
				}
    		});
    		$("#liname").val(tabchoice.eq(tabchoicenow).text());
    		if (tabchoicenow==0) {
    			var tabchoicenow1 = $("#tab1 input[name= 'property']:checked");
    			if (tabchoicenow1.size()>0) {
    			} else {
    				jAlert("先选择要查看的指标或设备，请重新选择！");return false;
    			}
    		} else {
    		
    		}
    		if (tabchoicenow==1) {
    			var tabchoicenow2 = $("#tab2 input[name= 'instance']:checked");
    			if (tabchoicenow2.size()>0) {
    			
    			} else {
    				jAlert("先选择要查看的指标或设备，请重新选择！");return false;
    			}
			 } else {
			 
			 }
			 if (tabchoicenow==2) {
			 	var tabchoicenow3 = $("#tab3 input[name= 'radioClasspropertyname']:checked");
			 	if (tabchoicenow3.size()>0) {
				
				} else {
					jAlert("先选择要查看的指标或设备，请重新选择！");return false;
				}
			}else {
			
			}
			var timechoice = $("input[name= 'type']:checked");
			var timechoiceval = timechoice.val();
			var timechoice = $("input[name= 'date']");
			$("#linametime").attr("value",timechoice.eq(timechoiceval).attr("value"));
			return true;
			}
			function getData(container,tCode){
				var $container = $(container)
				, $tab = $('#tab'+(parseInt(tCode)+1))
				, dates = '';
				var data={};
				$container.find('input').each(function(n,input){
					var $input = $(input)
					, name = $input.attr('name')
					, type = $input.attr('type')
					, value = $input.val();
					if(type != 'radio'){
						data[name] = value;
					}else{
						var chk = $input.prop('checked');
						if(chk==true){
							data[name] = value;
						}
					}
				});
				//处理日期参数
				$container.find("input[name='date']").each(function(n,input){
					var $date = $(input)
					, value = $date.val()
					dates += value+',';
				});
				dates = dates.substring(0,dates.length-1);
				data['date'] = (dates);
				console.log(data);
				return data;
			}
    });
    	
    </script>
</head>
<body>
	<jsp:include page="../../header.jsp"></jsp:include>
     <div class="nav-nav clear">
         <div class="sel_nav ml10">
            <a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity">
            <span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span></a>
        </div>
    </div>
    <form id="costForm" action="" method="post">
		<input type="hidden"  id="fnzname" name="fnzname" value="${pvo.projectname}"/>
		<input type="hidden" id="liname" name="liname" value=""/>
		<input type="hidden" id="linametime" name="linametime" value=""/>
		<input type="hidden" id="showname" name="showname" value=""/>
		<input type="hidden" id="tabType" name="tab" value="0"/>
		<input type="hidden" id="temp" name="temp"/>
    <div id="container" class="">
        <div id="LeftCol" class="LeftCol LeftCol3"></div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft">
            </div>
            <div class="content contentTop">
                <div class="topFilter tab">
                    <table class="putform">
                        <tr>
                            <td class="tleft w60">查看方式：</td>
                            <td class="tleft w100 ">
                                <div class="tab-nav">
                                    <ul class="fiterTime" style="width: 120px;">
                                        <li><label><input type="radio" checked="checked" name="type" value="0" />天</label></li>
                                        <li><label><input type="radio" name="type" value="1" />月</label></li>
                                        <li><label><input type="radio" name="type" value="2" />年</label></li>
                                    </ul>
                                </div>
                            </td>

                            <td class="tleft">
                                <div class="fl tab-panel" style="display: block;">
                                    <input type="text" name="date" value="${curDay}" class="Wdate itxt w80" onfocus="WdatePicker({maxDate:'%y-%M-%d'})" autocomplete="off" />
                                </div>
                                <div class="fl tab-panel" style="">
                                    <input type="text" name="date" value="${curMonth}" class="Wdate itxt w80" onfocus="WdatePicker({dateFmt:'yyyy-MM',maxDate:'%y-%M'})" autocomplete="off" />
                                </div>
                                 <div class="fl tab-panel" style="">
                                    <input type="text" name="date" value="${curYear}" class="Wdate itxt w80" onfocus="WdatePicker({dateFmt:'yyyy',maxDate:'%y'})" autocomplete="off" />
                                </div>
                                 <div class="down-popup fl ml10 view-data" id="submitBt">查看数据
                                 	<div class="arr-group"></div> 
                                        <div class="list">
                                            <ul>
                                                <li><a class="sjb" id="sjbut"><span class="img"></span><span class="txt">数据表</span></a></li>
<%--                                                <li><a class="qxb" id="xxbut"><span class="img"></span><span class="txt">线性图</span></a></li>--%>
												<li><a class="qxb" id="xxbut"><span class="img"></span><span class="txt">柱状图</span></a></li>
                                            </ul>
                                        </div>
                                 </div>
                                 <a id="exportExcel" class="fr execl mt5" style="display: none;"></a>
                                 <input type="hidden" name="project" id="project" value="${pid}"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="wrap datalist-content" style="overflow-y:auto;"></div>
            </div>
        </div>
    </div>
    </form>
    <div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
</body>
</html>
