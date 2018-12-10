
var pi = {
  getSelectedRow: function () {
    var selectedAll = tableList.obj.bootstrapTable("getSelections");
    var selectedRow = null;
    if (selectedAll.length > 0) {
      selectedRow = selectedAll[0];
    }
    return selectedRow;
  },
  search: function () {
    tableList.obj.bootstrapTable("refresh");
  },
  clearCondition: function () {
    document.conditionForm.reset();
    pi.search();
  },
  detail: function (id) {
    $("#detailModal").modal({
      backdrop: "static"
    });
    $("#detailModal").css("padding", "0px");
    var t_height = $(document).height();
    var h_height = $(".modal-header").height();
    $("#detailIframe").css("height", t_height - h_height - 35);
    $("#detailIframe").attr("src", ctx + "/admin/user/manager/detail?id=" + id);
  },
};

var tableList = {
  obj: $("#table_list"),
  init: function () {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/user/manager/listpage",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      onLoadSuccess: function () {
        tableList.obj.bootstrapTable("uncheckAll");
      },
      //初始化时的排序字段
      sortName:'registTime',
      sortOrder: 'desc',
      sortStable:true,
      queryParams: function (params) {
        var newParams = {
          pageSize: params.pageSize,
          pageNum: params.pageNum,
          sortName: this.sortName,
          sortOrder: this.sortOrder
        };
        var searchArgs = $("#conditionForm").serializeJSON();
        for (var key in searchArgs) {
          newParams[key] = searchArgs[key];
        }
        return newParams;
      },
      onSort:function(name, order){
        $.bootstrapTableCustomOnSort("table_list", name);
      },
      pageSize: 15,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      sortable: true,
      idField: "id",
      //数据列
      columns: [{
        title: "头像",
        field: "avatar",
        align:"center",
        formatter: function (value, row, index) {
          var url = "/admin/img/avatar.jpg";
          if (row.avatar) {
            url = row.avatar;
          } else if (row.wxImg) {
            url = row.wxImg;
          }
          return '<img class="img-circle" id="avatar" style="width:30px" src="' + url + '"/>'
        }
      },{
        title:"来源",
        field:"dataSource",
        formatter:function (value) {
          if(value == 1){
            return "移动端";
          }else{
            return "PC端";
          }
        }
      }, {
        title: "手机号",
        field: "phone"
      }, {
        title: "昵称",
        field: "userNickName"
      }, {
        title: "微信名",
        field: "wxName"
      }, {
        title: "QQ",
        field: "userQq"
      }, {
        title: "企业名称",
        field: "companyName"
      }, {
        title: "企业地址",
        field: "address"
      }, {
        title: "注册时间",
        field: "registTime",
        sortable : true
      },{
        title: "最后登录时间",
        field: "lastLoginTime",
        sortable : true
      },{
        title:"地区",
        field:"registRegion"
      }, {
        title: "状态",
        field: "status",
        formatter: function (value, row, index) {
          switch (value) {
            case 0:
              return '限制登陆';
              break;
            case 1:
              return "正常";
              break;
          }
        }
      }, {
        title: "操作",
        field: "deal",
        formatter: function (value, row, index) {
          return '<button onclick="pi.detail(\'' + row.id + '\')" type="button" class="btn btn-success btn-xs"><i class="fa fa-search"></i>查看详情</button>';
        }
      }]
    });
  }
};

$(function () {
  tableList.init();
  window.onresize = function () {
    $("#detailModal").css("padding", "0px");
  };
  //日期范围限制
  var start = {
    elem: '#registTimeStart',
    format: 'YYYY-MM-DD hh:mm:ss',
    istime: true,
    istoday: true,
    isclear: false,
    choose: function (datas) {
      end.min = datas; //开始日选好后，重置结束日的最小日期
      // end.start = datas //将结束日的初始值设定为开始日
    }
  };
  var end = {
    elem: '#registTimeEnd',
    format: 'YYYY-MM-DD hh:mm:ss',
    istime: true,
    istoday: true,
    isclear: false,
    choose: function (datas) {
      start.max = datas; //结束日选好后，重置开始日的最大日期
    }
  };
  laydate(start);
  laydate(end);
});