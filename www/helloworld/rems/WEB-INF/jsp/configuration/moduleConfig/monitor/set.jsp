<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	closeFancybox();
	var hnid="",gnid="",propertyid="",rid=0,content="" ,size=0,isFirst=true,isFirst1=true;
	var projectid=$('#projectId').val();
	
	//换算系数数据初始化
	initRatio(projectid,0);
	function initRatio(projectid,page){
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/listByProjectid' />?new="+new Date().getTime(),data:{projectid:projectid,page:page},
	    success:function(data){
		    $("#rational").empty().html(data);
		    if(isFirst) {
	        	var count = $("#count").val();
	        	if(count>1) initPagination(count);
	        	else $("#Pagination").empty();
	        }
		    delHSXS();
		    editHSXS();
	    },error:function(){
			jAlert('加载失败！');
		}});
	}
	//系统指标数据初始化
	var max=0;
	initHomepage(projectid,2);
	function initHomepage(projectid,modelid){
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/listHomepage' />?new="+new Date().getTime(),data:{projectid:projectid,modelid:2},
	    success:function(data){	
		    $("#homepage").empty().html(data);
		    size=$("#hp").data('val');
		    if(size==4){
		    	$('#xtzbNew').hide();
		    }else{
		    	$('#xtzbNew').show();
		    }
		    if(size>0){
		    	max = $('#hp').find('tr:last-child').find('input[name="location"]').val();
		    }
		    delXTZB();
		    editXTZB();
	    },error:function(){
			jAlert('加载失败！');
		}});
	}
	//能源结构数据初始化
	initStructure(projectid,0);
	function initStructure(projectid,page){
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/listStructure' />?new="+new Date().getTime(),data:{projectid:projectid,page:page},
	    success:function(data){
		    $("#structure").empty().html(data);
		    if(isFirst1) {
	        	var count1 = $("#count1").val();
	        	if(count1>1) initPagination1(count1);
	        	else $("#Pagination1").empty();
	        }
		    delNYJG();
		    editNYJG();
	    },error:function(){
			jAlert('加载失败！');
		}});
	}
	
	
	//耗能/供能结构设置数据初始化
	var hnpid="",gnpid="";
	initEnergy(projectid);
	function initEnergy(pid){
		var hn="",gn="";
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/lists' />?new="+new Date().getTime(),data:{projectid:pid},
	    success:function(data){
			if(data.hnList!=0){
				hn=data.hnList.classinstancename;
				hnid=data.hnList.classinstanceid;
				hnpid=2;
				$("#hn").find(".text").text(hn).attr('title',hn);
			}
			if(data.gnList!=0){
				gn=data.gnList.classinstancename;
				gnid=data.gnList.classinstanceid;
				gnpid=3;
				$("#gn").find(".text").text(gn).attr('title',gn);;
			}
	    },error:function(){
			jAlert('加载失败！');
		}});
		
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/list' />?new="+new Date().getTime(),data:{projectid:pid},
	    success:function(data){
		    $.each(data,function(k){
		    	content += '<li val="'+$(this)[0].classinstanceid+'"><a class="w221 ellipsis" title='+$(this)[0].classinstancename+' href="">'+$(this)[0].classinstancename+'</a></li>';
		    });
		    
		    $("#hn").find("ul").empty().append(content);
		    
		    $("#gn").find("ul").empty().append(content);
		    
		    $("#hn").simSelect({
				callback:function(x,v){
				hnid = v ? v : hnid;
				}
			});
		    $("#gn").simSelect({
				callback:function(x,v){
				gnid = v ? v : gnid;
				}
			});
		},error:function(){
			jAlert('加载失败！');
		}});
	}
	
	//耗能/供能设置保存
	$(".savehngn").click(function(){
		var mid="",cid="",propertytypeid="";
		mid=$(this).attr("val");
		if(mid==4){
			cid=hnid;
			propertytypeid=2;
			hnpid=2;
		}
		else if(mid==5){
			cid=gnid;
			propertytypeid=3;
			gnpid=3;
		}
		$.ajax({type:"POST",url:"<c:url value='/modulemonitor/save' />?new="+new Date().getTime(),data:{projectid:projectid,modelid:mid,classinstanceid:cid,propertytypeid:propertytypeid},
	    success:function(data){
			if(data){
				hnid=hnid;
				gnid=gnid;
				jAlert("保存成功！");
			}
			else{
				jAlert("保存失败！");
			}
	    },error:function(){
			jAlert('保存失败！');
		}});
	});
	
	//耗能/供能换算系数新增属性初始化
	initProperty();
	
	function initProperty(){
	$("#hsxsNew").click(function(){
		$("#hsxs").find("h2").text("新增耗能供能结构换算系数维护");
		$("#hsxs").find("p").text("选择属性");
		propertyid="";
		$('#hsxs .popCheckMsg').css({'display':'none'}).text("");
		
		var propertyname="",pcontent="";
		$("#ratio").val("");
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/listPropertyByInstid' />?new="+new Date().getTime(),data:{Instid:hnid,Type:"2,3"},
	    success:function(data){
			$.each(data,function(k){
	    		pcontent += '<li val="'+$(this)[0].classpropertyid+'"><a href="">'+$(this)[0].classpropertyname+'</a></li>';
	    	});
		    $("#propertys").find("ul").empty().append(pcontent);
		    $("#propertys").simSelect({
				callback:function(x,v){
					propertyid = v ? v : propertyid;
					if(v&&propertyid!=""){
						$('#hsxs .popCheckMsg').eq(0).css({'display':'none'}).text("");
					}
				}
			});
		},error:function(){
			jAlert('加载失败！');
		}});
    });}
	
	//耗能/供能结构换算系数新增保存按钮
	$("#savehsxs").click(function(){
		var ratio=$("#ratio").val();
		$('#hsxs .popCheckMsg').css({'display':'none'}).text("");
		if(projectid==""){
			jAlert("请选择要配置的项目！");
			return;
		}
		if(propertyid==""){
			$('#hsxs .popCheckMsg').eq(0).css({'display':'block'}).text("请选择属性");
			return;
		}
		if(ratio==""){
			$('#hsxs .popCheckMsg').eq(1).css({'display':'block'}).text("请填写换算系数");
			return;
		}
		else if(isNaN(ratio)){
			$('#hsxs .popCheckMsg').eq(1).css({'display':'block'}).text("换算系数必须为数字类型");
			return;
		}
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/addRational' />?new="+new Date().getTime(),data:{projectid:projectid,classpropertyid:propertyid,ratio:ratio,rid:rid},
	    success:function(data){
			if(data){
				if(rid==0){
					jAlert("耗能/供能结构设置新增成功！");
				}
				else{
					rid=0;
					jAlert("耗能/供能结构设置修改成功！");
				}
				$.fancybox.close();
				isFirst = true;
				initRatio(projectid,0);
			}
			/**
			 * 金尚彬
			 * 2014-12-23 15:31:40
			 */
			else{
					if(rid==0){
					jAlert("耗能/供能结构设置新增失败！");
				}
				else{
					rid=0;
					jAlert("耗能/供能结构设置修改失败！");
				}
			}
		},error:function(){
			jAlert('操作失败！');
		}
	
		});
    });
	//耗能/供能结构换算系数删除
	function delHSXS(){
	$("#rTab .mksjpzDel").unbind("click").click(function(){
		var obj = $(this);
		
		jConfirm("确定要删除吗？","确定",function(r){
			if(r == true){
				var id=obj.attr("val");
				$.ajax({type:"POST",url:"<c:url value='/modulemonitor/delRational' />?new="+new Date().getTime(),data:{id:id},
					success:function(data){
						if(data){
							jAlert("删除成功！");
							isFirst = true;
							initRatio(projectid,0);
						}
						else{
							jAlert("删除失败！");
							return false;
						}
					},error:function(){
						jAlert('删除失败！');
					}	
				});
			}
		});
    });}
	
	//耗能供能结构换算系数维护修改
	function editHSXS(){
	$("#rTab .mksjpzEdi").click(function(){
		$("#hsxs").find("h2").text("修改耗能供能结构换算系数维护");
		var id=$(this).attr("val");
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/editRational' />?new="+new Date().getTime(),data:{pid:projectid,id:id},
	    success:function(data){
				propertyid=data.classpropertyid;
				rid=data.id;
				$("#ratio").val(data.ratio);
				$("#propertys").find(".text").text(data.classpropertyname).attr('title',data.classpropertyname);
				
	    },error:function(){jAlert('修改失败！');}
		});
    });}
	//能源结构分解初始化下拉框
	var fSBid="", fpropertyid="",sSBid="",spropertyid="",structureid=0;
	function initNYJGnew(hnid){
		fSBid=hnid;
		$("#fsb").val($("#hn p").text());//能源结构分解   主设备名
		var pcontents="";
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/listPropertyByInstid' />?new="+new Date().getTime(),data:{Instid:fSBid,Type:"2,3"},
	    success:function(data){
			$.each(data,function(k){
	    		pcontents += '<li val="'+$(this)[0].classpropertyid+'"><a href="">'+$(this)[0].classpropertyname+'</a></li>';
	    	});
	    	$("#fpropertys").find("ul").empty().append(pcontents);//主属性
	    	$("#fpropertys").simSelect({
			callback:function(x,v){
			fpropertyid = v ? v : fpropertyid;
			if(v&&fpropertyid!=""){
				$('#nyjgfj .popCheckMsg').eq(0).css({'display':'none'}).text("");
			}
			}
		});
	   },error:function(){jAlert('加载失败！');}});
		$("#sSB").find("ul").empty().append(content);//子设备
		var scontents="";
		$("#sSB").simSelect({
			callback:function(x,v){
			sSBid = v ? v : sSBid;
			if(v&&sSBid!=""){
				$('#nyjgfj .popCheckMsg').eq(1).css({'display':'none'}).text("");
				$("#spropertys").find(".text").text("");
				spropertyid="";
			}
			else{
				$("#spropertys").find("ul").empty().end().find('.list').hide();
				$("#spropertys").off('click');
			}
			$.ajax({type:"GET",url:"<c:url value='/modulemonitor/listPropertyByInstid' />?new="+new Date().getTime(),data:{Instid:sSBid,Type:"2,3"},
                success:function(data){
		        $.each(data,function(k){
    	        	scontents += '<li val="'+$(this)[0].classpropertyid+'"><a href="">'+$(this)[0].classpropertyname+'</a></li>';
             	});
		        
           		$("#spropertys").find("ul").empty().append(scontents);//子属性
    
            	$("#spropertys").simSelect({
		        	callback:function(x,v){
		        	spropertyid = v ? v : spropertyid;
		        	if(v&&spropertyid!=""){
		        		$('#nyjgfj .popCheckMsg').eq(2).css({'display':'none'}).text("");
		        	}
		        	}
	        	});
       			},error:function(){jAlert('加载失败！');}
			});
			}
		});
		
	}
	$("#nyjgNew").click(function(){
		$('#nyjgfj .popCheckMsg').css({'display':'none'}).text("");
		$("#nyjgfj").find("h2").text("新增能源结构分解");
		structureid=0;
		$("#fpropertys").find(".text").text("");
		fpropertyid="";
		$("#sSB").find(".text").text("");
		sSBid="";
		$("#spropertys").find(".text").text("");
		spropertyid="";
		initNYJGnew(hnid);
    });
	
	//能源结构分解新增保存按钮
	$("#savenyjg").click(function(){
		$('#nyjgfj .popCheckMsg').css({'display':'none'}).text("");
		if(projectid==""){
			jAlert("请选择要配置的项目！");
			return;
		}
		if(fSBid==""){
			jAlert("请选择主设备！");
			return;
		}
		if(fpropertyid==""){
			$('#nyjgfj .popCheckMsg').eq(0).css({'display':'block'}).text("请选择主属性");
			return;
		}
		if(sSBid==""){
			$('#nyjgfj .popCheckMsg').eq(1).css({'display':'block'}).text("请选择子设备");
			return;
		}
		if(spropertyid==""){
			$('#nyjgfj .popCheckMsg').eq(2).css({'display':'block'}).text("请选择子属性");
			return;
		}
		
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/addStructure' />?new="+new Date().getTime(),data:{projectid:projectid,fid:fSBid,fpid:fpropertyid,sid:sSBid,spid:spropertyid,structureid:structureid},
	    success:function(data){
			if(data){
				if(structureid==0){
					jAlert("能源结构分解新增成功！");
				}
				else{
					structureid=0;
					jAlert("能源结构分解修改成功！");
				}
				$.fancybox.close();
				isFirst1 = true;
				initStructure(projectid,0);
				
			}
			/**
			 * 金尚彬
			 * 2014-12-23 15:32:14
			 * @memberOf {TypeName} 
			 * @return {TypeName} 
			 */
			else{
				if(structureid==0){
					jAlert("能源结构分解新增失败！");
				}
				else{
					structureid=0;
					jAlert("能源结构分解修改失败！");
				}
			}
		},error:function(){jAlert('操作失败！');}});
    });
	
	//能源结构分解删除
	function delNYJG(){
	$("#sTab .mksjpzDel").unbind("click").click(function(){
		var obj = $(this);
		jConfirm("确定要删除吗？","确定",function(r){
			if(r == true){
				var id=obj.attr("val");
				$.ajax({type:"POST",url:"<c:url value='/modulemonitor/delStructure' />?new="+new Date().getTime(),data:{id:id},
					success:function(data){
						if(data){
							jAlert("删除成功！");
							isFirst1 = true;
							initStructure(projectid,0);
						}
						else{
							jAlert("删除失败！");
							return false;
						}
					},error:function(){jAlert("操作失败！");}
				});
			}
		});

    });}
	
	//能源结构分解修改
	function editNYJG(){
	$("#sTab .mksjpzEdi").click(function(){
		$("#nyjgfj").find("h2").text("修改能源结构分解");
		var id=$(this).attr("val");
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/editStructure' />?new="+new Date().getTime(),data:{pid:projectid,id:id},
	    success:function(data){
				structureid=data.id;
				$("#fsb").val(data.fclassinstancename);
				fSBid=data.fclassinstanceid;
				$("#fpropertys").find(".text").text(data.fclasspropertyname).attr('title',data.fclasspropertyname);
				fpropertyid=data.fclasspropertyid;
				$("#sSB").find(".text").text(data.sclassinstancename);
				sSBid=data.sclassinstanceid;
				$("#spropertys").find(".text").text(data.sclasspropertyname).attr('title',data.sclasspropertyname);
				spropertyid=data.sclasspropertyid;
				initNYJGnew(hnid);
	    },error:function(){jAlert('修改失败！');}
	});
    });}
	
	//系统指标新增初始化下拉框
	var bindSBid="",zbpid="",homeid1=0,homeid2=0,homeid3=0,homepageid=0;
	function initXTZBnew(projectid){
		$("#xzxtzb").find("h2").text("新增系统指标数据");
		var zbcontent="",zbpcontent="";
		bindSBid=hnid;
		
		$("#bindSB p").text($("#hn p").text()).attr('title',$("#hn p").text());;
		
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/list' />?new="+new Date().getTime(),data:{projectid:projectid},
	    success:function(data){
	    $.each(data,function(k){
	    	zbcontent += '<li val="'+$(this)[0].classinstanceid+'"><a href="">'+$(this)[0].classinstancename+'</a></li>';
	    });
	    $("#bindSB").find("ul").empty().append(zbcontent);
	    $("#bindSB").simSelect({
			callback:function(x,v){
			bindSBid = v ? v : bindSBid;
			if(bindSBid!=""){
				$('#xzxtzb .popCheckMsg').eq(0).css({'display':'none'}).text("");
				$("#zbproperty").find(".text").text("");
				zbpid="";
			}
			else{
				$("#zbproperty").find("ul").empty().end().find('.list').hide();
				$("#zbproperty").off('click');
			}
			}
		});
	    if(bindSBid!=""){
	    	$.ajax({type:"GET",url:"<c:url value='/moduleconfig/listPropertyByUnit' />?new="+new Date().getTime(),data:{Instid:bindSBid},
	         success:function(data){
			 $.each(data,function(k){
				 zbpcontent += '<li val="'+$(this)[0].classpropertyid+'"><a href="">'+$(this)[0].classpropertyname+'</a></li>';
			 });
			 $("#zbproperty").find("ul").empty().append(zbpcontent);
			 $("#zbproperty").simSelect({
			        callback:function(x,v){
			        zbpid = v ? v : zbpid;
			        if(v&&zbpid!=""){
			        	$('#xzxtzb .popCheckMsg').eq(1).css({'display':'none'}).text("");
			        }
			        }
		     });
	        }});
	    }
	    
	},error:function(){jAlert('加载失败！');}});
	
	//仪表盘数据约束	
	$("#top1").blur(function(){
		
		var Vtop1 = $("#top1").val();
		if(Vtop1=="") return;
		$("#limit2").val(Vtop1).attr("disabled",'disabled');
	});
		
	$("#top2").blur(function(){
		
		var Vtop2 = $("#top2").val();
		if(Vtop2=="") return;
		$("#limit3").val(Vtop2).attr("disabled",'disabled');
	});
		
		
	}
	
	$("#xtzbNew").click(function(){
		$('#xzxtzb .popCheckMsg').css({'display':'none'}).text("");
		$("#showname").val("");	
		$("#zbproperty").find(".text").text("");
		zbpid="";
		$("#unitname").val("");
		homeid1=0;
		homeid2=0;
		homeid3=0;
		homepageid=0;
		$("#limit1").val("");
		$("#top1").val("");
		$("#color1").val("");
		
		$("#limit2").val("");
		$("#top2").val("");
		$("#color2").val("");
		
		$("#limit3").val("");
		$("#top3").val("");
		$("#color3").val("");
		initXTZBnew(projectid);
		
    });
	
	//系统指标数据删除
	function delXTZB(){
	$("#hp .mksjpzDel").unbind("click").click(function(){
		var obj = $(this);
		jConfirm("确定要删除吗？","确定",function(r){
			if(r == true){
				
		        var classinstanceid=obj.parents('tr').find('td').eq(1).find('input[name="classinstanceid"]').val();
		        var classpropertyid=obj.parents('tr').find('td').eq(3).find('input[name="classpropertyid"]').val();
		        var modelid=2;
		        var location=obj.attr("val");
		        
				$.ajax({type:"POST",url:"<c:url value='/modulemonitor/delHomePage' />?new="+new Date().getTime(),data:{projectid:projectid,modelid:modelid,location:location,classinstanceid:classinstanceid,classpropertyid:classpropertyid},
					success:function(data){
						if(data){
							jAlert("删除成功");
							initHomepage(projectid,2);
						}
						else{
							jAlert("删除失败！");
							return false;
						}
					},error:function(){jAlert('删除失败！');}	
				});
			}
		});
		
    });}
	
	//系统指标数据修改
	var location1=0;
	function editXTZB(){
	$("#hp .mksjpzEdi").click(function(){
		$("#xzxtzb").find("h2").text("修改系统指标数据");
		
		var $this = $(this);
		
		var classinstanceid=$this.parents('tr').find('td').eq(1).find('input[name="classinstanceid"]').val();
		var classpropertyid=$this.parents('tr').find('td').eq(3).find('input[name="classpropertyid"]').val();
		var modelid=2;
		location1=$this.attr("val");
		
		$.ajax({type:"GET",url:"<c:url value='/modulemonitor/editHomepage' />?new="+new Date().getTime(),
			data:{projectid:projectid,modelid:modelid,location:location1,classinstanceid:classinstanceid,classpropertyid:classpropertyid},
	    success:function(data){
			
			homepageid=data.homepage.id;
			$("#bindSB").find(".text").text(data.homepage.classinstancename).attr('title',data.homepage.classinstancename);
			bindSBid=data.homepage.classinstanceid;
			
			$("#showname").val(data.homepage.showname);
			
			$("#zbproperty").find(".text").text(data.homepage.classpropertyname).attr('title',data.homepage.classpropertyname);
			zbpid=data.homepage.classpropertyid;
			
			$("#unitname").val(data.homepage.unitname);
			var homeid=new Array();
			$.each(data.gauge,function(k,item){
				
				 $("#limit"+(k+1)).val(item.gfrom);
				 $("#top"+(k+1)).val(item.gto);
				 $("#color"+(k+1)).val(item.color);
				 
				 homeid[k]=item.id;
				 
			});
			homeid1=homeid[0];
			homeid2=homeid[1];
			homeid3=homeid[2];
			
			initXTZBnew(projectid);
			
			
	    },error:function(){jAlert('操作失败！');}
	});
    });}
	
	//系统指标数据新增
	$("#savextzb").click(function(){
		
		var showname=$("#showname").val();
		var unitname=$("#unitname").val();
		var gf1="",gt1="",c1="",gf2="",gt2="",c2="",gf3="",gt3="",c3="";
		gf1=$("#limit1").val();
		gt1=$("#top1").val();
		c1=$("#color1").val();
		
		gf2=$("#limit2").val();
		gt2=$("#top2").val();
		c2=$("#color2").val();
		
		gf3=$("#limit3").val();
		gt3=$("#top3").val();
		c3=$("#color3").val();
		if(location1==0){
			max++;
		}
		else{
			max=location1;
		}
		
		$('#xzxtzb .popCheckMsg').css({'display':'none'}).text("");
		if(projectid==""){
			jAlert("请选择要配置的项目！");
			return;
		}
		if(bindSBid==""){
			$('#xzxtzb .popCheckMsg').eq(0).css({'display':'block'}).text("请选择绑定设备");
			return;
		}
		if(zbpid==""){
			$('#xzxtzb .popCheckMsg').eq(1).css({'display':'block'}).text("请选择属性");
			return;
		}
		if(showname==""){
			$('#xzxtzb .popCheckMsg').eq(2).css({'display':'block'}).text("请填写属性显示名");
			return;
		}
		if(unitname==""){
			$('#xzxtzb .popCheckMsg').eq(3).css({'display':'block'}).text("请填写单位");
			return;
		}
		var flag = true
		$('#xzxtzb .colorInput').each(function(){
			 if($(this).val().trim().length==0){
				$('#xzxtzb .popCheckMsg').eq(4).css({'display':'block'}).text("请完善仪表盘数据");
				flag = false;
			 }
		 });
		$('#xzxtzb .colorNumber').each(function(){
			 if(isNaN($(this).val())){
				$('#xzxtzb .popCheckMsg').eq(4).css({'display':'block'}).text("百分比区间必须为数字类型");
				flag = false;
			 }
		 });
		if(!flag) return; 
		$.ajax({type:"POST",url:"<c:url value='/modulemonitor/addHomepage' />?new="+new Date().getTime(),
			data:{projectid:projectid,modelid:2,location:max,classinstanceid:bindSBid,classpropertyid:zbpid,showname:showname,unitname:unitname,gf1:gf1,gt1:gt1,c1:c1,gf2:gf2,gt2:gt2,c2:c2,gf3:gf3,gt3:gt3,c3:c3,homeid1:homeid1,homeid2:homeid2,homeid3:homeid3,homepageid:homepageid},
	    success:function(data){
			if(data){
				if(homeid1==0&&homeid2==0&&homeid3==0&&homepageid==0){
					jAlert("系统指标数据新增成功！");
				}
				else{
					homeid1=0;
					homeid2=0;
					homeid3=0;
					homepageid=0;
					location1=0;
					jAlert("系统指标数据修改成功！");
				}
				$.fancybox.close();
				initHomepage(projectid,2);
			}
			/**
			 * 金尚彬
			 * 2014-12-23 15:33:09
			 * @param {Object} pagers
			 */
				else{
				if(homeid1==0&&homeid2==0&&homeid3==0&&homepageid==0){
					jAlert("系统指标数据新增失败！");
				}
				else{
					homeid1=0;
					homeid2=0;
					homeid3=0;
					homepageid=0;
					location1=0;
					jAlert("系统指标数据修改失败！");
				}
			}
	},error:function(){jAlert('操作失败！');}});
    });
	
	//换算系数分页
	function initPagination(pagers) {
		$("#Pagination").pagination(pagers, {
			num_edge_entries: 1,
			num_display_entries: 4,
			callback: pageselectCallback,
			items_per_page: 1,
			prev_text: "上一页",
			next_text: "下一页"
		});
	}
	
	function pageselectCallback(page_index, jq){
        if(isFirst) {isFirst = false;return;}
		initRatio(projectid,page_index);
		return false;
	}
	
	//能源结构分页
	function initPagination1(pagers) {
		$("#Pagination1").pagination(pagers, {
			num_edge_entries: 1,
			num_display_entries: 4,
			callback: pageselectCallback1,
			items_per_page: 1,
			prev_text: "上一页",
			next_text: "下一页"
		});
	}
	
	function pageselectCallback1(page_index, jq){
        if(isFirst1) {isFirst1 = false;return;}
		initStructure(projectid,page_index);
		return false;
	}
	
	
})
</script>
<!--start-->
<div class="mksjpzglszBlock" id="c2b1">
    <div class="mksjpzglszbInner">
        <p class="mksjpzTitle">耗能结构设置</p>
        <div class="mksjpzLine clearfix">
            <div class="mod-select mksjpzMs" id="hn">
                <p class="text w205 ellipsis">选择设备</p>
                <span class="arr-group hand">
                    <i class="icon-mod icon-arr"></i>
                </span>
                <div class="list">
                    <ul>
                    </ul>
                </div>
            </div>
            <div class="mksjpzLine clearfix">
                <span val="4" class="newButton p410 right savehngn">保存</span>
            </div>
        </div>
    </div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c2b2">
    <div class="mksjpzglszbInner">
        <p class="mksjpzTitle">供能结构设置</p>
        <div class="mksjpzLine clearfix">
            <div class="mod-select mksjpzMs" id="gn">
                <p class="text w205 ellipsis">选择设备</p>
                <span class="arr-group hand">
                    <i class="icon-mod icon-arr"></i>
                </span>
                <div class="list">
                    <ul>
                    </ul>
                </div>
            </div>
            <div class="mksjpzLine clearfix">
                <span val="5" class="newButton p410 right savehngn">保存</span>
            </div>
        </div>
    </div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c2b3">
    <div class="mksjpzglszbInner">
        <p class="mksjpzTitle">耗能供能结构换算系数维护</p>
        <div class="mksjpzLine clearfix">
            <span href="#hsxs" id="hsxsNew" class="newButton p410 right mr15 fancybox">新增</span>
        </div>
        <div class="mksjpzTableBox" id="rational">
            
        </div>
        <div class="wrap">
            <div class="datalist-div" style="border-left: none; border-top: none;">
                <%--
                <div id="tableDiv" style="background-color: #fff;overflow-y:auto;"></div>
                 --%>
                <div class="page mt10">
					<div id="Pagination" class="pagination"></div>
				</div>
             </div>
        </div>
    </div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c2b4">
    <div class="mksjpzglszbInner">
        <p class="mksjpzTitle">能源结构分解</p>
        <div class="mksjpzLine clearfix">
            <span href="#nyjgfj" id="nyjgNew" class="newButton p410 right mr15 fancybox">新增</span>
        </div>
        <div class="mksjpzTableBox" id="structure">
            
        </div>
        <div class="wrap">
            <div class="datalist-div" style="border-left: none; border-top: none;">
                <%--
                <div id="tableDiv" style="background-color: #fff;overflow-y:auto;"></div>
                 --%>
                <div class="page mt10">
					<div id="Pagination1" class="pagination"></div>
				</div>
             </div>
        </div>
    </div>
