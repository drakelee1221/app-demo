
var sms = {
  contactGrid: null
};
$(function () {
  $("#table_list").bootstrapTable({
    method: "GET",
    url: ctx + "/admin/operation/sms/pages",
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    onLoadSuccess: function () {
      $("#table_list").bootstrapTable("uncheckAll");
    },
    queryParams: function (params) {
      return {
        pageSize: params.pageSize,
        pageNum: params.pageNum,
        startDate: $("#startDate").val(),
        endDate: $("#endDate").val(),
        keywords: $("#keywords").val(),
        status: $("#status").val()
      };
    },
    pageSize: 10,
    checkboxHeader: false,
    clickToSelect: true,
    singleSelect: false,
    idField: "id",
    //数据列
    columns: [{
      checkbox: true
    }, {
      title: "批次",
      field: "batch"
    }, {
      title: "发送模式",
      field: "smsSendMode",
      formatter: function (v) {
        if (v === 0) {
          return "批量发送模式";
        } else if (v === 1) {
          return "手工发送模式";
        }
      }
    }, {
      title: "模板",
      field: "templateName"
    }, {
      title: "模板内容",
      field: "tplContent"
    }, {
      title: "自定义参数内容",
      field: "content"
    }, {
      title: "创建时间",
      field: "createTime"
    }, {
      title: "状态",
      field: "status",
      formatter: function (value) {
        switch (value) {
          case 0 :
            return '未发送';
          case 1 :
            return '发送完成';
          case 2 :
            return '发送未完成';
        }
      }
    }, {
      title: "备注",
      field: "remarks"
    }, {
      title: "操作",
      formatter: function (value, row, index) {
        var deleteBtn = "<button class=\"btn btn-danger btn-xs\" onclick=\"deleteSms('" + row.id + "')\"><i class='fa fa-dropbox'></i>删除</button>";
        var send = "<button class=\"btn btn-primary btn-xs\" onclick=\"sendSms('" + row.id + "')\"><i class='fa fa-send'></i>发送</button>&nbsp;&nbsp;";

        var record = "<button class=\"btn btn-warning btn-xs\" onclick=\"record('" + row.id + "')\">短信记录</button>" + "&nbsp;&nbsp;";
        var view = "<button class=\"btn btn-success btn-xs\" onclick=\"viewContent('" + row.id + "')\">查看详情</button>" + "&nbsp;&nbsp;";
        if (row.status === 1) {
          send = "";
        }
        if (row.status !== 0) {
          view = "";
          deleteBtn = "";
        }
        return view + record + send + deleteBtn;
      }
    }]
  });

  initTemplate();
});
//日期范围限制
var start = {
  elem: '#startDate',
  format: 'YYYY-MM-DD',
  istime: false,
  istoday: false,
  choose: function (datas) {
    end.min = datas; //开始日选好后，重置结束日的最小日期
    end.start = datas //将结束日的初始值设定为开始日
  }
};
var end = {
  elem: '#endDate',
  format: 'YYYY-MM-DD',
  istime: false,
  istoday: false,
  choose: function (datas) {
    start.max = datas; //结束日选好后，重置开始日的最大日期
  }
};
laydate(start);
laydate(end);

function refreshGrid() {
  $("#table_list").bootstrapTable("refresh");
}

function clearCondition() {
  document.searchForm.reset();
  $("#table_list").bootstrapTable("refresh");
}

function viewContent(id) {
  $.get(ctx + "/admin/operation/sms/" + id, "", function (re) {
    $("#id").val(re.id);
    /*$("#templateId").find("option[value='" + re.templateId + "']").attr("selected", true);
    templateChange();*/
    $("#templateId").val(re.templateId);
    templateChange();
    $("#remarks").val(re.remarks);
    $("#batch").val(re.batch);
    $("#smsChannel").val(re.smsChannel);
    $("#paramJson").val(re.paramJson);
    if (re.smsSendMode === 0) {
      clearUserCondition(false);
      if (re.userFilter) {
        var filter = JSON.parse(re.userFilter);
        $.each(filter, function (k, v) {
          if (k === "region_name") {
            v = decodeURIComponent(v);
          }
          $("#q_" + k).val(v);
        });
        refreshContactGrid();
      }
      $("#phones").val("");
      $("#mode_tab a:first").tab("show");
    } else {
      document.contact_search_form.reset();
      $("#contact_list").bootstrapTable("removeAll");
      $("#mode_tab a:last").tab("show");
      $("#phones").val(re.phones);
    }

    hiddenOperateBtn(re.status !== 0);
    $("#createSmsModal").modal();
  })
}

function createSms() {
  document.contact_search_form.reset();
  if (!sms.contactGrid) {
    initContactGrid();
  }else{
    $("#contact_list").bootstrapTable("removeAll");
  }
  $("#sms_form")[0].reset();
  $("#id").val("");
  $("#smsChannel").val(0);
  $("#templateId").val("");
  hiddenOperateBtn(false);
  $("#createSmsModal").modal();
}

function saveSms(func) {
  var data = $("#sms_form").serialize();

  var l = layer.load(1, {shade: 0.3});
  if ($("#smsSendMode").val() == 0) {
    var contacts = $("#contact_list").bootstrapTable("getData");
    if (contacts.length === 0) {
      layer.close(l);
      layer.alert("无短信接收人", {icon: 2});
      return;
    }
    data = data + "&filter=" + JSON.stringify(getFilterParam());
  } else {
    data = data + "&phones=" + $("#phones").val();
  }


  $.post(ctx + "/admin/operation/sms", data, function (rs) {
    layer.close(l);
    if (rs.success) {
      refreshGrid();
      $("#id").val(rs.data.id);
      layer.alert("保存成功", {icon: 1});
    } else {
      layer.alert(rs.message, {icon: 1});
    }
  }, "json");
}

