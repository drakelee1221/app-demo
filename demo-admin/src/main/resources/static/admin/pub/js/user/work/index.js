
var tp = {
  search: function () {
    var searchArgs = $("#search_form").serializeJSON();
    tableList.init(searchArgs);
  },
  clearCondition: function () {
    document.searchForm.reset();
    tp.search();
  },

};

var tableList = {
  obj: $("#table_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/user/work/page",
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
      pageList: [15, 25, 50, 100, 150, 500, 10000],
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      showExport: true, //显示导出
      exportDataType: 'all', // 导出数据 basic-当前页， all-所有，selected-选择
      exportTypes: ['excel'], // 导出数据类型
      exportOptions: {
        ignoreColumn: [0], // 忽略第一列id
        fileName: '工作状态切换日志' //文件名字
      },
      showColumns: true,

      idField: "id",
      //数据列
      columns: [{
        checkbox: true
      }, {
        title: "姓名",
        field: "userNickName"
      }, {
        title: "切换后状态",
        field: "afterWorkStatus",
        formatter: function (value, row, index) {
          if(value === 0) {
            return '<span style="color: red">关</span>';
          } else if(value === 1){
            return '<span style="color: green">开</span>';
          }
        }
      }, {
        title: "切换时间",
        field: "createTime"
      }, {
        title: "操作人",
        field: "creator"
      },
      ]
    });
  }
};

function initPlugins() {
  //日期范围限制
  var start = {
    elem: '#startTime',
    format: 'YYYY-MM-DD hh:mm:ss',
    //: laydate.now(), //设定最小日期为当前日期
    //max: '2099-06-16 23:59:59', //最大日期
    istime: true,
    istoday: false,
    choose: function (datas) {
      end.min = datas; //开始日选好后，重置结束日的最小日期
      end.start = datas //将结束日的初始值设定为开始日
    }
  };
  var end = {
    elem: '#endTime',
    format: 'YYYY-MM-DD hh:mm:ss',
    //min: laydate.now(),
    //max: '2099-06-16 23:59:59',
    istime: true,
    istoday: false,
    choose: function (datas) {
      start.max = datas; //结束日选好后，重置开始日的最大日期
    }
  };

  laydate(start);
  laydate(end);

}
$(function () {
  tableList.init(tp.search());
  initPlugins();

});