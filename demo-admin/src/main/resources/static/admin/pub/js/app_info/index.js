

var ap = {
  memberType: null, //表单类别:0 = dept, 1 = person
  selected: null, //选中节点
  isUpdate:false,
  initTree: function (param) { //初始化tree
    ap.tree = $("#app_tree").fancytree({
      extensions: ["dnd", "glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/appInfo/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        ap.treeParam["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/appInfo/tree",
          data: ap.treeParam
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        ap.selected = data.node;
        ap.clickNode(data.node);
      },
      dnd: {
        autoExpandMS: 500,
        focusOnClick: true,
        preventVoidMoves: true, // Prevent dropping nodes 'before self', etc.
        preventRecursiveMoves: true, // Prevent dropping nodes on own descendants
        dragStart: function (node, data) {
          return !!node.data.parentId;
        },
        dragEnter: function (node, data) {
          return true;
        },
        dragOver: function (node, data) {
          if (node.isDescendantOf(data)) {
            return false;
          }
        },
        dragDrop: function (node, data) {
          if (node.data.parentId) {
            ap.doMove(node, data.otherNode, data.hitMode);
          } else {
            layer.alert("目标节点不能为根节点！", {icon:2});
          }
        }
      }
    });
    ap.tree.fancytree("getTree").setFocus(true);
    $("#app_tree ul").css({"max-height": window.innerHeight * 4/5});
  },
  doMove: function (target, src, hitMode) {
    if ("over" == hitMode && target.data.memberType == 1) {
      layer.alert("不能将 [" + src.title + "] 移动到 [" + target.title + "] 里面 ！", {icon:2});
    } else {
      layer.confirm("确定要将 [" + src.title + "] 移动到 [" + target.title + "] " + (hitMode == "over" ? "里面" : (hitMode == "after" ? "后面" : "前面")) + " 吗？", {
        btn: ['确定','取消'],
        shade: 0.3
      }, function(){
        var l = layer.load(1,{shade:0.3});
        $.post(ctx + "/admin/appInfo/doMove", {
          srcId: src.refKey,
          targetId: target.refKey,
          hitMode: hitMode
        }, function (rs) {
          layer.close(l);
          if (rs.success) {
            src.moveTo(target, hitMode);
            layer.alert(rs.message, {icon:1});
          } else {
            layer.alert(rs.message, {icon:2});
          }
        }, "json");
      });
    }
  },
  clickNode: function (node) { //点击节点
    if (node) {
      ap.memberType = node.data.memberType;
      ap.isUpdate = true;
      ap.updateForm(node.data);
    }
  },
  updateForm: function (json) { //更新表单
    if (json) {
      $('#app_form').find("input,textarea").val("");
      for (var i in json) {
        var input = $('#app_form').find("#"+i);
        if (i === "status" || i === 'directory') {
          input[0].checked = (json[i] === 1);
        } else {
          if (i === 'authUrlPrefix'){
            input.val(json[i].replace(/,/g, '\n'));
          } else {
            input.val(json[i]);
          }
        }
      }
      ap.setDisable(['add_dir_btn', 'add_app_btn'], json['directory'] === 0);
      ap.setDisable(['targetUrl', 'authUrlPrefix', 'readWriteType'], json['directory'] === 1);
      ap.setDisable(['sub_btn'], json.parentId === '');
    }
  },
  formSubmit: function () { //提交表单
    if (!ap.selected) {
      layer.alert("请填选择一个节点!", {icon:2});
      return;
    }
    if(!$("#name").val()){
      layer.alert("请填写名称!", {icon:2});
      return;
    }
    var dir = $("#directory")[0].checked;
    if (!dir) {
      if(!$("#authUrlPrefix").val()){
        layer.alert("授权路径前缀!", {icon:2});
        return;
      }
      if(!$("#targetUrl").val()){
        layer.alert("跳转路径!", {icon:2});
        return;
      }
    }
    var action = ctx + "/admin/appInfo/saveOrUpdate";
    var status = $("#status")[0].checked;
    var authUrlPrefix = $('#authUrlPrefix').val();
    authUrlPrefix = authUrlPrefix.replace(/\n/g, ',');
    var postData = $("#app_form").serializeJSON();
    postData.authUrlPrefix = authUrlPrefix;
    postData.status= status?1:0;
    postData.directory=dir?1:0;
    postData.readWriteType= $("#readWriteType").val();
    if(ap.isUpdate){
      postData.id=$("#id").val();
    }else{
      if(ap.selected.isLazy()){
        ap.selected.load(true);
      }
    }
    var l = layer.load(1,{shade:0.3});
    $.post(action, postData, function (rs) {
      layer.close(l);
      if (rs.success) {
        if (ap.isUpdate) {
          ap.selected.setTitle(rs.data.data.name);
          ap.selected.extraClasses = status ? ap.selected.extraClasses.replace("ui-state-disabled", "")
                                            : ap.selected.extraClasses + " ui-state-disabled";
          ap.selected.data = $.extend(ap.selected.data, rs.data.data);
          ap.selected.render();
        } else { //add
          ap.selected.addChildren(rs.data);
          ap.selected.setExpanded(true);
        }
        layer.alert(rs.message, {icon:1});
      } else {
        layer.alert(rs.message, {icon:2});
      }
    }, "json");
  },
  add: function (type) {
    ap.isUpdate = false;
    var t = "应用";
    if (ap.selected) {
      $("#readWriteType").val(0).removeAttr("disabled");
      ap.setDisable(['sub_btn'], false);
      $('#app_form').find("input").not("#directory").val("").removeAttr("disabled");
      ap.memberType = type;
      if (type === 0) {
        t = "目录";
        $("#directory")[0].checked = true;
        ap.setDisable(['targetUrl', 'authUrlPrefix', 'readWriteType'], true);
      }else{
        $("#directory")[0].checked = false;
        $("#authUrlPrefix").val("");
        $("#authUrlPrefix").removeAttr("disabled");
      }
      $("#parentId").val(ap.selected.refKey);
      $("#id").val(ap.selected.title + " — 添加“" + t + "”");
    } else {
      layer.alert("请填选择一个节点!", {icon:2});
    }
  },
  del: function () {
    if (ap.selected) {
      if(!ap.selected.data.parentId){
        layer.alert("不能删除根节点!", {icon:2});
        return;
      }
      layer.confirm("确定要删除：" + ap.selected.title + "，及其所有子节点吗？", {
        btn: ['确定','取消'],
        shade: 0.3
      }, function(){
        var l = layer.load(1,{shade:0.3});
        $.post(ctx + "/admin/appInfo/delete", {id: ap.selected.refKey}, function (rs) {
          layer.close(l);
          if (rs.success) {
            var parent = ap.selected.parent;
            ap.selected.remove();
            $(parent.ul).trigger("click");
            layer.alert(rs.message, {icon:1});
          } else {
            layer.alert(rs.message, {icon:2});
          }
        }, "json");
      });
    } else {
      layer.alert("请填选择一个节点!", {icon:2});
    }
  },
  setDisable:function(ids, isDisable){
    var items = $("#"+ids.join(",#"));
    if(isDisable){
      items.attr("disabled", true);
    }else{
      items.removeAttr("disabled");
    }
  },
  openIcon:function selectIcon(obj) {
    $.selector.icons(function (value) {
      $(obj).val(value);
    });
  }
};
$(function () {
  ap.treeParam = {};
  ap.initTree(ap.treeParam);
});