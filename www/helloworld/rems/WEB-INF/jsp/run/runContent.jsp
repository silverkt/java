<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
$(function(){
	var scrH=$(window).height()- 130;
	$(".datalist-div").css("height",scrH-50);
	popFancybox();
	Highcharts.setOptions({
		global: {useUTC: false}
	})
	var seriesOptions = [],propertyid,instance = ${instance};
	$(".ico",".datalist").click(function(){
		$("#unit").val($(this).parent().parent().parent().find(".unit").text());
		$("#highstock").empty();
		var len = $("input","#datalisttable").length,
			title = $(this).parent().find(">span").text();
		propertyid = $(this).attr("pid");
		$(".hd h2","#pop-oncanshu").html(title+"运行参数详细");
		var temps = [],instanceid = ""; 
		$("input","#datalisttable").each(function(i){
			var temp = $(this).val().split(";");
			temps.push(temp);
			instanceid += temp[0] + ";";
		});
		$.ajax({type:"GET",url:"<c:url value='/run/highstock' />?new="+new Date().getTime(),//async:false,
				data:{date:"${date}",instanceid:instanceid,propertyid:propertyid},
				success:function(data){
					for(var i = 0;i < temps.length;i++){
						$.each(data,function(k,v){
							var temp = temps[i]
							if(k == temp[0]){
								seriesOptions[i]={name:temp[1],data:v};
								return true;
							}
						});
					}
					createChart();
				}
		});
	});
	//刷新页面
	function getDataByMin(){
		$.ajax({type:"GET",url:"<c:url value='/run/data/min' />?new="+new Date().getTime(),data:{instanceid:instance},
				success:function(data){
					$.each(data,function(k,v){
						$(".datavalue:eq("+k+")").text(v.datavalue);
					})
				}
		});
	}
	clearInterval($("#interval").val());
	$("#interval").val(setInterval(getDataByMin,1000*60)); 
	function createChart(){
		$('#highstock').highcharts('StockChart', { 
			chart : { 
				/*events : { 
						load : function() { 
									var series = this.series[0];
									setInterval(function() {
											$.ajax({type:"GET",url:"<c:url value='/run/min' />?new="+new Date().getTime(),
												data:{instanceid:instance,propertyid:propertyid},
												success:function(data){
							                		 series.addPoint([data.time, data.data], true, true);
												}
											});
									}, 1000*60); 
							} 
					}*/ 
			},
			credits:{enabled:false},
			rangeSelector: {
				buttons:[
					{type:'minute',count:60,text:"小时"},
					{type:'all',text:"全天"}
				],
				selected: 0,
				inputEnabled:false
			},
			xAxis:{
				dateTimeLabelFormats: {
				<%--
					second: '%Y-%m-%d<br/>%H:%M:%S',
                    minute: '%Y-%m-%d<br/>%H:%M',
                    hour: '%Y-%m-%d<br/>%H:%M',
                    day: '%Y<br/>%m-%d',
                    week: '%Y<br/>%m-%d',
                    month: '%Y-%m',
                    year: '%Y'
                    
                    second: '%H:%M:%S',--%>
                    minute: '%H:%M',
                    hour: '%H:%M',
                    day: '%m-%d',
                    week: '%m-%d',
                    month: '%Y-%m',
                    year: '%Y'
                }
            },
			yAxis: { opposite:false }, 
        	tooltip:{
        		//xDateFormat: '%Y-%m-%d %H:%M:%S',
				crosshairs: true,shared: true,
				formatter: function() {
					var date=new Date(Number(this.x));
					var month=(date.getMonth()+1)>=10?(date.getMonth()+1):("0"+(date.getMonth()+1));
					var day=(date.getDate())>=10?(date.getDate()):("0"+(date.getDate()));
					var hours=(date.getHours())>=10?(date.getHours()):("0"+(date.getHours()));
					var minutes=(date.getMinutes())>=10?(date.getMinutes()):("0"+(date.getMinutes()));
					var seconds=(date.getSeconds())>=10?(date.getSeconds()):("0"+(date.getSeconds()));
					//date.get
	                var s = '<b>'+ date.getFullYear()+'-'+month+'-'+day+' '+hours+'H'+minutes+'M </b>';
	                $.each(this.points, function(i, point) {
	                    s += '<br/>数值: '+ Number(point.y).toFixed(2)+" "+$("#unit").val();
	                });
	                return s;
	            }
			},
        	legend:{enabled:false},
			series: seriesOptions
		}); 
	}
	$(".ygysxpz li").bind("click", function () {
                $(".ygysxpz li").removeClass("li_sel");
                $(this).addClass("li_sel");
                $(".datalist").css("display", "none");
                $("#" + $(this).attr("checkid")).css("display", "");

            });
})
</script>

<div class="tblcomhead sbsx_tblcomhead">
                            <span class="h2"></span>
                            <ul class="ygysxpz">
                                <li class="li_sel" checkid="datalisttable">动态属性</li>
                                <li checkid="datalisttable2">静态属性</li>
                            </ul>
                        </div>

