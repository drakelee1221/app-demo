
var ms = {
  searching:false,
  clearSearch:function(){
    $("#search_form .form-control").val("");
    ms.search('table_list');
  },
  search:function(table){
    ms.searching = true;
    $('#' + table).bootstrapTable('refresh');
  }
};
$(function(){
  $("#table_list").bootstrapTable({
    method: "GET",
    url: ctx + "/admin/message/page",
    queryParams: function (params) {
      var num = ms.searching ? 1 : params.pageNum;
      ms.searching = false;
      var p = {
        pageSize: params.pageSize,
        pageNum: num
      };
      $("#search_form .form-control").each(function(){
        var v = $(this).val();
        if(v){
          p[this.name] = v;
        }
      });
      return p;
    },
    pageSize: 15,
    checkboxHeader: false,
    clickToSelect: true,
    singleSelect: false,
    idField: "id",
    //数据列
    columns: [{
      title: "接收用户",
      field: "userNickName"
    }, {
      title: "用户类型",
      field: "userTypeName"
    }, {
      title: "手机号",
      field: "phone"
    }, {
      title: "消息内容",
      field: "content"
    }, {
      title: "发送时间",
      field: "createTime"
    }, {
      title: "读取时间",
      field: "knowTime"
    }, {
      title: "状态",
      field: "status",
      formatter: function (value, row, index) {
        return "<label class='label label-"+(value === 1?"info":"warning")+"'>"+(value === 1?"已读":"未读")+"</label>"
      }
    }]
  });

});