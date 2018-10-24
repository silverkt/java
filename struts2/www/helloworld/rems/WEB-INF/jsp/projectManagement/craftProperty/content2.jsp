<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
	$(function(){
		
        //隔行变色
        $("#gysxpz_tbl2").find("tr:odd").attr("class","odd");
        $("#gysxpz_tbl2").find("tr:even").attr("class","even");
        
		//下拉
		$(".mod-select").simSelect({
		    callback: function (x,v) {
		        if(v) $(this).find("input").val(v);
			}
    	});
		
		//切换选项卡
		$(".ygysxpz li").bind("click", function () {
			initRightTab1();
			$(".wrap").empty();
            //$(".ygysxpz li").removeClass("li_sel");
            //$(this).addClass("li_sel");
            //$(".datalist").css("display", "none");
            //$("#gysxpz_tbl" + $(this).attr("checkid")).css("display", "");
        });
		function initRightTab1(){
	        var tabInstanceid = $("#thisInstanceid").val();
	        var tabInstancename = $("#thisInstancename").val();
	        var tabProjectid = $("#thisProjectid").val();
			$.ajax({type:"GET",url:"<c:url value='/craftProperty/listRight' />?new="+new Date().getTime(),data:{id:tabInstanceid,projectid:tabProjectid,instancename:tabInstancename},
		    	success:function(data){
				$(".wrap").empty().html(data);
		    }});
		}
		function initRightTab2(){
	        var pageInstanceid = $("#thisInstanceid").val();
	        var pageInstancename = $("#thisInstancename").val();
	        var pageProjectid = $("#thisProjectid").val();
			$.ajax({type:"GET",url:"<c:url value='/craftProperty/listRightTab2' />?new="+new Date().getTime(),data:{id:pageInstanceid,projectid:pageProjectid,instancename:pageInstancename},
		    	success:function(data){
				$(".wrap").empty().html(data);
		    }});
		}
		
		//修改、删除操作
		$(".opper a").bind("click", function () {
                var flag = true
                if ($(this).attr("class") == "xml_edite2") {
                	//编辑
                    //判断是否有未保存的行
                $(this).parents('tr').siblings('tr').find('.opper a').each(function(){
                    if($(this).attr('class') == 'xml_save'){
                    	jAlert('请先保存编辑内容') 
                         flag = false
                    }

                })
                	
                    if(flag) {
                    $(this).removeClass("xml_edite2").addClass("xml_save");
                    /*$(this).parent("td").parent("tr").children(".txtgysxpz").each(function () {
                        var val = $.trim($(this).text());
                        $(this).html("");
                        $(this).html('<input type="text" style="width: 100%; height: 100%;text-align:left;" value="' + val + '" />');
                    })*/
                    var $tr = $(this).parent("td").parent("tr");
                    
                    $("#tr1").val($tr.find(">td:eq(1)").html().trim());
               		$("#tr2").val($tr.find(">td:eq(2)").html().trim());
               		
               		
                    $tr.find(">td:eq(1)").html('<input type="text" name="datavalue" style="width: 100%; height: 100%;text-align:left;" maxlength=25 value="'+$tr.find(">td:eq(1)").html()+'" />');
                    $tr.find(">td:eq(2)").html('<input type="text" name="remarks" style="width: 100%; height: 100%;text-align:left;" maxlength=25 value="'+$tr.find(">td:eq(2)").html()+'" />');
                    }
                }
                else if ($(this).attr("class") == "xml_save") {
                	<%--保存数据--%>
                	var $this = $(this);
                	<%--获得页面选中的项目ID和设备ID--%>
                	var pageInstanceid = $("#thisInstanceid").val();
                	//var pageProjectid = $("#thisProjectid").val();
                	<%--获得原有的项目ID和设备ID--%>
                	var trInstanceid = $this.parent().find("input[name='pageInstanceid']").val();
                	
                	//var trProjectid = $this.parent().find("input[name='projectid']").val();
                	<%--如果信息中没有项目ID和设备ID，则表示数据库中不存在，需做添加操作，有则做修改操作
                		添加之前需要把页面选中的项目ID和设备ID赋值到对应字段中--%>
                	if(trInstanceid == ""){
                		
						$this.parent().find("input[name='pageInstanceid']").val(pageInstanceid);
                	}
                	//if(trProjectid == ""){
					//	$this.parent().find("input[name='projectid']").val(pageProjectid);
                	//}
                	
        			var obj = $(this).parent().parent();
        			var vals = $("input",$(obj)).serialize();
        			$.ajax({type:"POST",url: "<c:url value='/craftProperty/updateStatic'/>?new="+new Date().getTime(),data:vals,
						success: function(data){
							if(data.success){
								jAlert("编辑成功！");
								$this.parent().find("input[name='classinstanceid']").val(data.returnInstanceid);
							}else{
								jAlert(data.msg);
								var $tr = $this.parent("td").parent("tr");
								$tr.find(">td:eq(1)").html($("#tr1").val());
								$tr.find(">td:eq(2)").html($("#tr2").val());
							}
						},
						error : function(){
							jAlert("编辑失败！");
							var $tr = $this.parent("td").parent("tr");
							$tr.find(">td:eq(1)").html($("#tr1").val());
							$tr.find(">td:eq(2)").html($("#tr2").val());
						}
					});
        			/*
                	$.post("<c:url value='/craftProperty/updateStatic'/>?new="+new Date().getTime(),vals,function(data){
						if (data.success){
							jAlert("编辑成功");
							$this.parent().find("input[name='classinstanceid']").val(data.returnInstanceid);
						}else {
							jAlert(data.msg);
						}
	        		});*/
                	
                    $(this).removeClass("xml_save").addClass("xml_edite2");
                    $(this).parent("td").parent("tr").children(".txtgysxpz").each(function () {
                        var val = $.trim($(this).children("input").val());
                        $(this).html(val);
                    })
                }
                else if ($(this).attr("class") == "xml_del2") {
                	var $this = $(this);
                    jConfirm("确定删除此项吗?","确定",function(r){
                    	 if (r == true){
							var instanceid = $this.parent().find("input[name='classinstanceid']").val();
							var propertyid = $this.parent().find("input[name='propertyid']").val();
	                    	
	                    	//执行删除操作
	                    	
	                    	$.ajax({ 
	                    		type:"POST",
	                    		data:{instanceid:instanceid,propertyid:propertyid},
	                    		url: "<c:url value='/craftProperty/deleteStatic'/>?new="+new Date().getTime(),
	                    		success: function(data){
	                    			if (data.success){
										jAlert("删除成功！");
										initRightTab2();
										$.fancybox.close();
									}else {
										jAlert(data.msg);
									}
	                    		},
	                    		error:function(){
									jAlert("删除失败！");
								}
	                    	});
	                    	
	                    	<%--
	                    	
	                        $.get("<c:url value='/craftProperty/deleteStatic'/>?new="+new Date().getTime(),{"instanceid":instanceid,"propertyid":propertyid},function(data){
								if (data.success){
									jAlert("删除成功");
									initRightTab2();
								}else {
									jAlert(data.msg);
								}
			        			
			        		});
			        		--%>
			        		
	                        if ($(this).parent("td").children("a").hasClass("xml_save")){
	                            var $tr = $(this).parent("td").parent("tr");
			                    $tr.find(">td:eq(1)").html('<input type="text" name="datavalue" style="width: 100%; height: 100%;text-align:left;" value="" maxlength=25/>');
			                    $tr.find(">td:eq(2)").html('<input type="text" name="remarks" style="width: 100%; height: 100%;text-align:left;" value="" maxlength=25/>');
	                        }else{
	                            $(this).parent("td").parent("tr").children(".txtgysxpz").html("");
	                        }
	                    }
                    });
                }
            });
	})
	

	
