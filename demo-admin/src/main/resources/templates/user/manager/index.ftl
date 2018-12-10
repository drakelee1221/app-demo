<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="row">
  <div class="col-xs-3 col-sm-2">
    <div class="ibox ">
      <div class="ibox-title">
        <h5>地区</h5>
      </div>
      <div class="ibox-content">
        <div id="region_tree" class="region-tree"></div>
      </div>
    </div>
  </div>
  <div class="col-xs-12 col-sm-10">
    <div class="panel panel-default">
      <div class="panel-heading">
        <form id="conditionForm" name="conditionForm">
          <input type="hidden" id="registRegion" name="registRegion"/>
          <input type="hidden" id="regionId" name="regionId"/>
          <div class="form-inline form-group">
            <span class="m-r-lg">所选地区：
              <b class="label label-primary f-s">
                <span id="regionChecked">全部</span><a class="remove-regionChecked" onclick="regionTree.searchAll()" style="display: none;"
                                                     href="javascript:void(0)">&nbsp;&nbsp;X</a>
              </b>
            </span>
            <span class="m-r-lg">
              注册时间 <i class="fa fa-question-circle" title="为提升效率，跨度超过90天的查询，将不提供时间排序" style="color:#23b7e5"></i> ：
              <input type="text" placeholder="请选择开始时间" id="registTimeStart" value="${registTimeStart}"
                     name="registTimeStart" class="form-control layer-date" style="background:#fff" readonly> -
              <input type="text" placeholder="请选择结束时间" id="registTimeEnd"  value="${registTimeEnd}"
                     name="registTimeEnd" class="form-control layer-date" style="background:#fff" readonly>
            </span>
          </div>
          <div class="form-inline">
            <div class="form-group">
              <label for="searchStatus" class="sr-only">状态</label>
              <select id="searchStatus" name="searchStatus" class="form-control">
                <option value="-1">全部状态</option>
                <option value="1">正常</option>
                <option value="0">限制登录</option>
              </select>
            </div>
            <div class="form-group">
               <select id="hand" name="hand" class="form-control">
                <option value="">全部用户</option>
                <option value="0">注册用户</option>
                <option value="1">导入用户</option>
              </select>
            </div>
            <div class="form-group">
              <label for="searchPhone" class="sr-only">手机号</label>
              <input type="text" placeholder="手机号" name="searchPhone" id="searchPhone" class="form-control">
            </div>
            <div class="form-group">
              <label for="searchUserNickName" class="sr-only">用户姓名</label>
              <input type="text" placeholder="用户姓名" name="searchUserNickName" id="searchUserNickName"
                     class="form-control">
            </div>
            <div class="form-group">
              <label for="searchCompanyName" class="sr-only">企业名称</label>
              <input type="text" placeholder="企业名称" name="searchCompanyName" id="searchCompanyName"
                     class="form-control">
            </div>
            <div class="form-group">
              <label for="dataSource" class="sr-only">来源</label>
              <select class="form-control" name="dataSource" id="dataSource">
                <option value="" selected>选择来源</option>
                <option value="1">移动端</option>
                <option value="0">PC端</option>
              </select>
            </div>
            <button type="button" class="btn btn-primary" onclick="pi.search()"><i class="fa fa-search"></i>查询</button>
            <button type="button" class="btn btn-white" onclick="pi.clearCondition()"><i class="fa fa-recycle"></i>清空条件
            </button>
          </div>
        </form>
      </div>
      <div class="panel-body">
        <table id="table_list"></table>
      </div>
    </div>
  </div>
</div>
  <div class="modal" id="detailModal" tabindex="-1" role="dialog" style="padding: 0;border: 0;margin: 0;"
       aria-hidden="true">
    <div class="modal-dialog" style="width: 100%;height: 100%;padding: 0;border: 0;margin: 0;">
      <div class="modal-content" style="width: 100%;height: 100%;padding: 0;border: 0;margin: 0;">
        <div class="modal-header" style="border: 0;margin: 0;">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
            class="sr-only">关闭</span>
          </button>
          <h4 class="modal-title">
            <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-chevron-left"></i> 返回用户列表
            </button>
          </h4>
        </div>
        <iframe id="detailIframe" src=""
                style="width: 100%;border: 0;margin: 0;padding: 0;"></iframe>
      </div>
    </div>
  </div>
</@htmlContent>

<@htmlJs>
  <script src="${ctx!}/admin/pub/js/user/manager/index.js"></script>
  <script src="${ctx!}/admin/pub/js/user/manager/region_tree.js"></script>
  <script src="${ctx!}/admin/js/plugins/layer/laydate/laydate.js"></script>

  <@fancytree/>
</@htmlJs>