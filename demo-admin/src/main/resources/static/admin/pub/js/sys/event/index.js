
var eventHandle = {
  obj: $("#event_handle"),
  init: function (searchArgs) {
    eventHandle.obj.bootstrapTable('destroy');
    eventHandle.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/event/handle/page",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        eventHandle.obj.bootstrapTable("uncheckAll");
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
      pageSize: 10,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      idField: "id",
      //数据列
      columns: [{
        title: "监听者",
        field: "listenerId"
      }, {
        title: "监听者class",
        field: "listenerClass"
      }, {
        title: "是否完成",
        field: "hasDone",
        formatter: function (value, row, index) {
          if(value === 0) {
            return '未完成';
          } else {
            return '已完成';
          }
        }
      }, {
        title: "完成host",
        field: "doneHost"
      }, {
        title: "完成服务",
        field: "doneServer"
      }, {
        title: "完成时间",
        field: "doneTime"
      }, {
        title: "异常时间",
        field: "errorTime"
      }, {
        title: "异常信息",
        field: "errorStack"
      }
      ]
    });
  }
};

$(function () {
  if(messageChannels){
    var c =  $("#channel");
    for(var i in messageChannels){
      var arr = i.split(".");
      c.append("<option value='"+i+"'>"+ arr[arr.length-1] + " - " +messageChannels[i]+"</option>");
    }
  }
  $("#table_list").bootstrapTable({
    method: "GET",
    url: ctx + "/admin/event/list",
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    onCheck: function (row) {
      eventHandle.init({messageId:row.id});
    },
    onLoadSuccess: function () {
      $("#table_list").bootstrapTable("uncheckAll");
    },
    queryParams: function (params) {
      if(searching){
        params.pageNum = 1;
      }
      return {
        pageSize: params.pageSize,
        pageNum: params.pageNum,
        hasDone: $("#hasDone").val(),
        startDate: $("#startDate").val(),
        endDate: $("#endDate").val(),
        channel: $("#channel").val()
      };
    },
    pageSize: 10,
    checkboxHeader: false,
    clickToSelect: true,
    singleSelect: true,
    idField: "id",
    //数据列
    columns: [{
      checkbox: true
    }, {
      field: "channel",
      title: "事件"
    }, {
      field: "channelInfo",
      title: "事件名",
      formatter: function (value, row, index) {
        var arr = row.channel.split("@")[0];
        var typeArr = arr.split(".");
        return typeArr[typeArr.length-1] + " - " + messageChannels[arr];
      }
    }, {
      field: "createTime",
      title: "触发时间"
    }, {
      field: "eventInfoJson",
      title: "eventInfoJson",
      width: "30%"
    }, {
      field: "remark",
      title: "备注"
    }]
  });
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
var searching = false;
function refreshGrid() {
  searching = true;
  $("#table_list").bootstrapTable("refresh");
  searching = false;
}

function clearCondition() {
  document.searchForm.reset();
  $("#table_list").bootstrapTable("refresh");
}
