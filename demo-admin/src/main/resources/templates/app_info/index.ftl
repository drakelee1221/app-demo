<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<link rel="stylesheet" type="text/css" href="${ctx!}/admin/pub/css/app_info/app_info.css" />
  <div class="col-xs-12 col-sm-6">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4>应用菜单</h4>
      </div>
      <div class="panel-body">
        <div class="row">
          <div class="col-xs-12">
            <div id="app_tree" class="app-tree"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="col-xs-12 col-sm-6">
    <div class="panel panel-default">
      <div class="panel-heading text-center">
        <button onclick="ap.add(0)" type="button" class="btn btn-info" id="add_dir_btn" disabled>
          <i class="fa fa-plus"></i>
          新目录
        </button>
        <button onclick="ap.add(1)" type="button" class="btn btn-info" id="add_app_btn" disabled>
          <i class="fa fa-plus"></i>
          新应用
        </button>
        <button onclick="ap.del()" type="button" id='delete_btn' class="btn btn-danger">
          <i class="fa fa-trash-o"></i>
          删除
        </button>
      </div>
      <form class="panel-body m-h" id="app_form">
        <input type="hidden" name="parentId" id="parentId"/>
        <div class="form-group">
          <label for="id" class="control-label">ID：</label>
          <div>
            <input type="text" class="form-control" id="id" readonly="readonly"/>
          </div>
        </div>
        <div class="form-group">
          <label for="name" class="control-label">名称：</label>
          <div>
            <input type="text" class="form-control" name="name" id="name" required="required"/>
          </div>
        </div>
        <div class="form-group">
          <label for="description" class="control-label">描述：</label>
          <div>
            <input type="text" class="form-control" name="description" id="description" />
          </div>
        </div>
        <div class="form-group">
          <label for="iconClass" class="control-label">图标：</label>
          <div>
            <input type="text" class="form-control" name="iconClass" id="iconClass" onclick="ap.openIcon(this)" />
          </div>
        </div>
        <div class="form-group">
          <label for="targetUrl" class="control-label">跳转路径：</label>
          <div>
            <input type="text" class="form-control" name="targetUrl" id="targetUrl" />
          </div>
        </div>
        <div class="form-group">
          <label for="authUrlPrefix" class="control-label">授权路径前缀，以“/”结束，多个以换行分割，会授权以此路径开头的：</label>
          <div>
            <#--<input type="text" class="form-control" name="authUrlPrefix" id="authUrlPrefix" />-->
            <textarea class="form-control" rows="5" name="authUrlPrefix" id="authUrlPrefix"></textarea>
          </div>
        </div>
        <div class="form-group">
          <label for="readWriteType" class="control-label">读写级别：</label>
          <div>
            <select class="form-control" id="readWriteType">
              <option value="0" selected>读写</option>
              <option value="1">只读</option>
              <option value="2">只写</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label for="directory" class="control-label">是否为目录：</label>
          <input type="checkbox" id="directory" disabled/>
        </div>
        <div class="form-group">
          <label for="status" class="control-label">是否启用：</label>
          <input type="checkbox" id="status"/>
        </div>
        <div class="form-group" align="center">
          <button type="button" class="btn btn-primary" id="sub_btn" onclick="ap.formSubmit()" disabled>
            <i class="fa fa-save"></i>
            保存
          </button>
        </div>
      </form>
    </div>
  </div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/app_info/index.js"></script>
<script src="${ctx!}/admin/pub/plugin/icons/selector.icons.js"></script>
  <@fancytree/>
</@htmlJs>