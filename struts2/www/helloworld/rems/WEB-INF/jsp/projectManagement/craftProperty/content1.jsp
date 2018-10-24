<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
	$(function(){ 
        //显示单位title
        $('tr').each(
            function() {
                var content_unit = $(this).find('.ellipsis').eq(0).html();
                $(this).find('.gysxpz_select').eq(0).attr("title",$.trim(content_unit));
        });
		
        //隔行变色
        $("#gysxpz_tbl1").find("tr:odd").attr("class","odd");
        $("#gysxpz_tbl1").find("tr:even").attr("class","even");
        
        function initSelect(obj){
        	$(".mod-select",obj).simSelect({
		        callback: function (x,v) {
            		if(v) $(this).find("input").val(v);
		        }
		    });
        }
        
		
		//切换选项卡
		$(".ygysxpz li").bind("click", function () {
			initRightTab2();
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
                    });*/
                    var array=[];
                    var $tr = $(this).parent("td").parent("tr");
                    $('.gysxpz_select',$tr).each(function(){
                    	var $this = $(this)
                    	  , t, v
                    	  , tWrap = $this.find('.text')
                    	  , vWrap = $this.find('li').eq(0)
                    	  t = vWrap.children('a').text()
                    		v = vWrap.attr('val')
                    		
                    	if(tWrap.text().trim().length == 0){
                    		t = vWrap.children('a').text()
                    		v = vWrap.attr('val')
                    		
                    		tWrap.text(t)
                    		$this.find('input').val(v)
                    	}
                    	array.push($this.find('.text').text().trim().toString());
                    });
                    $("#tr3").val(array.toString());
                    initSelect($tr);
                   	$("#tr1").val($tr.find(">td:eq(1)").text().trim());
               		$("#tr2").val($tr.find(">td:eq(2)").text().trim());
                    $tr.find(">td:eq(1)").html('<input type="text" name="sitecode" style="width: 100%; height: 100%;text-align:left;" maxlength=25 value="'+$tr.find(">td:eq(1)").html()+'" />');
                    $tr.find(">td:eq(2)").html('<input type="text" name="classinsprodes" style="width: 100%; height: 100%;text-align:left;" maxlength=25 value="'+$tr.find(">td:eq(2)").html()+'" />');
                }
                	
                }
                else if ($(this).attr("class") == "xml_save") {
                	$(".mod-select").unbind("click");
                	<%--保存数据--%>
        			var $this = $(this);
                	<%--获得页面选中的项目ID和设备ID--%>
                	var pageInstanceid = $("#thisInstanceid").val();
                	var pageProjectid = $("#thisProjectid").val();
                	<%--获得原有的项目ID和设备ID--%>
                	var trInstanceid = $this.parent().find("input[name='pageInstanceid']").val();
                	var trProjectid = $this.parent().find("input[name='projectid']").val();
                	<%--如果信息中没有项目ID和设备ID，则表示数据库中不存在，需做添加操作，有则做修改操作
                		添加之前需要把页面选中的项目ID和设备ID赋值到对应字段中--%>
                	if(trInstanceid == ""){	
						$this.parent().find("input[name='pageInstanceid']").val(pageInstanceid);
                	}
                	if(trProjectid == ""){
						$this.parent().find("input[name='projectid']").val(pageProjectid);
                	}
                	var obj = $(this).parent().parent();
                	
        			var vals = $("input",$(obj)).serialize();
        			
        			$.ajax({ 
	                    		type:"POST",
	                    		data:vals,
	                    		url: "<c:url value='/craftProperty/update'/>?new="+new Date().getTime(),
	                    		success: function(data){
	                    			if (data.success){
										jAlert("编辑成功！");
										$this.parent().find("input[name='classinstanceid']").val(data.returnInstanceid);
										//gong$.fancybox.close();
									}else {
										jAlert(data.msg);
										var $tr = $this.parent("td").parent("tr");
										$tr.find(">td:eq(1)").html($("#tr1").val());
										$tr.find(">td:eq(2)").html($("#tr2").val());
										if($("#tr1").val()==""){
											$('.gysxpz_select',$tr).each(function(){
						                    	var $this = $(this)
						                    	  , t, v
						                    	  , tWrap = $this.find('.text')
						                    	  , vWrap = $this.find('li').eq(0)
						                    	  t = vWrap.children('a').text()
						                    		v = vWrap.attr('val')
						                    		
						                    		t = vWrap.children('a').text()
						                    		v = vWrap.attr('val')
						                    		
						                    		tWrap.text('')
						                    		$this.find('input').val('')
						                    	
						                    });
													
										}else{
											var array=(($("#tr3").val()).toString()).split(",");
											$('.gysxpz_select',$tr).each(function(i,item){
						                    	var $this = $(this)
						                    	  , t, v
						                    	  , tWrap = $this.find('.text')
						                    	  , vWrap = $this.find('li').eq(0)
						                    	  t = vWrap.children('a').text()
						                    		v = vWrap.attr('val')
						                    		
						                    		t = vWrap.children('a').text()
						                    		v = vWrap.attr('val')
						                    		
						                    		tWrap.text(array[i]); //变更
						                    		$this.find('input').val('')
						                    	
						                    });
										}
									}
	                    		},
	                    		error:function(){
									jAlert("编辑失败！");
									var $tr = $this.parent("td").parent("tr");
									$tr.find(">td:eq(1)").html($("#tr1").val());
									$tr.find(">td:eq(2)").html($("#tr2").val());
									if($("#tr1").val()==""){
										$('.gysxpz_select',$tr).each(function(){
					                    	var $this = $(this)
					                    	  , t, v
					                    	  , tWrap = $this.find('.text')
					                    	  , vWrap = $this.find('li').eq(0)
					                    	  t = vWrap.children('a').text()
					                    		v = vWrap.attr('val')
					                    		
					                    		t = vWrap.children('a').text()
					                    		v = vWrap.attr('val')
					                    		
					                    		tWrap.text('')
					                    		$this.find('input').val('')
					                    	
					                    });
												
									}else{
										var array=(($("#tr3").val()).toString()).split(",");
										$('.gysxpz_select',$tr).each(function(i,item){
					                    	var $this = $(this)
					                    	  , t, v
					                    	  , tWrap = $this.find('.text')
					                    	  , vWrap = $this.find('li').eq(0)
					                    	  t = vWrap.children('a').text()
					                    		v = vWrap.attr('val')
					                    		
					                    		t = vWrap.children('a').text()
					                    		v = vWrap.attr('val')
					                    		
					                    		tWrap.text(array[i]); //变更
					                    		$this.find('input').val('')
					                    	
					                    });
									}
								}
	                    	});
        			
        			
        			<%--
                	$.post("<c:url value='/craftProperty/update'/>?new="+new Date().getTime(),vals,function(data){
						if (data.success){
							jAlert("编辑成功");
							$this.parent().find("input[name='classinstanceid']").val(data.returnInstanceid);
						}else {
							jAlert(data.msg);
							
							var $tr = $this.parent("td").parent("tr");
							$('.gysxpz_select',$tr).each(function(){
		                    	var $this = $(this)
		                    	  , t, v
		                    	  , tWrap = $this.find('.text')
		                    	  , vWrap = $this.find('li').eq(0)
		                    	  t = vWrap.children('a').text()
		                    		v = vWrap.attr('val')
		                    		
		                    		t = vWrap.children('a').text()
		                    		v = vWrap.attr('val')
		                    		
		                    		tWrap.text('')
		                    		$this.find('input').val('')
		                    	
		                    });
						}
	        			
	        		});
        			--%>
        			
                    $(this).removeClass("xml_save").addClass("xml_edite2");
                    $(this).parent("td").parent("tr").children(".txtgysxpz").each(function () {
                        var val = $.trim($(this).children("input").val());
                        $(this).html(val);
                    });
                }
                else if ($(this).attr("class") == "xml_del2") {
                	var $this = $(this);
                    jConfirm("确定删除此项吗?","确定",function(r){
                    	if(r==true) {
							var instanceid = $this.parent().find("input[name='classinstanceid']").val();
							var propertyid = $this.parent().find("input[name='classpropertyid']").val();
	                    	
	                    	//执行删除操作
	                    	
	                    	$.ajax({ 
	                    		type:"POST",
	                    		data:{instanceid:instanceid,propertyid:propertyid},
	                    		url: "<c:url value='/craftProperty/delete'/>?_="+new Date().getTime(),
	                    		success: function(data){
	                    			if (data.success){
										jAlert("删除成功！");
										initRightTab1();
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
	                        $.get("<c:url value='/craftProperty/delete'/>?new="+new Date().getTime(),{"instanceid":instanceid,"propertyid":propertyid},function(data){
								if (data.success){
									jAlert("删除成功");
									initRightTab1();
								}else {
									jAlert(data.msg);
								}
			        			
			        		});
	                        
	                        --%>
	                        if ($(this).parent("td").children("a").hasClass("xml_save")){
	                    		var $tr = $(this).parent("td").parent("tr");
	                    		$tr.find(">td:eq(1)").html('<input type="text" name="sitecode" style="width: 100%; height: 100%;text-align:left;" maxlength=25 value="" />');
	                    		$tr.find(">td:eq(2)").html('<input type="text" name="classinsprodes" style="width: 100%; height: 100%;text-align:left;" maxlength=25 value="" />');
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
                                <li class="li_sel" checkid="1">动态属性</li>
                                <li checkid="2">静态属性</li>
                            </ul>
                        </div>
                        <%--选中的   项目ID、设备ID、设备名称 --%>
                        <input type="hidden" id="thisInstanceid" value="${thisInstanceid}"/>
                        <input type="hidden" id="thisInstancename" value="${thisInstancename}"/>
                        <input type="hidden" id="thisProjectid" value="${thisProjectid}"/>
                        <table id="gysxpz_tbl1" class="datalist nxfx_sbnx datalist2 gysxpz"> 
                            <thead class="sssbgl_thead">
                                <tr>
                                    <td>属性名称</td>
                                    <td>采集点编码</td>
                                    <td>属性描述</td>
                                    <td>单位</td>
                                    <td>小时融合方式</td>
                                    <td>天融合方式</td>
                                    <td>月融合方式</td>
                                    <td>年融合方式</td>
                                    <td>操作</td>
                                </tr>
                            </thead>
                            <tbody>
                            	
                                <c:forEach var="s" items="${proptyList}" varStatus="v">
                                <tr class="even">
                                    <td>${s.classpropertyname}</td>
                                    <td class="txtgysxpz">${s.sitecode}</td>
                                    <td class="txtgysxpz">${s.classinsprodes}</td>
                                    <td class="gysxpz_select">
                                        <div class="mod-select  mt5">
                                            <input type="hidden" name="unitid" value="${s.unitid}"/>
                                            <p class="text ellipsis">
                                            	<c:forEach var="u" items="${unitList}">
                                            		<c:if test="${s.unitid == u.unitid}">${u.unitname}</c:if>
                                            	</c:forEach>
                                            </p>
                                            <span class="arr-group hand">
                                                <i class="icon-mod icon-arr"></i>
                                            </span>
                                            <div class="list">
                                                <ul>
                                                	<c:forEach var="u" items="${unitList}">
                                                    	<li val="${u.unitid}"><a class="ellipsis" title="${u.unitname}" href="">${u.unitname}</a></li>
                                                	</c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                    <td  class="gysxpz_select">
                                         <div class="mod-select  mt5">
                                            <input type="hidden" name="houraggrtypeid" value="${s.houraggrtypeid}"/>
                                            <p class="text ellipsis">
                                            	<c:forEach var="u" items="${aggregateList}">
                                            		<c:if test="${s.houraggrtypeid == u.aggrtypeid}">${u.aggrtypename}</c:if>
                                            	</c:forEach>
                                            </p>
                                            <span class="arr-group hand">
                                                <i class="icon-mod icon-arr"></i>
                                            </span>
                                            <div class="list">
                                                <ul>
                                                	<c:forEach var="u" items="${aggregateList}">
                                                    	<li val="${u.aggrtypeid}"><a class="ellipsis" title="${u.aggrtypename}" href="">${u.aggrtypename}</a></li>
                                                	</c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                    <td  class="gysxpz_select">
                                         <div class="mod-select  mt5">
                                            <input type="hidden" name="dayaggrtypeid" value="${s.dayaggrtypeid}"/>
                                            <p class="text ellipsis">
                                            	<c:forEach var="u" items="${aggregateList}">
                                            		<c:if test="${s.dayaggrtypeid == u.aggrtypeid}">${u.aggrtypename}</c:if>
                                            	</c:forEach>
                                            </p>
                                            <span class="arr-group hand">
                                                <i class="icon-mod icon-arr"></i>
                                            </span>
                                            <div class="list">
                                                <ul>
                                                	<c:forEach var="u" items="${aggregateList}">
                                                    	<li val="${u.aggrtypeid}"><a class="ellipsis" title="${u.aggrtypename}" href="">${u.aggrtypename}</a></li>
                                                	</c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                    <td  class="gysxpz_select">
                                         <div class="mod-select  mt5">
                                            <input type="hidden" name="monaggrtypeid" value="${s.monaggrtypeid}"/>
                                            <p class="text ellipsis">
                                            	<c:forEach var="u" items="${aggregateList}">
                                            		<c:if test="${s.monaggrtypeid == u.aggrtypeid}">${u.aggrtypename}</c:if>
                                            	</c:forEach>
                                            </p>
                                            <span class="arr-group hand">
                                                <i class="icon-mod icon-arr"></i>
                                            </span>
                                            <div class="list">
                                                <ul>
                                                	<c:forEach var="u" items="${aggregateList}">
                                                    	<li val="${u.aggrtypeid}"><a class="ellipsis" title="${u.aggrtypename}" href="">${u.aggrtypename}</a></li>
                                                	</c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                    <td  class="gysxpz_select">
                                         <div class="mod-select  mt5">
                                            <input type="hidden" name="yearaggrtypeid" value="${s.yearaggrtypeid}"/>
                                            <p class="text ellipsis">
                                            	<c:forEach var="u" items="${aggregateList}">
                                            		<c:if test="${s.yearaggrtypeid == u.aggrtypeid}">${u.aggrtypename}</c:if>
                                            	</c:forEach>
                                            </p>
                                            <span class="arr-group hand">
                                                <i class="icon-mod icon-arr"></i>
                                            </span>
                                            <div class="list">
                                                <ul>
                                                	<c:forEach var="u" items="${aggregateList}">
                                                    	<li val="${u.aggrtypeid}"><a href="">${u.aggrtypename}</a></li>
                                                	</c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="opper">
                                		<input type="hidden" name="classinstanceid" value="${s.classinstanceid}"/>
                                		<input type="hidden" name="classpropertyid" value="${s.classpropertyid}"/>
                                		<input type="hidden" id="thisTrProjectid" name="projectid" value="${s.projectid}"/>
                                		<input type="hidden" id="thisTrInstanceid" name="pageInstanceid" value="${s.classinstanceid}"/>
                                    	<shiro:hasPermission name="craftProperty:update">
                                    	<a class="xml_edite2"></a>
                                    	</shiro:hasPermission>
                                    	<shiro:hasPermission name="craftProperty:delete">
                                    	<a class="xml_del2"></a>
                                    	</shiro:hasPermission>
                                    </td>
                                </tr>
                                </c:forEach>
                                
                            </tbody>

                        </table>
                        
                    </div>
                
