
var tp = {
  curId: '',
  search: function () {
    var searchArgs = $("#search_form").serializeJSON();
    tableList.init(searchArgs);
  },
  searchChild: function () {
    var type = $('#type').val();
    if(!type){
      layer.alert("请选择一种类型");
      return;
    }
    childList.init(type);
  },
  clearCondition: function () {
    document.searchForm.reset();
    tp.search();
  },
  openChildModal: function (id, type) {
    childList.obj.bootstrapTable('destroy');
    tp.curId = id;
    $("#childModal").modal();
    var l = layer.load(1, {shade: 0.3});
    $.get(ctx + "/admin/dynamicform/type?code=" + tableList.curCode, function (rs) {
      layer.close(l);
      var parse = JSON.parse(rs);
      $('option[name="customOption"]').remove();
      for(var i=0;i<parse.length;i++){
        $("#type").append('<option value="'+parse[i]+'" name="customOption">'+parse[i]+'</option>');
      }
      if(type){
        childList.init(type);
      }
    }, "text");
  }
};

var tableList = {
  obj: $("#table_list"),
  params: [],
  curCode: '',
  init: function (searchArgs) {
    var code = '';
    if(searchArgs['code']){
      code = searchArgs['code'];
    }
    $.ajax({
      type: "GET",
      url: "/admin/dynamicform/columns?code="+code,
      contentType: "application/json;charset=utf-8",
      dataType: "json",
      json: 'callback',
      success: function (json) {
        if(code !== tableList.curCode){
          tableList.curCode = code;
          $('div[name="otherqueryform"]').remove();
          for (var index in json){
            if("createTime" !== json[index].field && "title" !== json[index].field ){
              // 添加搜索条件
              $('#otherquery').after('        <div class="form-group" name="otherqueryform">\n' +
                '          <label for="title" class="sr-only">'+json[index].title+'</label>\n' +
                '          <input type="text" placeholder="'+json[index].title+'" name="'+json[index].field+'" id="'+json[index].field+'" class="form-control">\n' +
                '        </div>');
            }
          }
        }
        json.push({
          title: "附属信息",
          field: "deal",
        formatter: function (value, row, index) {
            var str = '';
            for(var key in row){
              if(key.indexOf('count_') === 0){
                var keystr = key.replace('count_','');
                str += '<button class="btn btn-info btn-xs" type="button" onclick="tp.openChildModal(\'' + row.id + '\', \''+keystr+'\')">'+keystr+'('+row[key]+')</button> &nbsp;&nbsp;';
              }
            }
            return str;
          }
        })
        tableList.obj.bootstrapTable('destroy').bootstrapTable({
            method: "GET",
            url: ctx + "/admin/dynamicform/page",
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
            columns: json

        });
      }
    });

  }
};

var childList = {
  obj: $("#child_list"),
  init: function (type) {
    $.ajax({
      type: "GET",
      url: "/admin/dynamicform/child/columns?code="+tableList.curCode+"&type="+type,
      contentType: "application/json;charset=utf-8",
      dataType: "json",
      json: 'callback',
      success: function (json) {
        childList.obj.bootstrapTable('destroy').bootstrapTable({
            method: "GET",
            url: ctx + "/admin/dynamicform/child?id="+tp.curId+"&type="+type,
            responseHandler: function (res) {
              return {
                "rows": res
              };
            },
            onLoadSuccess: function () {
              childList.obj.bootstrapTable("uncheckAll");
            },
            pageSize: 15,
            checkboxHeader: false,
            clickToSelect: true,
            singleSelect: true,
            pagination: false,
            idField: "id",
            //数据列
            columns: json

        });
      }
    });

  }
};

$(function () {
  tp.search();
});