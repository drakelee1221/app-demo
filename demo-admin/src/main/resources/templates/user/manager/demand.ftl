<div class="panel panel-default">
  <div class="panel-heading">
    <div class="m-b-md">
      <button onclick="dm.detail()" type="button" class="btn btn-success">
        <i class="fa fa-search"></i>
        查看详情
      </button>
    </div>
    <form id="demandForm" name="demandForm">
      <div class="form-inline">
        <div class="form-group">
          <label for="startDate">起止时间</label>
          <input type="text" placeholder="请选择开始时间" id="demandStartDate" name="startDate" class="form-control layer-date">
        </div>
        <div class="form-group">
          <label for="endDate">至</label>
          <input type="text" placeholder="请选择结束时间" id="demandEndDate" name="endDate" class="form-control layer-date">
        </div>
        <div class="form-group">
          <input type="hidden" name="searchUserId" id="searchUserId" value="${userId}" class="form-control">
          <input type="hidden" name="searchType" id="searchType" value="0" class="form-control">
        </div>
        <div class="form-group">
          <label for="searchCategoryId" class="sr-only">需求分类</label>
          <select class="form-control chosen-select" id="searchCategoryId" name="searchCategoryId">
            <option value="">需求分类</option>
          <#list groups as group>
            <option value="${group.id}" hassubinfo="true">${group.name}</option>
          </#list>
          </select>
        </div>
        <div class="form-group">
          <label for="searchStatus" class="sr-only">状态</label>
          <select id="searchStatus" name="searchStatus" class="form-control">
            <option value="-1">全部状态</option>
            <option value="0">未审核</option>
            <option value="1">通过</option>
            <option value="2">驳回</option>
            <option value="3">已上线</option>
            <option value="4">已下线</option>
            <option value="5">已过期</option>
          </select>
        </div>
        <button type="button" class="btn btn-primary" onclick="dm.search()"><i class="fa fa-search"></i>查询</button>
        <button type="button" class="btn btn-white" onclick="dm.clearCondition()"><i class="fa fa-recycle"></i>清空条件
        </button>
      </div>
    </form>
  </div>
  <div class="panel-body">
    <table id="demand_list"></table>
  </div>
</div>
<div class="modal" id="demandModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <b id="modal_title">供需详情</b>
        </h4>
      </div>
      <div class="modal-body">
        <form class="panel-body form-horizontal" id="cooperation_form">
          <div class="form-group" style="text-align: center">
            <img alt="形象图" class="img-circle" id="thumbnail" style="width: 100px;height: 100px;" src="">
          </div>
          <div class="form-group">
            <div>
              <label for="categoryName" class="control-label">需求分类：</label>
              <input type="text" class="form-control" placeholder="活动标题" id="categoryName" name="categoryName"/>
            </div>
          </div>
          <div class="form-group">
            <div>
              <label for="expireDay" class="control-label">时效天数：</label>
              <input type="text" class="form-control" placeholder="时效天数" id="expireDay" name="expireDay"/>
            </div>
          </div>
          <div class="form-group">
            <div>
              <label for="title" class="control-label">需求标题：</label>
              <input type="text" class="form-control" placeholder="需求标题" id="title" name="title"/>
            </div>
          </div>
          <div class="form-group">
            <div>
              <label for="content" class="control-label">需求内容：</label>
              <textarea class="form-control" placeholder="需求标题" rows="3" id="content" name="content"></textarea>
            </div>
          </div>
          <div class="form-group">
            <div>
              <label for="phone" class="control-label">联系电话：</label>
              <input type="text" class="form-control" placeholder="联系电话" id="phone" name="phone"/>
            </div>
          </div>

          <div class="form-group">
            <div>
              <label for="checker" class="control-label">审核者：</label>
              <input type="text" class="form-control" placeholder="审核者" id="checker" name="checker"/>
            </div>
          </div>

          <div class="form-group">
            <div>
              <label for="checkTime" class="control-label">审核时间：</label>
              <input type="text" class="form-control" placeholder="审核时间" id="checkTime" name="checkTime"/>
            </div>
          </div>

          <div class="form-group">
            <div>
              <label for="status" class="control-label">状态：</label>
              <select id="status" name="status" class="form-control">
                <option value="-1">全部状态</option>
                <option value="0">未审核</option>
                <option value="1">通过</option>
                <option value="2">驳回</option>
                <option value="3">已上线</option>
                <option value="4">已下线</option>
                <option value="5">已过期</option>
              </select>
            </div>
          </div>


        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
    </div>
  </div>

</div>

<script src="${ctx!}/admin/pub/js/user/manager/demand.js"></script>
