

var currentRelation='appInfo';

var ro = {
  authCodes: null,
  changeStatus:function(){
    var select = $("#table_list").bootstrapTable("getSelections");
    if(select.length > 0){
      var c = layer.confirm("是否需要 "+(select[0].status === 1?"禁用":"启用")+" 权限角色："+select[0].name+"？", {
        btn: ['确定', '取消'],
        shade: 0.3
      }, function(){
        var l = layer.load(1, {shade: 0.3});
        $.post(ctx + "/admin/role/changeStatus", {id: select[0].id, status: select[0].status === 1?0:1}, function (rs) {
          layer.close(l);
          if (rs.success) {
            $('#table_list').bootstrapTable('refresh');
            layer.alert(rs.message, {icon: 1});
          } else {
            layer.alert(rs.message, {icon: 2});
          }
        }, "json");
        layer.close(c);
      });
    }else{
      layer.alert("请选择一个权限角色！", {icon: 2});
    }
  },
  openModal:function(type){
    if(type === "edit"){
      var select = $("#table_list").bootstrapTable("getSelections");
      if(select.length === 0){
        layer.alert("请选择一个权限角色！", {icon: 2});
        return;
      }
      $("#modal_title").html("修改");
      $("#role_form .form-control").each(function(){
        var $this = $(this);
        $this.val(select[0][$this.attr("name")]);
      });
    }else{
      $("#role_form input[name='id']").val("");
      $("#modal_title").html("新增");
    }
    $("#roleModal").modal();
  },
  formSubmit:function(){
    var els = $("#role_form [required='required']");
    var check = true;
    els.each(function(){
      var $this = $(this);
      if(!$this.val()){
        layer.alert($this.parent().prev().html() + " 未填写！", {icon: 2});
        return check = false;
      }
    });
    if(check){
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/role/saveOrUpdate",
        $("#role_form").serialize(), function (rs) {
          layer.close(l);
          if (rs.success) {
            $('#table_list').bootstrapTable('refresh');
            layer.alert(rs.message, {icon: 1});
            $("#roleModal").modal("hide");
          } else {
            layer.alert(rs.message, {icon: 2});
          }
        }, "json");
    }
  },
  appInfoTreeInit: function (treeParam) { //初始化tree
    ro.appInfoTree = $("#app_tree").fancytree({
      extensions: ["glyph", "clones"],
      checkbox: true,
      source: treeParam,
      dblclick:function(event, data){
        var json = data.node.data;
        if(json){
          $('#appInfo_form input').val("");
          $("#appInfo_modal_title").html(json.name);
          for (var i in json) {
            var input = $("#appInfo_form [name='"+i+"']");
            if (i === "status" || i === 'directory') {
              input[0].checked = (json[i] === 1);
            } else {
              input.val(json[i]);
            }
          }
          $("#appInfoModal").modal();
        }
      }
    });
    $("#app_tree ul").css({"max-height": window.innerHeight * 3/5});
  },
  memberTreeInit: function (treeParam) {
    ro.memberTree = $("#member_tree").fancytree({
      extensions: ["glyph", "clones"],
      checkbox: true,
      source: treeParam,
      dblclick:function(event, data){
        var json = data.node.data;
        if(json.memberType === 1){
          $("#auth_modal_title").html(json.memberName + " - 完整授权信息");
          ro.authTreeParam.data.memberId = json.id;
          if(!ro.authTree){
            ro.authTree = $("#auth_tree").fancytree({
              extensions: ["glyph", "clones"],
              source: ro.authTreeParam
            });
            $("#auth_tree ul").css({"max-height": window.innerHeight * 3/5});
          }else{
            ro.authTree.fancytree("getTree").reload(ro.authTreeParam);
          }
          $.get(ctx + "/admin/role/member?memberId="+json.id,function(rs){
            var c = $("#auth_roles").html("");
            for(var i = 0; i < rs.length; i++){
              var r = rs[i];
              var t = (r.status===1?"启用 - ":"禁用 - ") + r.description;
              c.append("<span title='"+t+"' class='label label-"+(r.status===1?'info':'default')+" m-r-xs'>"+r.name+"</span>");
            }
            $("#authMemberModal").modal();
          },"json");
        }
      }
    });
    $("#member_tree ul").css({"max-height": window.innerHeight * 3/5});
  },
  updateAppInfoJoin:function(){
    if(ro.appInfoTreeParam.data.roleIds){
      var nodes = ro.appInfoTree.fancytree("getTree").getSelectedNodes();
      var appInfoIds = [];
      for(var i = 0 ; i < nodes.length; i++){
        appInfoIds.push(nodes[i].refKey);
      }
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/role/appInfo/select", {appInfoIds: appInfoIds.join(","), roleId: ro.appInfoTreeParam.data.roleIds}, function (rs) {
        layer.close(l);
        if (rs.success) {
          ro.appInfoTree.fancytree("getTree").reload(ro.appInfoTreeParam);
          layer.alert(rs.message, {icon: 1});
        } else {
          layer.alert(rs.message, {icon: 2});
        }
      }, "json");
    }
  },
  updateMemberJoin:function(){
    if(ro.memberTreeParam.data.roleIds){
      var nodes = ro.memberTree.fancytree("getTree").getSelectedNodes();
      var memberIds = [];
      for(var i = 0 ; i < nodes.length; i++){
        memberIds.push(nodes[i].refKey);
      }
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/role/member/select", {memberIds: memberIds.join(","), roleId: ro.memberTreeParam.data.roleIds}, function (rs) {
        layer.close(l);
        if (rs.success) {
          ro.memberTree.fancytree("getTree").reload(ro.memberTreeParam);
          layer.alert(rs.message, {icon: 1});
        } else {
          layer.alert(rs.message, {icon: 2});
        }
      }, "json");
    }
  },
  searchRelation:function () {
    if(currentRelation=='appInfo'){
      ro.searchAppInfo();
    }
    if(currentRelation=='member'){
      ro.searchMember();
    }
  },
  searchAppInfo:function(){
    currentRelation='appInfo';
    var select = $("#table_list").bootstrapTable("getSelections");
    if(select.length > 0){
      $("#appInfo_update_join_btn").removeAttrs("disabled");
      $("#app_tree_title").html(select[0].name);
      ro.appInfoTreeParam.data.roleIds = select[0].id;
      ro.appInfoTree.fancytree("getTree").reload(ro.appInfoTreeParam);
      $("#app_info_dev").show();
      $("#member_dev").hide();
    }else{
      layer.alert("请选择一个权限角色！", {icon: 2});
    }
  },
  searchMember:function(){
    currentRelation='member';
    var select = $("#table_list").bootstrapTable("getSelections");
    if(select.length > 0){
      $("#member_update_join_btn").removeAttrs("disabled");
      $("#member_tree_title").html(select[0].name);
      ro.memberTreeParam.data.roleIds = select[0].id;
      ro.memberTree.fancytree("getTree").reload(ro.memberTreeParam);
      $("#app_info_dev").hide();
      $("#member_dev").show();
    }else{
      layer.alert("请选择一个权限角色！", {icon: 2});
    }
  }
};
$(function () {
  ro.authCodes = JSON.parse($('#authCodeStr').val());
  $("#table_list").bootstrapTable({
    method: "GET",
    url: ctx + "/admin/role/page",
    pageSize: 15,
    checkboxHeader: false,
    clickToSelect: true,
    singleSelect: true,
    idField: "id",
    //数据列
    columns: [{
      checkbox: true
    }, {
      title: "名称",
      field: "name"
    }, {
      title: "编码",
      field: "code",
      formatter: function (value, row, index) {
        for(var index in ro.authCodes){
          if(ro.authCodes[index]['key'] === value){
            return value + '<br>' + ro.authCodes[index]['val'];
          }
        }
        return value;
      }
    }, {
      title: "描述",
      field: "description"
    }, {
      title: "排序",
      field: "orderNo"
    }, {
      title: "状态",
      field: "status",
      formatter: function (value, row, index) {
        return value === 0 ? '禁用' : '启用'
      }
    }],
    onCheck:function (row) {
      ro.searchRelation();
    },
  });
  ro.appInfoTreeParam = {
      async: true,
      url: ctx + "/admin/role/appInfo/tree",
      data:{}
  };
  ro.appInfoTreeInit(ro.appInfoTreeParam);
  ro.memberTreeParam = {
      async: true,
      url: ctx + "/admin/role/member/tree",
      data:{}
  };
  ro.memberTreeInit(ro.memberTreeParam);
  ro.authTreeParam = {
    async: true,
    url: ctx + "/admin/role/member/auth/tree",
    data:{}
  };
});