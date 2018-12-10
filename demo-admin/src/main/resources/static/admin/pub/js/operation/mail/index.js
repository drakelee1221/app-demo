

$(function () {

  $("#table_list").bootstrapTable({
    method: "GET",
    url: ctx + "/admin/operation/mail/pages",
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
      title: "标题",
      field: "subject"
    }, {
      title: "数量",
      field: "count"
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
            return '已发送';
        }
      }
    }, {
      title: "备注",
      width: "30%",
      field: "remark"
    }, {
      title: "操作",
      formatter: function (value, row, index) {
        var send = "<button class=\"btn btn-primary btn-xs\" onclick=\"sendMail('" + row.id + "')\"><i class='fa fa-send'></i>发送</button>";
        return "<button class=\"btn btn-success btn-xs\" onclick=\"viewContent('" + row.id + "')\">查看详情</button>&nbsp;&nbsp;" + send;
      }
    }]
  });
});
//日期范围限制
var start = {
  elem: '#startDate',
  format: 'YYYY-MM-DD',
  istime: true,
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

function sendMail(id) {

}

function viewContent(id) {
  $.get(ctx + "/admin/operation/mail/" + id, "", function (re) {
    $("#id").val(re.id);
    $("#subject").val(re.subject);
    $("#addressee").val(re.addressee);
    $("#remarks").val(re.remarks);
    var ue = UE.getEditor("content");
    ue.ready(function () {
      //设置编辑器的内容
      ue.setContent(re.content);
    });
    $("#createMailModal").modal();
  })
}

function createMail() {
  $("#mail_form")[0].reset();
  $("#createMailModal").modal();
}

function saveMail() {
  var l = layer.load(1, {shade: 0.3});
  $.post(ctx + "/admin/operation/mail", $("#mail_form").serialize(), function (rs) {
    layer.close(l);
    if (rs.success) {
      refreshGrid();
      layer.alert("保存成功", {icon: 1});
    } else {
      layer.alert(rs.message, {icon: 1});
    }
  }, "json");
}

function saveMailBox() {
  var l = layer.load(1, {shade: 0.3});
  $.post(ctx + "/admin/operation/mail/server", $("#mailbox_form").serialize(), function (rs) {
    layer.close(l);
    if (rs.success) {
      layer.alert("保存成功", {icon: 1});
    } else {
      layer.alert(rs.message, {icon: 1});
    }
  }, "json");
}

function configServer() {
  $("#mailbox_form")[0].reset();

  $.get(ctx + "/admin/operation/mail/server", "", function (re) {
    $("#box_id").val(re.id);
    $("#address").val(re.address);
    $("#smtp").val(re.smtp);
    $("#password").val(re.password);
    $("#sign").val(re.sign);
    $("#mailBoxModal").modal();
  })
}

function sendMail(id) {
  var l = layer.load(1, {shade: 0.3});
  $.post(ctx + "/admin/operation/mail/send", {id: id}, function (rs) {
    layer.close(l);
    if (rs.success) {
      layer.alert("发送完成", {icon: 1});
    } else {
      layer.alert(rs.message, {icon: 2});
    }
  }, "json");

}