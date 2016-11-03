<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>

<script type="text/javascript">
	$(function(){
	
		closeFancybox();
		 jQuery.validator.addMethod("ismypassword", function(value, element,param) {
			 			if(!value) return true;
				        var regu1 =/[A-Za-z]/, regu2=/\d/,regu3=/[!,.@#$%^&*?_~]/;
				        var b1=regu1.test(value),b2=regu2.test(value);
				        var b=b1&&b2;
				    return b == eval(param);
				 }, "密码太过简单,请使用字母数字组合"); 

            $("#infoForm").validate({
                onkeyup: false, 
                wrapper:"div",
                rules:{
                    userShowName:"required",
                    password:{
                        required:false,
                        minlength:6,
                        maxlength:14,
                        ismypassword:true
                    },
                    repassword:{
                        required:false,
                        equalTo:"#password"
                    },
                    emailAddress:"email"
                },
                messages:{
                    userShowName:"昵称必填",
                    password:{
                        required:"密码必填",
                        minlength:jQuery.format(" 密码长度不少于 {0} 位 "),
                        maxlength:jQuery.format(" 密码长度不超过 {0} 位 ")
                    },
                    repassword:{
                        required:"确认密码必填",
                        equalTo:"新密码与确认密码输入不一致！"
                    },
                    emailAddress:"格式有误"
                }
            });
		
		var flagOldpwd = true;
		$("#oldPassword").blur(function(){
			oldPassword = $(this).val();
			var nowUserid = $("#currentUserid").val();//
			if(oldPassword==""){
				$("#oldPasswordMsg_TR").show();
				$("#oldPasswordMsg").text("请输入原密码");
				flagOldpwd = true;
				return;
			}
			$.post("<c:url value='/user/checkPassword'/>",{userid:nowUserid,oldPassword:oldPassword},function(data){
				if(data){
					$("#oldPasswordMsg_TR").hide();
			    	$("#oldPasswordMsg").text("");
			    	flagOldpwd = false;
			    	$("#infoForm input").attr("disabled",false);
				}else{
					$("#oldPasswordMsg_TR").show();
					$("#oldPasswordMsg").text("原密码错误");
					flagOldpwd = true;
				}
			})
		});
		$("#updateCurrentBtn").click(function(){
			
			if($("#oldPassword").val()==''){
				$("#oldPasswordMsg_TR").show();
				$("#oldPasswordMsg").text("请输入原密码");
				return false;
			}
			if($("#oldPassword").val()!='' && flagOldpwd){
				$("#oldPasswordMsg_TR").show();
				$("#oldPasswordMsg").text("原密码错误");
				return false;
			}
			if($("#infoForm").valid()){
				$.ajax({type:"POST",url:"<c:url value='/user/updateCurrentUser'/>",data:$("#infoForm").serialize(),
						success:function(data){
							if (data.success){
								jAlert("编辑成功！");
								$.fancybox.close();
							}else {
								jAlert(data.msg);
							}
						},
						error:function(){
							jAlert("保存失败！");
						}
				});
			}
			
		});
	});
</script>
<style>

form label.error{background: url(<c:url value='/resources/img/erroicon.png)'/> no-repeat;}

</style>
    
<form id="infoForm">
	<input type="hidden" id="currentUserid" name="userId" value="${loginUser.userId}"/>
    
            <div class="fl">
	            <table class="putform fl">
					<tr>
						<td class="tright w80 yhgl_tright">昵称：</td>
						<td class="tleft errordiv">
							<input type="text" name="userShowName" value="${loginUser.userShowName}" class="w200 ttxt" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="tright w80 yhgl_tright">原密码：</td>
						<td class="tleft errordiv">
							<input type="password" id="oldPassword" name="oldPassword" class="w200 ttxt" />
						</td>
					</tr>
					<tr id="oldPasswordMsg_TR" class="yhgl_oldPasswordMsg_TR">
						<td></td>
						<td><div class="yhgl_errordiv">
							<label id="oldPasswordMsg" style="background: url(<c:url value='/resources/img/erroicon.png)'/> no-repeat;" class="error yhgl_error"></label></div></td>
					</tr>
					<tr>
						<td class="tright w80 yhgl_tright">新密码：</td>
						<td class="tleft errordiv">
							<input type="password" id="password" name="password" class="w200 ttxt" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="tright w80 yhgl_tright">确认密码：</td>
						<td class="tleft errordiv">
							<input type="password" name="repassword" class="w200 ttxt" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="tright w80">公司名称：</td>
						<td class="tleft errordiv">
							<input type="text" name="company" value="${loginUser.company}" class="w200 ttxt" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="tright w80">公司地址：</td>
						<td class="tleft errordiv">
							<input type="text" name="address" value="${loginUser.address}" class="w200 ttxt" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="tright w80 yhgl_tright">邮箱地址：</td>
						<td class="tleft errordiv">
							<input type="text" name="emailAddress" value="${loginUser.emailAddress}" class="w200 ttxt" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="tright w80">描述：</td>
						<td class="tleft errordiv">
							<input type="text" name="remarks" value="${loginUser.remarks}"  class="w200 ttxt" disabled="disabled" />
						</td>
					</tr>
				</table>
                <div class="role-container clear"></div>
            </div>
            <div class="clear">
                <a class="yhgl_cancel tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
                <a id="updateCurrentBtn" class="tck-save fr mt15">保存</a>
            </div>
</form>
