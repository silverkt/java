<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<style>
        .putform_xtzb td {
            background: url("<c:url value='/resources/img/remote_zb.png' />") no-repeat;
            background-position: center top;
            width: 150px;
            height: 90px;
            vertical-align: top;
        }

            .putform_xtzb td .xtzb_val {
                height: 20px;
                margin-top: 20px;
                width: 100%;
                text-align: center;
                float: left;
                color: #5b636c;
            }

            .putform_xtzb td .xtzb_name {
                height: 20px;
                float: left;
                width: 100%;
                text-align: center;
                color: #5b636c;
            }
        .tjt_tbl tr td {
            width:112px;
            height:112px;
            vertical-align:top;
        }
            .tjt_tbl tr td a {
                display:block;
                width:112px;
                text-align:center;
                font-size:13px;
                color:#fff;
                float:left;
                height:20px;
            }
            .tjt_tbl tr td .top {
                margin-top: 45px;
            }
             .tjt_tbl tr td .top2 {
                margin-top: 10px;
            }
    </style>
<div class="mleft bwhite bshadow fl" id="mleft" style="width: 638px;">
	<div class="p15">
		<table class="putform xmgl-tjt">
			<tr>
				<td colspan="3" class="tcenter" style="color: #5b636c; font-size: 17px; font-family: 微软雅黑; padding-bottom: 20px;">
					${project.projectname }
				</td>
			</tr>
			<tbody>
				<tr>
					<td>
						<c:forEach items="${ios['i']}" var="i">
							<p class="tjt-item i" mid="${i.modelid }">
								<span class="ico ${i.icon }"></span>
								<span class="btn-view">
									<a>${i.showname }&nbsp;<i id="cost">${i.costValue }</i>${i.costunit }</a>
									<a>${i.showname2 }&nbsp;<i id="energy">${i.energypvalue }</i>${i.energyunit }</a></span>
							</p>
						</c:forEach>
					</td>
					<td class="tcenter">
						<div class="tjt">
							<table class="tjt_tbl">
								<tr>
									<td>
										<a class="top"><i class="annular" cid="${annulars[0].classinstanceid }" pid="${annulars[0].classpropertyid }"></i>${annulars[0].unitname }</a>
										<a style="text-align: left;text-indent: 18px;">${annulars[0].showname }</a>
									</td>
									<td>
										<a class="top"><i class="annular" cid="${annulars[1].classinstanceid }" pid="${annulars[1].classpropertyid }"></i>${annulars[1].unitname }</a>
										<a>${annulars[1].showname }</a>
									</td>
								</tr>
								<tr>
									<td>
										<a class="top2"><i class="annular" cid="${annulars[2].classinstanceid }" pid="${annulars[2].classpropertyid }"></i>${annulars[2].unitname }</a>
										<a>${annulars[2].showname }</a>
									</td>
									<td>
										<a class="top2"><i class="annular" cid="${annulars[3].classinstanceid }" pid="${annulars[3].classpropertyid }"></i>${annulars[3].unitname }</a>
										<a>${annulars[3].showname }</a>
									</td>
								</tr>
							</table>
						</div>

					</td>
					<td>
						<c:forEach items="${ios['o']}" var="i">
							<p class="tjt-item o" mid="${i.modelid }">
								<span class="ico ${i.icon }"></span>
								<span class="btn-view">
									<a>${i.showname }</a><a><i id="energy">${i.energypvalue }${i.energyunit }</i></a></span>
							</p>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="xmdetail">
			<div class="xm-tit">
				<table class="putform ptit">
					<thead>
						<tr>
							<td class="tleft"><span class="xmdetail-tit">项目简介</span></td>
							<td class="tright w140">
								<div class="ment-table-type fr nyjg ml20">
									<a class="htit">能源价格</a>
									<div class="list" style="width: 598px;">
										<span class="point"></span>
										<ul>
											<li>
												<table>
													<c:forEach items="${prices}" var="d" varStatus="s">
														${s.index % 3 eq 0 ? '<tr>':'' }
															<td>${d.classpropertyname }：${d.datavalue }${d.unitname }</td>
														${s.index + 1 % 3 eq 0 || s.last ? '</tr>':'' }
													</c:forEach>
												</table>
											</li>
										</ul>
									</div>
								</div>
								<div class="ment-table-type fr sjfh">
									<a class="htit">设计负荷</a>
									<div class="list" style="width: 598px;">
										<span class="point"></span>
										<ul>
											<li>
												<table>
													<c:forEach items="${design}" var="d" varStatus="s">
														${s.index % 3 eq 0 ? '<tr>':'' }
															<td>${d.conitemname }：${d.loadvalue }${d.unitname }</td>
														${s.index + 1 % 3 eq 0 || s.last ? '</tr>':'' }
													</c:forEach>
												</table>
											</li>
										</ul>
									</div>
								</div>
							</td>
						</tr>
					</thead>
				</table>
			</div>
			<div class="xm-txt">
				<table class="putform">
					<tr>
						<td class="tleft">项目名称：${project.projectname }</td>
						<td class="tleft">所属行业：${project.industrytypename }</td>
					</tr>
					<tr>
						<td class="tleft">项目类型：${project.industryclassname }</td>
						<td class="tleft">商业模式：${project.businesstypename }</td>
					</tr>
					<tr>
						<td class="tleft">运营商：${project.carrieroperator }</td>
						<td class="tleft">供能/建设：${project.supplyarea }m2/${project.buildingarea }m2</td>
					</tr>
					<tr>
						<td class="tleft">供冷期：${project.coldingstart }--${project.coldingend }</td>
						<td class="tleft">供热期：${project.heatingstart }--${project.heatingend }</td>
					</tr>
					<tr>
						<td class="tleft">投资单位：${project.investcompany }</td>
						<td class="tleft">设计单位：${project.designcompany }</td>
					</tr>
					<tr>
						<td class="tleft">项目地址：${project.address }</td>
						<td class="tleft">建筑单位：${project.buildcompany }</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<div class="mright fl" id="mright" style="width: 650px;">
	<div class="xmgl-item">
		<div class="xmgl-h"><span class="fl" mid="4">当日能耗</span><a class="btn fr fancybox" href="#pop-xmgl"></a></div>
		<div class="xmgl-c" id="hichart1"></div>
	</div>

	<div class="xmgl-item">
		<div class="xmgl-h"><span class="fl" mid="5">当日供能</span><a class="btn fr fancybox" href="#pop-xmgl"></a></div>
		<div class="xmgl-c" id="hichart2"></div>
	</div>
	
	<div class="xmgl-item xtzb">
		<div class="xmgl-h">
			<span class="fl">系统指标</span><%--<a class="btn fr"></a>
		--%></div>
		<div class="xmgl-c">
			<table class="putform putform_xtzb">
				<c:forEach items="${quotas}" var="d" varStatus="s">
					${s.index % 2 eq 0 ? '<tr>':'' }
						<td>
							 <p class="xtzb_val">
							 	<span class="quota" cid="${d.classinstanceid }" pid="${d.classpropertyid }"></span>${d.unitname }</span>
							 </p>
                                <p class="xtzb_name">${d.showname }</p>
							
						</td>
					${s.index + 1 % 2 eq 0 || s.last ? '</tr>':'' }
				</c:forEach>
			</table>
		</div>
	</div>

	<div class="xmgl-item">
		<div class="xmgl-h"><span class="fl" mid="7">实时气象</span><a class="btn fr fancybox" href="#pop-xmgl"></a></div>
		<div class="xmgl-c" id="hichart3"></div>
	</div>
	<div class="xmgl-item">
		<div class="xmgl-h"><span class="fl" mid="40">月级能耗同比</span><a class="btn fr fancybox" href="#pop-xmgl"></a></div>
		<div class="xmgl-c" id="hichart4"></div>
	</div>
	<div class="xmgl-item">
		<div class="xmgl-h"><span class="fl" mid="50">月级供能同比</span><a class="btn fr fancybox" href="#pop-xmgl"></a></div>
		<div class="xmgl-c" id="hichart5"></div>
	</div>
</div>