</div>
<!--end-->
<!--start-->
<div class="mksjpzglszBlock" id="c2b5">
    <div class="mksjpzglszbInner">
        <p class="mksjpzTitle">系统指标设置</p>
        <div class="mksjpzLine clearfix">
            <span href="#xzxtzb" id="xtzbNew" class="newButton p410 right mr15 fancybox">新增</span>
        </div>
        <div class="mksjpzTableBox" id="homepage">
            
        </div>
    </div>
</div>

<div id="hsxs" class="mod-pop xzxtzbBlock">
                <div class="hd">
                    <h2>新增耗能供能结构换算系数维护</h2>
                </div>
            <div class="popBg">
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">属性：</span>
                    <div class="mod-select popSelStyle w243" id="propertys">
                        <p class="text w205 ellipsis">选择属性</p>
                        <span class="arr-group hand">
                            <i class="icon-mod icon-arr"></i>
                        </span>
                        <div class="list" style="height:80px;overflow-y: auto;">
                            <ul></ul>
                        </div>
                    </div>
                    <span class="popCheckMsg"></span>
                </div>
               
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">换算系数：</span>
                    <input id="ratio" class="popInputStyle w274" type="">
                    <span class="popCheckMsg"></span>
                </div>
            </div>
            <div class="popButtonArea clearfix">
                <span class="newButton closeFancybox newButtonCancel p425 right mr15">取消</span>
                <span id="savehsxs" class="newButton p425 right mr15">保存</span>
            </div>
        </div>
        
