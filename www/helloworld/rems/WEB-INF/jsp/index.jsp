<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <!-- 我是首页 -->
    <meta name="viewport" content="initial-scale=1.0,user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <title>远程能源管理系统</title>
    <link href="<c:url value='/resources/css/common.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/global.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/tinyscrollbar.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/context.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/pagination.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/css/index.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/js/jquery-ui-1.10.4/development-bundle/themes/base/jquery.ui.all.css' />" rel="stylesheet" />
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
    <script src="http://api.map.baidu.com/api?v=2.0&services=false&ak=508d19135c7e834335c9fd942625c161" type="text/javascript"></script>
    <script src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js" type="text/javascript" ></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/AreaRestriction/1.2/src/AreaRestriction_min.js"></script>
    <script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.validate.js' />"></script>
    <script src="<c:url value='/resources/js/jquery-ui-1.10.4/development-bundle/ui/jquery.ui.core.js' />"></script>
    <script src="<c:url value='/resources/js/jquery-ui-1.10.4/development-bundle/ui/jquery.ui.widget.js' />"></script>
    <script src="<c:url value='/resources/js/jquery-ui-1.10.4/development-bundle/ui/jquery.ui.position.js' />"></script>
    <script src="<c:url value='/resources/js/jquery-ui-1.10.4/development-bundle/ui/jquery.ui.menu.js' />"></script>
    <script src="<c:url value='/resources/js/jquery-ui-1.10.4/development-bundle/ui/jquery.ui.autocomplete.js' />"></script>
    <script src="<c:url value='/resources/js/my.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.tinyscrollbar.js' />"></script>
    <script src="<c:url value='/resources/js/common.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
    <script src="<c:url value='/resources/js/base.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.pagination.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/index.js' />"></script>
    <script src="<c:url value='/resources/js/jquery.fancybox.js' />"></script>
     <link href="<c:url value='/resources/css/jquery.alerts.css' />" rel="stylesheet" />
    <script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>

    <script type="text/javascript">
    $(function(){
		var screenW=document.documentElement.clientWidth-270;
		var scrH=($(window).height()- 80)/2;
		$("#folderBtn").css("top",scrH);
		
		$("#container1").css("min-height",$(window).height()- 80);
		$("#scrollH").css("height",$(window).height()- 310-5-20);
    	var projects = null,proTemp = new Array(),num = 0,pro_size = 0,map = null,
    		markers = {},infos = {},city = 0,proQuickly = new Array();
    	var initMap = function(){
    		map = new BMap.Map("container1");
    		map.centerAndZoom(new BMap.Point(106.387516,37.729803),5);
    		map.enableScrollWheelZoom(); map.setMinZoom(5);
			map.addControl(new BMap.NavigationControl());
			map.enableAutoResize();
			/*
				拖拽边界控制
			*/
			var center;
			map.addEventListener("dragstart",function(){center=map.getCenter();});
			map.addEventListener("dragend",function(){
				var bounds = map.getBounds(); 
				var zoom=map.getZoom();
				var ne_lng = bounds.getNorthEast().lng;
				var ne_lat = bounds.getNorthEast().lat;
				var sw_lng = bounds.getSouthWest().lng;
				var sw_lat = bounds.getSouthWest().lat;
				//console.log("ce_lng:"+center.lng+" ce_lat:"+center.lat);
				//console.log("sw_lng:"+sw_lng+" sw_lat:"+sw_lat);
				//console.log("ne_lng:"+ne_lng+" ne_lat:"+ne_lat);
				if(sw_lng<-200||sw_lat<-83) {//console.log("左下");
				map.centerAndZoom(new BMap.Point(center.lng,center.lat),zoom);}
				if(ne_lng>210||ne_lat>86){//console.log("右上");
				map.centerAndZoom(new BMap.Point(center.lng,center.lat),zoom);}
	    	});

    	}();
    	
    	var getProjects = function(cproperty){
    		$.ajax({type:"GET",url:"<c:url value='/project/baseinfo/list' />?new="+new Date().getTime(),data:{"cproperty":cproperty},
    			success:function(res){
					projects = res;
					initPagerData();
				}
			});
    	};
    	getProjects(474);
    	//初始化分页数据
    	function initPagerData(){
    		map.clearOverlays();
    		proTemp = null,markers = {},infos = {},proQuickly = new Array();
    		if(city == 0){
    			proTemp = projects;	
    		}else{
    			proTemp = new Array();
    			$.each(projects,function(){
    				if($(this)[0].districtid == city || $(this)[0].pdistrictid == city) proTemp.push($(this)[0]);
    			});
    		}
    		pro_size = proTemp.length;//总条数
    		num = parseInt((pro_size + 10 -1)/10);//计算总页数
    		
			for(var i = 0;i < pro_size;i++){
				var id = proTemp[i].projectid;
				var pName = proTemp[i].projectname;
				var pQuanpin = proTemp[i].quanpin;
				var pJianpin = proTemp[i].jianpin;
				var item = {"name":pName,"quanpin":pQuanpin,"jianpin":pJianpin};
				proQuickly.push(item);
				markers[id] = addMarker(proTemp[i],id,i);
			}
			if(num>1) initPagination();
    		else $("#Pagination").empty();
			getResult(0); //数据条数小于1页时执行
			$("#tip-tit").attr("title",proTemp[0].projectname);
    		$("#tip-tit").text(proTemp[0].projectname.length<=11?proTemp[0].projectname:proTemp[0].projectname.substring(0,11)+"...");	
    		//*
    		$('#topSearch').autocomplete({
				source: function( request, response ) {
					//alert(request.term+"=="+response);
					var Matcher = new RegExp( $.ui.autocomplete.escapeRegex( request.term ), "i" );
					var fMatcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
					var arr = new Array();
					$.grep( proQuickly, function( item ){
						if((Matcher.test( item.quanpin))||(Matcher.test( item.jianpin))||
							(Matcher.test( item.name))){arr.push(item.name);}
					});
					response( $.grep( arr, function( item ){
						return item;
					}));
				}
			});
    		//*/
			//$("#topSearch").autocomplete({source: proQuickly});
			doEvaluate(proTemp[0].projectid,proTemp[0].projectname);
    	}
    	function doEvaluate(projectid,projectname){
    		$("#tip-tit").attr("title",projectname);//显示title
    		$("#tip-tit").text(projectname.length<=11?projectname:projectname.substring(0,11)+"..."); //cop对应项目名称
			$.ajax({type:"GET",url:"<c:url value='/project/baseinfo/cop' />?new="+new Date().getTime(),data:{"projectid":projectid},
    			success:function(data){
       				if(data.length>0){
        				var num=0;
        				var val=data[0].datavalue;
        				var val1 = (Number(val)/100).toFixed(2);
        				var num = 7 - parseInt(val1);
        				if(num >= 7) num = 6;
        				if(num <=1) num = 0;
        				$("#LeftCol .gl_top").find("li").removeClass("gl_li");
    					$("#LeftCol .gl_top").find("li:eq("+num+")").addClass("gl_li");
    					if(!isNaN(val1)){
    						$("#cop_value").empty().append(val1);
    						$("#cop_text").empty().append('C.O.P');
    					}else{
    						$("#cop_value").empty();
    						$("#cop_text").empty();
    					}
            			$("#LeftCol .gl_top").find("li").removeClass("gl_li");
            			$("#LeftCol .gl_top").find("li:eq("+num+")").addClass("gl_li");
    				}else{
    					$("#cop_value").empty();
    					$("#cop_text").empty();
    					$("#LeftCol .gl_top").find("li").removeClass("gl_li");
    				}
				}
			});
    	}
    	
    	function getResult(page){//page 当前页
    		var result = "";
    		doEvaluate(proTemp[page * 10].projectid,proTemp[page * 10].projectname);
    		for(var i = 0;i < 10;i++){
    			var j = (page * 10) +i;
    			if(j >= pro_size) break;
    			var pro = proTemp[j],clazz = i == 0 ? "selectF":"";
    			var title='',projectname='',trstyle='';
    			pro.rectime!=null?title=pro.projectname+' 采集时间：'+pro.rectime:title=pro.projectname;
    			pro.datavalue=="-"?trstyle="right":trstyle="right";
    			projectname=pro.projectname.length<=11?pro.projectname:pro.projectname.substring(0,11)+"..."
    			result += '<tr class="'+clazz+'"><td class="tcenter Searchresult-no-pd">'+(j+1)+'</td><td class="tleft"><a pid="'+pro.projectid+'" title="'+title+'" class="name ellipsis dblock" did="'+pro.pdistrictid+'">'+projectname+'<input type="hidden" class="title" value="'+pro.projectname+'"></a></td>' +
    					'<td style="text-align:'+trstyle+';"><span style="position:relative;padding-right: 29px;">'+pro.datavalue+'<i class="ico-lift '+pro.differ+'" style="position:absolute;right:6px;top:2px;"></i></span></td></tr>';
    		}
    		$("#Searchresult tbody").empty().append(result);
    		
			$(".name","#Searchresult tbody").bind("click",function(){
    			var id = $(this).attr("pid");
    			var did = $(this).attr("did");
    			getDistrict(did);
    			infos[id].open(markers[id]);
    			for(var i = 0;i < proTemp.length;i++){
        			var num=proTemp[i].projectid;
        			markers[num].setTop(false);
        		}
    			markers[id].setTop(true);
    			$("#Searchresult tbody tr").removeClass("selectF");
    			$(this).parent().parent().addClass("selectF");
    			doEvaluate(id,$(this).children('.title').val());
    		});
			for(var i = 0;i < proTemp.length;i++){
    			var id=proTemp[i].projectid;
    			//console.log(id);
    			infos[id].close(markers[id]);
    		}
    	}
    	function getDistrict(id){
    		$("#selCityPlaceListId .sel-city-td-sf a").each(function(){
    			if($(this).attr("pid") == id){
    				$("#curCity").html($(this).attr("fname"));
    				return false;
    			}
    			
    		})
    	}
    	function addMarker(pro,id,num){
    		var myIcon =null;
    		num<10?num:num=10;
			myIcon = new BMap.Icon("<c:url value='/resources/img/markers3.png' />", new BMap.Size(20, 24), {  
				offset: new BMap.Size(10, 25), // 指定定位位置  
				imageOffset: new BMap.Size((Number(pro.state)-2)*20, 0-num*25) // 设置图片偏移   
			});
			
    		var	url = '<c:url value="/monitor?id=2&menuid=6&project=" />'+ pro.projectid;
    		var a="";
    		if(Number(pro.state)==2){
    			a="<a style='margin-left:5px;font-size:12px;color:blue;font-weight:normal;text-decoration:none;'href='"+url+"'>详情»</a>";
    		}else if(Number(pro.state)==1){
    			a="<span style='margin-left:5px;color:#999'>在建中</span>";
    		}else{
    			a="<span style='margin-left:5px;color:#999'>规划中</span>";
    		}
    		
    		var marker = new BMap.Marker(new BMap.Point(pro.longitude,pro.latitude),{icon:myIcon}),
    		 	sContent = "<table width='300px' border='0' cellspacing='0' cellpadding='0' style='font-size:12px'>" +
    		 			    "<tr><td  height='25px'>项目类型："+pro.industryclassname+"</td>" +
    		 			    "<td height='100px' width='160px' rowspan='4' align='right'>" +
    		 			    "<img src='"+pro.pictureptah+"' width='160' height='100' style='border: 1px solid #d2e3f5;'/></td></tr>"+
    		 			    "<tr><td  height='25px'>所属行业："+pro.industrytypename+"</td></tr>" +
    		 			    "<tr><td  height='25'>建筑面积："+pro.buildingarea+" m2</td></tr>" +
    		 			    "<tr><td  height='25'>商业模式："+pro.businesstypename+"</td></tr>" +
    		 			    "<tr><td height='25px' colspan='2'>项目地址："+pro.address+"</td></tr>"+
    		 				"</table>",
    		 	title="<span style='font:bold 14px/16px arial,simsun,sans-serif;'>"+pro.projectname+"</span>" +a,
    		 	searchInfoWindow = new BMapLib.SearchInfoWindow(map,sContent,{
		    				title:title,width:300,height:140,panel:"panel",
		    				enableAutoPan:true,enableSendToPhone: false,searchTypes:[]});
    		map.addOverlay(marker);
    		infos[id] = searchInfoWindow;
    		//marker.setTop(false);
    		marker.addEventListener("click",function(){
    			for(var i = 0;i < proTemp.length;i++){
        			var id=proTemp[i].projectid;
        			//console.log(id);
        			//infos[id].close();
        			markers[id].setTop(false);
        		}
    			searchInfoWindow.open(marker);	
    			marker.setTop(true);
    			//marker.setZIndex(100);
    		});
			return marker;
    	}
    	
    	var initPagination = function() {
			$("#Pagination").pagination(num, {
				num_edge_entries: 1, //边缘页数
				num_display_entries: 4, //主体页数
				callback: pageselectCallback,
				items_per_page:1, //每页显示1项
				prev_text: "上一页",
				next_text: "下一页"
			});
		 };
		 
		function pageselectCallback(page_index, jq){
			getResult(page_index);
			return false;
		}
		//搜索单击事件
		$("#topsubmit").click(function(){
			var search = $("#topSearch").val();
			for(var i = 0;i < pro_size;i++){
				if(proTemp[i].projectname == search){
					var id = proTemp[i].projectid;
					infos[id].open(markers[id]);
				}
			}
		})
		//城市搜索
		$("#selCitySubmit").click(function(){
			var citys = $("#mapContent a"),city1 = $("#selCityCityWd"),flag=true;		
			$.each(citys,function(){
				if($(this).text().trim() == city1.val().trim()){
					city = $(this).attr("pid");//
					$("#curCity").text($(this).attr("fname")).removeClass("on");//
					$(this).parents(".map_popup").hide();
					map.setCenter(new BMap.Point($(this).attr("long"),$(this).attr("lat")));
	        		map.setZoom(parseInt($(this).attr("zoom")));
	        		flag = false;
	        		initPagerData();//
	        		return false;
				}
			});
			if(flag) city1.val("没有该城市");
		})
		//城市单击事件
		$("#mapContent a").click(function () {
	    	var $txt = $(this).attr("fname");
	    	city = $(this).attr("pid");
	    	
	        $("#curCity").text($txt).removeClass("on");
	        $(this).parents(".map_popup").hide();
	        map.setCenter(new BMap.Point($(this).attr("long"),$(this).attr("lat")));
	        map.setZoom(parseInt($(this).attr("zoom")));
	        initPagerData();
	    });
		//排名单击事件
		$("a","#energyRank").click(function(){
			getProjects($(this).attr("pid"));
			var pid=$(this).attr("pid");
			if(Number(pid)==597){
				$("#ranktitle").empty().html("排名指数(W/m&sup2;)");
			}else if(Number(pid)==474){
				$("#ranktitle").empty().html("排名指数(%)");
			}
		});
		
		
		//修改用户信息页面
	    $("#toUpdateCurrentUserBtn").click(function(){
	    	$.ajax({type:"get",url:"<c:url value='/user/updateCurrentUserInput?id=${id}&menuid=${menuid}' />&_="+new Date().getTime(),data:{},
	    		success:function(data){
	    			$("#pop-onupdateCurrentUser .bd").empty().html(data);
	    		}	
	    	});
	    })
	    
	   $(".fancybox","#slidetxt").click(function(){
	   		var cid = $(this).attr("nid");
	   		isFirst = true;
    		flushNews(cid);
    		flushNewsList(0);
		})
		
	})
	var isFirst = true;
	function flushNewsList(dex){
		var container = $('.news_list','#pop-news');
		$.ajax({global:false,type:"GET",url:"<c:url value='/project/news/indexList' />",data:{dex:dex},
			success:function(data){
				container.empty().html(data);
				if(isFirst) {
					var count = $("#iCount").val();
					if(count > 1) initNewsPagination(count);
					else $("#newsPagination").empty();
				}
			}
		});
	}
	function flushNews(id){
		//alert(id);
			$("#pop-news #news").empty();
			//$("#pop-news .hd h2").html($(this).find(".title").html());
			$.ajax({global:false,type:"GET",url:"<c:url value='/project/news/' />"+id,
    			success:function(data){
    			//alert(data);
    				$("#pop-news #news").html(data);
				}
    		});
		}
	var initNewsPagination = function(num) {
			$("#newsPagination").pagination(num, {
				num_edge_entries: 1, //边缘页数
				num_display_entries: 4, //主体页数
				callback: newsPageCallback,
				items_per_page:1, //每页显示1项
				prev_text: "上一页",
				next_text: "下一页"
			});
		 };
		 
		function newsPageCallback(dex, jq){
			if(isFirst){isFirst = false; return;}
			flushNewsList(dex);
			return false;
		}
	$("#container1 div.anchorBL").hide(); 
    </script>
    </head>
    <body>
		<div class="head"> <a class="logo"></a>
      	<div class="navbar">
    	<ul>
        	<li class="on"><a  href="<%=request.getContextPath()%>/index">首页</a></li>
         		<c:forEach items="${fns:listMenu(0)}" var="c">
            		<shiro:hasPermission name="${c.perssioncode}">
            		<c:set var="count" value="0"/>
            		<c:forEach items="${fns:listMenu(c.menuid)}" var="cl" varStatus="status">
            			<c:out value='${c1.menuid}'/>
            			<shiro:hasPermission name="${cl.perssioncode}">
            				<c:if test="${count==0}">
            					<li class="${id==c.menuid ? 'on':''}" test><a class="" href="<c:url value='${cl.accessurl }'/>">${c.menuname}</a></li>
            				</c:if>
            				<c:set var="count" value="${status.count}"/>
            			</shiro:hasPermission>
            		</c:forEach>
            		</shiro:hasPermission>
            	</c:forEach>
        </ul>
		</div>
    	<div class="down-popup fr"> ${loginUser.userShowName }
    		<div class="arr-group"></div>
    		<div class="list">
        		<ul>
        			<li><a id="toUpdateCurrentUserBtn" class="a fancybox" href="#pop-onupdateCurrentUser">修改信息</a></li>
       				 <li><a href="<%=request.getContextPath()%>/logout">安全退出</a></li>
      			</ul>
        	</div>
  		</div>
   		</div>
		<div class="index-slide-txt clear" id="slide-txt">
      		<ol id="slidetxt">
    <li><c:forEach items="${news}" var="n" varStatus="s">
        	<a class="fancybox" nid="${n.newsid}" href="#pop-news"> <span>
          <fmt:formatDate value="${n.createtime}" pattern="MM-dd"/>
          </span> <span class="title">${n.title }</span></a>
        </c:forEach></li>
  			</ol>
    	</div>
		<div id='background' class='background'></div>
		<div id='progressBar' class='progressBar'><img src="<c:url value='/resources/img/loading4.gif'/>" /></div>
		<div id="container" class="AllCol-index index">
      		<div id="LeftCol" class="LeftCol LeftCol-index">
 				<div class="index-left">
          			<p class="index-left-title" style="width:305px;"> <span id="tip-tit"></span><span id="cop_text">C.O.P </span><a id="cop_value"></a></p>
		        	<div class="index-left-core" style="background:url(<c:url value='/resources/img/gltop.png' />) no-repeat;">
		        		<ul class="gl_top">
				            <li></li>
				            <li></li>
				            <li></li>
				            <li></li>
				            <li></li>
				            <li></li>
				            <li style="height: 25px;" class="gl_li"></li>
		            	</ul>
		    		</div>
        			<div class="mod-select fl index-energyRank" id="energyRank">
        				<p class="text" style="width:265px;text-align:left;">系统能效</p>
        				<span class="arr-group hand"><i class="icon-mod icon-arr"></i></span>
        				<div class="list">
              			<ul>
				            <li><a href="" pid="474" style="text-align:left;">系统能效</a></li>
				            <li><a href="" pid="597" style="text-align:left;">单位面积耗冷/热负荷</a></li>
				        </ul>
            		</div>
      			</div>
      			<table class="putform lineform Searchresult-hd" id="Searchresult">
      				<thead>
			            <tr>
			           		<td width="50px">排名</td>
			                <td class="tleft">项目名称</td>
			                <td id="ranktitle" width="120px">排名指数(%)</td>
			            </tr>
      				</thead>
    			</table>
    			<div class="scrollH" id="scrollH">
        			<table class="putform lineform Searchresult-bd" id="Searchresult">
          				<tbody >
          				</tbody>
         			</table>
        			<div class="page mt10">
              			<div id="Pagination" class="pagination"></div>
            			</div>
      				</div>
        		</div>
  			</div>
      		<div id="MainCol" class="MainCol">
    			<div id="folderBtn" class="icoLeft"> </div>
    			<div class="content">
          			<div class="topInfo">
        				<div id="selCity" class="fl">
              				<div class="sel_container"> <a id="curCity" class="curcity-expand showdiv" data-target=".map_popup" title="修改城市">全国</a> 
              				</div>
            			</div>
        				<fieldset class="search fl ml10">
              				<legend class="sr-only">site search</legend>
              				<input id="topSearch" class="empty" value='项目检索' type="text"/>
              				<button type="submit" id="topsubmit"></button>
            			</fieldset>
      				</div>
          			<div class="wrap wrap-index">
        				<div class="container1" id="container1"></div>
      				</div>
        		</div>
  			</div>
    	</div>
		<div class="map_popup">
      		<div class="popup_main">
    			<div class="title">城市列表</div>
    			<div class="content" id="mapContent">
          			<div class="sel_city blueC">
        				<div id="selCityTop">
              				<div id="selCityHotCityId" class="selCityHotCityId sel-city-hotcity"> <a class="fontbold" long="105.357267" lat="37.391597" zoom="5" pid="0" fname="全国">全国</a>
            <c:forEach items="${city}" var="c"> <a fname="${c.fullname}" pid="${c.districtid}" long="${c.longitude}" lat="${c.latitude}" zoom="${c.defaultzoom}"> ${c.districtname}</a> </c:forEach>
          					</div>
              				<div class="sel-city-searchbar">
            					<div class="btnbar"> <span class="sel-city-btnl sel-city-btnl-sel" id="selCityProvince">按省份</span> <span class="sel-city-btnr" id="selCityCity">按城市</span> </div>
            					<form id="selectCity">
                  					<input type="text" value="输入城市名" name="wd" id="selCityCityWd" class="sel-city-searchinput" autocomplete="off">
                  					<span class="sel-city-btn-submit" id="selCitySubmit">搜索</span>
                  					<div class="sel-city-tip selCityInfo" id="selCityInfo">请输入正确的城市名</div>
                				</form>
          					</div>
              				<div class="cut-off"></div>
            			</div>
        				<div id="scrollbarc">
              				<div class="scrollbar">
            					<div class="track">
                  					<div class="thumb">
                						<div class="end"></div>
              						</div>
                				</div>
          					</div>
              				<div class="viewport">
            					<div id="selCityPlaceListId" class="overview">
                  					<table class="putform tdform">
                						<tbody>
                      <c:forEach items="${provinces}" var="a">
                    <c:forEach items="${a.value}" var="p" varStatus="s">
                          <tr>
                        <td class="sel-city-td-letter"><div>${s.first ? a.key:''}</div></td>
                        <td class="sel-city-td-sf"><a fname="${p.fullname}" pid="${p.districtid}" long="${p.longitude}" lat="${p.latitude}" zoom="${p.defaultzoom}"> ${p.districtname}:</a></td>
                        <td class="tleft"><c:if test="${!empty p.children}">
                            <c:forEach items="${p.children}" var="c"> <a fname="${c.fullname}" pid="${c.districtid}" long="${c.longitude}" lat="${c.latitude}" zoom="${c.defaultzoom}"> ${c.districtname}</a> </c:forEach>
                          </c:if></td>
                      </tr>
                          ${s.last ? '
                          <tr>
                        <td colspan="3"><div class="sel-city-tr-splitline">A</div></td>
                      </tr>
                          ':''} </c:forEach>
                  </c:forEach>
                    					</tbody>
              						</table>
                				</div>
            					<div id="selProvincePlaceListId" class="selProvincePlaceListId overview">
                  					<table class="putform tdform">
                						<tbody>
                      <c:forEach items="${citys}" var="a">
                    						<tr>
						                          <td class="sel-city-td-letter"><div>${a.key }</div></td>
						                          <td class="tleft"><c:forEach items="${a.value}" var="c"> <a fname="${c.fullname}" pid="${c.districtid}" long="${c.longitude}" lat="${c.latitude}" zoom="${c.defaultzoom}"> ${c.districtname}</a> </c:forEach></td>
						                    </tr>
						                    <tr>
                          					<td colspan="3"><div class="sel-city-tr-splitline">A</div></td>
                        					</tr>
                  </c:forEach>
                    					</tbody>
              						</table>
                				</div>
          					</div>
            			</div>
      				</div>
        		</div>
    			<button id="poput_close" title="关闭" class="showdiv-close"></button>
  			</div>
      	<div class="poput_shadow"></div>
    </div>
	<div class="mod-pop pop-onupdateCurrentUser" id="pop-onupdateCurrentUser">
      	<div class="hd">
    		<h2>修改信息</h2>
  		</div>
      	<div class="bd"></div>
    </div>
	<div class="mod-pop pop-news" id="pop-news">
		<div class="hd">
			<h2>最新新闻</h2>
		</div>
		<div class="bd" style="padding: 0;">
    		<div class="news" id="news"></div>
    
    	<div class="news_list">
    	
    </div>
    <div class="page mt10">
    	<div id="newsPagination" class="pagination"></div>
	</div>
  </div>
</div>
</body>
</html>
