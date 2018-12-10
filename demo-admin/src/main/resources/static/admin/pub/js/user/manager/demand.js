
var dm = {
  detail: function () {
    var selectedRow = dm.getSelectedRow();
    if (selectedRow == null) {
      layer.alert("请选择一行", {icon: 1});
      return;
    }
    dm.openModal();
    $('#cooperation_form').find("input").val("");
    if (selectedRow) {
      for (var i in selectedRow) {
        var input = $('#cooperation_form').find("#" + i);
        input.val(selectedRow[i]);
        input.attr("readonly","readonly");
      }
    }
    $("#thumbnail").attr("src",selectedRow.thumbnail);
  },
  openModal: function () {
    $("#demandModal").modal({
      backdrop: "static"
    });
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
    var searchArgs = $("#demandForm").serializeJSON();
    tableList.init(searchArgs);
  },
  clearCondition: function () {
    document.demandForm.reset();
    dm.search();
  },
  deal: function (status) {
    var selectedRow = dm.getSelectedRow();
    if (selectedRow == null) {
      layer.alert("请选择一行", {icon: 1});
      return;
    }
    var params = {
      status: status,
      id: selectedRow.id
    }
    var cmsg = "";
    if (status == '1') {
      cmsg = "确定要通过：" + selectedRow.title + "吗？";
    }
    if (status == '2') {
      cmsg = "确定要驳回：" + selectedRow.title + "吗？";
    }
    if (status == '4') {
      cmsg = "确定要下线：" + selectedRow.title + "吗？";
    }
    var index = layer.confirm(cmsg, {
      btn: ['确定', '取消'],
      shade: 0.3
    }, function () {
      var l = layer.load(1, {shade: 0.3});
      $.post(ctx + "/admin/operation/cooperation/info/deal", params, function (rs) {
        layer.close(l);
        layer.close(index);
        if (rs.success) {
          layer.msg(rs.message, {icon: 1, time: 500});
          dm.search();
        } else {
          layer.alert(rs.message, {icon: 2});
        }
      }, "json");
    });
  }

};

var serviceDate;
var tableList = {
  obj: $("#demand_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/operation/cooperation/info/listpage",
      responseHandler: function (res) {
        serviceDate = res.date;
        return {
          "rows": res.data.list,
          "total": res.data.total
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
        title: "供需类型",
        field: "type",
        formatter: function (value, row, index) {
          return value == 0 ? '需求' : '供应';
        }
      }, {
        title: "需求分类",
        field: "categoryName"
      }, {
        title: "用户",
        field: "phone"
      }, {
        title: "缩略图",
        field: "thumbnail",
        formatter:function (value, row, index) {
            var val = "<img  class='img-circle' style='width: 18px;height: 18px;' src='" + value + "'><a href='"+ value +"' target='_blank'>查看大图</a>";
            return val;
        }
      }, {
        title: "标题",
        field: "title"
      }, {
        title: "内容",
        field: "content"
      }, {
        title: "提交时间",
        field: "createTime"
      }, {
        title: "剩余天数",
        field: "expireDay",
        formatter: function (value, row, index) {
          var s1 = new Date(row.expireTime);
          var s2 = new Date(serviceDate);
          var time = s1.getTime() - s2.getTime();
          var days = parseInt(time / (1000 * 60 * 60 * 24));
          return (value - days) + '天';
        }
      }, {
        title: "备注",
        field: "remark"
      }, {
        title: "状态",
        field: "status",
        formatter: function (value, row, index) {
          switch (value) {
            case 0:
              return '未审核';
              break;
            case 1:
              return "通过";
              break;
            case 5:
              return "驳回";
              break;
            case 2:
              return "已上线";
              break;
            case 4:
              return "已下线";
              break;
            case 3:
              return "已过期";
              break;
          }
        }
      },

      ]
    });
  }
};


function initPlugins() {
  //日期范围限制
  var start = {
    elem: '#demandStartDate',
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
    elem: '#demandEndDate',
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


  //下拉框搜索
  var config = {
    '.chosen-select': {},
    '.chosen-select-deselect': {
      allow_single_deselect: true
    },
    '.chosen-select-no-single': {
      disable_search_threshold: 10
    },
    '.chosen-select-no-results': {
      no_results_text: '无此搜索值!'
    },
    '.chosen-select-width': {
      width: "95%"
    }
  }
  for (var selector in config) {
    $(selector).chosen(config[selector]);
  }

}


$(function () {
  dm.search();
  initPlugins();
});