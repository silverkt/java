
var setting = {
    check: {
        enable: true,
        chkStyle: "checkbox"
        //        chkboxType : { "Y" : "", "N" : "" }
    },
    
    data: {
        simpleData: { enable: true }
    },
    callback: {
        onClick: onClick
    }
};
var setting2 = {
    
    data: {
        simpleData: { enable: true }
    },
    callback: {
        onClick: onClick
    }
};
var zNodes = null;

function onClick(event, treeID, treeNode, clickFlag) {
    $("#select_del").text(treeNode.name);
    $("#select_edt").val(treeNode.name);
    $("#select_add").val(treeNode.name);
    var mark =  $("#markIddu").val();
	var isParent = treeNode.level==0?true:false;
	var isChildren = treeNode.children.length==0?true:false;
	$("#selectedId").val(treeNode.id);
	
	//如果是父节点
	if(isParent){
		$("#tablenameID").val("project_Region");
	}else{
		$("#tablenameID").val("Project_park");
		//$("#btn_xjzj").css("background", "url(../resources/img/xmgl_btn2.png)");
		$("#select_addhidden").val(treeNode.getParentNode().id);
	}
	//点击修改时可以修改
	if(mark==3){
		if(isParent){
			$("#tablenameID").val("project_Region");
		}else{
			$("#tablenameID").val("Project_park");
			//$("#btn_xjzj").css("background", "url(../resources/img/xmgl_btn2.png)");
			$("#select_addhidden").val(treeNode.getParentNode().id);
		}
	}
}

$(document).ready(function () {
    $.fn.zTree.init($("#areaNames"), setting, zNodes);
});
$(document).ready(function () {
    $.fn.zTree.init($("#areaNames2"), setting2, zNodes);
})