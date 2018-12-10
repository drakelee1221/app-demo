

var scs = {
  searching:false,
  consultId:"",
  clearSearch:function(){
    $("#consult_search_form .search-input").val("");
    scs.search();
  },
  search:function(){
    scs.searching = true;
    $('#consult_list').bootstrapTable('refresh');
  },
  showAnswer:function(id, name){
    scs.consultId = id;
    $('#answerer_list').bootstrapTable('refresh');
    $("#answer_modal").modal();
  }
};
$(function () {
  $("#consult_list").bootstrapTable({
    method: "GET",
    url: ctx + "/admin/service/consult/page",
    queryParams: function (params) {
      var num = scs.searching ? 1 : params.pageNum;
      scs.searching = false;
      var p = {
        pageSize: params.pageSize,
        pageNum: num
      };
      $("#consult_search_form .form-control").each(function(){
        var v = $(this).val();
        if(v){
          p[this.name] = v;
        }
      });
      return p;
    },
    pageSize: 15,
    checkboxHeader: false,
    clickToSelect: false,
    singleSelect: false,
    idField: "id",
    //数据列
    columns: [{
      title: "产品名称",
      field: "productName"
    }, {
      title: "发起人",
      field: "userName"
    }, {
      title: "发起人手机",
      field: "userPhone"
    }, {
      title: "受理人",
      field: "answererName"
    }, {
      title: "受理人手机",
      field: "answererPhone"
    }, {
      title: "咨询内容",
      field: "content"
    }, {
      title: "发起时间",
      field: "createTime"
    }, {
      title: "回复数",
      field: "answerCount",
      formatter: function (value, row, index) {
        if(value === 0){
          return "<label class='label label-danger'>未回复</label>";
        }
        return "<button class='btn btn-info btn-xs' onclick='scs.showAnswer(\""+row.id+"\");return false;'>" +
          "<b> "+value+" </b></button>";
      }
    }]
  });
  $("#answerer_list").bootstrapTable({
    method: "GET",
    url: ctx + "/admin/service/consult/answers",
    queryParams: function (params) {
      return {
        responseId: scs.consultId,
        pageSize: params.pageSize,
        pageNum: params.pageNum
      };
    },
    pageSize: 5,
    checkboxHeader: false,
    clickToSelect: true,
    singleSelect: false,
    idField: "id",
    //数据列
    columns: [{
      title: "产品名称",
      field: "productName"
    }, {
      title: "回复人",
      field: "userName"
    }, {
      title: "回复手机",
      field: "userPhone"
    }, {
      title: "咨询内容",
      field: "content"
    }, {
      title: "回复时间",
      field: "createTime"
    }]
  });

});