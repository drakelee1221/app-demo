<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="panel panel-default">
  <div class="panel-heading">
    <form id="search_form" name="searchForm">
      <div class="form-inline">
        <div class="form-group">
          <label for="code" class="sr-only">编号</label>
          <select id="code" name="code" class="form-control">
            <option value="">请选择编号</option>
            <#list codes as code>
              <#if "${RequestParameters['code']}"?? && "${RequestParameters['code']}"=="${code.code}">
                <option value="${code.code}" selected>${code.title}</option>
              <#else>
                <option value="${code.code}">${code.title}</option>
              </#if>
            </#list>
          </select>
        </div>
        <div id="otherquery" disabled="disabled"></div>

        <button type="button" class="btn btn-primary" onclick="tp.search()"><i class="fa fa-search"></i>查询</button>
        <button type="button" class="btn btn-white" onclick="tp.clearCondition()"><i class="fa fa-recycle"></i>清空条件
        </button>
      </div>
    </form>
  </div>

  <div class="panel-body">
    <table id="table_list"></table>
  </div>
</div>
<div class="modal" id="childModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">附属信息</b>
        </h4>
      </div>
      <div class="modal-body">
        <div class="panel-heading">
          <div class="form-inline">
            <div class="form-group">
              <select id="type" name="type" class="form-control">
                <option value="">请选择附属信息类型</option>
              </select>
            </div>
            <button type="button" class="btn btn-primary" onclick="tp.searchChild()"><i class="fa fa-search"></i>查询</button>
          </div>
        </div>
        <div class="panel-body">
          <table id="child_list"></table>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
    </div>
  </div>
</div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/dynamicform/index.js"></script>
<script src="${ctx!}/admin/js/plugins/layer/laydate/laydate.js"></script>

  <@fancytree/>
</@htmlJs>