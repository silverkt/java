<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
	$(function(){

		closeFancybox();

	});
</script>
<form id="newsform" method="post" enctype="multipart/form-data">
<input type="hidden" name="projectid" value="${pid}"/>
<input type="hidden" id="update_newsid" name="newsid" value="${updateNews.newsid}"/>
<input type="hidden" name="user.userId" value="${empty updateNews.user.userId ? loginUser.userId : updateNews.user.userId}"/>
<table class="tblnygl">
     <tr>
         <td class="tright w80" style="width: 40px;">标题：</td>
         <td>
             <input type="text" name="title" value="${updateNews.title}" class="w615 ttxt txtt2" maxlength="90" /></td>
     </tr>
     <tr>
         <td class="tright w80">内容：</td>
         <td>
             <script id="editor" type="text/plain" style="width: 100%; height: 335px;">${updateNews.newscontaint}</script>
         </td>
     </tr>
 </table>
 </form>
 <div class="clear">
 	<span id="customWordsCount" class="fl mt15 ml40 errorText"></span>
 	<a class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
 	<a id="submitLink" class="tck-save fr mt15">保存</a>
 </div>