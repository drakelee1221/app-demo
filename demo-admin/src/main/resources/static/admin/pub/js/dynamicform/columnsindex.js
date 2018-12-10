
var tp = {
  curId: '',
  curIndex: 0,
  search: function () {
    var searchArgs = $("#search_form").serializeJSON();
    tableList.init(searchArgs);
  },
  clearCondition: function () {
    document.searchForm.reset();
    tp.search();
  },
  openModal: function (type) {
    $('#jsonData_group .input-daterange').remove();
    if(type == 'edit'){
      var selected = tableList.obj.bootstrapTable("getSelections");
      if(selected.length < 1){
        layer.alert('请选择一行数据');
        return;
      }
      $("#columnsModal").modal({
        backdrop: "static"
      });
      $("#columns_form #code").val(selected[0]['code']);
      $("#columns_form #id").val(selected[0]['id']);
      var jsonData = JSON.parse(selected[0]['jsonData'])
      for(var index in jsonData){
        var cur = jsonData[index];
        tp.appendDiv(index, cur['field'],cur['title']);
      }
    } else {
      $("#columnsModal").modal({
        backdrop: "static"
      });
      $("#columns_form #code").val('');
      $("#columns_form #id").val('');
      tp.appendDiv(0, '','');
    }
  },
  appendDiv: function (index, englishVal, ChineseVal) {
    var id = 'jsonDataDiv_'+index;
    $('#jsonData_group').append(
      '           <div class="input-daterange input-group m-b" id="'+id+'">\n' +
      '              <input type="text" class="input-sm form-control" name="english" placeholder="字段英文名" value="'+englishVal+'">\n' +
      '              <span class="input-group-addon">-></span>\n' +
      '              <input type="text" class="input-sm form-control" name="chinese" placeholder="字段中文名" value="'+ChineseVal+'">\n' +
      '              <span class="input-group-addon cursor-pointer" style="background-color:red;color:white" onclick="tp.removeDiv(\''+id+'\')"> \n' +
      '                 <span class="fa fa-minus"></span>\n' +
      '              </span>\n' +
      '            </div>'
    )
    tp.curIndex = index;
  },
  typeSave: function () {
    if (!$("#columns_form").valid()) {
      return;
    }
    var l = layer.load(1, {shade: 0.3});
    var code = $('#columns_form #code').val();
    var id = $('#columns_form #id').val();
    var arr = new Array();
    $('#columns_form .input-daterange').each(function () {
      var id = $(this).attr('id');
      arr.push({
        field: $('#'+id+' input[name="english"]').val(),
        title: $('#'+id+' input[name="chinese"]').val()
      })
    })
    $.post(ctx + "/admin/dynamicform/columns", {id: id,code: code, jsonData: JSON.stringify(arr)}, function (rs) {
      layer.close(l);
      if (rs.success) {
        $("#columnsModal").modal("hide");
        tp.search();
      } else {
        layer.alert(rs.message, {icon: 2});
      }
    }, "json");
  },
  removeDiv: function (id) {
    if(id === 'jsonDataDiv_0'){
      $('#'+id).find('input').each(function(){$(this).val('')})
    } else {
      $('#'+id).remove();
    }
  },
  addColumns: function () {
    tp.curIndex = parseInt(tp.curIndex) + 1;
    tp.appendDiv(tp.curIndex, '','');
  }
};

var tableList = {
  obj: $("#table_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/dynamicform/columns/page",
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
        title: "字段数据",
        field: "jsonData",
        formatter: function (value, row, index) {
          var str = '';
          var jsonData = JSON.parse(value);
          for(var index in jsonData){
            str += '<span class="label label-primary">'+jsonData[index]["title"]+'</span> &nbsp;&nbsp;';
          }
          return str;
        }
      }
      ]
    });
  }
};

$(function () {
  tableList.init({});
});