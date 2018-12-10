/**
 * Created by Administrator on 2017/12/18 0018.
 */
var lineoption = {
  /*title: {
    text: '趋势图'
  },*/
  tooltip: {
    trigger: 'axis'
  },
  legend: {
    data: ['上传简历数']
  },
  grid: {
    x: 40,
    x2: 40,
    y2: 24
  },
  calculable: true,
  yAxis: [
    {
      type: 'value',
      axisLabel: {
        formatter: '{value}'
      }
    }
  ]
};
$(function () {
  $('#resume_upload_tab').on('shown.bs.tab', function (e) {
    refreshChart();
  });
  //用户上传的简历
  $("#upload_resume_list").bootstrapTable({
    method: "POST",
    contentType: "application/x-www-form-urlencoded",
    url: ctx+"/admin/user/resume/uploading",
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    queryParams: function (param) {
      return {
        userId: $("#userId").val(),
        pageSize: param.pageSize,
        pageNum: param.pageNum,
        keywords: $("#keywords").val(),
        level: $("#level").val(),
        downloadCount: $("#downloadCount").val(),
        startDate: $("#startDate").val(),
        endDate: $("#endDate").val()
      }
    },
    silent: true,
    //数据列
    columns: [{
      title: "姓名",
      field: "resumeName"
    }, {
      title: "获得优悦钱数量",
      field: "integral"
    }, {
      title: "创建时间",
      field: "createTime"
    }, {
      title: "下载次数",
      field: "downloadCount"
    }, {
      title: "简历星级",
      field: "level"
    }]
  });
  $("#task_list").bootstrapTable({
    method: "POST",
    contentType: "application/x-www-form-urlencoded",
    url: ctx+"/admin/user/task/list",
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    queryParams: function (param) {
      return {
        userId: $("#userId").val(),
        pageSize: param.pageSize,
        pageNum: param.pageNum
      }
    },
    silent: true,
    //数据列
    columns: [{
      title: "任务内容",
      field: "missionDesc"
    }, {
      title: "任务奖励",
      field: "awardVal"
    }, {
      title: "任务类型",
      field: "missionBizType",
      formatter: function (value, row, index) {
        if (value === 1) {//1 账号任务，2、每日任务，3简历任务
          return "账号任务";
        } else if (value === 2) {
          return "每日任务";
        } else if (value === 3) {
          return "简历任务";
        } else {
          return "";
        }
      }
    }]
  });
  $("#integral_detail_list").bootstrapTable({
    method: "POST",
    contentType: "application/x-www-form-urlencoded",
    url: ctx+"/admin/user/integral/list",
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    queryParams: function (param) {
      return {
        userId: $("#userId").val(),
        pageSize: param.pageSize,
        pageNum: param.pageNum
      }
    },
    silent: true,
    //数据列
    columns: [{
      title: "用途名称",
      field: "detailDesc"
    }, {
      title: "收入/支出",
      field: "integrals",
      formatter: function (value, row, index) {
        if (row.detailType === 0) {//1 账号任务，2、每日任务，3简历任务
          return "" + value;
        } else if (row.detailType === 1) {
          return "-" + value;
        } else {
          return "";
        }
      }
    }, {
      title: "时间",
      field: "detailTime"
    }]
  });
  //下载统计
  $("#download_resume_list").bootstrapTable({
    method: "POST",
    contentType: "application/x-www-form-urlencoded",
    url: ctx+"/admin/user/resume/downloading",
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    queryParams: function (param) {
      return {
        userId: $("#userId").val(),
        pageSize: param.pageSize,
        pageNum: param.pageNum
      }
    },
    silent: true,
    //数据列
    columns: [{
      title: "姓名",
      field: "resumeName"
    }, {
      title: "优悦钱数量",
      field: "integral"
    }, {
      title: "下载时间",
      field: "opTime"
    }, {
      title: "简历星级",
      field: "level"
    }]
  });
  //订单统计
  $("#order_list").bootstrapTable({
    method: "POST",
    contentType: "application/x-www-form-urlencoded",
    url: ctx+"/admin/user/order/list",
    responseHandler: function (res) {
      return {
        "rows": res.list,
        "total": res.total
      };
    },
    queryParams: function (param) {
      return {
        userId: $("#userId").val(),
        pageSize: param.pageSize,
        pageNum: param.pageNum
      }
    },
    silent: true,
    //数据列
    columns: [{
      title: "订单时间",
      field: "orderTime"
    }, {
      title: "商品名称",
      field: "commName"
    }, {
      title: "兑换价格",
      field: "price"
    }, {
      title: "订单号",
      field: "orderNo"
    }, {
      title: "快递公司",
      field: "express"
    }, {
      title: "快递编号",
      field: "expressNo"
    }, {
      title: "交易状态",
      field: "status",
      formatter: function (value, row, index) {
        if (value === '101') {//1 账号任务，2、每日任务，3简历任务
          return "废弃";
        } else if (value === '201') {
          return "已付款";
        } else if (value === '301') {
          return "已发货";
        } else {
          return "";
        }
      }

    }]
  });
});
function queryResume() {
  $("#upload_resume_list").bootstrapTable('refresh');
}
function refreshChart(){
  var days = $("#days").val();
  var lineChart = echarts.init(document.getElementById("echarts-line-chart"));

  $.ajax({
    url:ctx+"/admin/user/uploading/statistics",
    data:{
      userId:$("#userId").val(),
      days:days
    },
    dataType:'json',
    success:function(data){
      lineoption.xAxis = [
        {
          type: 'category',
          boundaryGap: false,
          data: data.xAxis
        }
      ];
      lineoption.series= [
        {
          name: '上传简历数',
          type: 'line',
          data: data.yAxis
        }
      ];
      lineChart.setOption(lineoption);
      $(window).resize(lineChart.resize);
    }
  });
}