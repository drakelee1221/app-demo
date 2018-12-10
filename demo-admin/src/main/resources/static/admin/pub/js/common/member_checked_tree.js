

var memberTree = {
  memberType: null, //表单类别:0 = dept, 1 = person
  selected: null, //选中节点
  isUpdate:false,
  initTree: function (param) { //初始化tree
    memberTree.tree = $("#member_attr_tree").fancytree({
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
      },
      dblclick:function(event, data){
        var id = data.node.refKey;
        if($('#label_'+id).length > 0){
          return;
        }
        console.log(data.node);
        var name = data.node.data.memberName;
        var namePath = memberRegionTree.selected.data.namePath;
        $('#selected_members').append(
          "<label id='label_" + id + "' class=\"label label-primary m-r-xs\" style='display:inline-block' data-toggle=\"tooltip\" title=\""+namePath+"\">" + name + " <a class=\"text-fff\" href=\"javascript:mb.removeSelectedMember('" + id + "')\">X</a></label>"
        );
      }
    });
    memberTree.tree.fancytree("getTree").setFocus(true);
    $("#member_attr_tree ul").css({"max-height": window.innerHeight * 4/5});
  }
};

