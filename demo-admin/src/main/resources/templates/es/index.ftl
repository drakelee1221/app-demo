<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="row">
  <div class="col-sm-12">
    <div class="ibox ">
      <div class="ibox-title">
        <h5>ElasticSearch 全文索引管理</h5>
      </div>
      <div class="ibox-content">
        <div class="row">
          <div class="col-xs-12 font-bold">
            <p>Master Http Address：${esMasterHttpAddress!}</p>
            <p>All Transport Address：${esTransportAddress!}</p>
            <#if !esEnabled>
              <h4 class="text-danger">ElasticSearch 配置未开启（elasticsearch.enable = false）</h4>
            </#if>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12">
            <button class="btn btn-link" style="border:1px solid #888" type="button" onclick="esPage.preSearch()">
              <i class="fa fa-search"></i> 查询
            </button>
            <button class="btn btn-info" type="button" onclick="esPage.rebuildSoft()">
              <i class="fa fa-wrench"></i> 重构（Soft）
            </button>
            <button class="btn btn-warning" type="button" onclick="esPage.rebuildMixed()">
              <i class="fa fa-wrench"></i> 重构（Mixed）
            </button>
            <button class="btn btn-danger" type="button" onclick="esPage.rebuildHard()">
              <i class="fa fa-wrench"></i> 重构（Hard）
            </button>
            <button class="btn btn-default" type="button" onclick="$('#table_list').bootstrapTable('refresh');">
              <i class="fa fa-refresh"></i>
            </button>
          </div>
        </div>
        <div class="m-t">
          <table id="table_list"></table>
        </div>
      </div>
    </div>
  </div>


  <div class="col-sm-12">
    <div class="ibox ">
      <div class="ibox-title">
        <h5>索引查询：<b id="index_name"></b></h5>
      </div>
      <div class="ibox-content">
        <div class="row">
          <div class="col-xs-12 form-horizontal">
            <div class="col-xs-7">
              <label class="col-xs-4 control-label">搜索关键字（空格分隔）：</label>
              <div class="col-xs-8">
                <input class="form-control search-query" id="search_query">
              </div>
            </div>
            <div class="col-xs-5">
              <button class="btn btn-success" type="button" id="search_btn"
                      onclick="esPage.search()">
                <i class="fa fa-search"></i>
              </button>
              <button class="btn btn-default" type="button"
                      onclick="$('.search-query').val('');esPage.search();">
                <i class="fa fa-refresh"></i>
              </button>
            </div>
          </div>
        </div>
        <div class="m-t">
          <table id="search_table"></table>
        </div>
      </div>
    </div>
  </div>
</div>
</@htmlContent>

<@htmlJs>
<!-- Page-Level Scripts -->
<script type="text/javascript">
  var esPage = {
    searching:false,
    search:function(){
      esPage.searching = true;
      $('#search_table').bootstrapTable('refresh');
      esPage.searching = false;
    },
    refresh:function(){
      $("#table_list").bootstrapTable("refresh");
    },
    select:function(){
      var select = $("#table_list").bootstrapTable("getSelections");
      if(select.length !== 1){
        layer.alert('请选择一个索引');
        return null;
      }
      return select[0];
    },
    rebuildSoft:function(){
      var select = esPage.select();
      if(select){
        layer.confirm('soft模式重构索引['+select.indexName+'] - 以数据库为准更新重构索引？', {
          btn: ['是','否'],
          shade: 0.3
        }, function(){
          var index = layer.load(1);
          $.post("${ctx!}/admin/es/rebuild/"+select.indexName+"/soft",function(res){
            layer.close(index);
            layer.alert(res.message, {icon: res.success?1:2});
            esPage.refresh();
          });
        });
      }
    },
    rebuildMixed:function(){
      var select = esPage.select();
      if(select){
        layer.confirm('mixed模式重构索引['+select.indexName+'] - 去除索引中存在，但数据库中不存在的索引？', {
          btn: ['是','否'],
          shade: 0.3
        }, function(){
          var index = layer.load(1);
          $.post("${ctx!}/admin/es/rebuild/"+select.indexName+"/mixed",function(res){
            layer.close(index);
            layer.alert(res.message, {icon: res.success?1:2});
            esPage.refresh();
          });
        });
      }
    },
    rebuildHard:function(){
      var select = esPage.select();
      if(select){
        layer.confirm('hard模式重构索引['+select.indexName+'] - 删除索引并以数据库为准重构（慎用）？', {
          btn: ['是','否'],
          shade: 0.3
        }, function(){
          var index = layer.load(1);
          $.post("${ctx!}/admin/es/rebuild/"+select.indexName+"/hard",function(res){
            layer.close(index);
            layer.alert(res.message, {icon: res.success?1:2});
            esPage.refresh();
          });
        });
      }
    },
    searchParam:function(params) {
      if(esPage.searching){
        params.pageNum = 1;
      }
      return {
        pageSize: params.pageSize,
        pageNum: params.pageNum,
        query:$("#search_query").val().trim()
      };
    },
    preSearch:function(){
      var select = esPage.select();
      if(select) {
        var index = layer.load(1);
        $('#search_table').bootstrapTable('destroy');
        $("#index_name").html(select.indexName);
        $.get("${ctx!}/admin/es/fields/" + select.indexName, function (res) {
          layer.close(index);
          $("#search_table").bootstrapTable({
            url: "${ctx!}/admin/es/query/"+ select.indexName,
            pageSize: 10,
            queryParams: esPage.searchParam,
            columns:res
          });
        });
      }
    }
  };
  $(document).ready(function () {
    //初始化表格,动态从服务器加载数据
    $("#table_list").bootstrapTable({
      url: "${ctx!}/admin/es/list",
      onLoadSuccess: function () {
        $("#table_list").bootstrapTable("uncheckAll");
      },
      pageSize: 1000,
      checkboxHeader: false,
      clickToSelect: true,
      singleSelect: true,
      idField: "indexName",
      //数据列
      columns: [{
        checkbox: true
      }, {
        title: "索引名称",
        field: "indexName"
      }, {
        title: "文档Class",
        field: "entityClass"
      }, {
        title: "索引文档总数",
        field: "docsCount"
      }, {
        title: "DB数据总数",
        field: "dbCount"
      }]
    });

    $('#search_query').keydown(function(e){
      if(e.keyCode === 13){
        esPage.search();
      }
    });
  });
</script>
</@htmlJs>