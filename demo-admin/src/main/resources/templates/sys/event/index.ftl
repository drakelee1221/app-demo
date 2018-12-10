<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<script>
  var messageChannels = ${messageChannels!'{}'};
</script>
<div class="panel panel-default">
  <div class="panel-heading">
    <form id="search_form" name="searchForm">
      <div class="form-inline">
        <div class="form-group">
          <label for="startDate" class="sr-only">开始时间</label>
          <input type="text" placeholder="请选择开始时间" id="startDate" class="form-control layer-date">
        </div>
        <div class="form-group">
          <label for="endDate" class="sr-only">结束时间</label>
          <input type="text" placeholder="请选择结束时间" id="endDate" class="form-control layer-date">
        </div>
        <div class="form-group">
          <select class="form-control" id="hasDone" onchange="refreshGrid()">
            <option value="">全部</option>
            <option value="-1">执行中</option>
            <option value="0">未开始</option>
            <option value="1">已完成</option>
            <option value="2">异常</option>
          </select>
        </div>
        <div class="form-group">
          <select class="form-control" id="channel" onchange="refreshGrid()">
            <option value="">全部</option>
          </select>
        </div>
        <button type="button" class="btn btn-primary" onclick="refreshGrid()"><i class="fa fa-search"></i>查询</button>
        <button type="button" class="btn btn-white" onclick="clearCondition()"><i class="fa fa-recycle"></i>清空条件
        </button>
      </div>
    </form>
  </div>
  <div class="panel-body">
    <div class="row">
      <div class="col-xs-12"><table id="table_list"></table></div>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <div class="panel panel-default">
          <div class="panel-heading">
            事件处理列表
          </div>

          <div class="panel-body">
            <table id="event_handle"></table>
          </div>
        </div>

      </div>
    </div>


  </div>

</div>
<div class="modal" id="remarksModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-group"></i>
          <b id="modal_title"></b>填写备注
        </h4>
      </div>
      <div class="modal-body">
        <form class="panel-body form-horizontal" id="user_form">
          <input type="hidden" class="form-control" name="id" id="id"/>
          <div class="form-group">
            <label for="name" class="control-label">备注：</label>
            <div>
              <input type="text" class="form-control" id="edit_remarks" name="edit_remarks" required="required"/>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="saveRemarks()"><i class="fa fa-save"></i>保存</button>
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
    </div>
  </div>
</div>

</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/sys/event/index.js"></script>
<script src="${ctx!}/admin/js/plugins/layer/laydate/laydate.js"></script>

  <@fancytree/>
</@htmlJs>