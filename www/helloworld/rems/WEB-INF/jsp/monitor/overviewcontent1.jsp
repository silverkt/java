<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<style>
.pic{background-image: url('<c:url value="/${imgs[0].bgpath}" />');}
.fs162 {
    font-size: 16px;
    margin-right:20px;
}
</style>
	<!--xmgl0915 start-->
    <div class="tests yc" id="tblinfo">
    <div class="xmglWrapper clearfix">
       <div class="xmglLeft ml10 left">
           <div id="xmglaUp" class="xmglArrow xmglaUp"></div>
           <div class="xmglListWrapper">
               <ul>
               		<c:forEach items="${ios['i']}" var="i">
               			<li class="ios_i" mid="${i.modelid }">
	                        <span class="xmglIcon ${i.energyicon}"></span>
	                        <p class="fs14 fcGray mt20" id="cost" title="当日累计${i.showname2}:${i.costValue }${i.costunit }">当日累计${i.showname}</p>
	                        <p class="fs14 fcRed"><i id="energy">${i.energypvalue}</i>&nbsp;${i.energyunit}</p>
	                        <p class="fs14 fcGray mt20" title="当月累计${i.showname2}:${i.costValue2 }${i.costunit }">当月累计${i.showname}</p>
	                        <p class="fs14 fcRed">${i.energypvalue2}&nbsp;${i.energyunit}</p>
	                   </li>
               		</c:forEach>
               </ul>
           </div>
           <div id="xmglaDown" class="xmglArrow xmglaDown"></div>
       </div>
       <div class="xmglmiddle left">
            <div class="xmglmBlock">
            	<div class="xmglmbLeft left mt87">
                    <span class="xmglIcon xmglmbArrowUP"></span>
                    <span class="xmglIcon xmglmbArrowDown mt293"></span>
                </div>
                <div class="xmglmbMiddle left">
                	<p class="xmglTitle">${project.projectname }项目运行概览</p>
			         <div class="temWords">
				        	<p class="taCenter ml13 mt15">
				        		<c:forEach items="${qx}" var="q" varStatus="s">
				        			<span class="fs18 fcBlack ${s.index eq 0 ? '':'ml20'}">${q.classpropertyname}：<i class="annular" cid="${q.classinstanceid}" pid="${q.classpropertyid }">${q.datavalue}</i>${q.unitname}</span>
				        		</c:forEach>
				        	</p>
				        	<p class="taCenter ml13 mt15">
				        		<c:forEach items="${annulars}" var="a" varStatus="s">
				        			<c:if test="${s.index le 2}">
				        				<span class="fs16 ${s.index eq 0 ? '':'ml15'} ">${a.showname }：<i class="annular" cid="${a.classinstanceid }" pid="${a.classpropertyid }"></i>&nbsp;${a.unitname }</span>
									</c:if>                    	
				        		</c:forEach>
				        </p>
			        </div>
                    <div class="xmglFactoryPicBlock mt40">
                    	<c:forEach items="${imgs}" var="i" varStatus="s">
                    		<img class="${s.index eq 0 ? '':'hide'}" data-se="${s.index+1}" src="<c:url value='${i.path}'/>" alt="">
                    	</c:forEach>
                    </div>
                     <div class="thumbnailBox clearfix ml13 ">
                     <c:if test="${!empty imgs[0]}">
                        <div data-thse="1" class="tbBlock tbbSel">
                            <span class="tbFonts">①</span>
                            <img src="<c:url value='${imgs[0].path}'/>" alt="">
                        </div>
                      </c:if>
                      <c:if test="${!empty imgs[1]}">
                        <div data-thse="2" class="tbBlock">
                            <span class="tbFonts">②</span>
                            <img src="<c:url value='${imgs[1].path}'/>" alt="">
                        </div>
                       </c:if>
                       <c:if test="${!empty imgs[2]}">
                        <div data-thse="3" class="tbBlock">
                            <span class="tbFonts">③</span>
                            <img src="<c:url value='${imgs[2].path}'/>" alt="">
                        </div>
                        </c:if>
                        <c:if test="${!empty imgs[3]}">
                        <div data-thse="4" class="tbBlock">
                            <span class="tbFonts">④</span>
                            <img src="<c:url value='${imgs[3].path}'/>" alt="">
                        </div>
                        </c:if>
                    </div>
                </div>
                <div class="xmglmbRight left taCenter">
                    <div class="xmglmbTable">
                        <div class="xmglmbCell">
                        	<c:forEach items="${ios['o']}" var="o">
                        		 <div class="xmglmbrBlock mb30 ios_o" mid="${i.modelid }">
	                                <p class="fs12 lh13 fcGray">当日累计${o.showname}</p>
	                                <p class="fs12 lh13 fcGray mb7"><i id="energy" >${o.energypvalue}</i>&nbsp;${o.energyunit}</p>
	                                <p class="fs12 lh13 fcGray ">当月累计${o.showname}</p>
	                                <p class="fs12 lh13 fcGray">${o.energypvalue2}&nbsp;${o.energyunit}</p>
	                                <span class="xmglIcon ${o.energyicon}"></span>
	                            </div>
                        	</c:forEach>
                        </div>
                    </div>
                </div>
       		</div>
       </div>
       <div class="xmglRight left pic"　style=""><%--
            <div class="xmglIconx xmglPageRightArrow" id="tbllista"></div>
            --%><div class="xmglrInner">
                <p class="xmglrTitle">${project.projectname }</p>
                <div class="xmglriTwoCol">
                    <p>
                        <span title="项目名称：${project.projectname }">项目名称：${project.projectname }</span>
                        <span title="供冷期：${project.coldingstart }--${project.coldingend }">供冷期：${project.coldingstart }--${project.coldingend }</span>
                    </p>
                    <p>
                        <span title="项目类型：${project.industryclassname }">项目类型：${project.industryclassname }</span>
                        <span title="供热期：${project.heatingstart }--${project.heatingend }">供热期：${project.heatingstart }--${project.heatingend }</span>
                    </p>
                    <p>
                        <span title="所属行业：${project.industrytypename }">所属行业：${project.industrytypename }</span>
                        <span title="投资单位：${project.investcompany }">投资单位：${project.investcompany }</span>
                    </p>
                    <p>
                        <span title="商业模式：${project.businesstypename }">商业模式：${project.businesstypename }</span>
                        <span title="设计单位：${project.designcompany }">设计单位：${project.designcompany }</span>
                    </p>
                    <p>
                        <span title="运营商：${project.carrieroperator}">运营商：${project.carrieroperator1 }</span>
                        <span title="建筑单位：${project.buildcompany }">建筑单位：${project.buildcompany1 }</span>
                    </p>
                    <p>
                        供能/建设：${project.supplyarea }m²/${project.buildingarea }m²
                    </p>
                    <p>
                        项目地址：${project.address1 }
                    </p>
                </div>
                <div class="xmglriThreeCol mt20 mb10">
                	<c:forEach items="${design}" var="d" varStatus="s">
                		${s.index % 2 eq 0 ? '<p>':'' }
							<span title="${d.conitemname }：${d.loadvalue }${d.unitname }">${d.conitemname }：${d.loadvalue }${d.unitname }</span>
						${s.index + 1 % 2 eq 0 || s.last ? '</p>':'' }
                    </c:forEach>
                </div>
            </div>
       </div>
    </div>
    </div>
    <!--for ie8 support css3-->
    <!--[if lt IE 9]>
    <script src="<c:url value='/resources/js/PIE.js' />"></script>
    <![endif]-->
    <script>
