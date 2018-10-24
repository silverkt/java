<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<script type="text/javascript">
	$(function(){
		
		closeFancybox();
		<%--
		$("#classPropertyForm").validate({
			//errorClass:"errorlabel",
			wrapper:"div",
			rules:{
				typename:"required"
			},
			messages:{
				typename:"属性名称必填"
			}
		});--%>
		//input框禁止使用enter键
		$("#add_classpropertyname").keypress(function (e) {  
            var keyCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;  
            if (keyCode == 13) {
                return false;  
            } else {  
                return true;  
            }  
        });  
		
		//属性名称
		$("#add_classpropertyname").blur(function(){
			if($(this).val() !== ''){
				$("#add_classpropertynameMsg_TR").hide();
			    $("#add_classpropertynameMsg").text("");
			}
		});
        //属性类型
		$('#add_propertytypeSel').simSelect({
			callback: function (x,v) {
				if(v){
				    $("#add_propertytypeid").val(v);
					$("#add_propertytypeidMsg_TR").hide();
			    	$("#add_propertytypeidMsg").text("");
				}
			}
		});
		//属性分类
		$('#add_isdynamicSel').simSelect({
			callback: function (x,v) {
				if(v){
			    	$("#add_isdynamic").val(v);
					$("#add_isdynamicMsg_TR").hide();
			    	$("#add_isdynamicMsg").text("");
			    }
			}
		});
		//属性关联
		$('#add_selfrelatedSel').simSelect({
			callback: function (x,v) {
				if(v){
			    	$("#add_selfrelated").val(v);
			    }
			}
		});
		
		//排序初始化
		 $('.p_rank').find("input[type='radio']").each(function(){
		 	var $radio = $(this);
		 	var v = $radio.val();
		 	var rank = $('#rank').val();
		 	if(rank==null||rank==''){
		 		rank = '1';
		 	}
		 	if(v==rank){
		 		$radio.attr("checked","checked");
		 	}else{
		 		$radio.removeAttr("checked");
		 	}
		 });
		
		//排序数据联动
		 $('.p_rank > input').click(function(){
		 	var $ptd = $(this).parent('td');
		 	$ptd.find("#rank").val($(this).val());
		 });
		
		$("#submitBtn").click(function(){
			if($("#add_classpropertyname").val().trim()== ''){
				$("#add_classpropertynameMsg_TR").show();
				$("#add_classpropertynameMsg").text("属性名称必填");
				return false;
			}else{
				$("#add_classpropertyname").val($("#add_classpropertyname").val().trim());
			}
			if($("#add_classpropertyname").val().length >18){
				$("#add_classpropertynameMsg_TR").show();
				$("#add_classpropertynameMsg").text("属性名称长度不能超过18位");
				return false;
			}
			if($("#add_propertytypeid").val()== ''){
				$("#add_propertytypeidMsg_TR").show();
				$("#add_propertytypeidMsg").text("属性类型必选");
				return false;
			}
			if($("#add_isdynamic").val()== ''){
				$("#add_isdynamicMsg_TR").show();
				$("#add_isdynamicMsg").text("属性分类必选");
				return false;
			}
			var classpropertyid = $("#update_classpropertyid").val();
			var url,vals = $("#classPropertyForm").serialize();
			if(classpropertyid != ""){
				url = "<c:url value='/classProperty/update'/>";
			}else{
				url = "<c:url value='/classProperty/add'/>";
			}
			$.post(url,vals,function(data){
						if (data.success){
							$.fancybox.close();
							if(classpropertyid != ""){
								jAlert("编辑成功！");
							}else{
								jAlert("新增成功！");
							}
							
							if($("#operate").val()== "edit"){
								searchByUpdate(vals);
							}else{
								refreshRight(data.pageClassid);
							}
							//jAlert("保存成功");
						}else {
							jAlert(data.msg);
						}
	        			
	       	});
		})
	
		function refreshRight(sid){
			$.ajax({type:"GET",url:"<c:url value='/classProperty/listRight' />",data:{id:sid},cache:false,
		    	success:function(data){
				$(".wrap").empty().html(data);
		    }});
		}
	})
</script>

<link href="<c:url value='/resources/css/add_pop.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/formerror.css' />" rel="stylesheet" />

