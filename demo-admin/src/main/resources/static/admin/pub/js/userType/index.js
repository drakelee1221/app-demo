
var tp = {
  openModal:function (type) {
    var selectedRow = new Object();
    if(type=='edit'){
      selectedRow = tp.getSelectedRow();
      if (selectedRow == null) {
        layer.alert("请选择一行", {icon: 1});
        return;
      }
    }
    $("#typeModal").modal({
      backdrop: "static"
    });
    $('#userType').val(selectedRow.userType);
    $('#userTypeName').val(selectedRow.userTypeName);
    $('#remark').val(selectedRow.remark);
    $("#id").val(selectedRow.id);
  },
  delete:function () {
    var selectedRow = tp.getSelectedRow();
    if (selectedRow == null) {
      layer.alert("请选择一行", {icon: 1});
      return;
    }
    layer.confirm("确定要删除该分类吗？", {
      btn: ['确定', '取消'],
      shade: 0.3
    }, function () {
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/userType/delete", {id: selectedRow.id}, function (rs) {
        layer.close(l);
        if (rs.success) {
          location.reload();
        } else {
          layer.alert(rs.message, {icon: 2});
        }
      }, "json");
    });
  },
  search:function () {
    tableList.init();
  },
  typeSave:function () {
    if (!$("#type_form").valid()) {
      return;
    }
    var l = layer.load(1, {shade: 0.3});
    $.post(ctx + "/admin/userType/save", {
      id: $("#id").val(),
      userType: $("#userType").val(),
      userTypeName: $("#userTypeName").val(),
      remark: $("#remark").val()
    }, function (rs) {
      layer.close(l);
      if (rs.success) {
        $("#typeModal").modal("hide");
        tp.search();
      } else {
        layer.alert(rs.message, {icon: 2});
      }
    }, "json");
  },
  getSelectedRow: function () {
    var selectedAll = tableList.obj.bootstrapTable("getSelections");
    var selectedRow = null;
    if (selectedAll.length > 0) {
      selectedRow = selectedAll[0];
    }
    return selectedRow;
  },
};

var tableList = {
  obj: $("#table_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/userType/page",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        tableList.obj.bootstrapTable("uncheckAll");
      },
      queryParams: function (params) {
        var newParams = {
          pageSize: params.pageSize,
          pageNum: params.pageNum
        };
        for (var key in searchArgs) {
          newParams[key] = searchArgs[key]
        }
        return newParams;
      },
      pageSize: 15,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      idField: "id",
      //数据列
      columns: [{
        checkbox: true
      }, {
        title: "分类编号",
        field: "userType"
      }, {
        title: "分类名称",
        field: "userTypeName"
      }, {
        title: "备注",
        field: "remark"
      },
      ]
    });
  }
};

$(function () {
  tableList.init({});
});