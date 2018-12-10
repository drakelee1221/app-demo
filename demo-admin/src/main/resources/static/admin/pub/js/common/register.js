$(function () {
  $.get(ctx+"/admin/userType/register",{}, function (rs) {
    if (rs.success) {
      var data = rs.data;
      for (var x = 0; x < data.length; x++) {
        var obj = data[x];
        $("#userType").append("<option value='" + obj.id + "'>" + obj.userTypeName + "</option>")
      }
    } else {
      layer.alert(rs.message, {icon:2});
    }
  }, "json");

  $("#product_list").bootstrapTable({
    method: "GET",
    url: ctx + "/admin/product/info/page",
    queryParams: function (params) {
      return {
        pageSize: params.pageSize,
        pageNum: params.pageNum
      };
    },
    pageSize: 10000,
    checkboxHeader: true,
    clickToSelect: true,
    singleSelect: false,
    idField: "id",
    //数据列
    columns: [{
      checkbox: true
    }, {
      title: "类别",
      field: "typeName"
    }, {
      title: "名称",
      field: "name"
    }, {
      title: "描述",
      field: "descri"
    }, {
      title: "图标",
      field: "icon"
    }, {
      title: "详情介绍链接",
      field: "url"
    }, {
      title: "启用时间",
      field: "beginTime"
    }, {
      title: "过期时间",
      field: "expireTime"
    }, {
      title: "计算周期",
      field: "cycle",
      formatter: function (value, row, index) {
        return value === 0 ? '否' : '是'
      }
    }, {
      title: "状态",
      field: "status",
      formatter: function (value, row, index) {
        return value === 0 ? '禁用' : '启用'
      }
    }]
  });
});
function registerUser() {
  var postData = $("#register_form").serialize();
  if(!$("#code").val()){
    layer.alert("请输入注册码", {icon:1});
    return;
  }
  if(!$("#userNickName").val()){
    layer.alert("请输入用户名", {icon:1});
    return;
  }
  if(!$("#phone").val()){
    layer.alert("请输入手机号", {icon:1});
    return;
  }
  if(!$("#pwd").val()){
    layer.alert("请输入密码", {icon:1});
    return;
  }
  if(!$("#pwd").val()){
    layer.alert("请输入确认密码", {icon:1});
    return;
  }
  if($("#pwd").val()!=$("#pwd_confirm").val()){
    layer.alert("两次输入的密码不一致，请重新输入", {icon:1});
    return;
  }
  if(!$("#memberName").val()){
    layer.alert("请选择部门", {icon:1});
    return;
  }
  if(!$("#regionNames").val()){
    layer.alert("请选择服务地区", {icon:1});
    return;
  }
  if(!$("#productNames").val()){
    layer.alert("请选择擅长产品", {icon:1});
    return;
  }
  $.post(ctx+"/admin/register", postData, function (rs) {
    if (rs.success) {
      $('#register_form').find("input").val("");
      layer.alert("注册成功，请前往网站登录", {icon:1});
    } else {
      layer.alert(rs.message, {icon:2});
    }
  }, "json");
}
function showRegion(){
  $("#treeModal").modal("show");
}
function confirmRegion(){
  var names = [];
  var nodes = regionTree.tree.fancytree("getTree").getSelectedNodes();
  if(nodes.length == 0){
    layer.alert("请选择服务地区", {icon:1});
    return;
  }
  var selectIds = [];
  for (var i = 0; i < nodes.length; i++) {
    selectIds.push(nodes[i].refKey);
    names.push(nodes[i].title);
  }
  $("#regionNames").val(names.join(","));
  $("#regionIds").val(selectIds.join(","));
  $("#treeModal").modal("hide");
}
function showProduct(){
  $("#productModal").modal("show");
}
function confirmProduct() {
  var names=[];
  var selectIds=[];
  var select = $("#product_list").bootstrapTable("getSelections");
  if(select.length == 0){
    layer.alert("请勾选擅长产品", {icon:1});
    return;
  }
  for(var i=0;i<select.length;i++){
    names.push(select[i].name);
    selectIds.push(select[i].id);
  }
  $("#productNames").val(names.join(","));
  $("#productIds").val(selectIds.join(","));
  $("#productModal").modal("hide");
}
function showMember() {
  $("#memberModal").modal("show");
}
function memberConfirm() {
  if(!memberTree.selected){
    layer.alert("请选择部门", {icon:1});
    return;
  }
  var nodes =  memberTree.selected;
  $("#memberName").val(nodes.title);
  $("#memberId").val(nodes.refKey);
  $("#memberModal").modal("hide");
}