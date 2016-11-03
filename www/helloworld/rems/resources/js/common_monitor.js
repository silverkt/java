
// tab plugin
function Tab(){
	var tabs=$('.tab');
	if(!tabs.length) return;
	tabs.find('.tab-nav a').click(function(e){
		//e.preventDefault();
	});
	tabs.each(function(){
		var navs=$(this).find('.tab-nav li:not(.no)'),
			panels = $(this).find('.tab-panel');
		
		if($(this).hasClass('tab-hover')){
			navs.mouseenter(function(){
				var index=$(this).index();
				navs.removeClass('on active').eq(index).addClass('on');
				panels.hide().eq(index).show();
			});
			return;
		};
		navs.hover(function(e){
			if(e.type=='mouseenter'){
				$(this).addClass('active');
			}else{
				$(this).removeClass('active');
			};
		}).click(function(){
			var index=$(this).index();
			navs.removeClass('on active').eq(index).addClass('on');
			panels.hide().eq(index).show();
			var inputs = tabs.find('.tab-panel').find(".nyfx-item");
			if($(this).find("input[type=radio]").size()>0){
				//inputs.find("input").removeAttr("checked");
			}else{
				if(!inputs.hasClass("noClear")) {
					inputs.find("input").removeAttr("checked");
				}
			}
		})
	})
}


//全选全消
function selectToggle() {
    var selects = $('.select-item');
    if (!selects.length) return;
    selects.each(function () {
        var selectAll = $(this).children(".item-tit").find('.selectAll'),
            selectReverse = $(this).find('.selectReverse'),
            inputs = $(this).children(".item-txt").find('input'),
        inputToggle = $(this).children(".item-tit").find('.selectToggle')
        selectAll.click(function (e) {
            inputs.add(selectAll).attr('checked', true);
            _callback();
        });
        selectReverse.click(function () {
            inputs.each(function () {
                var input = $(this)[0];
                input.checked = !input.checked
            });
            _callback();
        });
        inputs.click(function () {
            _callback();
        })
        inputToggle.click(function () {
            var len = inputs.filter(':checked').length,
                size = inputs.length;
            if (size == len) {
                inputs.attr('checked', false);
            } else {
                inputs.attr('checked', true);
            };
            _callback();
        });
      

        function _callback() {
            var len = inputs.filter(':checked').length,
                size = inputs.length;
            if (len == size) {
                inputToggle.attr('checked', true);
            }
            else {
                inputToggle.attr('checked', false);
               
            }
        }
    })
}

//默认搜索
$.fn.defaultInput=function(opts){
	this.each(function(){
		var setting={
			wrapselect:null,
			hovername:null,
			clickname:null
		};
		var dets=$.extend(true,{},setting,$(this).data(),opts),
			detVal=$(this).val(),
			wrap=dets.wrapselect,
			hoveName=dets.hovername,
			clickName=dets.clickname;

		$(this).click(function(){
			var v=$(this).val();
			if(v==detVal){
				$(this).val('');
				$(this).removeClass('empty');
			};
		}).blur(function(){
			var v = $.trim($(this).val());
			if(!v){
				$(this).val(detVal).addClass('empty');
			};
		});
		if(wrap){
			wrap=$(this).closest(wrap);
			if(hoveName){
				wrap.hover(function(e){
					if(e.type=='mouseenter'){
						$(this).addClass(hoverName);
					}else{
						$(this).removeClass(hoverName);
					}
				})
			};
			if(clickName){
				wrap.click(function(){
					$(this).addClass(clickName);
					return false;
				});
				$(document).click(function(){
					wrap.removeClass(clickName);
				});
			}
		};
	});
	return this;
}

