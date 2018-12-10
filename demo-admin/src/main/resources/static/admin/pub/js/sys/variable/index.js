
var tp = {
  selectPromotionId: null,
  addOrEdit: function (type) {
    if (type == "edit") {
      var selectedRow = tp.getSelectedRow();
      if (selectedRow == null) {
        layer.alert("请选择一行", {icon: 1});
        return;
      }
      tp.openModal();
      if (selectedRow) {
        for (var i in selectedRow) {
          var input = $('#data_form').find("#" + i);
          input.val(selectedRow[i]);
        }
      }
      if(selectedRow.avatar){
        $('#attas_img').attr('src', '/api/edges/oss/redirect?file='+selectedRow.avatar);
      }
      $('#data_form').valid();
    }
    if (type == "add") {
      tp.openModal();
    }
  },
  openModal: function () {
    $("#dataModal").modal({
      backdrop: "static"
    });
    attachment.imgclear();
    $('#dataModal').on('hidden.bs.modal', function () {
      //取消验证文字
      $('#data_form').validate().resetForm()
    });
    $('#attas_img').attr('src', '');
    $('#data_form').find("input").val("");
    $('#data_form').find("textarea").val("");
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
    tableList.init({});
  },
  dealSave: function () {
    if (!$("#data_form").valid()) {
      return;
    }
    var l = layer.load(1, {shade: 0.3});
    var params = $("#data_form").serializeJSON();
    params.attas = JSON.stringify(attachment.getAttaParams());
    $.post(ctx + "/admin/sys/variable", params, function (rs) {
      layer.close(l);
      if (rs.success) {
        $("#dataModal").modal("hide");
        tp.search();
      } else {
        layer.alert(rs.message, {icon: 2});
      }
    }, "json");
  },
  post: function (selectedRow, str, url) {
    var index = layer.confirm("确定要" + str + "吗？", {
      btn: ['确定', '取消'],
      shade: 0.3
    }, function () {
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + url, {id: selectedRow.id}, function (rs) {
        layer.close(l);
        layer.close(index);
        if (rs.success) {
          window.location.reload();
        } else {
          layer.alert(rs.message, {icon: 2});
        }
      }, "json");
    });
  },
  delete: function () {
    var selectedRow = tp.getSelectedRow();
    if (selectedRow == null) {
      layer.alert("请选择一行", {icon: 1});
      return;
    }
    tp.post(selectedRow, "删除", "/admin/sys/variable/delete");
  },
  addAtta: function () {
    $("#file").click();
  },
};

var tableList = {
  obj: $("#table_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/sys/variable",
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
        title: "类型",
        field: "type",
        formatter: function (value, row, index) {
          switch (value) {
            case 0:
              return "产品";
            case 1:
              return "客户";
            case 2:
              return "评价";
          }
        }
      }, {
        title: "图片",
        field: "avatar",
        formatter: function (value, row, index) {
          var url = "/admin/img/avatar.jpg";
          if (row.avatar) {
            url = '/api/edges/oss/redirect?file=' + row.avatar;
          }
          return '<img class="img-circle" id="avatarimg" style="width:30px" src="' + url + '"/>'
        }
      }, {
        title: "关联项",
        field: "refId"
      }, {
        title: "排序号",
        field: "orderNo"
      }, {
        title: "描述",
        field: "remark"
      }, {
        title: "内容",
        field: "jsonData"
      }
      ]
    });
  }
};


$(function () {
  tableList.init({});
  attachment.regist('img');
});