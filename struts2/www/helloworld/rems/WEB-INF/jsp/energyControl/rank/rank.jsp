<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- 泛能站排名 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/zTree_v3/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/nygl.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/leftwidth.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/pagination.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/zTree_v3/js/jquery.ztree.excheck-3.5.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
    <script type="text/javascript">
        var tempStr = "",CheckCount = 0,ztree= null;
        $(function() {
		var scrH=$(window).height()- 95;
		$(".LeftCol").css("height",scrH-12);
		$("#areaNames").css("height","auto");
			$(".left-nav").css("height",scrH-45);
			$(".wrap").css("height",scrH-70);
        	var setting = { check: {enable: true,chkStyle: "checkbox"},data: {simpleData: { enable: true }},callback: {onClick: onClick }},
        		pids = null,proids = "";
			$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />",success:function(data){
				ztree = $.fn.zTree.init($("#areaNames"), setting, data);
				$.fn.zTree.getZTreeObj("areaNames").expandAll(true);
				$('#areaNames').find('a').children('span:odd').addClass('ellipsis').css(
					{
						'width':119
						,'display':'inherit'
					});
			}});
			function onClick(event, treeID, treeNode, clickFlag) {}
			//全选
			var clicktimes = 0;
			$("#checkAll").click(function(){
				if(clicktimes == 0){
					ztree.checkAllNodes($(this).removeClass('checkAll_true').addClass('checkAll_true'));
					clicktimes = 1;
				}else{
					ztree.checkAllNodes();
					$(this).removeClass('checkAll_true');
					clicktimes = 0;
				}
				})
				
			//add 2015-01-06 begine
			//复选框自动选中
			$(".ztree").on('click',function(){
				var temp = ztree.getCheckedNodes(false).length;
				if(temp == 0){$("#checkAll").removeClass('checkAll_false').removeClass('checkAll_true').addClass('checkAll_true');			
				}else{$("#checkAll").removeClass('checkAll_false').removeClass('checkAll_true').addClass('checkAll_false');};
				setTimeout(function(){
					var temp = ztree.getCheckedNodes(false).length;
					if(temp == 0){$("#checkAll").removeClass('checkAll_false').removeClass('checkAll_true').addClass('checkAll_true');			
					}else{$("#checkAll").removeClass('checkAll_false').removeClass('checkAll_true').addClass('checkAll_false');};
				},10)
			}) 
			//add 2015-01-06 end
			
			//列表
			$("#lbbut").click(function(){
			//jquery获取复选框值    
            var chk_value =[];//定义一个数组    
            $('input[name="interest"]:checked').each(function(){
            	//遍历每一个名字为interest的复选框，其中选中的执行函数    
                chk_value.push($(this).val());//将选中的值添加到数组chk_value中    
            });
				
				 //数据权限
			var ids = "";
			var nodes = ztree.getCheckedNodes();
			for(var i=0;i<nodes.length;i++){
				if(nodes[i].children.length==0){
					var id=nodes[i].id;
					ids=ids+id+",";
				}
			}
			ids=ids.substring(0,ids.length-1);
			//$("#ids").val(ids);
			//异步之前需要选择排名泛能站
			if (ids == "") {
                jAlert("请选择排名泛能站");
                return false;
            }
			else if(chk_value.length==0){
				jAlert("请选择排名方式");
                return false;
			}
			else{
				$("#fbbutdiv").hide();
				getValue1(0,"",$("#lbbutdiv"),0,0,0);
				$("#lbbutdiv").show();
				$("#exportExcel").show();
				}		
				
			});
			
			
			//属性，项目id，类型，日期
			function getValue1(type,date,obj,stype,sortid,sort){
				proids = getProids();
				pids = getPids();
				if(pids == null || pids == "" || proids == "") return;
				$.ajax({type:"GET",url:"<c:url value='/analyse/rank/table1/' />"+stype,
	    			data:{proids:proids,pids:pids,type:type,date:date,sortid:sortid,sort:sort},
	    			success:function(data){
	    				$(obj).empty().html(data);if(stype == 0) init1();
					}
	    		});
			}
			function init1(){
				//导出
				$("#exportExcel").unbind("click").bind("click", function(){
					var obj = $("#lbbutdiv"),objForm = $("#exportForm");
						type = obj.find(".xmpm_tabsel").attr("val"),
						date = obj.find("#datenow").text();
					proids = getProids();
					pids = getPids();
					if(pids == null || pids == "" || proids == "") return;
					objForm.find("#type").val(type);
					objForm.find("#date").val(date);
					objForm.find("#proids").val(proids);
					objForm.find("#pids").val(pids);
					objForm.find("#sort").val($("#ascOrdesc").val());
					//alert(rankSort(Number($(this).parent().attr("pid"))));
					objForm.submit();
				});
				/*排序升降*/
	           	$(".datalist2 tr td .up","#lbbutdiv").unbind("click").bind("click", function () {
	                $(".datalist2 tr td .up","#lbbutdiv").removeClass("upsel");
	                $(".datalist2 tr td .down","#lbbutdiv").removeClass("downsel");
	                $(this).addClass("upsel");
	                $(this).next("a").removeClass("downsel");
	                var date = $("#lbbutdiv #datenow").text(),
	                	type = $(".xmpm_tab .xmpm_tabsel","#lbbutdiv").attr("val");
	                $("#exportForm").find("#sortid").val($(this).parent().attr("pid"));
	                $("#exportForm").find("#sort").val(rankSort(Number($(this).parent().attr("pid"))));
	                getValue1(type,date,$("#lbbutdiv #lbbuttable tbody"),1,$(this).parent().attr("pid"),rankSort(Number($(this).parent().attr("pid"))));
	            	
	           	});
	            $(".datalist2 tr td .down","#lbbutdiv").unbind("click").bind("click", function () {
	                $(".datalist2 tr td .up","#lbbutdiv").removeClass("upsel");
	                $(".datalist2 tr td .down","#lbbutdiv").removeClass("downsel");
	                $(this).addClass("downsel");
	                $(this).prev("a").removeClass("upsel");
	                var date = $("#lbbutdiv #datenow").text(),
	                	type = $(".xmpm_tab .xmpm_tabsel","#lbbutdiv").attr("val");
	                $("#exportForm").find("#sortid").val($(this).parent().attr("pid"));
	                $("#exportForm").find("#sort").val(rankSort(Number($(this).parent().attr("pid"))));
	               	getValue1(type,date,$("#lbbutdiv #lbbuttable tbody"),1,$(this).parent().attr("pid"),Math.abs(rankSort(Number($(this).parent().attr("pid")))-1));
	            });
	            /*年与日切换*/
	            $(".xmpm_tab li","#lbbutdiv").unbind("click").bind("click", function () {
	                $(".filterdiv input","#lbbutdiv").css("display", "none");
	                $(".xmpm_tab li","#lbbutdiv").removeClass("xmpm_tabsel");
	                $(this).addClass("xmpm_tabsel");
	                var type = $(this).attr("val"),sortid,sort,
	                	$input = $("#lbbutdiv .filterdiv input:eq("+type+")");
	                $input.css("display", "block");
	                $("#lbbutdiv #datenow").text($input.val());
	                if($("#lbbuttable").find(".upsel").length > 0){
	                	sortid = $("#lbbuttable").find(".upsel").parent().attr("pid");
	                	sort = rankSort(Number(sortid));
	                }else{
	                	sortid = $("#lbbuttable").find(".downsel").parent().attr("pid");
	                	sort = Math.abs(rankSort(Number(sortid))-1);
	                }
	                getValue1(type,$input.val(),$("#lbbutdiv #lbbuttable tbody"),1,sortid,sort);
	            });
				
			}
			//分布
			$("#fbbut").click(function(){
				
			//jquery获取复选框值    
            var chk_value =[];//定义一个数组    
            $('input[name="interest"]:checked').each(function(){
            	//遍历每一个名字为interest的复选框，其中选中的执行函数    
                chk_value.push($(this).val());//将选中的值添加到数组chk_value中    
            });
				
				 //数据权限
			var ids = "";
			var nodes = ztree.getCheckedNodes();
			for(var i=0;i<nodes.length;i++){
				if(nodes[i].children.length==0){
					var id=nodes[i].id;
					ids=ids+id+",";
				}
			}
			ids=ids.substring(0,ids.length-1);
			if (ids == "") {
                jAlert("请选择排名泛能站");
                return false;
            }
			else if(chk_value.length==0){
				jAlert("请选择排名方式");
                return false;
			}else{
				$("#lbbutdiv").hide();
				$("#exportExcel").hide();
				$("#fbbutdiv td").filter(".fnzpm_td").empty();
				var $tds = $("#fbbutdiv td").filter(".fnzpm_td");
				pids = getPids();
				if(pids == null || pids == "") return;
				//modify by Y 2015-01-21 保持与输入框顺序一致 begine
				//$(".mySelect_ul input:checkbox:checked").each(function(i){
				$("#mySelect_cont p span").each(function(i){
					//getValue($(this).val(),pids,0,"",$tds[i],0);
					getValue($(this).attr("id"),pids,0,"",$tds[i],0);
				//modify by Y 2015-01-21 保持与输入框顺序一致  end
				});
				$("#fbbutdiv").show();
				}
			})
			//属性，项目id，类型，日期
			function getValue(property,pids,type,date,obj,stype){
				$.ajax({type:"GET",url:"<c:url value='/analyse/rank/table/' />"+stype,
	    			data:{property:property,pids:pids,type:type,date:date},
	    			success:function(data){
	    				$(obj).empty().html(data);init2();
					}
	    		});
			}
			var isFirst = true,$div;
			 function init2(){
	            $(".xmpm_tab li","#fbbutdiv").unbind("click").bind("click", function () {
	            	var type = $(this).attr("val"),
	            		$parentDiv = $(this).parent().parent().parent(),
	            		$input = $parentDiv.find(".filterdiv input:eq("+type+")"),
	            		$table = $parentDiv.find(".fnzpm_innertbl");
	                $parentDiv.find(".filterdiv input").css("display", "none");
	                $(this).parent("ul").children("li").removeClass("xmpm_tabsel");
	                $(this).addClass("xmpm_tabsel");
	                $input.css("display", "inline");
	                $("#datenow",$parentDiv).text($input.val());
	                getValue($("#pro",$parentDiv).val(),pids,type,$input.val(),$table,1);
	            });
	           
	            $(".fancybox","#fbbutdiv").unbind("click").bind("click",function(){
	            	$div = $(this).parent().parent();
	            	isFirst = true;
	            	var text = $div.find('span:first').text()
	            	text = text.substring(0,text.indexOf('('));
	            	getValue3(0,text);
	            });
            }
			
			function getValue3(page,title){
				var type = $div.find(".xmpm_tabsel").attr("val"),
	            	pro = $("#pro",$div).val(),
	            	date = $("#datenow",$div).text(),
	            	$table = $("#pop-onupdate table tbody");
	            $table.empty();
	            $.ajax({type:"GET",url:"<c:url value='/analyse/rank/table/3' />",
	    			data:{property:pro,pids:pids,type:type,date:date,page:page},
	    			success:function(data){
	    				if(data == ""){
	    						$table.empty().html(data);
	    						$('#pop-onupdate').find('.moduleType').text(title);
	    						if(isFirst) initPagination($("#pop-onupdate #count").val());
	    				}else{
	    					$table.empty().html(data);
	    					$('#pop-onupdate').find('.moduleType').text(title);
	    					//modify by Y 2015-01-13 begine
	    					//if(isFirst) initPagination1($("#pop-onupdate #count").val());
	    					var temp = $("#pop-onupdate #count").val()
	    					if(Number(temp) > 1){
	    						if(isFirst) initPagination1($("#pop-onupdate #count").val());
	    					}
	    					//modify by Y 2015-01-13 end
	    				}
					}
	    		});
			}
			
			function initPagination(pager) {
				$("#Pagination").pagination(pager, {
					num_edge_entries: 1, //边缘页数
					num_display_entries: 4, //主体页数
					callback: pageselectCallback,
					items_per_page:1, //每页显示1项
					prev_text: "上一页",
					next_text: "下一页"
				});
			 }
			
			function initPagination1(pager) {
				$("#Pagination").pagination(pager, {
					num_edge_entries: 1, //边缘页数
					num_display_entries: 4, //主体页数
					callback: pageselectCallback,
					items_per_page:1, //每页显示1项
					prev_text: "",
					next_text: ""
				});
			 }
			
			 
			 function pageselectCallback(page_index, jq){
				 if(isFirst) {isFirst = false;return;}
				 getValue3(page_index);
				return false;
			}
			
            /*鼠标点击下拉外隐藏*/
            $(document).click(function (e) {
                var target = $(e.target);
                if(target.is("#mySelect_cont") || target.is('.togle') || target.is('.mySelect_ul_li')){
                	return;
                }
                $('.mySelect_cont').css("display", "none");
                $(".togle").css("background", "url(<c:url value='/resources/img/select-xl.png' />)");
            })
           
            $("#mySelect_cont").text("请选择排名方式");

            /*复选框选择排名选中事件*/
            $(".mySelect_ul li input").change(function () {
            	     /**
        			 * 触发点击checkbox
        			 * 生成一个新的内容加到排名方式中
        			 */ 
                var selId = $(this).val();
                if ($(this).attr("checked")) {
                    CheckCount++;
                    $(this).parent("li").addClass("mySelect_ul_se");
                    tempStr += "<p class='my_p' title><span id=" + selId + ">" + $(this).parent("li").text().trim() + "</span><a></a></p>";
                    if (CheckCount > 6) {
                        $(this).attr("checked", false);
                        $(this).parent("li").removeClass("mySelect_ul_se");
                        CheckCount--;
                        jAlert("最多只能选中六项。");
                        return false;
                    }
                    $("#mySelect_cont").html(tempStr);
					$('#mySelect_cont').find('.my_p').each(function(){
						$(this).attr("title",$(this).children("span").text().trim())
					});
					var my_p_width = 0;
					for (var i = 0;i < $("p.my_p").length;i++ )
					{
						my_p_width += $('.my_p').eq(i).width();
					}
					if (my_p_width > 700)
					{
						$('#mySelect_cont').find("span").addClass('ellipsis').css({
							"width":"50px",
							"height":"20px"
							});
					}
                }else {
                    $(this).parent("li").removeClass("mySelect_ul_se");
                    CheckCount--;
                    $("#mySelect_cont .my_p").each(function (i) {
                        var spanId = $(this).find("span").attr("id");
                        if (spanId == selId) {
                            $(this).remove();
                            tempStr = $("#mySelect_cont").html();
                            return false;
                        }
                    });
                }
                delSpan();
            });
            
            
            $("#mySelect_cont").click(function(){
            	chooseRank($(".togle"));
            })
            $(".togle").click(function(){
            	chooseRank($(this));
            })
        });
        function getPids(){
			var pidx = "";
			$.each(ztree.getCheckedNodes(true),function(){
				if(!this.isParent) pidx += this.id + ","; 
			});
			return pidx;
		}
		function getProids(){
			var pros = "";
			$('p>span','#mySelect_cont').each(function(n,i){
				var $this = $(i)
				, id = $this.attr('id');
				if(id!=''){
					pros+=id+',';
				}
			});
			pros.substring(0,pros.length-1);
			return pros;
		}
        /*删除选中排名*/
        function delSpan() {
            $("#mySelect_cont .my_p a").bind("click", function () {
                var spanId = $(this).parent().find("span").attr("id");
                $(".mySelect_ul li input").each(function () {
                    var inputId = $(this).val();
                    if (inputId == spanId) {
                        $(this).attr("checked", false);
                        $(this).parent("li").removeClass("mySelect_ul_se");
                        return false;
                    }
                })
                CheckCount--;
                $(this).parent().remove();
                tempStr = $("#mySelect_cont").html();
            });
        }
        
   
  
        
        
        /*选中排名显示隐藏*/
        function chooseRank(_this) {
            if ($(".mySelect_cont").css("display") == "none") {
                $(".mySelect_cont").css("display", "block");
                $(_this).css("background", "url(<c:url value='/resources/img/select-xl2.png' />)");
            }
            else {
                $(".mySelect_cont").css("display", "none");
                $(_this).css("background", "url(<c:url value='/resources/img/select-xl.png' />)");
            }
        }
        function On_StartDateChange(_this) {
            $(_this).parent("div").prev("div").children("span").text($(_this).val());
            var $parent = $(_this).parent().parent(), property = $("#pro",$parent).val(),
            	type = $(".xmpm_tabsel",$parent).attr("val"),date = $(_this).val(),obj = $("table",$parent);
            $.ajax({type:"GET",url:"<c:url value='/analyse/rank/table/1' />",
    			data:{property:property,pids:getPids(),type:type,date:date},
    			success:function(data){
    				$(obj).empty().html(data);
				}
    		});
        }
        function On_StartDateChange1(_this) {
            $("#datenow","#lbbutdiv").text($(_this).val());
            var date = $(_this).val(),sortid,sort,obj = $("#lbbutdiv #lbbuttable tbody"),
            	type = $(".xmpm_tabsel","#lbbutdiv").attr("val");
            
            if($("#lbbuttable").find(".upsel").length > 0){
            	sortid = $("#lbbuttable").find(".upsel").parent().attr("pid");
            	sort = rankSort(Number(sortid));
            }else{
            	sortid = $("#lbbuttable").find(".downsel").parent().attr("pid");
            	sort = Math.abs(rankSort(Number(sortid))-1);
            }
            
            obj.empty();
            proids = getProids();
			pids = getPids();
			if(pids == null || pids == "" || proids == "") return;
			$.ajax({type:"GET",url:"<c:url value='/analyse/rank/table1/1' />",
	    		data:{proids:proids,pids:pids,type:type,date:date,sortid:sortid,sort:sort},
	    		success:function(data){
	    			$(obj).empty().html(data);
				}
	    	});
        }
        
        /**
    	 * 排序顺序判定
    	 * 20150113
    	 * man
    	 */
    	function rankSort(sortid){
        	var arr=new Array();
        	<c:forEach items="${propertys}" var="p">
        		var obj={sortid:'${p.classpropertyid}',rank:'${p.rank}'};
        		arr.push(obj);
	       	</c:forEach>
	       	var flag=0;
	       	$.each(arr,function(i,item){
	       		if(item.sortid==sortid) {
	       			flag=item.rank;
	       		}
	       	});
	       	return flag;
    	} 
    </script>
    <style type="text/css">
    	.datalist .even td{border-bottom:1px solid #e6e6e6;}
    </style>
</head>
<body>
	<jsp:include page="../../header.jsp"></jsp:include>
    <form autocomplete="off">
        <div id="container">
            <div id="LeftCol" class="LeftCol LeftCol2" style="background: #fff; position: relative;width: 223px;">
                   <div class="left-nav left-nav2">
                  <div class="area_head" style="width:222px;" id="areaname"><span>选择排名泛能站：</span> </div>
                <div class="ztree" style="width: 100%; height: 20px; line-height: 30px; margin: 0; color: #333333;">
					<ul>
						<li>
							<span id="checkAll" class="button chk checkbox_false_full" style="margin:7px 0 0 18px;" treenode_check=""></span>
							<a treenode_a="" onclick="" target="_blank" style="" title="全选"><span style="position:relative;top:4px;">全选</span></a>
						</li>
					</ul>
                </div>
                <ul id="areaNames" class="ztree" style="width: 211px; margin-top: 0;"></ul>
            </div>
            </div>
            <div id="MainCol" class="MainCol">
                <div id="folderBtn" class="icoLeft"></div>
                <div class="content contentTop">
                    <div class="topFilter tab">
                        <table class="putform">
                            <tr>
                                <td class="w100">选择排名方式：</td>
                                <td style="vertical-align: top; width: 520px;">
                                    <div class="mySelect" style="width: 720px; min-height: 26px;">
                                        <div id="mySelect_cont" style="width: 700px; min-height: 26px;"></div>
                                        <span class="togle"></span>
                                        <div class="mySelect_cont" style="z-index:999;float:right;width:719px;">
                                            <ul class="mySelect_ul">
                                            	<c:forEach items="${propertys}" var="p">
                                            		 <li class="mySelect_ul_li" style="width:719px;">
	                                                    <input name="interest" class="mySelect_ul_li" value="${p.classpropertyid}" type="checkbox" />
	                                                    <span  class="mySelect_ul_li">${p.classpropertyname}</span>
	                                                </li>
                                            	</c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </td>
                                <td class="tleft">
                                    <div class="down-popup fl" style="margin-left:213px;"> 查看数据
                                        <div class="arr-group"></div>
                                        <div class="list">
                                            <ul>
                                                <li><a class="sjb" id="lbbut"><span class="img"></span><span class="txt">列表形式</span></a></li>
                                                <li><a class="zzt" id="fbbut"><span class="img" style="background: url(<c:url value='/resources/img/fenbu.png'/>) no-repeat;"></span><span class="txt">分布形式</span></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <a id="exportExcel" class="fr execl mt5" style="display: none;"></a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="wrap datalist-content-rank">
                    	<div id="lbbutdiv" class="wrap-rank datalist-div " style="border-left: none;display: none; overflow-y:auto;overflow-x:hidden;">
                    	</div>
                        <div class="wrap-rank datalist-div" id="fbbutdiv" style="display:none; border-left: none; overflow-y: auto;padding-bottom: 0px;">
							<table class="fnzpm_cont" style="height: 100%;">
								<tr>
									<td class="fnzpm_td"></td>
									<td class="fnzpm_td"></td>
									<td class="fnzpm_td"></td>
								</tr>
								<tr>
									<td class="fnzpm_td"></td>
									<td class="fnzpm_td"></td>
									<td class="fnzpm_td"></td>
								</tr>
							</table>
						</div>
                    </div>
                </div>
            </div>
        </div>
		<%--弹出层 --%>
        <div class="mod-pop" id="pop-onupdate" style="width: 480px; min-height: 400px;height:auto;">
            <div class="hd">
                <h2 style="float: left; color: #dfe2e4; font-size: 14px;"><span class="moduleType">耗气量</span>排名</h2>
            </div>
            <div class="datalist-div" style="border-bottom: none;">
                <table class="datalist datalistSec ">
                    <thead>
                        <tr>
                            <td>名次</td><td>泛能站</td><td><span class="moduleType">耗气量</span></td>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
                <div class="page mt10">
                	<div id="Pagination" class="pagination"></div>
                </div>
            </div>
        </div>
    </form>
    <form action="<c:url value='/analyse/rank/export' />" id="exportForm">
    	<input type="hidden" name="type" id="type">
    	<input type="hidden" name="date" id="date">
    	<input type="hidden" name="pids" id="pids">
    	<input type="hidden" name="proids" id="proids">
    	<input type="hidden" name="sortid" id="sortid">
    	<input type="hidden" name="sort" id="sort">
    </form>
</body>
</html>