//模拟select
$.fn.simSelect=function(opts){
	this.each(function(){
		var setting={
			hoverName:null,
			clickName:null,
			callback:null,
			conSelect:null,
			isBack:true,
			changeFun:null,
			handReversalClass:false,
			init:function(){
				return true;
			}
		};
		var hand=$(this).find('.hand'),
			that=$(this),
			dets=$.extend(true,{},setting,opts),
			list=$(this).find(dets.conSelect||'.list'),			
			hoveName=dets.hoverName,
			clickName=dets.clickName,
			callback=dets.callback,
			text=$(this).find('.text'),
			lis=list.find('li'),
			isAnimate=dets.isAnimate,
			changeFun=dets.changeFun,
			isBack=dets.isBack,
			handReversalClass=dets.handReversalClass;

		$(this).unbind("click").click(function(){
			if(!dets.init.call(this)) return;
			if(isAnimate && list.is(':animated')) return;
			changeFun && changeFun.call(that);
			if(list.is(':hidden')){
				if(isAnimate){
					list.slideDown();
				}else{
					$(".mod-select .list").hide();
					list.show();
				};
				clickName && $(this).addClass(clickName);
				$(this).addClass('on');
			}else{
				_close();
			};
			return false;
		});
		lis.click(function(){
			if(!isBack) return;
			_close($(this).text(),$(this).attr('val'));
			$(this).addClass("cur no").siblings().removeClass("cur");
		})
		if(hoveName){
			$(this).hover(function(e){
				if(e.type=='mouseenter'){
					$(this).addClass(hoveName);
				}else{
					$(this).removeClass(hoveName);
				}
			});
		};
		list.click(function(){
			return false;
		});
		if(handReversalClass){
			_close();
		}
		function _close(x,v){
			if(isAnimate){
				list.slideUp();
			}else{
				list.hide();
			};
			that.removeClass(clickName);
			callback && callback.call(that,x,v);
			if(x){
				text.html(x);
			};
			that.removeClass('on');
			if(handReversalClass && !isSupp){
				hand.addClass('arr-group-top');
			}else{
				hand.removeClass('arr-group-top');
			};	
		}
		$(document).click(function(){
			if(list.is(':visible')){
				if(!isBack) return
				_close();
			}
		})
	});
	return this;
}

// 显示层
function ShowDiv(){
	var elem=$('.showdiv');
	if(!elem.length) return;
	var cur=false;
	elem.each(function(){
		var con=$(this).find('.showdiv-con'),
			toggle=$(this).data('toggle')||'on',
			type=$(this).data('type')||'click',
			that=$(this),
			dir=$(this).data('dir')||'bottom',
			conOffset=($(this).data('offset')||'{}').replace(/px|%/,''),
			target= $(this).data('target'),
			con= target ? $(target) : $(this).find('.showdiv-con'),
			conWidth=con.width(),
			fixed=$(this).data('fixed')||false,
			setLeft=$(this).data('left')||false,
			btn=target ? $(target).find('.showdiv-close,.btn a:not(.check)') : $(this).find('.showdiv-close,.btn a:not(.check)');
		if(setLeft){
			con.css('margin-left',-conWidth/2)
		};
		$(this)[type](function(){
			if($(this).hasClass(toggle)){
				that.removeClass(toggle);
				target && ($(target).hide());
			}else{
				that.addClass(toggle);
				if(target){
					var elemOffset=that.offset(),
						style={},
						dis=0;
					if(dir=='bottom'){
						dis=that.height();
					}else{
						dis=-$(target).outerHeight();
					}
					conOffset = (typeof conOffset === 'string') ? eval('(' + conOffset + ')') : conOffset;
					style.left = elemOffset.left;
					//style.left=elemOffset.left + that.outerWidth()/2 - con.outerWidth()/2 + (conOffset.left||0);
					style.top=elemOffset.top + dis + (conOffset.top||0);
					if(!fixed){
						con.css(style)
					}
					con.show();
				}
			};			
		}).click(function(e){
			cur=$(this)[0]
			!target && _closeOther();
			return false;
		});
		con.click(function(){
			return false;
		});
		if(btn.size()){
			btn.click(function(){
				that.removeClass(toggle);
				target && ($(target).hide());
				
			});
		};
	});
	function _closeOther(){
		elem.each(function(){
			var toggle=$(this).data('toggle')||'on',
				target=$(this).data('target');
			if($(this)[0]!==cur){
				target && ($(target).hide());
				$(this).removeClass(toggle);
			};		
		});
	};
	$(document).click(function(){
		elem.each(function(){
			var toggle=$(this).data('toggle')||'on',
				target=$(this).data('target'),
				isAuto=$(this).data('auto');
			if(isAuto==undefined){
				$(this).removeClass(toggle);
				target && ($(target).hide());
			};			
		})

	})

}