<div class="datalist-div datalist-content-sbsxjc">
		<table class="datalist newdatalist" id="datalisttable">
			<thead>
				<tr>
					<td><span class="leftspan">参数</span></td>
					<td>
						${infos[0].projectname }-${instances[0].classinstancename }
						<input type="hidden" value="${instances[0].classinstanceid};${instances[0].classinstancename }" />
					</td>
					<%--<c:if test="${!empty lists[1]}">
						<td>${infos[1].projectname }-${instances[1].classinstancename }</td>
						<input type="hidden" value="${instances[1].classinstanceid};${instances[1].classinstancename }" />
					</c:if>
				--%></tr>
			</thead>
			<tbody>
				<c:forEach items="${lists[0]}" var="e" varStatus="s">
					<tr class="${s.index % 2 eq 0 ? 'even':'odd' } ">
						<td>
							<span class="leftspan">
								<span>${e.propertyname }</span>
								<c:if test="${e.datavalue1 ne '-' }">
								<i class="ico ico-yxxl mb5f mr5 fancybox" pid="${e.propertyid}" href="#pop-oncanshu"></i></c:if>
							</span>
						</td>
						<c:choose>
							<c:when test="${e.datavalue1 eq '-' }"><td><span class="datavalue">-</span></td></c:when>
							<c:otherwise><td><span class="datavalue">${e.datavalue}</span><span class="unit sbsx_unit">${e.unitname }</span></td></c:otherwise>
						</c:choose>
						<%--<c:if test="${!empty lists[1]}">
							<td>${lists[1][s.index].datavalue }${lists[1][s.index].unitname }</td>
						</c:if>
					--%></tr>
				</c:forEach>
				<c:set var="len" value="${fn:length(lists[0])}" />
				<%--<c:forEach items="${staticLists[0]}" var="e" varStatus="s">
					<tr class="${(len + s.index) % 2 eq 0 ? 'even':'odd' }">
						<td><span class="leftspan">${e.propertyname }</span></td>
						<td>${e.datavalue }</td>
						<c:if test="${!empty lists[1]}">
							<td>${staticLists[1][s.index].datavalue }</td>
						</c:if>
					</tr>
				</c:forEach>
			--%></tbody>
		</table>
		<table class="datalist" id="datalisttable2" style="display:none">
			<thead>
				<tr>
					<td><span class="leftspan">参数</span></td>
					<td>
						${infos[0].projectname }-${instances[0].classinstancename }
						<input type="hidden" value="${instances[0].classinstanceid};${instances[0].classinstancename }" />
					</td>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${classid eq 2}">
						<tr class="even">
								<td><span class="leftspan">项目类型</span></td>
								<td>${infos[0].industryclassname }</td>
						</tr>
						<tr class="odd">
								<td><span class="leftspan">供冷期</span></td>
								<td>${infos[0].coldingstart }--${infos[0].coldingend }</td>
						</tr>
						<tr class="even">
								<td><span class="leftspan">供热期</span></td>
								<td>${infos[0].heatingstart }--${infos[0].heatingend }</td>
						</tr>
						<tr class="odd">
								<td><span class="leftspan">所属行业</span></td>
								<td>${infos[0].industrytypename }</td>
						</tr>
						<tr class="even">
								<td><span class="leftspan">投资单位</span></td>
								<td>${infos[0].investcompany }</td>
						</tr>
						<tr class="odd">
								<td><span class="leftspan">商业模式</span></td>
								<td>${infos[0].businesstypename }</td>
						</tr>
						<tr class="even">
								<td><span class="leftspan">设计单位</span></td>
								<td>${infos[0].designcompany }</td>
						</tr>
						<tr class="odd">
								<td><span class="leftspan">运营商</span></td>
								<td>${infos[0].carrieroperator }</td>
						</tr>
						<tr class="even">
								<td><span class="leftspan">项目地址</span></td>
								<td>${infos[0].address }</td>
						</tr>
						<tr class="odd">
								<td><span class="leftspan">供能/建设</span></td>
								<td>${infos[0].supplyarea }m2/${infos[0].buildingarea }m2</td>
						</tr>
						<tr class="even">
								<td><span class="leftspan">建筑单位</span></td>
								<td>${infos[0].buildcompany }</td>
						</tr>
						<c:forEach items="${design}" var="d" varStatus="s">
							<tr class="${s.index % 2 eq 0 ? 'odd':'even' }">
								<td><span class="leftspan">${d.conitemname}</span></td>
								<td>${d.loadvalue }${d.unitname }</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach items="${staticLists[0]}" var="e" varStatus="s">
							<tr class="${s.index % 2 eq 0 ? 'even':'odd' }">
								<td><span class="leftspan">${e.propertyname }</span></td>
								<td>${e.datavalue }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				
			</tbody>
		</table>
</div>
 <div class="mod-pop sbsx_pop" id="pop-oncanshu" >
        <div class="hd"><h2></h2></div>
        <div class="bd" id="highstock"></div>
</div>