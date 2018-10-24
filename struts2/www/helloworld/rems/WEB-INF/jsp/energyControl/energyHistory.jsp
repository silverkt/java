<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/include.inc.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!-- 历史数据查询 -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>远程能源管理系统</title>
		<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/demo.css'/>" rel="stylesheet" />
		<link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
		<link href="<c:url value='/resources/css/pagination.css' />" rel="stylesheet" />
		<script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
		<script src="<c:url value='/resources/js/common.js' />"></script>
		<script src="<c:url value='/resources/js/my.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
		<script src="<c:url value='/resources/js/base.js' />"></script>
		<script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
		<script src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
		<script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>

<script type="text/javascript">
 $(document).ready(function () {
  var timeradio1 =$ ("input[name= 'timeradio']" ) ;
	//alert("pppppp-"+timeradio1.size());
			timeradio1.each(function(){
				  $(this).attr("checked",false);
			});
			timeradio1.eq(0).attr("checked",true);
  });
 $(function(){
	 	var scrH=$(window).height()- 130;
		
		$(".left-nav").css("height",scrH);
		$("#dataListContentId").css("height",scrH-100);

		$("#excelHistoryId").hide();

	 	var setting = {
    		data: {simpleData: {enable:true}},
    		callback: {onClick:onClick}
		};
	 	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />",success:function(data){
			$.fn.zTree.init($("#treeDemo"), setting, data);
			$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
		}});
	 	energyLeft(${pid});
		function onClick(event,treeID,treeNode,clickFlag) {
			//add by Y 2015-01-23 更换泛能站清楚分页逻辑 begine
			$("#Pagination").empty();
			//add by Y 2015-01-23 更换泛能站清楚分页逻辑 end
			if(treeNode.isParent){return};
			var parentNode = treeNode.getParentNode();
			$("#curCity").empty().append("<span>"+parentNode.getParentNode().name+"</span>-<span>"+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
			$(".area_popup").hide();
			$("#curCity").removeClass("on");
			energyLeft(treeNode.id);
			setSession(treeNode.id);
			$("#fnzname").attr("value",parentNode.getParentNode().name+"-"+parentNode.name+"-"+treeNode.name);
		}
		function setSession(pid){
			$.ajax({type:"GET",url:"<c:url value='/analyse/run/session' />?date="+new Date().getTime(),data:{pid:pid}});
		}
		//提交表单数据生成列表
		 $("#dateListduId").click(function(){
			if(val1 == "") {jAlert("请选择设备及参数!");return;}
			else if(val2 == "") {jAlert("请选择设备及参数!");return;}
			 f = true;
			 $("#Pagination").css('display','block');
			 var count = $('.select-listItem','#energyLeftId .select-list').size();
			 if(parseInt(count) == 0){
				 jAlert('请选择设备及参数!');
				 return;
			 }
			 var url = "<c:url value='/analyse/energyHistoryContent' />";
				$.ajax({
					type:"GET",
					url:url+"?page="+1,
					cache:false,
					data: $("#energyHistoryContentForm").serialize(),
					success:function(data){
						$("#dataListContentId").empty().html(data);
						initPagination($("#countPageId").val());
						$("#excelHistoryId").show();
					}
				});
			});
		//时间列表
		$(document).click(function(){
			$('.my-date-ul').hide().empty();
		})
		$('#smins2h').click(function(){
			var the_ul = $(this).next();
			$('.my-date-ul').hide();
			the_ul.show();
			if(the_ul.children().length == 0){
				for(var i = 0;i < 24;i++){
					if(i<=9){
						var the_li = "<li><a>0" + i +":00</a></li>"
					}else{
						var the_li = "<li><a>" + i +":00</a></li>"
					}
					the_ul.append(the_li);
				}
			}
			the_ul.find('a').click(function(){
					$('.my-date-ul').hide().empty();
					$('#smins2h').attr("value",$(this).text());
			})
			return false;
		});
		$('#emins2h').click(function(){
			var the_ul = $(this).next();
			$('.my-date-ul').hide();
			the_ul.show();
			var min_hour = 0;
			if($('#smins1h').val() == $('#emins1h').val()){
				min_hour = parseInt($('#smins2h').val().substring(0,2)) + 1;
			}
			if(the_ul.children().length == 0){
				for(var i = min_hour;i < 24;i++){
					if(i<=9){
						var the_li = "<li><a>0" + i +":00</a></li>"
					}else{
						var the_li = "<li><a>" + i +":00</a></li>"
					}
					the_ul.append(the_li);
				}
			}
			the_ul.find('a').click(function(){
				$('.my-date-ul').hide().empty();
				$('#emins2h').attr("value",$(this).text());
			})
			return false;
		});
		//提交表单数据生成柱状图
		 $("#datePieId").click(function(){
			 if(val1 == "") {jAlert("请选择设备及参数!");return;}
			else if(val2 == "") {jAlert("请选择设备及参数!");return;}
			 var count = $('.select-listItem','#energyLeftId .select-list').size();
			 if(parseInt(count) == 0){
				 jAlert('请选择设备及参数!');
				 return;
			 }
			 $("#Pagination").css('display','none');
			 
			$.ajax({ 
				type:"POST",
				data: $("#energyHistoryContentForm").serialize(),
				url: "<c:url value='/analyse/energyHistoryPie' />",
				success: function(data){
					$("#dataListContentId").empty().html(data);
					$("#excelHistoryId").hide();
		      }});
			});
		//异步查询左侧标签
		function energyLeft(pid){
			$("energyLeftId").empty();
			 $.ajax({ 
					type:"POST",
					data: {pid:pid},
					url: "<c:url value='/analyse/energyLeftHistory' />",
					success: function(data){
						$("#energyLeftId").html(data);
						initselect();
						$("#dataListContentId").empty();
			      }});
		}
		
		//异步查询左侧标签参数值
		function energyLeftCanshu(){
			$("energyLeftId").empty();
			 
		}
		var val1 = "",val2 = "";
		//初始化下拉框
		function initselect(data){
			//add by Y 2015-02-04 初始化的时候确定按钮失效   只有在选择了参数的时候才生效 begine
			//$("#confirm").css("background","url(<c:url value='/resources/img/bckPwdTime.png' />)");
			$("#confirm").addClass('confirm-disavailable').removeClass('confirm-available');
			//add by Y 2015-02-04 end
			$('#selectSb').simSelect({
				callback: function (x,v) {
					//console.log("x:"+x+" "+"v:" + v);
					if(!x) return;
					val1 = v;
					//加载ajax请求参数内容
					$.ajax({ 
					type:"POST",
					data: {classinstanceid:v},
					url: "<c:url value='/analyse/energyLeftHistoryCanshu' />",
					success: function(data){
						var $cs = $('#selectCs');
						$('ul',$cs).empty().append(data);//参数
						$('.text',$cs).text('选择参数');
						val2 = "";
						$cs.simSelect({
							callback: function (x,v) {
								//console.log("x:"+x+" "+"v:" + v);
								if(!x) return;
								val2 = v;
							}
						});
			      	}});
				}
			});
			//导出
			$("#excelHistoryId").click(function(){
			if (validdata()) {
			
		} else {
              return; 
		}	
				var url="<c:url value='/analyse/energyHistoryExport' />";
				$("#energyHistoryContentForm").attr("action",url);
				$("#energyHistoryContentForm").submit();
			});
			function validdata(){
			 var tabchoicenow=0;
		  var tabchoice=    $ (".select-listItem" ) ;
		   
		   if (tabchoice.size()>0) {
				
			} else {
 				jAlert("提醒:先选择要查看的指标或设备，请重新选择！");return false;
			}
		 var liname="";
		tabchoice .each(function(){
		liname+=$(this).text();
       
    });
    $("#liname").attr("value",liname);
     
    	 
			 var timechoice=    $ ("input[name= 'timeradio']:checked" ) ;
		 var timechoiceval= timechoice   .val();
		 if (timechoiceval.localeCompare("hours") == 0) {
		 var d1=$("#smins1h").val();
		  var d2=$("#smins2h").val();
		   var d3=$("#emins1h").val();
		  var d4=$("#emins2h").val();
		   $("#linametime").attr("value",d1+"号"+d2+"到"+d3+"号"+d4);
		   
		} else  if (timechoiceval.localeCompare("days") == 0) {
			 var d1=$("#sdayh").val();
		  var d2=$("#edayh").val();
		   
		   $("#linametime").attr("value",d1+"到"+d2);
		     
			 
		} else {
            jAlert("时间范围，请重新选择！");return false;
		}
			
		
			return true;
			}
			//确定单击事件
			$('.energyManagement-lssjcx .left-nav #confirm').bind('click', function () {
				if(val1 == "") {$("#confirm").css("background","url(<c:url value='/resources/img/bckPwdTime.png' />)");return;}
				else if(val2 == "") {$("#confirm").css("background","url(<c:url value='/resources/img/bckPwdTime.png' />)");return;}
				$("#confirm").css("background","url(<c:url value='/resources/img/confirm.png' />)");
				var val = val1 + "|" + val2,
					addpro = $('.energyManagement-lssjcx .select-list .select-listItem');
				if (addpro.length > 2) {showErrorMsg("最多三个运行参数进行查询。");return;}//数量大于三
				var flag = false;
				$("input",addpro).each(function(){
					if($(this).val() === val){
						flag = true;
						return false;
					}
				});
				if(flag) return;//有重复的
	
				var $sb = $("#selectSb").find(".cur").text(),
					$sc = $("#selectCs").find(".cur").text();
				var moveE = $('<div class="select-listItem">' + $sb + '-' + $sc + 
							  '<input type="hidden" name="idJihe" value="'+val+'" /><a class="remove"></a></div>');           
	
				moveE.appendTo($('.energyManagement-lssjcx .left-nav .select-list'));
	
				$('.remove').bind('click', function () {
					 $(this).parent('.select-listItem').remove();
				});       
			});
		}
		function showErrorMsg(msg){
    		$(".error").text(msg);
    	}
		$(".tab-nav .last").unbind("click");
		//$("#confirm").off('click');//.css("background","url(<c:url value='/resources/img/bckPwdTime.png' />)")
	});
	//--------------------分页开始-----------------------
			var f = true;
			function initPagination(pagers) {
				// 创建分页
				var rows = $('table','#dataListContentId').find('tr').length;
				if(rows<=1||pagers<=1||pagers==undefined){$("#Pagination").empty();return;}else{
					$("#Pagination").pagination(pagers, {
						num_edge_entries: 1, //边缘页数
						num_display_entries: 4, //主体页数
						callback: pageselectCallback,
						items_per_page: 1, //每页显示1项
						prev_text: "上一页",
						next_text: "下一页"
					});
				}
			 }
			 function pageselectCallback(page_index, jq){
				 if(f){
					 f=false;
					 return;
				}
				//var new_content = $("#hiddenresult div.result:eq("+page_index+")").clone();
					var url = "<c:url value='/analyse/energyHistoryContent' />";
				$.ajax({
					type:"GET",
					url:url+"?page="+(page_index+1),
					data: $("#energyHistoryContentForm").serialize(),
					success:function(data){
						$("#dataListContentId").empty().html(data);
					}
				});
				return false;
			}
		//--------------------分页结束-----------------------
		//add by Y 2015-02-04 begine
		function setConfirm(){
			//$("#confirm").css("background","url(<c:url value='/resources/img/confirm.png' />)");
			$("#confirm").addClass('confirm-available').removeClass('confirm-disavailable');
		}
		//add by Y 2015-02-04 end
		