// 提示内容框，生成div
function createWell(){
	var elem=$('.wellTip');
	if(!elem.length) return;
	elem.each(function(){
		var type=$(this).data('type')||'hover',
			con=$(this).data('con'),
			clientWidth=$(this).data('width'),
			targetOffset=($(this).data('offset') || '{}').replace(/px/,''),
			targetOffset=eval("("+targetOffset+")"),
			tip=$('<div id="createWell" class="well">'+con+'</div>'),
			tipElem=$('#createWell'),
			elemOffset=$(this).offset(),
			setTimeout_elem;
		if(type=='hover'){
			$(this).hover(function(e){
				var that=$(this),
					len=$('#createWell').length;
				setTimeout_elem &&	clearTimeout(setTimeout_elem);				
				if(e.type=='mouseenter'){
					if(!len){
						tip.appendTo('body').css(_getPos()).show().width(clientWidth).data('target',$(this)[0]);
						tipAddEvent(tip);
					}else{
						var target=tip.data('target');
						if(target!==$(this)[0]){
							tip.remove();
							tip.appendTo('body').css(_getPos()).show().width(clientWidth).data('target',$(this)[0]);
							tipAddEvent(tip);
						}
					};					
				}else{
					setTimeout_elem=setTimeout(function(){
						_close();
					},100);
				};
				function tipAddEvent(elem){
					elem.mouseenter(function(){
						setTimeout_elem && clearTimeout(setTimeout_elem);
					}).mouseleave(function(){
						setTimeout_elem=setTimeout(function(){
							_close();
						},100);
					})
				}
				function _getPos(){
					var pos={},
						elemW=that.outerWidth(),
						elemH=that.outerHeight(),
						tipW=tip.width(),
						offset=that.offset();
					pos.left=that.offset().left+elemW/2-tipW/2+(targetOffset.left||0);
					pos.top=that.offset().top+elemH+(targetOffset.top||0);
					return pos;
				};
				function _close(){
					$('#createWell').remove();
				}
			});
		}

	})
}

//关闭某元素
function closeElem(){
	var elem=$('.closeElem');
	if(!elem.length) return;
	elem.each(function(){
		var target=$(this).data('target')||$(this).parent();
		$(this).click(function(){
			target.hide();
		})
	})
}

//关闭fancyBox
function closeFancybox() {
    var elem = $('.closeFancybox');
    if (!elem.length) return;
    elem.each(function () {
        $(this).click(function () {
            $.fancybox.close();
        })
    })
}

//取消默认事件
function stopDefault(){
	$('a[href=#none]').click(function(e){
		e.preventDefault();
	})
}

/*///*导航
function topNagation() {

    $(".head .tab-panel ul li").each(function () {
        var img = $(this).attr("img");
        var hoverimg = $(this).attr("hoverimg");
        $(this).find(".ico").css("background-image", "url(" + img + ")");
        if ($(this).hasClass("on")) {
            $(this).find(".ico").css("background-image", "url(" + hoverimg + ")");
        }
    }).hover(function () {
    	
        var hoverimg = $(this).attr("hoverimg");
        $(this).find(".ico").css("background-image", "url(" + hoverimg + ")");
    }, function () {
        var img = $(this).attr("img");
        if ($(this).hasClass("on")) {
            //$(this).find(".ico").css("background-image", "url(" + hoverimg + ")");
        }
        else {
            $(this).find(".ico").css("background-image", "url(" + img + ")");
        }

    });
}*/

// 调用弹窗插件
function popFancybox(){
	var elem = $('.fancybox');
	if(!elem.length) return;
	elem.fancybox({
		padding:0
	});
}
$(function(){
	stopDefault();//取消默认事件
	createWell()//弹出便 出5kg提示框
	popFancybox();// 调用弹窗插件
	Tab();//tab切换
	closeElem();//关闭莫元素
	closeFancybox();//关闭fancybox

	$('.inputdefult-change').defaultInput();
	ShowDiv();//显示隐藏层
	$('#topSearch').defaultInput();//头部搜索框
	selectToggle();//全选全消
	//topNagation();//导航栏
	opperNavs();
	var ajaxbg = $("#background,#progressBar");
    ajaxbg.hide();    
})

function opperNavs() {
    $(".head .tab-panel ul li").each(function(){
    	if($(this).hasClass("nav_selectli")){
    		var img = $(this).attr("hoverimg");
    		$(this).find(".ico").css("background-image", "url(" + img + ")");
    		$(this).find(".nav_sepleft").css("background", "url("+$(".head #sepleft").val()+")");
       		$(this).find(".nav_seprigt").css("background", "url("+$(".head #seprigt").val()+")");
    	}	
    });
    $(".head .tab-panel ul li").mouseover(function () {
    	if($(this).hasClass("nav_selectli")) return;
        var hoverImg = $(this).attr("hoverimg");
        $(this).find(".ico").css("background-image", "url(" + hoverImg + ")");
        
    });
    $(".head .tab-panel ul li").mouseout(function () {
    	if($(this).hasClass("nav_selectli")) return;
        var img = $(this).attr("img");
        $(this).find(".ico").css("background-image", "url(" + img + ")");
    });
}