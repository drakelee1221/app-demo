<#include "/layout/pagelayout.ftl"/>

<@htmlContent>

<div class="middle-box text-center loginscreen   animated fadeInDown">
  <div>
    <h3>欢迎注册</h3>
    <p>创建一个服务人员账户</p>
    <form class="m-t" role="form" action="login.html" id="register_form">
      <div class="form-group">
        <select id="userType" name="userType" class="form-control" placeholder="账户类型">

        </select>
      </div>

      <div class="form-group">
        <input type="text" class="form-control" placeholder="注册码(必填)" required="" id="code" name="code">
      </div>
      <div class="form-group">
        <input type="text" class="form-control" placeholder="请输入用户名(必填)" required="" id="userNickName" name="userNickName">
      </div>
      <div class="form-group text-left">
          <input type="radio" class="radio-button" placeholder="请选择性别(必填)" required="" id="gender_male" name="gender" value="1">男
          <input type="radio" class="radio-button" placeholder="请选择性别(必填)" required="" id="gender_female" name="gender" value="2">女

      </div>
      <div class="form-group">
        <input type="text" class="form-control" placeholder="请输入手机号(必填)" required="" id="phone" name="phone">
      </div>
      <div class="form-group">
        <input type="password" class="form-control" placeholder="请输入密码(必填)" required="" id="pwd" name="pwd">
      </div>
      <div class="form-group">
        <input type="password" class="form-control" placeholder="请再次输入密码(必填)" required="" id="pwd_confirm">
      </div>
      <div class="form-group">
        <div class="input-group">
          <input type="text" class="form-control" id="memberName" name="memberName" placeholder="请选择机构(必选)" required="" readonly>
          <span class="input-group-btn"> <button type="button" class="btn btn-primary block full-width m-b" onclick="showMember()">选择</button> </span>
        </div>
        <input type="hidden" id="memberId" name="memberId">
      </div>
      <div class="form-group">
        <div class="input-group">
          <input type="text" class="form-control" id="regionNames" name="regionNames" placeholder="请选择服务地区(必选)" required="" readonly>
          <input type="hidden" id="regionIds" name="regionIds">
          <span class="input-group-btn"> <button type="button" class="btn btn-primary block full-width m-b" onclick="showRegion()">选择</button> </span>
        </div>
      </div>
      <div class="form-group">
        <div class="input-group">
          <input type="text" class="form-control" id="productNames" name="productNames" placeholder="请选择擅长产品(必选)" required="" readonly>
          <input type="hidden" class="form-control" id="productIds" name="productIds">
          <span class="input-group-btn"> <button type="button" class="btn btn-primary block full-width m-b" onclick="showProduct()">选择</button> </span>
        </div>


      </div>
      <div class="form-group">
        <input type="text" class="form-control" placeholder="个人简介" required="" id="profile" name="profile">
      </div>
      <button type="button" class="btn btn-primary block full-width m-b" onclick="registerUser()">注 册</button>

    </form>
  </div>
</div>
<div class="modal" id="treeModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">选择地区</b>
        </h4>
      </div>
      <div class="modal-body">
        <div id="region_tree" class="region-tree"></div>
      </div>
      <div class="modal-footer ">
        <button type="button" class="btn btn-primary block m-b" style="width: 50px; float: right;" onclick="confirmRegion()">确定</button>
      </div>
    </div>
  </div>
</div>
<div class="modal" id="productModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">选择擅长产品</b>
        </h4>
      </div>
      <div class="modal-body">
        <div id="product_list"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary block m-b" style="width: 50px; float: right;" onclick="confirmProduct()">确定</button>
      </div>
    </div>
  </div>
</div>
<div class="modal" id="memberModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">选择部门</b>
        </h4>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-xs-6">
            <div id="member_region_tree" class="region-tree"></div>
          </div>
          <div class="col-xs-6">
            <div id="member_tree" class="region-tree"></div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary block m-b" style="width: 50px; float: right;" onclick="memberConfirm()">确定</button>
      </div>
    </div>
  </div>
</div>
<script src="${ctx!}/admin/pub/js/common/register.js"></script>
<script src="${ctx!}/admin/pub/js/common/region_tree.js"></script>
<script src="${ctx!}/admin/pub/js/common/member_tree.js"></script>
<script src="${ctx!}/admin/pub/js/common/member_region_tree.js"></script>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/js/plugins/layer/laydate/laydate.js"></script>

  <@fancytree/>
</@htmlJs>
