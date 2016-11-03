<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="/include.inc.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- 运行参数对比 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>远程能源管理系统</title>
<link href="<c:url value='/resources/css/zTreeStyle/zTreeStyle.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/demo.css' />" rel="stylesheet" />
<link
	href="<c:url value='/resources/js/My97DatePicker/skin/WdatePicker.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/common.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/global.css' />"
	rel="stylesheet" />
<link href="<c:url value='/resources/css/frame.css' />" rel="stylesheet" />
<link href="<c:url value='/resources/css/context.css' />"
	rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery-1.8.2.min.js' />"></script>
<script src="<c:url value='/resources/js/common.js' />"></script>
<script src="<c:url value='/resources/js/my.js' />"></script>
<script
	src="<c:url value='/resources/js/jquery.cookies.2.2.0.min.js' />"></script>
<script src="<c:url value='/resources/js/base.js' />"></script>
<script
	src="<c:url value='/resources/js/My97DatePicker/WdatePicker.js' />"></script>
<script
	src="<c:url value='/resources/js/jquery.ztree.core-3.5.min.js' />"></script>
<script
	src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts.js' />"></script>
<script
	src="<c:url value='/resources/js/Highcharts-4.0.1/highcharts-more.js' />"></script>
<link href="<c:url value='/resources/css/jquery.alerts.css' />"
	rel="stylesheet" />
<script src="<c:url value='/resources/js/jquery.alerts.js' />"></script>


<style>
#hint1 {
	width: 30px;
	border: 1px solid #70786d;
	background: #fcffff;
	color: #595957;
	font-family: "微软雅黑";
	position: absolute;
	z-index: 9;
	padding: 3px;
	border-radius: 4px;
	line-height: 17px;
	text-align: left;
	top: 1520px;
}

#hintindict1 {
	width: 0px;
	height: 0px;
	background: "#ff0000";
	position: relative;
	float: left;
	margin-top: -10px;
}

#hint2 {
	width: 30px;
	border: 1px solid #70786d;
	/*
	background: #99ff33;
    */
	border-radius: 4px;
	background: #fcffff;
	color: #595957;
	font-family: "微软雅黑";
	position: absolute;
	z-index: 9;
	padding: 3px;
	line-height: 17px;
	text-align: left;
	top: 1520px;
}

#hintindict2 {
	width: 0px;
	height: 0px;
	background: "#ff0000";
	position: relative;
	float: left;
	margin-top: -10px;
}

.list li em {
	background: url('hover.png') no-repeat;
	width: 180px;
	height: 145px;
	position: absolute;
	top: 185px;
	left: 515px;
	text-align: center;
	padding: 20px 12px 10px;
	font-style: normal;
	z-index: 399;
	display: none;
}

