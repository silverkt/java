<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="<c:url value='/resources/css/backPwd.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
     <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
    <script type="text/javascript">
        $(document).ready(function () {
        	$("#cont1 #updateImg").click(function(){
        	   <%--<c:url value='/resources/img/kaptcha.jpg' />
        		$("#changeImg").src="/resources/img/kaptcha.jpg?"+Math.floor(Math.random()*100);
        	    $("#changeImg").src="<c:url value='/resources/img/kaptcha.jpg?"+Math.floor(Math.random()*100)+"' />";
        	    $("#changeImg").attr('src', '/resources/img/kaptcha.jpg?' + Math.floor(Math.random()*100) );--%>
        	    $("#changeImg").attr('src', "<c:url value='/resources/img/kaptcha.jpg?"+Math.floor(Math.random()*100)+"' />" );
        	   
           });
        	
        	var uname="";
           $("#cont1 #next").click(function(){
        	   $("#img_error").html("");
        	   $("#user_error").html("");
        	   //判断用户名（邮箱）是否合法
        	   //var s=isEmail($("#cont1 #username").val());
        	   //判断用户名是否合法，合法跳到下一页，邮箱
        	   $.ajax({type:"get",url:"<c:url value='/forget/getUname' />?new="+new Date().getTime(),data:{userName:$("#cont1 #username").val(),code:$("#cont1 #received").val()},
	    		success:function(data){
	    			if(data.success){
	    				uname=data.userName;
	    				$("#uname").text(data.userName);
	    				$("#email").val(data.email);
	    				$("input[name='username']").val(data.userName);
	    				next(2);
	    			}else{
	    				$("#img_error").html(data.msg);
	    				$("#user_error").html(data.message);
	    			}
	    		 }	
	    	   });
           });
           
           /*function isEmail(str){
        	   var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
		       return reg.test(str);
           }*/
           
           $("#cont2 #saveCode").click(function(){
        	   
        	   if($("#cont2 #code").val()==""){
        		   $("#errorCode").text("请输入邮箱验证码！");
        		   return false;
        	   }
        	   $("#errorCode").text("");
        	   
        	   //判断验证码是否合法，合法跳到下一页
        	   $.ajax({type:"POST",url:"<c:url value='/forget/checkCode' />?new="+new Date().getTime(),data:{username:$("#cont1 #username").val(),code:$("#cont2 #code").val()},
	    		success:function(data){
	    			if(data =='false'){
	    				$("#errorCode").text("邮箱验证码不正确！");
	    			}else{
	    				$("#errorCode").text("");
	    				$("#uname1").text(uname);
	    				$('#mid').val(data);
	    				next(3);
	    			}
	    		}	
	    	});
           });
           
      		$("#cont4 #fastlogin").click(function(){   
      			 $("#loginForm").submit();  
      			 
             });
           function next(num){
                $(".nav").css("background", "url(<c:url value='/resources/img/bckPwdli' />" + num + ".png)");
                $(".tblcont table").hide()
                $(".tblcont #cont" + num).show();
                if (num == 4) {
                	$(".nav").css("background", "url(<c:url value='/resources/img/bckPwdli' />" + 3 + ".png)");
				}
           }
           
           
           $("#cont3 #saveChange").click(function(){
	           var pwdRules = checkPwd()
	           , uname =$("#cont1 #username").val()
	           , upwd = $("#cont3 #pwd").val()
	           , cupwd = $("#cont3 #confirmPwd").val()
	           , $pwdChkMsg = $("#cont3 #error1")
	           , $cpwdChkMsg = $("#cont3 #error")
	           , data = {username:uname,password:upwd,mid:$('#mid').val()};
	           if(!pwdRules){
	           	return;
	           }else if(cupwd == ''){
	           	$pwdChkMsg.text('');
	           	$cpwdChkMsg.text('请输入确认新密码!');
	           	return;
	           }else if(upwd != cupwd){
	           	$pwdChkMsg.text('');
	           	$cpwdChkMsg.text('您输入的密码与确认密码不一致!');
	           	return;
	           }else{
	           	$pwdChkMsg.text('');
	           	$cpwdChkMsg.text('');
	           }
	           $.ajax({type:"get",url:"<c:url value='/forget/updatePwd' />?new="+new Date().getTime(),data:data,
	           dataType:"json",
	           success:function(data){
		           	if(data){
		           		//window.location="<c:url value='/login' />";
		           		next(4);
		           		$("#uname2").text(uname);
		           	}else{
		           		jAlert("密码修改失败，请重新修改！");
		           	}
	           }
	           });
           });
           
           var hash={ 
           'qq.com': 'http://mail.qq.com', 
           'gmail.com': 'http://mail.google.com', 
           'sina.com': 'http://mail.sina.com.cn', 
           '163.com': 'http://mail.163.com', 
           '126.com': 'http://mail.126.com', 
           'yeah.net': 'http://www.yeah.net/', 
           'sohu.com': 'http://mail.sohu.com/', 
           'tom.com': 'http://mail.tom.com/', 
           'sogou.com': 'http://mail.sogou.com/', 
           '139.com': 'http://mail.10086.cn/', 
           'hotmail.com': 'http://www.hotmail.com', 
           'live.com': 'http://login.live.com/', 
           'live.cn': 'http://login.live.cn/', 
           'live.com.cn': 'http://login.live.com.cn', 
           '189.com': 'http://webmail16.189.cn/webmail/', 
           'yahoo.com.cn': 'http://mail.cn.yahoo.com/', 
           'yahoo.cn': 'http://mail.cn.yahoo.com/', 
           'eyou.com': 'http://www.eyou.com/', 
           '21cn.com': 'http://mail.21cn.com/', 
           '188.com': 'http://www.188.com/', 
           'foxmail.coom': 'http://www.foxmail.com' 
           };
           
           $("#enterEmail").click(function(){
        	   //根据邮箱地址判断邮箱种类
        	   var email=$("#email").val().toLowerCase();
        	   var url = email.split('@')[1];
        	   for (var j in hash){
        		   $(this).attr("href", hash[url]);
        	   }
           });
        $('.forgetInput').on('focus blur ',fakePlaceholder)   
            $('.fakePlaceholder').on('click',hihi)   
        });