<div id="nyjgfj" class="mod-pop xzxtzbBlock">
                <div class="hd">
                    <h2>新增能源结构分解</h2>
                </div>
            <div class="popBg">
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">主设备：</span>
                    <input id="fsb" class="popInputStyle w274" type="" readonly="true">
                </div>
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">主属性：</span>
                    <div class="mod-select popSelStyle w243" id="fpropertys">
                        <p class="text w205 ellipsis"></p>
                        <span class="arr-group hand">
                            <i class="icon-mod icon-arr"></i>
                        </span>
                        <div class="list" style="height:80px;overflow-y: auto;">
                            <ul></ul>
                        </div>
                    </div>
                    <span class="popCheckMsg"></span>
                </div>
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">子设备：</span>
                    <div class="mod-select popSelStyle w243" id="sSB">
                        <p class="text w205 ellipsis"></p>
                        <span class="arr-group hand">
                            <i class="icon-mod icon-arr"></i>
                        </span>
                        <div class="list" style="height:80px;overflow-y: auto;">
                            <ul></ul>
                        </div>
                    </div>
                    <span class="popCheckMsg"></span>
                </div>
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">子属性：</span>
                    <div class="mod-select popSelStyle w243" id="spropertys">
                        <p class="text w205 ellipsis"></p>
                        <span class="arr-group hand">
                            <i class="icon-mod icon-arr"></i>
                        </span>
                        <div class="list" style="height:80px;overflow-y: auto;">
                            <ul></ul>
                        </div>
                    </div>
                    <span class="popCheckMsg"></span>
                </div>
                
            </div>
            <div class="popButtonArea clearfix">
                <span class="newButton closeFancybox newButtonCancel p425 right mr15">取消</span>
                <span id="savenyjg" class="newButton p425 right mr15">保存</span>
            </div>
        </div>



	<div id="xzxtzb" class="mod-pop xzxtzbBlock">
                <div class="hd">
                    <h2>新增系统指标</h2>
                </div>
            <div class="popBg">
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">绑定设备：</span>
                    <div class="mod-select popSelStyle w243" id="bindSB">
                        <p class="text w205 ellipsis">选择设备</p>
                        <span class="arr-group hand">
                            <i class="icon-mod icon-arr"></i>
                        </span>
                        <div class="list">
                            <ul>
                            </ul>
                        </div>
                    </div>
                    <span class="popCheckMsg"></span>
                </div>
                
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">属性：</span>
                    <div class="mod-select popSelStyle w243" id="zbproperty">
                        <p class="text w205 ellipsis">选择设备</p>
                        <span class="arr-group hand">
                            <i class="icon-mod icon-arr"></i>
                        </span>
                        <div class="list">
                            <ul>
                            </ul>
                        </div>
                    </div>
                    <span class="popCheckMsg"></span>
                </div>
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">属性显示名：</span>
                    <input id="showname" class="popInputStyle w274" type="">
                    <span class="popCheckMsg"></span>
                </div>
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">单位：</span>
                    <input id="unitname" class="popInputStyle w274" type="">
                    <span class="popCheckMsg"></span>
                </div>
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">仪表盘1级状态：</span>
                    <div class="plInner">
                       <span class="mr1">百分比区间</span>  
                       <input id="limit1" class="popInputStyle w36 fs12 colorInput colorNumber" type="">
                       <span class="mlr1">-</span>
                       <input id="top1" class="popInputStyle w36 fs12 colorInput colorNumber" type="">
                       <span class="ml15">颜色</span>
                       <input id="color1" value="" class="popInputStyle w80 cp fs12 colorInput" type="">
                    </div>
                </div>
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">仪表盘1级状态：</span>
                    <div class="plInner">
                       <span class="mr1">百分比区间</span>  
                       <input id="limit2" class="popInputStyle w36 fs12 colorInput colorNumber" type="">
                       <span class="mlr1">-</span>
                       <input id="top2" class="popInputStyle w36 fs12 colorInput colorNumber" type="">
                       <span class="ml15">颜色</span>
                       <input id="color2" value="" class="popInputStyle w80 cp fs12 colorInput" type="">
                    </div>
                </div>
                <div class="popLine mtb4">
                    <span class="popLabelStyle w118">仪表盘1级状态：</span>
                    <div class="plInner">
                       <span class="mr1">百分比区间</span>  
                       <input id="limit3" class="popInputStyle w36 fs12 colorInput colorNumber" type="">
                       <span class="mlr1">-</span>
                       <input id="top3" class="popInputStyle w36 fs12 colorInput colorNumber" type="">
                       <span class="ml15">颜色</span>
                       <input id="color3" value="" class="popInputStyle w80 cp fs12 colorInput" type="">
                    </div>
                </div>
                <span class="popCheckMsg"></span>
            </div>
            <div class="popButtonArea clearfix">
                <span class="newButton closeFancybox newButtonCancel p425 right mr15">取消</span>
                <span id="savextzb" class="newButton p425 right mr15">保存</span>
            </div>
        </div>
<!--end-->
<%--
<div class="mksjpzLine clearfix">
    <span class="newButton p410 newButtonCancel right mr15">保存</span>
</div>
 --%>

<script>
$(function(){
	  $('.cp').ColorPicker({
	onSubmit: function(hsb, hex, rgb, el) {
		$(el).val(hex);
		$(el).ColorPickerHide();
	},
	onBeforeShow: function () {
		$(this).ColorPickerSetColor(this.value);
	}
})
.bind('click', function(){
	$(this).ColorPickerSetColor(this.value);
});
})
</script>