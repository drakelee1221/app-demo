<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div>
        <button onclick="tp.openModal('add')" type="button" class="btn btn-info">
          <i class="fa fa-plus"></i>
          新增
        </button>
        <button onclick="tp.openModal('edit')" type="button" class="btn btn-warning">
          <i class="fa fa-edit"></i>
          编辑
        </button>
        <button onclick="tp.delete()" type="button" class="btn btn-danger">
          <i class="fa fa-remove"></i>
          删除
        </button>
      </div>
    </div>
    <div class="panel-body">
      <table id="table_list"></table>
    </div>
  </div>
<div class="modal" id="typeModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">分类</b>
        </h4>
      </div>
      <div class="modal-body">
        <form class="panel-body form-horizontal" id="type_form">
          <input type="hidden" class="form-control" name="id" id="id"/>
          <div class="form-group">
            <label for="userType" class="control-label">分类编号：</label>
            <div>
              <input type="text" class="form-control" id="userType" name="userType" required/>
            </div>
          </div>
          <div class="form-group">
            <label for="userTypeName" class="control-label">分类名称：</label>
            <div>
              <input type="text" class="form-control" id="userTypeName" name="userTypeName" required/>
            </div>
          </div>
          <div class="form-group">
            <label for="remark" class="control-label">备注：</label>
            <div>
              <input type="text" class="form-control" id="remark" name="remark"/>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="tp.typeSave()"><i class="fa fa-save"></i>保存</button>
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
    </div>
  </div>
</div>

</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/userType/index.js"></script>

  <@fancytree/>
</@htmlJs>