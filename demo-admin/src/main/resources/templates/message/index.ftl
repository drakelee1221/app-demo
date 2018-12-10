<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
  <div class="panel panel-default">
    <div class="panel-heading">
      <div class="form-inline" id="search_form">
        <div class="form-group">
          <select class="form-control" name="userTypeId" onchange="ms.search('table_list')">
            <option value="" selected>人员类别 - 全部</option>
            <#list userTypes as userType>
              <option value="${userType.id}">人员类别 - ${userType.userTypeName}</option>
            </#list>
          </select>
        </div>
        <div class="form-group">
          <select class="form-control" name="status" onchange="ms.search('table_list')">
            <option value="">状态 - 全部</option>
            <option value="1">状态 - 已读</option>
            <#if "${RequestParameters['status']}"?? && "${RequestParameters['status']}"=="0">
              <option value="0" selected>状态 - 未读</option>
            <#else>
              <option value="0">状态 - 未读</option>
            </#if>
          </select>
        </div>
        <div class="form-group">
          <input placeholder="姓名"  name="userNickName" class="form-control search-input">
        </div>
        <div class="form-group">
          <input placeholder="手机号"  name="phone" class="form-control search-input">
        </div>
        <div class="form-group">
          <input placeholder="信息内容"  name="content" class="form-control search-input">
        </div>
        <button type="button" class="btn btn-primary" onclick="ms.search('table_list')">
          <i class="fa fa-search"></i>
          查询
        </button>
        <button type="button" class="btn btn-white" onclick="ms.clearSearch()">
          <i class="fa fa-recycle"></i>
          清空条件
        </button>
      </div>
    </div>
    <div class="panel-body">
      <table id="table_list"></table>
    </div>
  </div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/message/index.js"></script>

  <@fancytree/>
</@htmlJs>