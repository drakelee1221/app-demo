<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="col-xs-12 col-sm-12">
  <div class="panel panel-default">
    <div class="panel-heading">
      <div>
        <button onclick="tp.addOrEdit('add')" type="button" class="btn btn-info">
          <i class="fa fa-plus"></i>
          创建
        </button>
        <button onclick="tp.addOrEdit('edit')" type="button" class="btn btn-warning">
          <i class="fa fa-edit"></i>
          编辑
        </button>
        <button onclick="tp.delete()" type="button" class="btn btn-danger">
          <i class="fa fa-trash-o"></i>
          删除
        </button>
      </div>
    </div>
    <div class="panel-body">
      <table id="table_list"></table>
    </div>
  </div>
</div>
<div class="modal" id="dataModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">业务活动</b>
        </h4>
      </div>
      <div class="modal-body">
        <form class="panel-body form-horizontal" id="data_form">
          <input type="hidden" class="form-control" name="id" id="id"/>
          <div class="form-group">
            <label for="status" class="control-label">类型：</label>
            <div>
              <select class="form-control" placeholder="类型" name="type" id="type" required="required">
                <option value="0">产品</option>
                <option value="1">客服</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="avatar" class="control-label">图片：</label>
            <button type="button" class="btn-success" style="position: relative;right: 0" onclick="tp.addAtta()"><i
              class="fa fa-upload"></i>更换图片
            </button>
            <div class="form-group" id="attas" style="display: none;">
            </div>
            <div>
              <img class="img" id="attas_img" style="width:90px" src="">
            </div>
          </div>
          <div class="form-group">
            <label for="status" class="control-label">关联项：</label>
            <div>
              <input type="text" class="form-control" placeholder="关联项" id="refId" name="refId" required="required"/>
            </div>
          </div>
          <div class="form-group">
            <label for="status" class="control-label">排序号：</label>
            <div>
              <input type="number" class="form-control" placeholder="排序号" id="orderNo" name="orderNo" required="required"/>
            </div>
          </div>
          <div class="form-group">
            <label for="status" class="control-label">描述：</label>
            <div>
              <input type="text" class="form-control" placeholder="描述" id="remark" name="remark" required="required"/>
            </div>
          </div>
          <div class="form-group">
            <label for="status" class="control-label">内容：</label><br>
            <label for="status" class="control-label" style="color:red;">注意：数据以{"name":"tec","sex":"男"}的方式拼接</label>
            <div>
              <textarea class="form-control" placeholder="内容" rows="3" id="jsonData" name="jsonData"
                        required="required"></textarea>
            </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="dealSaveBtn" onclick="tp.dealSave()"><i
          class="fa fa-save"></i>提交
        </button>
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
    </div>
  </div>
  <form id="attaForm" name="attaForm" method="post">
    <input type="file" style="display: none" dir="" id="file" name="file" enctype="multipart/form-data"/>
  </form>
</div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/sys/variable/index.js"></script>
<script src="${ctx!}/admin/pub/js/attachment/attachment.js"></script>

  <@fancytree/>
</@htmlJs>