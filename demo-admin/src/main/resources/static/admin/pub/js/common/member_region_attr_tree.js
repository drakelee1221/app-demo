

var memberRegionTree = {
  selected: null, //选中节点
  isUpdate: false,
  initTree: function (param) { //初始化tree
    memberRegionTree.tree = $("#member_region_tree").fancytree({
      extensions: [ "glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/region/member/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        memberRegionTree.treeParam["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/region/member/tree",
          data: memberRegionTree.treeParam
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        memberRegionTree.selected = data.node;
        memberRegionTree.clickNode(data.node);
      }
    });
    memberRegionTree.tree.fancytree("getTree").setFocus(true);
    memberRegionTree.tree.fancytree("getTree").visit(function(node){
      node.setExpanded();
    });
  },
  clickNode: function (node) { //点击节点
    if (node && !node.folder) {
      memberTree.treeParamData = {treeKind: node.refKey};
      if (!memberTree.tree) {
        memberTree.initTree(memberTree.treeParamData);
      } else {
        var param = {
          async: true,
          url: ctx + "/admin/profession-member/tree",
          data: memberTree.treeParamData
        };
        memberTree.tree.fancytree("getTree").reload(param);
      }
    }
  }
};