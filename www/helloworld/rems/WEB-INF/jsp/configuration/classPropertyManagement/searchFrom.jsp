<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <script type="text/javascript">
        $(document).ready(function () {
            //所属组别
			$('#selectCs').simSelect({
				callback: function (x,v) {
					if(v){
				    	listLeft(v);
					}
				}
			});
            //所属类型
			$('#selectSb').simSelect({
				callback: function (x,v) {
					if(v){
				    	$("#searchPropertytypeid").val(v);
					}
				}
			});
            //所属分类
			$('#xmgl_shi').simSelect({
				callback: function (x,v) {
					if(v){
				    	$("#searchIsdynamic").val(v);
					}
				}
			});
        });
    </script>
	<form id="searchForm" action="" method="post">
		<input type="hidden" id="searchPageClassid" name="searchPageClassid"
			value="${pageClassid}" />
		<table class="putform">
			<tr>
				<td class="w60">
					<span class="">属性类型：</span>
				</td>
				<td class="tleft lbgl">
					<div class="mod-select  mt5" id="selectSb" style="">
						<input type="hidden" id="searchPropertytypeid"
							name="searchPropertytypeid" value="" />
						<p class="text">
							请选择属性类型
						</p>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<div class="list" style="height: 95px; overflow-y: auto;">
							<ul>
								<li val=''><a href=''>请选择属性类型</a></li>
								<c:forEach var="s" items="${typeList}" varStatus="v">
									<li val="${s.propertytypeid}">
										<a href="">${s.typename}</a>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<span class="lbglspan" style="">属性分类：</span>
					<div class="mod-select  mt5" id="xmgl_shi">
						<input type="hidden" id="searchIsdynamic" name="searchIsdynamic"
							value="" />
						<p class="text">
							请选择属性分类
						</p>
						<span class="arr-group hand"> <i class="icon-mod icon-arr"></i>
						</span>
						<div class="list" style="">
							<ul>
								<li val=''>
									<a href=''>请选择属性分类</a>
								</li>
								<li val="0">
									<a href="">静态属性</a>
								</li>
								<li val="1">
									<a href="">动态属性</a>
								</li>
							</ul>
						</div>
					</div>
					<span class="lbglspan">属性名称：</span>
					<input type="text" class="lbglname" id="searchPropertyname"
						name="searchPropertyname" />
					<input type="hidden" id="lastSearchData" value="" />
					<a id="searchBtn" class="viewbtn2 fl ml10" style="margin-top: 5px;">查看数据</a>
					<a id="addBtn" class="fr xmgl_srear"
						style="background: url('<c:url value="/resources/img/xmgl_nadd.png" />');"
						href="#pop-onupdate"></a>
				</td>
			</tr>
		</table>
