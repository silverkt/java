<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<script type="text/javascript">
<!--
	$(function(){
		closeFancybox();
		
		var submitFlag = true;
		
		//年度指标
		$("#setLimitvalue").blur(function(){
			$("#limitvalueMsg_TR").hide();
			$("#limitvalueMsg").text("");
		});
		//保存年
		$("#pop-onupdate #saveBut").click(function(){
			var yearIndex = $("#setLimitvalue","#popform").val();
			if(yearIndex == ""){
				$("#limitvalueMsg_TR").show();
				$("#limitvalueMsg").text("年度指标必填");
				return false;
			}
			$.ajax({type:"POST",url:"<c:url value='/quota/save/year' />",data:$("#popform","#pop-onupdate").serialize(),
				success:function(data){
					if(data.success){
						$("#ylimit").text(data.limit);
						$("#yperwarn").html(data.prewarn);
						$("#ywarn").html(data.warn);
						$("#pop-onupdate #idnum").val(data.id);
						averageByMonth(data.limit);
						$.fancybox.close();
					}else{
						jAlert(data.msg);
					}
				}
			});
		});
		function averageByMonth(limit){
			var $checked = $('.month_tbl tr td input:checkbox:checked').not($(".dis")),
				$input = $(".datalist tbody tr input[name='limitvalue']"),
				monthdata = parseInt(limit/$checked.length);
			$.each($checked,function(){
				var val = $($(this)[0]).val();
				$input.each(function(){
					var $this = $($(this)[0]);
					if(val == $this.attr("mid")){
						$this.val(monthdata);
						return false;
					}
				});
			});
		}
		
		//保存月
		$("#Button1",".datalist-div").click(function(){
			//验证 差值 >=0,才可保存
			console.log($("#chazhiValue",".datalist-div").text());
			var chazhi = parseInt($("#chazhiValue",".datalist-div").text());
			if(chazhi < 0){
				jAlert("月指标合计大于年度指标")
				return;
			}
			if(!submitFlag){
				jAlert("确保所填数据的合理性");
				return;
			}
			var trs = $(".datalist-div .datalist tbody tr"),dataArray = [],pid = ${pid},type = "${type}",year = "${y}";
			trs.each(function(){
				var data = {},$input = $(this).find("input");
				if($input == null || $input.size() <= 0) return true;
				$input.each(function(){
					data[$(this).attr("name")] = $(this).val();
				});
				dataArray.push(data);
			});
			if(dataArray.length == 0) return;
			var url = "<c:url value='/quota/save/month/' />";
			$.ajax({type:"POST",url:url + pid + "/" + type,
					data:JSON.stringify(dataArray),
					dataType:"json",contentType:"application/json",
	  				success:function(data){
						if(data.success){
							$.ajax({type:"GET",url:"<c:url value='/quota/value/1' />",
								data:{pid:pid,year:year,type:type},
				    			success:function(data){
								$("#tablediv").empty().html(data);
				    		}});
						}
	  				}
			});
		});
		
		$(".month_tbl tr td input").change(function () {
                var checkedNum = $('.month_tbl tr td input:checkbox:checked').not($(".dis")).length,
                	disNum = 12 - $('.dis').length;
                if(checkedNum < disNum) $("#checkAll").removeAttr("checked");
                else if(checkedNum == disNum) $("#checkAll").attr("checked", "checked");
        });
		
		$("#checkAll").change(function(){
			if ($(this).attr("checked")) {
	        	$(".month_tbl tr td input").not($(".dis")).attr("checked", "checked");
	        } else {
	            $(".month_tbl tr td input").not($(".dis")).removeAttr("checked");
	        }
		});
		
		//修改月指标的值时，月指标合计、差值  实时更新
		$(".monIndex","#tablediv").keyup (function(){
			var updateValue = 0, lineValue = 0, readonlyValue = 0, yearValue = 0;
			$(".monIndex","#tablediv").each(function(){
				lineValue = parseInt($(this).val());
				updateValue = updateValue + lineValue;
			});
			readonlyValue = parseInt($("#totalReadonlyTag").val());
			$("#monIndexSum").text(parseInt(updateValue) + readonlyValue);
			yearValue = parseInt($("#ylimit").text());
			$("#chazhiValue").text(yearValue - (updateValue + readonlyValue));
		});
		
		//月预警数字范围限制（月预警<月指标）
		$(".monYuj","#tablediv").blur(function(){
			var monYuj = parseInt($(this).val());
			var $tr = $(this).parent("td").parent("tr");
			var monIndex = parseInt($tr.find("input[name='limitvalue']").val());
			if(monYuj > monIndex){
				jAlert("月预警必须小于月指标");
				//$(this).focus();
				submitFlag = false;
				return;
			}
			submitFlag = true;
		});
		//月报警数字范围限制（月预警<月报警<月指标）
		$(".monBaoj","#tablediv").blur(function(){
			var monBaoj = parseInt($(this).val());
			var $tr = $(this).parent("td").parent("tr");
			var monIndex = parseInt($tr.find("input[name='limitvalue']").val());
			var monYuj = parseInt($tr.find("input[name='prewarnvalue']").val());
			if(monBaoj > monIndex){
				jAlert("月报警必须小于月指标");
				//$(this).focus();
				submitFlag = false;
				return;
			}
			if(monBaoj < monYuj){
				jAlert("月报警必须大于月预警");
				//$(this).focus();
				submitFlag = false;
				return;
			}
			submitFlag = true;
		});
		
		
			//限制本页面的所有文本框，只能输入数字和小数点
			$(".txttblval").keydown(function(event){
				if((event.which >= 48 && event.which <= 57) || event.which == 190 || event.which == 8){
					return true;
				}else{
					return false;
				}
			});
	})
