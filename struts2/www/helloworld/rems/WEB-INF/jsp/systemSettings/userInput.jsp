<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<script type="text/javascript">
	$(function(){
		//去除IE下弹窗的滚动条
		$('.mod-pop').parent('.fancybox-inner').css('overflow','hidden');

		closeFancybox();
		$("#userForm").validate({
			wrapper:"div",
			rules:{
				userName:{
					remote:"checkUsername?id=${userObj.userId}&temp="+Math.random()
				},
				userShowName:"required",
				
			},
			messages:{
				userName:{
					remote:"用户名已存在",	
				},
				userShowName:"昵称必填",
				
				
			}
		});
		
		
		//邮箱验证
		$("#email").blur(checkEmail);
		
		function checkEmail(){
			var myreg = /^(\w\.?)+\w+@(\w\.?)+\w+\.[a-zA-Z]{2,3}$/;
			$("#emailMsg").hide();
		 	var email = $("#email").val();
		 	if(email!=""){
		 		if(email.indexOf("@")==-1||email.indexOf(".")==-1){
		 			$("#emailError").show();
	    			$("#emailMsg").text("邮箱格式错误"); 
					return false;
		 		}else{
		 			if(!myreg.test(email)){
						$("#emailError").show();
	        			$("#emailMsg").text("邮箱格式错误"); 
	    				return false;
					}else{				
						$("#emailError").hide();
						return true;
					}
		 		}
		 	}else{
		 		$("#emailError").show();
        		$("#emailMsg").text("邮箱必填"); 
        		return false;
		 	}
		}
		
		//身份角色
		$('#sfRole').simSelect({
			callback: function (x,v) {
				if(v){
			    	$("#sfRoleid").val(v);
					$("#sfRoleidMsg_TR").hide();
			    	$("#sfRoleidMsg").text("");
			    }
			}
		});
		//项目角色
		$('#xmRole').simSelect({
			callback: function (x,v) {
				if(v){
			    	$("#xmRoleid").val(v);
					$("#xmRoleidMsg_TR").hide();
			    	$("#xmRoleidMsg").text("");
			    }
			}
		});
		var ztree= null;
		var setting = {check: {enable: true},view:{showIcon: false,expandSpeed: "fast"},data: {simpleData: { enable: true }},callback: {onClick: onClick}};
 		$.ajax({type:"GET",url:"<c:url value='/user/tree' />?_="+new Date().getTime(),data:{'userid':'${userObj.userId}'},success:function(data){
			//console.log(data.length);
			ztree = $.fn.zTree.init($("#rightsManagement"), setting, data);
			$.fn.zTree.getZTreeObj("rightsManagement").expandAll(true);
			//修改时，选中用户原有的权限树
			var ids='${userObj.projectIds}';
			if(ids!==""){
				var idArray=ids.split(",");
				for(var i=0;i<idArray.length;i++){
					id=idArray[i];
					var node = ztree.getNodeByParam("id",id, null);
					//console.log("id:"+node.id+"  level"+node.level+" name"+node.name);
					if(node)
						ztree.checkNode(node, true, true,false);
				}
			}
			$('#rightsManagement').find('span').each(function(){
				//console.log(12121)
				var x = $(this).attr('class')
				if(!x)
					$(this).addClass('ellipsis').attr("style","display:inline-block;width:229px;")
				// console.log(111)
				$(this).attr('class') == 'undefined' ? $(this).addClass('ellipsis') : null 
			})
		}});
		function onClick(event, treeID, treeNode, clickFlag) {

		}
		var flagpwd = false;
		
		/* 取消修改是原始密码验证   chf
		 $("#oldPassword").blur(function(){
			oldPassword = $(this).val();
			var nowUserid = $("#userObjId").val();
			$.post("<c:url value='/user/checkPassword'/>",{userid:nowUserid,oldPassword:oldPassword},function(data){
				if(data){
					$("#oldPasswordMsg_TR").hide();
			    	$("#oldPasswordMsg").text("");
			    	flagpwd = false;
				}else{
					$("#oldPasswordMsg_TR").show();
					$("#oldPasswordMsg").text("原密码错误");
					flagpwd = true;
				}
			})
		});*/
		
		//密码纯数字验证
		$("#password1").blur(function(){
			var password1 = $("#password1").val();
		
			var regpwd = $("#repPwd").val();
			var reg = /^\d+$/;
			var userObjId = $("#userObjId").val();
			if(userObjId != ""){
				if(password1 == ""){
					$("#password1").val("");
					$("#repPwd").val("");
					$("#errorMsg").css("display","none");
					$("#conrimPwdMsg").css("display","none");
				}else if(password1.length<6||password1.length>14){
        				$("#errorMsg").show();
        				$("#pwdMsg").text("长度6-14位，字母区分大小写!"); 
        				return false;	
        		}else if(reg.test(password1)){
        			//console.log('stop reg');
        				$("#errorMsg").show();
        				$("#pwdMsg").text("密码太过简单，使用字母数字组合!"); 
        				return false;
        		}
				else if(password1 == ""){
        			$("#errorMsg").show();
        			$("#pwdMsg").text("密码必填!"); 
        			return false;
        		}else if(password1 == regpwd){
        			$("#conrimPwdMsg").hide();
        			//$("#pwdMsg").text("密码必填!"); 
        			return true;
        		}
				else{
        		 	$("#errorMsg").css("display","none");
        		 	return true;
        			}
		}else{
				if(reg.test(password1)){
				$("#errorMsg").show();
				$("#pwdMsg").text("密码太过简单，使用字母数字组合!");
				return false;	
			}
			else if(password1 == ""){
        		$("#errorMsg").show();
        		$("#pwdMsg").text("密码必填!"); 
        		return false;
        	}else if(password1.length<6||password1.length>14){
        		$("#errorMsg").show();
        		$("#pwdMsg").text("长度6-14位，字母区分大小写!"); 
        		 return false;
        	}else if(password1 == regpwd){
        			$("#conrimPwdMsg").hide();
        			//$("#pwdMsg").text("密码必填!"); 
        			return true;
        		}else{
        		 $("#errorMsg").css("display","none");
        		 return true;
        	} 
			}
		}); 
		
		
		$("#repPwd").blur(function(){
			var userObjId = $("#userObjId").val();
			var password1 = $("#repPwd").val();
			var pwd = $("#password1").val();
			var reg = /^\d+$/;
			if(userObjId == ""){
			//新增
			if(password1 == ""){
        		$("#conrimPwdMsg").show();
        		$("#conrimpwdMsg").text("确认密码必填!"); 
        		return false;
        	}else if(!(password1 == pwd)){
        		$("#conrimPwdMsg").show();
        		$("#conrimpwdMsg").text("新密码和确认密码不一致");
        	}else{
        		 $("#conrimPwdMsg").css("display","none");
        		 return true;
        	}
			}else{
				//修改
				if(pwd == ""){
					$("#errorMsg").css("display","none");
					$("#conrimPwdMsg").css("display","none");
				}else{
			
			if(password1 == ""){
        		$("#conrimPwdMsg").show();
        		$("#conrimpwdMsg").text("确认密码必填!"); 
        		return false;
        	}else if(!(password1 == pwd)){
        		$("#conrimPwdMsg").show();
        		$("#conrimpwdMsg").text("新密码和确认密码不一致");
        	}else{
        		 $("#conrimPwdMsg").css("display","none");
        		 return true;
        	}
				}
			}
			 
		});
		$("#userName").blur(function(){
			if($("#userName").val() != ''){
				$("#usernameError").css("display","none");
			}
		});
		
		/* $("#email").blur(function(){
			if($("#email").val() != ''){
				$("#emailError").css("display","none");
			}
		}); */
		
		$("#userShowName").blur(function(){
			
			if($("#userShowName").val() != ''){
				$("#userShownameError").css("display","none");
			}
		});
		
		$("#submitBtn").click(function(){
			
			//数据权限
			var ids = "";
			var nodes = ztree.getCheckedNodes();
			for(var i=0;i<nodes.length;i++){
				//console.log("id:"+nodes[i].id+"  level"+nodes[i].level+" name"+nodes[i].name);
				if(nodes[i].children.length==0&&nodes[i].level==2){
					var id=nodes[i].id;
					ids=ids+id+",";
				}
			}
			ids=ids.substring(0,ids.length-1);
			$("#ids").val(ids);
			if(flagpwd){
				return false;
			}
			if($("#sfRoleid").val()== ''){
				$("#sfRoleidMsg_TR").show();
				$("#sfRoleidMsg").text("身份角色必选");
				return false;
			}
			
			if($("#xmRoleid").val()== ''){
				$("#xmRoleidMsg_TR").show();
				$("#xmRoleidMsg").text("项目角色必选");
				return false;
			}
			
			
			var userObjId = $("#userObjId").val();
			var reg = /^\d+$/;
			var password1 = $("#repPwd").val();
			var pwd = $("#password1").val();
			/**
			 * 金尚彬
			 * 2014-12-23 17:30:37
			 * 用户名非空验证
			 */
			 //如果是新增
			 if(userObjId == ""){
						if ($("#userName").val() == '') {
							//jAlert("用户名必填");
							$("#usernameError").show();
							$("#usernameMsg").text("用户名必填");
							return false;
						} else if (checkEmail() == false) {
							return false;
						} else if ($("#userShowName").val() == '') {
							$("#userShownameError").show();
							$("#userShownameMsg").text("昵称必填");
							return false;
						} else if (reg.test(password1)) {
							$("#conrimPwdMsg").show();
							$("#conrimpwdMsg").text("密码太过简单，使用字母数字组合!");
							return false;
						} else if (pwd == "") {
							$("#errorMsg").show();
							$("#pwdMsg").text("密码必填!");
							return false;
						} else if (!(password1 == pwd)) {
							$("#conrimPwdMsg").show();
							$("#conrimpwdMsg").text("新密码和确认密码不一致");
							return false;
						} else if (password1.length<6||password1.length>14) {
							$("#conrimPwdMsg").show();
							$("#conrimpwdMsg").text("长度6-14位，字母区分大小写!");
							return false;
						}
					}
					//修改
					else {
						//如果密码为空
						if (pwd == "" && password1 == "") {
							$("#errorMsg").css("display", "none");
							$("#conrimPwdMsg").css("display", "none");
						}
						if (pwd != "") {
							if(reg.test(password1)){
								$("#conrimPwdMsg").show();
								$("#conrimpwdMsg").text("密码太过简单，使用字母数字组合!");
							}
							if (password1.length<6||password1.length>14) {
								$("#conrimPwdMsg").show();
								$("#conrimpwdMsg").text("长度6-14位，字母区分大小写!");
								return false;
							}
							if(password1 == ""){
								$("#conrimPwdMsg").show();
								$("#conrimpwdMsg").text("确认密码必填!");
								return false;
							}
						}
						if (!(password1 == pwd)) {
							$("#conrimPwdMsg").show();
							$("#conrimpwdMsg").text("新密码和确认密码不一致");
							return false;
						}
						if (checkEmail() == false) {
							return false;
						} 

					}

					//判断是添加还是修改，（修改的话，加载过来的userObj不为空，添加则为空）

					var url, vals = $("#userForm").serialize();
					if (userObjId != "") {
						//$("#userForm").attr("action","<c:url value='/user/update'/>");
						url = "<c:url value='/user/update'/>?new="
								+ new Date().getTime();
					} else {
						//$("#userForm").attr("action","<c:url value='/user/add'/>");
						url = "<c:url value='/user/add'/>?new="
								+ new Date().getTime();
					}
					//$("#userForm").submit();
					if (!$("#userForm").valid()) {
						return;
					}
					$.post(url, vals, function(data) {
						if (data != '' && data == "true") {
							var text = "";
							if (userObjId != "") {
								text = "编辑成功！";
							} else {
								text = "新增成功！";
							}
							jAlert(text, "确定", function(r) {
								$.fancybox.close();
								if (r == true) {
									location.replace(location.href);
								}
							});
						} else {
							if (userObjId != "") {
								jAlert("编辑失败！");
							} else {
								jAlert("新增失败！");
							}

						}

					});
				})
	})