function hihi() {
    $(this).fadeOut('fast')
        $(this).siblings('.forgetInput').focus()
}
//验证码提示框隐藏的函数
function fakePlaceholder(e) {
    var $this = $(this)
      , ph =$this.siblings('.fakePlaceholder') 
    if(e.type == 'focus') 
    ph.fadeOut('fast') 
    else if(e.type == 'blur') {
        if($this.val()=="") 
        ph.fadeIn('fast') 
    }
} 
        function checkSend() {
        	var Email  = $("#cont2 #email").val();
        	if(Email==''){
        		$(".cgCode").text('发送失败！').show();
            	$("#pwdSend").removeAttr("onClick");
            	return;	
        	}
        	$.ajax({type:"get",url:"<c:url value='/email/sendEmail' />?new="+new Date().getTime(),data:{username:$("#cont1 #username").val(),email:Email},
	    		success:function(data){
	    			if(data.length>0){
	    				senEmail();
	    			}
	    		}	
	    	});
        }
        
        function senEmail(){
        	var count;
            count = 60;
            $(".cgCode").show();
            $("#pwdSend").removeAttr("onClick");
           var f= setInterval(function () {
                count--;
                $("#pwdSend").val("重新发送(" + count + ")");
                $("#pwdSend").css("color", "#A7A7A7");
                if (count <= 0) {
                    $("#pwdSend").val("发送验证码");
                    $("#pwdSend").css("color","#000");
                    $("#pwdSend").attr("onClick", "checkSend();");
                    clearInterval(f);
                }
            }, 1000);
        }
        
        /**
         * 密码校验 密码格式
         * @return {TypeName} 
         */
        function checkPwd(){
        	var pwd=$("#cont3 #pwd").val()
        	, confirmPwd = $("#cont3 #confirmPwd").val()
        	, $pwdChkMsg = $("#cont3 #error1")
        	, $cpwdChkMsg = $("#cont3 #error")
        	, reg = /^\d+$/;
        	if(pwd == ''){
        		$cpwdChkMsg.text("");
        		$pwdChkMsg.text("请输入新密码!"); 
        		return false;
        	}if(pwd.length<6||pwd.length>14){
        		$cpwdChkMsg.text("");
        		$pwdChkMsg.text("密码长度6-14位，字母区分大小写!"); 
        		 return false;
        	} else if(reg.test(pwd)){
        		$cpwdChkMsg.text("");
        		$pwdChkMsg.text("您的密码太过简单，请使用字母数字组合!");
        		return false;
        	}else{
        		 $pwdChkMsg.text("");
        		 $cpwdChkMsg.text("");
        		 return true;
        	} 
        		 		
 }
    </script>
    <title>安全中心</title>