//-->
</script>
<style>
<!--
form label.error{background: url(<c:url value='/resources/img/erroicon.png)'/> no-repeat; display: block; padding-left: 20px; height: 26px; line-height: 28px; background-position: left center; font-size: 12px; color: #000;}
.errordiv div{background: #FEF2F2;width: 210px; height: 26px; border: 1px solid #FE7C7C;}
-->
</style>
<div class="datalist-div" style="border-left: none;">
	<div class="tblcomhead">
		<table width="100%">
			<tr>
				<td style="text-align: left;">
					<span class="tbltit tbltb">${y }年</span>
					<span class="tblval tblvalb">耗${typename }量指标</span>
				</td>
				<td style="text-align: right;">
					<span class="tbltit">年度指标：</span><span class="tblval" id="ylimit">${year.limitvalue }</span>
					<span class="tbltit">年预警值：</span><span class="tblval" id="yperwarn">${year.prewarnvalue }</span>
					<span class="tbltit">年报警值：</span><span class="tblval" id="ywarn">${year.warnvalue }</span>
					<a class="tblp fancybox" href="#pop-onupdate">
						<img src="<c:url value='/resources/img/iconsave.png' />"/>
					</a>
				</td>
			</tr>
		</table>
	</div>
	<div id="tablediv">
		<jsp:include page="table.jsp"></jsp:include>
	</div>
	<div style="background: #fff; height: 45px; width: 100%;">
		<input id="Button1" class="btnsave" type="button" value="保存" />
	</div>
</div>

<%--弹出层--%>
<div class="mod-pop" id="pop-onupdate" style="width:480px; height:380px;">
        <div class="hd"> 
            <h2>${y }年 ${typename } 年度指标</h2>
        </div>
        <div class="bd">
        <form id="popform" autocomplete="off">
        	<input type="hidden" name="idnum" value="${year.idnum}" id="idnum">
        	<input type="hidden" name="projectid" value="${pid}">
        	<input type="hidden" name="period" value="${y}">
        	<input type="hidden" name="timetype" value="Y">
        	<input type="hidden" name="energytype" value="${type}">
            <table class="tblnygl">
                <tr>
                    <td class="tright w80">年度指标：</td>
                    <td class="errordiv"><input type="text" class="w200 ttxt txttblval" id="setLimitvalue" name="limitvalue" value="${year.limitvalue }" /></td>
                </tr>
                <tr id="limitvalueMsg_TR" style="display:none">
					<td></td>
					<td><div style="width: 210px; height: 26px; border: 1px solid #FE7C7C; background: #FEF2F2;">
							<label id="limitvalueMsg" style="background: url(<c:url value='/resources/img/erroicon.png)'/> no-repeat; display: block; text-align:left;  padding-left: 20px; height: 26px; line-height: 28px; background-position: left center; font-size: 12px; color: #000;" class="error" ></label>
						</div>
					</td>
				</tr>
                 <tr>
                    <td class="tright w80">年度预警：</td>
                    <td> <input type="text" class="w200 ttxt txttblval" name="prewarnvalue" value="${year.prewarnvalue }" /></td>
                </tr>
                 <tr>
                    <td class="tright w80">年度报警：</td>
                    <td> <input type="text"  class="w200 ttxt txttblval" name="warnvalue" value="${year.warnvalue }" /></td>
                </tr>
                 <tr>
                    <td class="tright w80">平均分配月：</td>
                    <td>
                        <input type="checkbox" id="checkAll" /> <span class="nyglnotice">注：以上指标，按所勾选的月份进行平均分配</span>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <table class="month_tbl">
                        <c:forEach begin="1" end="12" var="x">
                        	${x - 1 % 6 eq 0 ? '<tr>':'' }
								<td>${x }月<input type="checkbox" value="${x}" ${x < cm ? 'disabled="disabled" class="dis"':''} /></td>
							${x % 6 eq 0 ? '</tr>':'' }
                        </c:forEach>
                        </table>
                             
                    </td>
                </tr>
            </table>
		</form>
            <div class="clear">
                <a title="Close" class="tck-cancel fr mt15 ml20 closeFancybox" href="javascript:;">取消</a>
                <a class="tck-save fr mt15" id="saveBut">保存</a>
            </div>
            </div>
</div>