</script>
<form id="userForm" action="" method="post" >
    
    <input type="hidden" id="headerid" name="id" value="${id}"/>
    <input type="hidden" id="headermenuid" name="menuid" value="${menuid}"/>
    <input type="hidden" name="isvalId" value="${userObj.isvalId}"/>
	<div class="fl">
		<table class="putform fl">
			<tr>
				<td class="tright w80">
					用户名：
				</td><%--
				 	style="position: absolute;display: table;"
					--%>
				<td class="tleft errordiv">
					<input type="hidden" value="${userObj.userId}" id="userObjId" name="userId" class="w200 ttxt" />
					<input type="text" id="userName" name="userName" value="${userObj.userName}" remote="<c:url value='/user/checkUsername?id=${userObj.userId}'/>" ${empty userObj.userId ? '' : 'readonly="readonly"'} class="w200 ttxt txtt2" />
				</td>
			</tr>
			<tr id="usernameError" class="Msg_TR">
				<td class="tright w80"></td>
				<td><div style="width: 210px; height: 26px; border: 1px solid #FE7C7C; background: #FEF2F2;">
					<label id="usernameMsg" class="error"></label></div></td>
			</tr>
			<%--<c:if test="${userObj != null}">
				<tr>
					<td class="tright w80" style="position: absolute;display: table;">
						原密码：
					</td>
					<td class="tleft errordiv">
						<input type="password" id="oldPassword" class="w200 ttxt" />
						<div style="color: red"><label class="" for="password"></label></div>
					</td>
				</tr>
				<tr id="oldPasswordMsg_TR" class="Msg_TR">
					<td></td>
					<td><div style="width: 210px; height: 26px; border: 1px solid #FE7C7C; background: #FEF2F2;">
						<label id="oldPasswordMsg" class="error"></label></div></td>
				</tr>
			</c:if>
			--%><tr>
				<td class="tright w80">
					新密码：
				</td>
				<td class="tleft errordiv" >
					<input type="password" id="password1" name="password" class="w200 ttxt txtt2"  />
				</td>
			</tr>
			<tr id="errorMsg" class="yhgl_oldPasswordMsg_TR">
				<td class="tright w80"></td>
				<td><div class="yhgl_errordiv yhgl_errordiv2">
					<label id="pwdMsg" class="error yhgl_error"></label></div></td>
			</tr>
			<tr>
				<td class="tright w80">
					确认密码：
				</td>
				<td class="tleft errordiv">
					<input type="password" name="repassword"  id = "repPwd" class="w200 ttxt txtt2" />
				</td>
			</tr>
			<tr id="conrimPwdMsg" class="yhgl_oldPasswordMsg_TR">
				<td class="tright w80"></td>
				<td><div class="yhgl_errordiv">
					<label id="conrimpwdMsg" class="error yhgl_error" ></label></div></td>
			</tr>
			<tr>
				<td class="tright w80">
					昵称：
				</td>
				<td class="tleft errordiv">
					<input id="userShowName" type="text" name="userShowName" value="${userObj.userShowName}" class="w200 ttxt txtt2" maxlength=10 />
				</td>
			</tr>
			<tr id="userShownameError" class="Msg_TR">
				<td class="tright w80"></td>
				<td><div style="width: 210px; height: 26px; border: 1px solid #FE7C7C; background: #FEF2F2;">
					<label id="userShownameMsg" class="error"></label></div></td>
			</tr>
			<tr>
				<td class="tright w80">
					公司名称：
				</td>
				<td class="tleft errordiv">
					<input type="text" name="company" value="${userObj.company}" class="w200 ttxt txtt2" maxlength=20 />
				</td>
			</tr>
			<tr>
				<td class="tright w80">
					公司地址：
				<td class="tleft errordiv">
					<input type="text" name="address" value="${userObj.address}" class="w200 ttxt txtt2" maxlength=25 />
				</td>
			</tr>
			<tr>
				<td class="tright w80">
					邮箱地址：
				</td>
				<td class="tleft errordiv">
					<input type="text"  id="email"  name="emailAddress" value="${userObj.emailAddress}" class="w200 ttxt txtt2" maxlength=30 />
				</td>
			</tr>
			<tr id="emailError" class="Msg_TR">
				<td class="tright w80"></td>
				<td><div style="width: 210px; height: 26px; border: 1px solid #FE7C7C; background: #FEF2F2;">
					<label id="emailMsg" class="error"></label></div></td>
			</tr>
			<tr>
				<td class="tright w80">
					描述：
				</td>
				<td class="tleft errordiv">
					<input type="text" name="remarks" value="${userObj.remarks}"  class="w200 ttxt txtt2" maxlength=40 />
				</td>
			</tr>
			<tr>
				<td class="tright w80">
					身份角色：
				</td>
				<td class="tleft">
				  <div class="yhgl_table">
					<div class="mod-select mt5 yhgl_sfrole" id="sfRole" >
						<p class="text">
							<c:if test="${sysroleObj.sysrolename == null}">身份角色</c:if>
							<c:if test="${sysroleObj.sysrolename != ''}">${sysroleObj.sysrolename}</c:if>
						</p>
						<input type="hidden" value="${sysroleObj.sysroleid}" id="sfRoleid" name="sfRoleid" />
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<div class="list yhgl_list">
							<ul>
								<c:forEach var="s" items="${sysroleList}">
									<li val="${s.sysroleid}">
										<a href="">${s.sysrolename}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
						
					</div>
				
				  </div>
				</td>
			</tr>
			<tr id="sfRoleidMsg_TR" class="yhgl_oldPasswordMsg_TR">
				<td></td>
				<td><div class="yhgl_errordiv">
					<label id="sfRoleidMsg" class="error yhgl_error"></label></div></td>
			</tr>
			<tr>
				<td class="tright w80">
					项目角色：
				</td>
				<td class="tleft">
				  <div class="yhgl_table">
					<input type="hidden" value="${projectroleObj.projectroleid}" id="xmRoleid" name="xmRoleid"  />
					<div class="mod-select mt5 yhgl_sfrole" id="xmRole">
						<p class="text">
							
							<c:if test="${projectroleObj.projectrolename == null}">项目角色</c:if>
							<c:if test="${projectroleObj.projectrolename != ''}">${projectroleObj.projectrolename}</c:if>
						</p>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<div class="list yhgl_list">
							<ul>
								<c:forEach var="p" items="${projectroleList}">
									<li val="${p.projectroleid}">
										<a href="">${p.projectrolename}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>

					<%--<div style="color: red" id="xmRoleidMsg"></div>--%>
				  
				  </div>
				</td>
			</tr>
			<tr id="xmRoleidMsg_TR" class="yhgl_oldPasswordMsg_TR">
				<td></td>
				<td><div class="yhgl_errordiv">
						<label id="xmRoleidMsg" class="error yhgl_error"></label>
					</div>
				</td>
			</tr>
	
		</table>
		<div class="role-container clear">
	
		</div>
	</div>
	<fieldset class="fl yhgl_fl">
		<legend>
			项目权限：
		</legend>
		<div class="yhgl_autooverflow">
			<input type="hidden" id="ids" name="projectIds"/>
			<ul id="rightsManagement" class="ztree yhgl_ztree"></ul>
		</div>
	</fieldset>
	<div class="clear">
		<a class="tck-cancel fr mt15 ml20 closeFancybox yhgl_cancel"
			href="javascript:;">取消</a>
		<a id="submitBtn" class="tck-save fr mt15">保存</a>
	
	</div>
</form>
