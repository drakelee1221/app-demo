<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="row">
  <div class="col-sm-12">
    <div class="ibox ">
      <div class="ibox-title">
        <h5>调度作业管理</h5>
      </div>
      <div class="ibox-content">
        <div class="row">
          <div class="col-xs-12 font-bold">
            <p>已启动的作业服务：${((taskServers?size) == 0)? string('<span class="text-danger">无服务，请启动至少一个服务','')}</p>
            <#list taskServers as task>
              <p><a href="${task.uri}/info" target="_blank">${task.host}:${task.port?c}</a></p>
            </#list>
            <br/>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12">
            <button class="btn btn-link" style="border:1px solid #888" type="button" onclick="taskPage.findLogs()">
              <i class="fa fa-file-text"></i> 日志
            </button>
            <button class="btn btn-success" type="button" onclick="taskPage.edit()">
              <i class="fa fa-edit"></i> 修改
            </button>
            <button class="btn btn-info" type="button" onclick="taskPage.trigger()">
              <i class="fa fa-rocket"></i> 执行
            </button>
            <button class="btn btn-primary" type="button" onclick="taskPage.enable()">
              <i class="fa fa-check-circle"></i> 启用
            </button>
            <button class="btn btn-warning" type="button" onclick="taskPage.disable()">
              <i class="fa fa-minus-circle"></i> 禁用
            </button>
            <button class="btn btn-danger" type="button" onclick="taskPage.rebuild()">
              <i class="fa fa-wrench"></i> 重构
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
        <h5>调度作业日志</h5>
      </div>
      <div class="ibox-content">
        <div class="row">
          <div class="col-xs-12 form-horizontal">
            <div class="col-xs-4">
              <label class="col-xs-4 control-label">ID：</label>
              <div class="col-xs-8">
                <input class="form-control logs-search" id="logs_taskId">
              </div>
            </div>
            <div class="col-xs-5">
              <label class="col-xs-4 control-label">日期：</label>
              <div class="col-xs-4">
                <input class="form-control layer-date logs-search" placeholder="起始日期" readonly
                       id="logs_timeS"
                       onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
              </div>
              <div class="col-xs-4">
                <input class="form-control layer-date logs-search" placeholder="截止日期" readonly
                       id="logs_timeE"
                       onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
              </div>
            </div>
            <div class="col-xs-3">
              <button class="btn btn-success" type="button"
                      onclick="$('#log_table').bootstrapTable('refresh');">
                <i class="fa fa-search"></i>
              </button>
              <button class="btn btn-default" type="button"
                      onclick="$('.logs-search').val('');$('#log_table').bootstrapTable('refresh');">
                <i class="fa fa-refresh"></i>
              </button>
            </div>
          </div>
        </div>
        <div class="m-t">
          <table id="log_table"></table>
        </div>
      </div>
    </div>
  </div>
</div>
</@htmlContent>

