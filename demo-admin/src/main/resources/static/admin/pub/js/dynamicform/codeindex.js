
var tp = {
  curId: '',
  search: function () {
    var searchArgs = $("#search_form").serializeJSON();
    tableList.init(searchArgs);
  },
  clearCondition: function () {
    document.searchForm.reset();
    tp.search();
  },
  openModal: function (type) {
    $("#codeModal").modal({
      backdrop: "static"
    });
    if(type == 'edit'){
      var selected = tableList.obj.bootstrapTable("getSelections");
      $("#code_form .form-control").each(function () {
        var $this = $(this);
        $this.val(selected[0][$this.attr("name")]);
      });
    } else {
      $("#code_form .form-control").each(function () {
        var $this = $(this);
        $this.val('');
      });
    }
  },
  typeSave: function () {
    if (!$("#code_form").valid()) {
      return;
    }
    var l = layer.load(1, {shade: 0.3});
    var params = $("#code_form").serializeJSON();
    $.post(ctx + "/admin/dynamicform/code", params, function (rs) {
      layer.close(l);
      if (rs.success) {
        $("#codeModal").modal("hide");
        tp.search();
      } else {
        layer.alert(rs.message, {icon: 2});
      }
    }, "json");
  },
  showData: function (code) {

  }
};

var tableList = {
  obj: $("#table_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/dynamicform/code",
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
        title: "编号",
        field: "code"
      }, {
        title: "标题",
        field: "title"
      }, {
        title: "开始日期",
        field: "beginTime"
      }, {
        title: "结束日期",
        field: "endTime"
      }, {
        title: "已收集数量",
        field: "count",
        formatter: function (value, row, index) {
          return '<button class="btn btn-info btn-xs" type="button" onclick="parent.index.showNav(\'/admin/dynamicform/index?code='+row.code+'\', true)">'+value+'</button>';
        }
      }
      ]
    });
  }
};
function initPlugins() {
  //日期范围限制
  var start = {
    elem: '#beginTime',
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
  tableList.init({});
  initPlugins();
});