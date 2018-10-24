$(function () {
function isIE() {
    var myNav = navigator.userAgent.toLowerCase();
    return (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
}
if(isIE() && isIE() < 11) {
    jAlert('你的IE版本过低，请用以下链接升级至IE11 http://windows.microsoft.com/zh-cn/internet-explorer/download-ie');
}

$("#form").find(".input input").focus(function () {
    $(this).parent(".input").addClass("on").find("span").fadeOut("fast");
}).blur(function () {
    var $this = $(this);
    if ($this.val() == "") {
        $this.parent(".input").removeClass("on").find("span").fadeIn("fast")
    }
});



})