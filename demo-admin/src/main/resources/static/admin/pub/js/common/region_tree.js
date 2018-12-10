

var regionTree = {
  selected: null, //选中节点
  isUpdate: false,
  initTree: function (param) { //初始化tree
    regionTree.tree = $("#region_tree").fancytree({
      extensions: [ "glyph", "clones"],
      checkbox:true,
      source: {
        async: true,
        url: ctx + "/admin/region/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        regionTree.treeParam["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/region/tree",
          data: regionTree.treeParam
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        regionTree.selected = data.node;
        regionTree.clickNode(data.node);
      }
    });
    regionTree.tree.fancytree("getTree").setFocus(true);
    regionTree.tree.fancytree("getTree").visit(function(node){
      node.setExpanded();
    });
  },
  clickNode: function (node) { //点击节点

  }
};
$(function () {
  regionTree.treeParam = {};
  regionTree.initTree(regionTree.treeParam);
  $("#region_tree ul").height(window.innerHeight * 2 / 3);
});