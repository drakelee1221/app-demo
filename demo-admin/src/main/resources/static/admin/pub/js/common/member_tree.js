

var memberTree = {
  memberType: null, //表单类别:0 = dept, 1 = person
  selected: null, //选中节点
  isUpdate:false,
  initTree: function (param) { //初始化tree
    memberTree.tree = $("#member_tree").fancytree({
      extensions: ["dnd", "glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/profession-member/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        memberTree.treeParamData["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/profession-member/tree",
          data: memberTree.treeParamData
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        memberTree.selected = data.node;
      }
    });
    memberTree.tree.fancytree("getTree").setFocus(true);
    $("#member_tree ul").css({"max-height": window.innerHeight * 4/5});
  }
};

$(function () {
  /*memberTree.treeParam = {};
  memberTree.initTree(regionTree.treeParam);
  $("#member_tree ul").height(window.innerHeight * 2 / 3);*/
});