(function(){
    // for html font size
        recalc();
    // for scroll bar
        remsScroll();
	
		
	var stepnum=0;	

	
    $(window).resize(function(){
        remsScroll();
        recalc();
    var wrap = $('.xmglListWrapper');
	step = -wrap.children('ul').children('li').outerHeight();
    wrap.height(-step*2)// 动态外框高度
	var newtop=stepnum*parseFloat(step);
	wrap.find('ul').css('top',newtop);
	
    });
    // for nav
    $(document).on('click', '.remsNav > li > a', remsNav) 
    // for select pic
    var tbBlock = $('.tbBlock')
    $(document).on('click', '.tbBlock', function() {
        var $this = $(this)    
          , num = $this.data('thse')
          , pic = $('.xmglFactoryPicBlock').children('img')
          $this.siblings('.tbBlock').removeClass('tbbSel').end().addClass('tbbSel')
          pic.each(function(){
             var $this = $(this)
             $this.data('se') == num
             && $this.siblings('img').hide().end().show() 
          });
    });
    // for PIE
    if(window.PIE) {
        $('.xmglLeft').each(function(){
            PIE.attach(this);    
        }); 
        $('.xmglRight').each(function(){
            PIE.attach(this);    
        }); 
    }

    // custom scroll
    $('.xmglmbRight').slimScroll({
        size: '5px',
        height: '862px',
        alwaysVisible: true,
        width: '22%'
    });
    // for xmgl arrow
    
    var animated = false
      //, step = -388 
    var wrap = $('.xmglListWrapper');
    var step = -wrap.children('ul').children('li').outerHeight();

    wrap.height(-step*2)// 动态外框高度
/*
    $(document).on('click', '#xmglaUp', {offset: -388}, xmglArrow); 
    $(document).on('click', '#xmglaDown', {offset: 388}, xmglArrow); 
    */
    $(document).on('click', '#xmglaUp', {offset: step}, xmglArrow); 
    $(document).on('click', '#xmglaDown', {offset: -step}, xmglArrow); 

    $(document).on('click', '#xmglaUp', {dir: 'up'}, hoverEnd); 
    $(document).on('click', '#xmglaDown', {dir: 'down'}, hoverEnd); 
    $(document).on('mouseover', '#xmglaUp', {dir: 'up'}, hoverIn); 
    $(document).on('mouseover', '#xmglaDown', {dir: 'down'}, hoverIn); 
    $(document).on('mouseleave', '#xmglaUp', {dir: 'up'}, hoverOut); 
    $(document).on('mouseleave', '#xmglaDown', {dir: 'down'}, hoverOut); 

function hoverOut(event) {
    var dir = event.data.dir;
    var $this = $(this);
    if(dir == 'up') {
        $this.removeClass('xmglaUpH');
    } else {
        $this.removeClass('xmglaDownH');
    }
}
function hoverIn(event) {
    var dir = event.data.dir;
    var $this = $(this);
    var ul = $this.siblings('div.xmglListWrapper').find('ul');
    var num = ul.find('li').length;
    if(dir == 'up') {
        if(!(parseInt(ul.css('top')) ==(num - 2) * step )){
            $this.addClass('xmglaUpH');
        }
    } else {
        if(!(parseInt(ul.css('top')) == 0)){
            $this.addClass('xmglaDownH');
        }
    }
}
function hoverEnd(event) {
    var $this = $(this);
    var ul = $this.siblings('div.xmglListWrapper').find('ul');
    var num = ul.find('li').length;
    var dir = event.data.dir;
    if(parseInt(ul.css('top')) == (num - 2) * step && dir == 'up') {
        $this.removeClass('xmglaUpH');
    } else if(parseInt(ul.css('top')) == 0 && dir == 'down') {
        $this.removeClass('xmglaDownH');
    } 
}
function xmglArrow(event) {
   var $this = $(this),
       ul = $this.siblings('div.xmglListWrapper').find('ul'),
       num = ul.find('li').length;
   var left = parseInt(ul.css('top')) + event.data.offset;
       if (event.data.offset > 0) {
            offset = '+=' +Math.abs(step); 
           if(parseInt(ul.css('top')) == 0) {
                offset = 0;
           }
       } else {
           offset = '-=' +Math.abs(step);
           if(parseFloat(ul.css('top')) == parseFloat((num - 2) * step )) {
                offset = (num - 2) * step;
           }
       }
       if(!ul.is(':animated')) {
           ul.animate({top: offset},
                   {start: function() {
                        animated = true;
                   },
                    progress: function() {
                        animated = false;
                    },
                   complete: function() {
                        animated = false;
						
						stepnum=parseFloat(ul.css('top'))/parseFloat(step);
                    }}       
            );
       }
}

})();
// 选择导航
function remsNav(e) {
    e.preventDefault()
    var $this = $(this)   
      , num = $this.data('nav')
      , subNav = $('.remsSubNav').children('div')
    $this.addClass('active').parents('li').siblings('li').children('a').removeClass('active')
    // 判断总导航选择子导航
    switch(num) {
        case -1:
            subNav.addClass('hide')
            break
        case 0:
           subSel(subNav.eq(0),'hide')
           break
        case 1:
           subSel(subNav.eq(1),'hide')
           break
        case 2:
           subSel(subNav.eq(2),'hide')
           break
        case 3:
           subSel(subNav.eq(3),'hide')
           break
        case 4:
           subSel(subNav.eq(4),'hide')
           break
    }
}
// 子导航选择函数
function subSel(sel,className) {
   sel.removeClass(className).siblings('div').addClass(className) 
}
// 滚动条函数 
function remsScroll() {
    var height = $(window).height()
      //, headerH = $('.remsHeader').height()
      , headerH = $('.head').outerHeight()
      , nav = $('.nav-nav').outerHeight()
      , tests = $('.tests');
    //tests.height(height-headerH-nav);
    tests.height(height-130);
}
// 计算字体大小
function recalc() {
    var winWid = $(window).width()
      , fs = 12 * (winWid / 1366) + 'px' 
    if(winWid <= 1200) $('html').css('fontSize',10+'px')
    else $('html').css('fontSize',fs)    
    
} 
    </script>
    <!--xmgl0915 end-->
