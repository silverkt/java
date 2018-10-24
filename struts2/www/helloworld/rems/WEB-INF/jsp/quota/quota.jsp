<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>远程能源管理系统</title>
     <link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/nygl.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.validate.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
    <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>
   
    <script type="text/javascript">
        $(function () {
        	var setting = {data: {simpleData: {enable:true}},callback: {onClick:onClick}},year,type;
	    	$.ajax({type:"GET",url:"<c:url value='/analyse/tree' />",success:function(data){
					$.fn.zTree.init($("#treeDemo"), setting, data);
					$.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
			}});
        	function onClick(event,treeID,treeNode,clickFlag) {
        		if(treeNode.getParentNode()==null) return;
				var parentNode = treeNode.getParentNode(),rootNode = parentNode.getParentNode();
				$("#curCity").empty().append((rootNode  == null ? '<span>' : '<span>'+rootNode.name+'</span>-<span>')+parentNode.name+"</span>-<span>"+treeNode.name+"</span>")
				$(".area_popup").hide();
				$("#curCity").removeClass("on");
				var $ul = $("#nyglinul").empty(),lis = "";
				if(treeNode.children.length == 0) 
					lis = getLi(treeNode.id,treeNode.name,true);
				else
					$.each(treeNode.children,function(i){
						var flag = i == 0 ? true : false;
						lis += getLi($(this)[0].id,$(this)[0].name,flag);
					});
				$ul.append(lis);
				$("#nyglinul li").bind("click", function () {
	                $("#nyglinul li").removeClass("nyglinulsel");
	                $(this).addClass("nyglinulsel");
	            });
			}
        	function getLi(id,name,flag){
        		return '<li '+(flag ? 'class="nyglinulsel"':'')+' val="'+id+'"><img src="<c:url value='/resources/img/iconleft.png'/>" />'+name+'</li>';
        	}
        	
        	//加载页面时，默认选择一项
        	year = "2014",type = "E";
			$('#selectSb').simSelect({callback: function (x,v) {if(!v) return;year = v;}});
			$('#nyzl').simSelect({callback: function (x,v) {if(!v) return;type = v;}});
            
			$(".putform #submitBt").click(function(){
				var pid = $(".nyglinulsel").attr("val");
				$.ajax({type:"GET",url:"<c:url value='/quota/value/0' />",
					data:{pid:pid,year:year,type:type},
	    			success:function(data){
					$(".wrap").empty().html(data);
	    		}});
			})
			
            $(".curSelectedNode span:first-child").css("background", "url(./img/img_23.png)");
            
        });
       
    </script>
</head>
<body>

	<jsp:include page="../header.jsp"></jsp:include>
	
    <div class="nav-nav clear">
        <div class="sel_nav ml10">
            <a title="" data-target=".area_popup" class="curcity-expand showdiv" id="curCity">请选择</a>
        </div>
    </div>
    <div id="container" class="">
        <div id="LeftCol" class="LeftCol" style="background:#fff;">
            <ul id="nyglinul" class="nyglinul"></ul>
        </div>
        <div id="MainCol" class="MainCol">
            <div id="folderBtn" class="icoLeft"></div>
            <div class="content contentTop">
                <div class="topFilter tab">
                    <table class="putform">
                        <tr>
                            <td class="w60"><span class="">选择年份：</span></td>
                            <td class="tleft">
	                            <div class="mod-select  mt5" id="selectSb" style="float:left;border-radius:5px;background-color:#fff; width:90px;">
	                                <p class="text">2014</p>
	                                <span class="arr-group hand">
	                                    <i class="icon-mod icon-arr"></i>
	                                </span>
	                                <div class="list">
	                                    <ul>
	                                        <li val="2014"><a href="">2014</a></li>
	                                        <li val="2015"><a href="">2015</a></li>
	                                        <li val="2016"><a href="">2016</a></li>
	                                        <li val="2017"><a href="">2017</a></li>
	                                        <li val="2018"><a href="">2018</a></li>
	                                        <li val="2019"><a href="">2019</a></li>
	                                        <li val="2020"><a href="">2020</a></li>
	                                    </ul>
	                                </div>
	                            </div>
	                            <span style="float:left; margin-left:12px;color: #373737; margin-top:3px;">能源种类：</span> 
                                <div class="mod-select  mt5" id="nyzl" style="float:left;border-radius:5px;background-color:#fff; width:90px;">
	                                <p class="text">电</p>
	                                <span class="arr-group hand">
	                                    <i class="icon-mod icon-arr"></i>
	                                </span>
	                                <div class="list">
	                                    <ul>
	                                        <li val="E"><a href="">电</a></li>
	                                        <li val="G"><a href="">气</a></li>
	                                    </ul>
	                                </div>
                            	</div>
                                <a id="submitBt" class="down-popup fl ml10" style="margin-top:5px;">查看数据</a>
                             </td>
                        </tr>
                    </table>
                </div>
                <div class="wrap">
                    <jsp:include page="content.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>
    
    <div class="area_popup">
        <div class="datalist-div" style="padding-bottom: 0px;">
            <div class="area-tit">
                <a class="smalllogo"></a>
            </div>
            <ul id="treeDemo" class="ztree"></ul>
        </div>
    </div>
    
</body>
</html>
