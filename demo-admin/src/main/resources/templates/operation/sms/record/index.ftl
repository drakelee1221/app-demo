
  <div class="row">
    <div class="col-xs-8">
      <div class="panel panel-default">
        <div class="panel-heading">

          <form id="record_search_form" name="recordSearchForm">
            <div class="form-inline">
              <input type="hidden" name="smsId" id="smsId" value="">
              <div class="form-group">
                <label for="searchUserName" class="sr-only">用户名</label>
                <input type="text" placeholder="用户名" name="searchUserName" id="searchUserName" class="form-control">
              </div>
              <div class="form-group">
                <label for="searchPhone" class="sr-only">电话</label>
                <input type="text" placeholder="电话" name="searchPhone" id="searchPhone" class="form-control">
              </div>
              <div class="form-group">
                <label for="searchStatus" class="sr-only">状态</label>
                <select id="searchStatus" name="searchStatus" class="form-control">
                  <option value="-1">全部状态</option>
                  <option value="0">未发送</option>
                  <option value="1">发送成功</option>
                  <option value="2">发送失败</option>
                </select>
              </div>
              <br>
              <br>
              <div class="form-group">
                <label for="lastLoginStartDate" class="sr-only">最近登陆时间始</label>
                <input type="text" placeholder="最近登陆时间始" id="lastLoginStartDate" name="lastLoginStartDate" class="form-control layer-date">
              </div>
              <div class="form-group">
                <label for="lastLoginEndDate" class="sr-only">最近登陆时间止</label>
                <input type="text" placeholder="最近登陆时间止" id="lastLoginEndDate" name="lastLoginEndDate"  class="form-control layer-date">
              </div>
              <button type="button" class="btn btn-primary" onclick="pi.search()"><i class="fa fa-search"></i>查询</button>
              <button type="button" class="btn btn-white" onclick="pi.clearCondition()"><i class="fa fa-recycle"></i>清空条件
              </button>
            </div>
          </form>
        </div>
        <div class="panel-body">
          <table id="record_list"></table>
        </div>
      </div>

    </div>
    <div class="col-xs-4">
      <h4 class="inline"><b class="label label-primary f-s" id="region_list_title"></b> - 短信信息：</h4>
      <form class="panel-body form-horizontal" id="v_sms_form">
        <div class="form-group">
          <label for="templateId" class="sr-only">批次</label>
          <input type="text" placeholder="批次" id="v_batch" name="batch" class="form-control" readonly/>
        </div>
        <div class="form-group">
          <label for="templateId" class="sr-only">短信通道</label>
          <select id="v_smsChannel" name="smsChannel" class="form-control" readonly>
            <option value="0" selected="selected">默认通道</option>
          </select>
        </div>
        <div class="form-group">
          <label for="templateId" class="sr-only">短信模板</label>
          <select id="v_templateId" name="templateId" class="form-control" readonly>
            <option value="">选择模板</option>
          </select>
        </div>
        <div class="form-group">
          <label for="v_content_view" class="sr-only">示例内容</label>
          <textarea placeholder="示例内容" id="v_content_view" name="content_view" class="form-control"
                    readonly></textarea>
        </div>

        <div class="form-group">
          <label for="content" class="sr-only">参数内容</label>
          <textarea placeholder="参数内容" id="v_paramJson" name="paramJson" class="form-control" readonly></textarea>
        </div>
      <#--<div class="form-group">
        <label for="addressee" class="sr-only">手机号码</label>
        <textarea placeholder="手机号码(多个以逗号分隔)" id="users" name="users" class="form-control"></textarea>
      </div>-->
        <div class="form-group">
          <label for="remarks" class="sr-only">备注</label>
          <input type="text" placeholder="备注" id="v_remarks" name="remarks" class="form-control" readonly/>
        </div>
      </form>
    </div>
  </div>
