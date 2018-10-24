<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<script type="text/javascript">
	$(function(){
		closeFancybox();
		<%--
		$("#classForm").validate({
			//errorClass:"errorlabel",
			wrapper:"div",
			rules:{
				classname:"required",
				picturepath:"required"
			},
			messages:{
				classname:"类别名称必填",
				picturepath:"未选择图片"
			}
		});
		--%>
		if($("#updateObjClassid").val()==""){
			//所属父类
			$('#parentclassTag').simSelect({
				callback: function (x,v) {
					if(v){
				    	$("#parentclassid").val(v);
						$("#parentclassidMsg_TR").hide();
				    	$("#parentclassidMsg").text("");
				    	
					}
				}
			});
			
			//所属组别
			$('#classtypeTag').simSelect({
				callback: function (x,v) {
					if(v){
				    	$("#classtypeid").val(v);
						$("#classtypeidMsg_TR").hide();
				    	$("#classtypeidMsg").text("");
				    }
				}
			});
		}
		
		
		
		//类名称
		$("#classname").blur(function(){
			$("#classnameMsg_TR").hide();
			$("#classnameMsg").text("");
		});
		//类图片
		$("#picturepath").blur(function(){
			$("#picturepathMsg_TR").hide();
			$("#picturepathMsg").text("");
		});
		$("#submitBtn").click(function(){
			<%--			
			if($("#parentclassid").val()== ''){
				$("#parentclassidMsg_TR").show();
				$("#parentclassidMsg").text("所属类别必选");
				//alert("身份");
				return false;
			}
			
			if($("#classtypeid").val()== ''){
				$("#classtypeidMsg_TR").show();
				$("#classtypeidMsg").text("所属组别必选");
				//jAlert("项目");
				return false;
			}
			--%>
			var dataArray = {},flag = false ,checkFlag = false;
			$("#classForm input","#pop-onupdate").each(function(){
				var name = $(this).attr("name"),value = $(this).val().trim();
				if(name == "classname" && value == ""){
					flag = true;
					$("#classnameMsg_TR").show();
					$("#classnameMsg").text("类名称必填");
				    return false;
				} else if(name == "parentclassid" && value == ""){
				    flag = true;
					$("#parentclassidMsg_TR").show();
					$("#parentclassidMsg").text("所属父类必选");
				    return false;
				} else if(name == "classtypeid" && value == ""){
				    flag = true;
					$("#classtypeidMsg_TR").show();
					$("#classtypeidMsg").text("所属组别必选");
				    return false;
				}
				
				dataArray[name] = value;
			});
			
		
		
			var remark = $("#TextArea1").val().trim();
			var classtypeid = $("#classtypeid").val();
			var parentclassid = $("#parentclassid").val();
			var classname = $("#classname").val().trim();
			var updateObjClassid = $("#updateObjClassid").val();
			var fakePicpath = $("#fakePicpath").val();
			if(flag){ return;}
			else{
				var data = {'classid':updateObjClassid,'pclassid':parentclassid,'classname':classname};
				$.ajax({url: "<c:url value='/classManage/checkClassname'/>",type:"POST",
				cache:false,data:data,async:false,
				success:function(data){
					if(data){
						$("#classnameMsg_TR").show();
						$("#classnameMsg").text("类名称重复");
						return;
					}else{
						submitContent(remark,classtypeid,parentclassid,classname);
					}
					
				},error:function(){
					checkFlag = false;
				}});
			}
		});
	});
	function fileChange(obj){
		$("#myImageName").val($(obj).val());
	}
	function checkClassname(data){
		$.ajax({url: "<c:url value='/classManage/checkClassname'/>",type:"POST",
		cache:false,data:data,async:false,
		success:function(data){
			return data;
		},error:function(){
			return false;
		}});
	}
	function submitContent(remark,classtypeid,parentclassid,classname){
		var url;
		var updateObjClassid = $("#updateObjClassid").val();
		var fakePicpath = $("#fakePicpath").val();
		
		if(updateObjClassid != ""){
			if($("#myImageName").val() != ""){
				var ImageType = $("#myImageName").val().substring($("#myImageName").val().lastIndexOf(".")).toLowerCase();
				if(ImageType!=".jpg" && ImageType!=".gif" && ImageType!=".jpeg" && ImageType!=".png" && ImageType!=".bmp"){
								$("#picturepathMsg_TR").show();
								$("#picturepathMsg").text("图片格式不对");
								return false;
				}
			}else if($("#myImageName").val() == ""){
				$("#picturepathMsg_TR").hide();
			}
			
			url = "<c:url value='/classManage/update'/>";
			$.ajaxFileUpload({url: url,type:"POST",cache:false,
				fileElementId:'picturepath',data: {remarks:remark,classtypeid:classtypeid,parentclassid:parentclassid,classname:classname,updateObjClassid:updateObjClassid,fakePicpath:fakePicpath},dataType:"text",
				success: function(data){
				    if(data == "true"){
						jAlert("编辑成功！","确定",function(r){
							if(r == true){
								$.fancybox.close();
								location.replace(location.href);
							}
						});
				    }else if(data == "Tfalse"){				    	
				        jAlert("编辑失败，一个组别内标准类类树只有唯一根节点！");
				    }
				    else{					    	
						jAlert("编辑失败！");
					
				    }
										
				}
			});
		}else{			
			if($("#myImageName").val() != ""){
				var ImageType = $("#myImageName").val().substring($("#myImageName").val().lastIndexOf(".")).toLowerCase();
				if(ImageType!=".jpg" && ImageType!=".gif" && ImageType!=".jpeg" && ImageType!=".png" && ImageType!=".bmp"){
								$("#picturepathMsg_TR").show();
								$("#picturepathMsg").text("图片格式不对");
								return false;
				}
			}else if($("#myImageName").val() == ""){
				$("#picturepathMsg_TR").hide();
				//$("#picturepathMsg").text("图片格式不对");
				//return true;
			}
				
			url = "<c:url value='/classManage/add'/>";
			$.ajaxFileUpload({url: url,type:"POST",cache:false,
				fileElementId:'picturepath',data: {remarks:remark,classtypeid:classtypeid,parentclassid:parentclassid,classname:classname},dataType:"text",
				success: function(data){
				    if(data == "true"){
						jAlert("新增成功！","确定",function(r){
							if(r == true){
								$.fancybox.close();
								
								location.replace(location.href);  
							}
						});								
				    }
				    else if(data == "Tfalse"){				    	
				        jAlert("新增失败，一个组别内标准类类树只有唯一根节点！");
				    }else{					    	
				        jAlert("新增失败！");
				    }
										
				}
			});
		}
	}
	
	function refreshRight(){
		$.ajax({type:"GET",url:"<c:url value='/classManage/list' />",data:{id:'${id}',menuid:'${menuid}'},cache:false,
	    	success:function(data){
			
	    }});
	}