</script>

                    
                    <div class="datalist-div xmgl-datalist-div">
                        <div class="tblcomhead xmgl-tblcomhead">
                            <span class="h2">${thisInstancename}</span>
                            <ul class="ygysxpz">
                                <li checkid="1">动态属性</li>
                                <li class="li_sel" checkid="2">静态属性</li>
                            </ul>
                        </div>
                        <%--选中的   项目ID、设备ID --%>
                        <input type="hidden" id="thisInstanceid" value="${thisInstanceid}"/>
                        <input type="hidden" id="thisInstancename" value="${thisInstancename}"/>
                        <input type="hidden" id="thisProjectid" value="${thisProjectid}"/>
                        
                        <table id="gysxpz_tbl2" class="datalist nxfx_sbnx datalist2 gysxpz"> 
                            <thead class="sssbgl_thead">
                                <tr>
                                    <td>属性名称</td>
                                    <td>属性值</td>
                                    <td>属性描述</td>
                                    <td>操作</td>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="p" items="${proptyList}">
	                                <tr class="even">
	                                    <td>${p.classpropertyname}</td>
	                                    <td class="txtgysxpz">${p.datavalue}</td>
	                                    <td class="txtgysxpz">${p.remarks}</td>
	                               
	                                    <td class="opper">
                                			<input type="hidden" name="classinstanceid" value="${p.classinstanceid}"/>
                                			<input type="hidden" name="propertyid" value="${p.classpropertyid}"/>
                                			<input type="hidden" id="thisTrInstanceid1" name="pageInstanceid" value="${P.classinstanceid}"/>
                                			<%--
                                			<input type="hidden" id="thisTrProjectid" name="projectid" value="${p.projectid}"/>要更改相应的sql语句、vo
                                			 --%>
	                                    	<shiro:hasPermission name="craftProperty:updateStatic">
	                                    	<a class="xml_edite2"></a>
	                                    	</shiro:hasPermission>
	                                    	<shiro:hasPermission name="craftProperty:deleteStatic">
	                                    	<a class="xml_del2"></a>
	                                    	</shiro:hasPermission>
	                                    </td>
	                                </tr>
                                </c:forEach>
                            </tbody>

                        </table>
                    </div>
                
