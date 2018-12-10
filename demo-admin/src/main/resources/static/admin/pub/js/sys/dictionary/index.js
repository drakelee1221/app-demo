/*
 * Copyright (c) 2017.mj.he800.com Inc. All rights reserved.
 */
var pi = {
  addOrEdit: function (type) {
    if (type == "edit") {
      var selectedRow = pi.getSelectedRow();
      if (selectedRow == null) {
        layer.alert("请选择一行", {icon: 1});
        return;
      }
      if (selectedRow.canEdit == 0) {
        layer.alert("不可编辑", {icon: 1});
        return;
      }
      pi.openModal();
      if (selectedRow) {
        for (var i in selectedRow) {
          var input = $('#dictionary_form').find("#" + i);
          input.val(selectedRow[i]);
        }
      }
      $('#dictionary_form').valid();
    }
    if (type == "add") {
      pi.openModal();
    }
  },
  openModal: function () {
    $("#dictionaryModal").modal({
      backdrop: "static"
    });
    $('#dictionaryModal').on('hidden.bs.modal', function () {
//取消验证文字
      $('#dictionary_form').validate().resetForm();
      document.dictionaryForm.reset();
    });
    $('#dictionary_form').find("input").val("");
  },
  getSelectedRow: function () {
    var selectedAll = tableList.obj.bootstrapTable("getSelections");
    var selectedRow = null;
    if (selectedAll.length > 0) {
      selectedRow = selectedAll[0];
    }
    return selectedRow;
  },
  search: function () {
    var searchArgs = $("#search_form").serializeJSON();
    tableList.init(searchArgs);
  },
  clearCondition: function () {
    document.searchForm.reset();
    pi.search();
  },
  dealSave: function () {
    if (!$("#dictionary_form").valid()) {
      return;
    }

    var l = layer.load(1, {shade: 0.3});
    var params = $("#dictionary_form").serializeJSON();

    $.post(ctx + "/admin/sys/dictionary/saveOrUpdate", params, function (rs) {
      layer.close(l);
      if (rs.success) {
        $("#dictionaryModal").modal("hide");
        pi.search();
      } else {
        layer.alert(rs.message, {icon: 2});
      }
    }, "json");
  },
  delete: function () {
    var selectedRow = pi.getSelectedRow();
    if (selectedRow == null) {
      layer.alert("请选择一行", {icon: 1});
      return;
    }
    if (selectedRow.canEdit == 0) {
      layer.alert("不可编辑", {icon: 1});
      return;
    }
    var index = layer.confirm("确定要删除：" + selectedRow.dictName + "吗？", {
      btn: ['确定', '取消'],
      shade: 0.3
    }, function () {
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/sys/dictionary/delete", {ids: selectedRow.id}, function (rs) {
        layer.close(l);
        layer.close(index);
        if (rs.success) {
          tableList.init({});
        } else {
          layer.alert(rs.message, {icon: 2});
        }
      }, "json");
    });
  },
};

var tableList = {
  obj: $("#table_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/sys/dictionary/page",
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
        title: "字典编码",
        field: "dictCode"
      }, {
        title: "字典名称",
        field: "dictName"
      }, {
        title: "数据类型",
        field: "dataType"
      }, {
        title: "备注",
        field: "remarks"
      }, {
        title: "状态",
        field: "status",
        formatter: function (value, row, index) {
          switch (value) {
            case 0:
              return '禁用';
              break;
            case 1:
              return "启用";
              break;
          }
        }
      }, {
        title: "是否可编辑",
        field: "canEdit",
        formatter: function (value, row, index) {
          switch (value) {
            case 0:
              return '不可编辑';
              break;
            case 1:
              return "可编辑";
              break;
          }
        }
      },
      ],
      onClickRow: function (row) {
        var ifm = document.getElementById("dictionaryDataIfm").contentWindow;
        if (ifm.$(".modal").is(":hidden")) {
          ifm.init(row.id, row.dictName);
          if (row.canEdit == 0) {
            ifm.$("#editDiv button").hide();
          } else {
            ifm.$("#editDiv button").show();
          }
        } else {
          layer.alert("请先提交或者取消右侧修改！", {icon: 2});
        }
      }
    });
  }
};

$(function () {
  tableList.init({});
  document.getElementById("dictionaryDataIfm").style.height = $("body").height() + "px";
});

function exampleSelect() {
  $("#exampleModal").modal();
}

function refreshDictionaryCache() {
  var l = layer.load(1, {shade: 0.3});
  $.post(ctx + "/admin/sys/dictionary/refresh-cache", {}, function (re) {
    if(re.success){
      layer.alert("刷新成功！", {icon: 1});
    }else{
      layer.alert("异常重试！", {icon: 2});
    }
    layer.close(l);
  }, "json");
}