</script>

<link href="<c:url value='/resources/css/formerror.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/add_pop.css' />" rel="stylesheet" />

<form id="classForm" action="" method="post">
    <input type="hidden" id="headerid" name="id" value="${id}"/>
    <input type="hidden" id="headermenuid" name="menuid" value="${menuid}"/>
    <input type="hidden" id="updateObjClassid" name="classid" value="${classObj.classid}"/>
    <input type="hidden" id="fakePicpath" name="noUpload"  value="${classObj.picturepath}"/>
	
	<table class="tblnygl">
                <tr>
                    <td class="tright w80">类名称：</td>
                    <td class="errordiv">
                        <input type="text" id="classname" name="classname" value="${classObj.classname}" class="inputinstancename w200 ttxt txtt2"/></td>
                </tr>
                <tr id="classnameMsg_TR" class="Msg_TR">
					<td></td>
					<td><div class="error-box">
						<label id="classnameMsg" class="error"></label></div></td>
				</tr>
                <tr>
                    <td class="tright w80">所属父类：</td>
                    <td class="tleft">
					  <div style="display:table;">
						<div id="parentclassTag" class="parentclassTag mod-select  mt5 xmgl_selct">
							<p class="text">
								<c:forEach var="s" items="${parentlist}">
									<c:if test="${classObj.parentclassid == s.classid}">${s.classname}</c:if>
								</c:forEach>
							</p>
							<input type="hidden" id="parentclassid" name="parentclassid" value="${classObj.parentclassid}" />
							<span class="arr-group hand"> 
								<i class="icon-mod icon-arr"></i>
							</span>
							<div class="list" id="plist">
								<ul>
									<c:choose>
										<c:when test="${not empty parentlist}">
											<c:forEach var="s" items="${parentlist}">
												<li val="${s.classid}">
													<a href="">${s.classname}</a>
												</li>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<li val="-1">
													<a href="">无父标准类</a>
											</li>
										</c:otherwise>
									</c:choose>
								</ul>
							</div>
						</div>
					  </div>
					</td>
                </tr>
				<tr id="parentclassidMsg_TR" class="Msg_TR">
					<td></td>
					<td><div class="error-box">
						<label id="parentclassidMsg" class="error"></label></div></td>
				</tr>
                <tr>
                    <td class="tright w80">所属组别：</td>
                    <td class="tleft">
					  <div style="display:table;">
						<div id="classtypeTag" class="classtypeTag mod-select  mt5 xmgl_selct">
							<p class="text">
								<c:forEach var="s" items="${formatList}">
									<c:if test="${classObj.classtypeid == s.formatid}">${s.formatname}</c:if>
								</c:forEach>
							</p>
							<input type="hidden" id="classtypeid" name="classtypeid" value="${classObj.classtypeid}" />
							<span class="arr-group hand"> 
								<i class="icon-mod icon-arr"></i>
							</span>
							<div class="list restyle-list">
								<ul>
									<c:forEach var="s" items="${formatList}">
										<li val="${s.formatid}">
											<a href="">${s.formatname}</a>
										</li>
									</c:forEach>
								</ul>
							</div>
							
						</div>
					
					  </div>
					</td>
                </tr>
				<tr id="classtypeidMsg_TR" class="Msg_TR">
					<td></td>
					<td><div class="error-box">
						<label id="classtypeidMsg" class="error"></label></div></td>
				</tr>
                <tr>
                    <td class="tright w80">类图片：</td>
                    <td class="errordiv">
                    <c:forEach	items="${parentlist}" var="p">
                    		
                    </c:forEach>
                        <%--<input type="file" id="picturepath" name="file" value="${classObj.picturepath}" style="border: 1px solid #C9CED1;" />
                    	--%><input name="file" id="picturepath"  type="file" onchange="fileChange(this);" class="inputImage">
            			<input id="myImageName" name ='fakePicturepath' class="imageName w200 ttxt txtt2" type="text"  placeholder="请选择文件"  value="${classObj.picturepath}">
                    </td>
                </tr>
                <tr id="picturepathMsg_TR" class="Msg_TR">
					<td></td>
					<td><div class="error-box">
						<label id="picturepathMsg" class="error"></label></div></td>
				</tr>
                <tr>
                    <td class="tright w80">备注：</td>
                    <td>
                        <textarea id="TextArea1" class="TextArea1" name="remarks" cols="20" rows="2">${classObj.remarks}</textarea>
                    </td>
                </tr>

            </table>

            <div class="clear">
                <a class="bzlgl-add-cancel tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
                <a id="submitBtn" class="tck-save fr mt15">保存</a>

            </div>
</form>
