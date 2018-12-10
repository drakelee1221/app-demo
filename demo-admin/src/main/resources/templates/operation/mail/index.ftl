<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="panel panel-default">
  <div class="panel-heading">
    <div class="m-b-sm">
      <button onclick="createMail()" type="button" class="btn btn-info">
        <i class="fa fa-plus"></i>
        创建邮件
      </button>
      <button onclick="configServer()" type="button" class="btn btn-warning">
        <i class="fa fa-edit"></i>
        服务器设置
      </button>
    </div>
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
          <label for="keywords" class="sr-only">关键词</label>
          <input type="text" placeholder="请输入查询关键词" id="keywords" class="form-control">
        </div>
        <div class="form-group">
          <label for="withdrawStatus" class="sr-only">状态</label>
          <select id="status" name="withdrawStatus" class="form-control">
            <option value="">全部状态</option>
            <option value="0">未发送</option>
            <option value="1">已发送</option>
          </select>
        </div>
        <button type="button" class="btn btn-primary" onclick="refreshGrid()"><i class="fa fa-search"></i>查询</button>
        <button type="button" class="btn btn-white" onclick="clearCondition()"><i class="fa fa-recycle"></i>清空条件
        </button>
      </div>
    </form>
  </div>
  <div class="panel-body">
    <table id="table_list"></table>
  </div>
</div>

<div class="modal" id="createMailModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-group"></i>
          <b id="modal_title"></b>创建/修改邮件
        </h4>
      </div>
      <div class="modal-header">
        <button type="button" class="btn btn-primary" id="dealSaveBtn" onclick="saveMail()"><i class="fa fa-save"></i>提交
        </button>
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
      <div class="modal-body">
        <form class="panel-body form-horizontal" id="mail_form">
          <input type="hidden" class="form-control" name="id" id="id"/>
          <div class="form-group">
            <label for="subject" class="sr-only">邮件主题</label>
            <input type="text" placeholder="邮件主题" id="subject" name="subject" class="form-control">
          </div>
          <div class="form-group">
            <label for="addressee" class="sr-only">收件人</label>
            <textarea placeholder="收件人(多个以逗号分隔)" id="addressee" name="addressee" class="form-control"></textarea>
          </div>
          <div class="form-group">
            <label for="remarks" class="sr-only">备注</label>
            <input type="text" placeholder="备注" id="remark" name="remark" class="form-control"/>
          </div>
          <div class="form-group">
            <label for="content" class="sr-only">内容：</label>
            <div class="col-sm-11">
              <#assign ueditor_id="content"/>
              <#assign ueditor_height="400"/>
              <#include "../../ueditor/include.ftl"/>
            </div>
          </div>

        </form>
      </div>

    </div>
  </div>
</div>
<div class="modal" id="mailBoxModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-group"></i>
          <b id="modal_title"></b>配置邮件服务器
        </h4>
      </div>

      <div class="modal-body">
        <form class="panel-body form-horizontal" id="mailbox_form">
          <input type="hidden" class="form-control" name="id" id="box_id"/>
          <div class="form-group">
            <label for="address" class="sr-only">邮箱地址</label>
            <input type="text" placeholder="邮箱地址" id="address" name="address" class="form-control">
          </div>
          <div class="form-group">
            <label for="smtp" class="sr-only">smtp服务器</label>
            <input type="text" placeholder="smtp服务器" id="smtp" name="smtp" class="form-control">
          </div>
          <div class="form-group">
            <label for="password" class="sr-only">密码</label>
            <input type="text" placeholder="密码" id="password" name="password" class="form-control"/>
          </div>
          <div class="form-group">
            <label for="sign" class="sr-only">签名</label>
            <input type="text" placeholder="签名" id="sign" name="sign" class="form-control"/>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="dealSaveBtn" onclick="saveMailBox()"><i
          class="fa fa-save"></i>提交
        </button>
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
    </div>
  </div>
</div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/operation/mail/index.js"></script>
<script src="${ctx!}/admin/js/plugins/layer/laydate/laydate.js"></script>

  <@fancytree/>
</@htmlJs>