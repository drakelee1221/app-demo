<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<link rel="stylesheet" type="text/css" href="${ctx!}/admin/pub/css/app_info/app_info.css"/>
<div class="row">
  <div class="col-xs-12 col-sm-5">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4>后台帐号管理</h4>
      </div>
      <div class="panel-body">
        <div class="row">
          <div class="col-xs-12">
            <p><i class="fa fa-info-circle"></i> 双击人员姓名，显示完整授权信息</p>
            <div id="member_tree" class="member-tree"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="col-xs-12 col-sm-7">
    <div class="panel panel-default">
      <div class="panel-heading text-center">
        <button onclick="mb.add_member(0)" type="button" class="btn btn-info" id="add_dept_btn"
                disabled>
          <i class="fa fa-plus"></i>
          新分组
        </button>
        <button onclick="mb.add_member(1)" type="button"
                class="btn btn-info" id="add_person_btn" disabled="disabled">
          <i class="fa fa-plus"></i>
          新人员
        </button>
        <button onclick="mb.delete_member()" type="button" id='delete_btn' class="btn btn-danger">
          <i class="fa fa-trash-o"></i>
          删除
        </button>
        <button onclick="mb.add_member_attr()" type="button" id='add_member_attr_btn' class="btn btn-primary"
                disabled="disabled">
          <i class="fa fa-share-alt"></i>
          业务授权
        </button>
      </div>
      <form class="panel-body form-horizontal" id="member_form">
        <input type="hidden" name="parentId" id="parentId"/>
        <input type="hidden" name="treeKind" id="treeKind"/>
        <div class="form-group">
          <label for="id" class="col-xs-2 control-label">ID：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" id="id" readonly="readonly"/>
          </div>
        </div>
        <div class="form-group">
          <label for="name" class="col-xs-2 control-label">名称：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" name="memberName" id="memberName" required="required"/>
          </div>
        </div>
        <div class="form-group">
          <label for="account" class="col-xs-2 control-label">登录账号：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" name="account" id="account" autocomplete="off" required="required"/>
          </div>
        </div>
        <div class="form-group">
          <label for="password" class="col-xs-2 control-label">登录密码：</label>
          <div class="col-xs-10">
            <input type="text" class="form-control" name="pwd" id="pwd" autocomplete="off" required="required"/>
          </div>
        </div>
        <div class="form-group">
          <label for="status" class="col-xs-2 control-label">冻结：</label>
          <div class="col-xs-10">
            <input type="checkbox" id="status"/>
          </div>
        </div>
        <div class="form-group" align="center">
          <button type="button" class="btn btn-primary" onclick="mb.memberSubmit()">
            <i class="fa fa-save"></i>
            保存
          </button>
        </div>
      </form>
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
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>关闭</button>
      </div>
    </div>
  </div>
</div>
<div class="modal" id="memberAttrModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-user"></i>
          <b id="attr_modal_title"></b> > 关联业务授权
        </h4>
      </div>
      <div class="ibox-content">
        <div class="row">
          <div class="col-xs-12">
            <div><p><i class="fa fa-info-circle"></i>双击机构，可以添加该机构</p></div>
            <div class="m-t-xs" style="min-height:30px" id="selected_members">
            </div>
          </div>
        </div>
        <div class="row">
          <#--<div class="col-xs-12">-->
            <#--<p><i class="fa fa-info-circle"></i> 不计算上下级，只会计算勾选的节点</p>-->
            <#--<div id="member_attr_tree" class="member-tree checkbox-tree"></div>-->
          <#--</div>-->
            <div class="col-xs-6">
              <div id="member_region_tree" class="region-tree"></div>
            </div>
            <div class="col-xs-6">
              <div id="member_attr_tree" class="region-tree"></div>
            </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="memberAttrSubmitBtn" onclick="mb.updateMemberAttr()"><i class="fa fa-save"></i>保存
        </button>
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>关闭</button>
      </div>
    </div>
  </div>
</div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/member/index.js"></script>
<script src="${ctx!}/admin/pub/js/common/member_checked_tree.js"></script>
<script src="${ctx!}/admin/pub/js/common/member_region_attr_tree.js"></script>
  <@fancytree/>
</@htmlJs>