#hint3 {
	width: 198px;
	border: 1px solid #000000;
	background: #99ff33;
	position: absolute;
	z-index: 999;
	padding: 6px;
	line-height: 17px;
	text-align: left;
	top: 1520px;
}
</style>
<script type="text/javascript">


      
            var sbType="";
            var valSB1="";
            var valSB2="";
            var Fnz1="";
            var Fnz2="";
            var date="";
            var time="0";
            
              var date1="";
            var time1="0";
              var date2="";
            var time2="0";
            var array1={};
            var array2={};
       
            	var array_test=new Array();
            var tabclick=0;//指示点击动态参数，静态参数
        $(document).ready(function () {
        $.ajaxSetup({
    async: false
   });
          $('#selecthQ').on({mouseover : function (e) {
var p= $("#selecthQ p").attr("title") ;
  if (p==null) {
	
} else {
$("#selecthQ p").attr("title",p.trim()) ;
}
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
  var p= $("#selecthQ p").attr("title") ;
  if (p==null) {
	
} else {
$("#selecthQ p").attr("title",p.trim()) ;
}
//// alert("pppp"+p);
                } 
});
$('#xmgl_shi1').on({mouseover : function (e) {
var p= $("#xmgl_shi1 p").attr("title") ;
  if (p==null) {
	
} else {
$("#xmgl_shi1 p").attr("title",p.trim()) ;
}
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
  var p= $("#xmgl_shi1 p").attr("title") ;
  if (p==null) {
	
} else {
$("#xmgl_shi1 p").attr("title",p.trim()) ;
}
//// alert("pppp"+p);
                } 
});
$('#xmgl_shi').on({mouseover : function (e) {
var p= $("#xmgl_shi p").attr("title") ;
  if (p==null) {
	
} else {
$("#xmgl_shi p").attr("title",p.trim()) ;
}
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
  var p= $("#xmgl_shi p").attr("title") ;
  if (p==null) {
	
} else {
$("#xmgl_shi p").attr("title",p.trim()) ;
}
//// alert("pppp"+p);
                } 
});
        <c:if test="${!empty projectInfo}">
				<c:forEach var="i" items="${projectInfo}">
					var temp={id:"${i.projectid}",name:"${i.projectname}",quanpin:"${i.quanpin}",jianpin:"${i.jianpin}"};
					array_test.push(temp);
				</c:forEach>
			 </c:if>
         var scrH = $(window).height() - 115;
            $(".csdb_cont").css("height", scrH);
            $(".csdb_tab li").bind("click", function () {
                initLeft($(this),$(this).attr("val"));
                tabclick=$(this).attr("val");
              	if (tabclick==0) {
              	initlinereset(1);
                 initp1reset(1);
                 initlinereset(2);
                   initp1reset(2);
					initTimeLine(1);
					initTimeLine(2);
				} else {

				}
                $("#tab1 table").hide();
                $("#tab1 table").eq($(this).attr("val")).css("display", "table");
                $("#tab2 table").hide();
                $("#tab2 table").eq($(this).attr("val")).css("display", "table");
                 // var table1=$("#tab1 tr").size();
				   // var table2=$("#tab2 tr").size();
				     
            });
            initline( );    
            initp1();
              initSBTY(); 
            initFnz1();
              
            initFnz2();
            
            indicatedinit();
            //获取所选的设备类型
               $(window).resize(function(){
 // //alert("你改变了窗口大小！");
 // initline( );
//initp1();
 
if (array1.lenght==0) {
	 
} else {
 initline1(array1,1 );
}
if (array2.lenght==0) {
	  
} else {
  initline1(array2,2 );
  }
});
            //搜索
           //搜索开始
                $('#txt1').keyup(function() {
                	search(1);
                });
                $('#txt2').keyup(function() {
                	search(2);
                });
                
                $(".csdb_sear_a").bind('click',function(){
                	search($(this).attr("val"));
                });
                
                function search(num){
    	        	var keyStr="",lis="",$su="";
    	        	if(num==1){
    	        		keyStr=$("#txt"+num).val();
    	        	$su = $("#xmgl_shi1");//	$su = $("#slectSb");
    	        	}else if(num==2){
    	        		keyStr=$("#txt"+num).val();
    	        		$su = $("#xmgl_shi");//$su = $("#xmgl_shi");
    	        	}
    	        	keyStr=keyStr.toLowerCase(); 
    	        	var arr = new Array();
    				$.grep( array_test, function(item ){
    					if((check( item.quanpin,keyStr))||(check( item.jianpin,keyStr))||
    							(check( item.name,keyStr))){arr.push(item);}
    				});
    			//	var $ul=$("#txt"+num).parents(".list").find("ul");
    			//	$ul.empty();
    				$.each(arr,function(i,item){
    				lis+="<li val='"+item.id+"'><a href=''>"+item.name+"</a></li>";
    				//	$ul.append('<li val="'+item.id+'"><a href="">'+item.name+'</a></li>');
    				});
				//	$ul.find('a').bind('click',function(){
					//	console.log($(this).text());
					//	$("#txt"+num).parents(".list").siblings('p.text').children('span').html($(this).text());
					//	$('.list').hide();
				//	});
					 $su.find("ul").empty().append(lis);
		    					if(num == 1) initFnz1();
		    					else initFnz2();
    			//	console.log($ul.html());
    	        	
    	        }
    	        function check(str,reg){
    	        	if(str.toLowerCase().indexOf(reg)!=-1){
    	        		return true;
    	        	}else{
    	        		return false;
    				}
				}
    	        //搜索结束
    	          $(".csdb_sear_a").click(function(){
            //	search1($(this).attr("val"));
            });
            $('#selecthQ').simSelect({
				callback: function (x,v) {
					if(v){
					  initp1();
					 //// alert("p14-"+tabclick);
					 	initlinereset(1);
						initp1reset(1);
							initlinereset(2);
						initp1reset(2);
			 tabclick=0; 
			//// alert("p15-"+tabclick);
						sbType=v;//左边
				    	listLeft(v);
				 initSB1(Fnz1,sbType);
				  initSB2(Fnz2,sbType);
				    	
					}
				}
			});
            
            
		});
           
      
            
            //初始化设备类型
            function initSBTY(){
            //	if(${classid}!=0){
            	//	listLeft(${classid});
            	//	sbType=${classid};
            //	}
             
				    	 Fnz1=${pid};
				    	  Fnz2=${pid};
				    //	initSB1(Fnz1,sbType);
				    //initSB2(Fnz2,sbType);
           
            }        
              function initLeft(obj,num){
            	$(".csdb_tab li").attr("class", "csdb_li");
            	obj.attr("class", "csdb_lis");
                $("#showcdbtab table").css("display", "none");
                $("#showcdbtab table").eq(num).css("display", "table");
                	
            }    function listLeft(classid){
            	if(classid == null || classid == "") return;
	    		$.ajax({type:"GET",url:"<c:url value='/analyse/run/left' />",data:{id:classid},
	    			success:function(data){
 
					$("#showcdbtab").empty().html(data);
				 
					initLeft($(".csdb_tab li").eq(0),0);
			   	
				  // clickp();
	    		}});
	    	}     
               function initFnz1(){
            	//获取所选的泛能站1
            	initlinereset(1);
						initp1reset(1);
							 
	            $('#xmgl_shi1').simSelect({
					callback: function (x,v) {
						if(v){
				//	// alert(x+"--1--"+v);
				 initlinereset(1);
						initp1reset(1);
							 
					
							$("#tab1").empty();
							Fnz1=v;
							if (sbType=="") {
								// alert("设备类型为空");
							} else {

							}
							//// alert(Fnz1+"--2--"+sbType);
							if (tabclick==1) {
					 tabclick=0; 
					 initSB1(Fnz1,sbType);
					initSB2(Fnz2,sbType);
				} else {
				 tabclick=0; 
	                 initSB1(Fnz1,sbType);
				}
					    
					    	
						}
					}
				});
			//	alert("p11-"+tabclick);
				 tabclick=0; 
				//// alert("p12-"+tabclick);
				 
            }   //初始化设备1
	        function initSB1(Fnz1,sbType){
	    	    if(Fnz1 === "" || sbType === "") return;
	    	   //alert(Fnz1+"Fnz1,sbType"+sbType);
	    	    $.ajax({type:"GET",url:"<c:url value='/analyse/run/instance' />",data:{pid:Fnz1,cid:sbType},
	    			success:function(data){
	    	    		valSB1 = "";
	    				var sb = "",$sb = $("#xmgl_sheng1"),fsb = "";
	    				$.each(data,function(k){
	    					if(k == 0) {
	    						fsb = $(this)[0].classinstancename;
	    						valSB1 = $(this)[0].classinstanceid;
	    					}
	    					sb += '<li val="'+$(this)[0].classinstanceid+'"><a href="">'+$(this)[0].classinstancename+'</a></li>';
	    					
	    				});
						$sb.find(".text").text(fsb);
						$sb.find("ul").empty().append(sb);
						 //alert(fsb+"fsb,sb"+sb);
						  
						   //alert(( !valSB1)+"valSB1-"+( valSB1));
						if( valSB1!= null) {
						//alert("initChart( 1);-"+1);
						initTimeLine(1);//	initChart( 1);
						}//if(!valSB1) return;
					 //	//alert("MM1-"+1);
					 //	initTimeLine(1);
						$sb.simSelect({
							callback:function(x,v){
							initlinereset(1);
						initp1reset(1);
							 
								valSB1 = v ? v : "";
								initTimeLine(1);
							}
						});//设备
	    			}
	    	    });
	        }   function initContent(valPP,valSB,valSBType,judge,date,time){
	        //alert("tablenull1p05--"+judge);
	          tablenull1p0(judge);
	   
            	if(valPP == "" || valSB == "" || valSBType == ""|| date == ""|| time == null) return;//没有选择
            		
            	 
            	$.ajax({type:"GET",async:false,url:"<c:url value='/analyse/run/getValue' />",data:{cid:valSBType,sb:valSB,date:date,time:time},
            	error:function(data){
	    		      	
	    			 },
	    			success:function(data){
	    			// // alert("getValue2"+data);
            		    if(judge==1){
            		   // alert(time1+"judge==1-"+judge+"-"+time);
            		    $("#tab1").empty().html(data);
            		    	   	
            
            		    }else if(judge==2){
            		    // alert(time2+"judge==2-"+judge+"-"+time);
            		    	$("#tab2").empty().html(data);
            		    	    	
               
            		    }
	    			}
	    	    });
            }  function initFnz2(){
            	//获取所选的泛能站2
            	 
							initlinereset(2);
						initp1reset(2);
            $('#xmgl_shi').simSelect({
				callback: function (x,v) {
					if(v){
				 
							initlinereset(2);
						initp1reset(2);
						$("#tab2").empty();
						Fnz2=v;
						if (sbType=="") {
							//	// alert("设备类型为空");
							} else {

							}
				    	if (tabclick==1) {
					 tabclick=0; 
					 initSB1(Fnz1,sbType);
					initSB2(Fnz2,sbType);
				} else {
				 tabclick=0; 
	               initSB2(Fnz2,sbType);
				}
				    	
					}
				}
			});
		//	alert("p13-"+tabclick);
			 tabclick=0; 
			//// alert("p14-"+tabclick);
            }      //初始化设备2
	        function initSB2(Fnz2,sbType){
	    	    if(Fnz2 === "" || sbType === "") return;
	    	    $.ajax({type:"GET",url:"<c:url value='/analyse/run/instance' />",data:{pid:Fnz2,cid:sbType},
	    			success:function(data){
	    	    	    valSB2 = "";
	    				var sb = "",$sb = $("#xmgl_sheng"),fsb = "";
	    				$.each(data,function(k){
	    					if(k == 0) {
	    						fsb = $(this)[0].classinstancename;
	    						valSB2 = $(this)[0].classinstanceid;
	    					}
	    					sb += '<li val="'+$(this)[0].classinstanceid+'"><a href="">'+$(this)[0].classinstancename+'</a></li>';
	    				});
						$sb.find(".text").text(fsb);
						$sb.find("ul").empty().append(sb);
						if( valSB2!=null)	initTimeLine(2);// initChart( 2);
						//if(!valSB2) return;
					 //	initTimeLine(2);
						
						$sb.simSelect({
							callback:function(x,v){
							 
							initlinereset(2);
						initp1reset(2);
								valSB2 = v ? v : "";
								initTimeLine(2);
							}
						});//设备
	    			}
	    	    });
	        }     //初始化时间轴
                 function search1(num){
	        	var keyStr="",lis="",$su="";
	        	if(num==1){
	        		keyStr=$("#txt1").val();
	        		$su = $("#xmgl_shi1");
	        	}else if(num==2){
	        		keyStr=$("#txt2").val();
	        		$su = $("#xmgl_shi");
	        	}
	        	$.ajax({type:"GET",url:"<c:url value='/analyse/run/search' />",data:{str:keyStr},
		    			success:function(data){
		    				if(data.length==0){
		    					$("#txt1").val("没有查到"+keyStr);
		    				}else{
		    					$.each(data,function(n,value){
		    						lis+="<li val='"+value.projectid+"'><a href=''>"+value.projectname+"</a></li>";
		    					});
		    					$su.find("ul").empty().append(lis);
		    					if(num == 1) initFnz1();
		    					else initFnz2();
		    				}
		    			}
		    	});
	        }  function initTimeLinep(num,data1){
            	var valSB="",Fnz="";
            	if(num==1){
            		date=data1;
            		valSB=valSB1;
            		Fnz=Fnz1;
            	}
            	else if(num==2){
            		date=data1;
            		valSB=valSB2;
            		Fnz=Fnz2;
            	}
            	  ////alert("a11111111111__1_____"+sbType);
            	 ////alert("a11111111111___2____"+Fnz);
            	 ////alert("a11111111111____3___"+valSB);
            	 //alert("a11111111111____4___"+date);
            	 ////alert("a11111111111_____5__"+num);
            	  //alert("tablenull1p06--"+num);
            	  tablenull1p0(num);
            	 	if(sbType=="" ){
            	//// alert("设备类型不能为空" );
            	 
            	}  
            	if( Fnz==""  ){
            	 alert("能源站不能为空" );
            	  
            	}  if(  valSB== ""  ){
            	// alert("设备不能为空" );
            	  
            	 
            	} 
            	 
            	if(sbType!="" && Fnz!="" && valSB!= "" && date != ""){
            	 
            		datetimep(num,date );
            	}
            }  function initTimeLine(num){
           //alert("tablenull1p01--"+num);
             tablenull1p0(num);
            	 //	// alert("MM1-"+2);
            	  //	// alert("MM2-"+num);
            	var valSB="",Fnz="";
            	if(num==1){
            		date=$("#date1").val();
            		valSB=valSB1;
            		Fnz=Fnz1;
            	}
            	else if(num==2){
            		date=$("#date2").val();
            		valSB=valSB2;
            		Fnz=Fnz2;
            	}
            	 //	// alert("a11111111111__1_____"+sbType);
            	//	// alert("a11111111111___2____"+Fnz);
            	//	// alert("a11111111111____3___"+valSB);
            	//	// alert("a11111111111____4___"+date);
            	//	// alert("a11111111111_____5__"+num);
            	 	if(sbType=="" ){
            	//// alert("设备类型不能为空" );
            	 
            	}  
            	if( Fnz==""  ){
            	 alert("能源站不能为空" );
            	  
            	}  if(  valSB== ""  ){
            	// // alert("设备不能为空" );
            	  
            	 
            	}   	
            	if(sbType!="" && Fnz!="" && valSB!= "" && date != ""){
            	 //	// alert("MM3-"+2);
            		datetime(num);
            	}
            } 
             function initCharttime( a,data11){
             //alert("tablenull1p02--"+a);
             tablenull1p0(a);
             if(a==1){
					        	  date=data11;//$("#date1").val();
					        	  time=time1;
		 
				                   	 //     tablenull();
					          initContent(Fnz1,valSB1,sbType,   1,    date,time);
					        	   
					        	  initLeft($(".csdb_tab li").eq(0),0);
					          }
					          else if(a==2){
					        	   date=data11;//date=$("#date2").val();
					        	  time=time2;
					        	       
			  	//    tablenull();
					        	  initContent(Fnz2,valSB2,sbType,2,date,time);
					        	  
					        	  initLeft($(".csdb_tab li").eq(0),0);
					        	 
					          }
            } function initChart( a){
             //alert("tablenull1p02--"+a);
             tablenull1p0(a);
             if(a==1){
					        	  date=$("#date1").val();
					        	  time=time1;
		 
				                   	 //     tablenull();
					          initContent(Fnz1,valSB1,sbType,   1,    date,time);
					        	   
					        	  initLeft($(".csdb_tab li").eq(0),0);
					          }
					          else if(a==2){
					        	  date=$("#date2").val();
					        	  time=time2;
					        	       
			  	//    tablenull();
					        	  initContent(Fnz2,valSB2,sbType,2,date,time);
					        	  
					        	  initLeft($(".csdb_tab li").eq(0),0);
					        	 
					          }
            } //初始化时间轴
             function datetimep(num,data1){
            	var sbid,Fnz,$c,aa;
            	if(num==1){
            		date=data1;
            		sbid=valSB1;
            		Fnz=Fnz1;
            		 
            		aa=1;
            	}
            	else if(num==2){
            		date=data1;
            		sbid=valSB2;
            		Fnz=Fnz2;
            	 
            		aa=2;
            	}
                //	// alert("MM9-"+aa);
                 //alert("tablenull1p03--"+num);
                 tablenull1p0(num);
                  	
            	if(sbType=="" || Fnz=="" || sbid== "" || date == "") return;
            	  //	// alert("MM8"+aa);
            	$.ajax({type:"GET",async:false, url:"<c:url value='/analyse/run/timeLine' />",data:{classinstanceid:sbid,date:date},
		    			success:function(data){
            		       if(data.length==0){
            		       alert("MM7-"+date);
            		    	  initCharttime( aa,date);// initChart( aa); 
            		    	 // alert(data);
            		    	  // alert(data[0]);
            		    	    // alert(data[1]);
            		    	           if (aa==1) {
											array1={};
										} else {
				                             array2={};
										}
            		    	  initline1(data, aa);
            		       }
            		       else{
            		    // // alert(data);
            		        //  // alert("lll111111---------"+data.length);
            		    	// // alert("lll111111pppp"+data[0]);
            		    	  //  // alert("lll111111llllllll"+data[1]); 
			            		       initline1(data, aa);
			            		       //  // alert("MM6-"+date);
			            		    	 initCharttime( aa,date);//  initChart( aa);
			            		    	   if (aa==1) {
												array1=data;
											} else {
					                           array2=data;
											}
            		          }
            		       
		    			}
		    	});
            } //初始化时间轴
             function datetime(num){
            	var sbid,Fnz,$c,aa;
            	if(num==1){
            		date=$("#date1").val();
            		sbid=valSB1;
            		Fnz=Fnz1;
            		 
            		aa=1;
            	}
            	else if(num==2){
            		date=$("#date2").val();
            		sbid=valSB2;
            		Fnz=Fnz2;
            	 
            		aa=2;
            	}
               //	// alert("MM4-"+2);
               //alert("tablenull1p04--"+aa);
               tablenull1p0(aa);
                 	
            	if(sbType=="" || Fnz=="" || sbid== "" || date == "") return;
            	 //	// alert("MM5-"+2);
            	$.ajax({type:"GET",async:false,url:"<c:url value='/analyse/run/timeLine' />",data:{classinstanceid:sbid,date:date},
		    			success:function(data){
		    			 //	// alert("MM6-"+data);
            		       if(data.length==0){
            		    	  initChart( aa); 
            		    	  ////alert(data);
            		    	  ////alert(data[0]);
            		    	    ////alert(data[1]);
            		    	     if (aa==1) {
											array1={};
										} else {
				                             array2={};
										}
            		    	  initline1(data, aa);
            		       }
            		       else{
            		       ////alert(data);
            		            //////alert("lll111111---------"+data.length);
            		    	  //////alert("lll111111pppp"+data[0]);
            		    	    ////alert("lll111111llllllll"+data[1]); 
            		       initline1(data, aa);
            		    	   initChart( aa);
            		    	    if (aa==1) {
												array1=data;
											} else {
					                           array2=data;
											}
            		       }
		    			}
		    	});
            } 
      	function getValue(){
      	   ////alert("a11111111111_data_1_____"+sbType);
            
            	initChart(1);
            	
            	}
      	//////////////////////////////////////////////
      		function tablenull1p0(aa){
      		  	
      		 var table1=$("#table1 tr").size();
				    var table2=$("#table2 tr").size();
				    var tablenull1='<table id="dt" class="datalist_cdb">	<tbody>  ';
				    for ( var i = 0; i < table1; i++) {
						if ((i%2)==0) {
							    tablenull1+=' <tr class="even">';
						}else {
						 tablenull1+=' <tr class="odd">';	
						}
						 tablenull1+='<td>'+'-'+'</td> </tr>';
						  
					}
					 tablenull1+="  </tbody> </table>";	
				        var tablenull2='<table id="jt" class="datalist_cdb" style="display: none;">	<tbody>  ';
				    for ( var i = 0; i < table2; i++) {
						if ((i%2)==0) {
							    tablenull2+=' <tr class="even">';
						}else {
						 tablenull2+=' <tr class="odd">';	
						}
						 tablenull2+='<td>'+'-'+'</td> </tr>';
						  
					}
					 tablenull2+="  </tbody> </table>";	
				     var    tablenull1p="";
         var    tablenull2p="";
	    			   tablenull1p=tablenull1;
              tablenull2p=tablenull2;
              tablenull1p+=tablenull2p;
              var p1=$("#tab1 tr").size();
               var p2=$("#tab2 tr").size();
              // alert(aa+"ppppppppppp"+ tablenull1p);
              if (aa==1) {
            //  alert(aa+"pppppppp1ppp"+ tablenull1p);
				 $("#tab1").empty().html(tablenull1p);
			} else {
			//  alert(aa+"ppppp2pppppp"+ tablenull1p);
			
                    $("#tab2").empty().html(tablenull1p);
			}
      		 
      		}
      		function tablenulldddddddd(){
      		 	
      		 var table1=$("#table1 tr").size();
				    var table2=$("#table2 tr").size();
				    var tablenull1='<table id="dt" class="datalist_cdb">	<tbody>  ';
				    for ( var i = 0; i < table1; i++) {
						if ((i%2)==0) {
							    tablenull1+=' <tr class="even">';
						}else {
						 tablenull1+=' <tr class="odd">';	
						}
						 tablenull1+='<td>'+'-'+'</td> </tr>';
						  
					}
					 tablenull1+="  </tbody> </table>";	
				        var tablenull2='<table id="jt" class="datalist_cdb" style="display: none;">	<tbody>  ';
				    for ( var i = 0; i < table2; i++) {
						if ((i%2)==0) {
							    tablenull2+=' <tr class="even">';
						}else {
						 tablenull2+=' <tr class="odd">';	
						}
						 tablenull2+='<td>'+'-'+'</td> </tr>';
						  
					}
					 tablenull2+="  </tbody> </table>";	
				     var    tablenull1p="";
         var    tablenull2p="";
	    			   tablenull1p=tablenull1;
              tablenull2p=tablenull2;
              tablenull1p+=tablenull2p;
              var p1=$("#tab1 tr").size();
               var p2=$("#tab2 tr").size();
              ////// alert("ppppppppppp"+$("#tab1 #dt tr").size());
               if (tabclick==0) {
				if (
				     (
				      $("#tab1 table").size()==0 
				      )||
				     (
				      $("#tab1 #dt tr").size()!=$("#table1 tr").size() 
				     )
				     ) {
					 $("#tab1").empty().html(tablenull1p);
				} else {

				}
					if (
				     (
				      $("#tab2 table").size()==0 
				      )||
				     (
				      $("#tab2 #dt tr").size()!=$("#table1 tr").size() 
				     )
				     ) {
					 $("#tab2").empty().html(tablenull1p);
				} else {

				}
			} else {
	if (
				     (
				      $("#tab1 table").size()==0 
				      )||
				     (
				      $("#tab1 #jt tr").size()!=$("#table1 tr").size() 
				     )
				     ) {
					 $("#tab1").empty().html(tablenull1p);
				} else {

				}
					if (
				     (
				      $("#tab2 table").size()==0 
				      )||
				     (
				      $("#tab2 #jt tr").size()!=$("#table1 tr").size() 
				     )
				     ) {
					 $("#tab2").empty().html(tablenull1p);
				} else {

				}
			}
      		
      		}
      	function clickp(){
//// alert("你改变了窗口大小！");
  initline( );
initp1();
if (array1.lenght==0) {
	
} else {
 initline1(array1,1 );
}
if (array2.lenght==0) {
	
} else {
  initline1(array2,2 );
  }
}
      	function 	indicatedinit(){
      	
      	  $('#hintindict1').on({mouseover : function (e) {
////alert('替代.bind()移入！');
    $('#hint1').show();
     
	
},
mouseout : function () {
////alert('替代.bind()移出！');
  $('#hint1').hide();
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
  
                }, mousedown :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
    //// alert("p8-"+tabclick);
			 if (tabclick==0) {
		 
					initChart(1);
			} else {

			}
				
                }
});
        $('#hintindict2').on({mouseover : function (e) {
////alert('替代.bind()移入！');
    $('#hint2').show();
     
	
},
mouseout : function () {
////alert('替代.bind()移出！');
  $('#hint2').hide();
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
  
                }, mousedown :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
     
   // // alert("p1-"+tabclick);
			 if (tabclick==0) {
		 
					initChart(2);
			} else {

			}
				
                }
});        
  $('#mc1').on({mouseover : function (e) {
////alert('替代.bind()移入！');
    $('#hint1').show();
     var offset = $(this).offset();//DIV在页面的位置  
                var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
		
	
},
mouseout : function () {
////alert('替代.bind()移出！');
 $('#hint1').hide();
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
                 var xPos = parseInt(e.pageX+12) + "px";
                var yPos = parseInt(e.pageY+12) + "px";
              	 var offset = $("#mc1").offset();//DIV在页面的位置  
              
			    var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			   $('#hint').show();
			     $("#hint1").css("left", xPos).css("display","block");
                $("#hint1").css("top", yPos );
				 $("#hintindict1").css("left", x-5).css("display","block");
			  
     	  	 
     	  	  var width=$("#mc1").width();
    var height=$("#h1").height(); 
				$("#hint1").text(formattime(Math.round(x*1440/width)));
	time1=Math.round(x*1440/width);
	 if (time1>=1380) {
		time1=1380;
	} else {

	}
				time=time1;
                }, mousedown :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
                 var xPos = parseInt(e.pageX+12) + "px";
                var yPos = parseInt(e.pageY+12) + "px";
              	 var offset = $("#mc1").offset();//DIV在页面的位置  
              
			    var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			   $('#hint').show();
			     $("#hint1").css("left", xPos).css("display","block");
                $("#hint1").css("top", yPos );
				 $("#hintindict1").css("left", x-5).css("display","block");
			////alert(formattime(x*4)+"llllllllllllllllll");
			 var width=$("#mc1").width();
    var height=$("#h1").height(); 
				$("#hint1").text(formattime(Math.round(x*1440/width)));
			time1=Math.round(x*1440/width);
			 if (time1>=1380) {
		time1=1380;
	} else {

	}
				time=time1;
		//// alert("p2-"+tabclick);	
		  if (tabclick==0) {
			//// alert(" if (tabclick==01");
					initChart(1);
			} else {

			}
				
                }
});
  $('#mc2').on({mouseover : function (e) {
////alert('替代.bind()移入！');
    $('#hint2').show();
     var offset = $(this).offset();//DIV在页面的位置  
                var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
		
	
},
mouseout : function () {
////alert('替代.bind()移出！');
 $('#hint2').hide();
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
                 var xPos = parseInt(e.pageX+12-50) + "px";//50为向右显示提示框
                var yPos = parseInt(e.pageY+12) + "px";
              	 var offset = $("#mc2").offset();//DIV在页面的位置  
              
			    var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			   $('#hint').show();
			     $("#hint2").css("left", xPos).css("display","block");
                $("#hint2").css("top", yPos );
				 $("#hintindict2").css("left", x-5).css("display","block");
			
			var width=$("#mc2").width();
    var height=$("#h1").height(); 
				$("#hint2").text(formattime(Math.round(x*1440/width)));
				time2=Math.round(x*1440/width);
				 if (time2>=1380) {
		time2=1380;
	} else {

	}
				time=time2; 
                }, mousedown :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
                 var xPos = parseInt(e.pageX+12) + "px";
                var yPos = parseInt(e.pageY+12) + "px";
              	 var offset = $("#mc2").offset();//DIV在页面的位置  
              
			    var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			   $('#hint').show();
			     $("#hint2").css("left", xPos).css("display","block");
                $("#hint2").css("top", yPos );
				 $("#hintindict2").css("left", x-5).css("display","block");
		//	//alert(formattime(x*4)+"llllllllllllllllll");
		var width=$("#mc2").width();
    var height=$("#h1").height(); 
    time2=Math.round(x*1440/width);
     if (time2>=1380) {
		time2=1380;
	} else {

	}
				time=time2;
				$("#hint2").text(formattime(Math.round(x*1440/width)));
				//// alert("p3-"+tabclick);	
				  if (tabclick==0) {
					 //// alert(" if (tabclick==02");
				initChart(2);
			} else {

			}
                }
});
      	
      	}
      	
      	
     function 	ctxtexttestclick1(){
     $('#mc11').on({mouseover : function (e) {
////alert('替代.bind()移入！');
    $('#hint1').show();
     var offset = $(this).offset();//DIV在页面的位置  
                var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
		
	
},
mouseout : function () {
////alert('替代.bind()移出！');
 $('#hint1').hide();
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
                 var xPos = parseInt(e.pageX+12) + "px";
                var yPos = parseInt(e.pageY+12) + "px";
              	 var offset = $("#mc11").offset();//DIV在页面的位置  
              
			    var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			   $('#hint').show();
			     $("#hint1").css("left", xPos).css("display","block");
                $("#hint1").css("top", yPos );
				 $("#hintindict1").css("left", x-5).css("display","block");
			  
     	  	 
     	  	  var width=$("#mc11").width();
    var height=$("#h1").height(); 
				$("#hint1").text(formattime(Math.round(x*1440/width)));
	time1=Math.round(x*1440/width);
	 if (time1>=1380) {
		time1=1380;
	} else {

	}
				time=time1;
                }, mousedown :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
                 var xPos = parseInt(e.pageX+12) + "px";
                var yPos = parseInt(e.pageY+12) + "px";
              	 var offset = $("#mc11").offset();//DIV在页面的位置  
              
			    var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			   $('#hint').show();
			     $("#hint1").css("left", xPos).css("display","block");
                $("#hint1").css("top", yPos );
				 $("#hintindict1").css("left", x-5).css("display","block");
			////alert(formattime(x*4)+"llllllllllllllllll");
			 var width=$("#mc11").width();
    var height=$("#h1").height(); 
				$("#hint1").text(formattime(Math.round(x*1440/width)));
			time1=Math.round(x*1440/width);
			 if (time1>=1380) {
		time1=1380;
	} else {

	}
				time=time1;
		//// alert("p4-"+tabclick);	
		  if (tabclick==0) {
			//// alert(" if (tabclick==01");
					initChart(1);
			} else {

			}
				
                }
});
     
     }
      function 	ctxtexttestclick2(){
     $('#mc22').on({mouseover : function (e) {
////alert('替代.bind()移入！');
    $('#hint2').show();
     var offset = $(this).offset();//DIV在页面的位置  
                var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
		
	
},
mouseout : function () {
////alert('替代.bind()移出！');
 $('#hint2').hide();
}, mousemove :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
                 var xPos = parseInt(e.pageX+12-50) + "px";//50为向右显示提示框
                var yPos = parseInt(e.pageY+12) + "px";
              	 var offset = $("#mc22").offset();//DIV在页面的位置  
              
			    var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			   $('#hint').show();
			     $("#hint2").css("left", xPos).css("display","block");
                $("#hint2").css("top", yPos );
				 $("#hintindict2").css("left", x-5).css("display","block");
			
			var width=$("#mc22").width();
    var height=$("#h1").height(); 
				$("#hint2").text(formattime(Math.round(x*1440/width)));
				time2=Math.round(x*1440/width);
				 if (time2>=1380) {
		time2=1380;
	} else {

	}
				time=time2; 
                }, mousedown :function(e)//绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                {  
                 var xPos = parseInt(e.pageX+12) + "px";
                var yPos = parseInt(e.pageY+12) + "px";
              	 var offset = $("#mc22").offset();//DIV在页面的位置  
              
			    var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
			   $('#hint').show();
			     $("#hint2").css("left", xPos).css("display","block");
                $("#hint2").css("top", yPos );
				 $("#hintindict2").css("left", x-5).css("display","block");
		//	//alert(formattime(x*4)+"llllllllllllllllll");
		var width=$("#mc22").width();
    var height=$("#h1").height(); 
    time2=Math.round(x*1440/width);
    if (time2>=1380) {
		time2=1380;
	} else {

	}
				time=time2;
				$("#hint2").text(formattime(Math.round(x*1440/width)));
				//// alert("p5-"+tabclick);	 
				 if (tabclick==0) {
					 //// alert(" if (tabclick==02");
				initChart(2);
			} else {

			}
                }
});
     
     }
      	function immediately1(){
var element1 = document.getElementById("date1");
if("\v"=="v") {
element1.onpropertychange = webChange1;
}else{
 ////alert("mmmmmmm1");
element1.addEventListener("input",webChange1,false);
}
function webChange1(){
 ////alert("mmmmmmm");
if(element1.value){initTimeLine(1);};
}
}
function immediately2(){
var element2 = document.getElementById("date2");
if("\v"=="v") {
element2.onpropertychange = webChange2;
}else{
 ////alert("hhhhh2");
element2.addEventListener("input",webChange2,false);

}
function webChange2(){
 ////alert("hhhhh");
if(element2.value){initTimeLine(2);};
}
}   	function getOs() 
{ 
    var OsObject = ""; 
   if(navigator.userAgent.indexOf("MSIE")>0) { 
        return "MSIE"; 
   } 
   if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){ 
        return "Firefox"; 
   } 
   if(isSafari=navigator.userAgent.indexOf("Safari")>0) { 
        return "Safari"; 
   }  
   if(isCamino=navigator.userAgent.indexOf("Camino")>0){ 
        return "Camino"; 
   } 
   if(isMozilla=navigator.userAgent.indexOf("Gecko/")>0){ 
        return "Gecko"; 
   } 
   
} 
var t1=1440;
var t2=180;
var hh1=0;//
var hh11=10;//
var hh2=10;//
var hh22=10;//
var hh3=10;//
var hh33=10;//
var hh4=10;//
      	 function initline( ){ 
            	 // 获取canvas元素对应的DOM对象
	var canvas1 = document.getElementById('mc1');
	var canvas2 = document.getElementById('mc2');
	var ctx1 = canvas1.getContext('2d');
	var ctx2 = canvas2.getContext('2d');
	  var width=$("#h1").width();
    var height=$("#h1").height(); 
     	  
     	  	  var offset1 = $("#span1").width();
     	  	   var offset2 = $("#span2").width();
      
	// 设置填充颜色
	
	
	//alert( width+"-"+offset1+"-9s-"+ (width-40-offset1));
	var w1=Math.round( width-20-offset1) ;
	var w2=Math.round(( w1)/8);
	//var s='<canvas id="mc2" width="'+w1+'" height= "50"	  margin-top:-15;display:inline;	float: left "></canvas>';//'
	//$("#mc2").parent().remove("#mc2").append(s);
	$("#spantest11 ").empty();
   $("#spantest11").css("width",w1 ).css("height", 20 ) ;;
 $("#spantest22 ").empty();
   $("#spantest22").css("width",w1 ).css("height", 20 ) ;;
 	for ( var i = 0; i  < 8; i ++) {
	 //	var s1='<div id="divb'+i+'" style="position: relative;float:left; display: inline;" text-align: "left"><p   align="left" style="text-align: "left">'+formattime(i*180)+'</p></div>';
	//  $("#spantest22 ").append(s1);
	 //  var x =  $("#divb"+i).offset() ;
                
	 //// alert( i+"-o-"+ x.left );
	//  $("#divb"+i).css("left",w2*i  ) ;
 	}
	var s1='<canvas id="mc11" width="'+w1+'" height="15" 	style="float: left ;"></canvas> ';//'
	 $("#spantest11 ").append(s1);
	var s2='<canvas id="mc22" width="'+w1+'" height="15" 	  style="float: left ;"></canvas> ';//'
	 $("#spantest22 ").append(s2);
	 
	   $("#mc1").css("width",w1 ).css("height", 15 ) ;;
	   $("#mc2").css("width",w1 ).css("height", 15 ) ;;
	 var canvas11 = document.getElementById('mc11');
	var canvas22 = document.getElementById('mc22');
	var ctx11 = canvas11.getContext('2d');
	var ctx22 = canvas22.getContext('2d');
	    ctxtexttest(1, ctx11, w2);
	      ctxtexttest(2, ctx22, w2);
	      ctxtexttestclick1();
	      ctxtexttestclick2();
	      
	      /////////////////////////////////////////
	  //   $("#mc2").css("width", width );
ctxline2(1, ctx1);
ctxline2(2, ctx2);
	ctxlineindicate(1, ctx1);
ctxlineindicate(2, ctx2); 
 //ctxtext(1, ctx1);
//ctxtext(2, ctx2);
 
 
 
            }
 function initline1(array ,aa){
            	 // 获取canvas元素对应的DOM对象
	var canvas1 = document.getElementById('mc1');
	var canvas2 = document.getElementById('mc2');
	var ctx1 = canvas1.getContext('2d');
	var ctx2 = canvas2.getContext('2d');
	  var width=$("#h1").width();
    var height=$("#h1").height(); 
     	  
     	  	  var offset1 = $("#span1").width();
     	  	   var offset2 = $("#span2").width();
      
	// 设置填充颜色
	
	
	//alert( width+"-"+offset1+"-9s-"+ (width-40-offset1));
	var w1=Math.round( width-20-offset1) ;
	var w2=Math.round(( w1)/8);
	//var s='<canvas id="mc2" width="'+w1+'" height= "50"	  margin-top:-15;display:inline;	float: left "></canvas>';//'
	//$("#mc2").parent().remove("#mc2").append(s);
	$("#spantest11 ").empty();
   $("#spantest11").css("width",w1 ).css("height", 20 ) ;;
 $("#spantest22 ").empty();
   $("#spantest22").css("width",w1 ).css("height", 20 ) ;;
 	for ( var i = 0; i  < 8; i ++) {
	 //	var s1='<div id="divb'+i+'" style="position: relative;float:left; display: inline;" text-align: "left"><p   align="left" style="text-align: "left">'+formattime(i*180)+'</p></div>';
	//  $("#spantest22 ").append(s1);
	 //  var x =  $("#divb"+i).offset() ;
                
	 //// alert( i+"-o-"+ x.left );
	//  $("#divb"+i).css("left",w2*i  ) ;
 	}
	var s1='<canvas id="mc11" width="'+w1+'" height="15" 	style="float: left ;"></canvas> ';//'
	 $("#spantest11 ").append(s1);
	var s2='<canvas id="mc22" width="'+w1+'" height="15" 	  style="float: left ;"></canvas> ';//'
	 $("#spantest22 ").append(s2);
	 
	   $("#mc1").css("width",w1 ).css("height", 15 ) ;;
	   $("#mc2").css("width",w1 ).css("height", 15 ) ;;
	 var canvas11 = document.getElementById('mc11');
	var canvas22 = document.getElementById('mc22');
	var ctx11 = canvas11.getContext('2d');
	var ctx22 = canvas22.getContext('2d');
	    ctxtexttest(1, ctx11, w2);
	      ctxtexttest(2, ctx22, w2);
	      ctxtexttestclick1();
	      ctxtexttestclick2();
	      
	      /////////////////////////////////////////
	      
	 if (aa==2) {
 
	ctxline2(2, ctx2);
 //alert("mm3-"+aa);
 //alert("mm4-"+array);
 //alert("mm41-"+array.length);
ctxline2green(2, ctx2, array);
	} else {
		ctxline2(1, ctx1);
 //alert("mm1-"+aa);
 //alert("mm2-"+array);
 //alert("mm21-"+array.length);
ctxline2green(1, ctx1, array);
	}

	
ctxlineindicate(1, ctx1);
ctxlineindicate(2, ctx2);
 //ctxtext(1, ctx1);
//ctxtext(2, ctx2); 
 
 
 
            }
            function initlinereset( aa){
     	 // 获取canvas元素对应的DOM对象
	var canvas1 = document.getElementById('mc1');
	var canvas2 = document.getElementById('mc2');
	var ctx1 = canvas1.getContext('2d');
	var ctx2 = canvas2.getContext('2d');
	  var width=$("#h1").width();
    var height=$("#h1").height(); 
     	  
     	  	  var offset1 = $("#span1").width();
     	  	   var offset2 = $("#span2").width();
      
	// 设置填充颜色
	
	
	//alert( width+"-"+offset1+"-9s-"+ (width-40-offset1));
	var w1=Math.round( width-20-offset1) ;
	var w2=Math.round(( w1)/8);
	//var s='<canvas id="mc2" width="'+w1+'" height= "50"	  margin-top:-15;display:inline;	float: left "></canvas>';//'
	//$("#mc2").parent().remove("#mc2").append(s);
	$("#spantest11 ").empty();
   $("#spantest11").css("width",w1 ).css("height", 20 ) ;;
 $("#spantest22 ").empty();
   $("#spantest22").css("width",w1 ).css("height", 20 ) ;;
 	for ( var i = 0; i  < 8; i ++) {
	 //	var s1='<div id="divb'+i+'" style="position: relative;float:left; display: inline;" text-align: "left"><p   align="left" style="text-align: "left">'+formattime(i*180)+'</p></div>';
	//  $("#spantest22 ").append(s1);
	 //  var x =  $("#divb"+i).offset() ;
                
	 //// alert( i+"-o-"+ x.left );
	//  $("#divb"+i).css("left",w2*i  ) ;
 	}
	var s1='<canvas id="mc11" width="'+w1+'" height="15" 	style="float: left ;"></canvas> ';//'
	 $("#spantest11 ").append(s1);
	var s2='<canvas id="mc22" width="'+w1+'" height="15" 	  style="float: left ;"></canvas> ';//'
	 $("#spantest22 ").append(s2);
	 
	   $("#mc1").css("width",w1 ).css("height", 15 ) ;;
	   $("#mc2").css("width",w1 ).css("height", 15 ) ;;
	 var canvas11 = document.getElementById('mc11');
	var canvas22 = document.getElementById('mc22');
	var ctx11 = canvas11.getContext('2d');
	var ctx22 = canvas22.getContext('2d');
	     ctxtexttest(1, ctx11, w2);
	      ctxtexttest(2, ctx22, w2);
	      ctxtexttestclick1();
	      ctxtexttestclick2();
	      /////////////////////////////////////////

	 if (aa==2) {
 
ctxline2(2, ctx2);
	} else {
	ctxline2(1, ctx1);
   
	}

	 
ctxlineindicate(1, ctx1);
ctxlineindicate(2, ctx2);
 //ctxtext(1, ctx1);
//ctxtext(2, ctx2);
 
 
 
            }
             function ctxline2(num,ctx) {
           // 设置填充颜色
		ctx.fillStyle = '#CCC';
	// 填充一个矩形
	ctx.fillRect(  0  ,   0 ,  1440 , 10);
}
  function ctxline2green(num,ctx,array) {
        // 设置填充颜色
	ctx.fillStyle = '#009900';
	 
 
	 for(var i=0;i<1440 ;i+=1) 
{ 
// 填充一个矩形
 
	if( array[i  ]==1)
	{ 
	 
		ctx.fillRect( i  ,  0 , 1, 10); 
	} 
	else{ 
	  
	} 
 
}
}
            function ctxlineindicate(num,ctx) {
            ctx.fillStyle = '#ccc';
	 
	for(var i=0;i<=t1;i++) 
{ 
// 填充一个矩形
	if((i%t2)==0) 
	{ 
	ctx.fillRect( i  , 10 , 4  , 5); 
		 
	} 
	else{ 
	  
	} 
 
} 
}
            
            
             function ctxtext(num,ctx) {
             
             ctx .fillStyle = '#969696';
 ctx .font = 'bold 25px 幼圆';//'25px 微软雅黑';// '25px Tahoma, Helvetica, Arial';  //'bold 15px 微软雅黑';
 ctx .textBaseline ='bottom';// 文字的垂直对齐方式,值top,hanging,middle,alphabetic(默认),ideographic,bottom 
for(var i=0;i<=t1;i++) 
{ 
// 填充一个矩形
	if((i==1340) ) 
	{ 
	
  ctx .strokeText(formattime(1440),i+20 ,30 );
		 
	}  else if((i%t2)==0) 
	{ 
	
	ctx.strokeText(formattime(i),i,30 );
		
	} 
	else{ 
	  
	} 
 
}  
             
             
             }  function ctxtexttest(num,ctx,width) {
           // // alert(num+"-"+ctx+"-"+width);
             ctx .fillStyle = '#969696';
 ctx .font = '10px 微软雅黑';//'bold 25px 幼圆';//'25px 微软雅黑';// '25px Tahoma, Helvetica, Arial';  //'bold 15px 微软雅黑';
 ctx .textBaseline ='middle';// 文字的垂直对齐方式,值top,hanging,middle,alphabetic(默认),ideographic,bottom 
for(var i=0;i< 8;i++) 
{ 
// 填充一个矩形
	if((i==1340) ) 
	{ 
	
 // ctx .fillText(formattime(1440),i+20 ,0 );
		 
	}   
	{ 
	//// alert(num+"-"+ctx+"-"+width+"\n"+formattime(i*180)+"-"+i*width+"-"+10);
	ctx.fillText(formattime(i*180),i*width,5 );
		
	} 
	
 
}  
         ctx .fillText(formattime(1380),(7.5)*width ,5 );     
             
             }
 function formattime(num) 
{ 
if(num<0){ 
num=0;
}
if(num>1380){ 
num=1380;
}
var hour;
var minute;
var i;
var end="";
i=num/60;
			 if (i >= 0) {
							i = Math.floor(i); //返回小于等于原rslt的最大整数。   
						
						////////alert("mmmmmmmm1>>>"+ (i)) 
						}
						else {
							i = Math.ceil(i); //返回大于等于原rslt的最小整数。 
							////////alert("mmmmmmmm2>>>"+ (i))   
						}
			if(i<10){
				end="0"+i;
				////////alert("111111111>>>"+ (end));
				}else{
					end+= i;
					//////alert( "22222222>>>"+(end));
					}
		   //////alert( "33333333332>>>"+(i));
		
		end+= ":";
		//////alert("4444444442>>>"+ (end));
var minute=num%60; 
 if(minute<10){
	end+="0"+minute;
	}else{
		end+= minute;
		}
return end; 
}
      		function getValue(){}
    	function getX(obj){
    		var parObj=obj;  
    		var left=obj.offsetLeft;  
    	 	while(parObj=parObj.offsetParent){  
    	  		left+=parObj.offsetLeft;  
    		}  
     		return left;  
    	}  
      
    	function getY(obj){  
    		var parObj=obj;  
    		var top=obj.offsetTop;  
    		while(parObj = parObj.offsetParent){  
    	 		top+=parObj.offsetTop;  
    	 	}  
    	 return top;  
    	} 
    	function showme1(){
  	       
  	       }
    	 function initp1(){
 $("#hintindict1").css("left", -5).css("display","block");
  $("#hintindict2").css("left", -5).css("display","block");
   	   	 time1=0;
   	   	 time2=0;
   	   	 time=0;
   	       }
   	        function initp1reset(aa){
   	        if (aa==1) {
				 $("#hintindict1").css("left", -5).css("display","block");
				  time1=0;
			} else {
  $("#hintindict2").css("left", -5).css("display","block");
   	   	
   	   	 time2=0;
			}


   	   	 time=0;
   	       }
  	       function hidme1(){
  	        var oSon = window.document.getElementById("hint1");
  	        if(oSon == null) return;
  	        oSon.style.display="none";
  	       } function showme2(){
      	         
      	       }
      	       function hidme2(){
      	        var oSon = window.document.getElementById("hint2");
      	        if(oSon == null) return;
      	        oSon.style.display="none";
      	       }
      	     function onclickme1(){
      	       ////alert(time1);
      	  	  		initChart(1);
      	  	}
      	   function onclickme2(){
      	       ////alert(time2);
      	  	 
      	  	  	initChart(2);
      	  	}
      	 function pp(){
      	       ////alert(time1);
      	  	 // 	initTimeLine(1);
      	  	 
      	  	}
      	
      	    function OnPropChanged1 (event) {
            if (event.propertyName.toLowerCase () == "value") {
                ////alert ("The new content1: " + event.srcElement.value);
                  ////alert("a11111111111_data_1_____"+sbType);
            
            	initTimeLine(1);
            }
        }
         function OnPropChanged2 (event) {
            if (event.propertyName.toLowerCase () == "value") {
                ////alert ("The new content2: " + event.srcElement.value);
                  ////alert("a11111111111_data_2_____"+sbType);
            
            	initTimeLine(2);
            }
        }
        function OnInput1 (event) {
            
            
            	initTimeLine(1);
             
        }
        function OnInput2 (event) {
           
            
            	initTimeLine(2);
            
        }function cDayFunc1(){  
cFunc1('d');  
}  
function cMonthFunc1(){  
cFunc1('M');  
}  
function cYearFunc1(){  
cFunc1('y');  
}  
function cFunc1(who){ 


var str,p,c = $dp.cal;  
if(who=='y'){  
str='年份';  
p='y';  
}  
else if(who=='M'){  
str='月份';  
p='M';  
}  
else if(who=='d'){  
str='日期';  
p='d'; 
 ////alert($dp.cal.newdate.y+"-"+$dp.cal.newdate.M+"-"+$dp.cal.newdate.d+"kk");
 ////alert(str+'发生改变了1!\n$dp.cal.date.'+p+'='+c.date[p]+'\n$dp.cal.newdate.'+p+'='+c.newdate[p]); 
 	$("#date1").val();
 	initlinereset(1);
initp1reset(1);
 //alert(str+'发生改变了1!\n$dp.cal.date.'+p+'='+c.date[p]+'\n$dp.cal.newdate.'+p+'='+c.newdate[p]);  
 	initTimeLinep(1,$dp.cal.newdate.y+"-"+$dp.cal.newdate.M+"-"+$dp.cal.newdate.d);
}  
 //alert(str+'发生改变了2!\n$dp.cal.date.'+p+'='+c.date[p]+'\n$dp.cal.newdate.'+p+'='+c.newdate[p]);  
}  
function cDayFunc2(){  
cFunc2('d');  
}  
function cMonthFunc2(){  
cFunc2('M');  
}  
function cYearFunc2(){  
cFunc2('y');  
}  
function cFunc2(who){  
//alert(who+"who2"); 
var str,p,c = $dp.cal;  
if(who=='y'){  
str='年份';  
p='y';  
}  
else if(who=='M'){  
str='月份';  
p='M';  
}  
else if(who=='d'){  
str='日期';  
p='d'; 
////alert($dp.cal.newdate.y+"-"+$dp.cal.newdate.M+"-"+$dp.cal.newdate.d+"mm");
////alert(str+'发生改变了2!\n$dp.cal.date.'+p+'='+c.date[p]+'\n$dp.cal.newdate.'+p+'='+c.newdate[p]); 

$("#date2").val();
initlinereset(2);
initp1reset(2);
//alert(str+'发生改变3了!\n$dp.cal.date.'+p+'='+c.date[p]+'\n$dp.cal.newdate.'+p+'='+c.newdate[p]); 
 initTimeLinep(2,$dp.cal.newdate.y+"-"+$dp.cal.newdate.M+"-"+$dp.cal.newdate.d);
}  
 //alert(str+'发生改变4了!\n$dp.cal.date.'+p+'='+c.date[p]+'\n$dp.cal.newdate.'+p+'='+c.newdate[p]);  
}  
    </script>
