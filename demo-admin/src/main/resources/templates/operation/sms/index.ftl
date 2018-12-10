<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<div class="panel panel-default">
  <div class="panel-heading">
    <div class="m-b-sm">
      <button onclick="createSms()" type="button" class="btn btn-info">
        <i class="fa fa-plus"></i>
        创建短信
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
            <option value="1">发送完成</option>
            <option value="2">未发送完成</option>
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

<div class="modal" id="createSmsModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="width: 80%;height: 100%;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-group"></i>
          <b id="modal_title"></b>创建/修改短信
        </h4>
      </div>
      <div class="modal-header">
        <button type="button" class="btn btn-primary" id="save_btn" onclick="saveSms()"><i class="fa fa-save"></i>保存
        </button>
        <#--<button type="button" class="btn btn-primary" id="save_send_btn" onclick="saveSendSms()"><i
          class="fa fa-save"></i>保存并发送
        </button>-->
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-xs-8">
            <div class="tabs-container">
              <ul class="nav nav-tabs" id="mode_tab">
                <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true" onclick="setSendMode(0)">批量发送模式</a>
                </li>
                <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false" onclick="setSendMode(1)">手动发送模式</a>
                </li>
              </ul>
              <div class="tab-content">
                <div id="tab-1" class="tab-pane active">
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="inline"><b class="label label-primary f-s"></b> - 接收人员：</h4><span style="font-style: italic">默认发送列表的前1000名人员</span>
                      <div class="row">
                        <form id="contact_search_form" name="contact_search_form" class="form-inline">
                          <div class="form-group">
                            <label for="startDate" class="sr-only">批次</label>
                            <input type="text" placeholder="请输入批次" id="q_batch" name="batch" class="form-control" >
                          </div>
                          <div class="form-group">
                            <label for="endDate" class="sr-only">模板</label>
                            <select type="text" id="q_templateId" name="q_templateId" class="form-control">
                              <option value="">选择模板</option>
                            </select>
                          </div>
                          <div class="form-group">
                            <label for="q_region" class="sr-only">地区</label>
                            <input type="hidden" id="q_region" class="form-control">
                            <input type="text" placeholder="请选择地区" id="q_region_name" onclick="showQueryRegion()"
                                   class="form-control" readonly style="width:150px; ">
                          </div>
                          <div class="form-group">
                            <label for="keywords" class="sr-only">接收次数</label>
                            <input type="text" placeholder="请输入接收次数" id="q_receiveCount" name="q_receiveCount"
                                   class="form-control" style="width:150px; ">
                          </div>
                          <div class="form-group">
                            <button type="button" class="btn btn-primary" onclick="refreshContactGrid()"><i
                              class="fa fa-search"></i>查询
                            </button>
                            <button type="button" class="btn btn-white" onclick="clearUserCondition(true)"><i
                              class="fa fa-recycle"></i>清空条件

                          </div>

                        </form>
                      </div>

                    </div>
                    <div class="panel-body">
                      <table id="contact_list"></table>
                    </div>
                  </div>
                </div>
                <div id="tab-2" class="tab-pane">
                  <textarea placeholder="请输入电话号码,多个号码回车分隔" id="phones" name="phones" class="form-control" style="height: 200px;"></textarea>
                </div>
              </div>
            </div>

          </div>
          <div class="col-xs-4">
            <h4 class="inline"><b class="label label-primary f-s" id="region_list_title"></b> - 短信信息：</h4>
            <form class="panel-body form-horizontal" id="sms_form">
              <input type="hidden" class="form-control" name="id" id="id"/>
              <input type="hidden" class="form-control" name="smsSendMode" id="smsSendMode" value="0"/>
              <div class="form-group">
                <label for="templateId" class="sr-only">批次</label>
                <input type="text" placeholder="批次" id="batch" name="batch" class="form-control"/>
              </div>
              <div class="form-group">
                <label for="templateId" class="sr-only">短信通道</label>
                <select id="smsChannel" name="smsChannel" class="form-control">
                  <option value="0" selected="selected">默认通道</option>
                  <option value="1" >企业信使</option>
                </select>
              </div>
              <div class="form-group">
                <label for="templateId" class="sr-only">短信模板</label>
                <select id="templateId" name="templateId" class="form-control" onchange="templateChange(this)">
                  <option value="">选择模板</option>
                </select>
              </div>
              <div class="form-group">
                <label for="content" class="sr-only">示例内容</label>
                <textarea placeholder="示例内容" id="content_view" name="content_view" class="form-control"
                          readonly></textarea>
              </div>

              <div class="form-group">
                <label for="content" class="sr-only">参数内容</label>
                <textarea placeholder="参数内容" id="paramJson" name="paramJson" class="form-control"></textarea>
              </div>
            <#--<div class="form-group">
              <label for="addressee" class="sr-only">手机号码</label>
              <textarea placeholder="手机号码(多个以逗号分隔)" id="users" name="users" class="form-control"></textarea>
            </div>-->
              <div class="form-group">
                <label for="remarks" class="sr-only">备注</label>
                <input type="text" placeholder="备注" id="remarks" name="remarks" class="form-control"/>
              </div>
            </form>
          </div>

        </div>

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

<#--发送记录-->
<div class="modal" id="recordModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg" style="width: 80%;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
          class="sr-only">关闭</span>
        </button>
        <h4 class="modal-title">
          <i class="fa fa-group"></i>
          <b id="modal_title"></b>短信发送记录
        </h4>
      </div>

      <div class="modal-body">
          <#include "/operation/sms/record/index.ftl">
      </div>
      <#--<div class="modal-footer">
        <button type="button" class="btn btn-white" data-dismiss="modal"><i class="fa fa-close"></i>取消</button>
      </div>-->
    </div>
  </div>
</div>
<#--/发送记录-->
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
        <button type="button" class="btn btn-primary block m-b" style="width: 50px; float: right;"
                onclick="confirmQueryRegion()">确定
        </button>
      </div>
    </div>
  </div>
</div>
</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/operation/sms/record/index.js"></script>
<script src="${ctx!}/admin/pub/js/operation/sms/index.js"></script>
<script src="${ctx!}/admin/pub/js/operation/sms/region_tree.js"></script>
<script src="${ctx!}/admin/js/plugins/layer/laydate/laydate.js"></script>

  <@fancytree/>
</@htmlJs>