<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<input type="hidden" id="authCodeStr" value='${authCodeStr}' />
<link rel="stylesheet" type="text/css" href="${ctx!}/admin/pub/css/app_info/app_info.css"/>
  <div class="col-xs-6">
    <div class="panel panel-default">
      <div class="panel-heading">
        <div>
          <h3 class="">
            系统权限角色管理：
          </h3>
          <button onclick="ro.openModal('add')" type="button" class="btn btn-info">
            <i class="fa fa-plus"></i>
            新增
          </button>
          <button onclick="ro.openModal('edit')" type="button" class="btn btn-warning">
            <i class="fa fa-edit"></i>
            修改
          </button>
          <button onclick="ro.changeStatus()" type="button" id='delete_btn' class="btn btn-danger">
            <i class="fa fa-trash-o"></i>
            禁用/启用
          </button>
          <button onclick="ro.searchAppInfo()" type="button" class="btn btn-success pull-right m-l-xs">
            <i class="fa fa-search"></i>
            关联应用菜单
          </button>
          <button onclick="ro.searchMember()" type="button" class="btn btn-info pull-right">
            <i class="fa fa-search"></i>
            关联人员
          </button>
        </div>
      </div>
      <div class="panel-body">
        <table id="table_list"></table>
      </div>
    </div>
  </div>
  <div class="col-xs-6" id="app_info_dev" style="display:none">
    <div class="panel panel-default">
      <div class="panel-heading">
        <div>
          <h3 class="inline">
            <b class="label label-primary f-s" id="app_tree_title"></b> - 关联授权的应用菜单：
          </h3>
        </div>
      </div>
      <div class="panel-body">
        <p><i class="fa fa-info-circle"></i> 双击菜单名称，显示详细信息</p>
        <div id="app_tree" class="app-tree checkbox-tree"></div>
        <div class="text-center m-t-sm">
          <button onclick="ro.updateAppInfoJoin()" type="button" id="appInfo_update_join_btn" class="btn btn-primary"
                  disabled>
            <i class="fa fa-save"></i>
            保存修改
          </button>
        </div>
      </div>
    </div>
  </div>
  <div class="col-xs-6" id="member_dev" style="display:none">
    <div class="panel panel-default">
      <div class="panel-heading">
        <div>
          <h3 class="inline">
            <b class="label label-primary f-s" id="member_tree_title"></b> - 关联授权的人员：
          </h3>
        </div>
      </div>
      <div class="panel-body">
        <p><i class="fa fa-info-circle"></i> 双击人员姓名，显示完整授权信息</p>
        <div id="member_tree" class="member-tree checkbox-tree"></div>
        <div class="text-center m-t-sm">
          <button onclick="ro.updateMemberJoin()" type="button" id="member_update_join_btn" class="btn btn-primary"
                  disabled>
            <i class="fa fa-save"></i>
            保存修改
          </button>
        </div>
      </div>
    </div>
  </div>
<div class="modal" id="roleModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-group"></i>
          <b id="modal_title"></b> 权限角色
        </h4>
      </div>
      <div class="modal-body">
        <form class="panel-body form-horizontal" id="role_form" onsubmit="return false">
          <input type="hidden" name="id" class="form-control">
          <div class="form-group">
            <label for="name" class="control-label">名称：</label>
            <div>
              <input type="text" class="form-control" name="name" required="required"/>
            </div>
          </div>
          <div class="form-group">
            <label for="code" class="control-label">编码：</label>
            <div>
              <select class="input-sm form-control input-s-sm inline" id="code" name="code">
                <option value="">无</option>
                <#list authCode as code>
                  <option value="${code.key}">${code.key} - ${code.val}</option>
                </#list>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="description" class="control-label">描述：</label>
            <div>
              <input type="text" class="form-control" name="description"/>
            </div>
          </div>
          <div class="form-group">
            <label for="orderNo" class="control-label">排序值：</label>
            <div>
              <input type="text" class="form-control" name="orderNo" value="1"/>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="ro.formSubmit()"><i
          class="fa fa-save"></i>提交
        </button>
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="appInfoModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-group"></i>
          <b id="appInfo_modal_title"></b>
        </h4>
      </div>
      <div class="modal-body">
        <div class="panel-body form-horizontal" id="appInfo_form">
          <div class="form-group">
            <label for="name" class="control-label">名称：</label>
            <div>
              <input type="text" class="form-control" name="name" readonly/>
            </div>
          </div>
          <div class="form-group">
            <label for="description" class="control-label">描述：</label>
            <div>
              <input type="text" class="form-control" name="description" readonly/>
            </div>
          </div>
          <div class="form-group">
            <label for="iconClass" class="control-label">图标：</label>
            <div>
              <input type="text" class="form-control" name="iconClass" readonly/>
            </div>
          </div>
          <div class="form-group">
            <label for="targetUrl" class="control-label">跳转路径：</label>
            <div>
              <input type="text" class="form-control" name="targetUrl" readonly/>
            </div>
          </div>
          <div class="form-group">
            <label for="authUrlPrefix" class="control-label">授权路径前缀，以“/”结束，会授权以此路径开头的：</label>
            <div>
              <input type="text" class="form-control" name="authUrlPrefix" readonly/>
            </div>
          </div>
          <div class="form-group">
            <label for="readWriteType" class="control-label">读写级别：</label>
            <div>
              <select class="form-control" name="readWriteType" disabled>
                <option value="0" selected>读写</option>
                <option value="1">只读</option>
                <option value="2">只写</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="directory" class="control-label">是否为目录：</label>
            <input type="checkbox" name="directory" disabled/>
          </div>
          <div class="form-group">
            <label for="status" class="control-label">是否启用：</label>
            <input type="checkbox" name="status" disabled/>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="modal" id="authMemberModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-user"></i>
          <b id="auth_modal_title"></b>
        </h4>
      </div>
      <div class="modal-body">
        <h5>
          授权角色：
          <b id="auth_roles">
          </b>
        </h5>
        <h5>授权应用菜单：</h5>
        <div id="auth_tree" class="app-tree"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
    </div>
  </div>
</div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/role/index.js"></script>
  <@fancytree/>
</@htmlJs>