

var mb = {
  selected: null, //选中节点
  isUpdate: false,
  initTree: function (param) { //初始化tree
    mb.tree = $("#region_tree").fancytree({
      extensions: [ "glyph", "clones"],
      source: {
        async: true,
        url: ctx + "/admin/region/serviceCount/tree",
        data: param
      },
      lazyLoad: function (event, data) {
        mb.treeParam["nodeId"] = data.node.refKey;
        data.result = {
          url: ctx + "/admin/region/serviceCount/tree",
          data: mb.treeParam
        };
      },
      click: function (event, data) {
        data.node.setActive(true);
        mb.selected = data.node;
        mb.clickNode(data.node);
      }
    });
    mb.tree.fancytree("getTree").setFocus(true);
    mb.tree.fancytree("getTree").visit(function(node){
      node.setExpanded();
    });
  },
  clickNode: function (node) { //点击节点
    if (node) {
      $("#regionId").val(node.key);
      tp.search();
    }
  }
};
var tp = {
  search: function () {
    var searchArgs = $("#search_form").serializeJSON();
    tableList.init(searchArgs);
  },
};

var tableList = {
  obj: $("#table_list"),
  init: function (searchArgs) {
    tableList.obj.bootstrapTable('destroy');
    tableList.obj.bootstrapTable({
      method: "GET",
      url: ctx + "/admin/service/distribution/all?regionId=" + (mb.selected == null ? "" : mb.selected.data.id),
      responseHandler: function (res) {
        return {
          "rows": res
        };
      },
      onLoadSuccess: function () {
        tableList.obj.bootstrapTable("uncheckAll");
        $(".fixed-table-pagination").hide();
      },
      checkboxHeader: false,
      clickToSelect: false,
      singleSelect: true,
      pageshow: false,
      idField: "id",
      //数据列
      columns: [{
        title: '产品分类',
        field: 'group',
        width: '20%',
        formatter: function (value, row, index) {
          var element = '<div class="col-xs-12 text-center">' +
            '                        <div class="panel padder-v item bg-primary">' +
            '                          <div class="h1 text-fff font-thin h3">'+row.groupName+'</div>' +
            '                          <span class="text-muted text-xs">'+row.groupCount+'</span>' +
            '                        </div>' +
            '                      </div>';
          return element;
        }
      },
        {
        title: '分布',
        field: 'deal',
        formatter: function (value, row, index) {
          var element = '';
          for(var i=0;i<row.productList.length;i++){
            element += '<div class="col-xs-3 text-center"><div class="panel padder-v item bg-info">'+ row.productList[i].productName + '（' + row.productList[i].count +'）</div></div>';
          }
          return element;
        }
      }
      ]
    });
  }
};
$(function () {
  mb.treeParam = {};
  mb.initTree(mb.treeParam);
  $("#region_tree ul").height(window.innerHeight * 2 / 3);
  tableList.init({});
});