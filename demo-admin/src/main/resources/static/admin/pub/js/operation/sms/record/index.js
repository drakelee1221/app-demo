/*
 * Copyright (c) 2017.mj.he800.com Inc. All rights reserved.
 */
var pi = {
  search: function () {
    var searchArgs = $("#record_search_form").serializeJSON();
    recordList.init(searchArgs);
  },
  clearCondition: function () {
    document.recordSearchForm.reset();
    pi.search();
  },
};

var recordList = {
  obj: $("#record_list"),
  init: function (searchArgs) {
    recordList.obj.bootstrapTable('destroy');
    recordList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/operation/sms/record/page",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        recordList.obj.bootstrapTable("uncheckAll");
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
        field: "templateName"
      }, {
        title: "发送手机",
        field: "phone"
      }, {
        title: "用户姓名",
        field: "userName"
      }, {
        title: "发送状态",
        field: "status",
        formatter: function (value, row, index) {
          switch (value) {
            case 0:
              return '未发送';
              break;
            case 1:
              return "发送成功";
              break;
            case 2:
              return "发送失败";
              break;
          }
        }
      }, {
        title: "发送时间",
        field: "sendTime"
      },{
        title: "创建时间",
        field: "createTime"
      }, {
        title: "备注信息",
        field: "remarks"
      },{
        title: "最近登录时间",
        field: "lastLoginTime",
        formatter: function (value, row, index) {
          if(value){
            return value.substring(0,10);
          }
        }
      },

      ]
    });
  }
};


//日期范围限制
var lastLoginStartDate = {
  elem: '#lastLoginStartDate',
  format: 'YYYY-MM-DD',
  istime: false,
  istoday: false
};
var lastLoginEndDate = {
  elem: '#lastLoginEndDate',
  format: 'YYYY-MM-DD',
  istime: false,
  istoday: false
};
laydate(lastLoginStartDate);
laydate(lastLoginEndDate);

function initRecord(){
  pi.search();
  $.get(ctx + "/admin/operation/sms/template", "", function (re) {
    for (var x = 0; x < re.length; x++) {
      var obj = re[x];
      $("#v_templateId").append("<option value='" + obj.templateId + "' params='" + (obj.params?obj.params:"") + "' content='" + obj.content + "' id='" + obj.templateId + "'>" + obj.title + "</option>");
    }

    $.get(ctx + "/admin/operation/sms/" + $("#smsId").val(), "", function (re) {
      $("#v_templateId").find("option[value='" + re.templateId + "']").attr("selected", true);
      templateChange(this,"v_");
      $("#v_remarks").val(re.remarks);
      $("#v_batch").val(re.batch);
      $("#v_paramJson").val(re.paramJson);
    })
  });
}

