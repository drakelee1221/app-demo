
var sd = {
  selectedServiceId: "",
  refreshData: function () {
    logList.init();
    servicerList.init();
    complainList.init();
    signList.init();
    infoList.init()
  }
};

var tableList = {
  obj: $("#service_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/service/page",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        tableList.obj.bootstrapTable("uncheckAll");
      },
      onCheck:function(row){
        sd.selectedServiceId = row.id;
        sd.refreshData();
      },
      queryParams: function (params) {
        var newParams = {
          userId: $("#userId").val(),
          serviceId: $("#serviceId").val(),
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
      },{
        title: "服务类型",
        field: "productTypeName"
      }, {
        title: "产品",
        field: "productName"
      }, {
        title: "企业名称",
        field: "companyName"
      }, {
        title: "用户",
        field: "phone"
      }, {
        title: "服务开始时间",
        field: "startTime"
      }, {
        title: "服务结束时间",
        field: "endTime"
      }, {
        title: "状态",
        field: "status",
        formatter: function (value, row, index) {
          if(value === 0) {
            return '未开始';
          } else if(value === 1){
            return '服务中';
          } else if(value === 2){
            return '已完结';
          } else if(value === 3){
            return '待续费';
          } else if(value === 4){
            return '驳回';
          }
        }
      },
      ]
    });
  }
};

var logList = {
  obj: $("#log_list"),
  init: function (searchArgs) {
    logList.obj.bootstrapTable('destroy');
    logList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/service/log",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        logList.obj.bootstrapTable("uncheckAll");
      },
      queryParams: function (params) {
        var newParams = {
          id: sd.selectedServiceId,
          pageSize: params.pageSize,
          pageNum: params.pageNum
        };
        return newParams;
      },
      pageSize: 10,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      idField: "id",
      //数据列
      columns: [{
        title: "会计专家",
        field: "nickName"
      }, {
        title: "内容",
        field: "content"
      },{
        title: "提交时间",
        field: "createTime"
      },{
        title: "客户操作",
        field: "knowStatus",
        formatter: function (value, row, index) {
          if(value === 0) {
            return '未读';
          } else if(value === 1) {
            return '已读';
          }
        }
      },

      ]
    });
  }
};
var servicerList = {
  obj: $("#servicer_list"),
  init: function (searchArgs) {
    servicerList.obj.bootstrapTable('destroy');
    servicerList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/service/servicer",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        servicerList.obj.bootstrapTable("uncheckAll");
      },
      queryParams: function (params) {
        var newParams = {
          id: sd.selectedServiceId,
          pageSize: params.pageSize,
          pageNum: params.pageNum
        };
        return newParams;
      },
      pageSize: 10,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      idField: "id",
      //数据列
      columns: [{
        title: "服务人员名称",
        field: "userNickName"
      }, {
        title: "电话",
        field: "phone"
      },{
        title: "服务人员类型",
        field: "userTypeName"
      },

      ]
    });
  }
};
var complainList = {
  obj: $("#complain_list"),
  init: function (searchArgs) {
    complainList.obj.bootstrapTable('destroy');
    complainList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/service/complain",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        complainList.obj.bootstrapTable("uncheckAll");
      },
      queryParams: function (params) {
        var newParams = {
          id: sd.selectedServiceId,
          pageSize: params.pageSize,
          pageNum: params.pageNum
        };
        return newParams;
      },
      pageSize: 10,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      idField: "id",
      //数据列
      columns: [{
        title: "类型",
        field: "type",
        formatter: function (value, row, index) {
          if(value === 0) {
            return '服务态度';
          } else if(value === 1) {
            return '服务质量';
          } else if(value === 2) {
            return '意见建议';
          } else if(value === 3) {
            return '其他';
          }
        }
      }, {
        title: "内容",
        field: "content"
      },{
        title: "提交时间",
        field: "createTime"
      },{
        title: "状态",
        field: "status",
        formatter: function (value, row, index) {
          if(value === 0) {
            return '待处理';
          } else if(value === 1) {
            return '已回复';
          } else if(value === 2) {
            return '完结';
          }
        }
      },{
        title: "处理内容",
        field: "disposeContent"
      },

      ]
    });
  }
};
var signList = {
  obj: $("#sign_list"),
  init: function (searchArgs) {
    signList.obj.bootstrapTable('destroy');
    signList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/product/service/sign",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        signList.obj.bootstrapTable("uncheckAll");
      },
      queryParams: function (params) {
        var newParams = {
          id: sd.selectedServiceId,
          pageSize: params.pageSize,
          pageNum: params.pageNum
        };
        return newParams;
      },
      pageSize: 10,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      idField: "id",
      //数据列
      columns: [{
        title: "服务时长",
        field: "serviceExpireMonths"
      }, {
        title: "时间段",
        field: "serviceTime"
      },{
        title: "签约时间",
        field: "contractTime"
      },{
        title: "服务状态",
        field: "contractStatus",
        formatter: function (value, row, index) {
          switch (value) {
            case 0: return'未开始';
            case 1: return'服务中';
            case 2: return'已完结';
            case 3: return'待续费';
            case 4: return'驳回';
            case 5: return'已过期';
            case 6: return'作废';
            case 7: return'冻结';
            case 8: return'已退款';
            default: return'';
          }
        }
      },

      ]
    });
  }
};
var infoList = {
  obj: $("#info_list"),
  init: function (searchArgs) {
    infoList.obj.bootstrapTable('destroy');
    infoList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/product/service/info",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        infoList.obj.bootstrapTable("uncheckAll");
      },
      queryParams: function (params) {
        var newParams = {
          serviceId: sd.selectedServiceId,
          pageSize: params.pageSize,
          pageNum: params.pageNum
        };
        return newParams;
      },
      pageSize: 15,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      idField: "id",
      //数据列
      columns: [{
        title: "分组名称",
        field: "groupName"
      }, {
        title: "定价项名称",
        field: "itemName"
      },{
        title: "单位",
        field: "unit",
        formatter: function (value, row, index) {
          switch (value){
            case '0':
              return "月";
            case '1':
              return "年";
            case '2':
              return "次";
            case '3':
              return "人";
          }
        }
      },{
        title: "定价项价格",
        field: "amount",
        formatter: function (value, row, index) {
          return formatNumber(value, 2);
        }
      },{
        title: "实际价格",
        field: "quantity",
        formatter: function (value, row, index) {
          return formatNumber(value, 2);
        }
      },

      ]
    });
  }
};
$(function () {
  tableList.init({});
});