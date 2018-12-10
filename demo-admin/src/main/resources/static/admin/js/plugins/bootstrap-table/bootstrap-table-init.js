

(function(){
  jQuery.extend(
    jQuery.fn.bootstrapTable.defaults,
    {
      //表格显示条纹
      striped: true,
      //启动分页
      pagination: true,
      //每页显示的记录数
      pageSize: 15,
      //当前第几页
      pageNum: 1,
      //记录数可选列表
      pageList: [5, 10, 15, 20, 25],
      //是否启用查询
      search: false,
      //表示服务端请求
      sidePagination: "server",
      //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
      //设置为limit可以获取limit, offset, search, sort, order
      queryParamsType: "undefined",
      contentType: "application/json",
      responseHandler: function (res) {
        return {
          "rows": res.list,
          "total": res.total
        };
      },
      queryParams: function (params) {
        return {
          pageSize: params.pageSize,
          pageNum: params.pageNum
        };
      }
    }
  );
  /** 将只有asc、desc的两种方式的排序，改为asc、desc、不排序 三种方式 */
  jQuery.bootstrapTableCustomOnSort = function(tableId, sortName){
    var table = $("#"+tableId).data("bootstrap.table");
    if(table != null){
      var f = $("#"+tableId+" [data-field='"+sortName+"'] .sortable");
      if(f.length > 0){
        if(f.hasClass("desc") && table.options.sortOrder === "asc"){
          table.options.sortName = null;
          table.options.sortOrder = null;
        }
      }
    }
  };
})();