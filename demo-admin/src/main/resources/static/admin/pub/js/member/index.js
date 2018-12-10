

var mb = {
  memberType: null, //表单类别:0 = dept, 1 = person
  selected: null, //选中节点
  isUpdate:false,
  initTree: function (param) { //初始化tree
    mb.tree = $("#member_tree").fancytree({
      extensions: ["dnd", "glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/member/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        mb.treeParamData["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/member/tree",
          data: mb.treeParamData
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        mb.selected = data.node;
        mb.clickNode(data.node);
      },
      dblclick:function(event, data){
        var json = data.node.data;
        if(json.memberType === 1){
          $("#auth_modal_title").html(json.memberName + " - 完整授权信息");
          mb.authTreeParam.data.memberId = json.id;
          if(!mb.authTree){
            mb.authTree = $("#auth_tree").fancytree({
              extensions: ["glyph", "clones"],
              source: mb.authTreeParam
            });
            $("#auth_tree ul").css({"max-height": window.innerHeight * 3/5});
          }else{
            mb.authTree.fancytree("getTree").reload(mb.authTreeParam);
          }
          $.get(ctx + "/admin/member/role?memberId="+json.id,function(rs){
            var c = $("#auth_roles").html("");
            for(var i = 0; i < rs.length; i++){
              var r = rs[i];
              var t = (r.status===1?"启用 - ":"禁用 - ") + r.description;
              c.append("<span title='"+t+"' class='label label-"+(r.status===1?'info':'default')+" m-r-xs'>"+r.name+"</span>");
            }
            $("#authMemberModal").modal();
          },"json");
        }
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
            mb.doMove(node, data.otherNode, data.hitMode);
          } else {
            layer.alert("目标节点不能为根节点！", {icon:2});
          }
        }
      }
    });
    mb.tree.fancytree("getTree").setFocus(true);
    $("#member_tree ul").css({"max-height": window.innerHeight * 3/5});
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
        $.post(ctx + "/admin/member/doMove", {
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
      mb.memberType = node.data.memberType;
      mb.isUpdate = true;
      mb.updateForm(node.data);
    }
  },
  updateForm: function (json) { //更新表单
    if (json) {
      $('#member_form').find("input").val("");
      for (var i in json) {
        var input = $('#member_form').find("#"+i);
        if (i == "status") {
          $('#status')[0].checked = (json[i] == 0);
        } else {
          input.val(json[i]);
        }
      }
      var isDept = (json.memberType === 0);
      mb.setDisable(['account', 'pwd'], isDept);
      mb.setDisable(['add_dept_btn', 'add_person_btn', 'add_member_attr_btn'], !isDept);
    }
  },
  memberSubmit: function () { //提交表单
    if (!mb.selected) {
      layer.alert("请填选择一个节点!", {icon:2});
      return;
    }
    if (!$("#memberName").val()) {
      layer.alert("请填写名称!", {icon:2});
      return;
    }
    if(mb.memberType == 1){
      if(!$("#account").val()){
        layer.alert("请填写登录账号!", {icon:2});
        return;
      }
      if (!$("#pwd").val()) {
        layer.alert("请填写登录密码!", {icon:2});
        return;
      }
    }
    var action = ctx + "/admin/member/saveOrUpdate";
    var checked = $("#status")[0].checked;
    var postData = $("#member_form").serialize() + "&status=" + (checked?0:1) + "&memberType=" + mb.memberType;
    if(mb.isUpdate){
      postData += "&id=" + $("#id").val();
    }else{
      if(mb.selected.isLazy()){
        mb.selected.load(true);
      }
    }
    var l = layer.load(1,{shade:0.3});
    $.post(action, postData, function (rs) {
      layer.close(l);
      if (rs.success) {
        if (mb.isUpdate) {
          mb.selected.setTitle(rs.data.data.memberName);
          mb.selected.extraClasses = checked ? "ui-state-disabled" : "";
          mb.selected.data = $.extend(mb.selected.data, rs.data.data);
          mb.selected.render();
        } else { //add
          mb.selected.addChildren(rs.data);
          mb.selected.setExpanded(true);
        }
        layer.alert(rs.message, {icon:1});
      } else {
        layer.alert(rs.message, {icon:2});
      }
    }, "json");
  },
  add_member: function (type) { //添加成员
    mb.isUpdate = false;
    var t = "人员";
    if (mb.selected) {
      $('#member_form').find("input").val("").removeAttr("disabled");
      mb.memberType = type;
      if (type == 0) {
        t = "分组";
        mb.setDisable(['account', 'pwd'], true);
        // $('#member_form').find("input[name='account'],input[name='pwd']").attr("disabled", true);
      }
      $("#parentId").val(mb.selected.refKey);
      $("#id").val(mb.selected.title + " — 添加“" + t + "”");
    } else {
      layer.alert("请填选择一个节点!", {icon:2});
    }
  },
  add_member_attr: function () {
    if (mb.selected) {
      if (mb.selected.memberType === 1) {
        return;
      }
      if(!mb.selected.data.parentId){
        layer.alert("不能操作根节点!", {icon:2});
        return;
      }
      $('#selected_members').html('');
      if(!memberRegionTree.tree){
        memberRegionTree.treeParam = {};
        memberRegionTree.initTree({});
        $("#member_region_tree ul").height(window.innerHeight * 2 / 3);
      }else{
        memberRegionTree.tree.fancytree("getTree").reload();
        if(memberTree.tree){
          memberTree.tree.fancytree("getTree").reload();
        }
      }
      $.get(ctx+'/admin/member/attr/tree/select?memberId='+mb.selected.refKey, function (rs) {
        if (rs.success) {
          var data = rs.data;
          for(var i=0;i<data.length;i++){
            $('#selected_members').append(
              "<label id='label_" + data[i].id + "' class=\"label label-primary m-r-xs\" style='display:inline-block' data-toggle=\"tooltip\" title=\""+data[i].namePath+"\">" + data[i].name + " <a class=\"text-fff\" href=\"javascript:mb.removeSelectedMember('" + data[i].id + "')\">X</a></label>"
            );
          }
        }
      }, "json");
      $("#memberAttrModal").modal();
    } else {
      layer.alert("请填选择一个节点!", {icon:2});
    }
  },
  updateMemberAttr:function(){
    if($('#selected_members').length > 0) {
      var selectIds = [];
      $('#selected_members').find('label').each(function () {
        selectIds.push($(this).context.id.substr(6,$(this).context.id.length));
      });
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/member/attr/tree/select", {
        selectIds: selectIds.join(","),
        memberId: mb.selected.refKey
      }, function (rs) {
        layer.close(l);
        if (rs.success) {
          layer.alert(rs.message, {icon: 1});
          $("#memberAttrModal").modal("hide");
        } else {
          layer.alert(rs.message, {icon: 2});
        }
      }, "json");
    }
  },
  delete_member: function () {
    if (mb.selected) {
      if(!mb.selected.data.parentId){
        layer.alert("请不能删除根节点!", {icon:2});
        return;
      }
      layer.confirm("确定要删除：" + mb.selected.title + "，及其所有子节点吗？", {
        btn: ['确定','取消'],
        shade: 0.3
      }, function(){
        var l = layer.load(1,{shade:0.3});
        $.post(ctx + "/admin/member/delete", {id: mb.selected.refKey}, function (rs) {
          layer.close(l);
          if (rs.success) {
            var parent = mb.selected.parent;
            mb.selected.remove();
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
  removeSelectedMember: function (id) {
    $('#label_'+id).remove();
  }
};
$(function () {
  mb.treeParamData = {treeKind:'ADMIN'};
  mb.initTree(mb.treeParamData);
  mb.authTreeParam = {
    async: true,
    url: ctx + "/admin/member/auth/tree",
    data:{}
  };
  // mb.memberAttrTreeParam = {
  //   async: true,
  //   url: ctx + "/admin/profession-member/tree",
  //   data:{}
  // };
});