</head>
<body>
	<div id="hint1" style="display:none"></div>
	<div id="hint2" style="display:none"></div>
	<div id="hint3" style="display:none"></div>
	<jsp:include page="../../header.jsp"></jsp:include>

	<div class="csdb_cont" style="padding-top:13px;overflow:auto;">
		<table class="datalist_cdb csdb_datalist">
			<tr class="csdb_head">
				<td id="poiuy" class="csdb_th1"
					style="vertical-align:middle; height: 44px;">
					<div class="mod-select csdb_sel" id="selecthQ">
						<c:if test="${classid==0 and classname==null}">
							<p class="text">设备类型</p>
						</c:if>
						<c:if test="${classid!=0 and classname!=null}">
							<%--<p class="text">${classname}</p>--%>
							<p class="text">设备类型</p>
						</c:if>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<div class="list" style="height:300px;overflow-y:auto;">
							<ul>
								<c:forEach items="${standards}" var="c">
									<c:choose>
										<c:when test="${ fn:length(c.classname)  > 8}">
											<c:set var="testStr" value="${c.classname}" />
											<li title="${c.classname}" val="${c.classid}"><a
												title="${c.classname}" href="">${fn:substring(testStr,0,6)}...</a>
												<%--  <em  >${c.classname}</em>--%>
											</li>
										</c:when>
										<c:otherwise>
											<li title="${c.classname}" val="${c.classid}"
												hide="${c.classname}"><a title="${c.classname}" href="">${c.classname}</a>
												<%--  <em  >${c.classname}</em>--%>
											</li>
										</c:otherwise>

									</c:choose>
									<%-- 	<li val="${c.classid}" hide="${c.classname}"><a href="">${c.classname}</a>   <em  >${c.classname}</em> 
									</li>--%>
								</c:forEach>
							</ul>
						</div>
					</div>
				</td>
				<td class="csdb_th2" id="h1"
					style="vertical-align:middle; height: 44px;">
					<ul class="csdb_th2_ul1">
						<li class="csdb_th2_name1">对比设备 1</li>
						<li class="csdb_th2_xzsb">
							<div class="mod-select csdb_sel csdb_xzsb" id="xmgl_shi1">
								<p class="text">
									<span>${pvo.projectname}</span>
								</p>
								<span class="arr-group hand"> <i
									class="icon-mod icon-arr"></i> </span>
								<div class="list">
									<div class="csdb_sear">
										<input id="txt1" type="text" /><span val="1"
											class="csdb_sear_a" style="padding-left: 0;"></span>
									</div>
									<ul
										style="height:200px;overflow:hidden;overflow-y:auto;width: 212px;">

										<c:if test="${!empty projectInfo}">
											<c:forEach var="i" items="${projectInfo}">
												<li val="${i.projectid}"><a href="">${i.projectname}</a>
												</li>
											</c:forEach>
										</c:if>
									</ul>
								</div>
							</div>
						</li>
						<li class="csdb_th2_xzsb">
						<li class="csdb_th2_xzsb" style="margin-left: 10px;">
							<div class="mod-select csdb_sel csdb_xzsb" id="xmgl_sheng1">
								<p class="text">选择设备</p>
								<span class="arr-group hand"> <i
									class="icon-mod icon-arr"></i> </span>
								<div class="list">
									<ul></ul>
								</div>
							</div></li>
					</ul></td>
				<td class="csdb_th2 csdb_th3"
					style="vertical-align:middle; height: 44px;">
					<ul class="csdb_th2_ul1">
						<li class="csdb_th2_name1">对比设备 2</li>
						<li class="csdb_th2_xzsb">
							<div class="mod-select csdb_sel csdb_xzsb" id="xmgl_shi">
								<p class="text">
									<span>${pvo.projectname}</span>
								</p>
								<span class="arr-group hand"> <i
									class="icon-mod icon-arr"></i> </span>
								<div class="list">
									<div class="csdb_sear">
										<input id="txt2" type="text" /><span val="2"
											class="csdb_sear_a" style="padding-left: 0;"></span>
									</div>
									<ul
										style="height:200px;overflow:hidden;overflow-y:auto;width: 212px;">
										<c:if test="${!empty projectInfo}">
											<c:forEach var="i" items="${projectInfo}">
												<li val="${i.projectid}"><a href="">${i.projectname}</a>
												</li>
											</c:forEach>
										</c:if>
									</ul>
								</div>
							</div></li>
						<li class="csdb_th2_xzsb" style="margin-left: 10px;">
							<div class="mod-select csdb_sel csdb_xzsb" id="xmgl_sheng">
								<p class="text">选择设备</p>
								<span class="arr-group hand"> <i
									class="icon-mod icon-arr"></i> </span>
								<div class="list">
									<ul></ul>
								</div>
							</div></li>
					</ul></td>
			</tr>
			<tr class="csdb_head2"
				style="margin-top: -35px;height: 44px; border-left:1px solid white; 
			  background:url(../img/point1.gif) repeat-x; border-bottom:1px solid white;">
				<td class="csdb_td2"
					style="margin-top: -15px;height: 44px; border-left:1px solid white; 
			  background:url(../img/point1.gif) repeat-x; border-bottom:1px solid white;">
					<ul class="csdb_tab">
						<li class="csdb_lis" val="0">动态参数</li>
						<li class="csdb_li" style="margin-left: 10px;" val="1">静态参数</li>
					</ul></td>
				<td class="csdb_td2"
					style="margin-top: -15px;height: 44px; border-left:1px solid white; 
			  background:url(../img/point1.gif) repeat-x; border-bottom:1px solid white;">
					<table class="set_zhou">
						<tr>

							<td><span> <span id="span1"
									style="display: inline;float: left;""> <input id="date1"
										type="text" value="${curDay}" class="Wdate itxt w80"
										style="float: left; margin-top: -20"  
										 
										onfocus="WdatePicker({dchanging:pp, Mchanging:pp, ychanging:pp, dchanged:cDayFunc1, Mchanged:cMonthFunc1, ychanged:cYearFunc1})"
										autocomplete="off" /> </span> <span
									style="display: inline;float: left;margin-left: 10px;">
										<div>
											<div id="hintindict1" style="display:inline;   height: 10;">
												<img src="<c:url value='/resources/img/point1.gif'   />"
													style="display:inline;   height: 10;" />

											</div>
											<canvas id="mc1" width="1440" height="15"
												style="float: left; ">
									
									
									</canvas>
											<div id="spantest11" style="display:block;"></div>
										</div> </span> </span></td>
						</tr>

					</table></td>
				<td class="csdb_td2"
					style="margin-top: -15px;height: 44px; border-left:1px solid white; 
			  background:url(../img/point1.gif) repeat-x; border-bottom:1px solid white;">
					<table class="set_zhou">
						<tr>

							<td><span> <span id="span2"
									style="display: inline;float: left;""> <input id="date2"
										type="text" value="${curDay}" class="Wdate itxt w80"
										style="float: left; margin-top: -20"  
										onfocus="WdatePicker({dchanging:pp, Mchanging:pp, ychanging:pp, dchanged:cDayFunc2, Mchanged:cMonthFunc2, ychanged:cYearFunc2})"
										autocomplete="off" /> </span> <span
									style="display: inline;float: left;margin-left: 10px;">
										<div>
											<div id="hintindict2" style="display:inline;   height: 10;">
												<img src="<c:url value='/resources/img/point1.gif'   />"
													style="display:inline;   height: 10;" />

											</div>
											<canvas id="mc2" width="1440" height="15"
												style="float: left; ">
									
									
									</canvas>
											<div id="spantest22" style="display:block;"></div>
										</div> </span> </span></td>
						</tr>



					</table></td>
			</tr>
			<tr class="yxcsdb-tablebody" style="overflow-y:auto;">
				<td id="showcdbtab"
					style="vertical-align:top;border-bottom:none;border-left: none;"></td>
				<td style="vertical-align:top;border-bottom:none;border-left: none;"
					id="tab1"></td>
				<td style="vertical-align:top;border-bottom:none;border-left: none;"
					id="tab2"></td>
			</tr>

		</table>

	</div>
</body>
</html>
