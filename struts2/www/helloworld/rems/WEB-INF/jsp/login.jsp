<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
    <title>新奥远程能源管理系统-登录</title>
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value='/resources/img/rems_logo.ico' />" sizes="16x16 24x24 32x32 48x48"/>
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/samll_global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/login.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/login.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
    <script type="text/javascript">
    $(window).resize(function(){
    setSize();
    });
    $(function(){
        var baseUrl = "<%=basePath%>"+"login";
        if (top.location != baseUrl){
        top.location=baseUrl;    
      }
        setSize();
      
        $("#loginbtn").click(function(){
        formSubmit();
      });
      
      $("#password").keydown(function(event){
            if(event.which == 13){
              formSubmit();
            }       
        });
      function formSubmit(){
         
          if($("#loginname").val() == ""){
          $("#loginname").focus();
            $("#error").text("用户名不能为空！");
            return false;
          }
          if($("#password").val() == ""){
          $("#password").focus();
            $("#error").text("密码不能为空！");
            return false;
          }
          $("#loginForm").submit();
        }
        var count = $("#loginCount").val();
        if(count >= 3){
          jConfirm("错误已达3次，建议关闭窗口重新访问","确定",function(r){
            if(r == true){
              window.opener=null;
            window.open('','_self');
            window.close();
            }
          });
        }
      });
    
      function setSize(){
        var screenW=document.documentElement.clientWidth;
          var screenH=document.body.clientHeight;
      $(".module-login .contxt").css("width",screenW);
        if(screenH<666){
        $(".logtop").css("display","none");
        $("html").css("overflow-y","auto");
          }
      else{
        $("html").css("overflow","hidden");
        $(".logtop").css("display","block");
        var setH=screenH-666;
        if(setH<54){
          $(".logtop").css("height",setH+"px");
        }
        else{
          setH=(setH-54)/2;
          setH=setH+54;
          $(".logtop").css("height",setH+"px");
          $(".footer").css("height",setH+"px");
        }
      }
      if(screenW<=800){
        $(".module-login .loginnav").css("width","760px");
        $(".module-login .form").css("left","505px");
          }
      else{
        $("html").css("overflow","hidden");
        var setW=(screenW-850)/2;
        $(".module-login .loginnav").css("width","850px");
        $(".module-login .loginnav").css("left",setW);
        $(".module-login .form").css("left",setW+540);
      }
      }
    
    </script>
    </head>
    <body>
    <form id="loginForm" action="<%=request.getContextPath()%>/login" method="post">
   <div class="logtop">
   </div>
      <div class="module-login" style="position:relative;">
        <div class="contxt">
          <div id="form" class="form">
            <div class="input username"> <span id="sp1">请输入用户名</span>
              <input type="text" autocomplete="off" id="loginname" name="username" />
            </div>
            <div class="input password"> <span id="sp2">输入密码</span>
              <input type="password" autocomplete="off" id="password" name="password" />
            </div>
            <div class="notice">
              <input type="hidden" id="loginCount" name="loginCount" value="${loginCount}"/>
              <span class="error" id="error">${message}</span> </div>
            <div> <a id="loginbtn" class="loginbtn">登录</a> </div>
            <div><a id="forgetPwd" class=" fgtWpd" href="<c:url value='/forget' />">忘记密码？</a></div>
          </div>
          <table class="putform loginnav">
            <tr>
              <td><table class="putform">
                  <tr>
                  <td class="nav-tit yhty"><a class=""></a></td>
                  <td class="tleft"><p class="txt">用户体验</p>
                      <p>手机、移动终端随时随地项目运营情况全面掌握</p></td>
                </tr>
                </table></td>
              <td><table class="putform">
                  <tr>
                  <td class="nav-tit ycfw"><a class=""></a></td>
                  <td class="tleft"><p class="txt">远程服务</p>
                      <p>设备和系统多种形式、多种方法关联分析快速展示</p></td>
                </tr>
                </table></td>
              <td><table class="putform">
                  <tr>
                  <td class="nav-tit qlwj"><a class=""></a></td>
                  <td class="tleft"><p class="txt">潜力挖掘</p>
                      <p>建筑能耗、工艺系统运行数据挖掘，节能评估</p></td>
                </tr>
                </table></td>
            </tr>
          </table>
          <p class="homeRecommend">推荐浏览器IE11及以上<span class="ml10">推荐分辨率1280*1024</span></p>
        </div>
        
      </div>
      <div class="footer">
          <span>版权(V20150401)所有：新奥智能能源有限公司</span>
          <a href="http://www.enn.cn" target="_blank"><img class="logoIcon ml10" src="<c:url value='/resources/img/smlllogo.png' />" /></a>
          <span class="ml10">系统维护电话：021-31290823</span>
          <span class="ml10">Email：<a href="mailto:rems@enn.cn">rems@enn.cn</a></span>
      </div>


    </form>
</body>
</html>