</head>
<body>
    <div class="top">
        <img src="<c:url value='/resources/img/bckLog.png' />" />
    </div>
    <ul class="nav">
        <li></li>
        <li></li>
        <li></li>
    </ul>
   <form id="loginForm" action="<%=request.getContextPath()%>/login" method="post">
    <div class="tblcont">
        <table id="cont1" class="table1">
            <tr>
                <td class="infoP">请填写您需要找回的账号:</td>
            </tr>
            <tr>
                <td>
                    <input type="text"  class="pwdInput forgetInput" id="username"/>
                    <span class="fakePlaceholder" >请您输入用户名/注册邮箱</span>
                    <span class="user_error" id="user_error"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" class="checkInput forgetInput" id="received" />
                    <span  class="fakePlaceholder">请输入验证码</span>
                    <img class="checkImg" id="changeImg" src="<c:url value='/resources/img/kaptcha.jpg' />" />
                    <a class="refresh" id="updateImg">看不清？</a>
                    <span class="img_error" id="img_error"></span>
                    </td>
            </tr>
            <tr>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td>
                    <input type="button" value="下一步" class="pwdBtn" id="next"  /></td>
            </tr>
        </table>
        <table id="cont2" class="table2">
            <tr>
                <td class="forget-title"><p class="yrId">您正在找回的账号是：<span id="uname"></span></p>
                    <p class="yrId2">为了您的账号安全，请完成下方身份验证后找回密码</p>
                </td>
            </tr>
            
            <tr>
                <td class="yzfs"><span>验证方式</span><input type="text" class="pwdInput restyle-pwdInput" id="email" readonly="readonly" /></td>
            </tr>
            <tr>
                <td>
                    <input type="button" class="pwdSend" value="发送验证码" id="pwdSend" onclick="checkSend();" />
                    <span class="cgCode" >发送成功，<a href="javascript:;" target="_blank" id="enterEmail">立即进入邮箱</a>
                    </span>
                </td>
            </tr>
            <tr> 
                <td>
                    <input type="text" id="code" class="checkInput code2 forgetInput" autocomplete="off" />
                    <span  class="fakePlaceholder emailPh">邮箱验证码</span>

                    <span class="error" id="errorCode" style="font-size:12px;padding-left:12px;"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="button" value="确 定" class="pwdBtn pwdBtn2" id="saveCode" /></td>
            </tr>
        </table>
        <table id="cont3"  class="table3">
            <tr>
                
                <td><p class="yrId yrId2 ">您正在找回的账号是：<span id="uname1"></span></p>
                   <input type="hidden" id='mid' value = ""/>
                </td>
                <td></td>
            </tr>
            
            <tr>
                <td class="yzfs"><span style="font-size:12px;" class="newpwdtext w90">新密码：</span>
                <input type="password" class="pwdInput" id="pwd" onblur="checkPwd()" name="password"/>
                <span class="user_error" id="error1" style="font-size:12px;"></span>
                </td>
            </tr>
            
            <tr>
                <td class="yzfs">
                <span  class="confirmpw w90"style="font-size:12px;">确认新密码：</span>
                <input type="password" class="pwdInput" id="confirmPwd" onblur="checkPwd()"/>
                <span class="user_error" id="error" style="font-size:12px;"></span>
                </td>
                
            </tr>
            <tr>
                <td>
                    <input type="button" value="确 定" class="pwdBtn pwdBtn2 saveChange" id="saveChange" />
                </td>
                <td></td>
            </tr>
        </table>
        <input type="hidden" name="username" >
          <table id="cont4" class="table3">
			<tr>
				<td style="text-align:center"><p ><img src="<c:url value='/resources/img/backpwdbg.gif' />" />&nbsp;<B>恭喜，账号<span id="uname2"></span>重置密码成功！
					</B> </p></td>
			</tr>
			
			<tr>
				<td style="text-align:center"><input type="button" value="直接登录"
					class="pwdBtn pwdBtn2 saveChange" id="fastlogin" style="display:inline-block;"/></td>
			</tr>
		</table>
    </div>
    </form>
    <div class="foot">
        <p class="p1">用户名和邮箱都不记得了？</p>
        <p class="p2">*请联系管理员，重新找回用户名、邮箱</p>
        <p class="p2">*联系方式：800-8888 8888 ，90%的用户会在4小时内收到反馈</p>
    </div>
</body>
</html>
