
var setting = {
	check: {
				enable: true
			},
	view: {
			showIcon: false,
			expandSpeed: "fast"
		},
    data: {
        simpleData: { enable: true },
      
    },
  
    callback: {
        onClick: onClick
    }
   
};

var zNodes = [
    {
        name: "华北地区", open: true,  click: false,
        children: [
            {
                name: "长沙黄花机场", iconClose: "./img/img_2.png", iconOpen: "./img/img_2.png", click: false,
                children: [
                    { name: "1号泛能站", },
                    { name: "2号泛能站",  },
                    { name: "3号泛能站",  }

                ]
            },
            {
                name: "株洲神农城", iconClose: "./img/img_2.png", iconOpen: "./img/img_2.png", click: false,
                children: [
                    { name: "1号泛能站", icon: "./img/img_3.png" },
                    { name: "2号泛能站", icon: "./img/img_3.png" },
                    { name: "3号泛能站", icon: "./img/img_3.png" }

                ]
            },
            //{ name:"父节点13 - 没有子节点", isParent:true}
           
        ]
    },
    
    {
        name: "华东地区", iconClose: "./img/img_1.png", iconOpen: "./img/img_1.png", click: false,
        children: [
            {
                name: "长沙黄花机场", open: true, iconClose: "./img/img_2.png", iconOpen: "./img/img_2.png", click: false,
                children: [
                    { name: "1号泛能站", icon: "./img/img_3.png" },
                    { name: "2号泛能站", icon: "./img/img_3.png" },
                    { name: "3号泛能站", icon: "./img/img_3.png" }

                ]
            },
            {
                name: "株洲神农城", iconClose: "./img/img_2.png", iconOpen: "./img/img_2.png", click: false,
                children: [
                    { name: "1号泛能站", icon: "./img/img_3.png" },
                    { name: "2号泛能站", icon: "./img/img_3.png" },
                    { name: "3号泛能站", icon: "./img/img_3.png" },
                    { name: "4号泛能站", icon: "./img/img_3.png" }
                ]
            },
            {
                name: "东方伟业", iconClose: "./img/img_2.png", iconOpen: "./img/img_2.png", click: false,
                children: [
                    { name: "1号泛能站", icon: "./img/img_3.png" },
                    { name: "2号泛能站", icon: "./img/img_3.png" },
                    { name: "3号泛能站", icon: "./img/img_3.png" },
                    { name: "4号泛能站", icon: "./img/img_3.png" }
                ]
            }
        ]
    },
    //{ name:"父节点3 - 没有子节点", isParent:true}
  
];
      

		
function onClick(event, treeID, treeNode, clickFlag) {

}

$(document).ready(function () {
    $.fn.zTree.init($("#rightsManagement"), setting, zNodes);
     $.fn.zTree.init($("#rightsManagement1"), setting, zNodes);
   
});