</script>
	</head>
	<body>
		<jsp:include page="../header.jsp"></jsp:include>
		<div class="nav-nav clear">
			<div class="sel_nav ml10">
				<a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity"><span>${pvo.regionname}</span>-<span>${pvo.parkname}</span>-<span>${pvo.projectname}</span></a>
			</div>
		</div>
		<form id="energyHistoryContentForm" action="/analyse/energyHistoryContent" method="post">
		<input type="hidden" name="instid" value="${instid}"/>
		<input type="hidden"  id="fnzname" name="fnzname" value="${pvo.regionname}-${pvo.parkname}-${pvo.projectname}"/>
		<input type="hidden" id="liname" name="liname" value=""/>
		<input type="hidden" id="linametime" name="linametime" value=""/>
		<div id="container" class="energyManagement-lssjcx">
        <div id="LeftCol" class="LeftCol LeftCol3">
            <div class="left-nav left-nav3 tab">
                <div id="energyLeftId" class="left-in">
                    <div class="tab-nav">
                        <ul class="ml10">
                            <li class="last"><a class="spec">已选运行参数</a></li>
                        </ul>
                    </div>
                    <div class="tab-panel" style="display: block;">
                        <div class="select-list">
                        </div>
                        <p class="tcenter yred mt5 error"></p>
                        <div class="select-contit">
                        <div class="mod-select  mt5" id="selectSb">
                            <p class="text">选择设备</p>
                            <span class="arr-group hand">
                                <i class="icon-mod icon-arr"></i>
                            </span>
                            <div class="list">
                                <ul>
                                </ul>
                            </div>
                        </div>
                        <div class="mod-select mt5" id="selectCs">
                            <p class="text">选择参数</p>
                            <span class="arr-group hand">
                                <i class="icon-mod icon-arr"></i>
                            </span>
                            <div class="list">
                                <ul>
                                </ul>
                            </div>
                        </div>
                            </div>
                        <a class="confirm mauto mt15 dblock" id="confirm">确认</a>
                    </div>
                </div>
            </div>
        </div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft">
            </div>
            <div class="content">
                <div class="topFilter tab">
                    <table class="putform">
                        <tbody><tr>
                            <td class="tleft w60">查看方式：</td>
                            <td class="tleft w100">
                                <div class="tab-nav">
                                    <ul class="fiterTime">
                                        <li class="">
                                            <label>
                                                <input type="radio" name="timeradio" value="hours" checked="checked">小时</label></li>
                                        <li>
                                            <label>
                                                <input type="radio" name="timeradio" value="days">天</label></li>
                                    </ul>
                                </div>
                            </td>
                            <td class="w60">
                                <span class="">时间范围：</span></td>
                            <td class="tleft" style="position:relative;">
                                <div class="fl tab-panel" style="display: block;">
									<input id="smins1h" type="text" name="smins1" class="Wdate itxt w80" style="width: 90px;" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'emins1h\')}'})" autocomplete="off" value="${yDay}">
									<input id="smins2h" type="text" name="smins2" class="Wdate itxt w60 ml10 WdateHour"  autocomplete="off" value="00:00" readonly>
									<ul class="my-date-ul" id="my-date-ul1">
										
									</ul>
									<span class="ml5 mr5">到</span>
									<input id="emins1h" type="text" name="emins1" class="Wdate itxt w80" style="width: 90px;" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'smins1h\')}'})" autocomplete="off" value="${curDay}">
									<input id="emins2h" type="text" name="emins2" class="Wdate itxt w60 ml10 WdateHour" autocomplete="off" value="23:00" readonly>
									<ul class="my-date-ul" id="my-date-ul2">
									</ul>
								</div>
						                <div class="fl tab-panel" style="">
						                    <input id="sdayh" type="text" name="sday" class="Wdate itxt w80" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'edayh\')}'})" autocomplete="off" value="${yDay}">
						                    <span class="ml5 mr5">到</span>
						                    <input id="edayh" type="text" name="eday" class="Wdate itxt w80" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'sdayh\')}'})" autocomplete="off" value="${curDay}"></div>
                                <div class="down-popup fl ml10 view-data">
                                    查看数据
                            <div class="arr-group">
                            </div>
                                    <div class="list">

                                        <ul>
                                            <li id="dateListduId"><a class="sjb"><span class="img"></span><span class="txt">数据表</span></a></li>
                                            <li id="datePieId"><a class="qxb"><span class="img"></span><span class="txt">曲线图</span></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <a id="excelHistoryId" class="fr execl mt5"></a></td>
                        </tr>
                    </tbody></table>
                </div>
                <div class="wrap">	
                	<div id="dataListContentId" class="datalist-content-history" style="height: 300px;overflow: auto;overflow-x:hidden;"></div>
                	 <div class="page mt10">
							<div id="Pagination" class="pagination"></div>
					</div>
                </div>
            </div>
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
		<div class="mod-pop" id="pop-ontime">
        	<div class="hd"><h2>单击日期出现的数据表</h2></div>
        	<div class="bd"></div>
    	</div>
	</body>
</html>