<@htmlJs>
<!-- Page-Level Scripts -->
<script type="text/javascript">
  var taskPage = {
    refresh:function(){
      $("#table_list").bootstrapTable("refresh");
    },
    select:function(){
      var select = $("#table_list").bootstrapTable("getSelections");
      if(select.length !== 1){
        layer.alert('请选择一个调度作业');
        return null;
      }
      return select[0];
    },
    findLogs:function(){
      var select = taskPage.select();
      if(select){
        $("#logs_taskId").val(select.id);
        $('#log_table').bootstrapTable('refresh');
      }
    },
    edit: function () {
      var select = taskPage.select();
      if(select){
        layer.open({
          type: 2,
          title: '修改调度作业',
          shadeClose: true,
          shade: false,
          area: ['100%', '100%'],
          content: '${ctx!}/admin/task/edit/'+select.id,
          end: function(index){
            taskPage.refresh();
          }
        });
      }
    },
    enable:function(){
      var select = taskPage.select();
      if(select){
        layer.confirm('是否将['+ select.name + "]设为启用并同步更新到所有服务中？", {
          btn: ['是','否'],
          shade:0.3
        }, function(){
          var index = layer.load(1);
          $.post("${ctx!}/admin/task/enable/" + select.id,function(res){
            layer.close(index);
            layer.alert(res.message, {icon: res.success?1:2});
            taskPage.refresh();
          });
        });
      }
    },
    disable:function(){
      var select = taskPage.select();
      if(select){
        layer.confirm('是否将['+ select.name + "]设为禁用并同步更新到到所有服务中？", {
          btn: ['是','否'],
          shade:0.3
        }, function(){
          var index = layer.load(1);
          $.post("${ctx!}/admin/task/disable/" + select.id,function(res){
            layer.close(index);
            layer.alert(res.message, {icon: res.success?1:2});
            taskPage.refresh();
          });
        });
      }
    },
    trigger:function(){
      var select = taskPage.select();
      if(select){
        if(select.disabled){
          layer.alert("此调度作业已经被禁用", {icon: 2});
        }else{
          layer.confirm('是否广播所有服务并立即触发执行调度作业['+ select.name + "]？", {
            btn: ['是','否'],
            shade:0.3
          }, function(){
            var defaultArg = select['argumentsMap'];
            layer.prompt({
              title: '触发调用的参数：',
              formType: 2,
              maxlength:1000,
              value: defaultArg ? defaultArg : '{}',
            }, function(v){
              var index = layer.load(1);
              $.post("${ctx!}/admin/task/trigger/" + select.id,{argumentsMap:v},function(res){
                layer.close(index);
                layer.alert(res.message + (res.success?("触发执行数:"+res.data.count):""), {icon: res.success?1:2});
                taskPage.refresh();
              });
            });
          });
        }
      }
    },
    rebuild:function(){
      layer.confirm('是否要将当前数据库记录同步更新至所有调度作业服务中进行重构？', {
        btn: ['是','否'],
        shade: 0.3
      }, function(){
        var index = layer.load(1);
        $.post("${ctx!}/admin/task/rebuild",function(res){
          layer.close(index);
          layer.alert(res.message, {icon: res.success?1:2});
        });
      });
    },
    logsSearch:function(params) {
      return {
        pageSize: params.pageSize,
        pageNum: params.pageNum,
        taskId:$("#logs_taskId").val(),
        timeS:$("#logs_timeS").val(),
        timeE:$("#logs_timeE").val()
      };
    },
    showLog:function(logId){
      console.log(logId);
    }
  };
  $(document).ready(function () {
    //初始化表格,动态从服务器加载数据
    $("#table_list").bootstrapTable({
      url: "${ctx!}/admin/task/list",
      pageSize: 10,
      checkboxHeader:false,
      clickToSelect: true,
      singleSelect: true,
      idField: "id",
      //数据列
      columns: [{
        checkbox: true
      }, {
        title: "名称",
        field: "name"
      }, {
        title: "描述",
        field: "description"
      }, {
        title: "调用Class",
        field: "targetClass"
      }, {
        title: "时间表达式",
        field: "cronExpression"
      }, {
        title: "调用参数",
        field: "argumentsMap"
      }, {
        title: "最后执行",
        field: "lastServer"
      }, {
        title: "最后执行时间",
        field: "lastTime"
      }, {
        title: "启用",
        field: "disabled",
        formatter: function (value, row, index) {
          return value ? '否' : '是';
        }
      }, {
        title: "执行中",
        field: "locking",
        formatter: function (value, row, index) {
          return value === 1 ? '<span class="text-danger">是</span>' : '否';
        }
      }, {
        title: "创建日期",
        field: "createTime"
      }]
    });


    $("#log_table").bootstrapTable({
      url: "${ctx!}/admin/task/logs",
      onClickCell:function(field, value, row, el){
        if(value && field === "executeExceptions"){
          layer.open({
            title: "["+ row.taskName + "]， [" + row.taskFireTime + "]， [" + row.executeServerHost + "]",
            type: 1,
            skin: 'layui-layer-rim',
            area: ['90%', '90%'],
            content: '<pre class="text-danger">'+value+'</pre>'
          });
        }
      },
      queryParams: taskPage.logsSearch,
      pageSize: 10,
      idField: "id",
      //数据列
      columns: [{
        title: "名称",
        field: "taskName"
      }, {
        title: "触发时间",
        field: "taskFireTime"
      }, {
        title: "完成时间",
        field: "executeOverTime"
      }, {
        title: "结果",
        field: "executeSuccess",
        formatter: function (value, row, index) {
          return value ? '成功' : '<span class="text-danger">失败</span>';
        }
      }, {
        title: "异常信息",
        field: "executeExceptions",
        formatter: function (value, row, index) {
          return value && value.length > 53 ? "<a href=\"javascript:;\">" + value.substr(0, 53) + "</a>": value;
        }
      }, {
        title: "调用服务",
        field: "executeServerHost"
      }, {
        title: "执行信息",
        field: "resultMessage"
      }]
    });
  });


</script>
</@htmlJs>