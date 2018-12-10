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
      // 查询模板参数并显示
      $.ajax({
        url: ctx + "/admin/operation/sms/template/param",
        method: "GET",
        dataType: "json",
        data: {templateId: selectedRow.id},
        success: function (re) {
          re.forEach(function (item, index) {
            fitParam(item.paramCode, item.paramName, item.type, true, item.sysParamType);
          })
        }
      });
      pi.openModal();
      if (selectedRow) {
        for (var i in selectedRow) {
          var input = $('#template_form').find("#" + i);
          input.val(selectedRow[i]);
        }
      }
      $('#template_form').valid();
    }
    if (type == "add") {
      pi.openModal();
    }
  },
  openModal: function () {
    $("#templateModal").modal({
      backdrop: "static"
    });
    $('#templateModal').on('hidden.bs.modal', function () {
//取消验证文字
      $('#template_form').validate().resetForm();
      document.templateForm.reset();
      $("#paramTab").empty();
    });
    $('#template_form').find("input").val("");
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
    if (!$("#template_form").valid()) {
      return;
    }
    if(!refreshParam()){
      return;
    };
    var l = layer.load(1, {shade: 0.3});
    var params = $("#template_form").serializeJSON();
    //参数json
    var paramArray = new Array();
    $("#paramTab tr").each(function (index, item) {
      var param = {
        paramCode: $(this).find(".param_code").val(),
        paramName: $(this).find(".param_name").val(),
        type: $(this).find(".param_type").val(),
        sysParamType: $(this).find(".sys_param_type").val()
      }
      paramArray.push(param);
    });
    params.paramArray = JSON.stringify(paramArray);

    $.post(ctx + "/admin/operation/sms/template/saveOrUpdate", params, function (rs) {
      layer.close(l);
      if (rs.success) {
        $("#templateModal").modal("hide");
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
    var index = layer.confirm("确定要删除：" + selectedRow.content + "吗？", {
      btn: ['确定', '取消'],
      shade: 0.3
    }, function () {
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/operation/sms/template/delete", {ids: selectedRow.id}, function (rs) {
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
      url: ctx + "/admin/operation/sms/template/page",
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
        title: "模板名称",
        field: "tplName"
      }, {
        title: "类型名称",
        field: "typeName"
      }, {
        title: "内容",
        field: "content"
      }, {
        title: "阿里短信ID",
        field: "aliSmsId"
      }, {
        title: "创建时间",
        field: "createTime"
      }, {
        title: "状态",
        field: "status",
        formatter: function (value, row, index) {
          switch (value) {
            case 0:
              return '未审核';
              break;
            case 1:
              return "已审核";
              break;
          }
        }
      },

      ]
    });
  }
};


$(function () {
  tableList.init({});
});

//显示添加参数modal
$("#addParamBtn").click(function () {
  $("#paramModal").modal({
    backdrop: "static"
  }).on('hidden.bs.modal', function () {
    $("#param_code").val('');
    $("#param_name").val('');
  });
})

//快速选择参数
$(".paramClick").click(function () {
  var param_code = $(this).attr("data");
  var param_name = $(this).html();
  var sysParamType = $(this).attr("data-type");
  fitParam(param_code, param_name, 0, false, sysParamType);
})

//确认参数
$("#confirmParam").click(function () {
  var param_code = $("#param_code").val();
  var param_name = $("#param_name").val();
  var param_type = $("#param_type").val();
  if (param_code == '' || param_name == '' || param_name == '') {
    return;
  }
  fitParam(param_code, param_name, param_type, false, '');
  $("#paramModal").modal("hide");
})

//添加参数到主modal界面
function fitParam(param_code, param_name, param_type, isEditInit, sysParamType) {
  var quit = false;
  var params = catchParam($("#content").val());
  params.forEach(function (item, index) {
    if (item == param_code && !isEditInit) {
      layer.alert("参数已存在", {icon: 2});
      quit = true;
      return false;
    }
  })
  if (quit) {
    return;
  }
  var html = '<tr>' +
    '<td>参数：</td>' +
    '<td>' +
    '<input type="hidden" class="sys_param_type" value="' + sysParamType + '"/>' +
    '<input class="form-control param_code" readonly="readonly" required="required" type="text" value="' + param_code + '"/>' +
    '</td>' +
    '<td>名称：</td>' +
    '<td>';
  if (param_name != '') {
    html = html + '<input class="form-control param_name" readonly="readonly" required="required" type="text" value="' + param_name + '"/>';
  } else {
    html = html + '<input class="form-control param_name" required="required" type="text" value="' + param_name + '"/>';
  }
  html = html + '</td>' +
    '<td>参数类型：</td>' +
    '<td>' +
    '<select class="form-control param_type" disabled="disabled" required="required">';
  if (param_type == 0) {
    html = html + '<option value="0" selected>自动</option>' + '<option value="1">手动</option>';
  } else {
    html = html + '<option value="0">自动</option>' + '<option value="1" selected>手动</option>';
  }
  html = html + '</select>' +
    '</td>' +
    '<td>' +
    '&nbsp;&nbsp;&nbsp;<a class="delete_tr">删除</a>' +
    '</td>' +
    '</tr>';
  $("#paramTab").append(html);
  $(".delete_tr").click(function () {
    var param_code_new = "${" + $(this).parent().parent().find(".param_code").val() + "}";
    $(this).parent().parent().remove();
    var content_new = $("#content").val();
    content_new = content_new.replace(new RegExp("\\" + param_code_new, "g"), "");
    $("#content").val(content_new);
  });
  if (!isEditInit) {
    insertText(document.getElementById('content'), "${" + param_code + "}");
  }
}

//textarea光标位置插入值
function insertText(obj, str) {
  if (document.selection) {
    var sel = document.selection.createRange();
    sel.text = str;
  } else if (typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number') {
    var startPos = obj.selectionStart,
      endPos = obj.selectionEnd,
      cursorPos = startPos,
      tmpStr = obj.value;
    obj.value = tmpStr.substring(0, startPos) + str + tmpStr.substring(endPos, tmpStr.length);
    cursorPos += str.length;
    obj.selectionStart = obj.selectionEnd = cursorPos;
  } else {
    obj.value += str;
  }
}

//识别内容中的参数
function catchParam(content) {
  var first = -1;
  var second = -1;
  var params = [];
  for (var i = 0; i < content.length; i++) {
    if (content.substring(i, i + 1) == '$' && content.substring(i + 1, i + 2) == '{') {
      first = i + 2;
      continue;
    }
    if (content.substring(i, i + 1) == '}' && first != -1) {
      second = i;
      var param = content.substring(first, second);
      first = -1;
      params.push(param);
    }
  }
  return params;
}

//刷新内容中的参数
function refreshParam() {
  var params = catchParam($("#content").val());
  var repeat = isRepeat(params);
  if (repeat != '') {
    layer.alert("内容编辑框中参数重复，请修正：" + repeat, {icon: 2});
    return false;
  }
  var exist = [];
  $("#paramTab tr").each(function (index, item) {
    var param_code = $(this).find(".param_code").val();
    if ($.inArray(param_code, params) < 0) {
      $(this).remove();
    } else {
      exist.push(param_code);
    }
  });
  params.forEach(function (item, index) {
    if ($.inArray(item, exist) < 0) {
      fitParam(item, '', 1, true, '');
    }
  })
  return true;
}

//判断数组是否有重复元素
function isRepeat(arr) {
  var res = '';
  var nary = arr.sort();
  for (var i = 0; i < arr.length; i++) {
    if (nary[i] == nary[i + 1]) {
      res = nary[i];
      break;
    }
  }
  return res;
}


