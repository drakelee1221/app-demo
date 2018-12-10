<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
  <div class="col-xs-12 col-sm-4">
    <div class="ibox ">
      <div class="ibox-title">
        <h5>地区</h5>
      </div>
      <div class="ibox-content">
        <div class="row">
          <div class="col-xs-12">
            <div id="region_tree" class="region-tree"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="col-xs-12 col-sm-8">
    <div class="panel panel-default">
      <div class="panel-heading text-center">
        <button onclick="mb.add_region(true)" type="button" class="btn btn-info" id="add_region_root_btn">
          <i class="fa fa-plus"></i>
          新增根节点
        </button>
        <button onclick="mb.add_region(false)" type="button" class="btn btn-info" id="add_region_btn"
                disabled>
          <i class="fa fa-plus"></i>
          新增下级节点
        </button>
        <button onclick="mb.delete_region()" type="button" id='delete_btn' class="btn btn-danger">
          <i class="fa fa-trash-o"></i>
          删除
        </button>
      </div>
      <form class="panel-body form-horizontal" id="region_form">
        <div class="form-group">
          <label for="id" class="col-xs-2 control-label">ID：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" id="id" readonly="readonly"/>
          </div>
        </div>
        <div class="form-group">
          <label for="parentId" class="col-xs-2 control-label">父级：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" id="parentName" readonly="readonly"/>
            <input type="hidden" class="form-control" id="parentId" name="parentId"/>
          </div>
        </div>
        <div class="form-group">
          <label for="name" class="col-xs-2 control-label">名称：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" name="name" id="name" required="required"/>
          </div>
        </div>
        <div class="form-group">
          <label for="orderNo" class="col-xs-2 control-label">排序号：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" name="orderNo" id="orderNo" autocomplete="off"/>
          </div>
        </div>
        <div class="form-group">
          <label for="remark" class="col-xs-2 control-label">备注：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" name="remark" id="remark" autocomplete="off"/>
          </div>
        </div><div class="form-group">
        <label for="status" class="col-xs-2 control-label">禁用：</label>
        <div class="col-xs-10">
          <input type="checkbox" id="status"/>
        </div>
      </div>

        <div class="form-group" align="center">
          <button type="button" class="btn btn-primary" onclick="mb.regionSubmit()">
            <i class="fa fa-save"></i>
            保存
          </button>
        </div>
      </form>
    </div>
  </div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/region/index.js"></script>
  <@fancytree/>
</@htmlJs>