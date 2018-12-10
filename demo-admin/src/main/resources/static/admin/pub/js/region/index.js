

var mb = {
  selected: null, //选中节点
  isUpdate: false,
  initTree: function (param) { //初始化tree
    mb.tree = $("#region_tree").fancytree({
      extensions: [ "glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/region/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        mb.treeParam["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/region/tree",
          data: mb.treeParam
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        mb.selected = data.node;
        mb.clickNode(data.node);
      }
    });
    mb.tree.fancytree("getTree").setFocus(true);
    mb.tree.fancytree("getTree").visit(function(node){
      node.setExpanded();
    });
  },
  clickNode: function (node) { //点击节点
    if (node) {
      mb.isUpdate = true;
      mb.updateForm(node);
      $("#add_region_btn").removeAttrs("disabled");
    }
  },
  updateForm: function (node) { //更新表单
    if (node.data) {
      $('#region_form').find("input").val("");
      for (var i in node.data) {
        var input = $('#region_form').find("#" + i);
        if (i == "status") {
          $('#status')[0].checked = (node.data[i] == 0);
        } else {
          input.val(node.data[i]);
        }
      }
    }
    if (node.parent) {
      $("#parentName").val(node.parent.data.name);
    }

  },
  regionSubmit: function () { //提交表单
    if(!$("#region_form").valid()){
      return;
    }
    var action = ctx + "/admin/region/saveOrUpdate";
    var checked = $("#status")[0].checked;
    var postData = $("#region_form").serialize() + "&status=" + (checked ? 0 : 1);
    if (mb.isUpdate) {
      postData += "&id=" + $("#id").val();
    }
    var l = layer.load(1, {shade: 0.3});
    $.post(action, postData, function (rs) {
      layer.close(l);
      if (rs.success) {
        layer.alert(rs.message, {icon: 1});
        location.reload();
      } else {
        layer.alert(rs.message, {icon: 2});
      }
    }, "json");
  },
  add_region: function (isRoot) {
    mb.isUpdate = false;
    if (isRoot) {
      $('#region_form').find("input").val("").removeAttr("disabled");
      $("#id").val("添加根地区");
    } else {
      if (mb.selected) {
        $('#region_form').find("input").val("").removeAttr("disabled");
        $("#parentId").val(mb.selected.refKey);
        $("#parentName").val(mb.selected.data.name);
        $("#id").val("添加节点地区");
      } else {
        layer.alert("请填选择一个节点!", {icon: 2});
      }
    }
  },
  delete_region: function () {
    if (mb.selected) {
      layer.confirm("确定要删除：" + mb.selected.title + "，及其所有子节点吗？", {
        btn: ['确定', '取消'],
        shade: 0.3
      }, function () {
        var l = layer.load(1, {shade: 0.3});
        $.post(ctx + "/admin/region/delete", {id: mb.selected.data.id}, function (rs) {
          layer.close(l);
          if (rs.success) {
            var parent = mb.selected.parent;
            mb.selected.remove();
            $(parent.ul).trigger("click");
            layer.alert(rs.message, {icon: 1});
          } else {
            layer.alert(rs.message, {icon: 2});
          }
        }, "json");
      });
    } else {
      layer.alert("请填选择一个节点!", {icon: 2});
    }
  }
};
$(function () {
  mb.treeParam = {};
  mb.initTree(mb.treeParam);
  $("#region_tree ul").height(window.innerHeight * 2 / 3);
});