<form id="classPropertyForm" action="" method="post">
    <input type="hidden" id="headerid" name="id" value="${id}"/>
    <input type="hidden" id="headermenuid" name="menuid" value="${menuid}"/>
    <input type="hidden" id="add_classid" name="classid" value="${pageClassid}"/>
    <input type="hidden" id="update_classpropertyid" name="classpropertyid" value="${updateObj.classpropertyid}"/>
    <input type="hidden" id="operate" name="operate" value="${operate}"/>
	
	<table class="tblnygl">
                <tr>
                    <td class="tright w80">属性名称：</td>
                    <td><input type="text" id="add_classpropertyname" name="classpropertyname" value="${updateObj.classpropertyname}" class="w200 ttxt txtt2 inputinstancename"/></td>
                </tr>
                <tr id="add_classpropertynameMsg_TR" class="Msg_TR">
					<td></td>
					<td><div class="error-box">
						<label id="add_classpropertynameMsg" class="error"></label></div></td>
				</tr>
                <tr>
                    <td class="tright w80">属性类型：</td>
                    <td>
                        <div class="propertytype mod-select  mt5 xmgl_selct add_propertytypeSel" id="add_propertytypeSel">
							<input type="hidden" id="add_propertytypeid" name="propertytypeid" value="${updateObj.propertytypeid}" />
                            <p class="text">
                            	<c:forEach var="s" items="${typeList}" varStatus="v">
                            		<c:if test="${updateObj.propertytypeid == s.propertytypeid}">${s.typename}</c:if>
                            	</c:forEach>
                            </p>
                            <span class="arr-group hand">
                                <i class="icon-mod icon-arr"></i>
                            </span>
                            <div class="list restyle-list">
                                <ul>
                                	<c:forEach var="s" items="${typeList}" varStatus="v">
	                                	<li val="${s.propertytypeid}"><a href="">${s.typename}</a></li>
									</c:forEach>
                                </ul>
                            </div>

                        </div>
                    </td>
                </tr>
                <tr id="add_propertytypeidMsg_TR" class="Msg_TR">
					<td></td>
					<td><div class="error-box">
						<label id="add_propertytypeidMsg" class="error"></label></div></td>
				</tr>
                <tr>
                    <td class="tright w80">属性分类：</td>
                    <td>
                        <div class="propertyclass mod-select  mt5 xmgl_selct" id="add_isdynamicSel">
							<input type="hidden" id="add_isdynamic" name="isdynamic" value="${updateObj.isdynamic}" />
                            <p class="text">
                            <!-- modify Y 01-09 begine-->
                            	<c:if test="${updateObj.isdynamic == 0}">静态属性</c:if>
                            	<c:if test="${updateObj.isdynamic == 1}">动态属性</c:if>
                            <!-- modify Y 01-09 end-->
                            </p>
                            <span class="arr-group hand">
                                <i class="icon-mod icon-arr"></i>
                            </span>
                            <div class="list" >
                                <ul>
                                    <li val="0"><a href="">静态属性</a></li>
                                    <li val="1"><a href="">动态属性</a></li>
                                </ul>
                            </div>

                        </div>
                    </td>
                </tr>
                <tr id="add_isdynamicMsg_TR" class="Msg_TR">
					<td></td>
					<td><div class="error-box">
						<label id="add_isdynamicMsg" class="error"></label></div></td>
				</tr>
                <tr>
                    <td class="tright w80">属性关联：</td>
                    <td>
                        <div class="propertyrelate mod-select  mt5 xmgl_selct" id="add_selfrelatedSel">
							<input type="hidden" id="add_selfrelated" name="selfrelated" value="${updateObj.selfrelated}" />
							<p class="text ellipsis">
								<c:forEach var="s" items="${addClassList}" varStatus="v">
									<c:if test="${updateObj.selfrelated == s.classpropertyid}" >
									${s.classpropertyname}
		                            </c:if>
	                            </c:forEach>
                            </p>
                            <span class="arr-group hand">
                                <i class="icon-mod icon-arr"></i>
                            </span>
                            <div class="list restyle-list">
                                <ul>
                                	<c:forEach var="s" items="${addClassList}" varStatus="v">
	                                	<li val="${s.classpropertyid}"><a href="" class="ellipsis" title="${s.classpropertyname}">${s.classpropertyname}</a></li>
									</c:forEach>
                                </ul>
                            </div>

                        </div>
                    </td>
                </tr>
				<tr>
					<td class="tright w80">排名顺序：
					</td>
					<td class="p_rank">
						<input type="radio" id="asc" name="rankradio" checked value="1"/>
						<label for="planing">降序排名</label>
						<input type="radio" id="desc" name="rankradio" value="0"/>
						<label for="constraction">升序排名</label>
						<input type="hidden" id="rank" name="rank" value="${updateObj.rank}"/>
					</td>
				</tr>
                <tr>
                    <td class="tright w80">备注：</td>
                    <td>
                        <textarea id="TextArea1" name="remarks" class="TextArea1" cols="20" rows="2"  maxlength=25>${updateObj.remarks}</textarea>
                    </td>
                </tr>

            </table>

            <div class="clear">
                <a class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
                <a id="submitBtn" class="tck-save fr mt15">保存</a>
            </div>
</form>