function saveSendSms() {
  saveSms(sendSms);
}

function sendSms(id) {
  layer.confirm('确定发送该批次短信？', {
    btn: ['确定', '取消']
  }, function () {
    var l = layer.load(1, {shade: 0.3});
    $.post(ctx + "/admin/operation/sms/send", {id: id}, function (rs) {
      layer.close(l);
      if (rs.success) {
        layer.alert("发送完成", {icon: 1});
        $("#createSmsModal").modal("hide");
        refreshGrid();
      } else {
        layer.alert(rs.message, {icon: 2});
      }
    }, "json");
  }, function () {

  });

}

function initTemplate() {
  $.get(ctx + "/admin/operation/sms/template", "", function (re) {
    for (var x = 0; x < re.length; x++) {
      var obj = re[x];
      $("#templateId,#v_templateId").append("<option value='" + obj.templateId + "' params='" + (obj.params ? obj.params : "") + "' content='" + obj.content + "' id='" + obj.templateId + "'>" + obj.title + "</option>");
      $("#q_templateId").append("<option value='" + obj.templateId + "'>" + obj.title + "</option>");
    }
  })
}

function templateChange(obj, prefix) {
  if (!prefix) {
    prefix = "";
  }
  var params = $($("#" + $("#" + prefix + "templateId").val())[0]).attr("params");
  var pId = "#" + prefix + "paramJson";
  if (!params) {
    $(pId).attr("placeholder", "当前模板无自定义参数");
    $(pId).attr("readOnly", true);
    $(pId).val("");
  } else {
    var ps = params.split(",");
    var t = "";
    for (var x = 0; x < ps.length; x++) {
      t = t + "\"" + ps[x] + "\":\"填写参数值\",";
    }
    t = t.substr(0, t.length - 1);
    if (!prefix) {
      $(pId).attr("readOnly", false);
    }
    $(pId).val("{" + t + "}");
  }
  $("#" + prefix + "content_view").val($($("#" + $("#" + prefix + "templateId").val())[0]).attr("content"));

}

function addToReceive() {
  var selects = $("#contact_list").bootstrapTable("getSelections");
  if (selects.length == 0) {
    layer.alert("选择联系人", {icon: 2});
    return;
  }
  for (var i = 0; i < selects.length; i++) {
    $("#local_contact_list").bootstrapTable("insertRow", {index: 0, row: selects[i]});
  }

}

function refreshContactGrid() {
  if (!sms.contactGrid) {
    initContactGrid();
  }
  $("#contact_list").bootstrapTable("refresh", {url: ctx + "/admin/operation/sms/users"});

}

function getFilterParam() {
  return {
    batch: $("#q_batch").val(),
    templateId: $("#q_templateId").val(),
    region: $("#q_region").val(),
    receiveCount: $("#q_receiveCount").val(),
    region_name: encodeURIComponent($("#q_region_name").val())
  };
}


//查看详情
function record(smsId) {
  $("#smsId").val(smsId);
  initRecord();
  $("#recordModal").modal();
}

function showQueryRegion() {
  $("#treeModal").modal("show");
}

function confirmQueryRegion() {
  var nodes = smsRegionTree.selected;
  if (!nodes) {
    layer.alert("请选择地区", {icon: 1});
    return;
  }
  $("#q_region_name").val(nodes.title);
  $("#q_region").val(nodes.refKey);
  $("#treeModal").modal("hide");
}

function clearUserCondition(refresh) {
  document.contact_search_form.reset();
  if (refresh) {
    $("#contact_list").bootstrapTable("refresh");
  }

}

function initContactGrid() {
  sms.contactGrid = $("#contact_list").bootstrapTable({
    method: "GET",
    //url: ctx + "/admin/operation/sms/users",
    data: [],
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    onLoadSuccess: function () {
      $("#table_list").bootstrapTable("uncheckAll");
    },
    queryParams: function (params) {
      var d = getFilterParam();
      d["pageSize"] = params.pageSize;
      d["pageNum"] = params.pageNum;
      return d;
    },
    pageSize: 10,
    checkboxHeader: false,
    clickToSelect: true,
    singleSelect: false,
    idField: "id",
    //数据列
    columns: [{
      title: "批次",
      field: "batch"
    }, {
      title: "手机号",
      field: "phone"
    }, {
      title: "昵称",
      field: "userNickName"
    }, {
      title: "最近登录时间",
      field: "lastLoginTime"
    }, {
      title: "短信接收次数",
      field: "sendNum"
    }]
  });
}

function hiddenOperateBtn(f) {
  if (f) {
    $("#save_btn").hide();
  } else {
    $("#save_btn").show();
  }
}

function setSendMode(v) {
  $("#smsSendMode").val(v);
}

function deleteSms(id) {
  layer.confirm('确定删除该短信？', {
    btn: ['确定', '取消']
  }, function () {
    $.ajax({
      url: ctx + "/admin/operation/sms?smsId=" + id,
      method: "delete",
      success: function (re) {
        layer.closeAll();
        refreshGrid();
      }
    });
  }, function () {

  });

}