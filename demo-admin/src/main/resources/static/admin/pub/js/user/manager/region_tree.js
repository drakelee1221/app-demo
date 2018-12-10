

var regionTree = {
  selected: null, //选中节点
  isUpdate: false,
  initTree: function (param) { //初始化tree
    regionTree.tree = $("#region_tree").fancytree({
      extensions: ["glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/user/region/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        regionTree.treeParam["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/user/region/tree",
          data: regionTree.treeParam
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        regionTree.selected = data.node;
        regionTree.clickNode(data.node);
      },
      postProcess: function(event, data) {
        if(regionTree.tree && regionTree.tree.fancytree("getTree").getNodeByKey("other")){
          return;
        }
        var nodeArr = [{
          title:"其他",
          key:'other',
          refKey:'other',
          data:{name:"其他"}
        }];
        data.result = nodeArr.concat(data.response);
      },
    });
    regionTree.tree.fancytree("getTree").setFocus(true);
    regionTree.tree.fancytree("getTree").visit(function (node) {
      node.setExpanded();
    });
  },
  clickNode: function (node) { //点击节点
    $("#regionId").val(node.refKey);
    $("#registRegion").val(node.data.name);
    $("#regionChecked").html(node.data.name);
    $(".remove-regionChecked").show();
    pi.search();
  },
  searchAll:function () {
    $("#regionId").val("");
    $("#registRegion").val("");
    $("#regionChecked").html("全部");
    $(".remove-regionChecked").hide();
    pi.search();
  },
};
$(function () {
  regionTree.treeParam = {};
  regionTree.initTree(regionTree.treeParam);
  $("#region_tree ul").height(window.innerHeight * 2 / 3);
});