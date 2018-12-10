

var smsRegionTree = {
  selected: null, //选中节点
  isUpdate: false,
  initTree: function (param) { //初始化tree
    smsRegionTree.tree = $("#region_tree").fancytree({
      extensions: [ "glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/region/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        smsRegionTree.treeParam["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/region/tree",
          data: smsRegionTree.treeParam
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        smsRegionTree.selected = data.node;
        smsRegionTree.clickNode(data.node);
      }
    });
    smsRegionTree.tree.fancytree("getTree").setFocus(true);
    smsRegionTree.tree.fancytree("getTree").visit(function(node){
      node.setExpanded();
    });
  },
  clickNode: function (node) { //点击节点

  }
};
$(function () {
  smsRegionTree.treeParam = {};
  smsRegionTree.initTree(smsRegionTree.treeParam);
  $("#region_tree ul").height(window.innerHeight * 2 / 3);
});