<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
<input type="hidden" id="userId" value="${id}">
<div class="panel panel-default">
  <div class="panel-body">
    <div class="tabs-container">
      <ul class="nav nav-tabs" id="userDetail">
        <li class="active"><a data-toggle="tab" href="#userDetail-tab-1" aria-expanded="true"> 用户信息</a>
        </li>
        <#--<li class=""><a data-toggle="tab" href="#userDetail-tab-2" aria-expanded="false">用户订单</a>-->
        <#--</li>-->
        <#--<li class=""><a data-toggle="tab" href="#userDetail-tab-3" aria-expanded="false">服务项目</a>-->
        <#--</li>-->
        <li class=""><a data-toggle="tab" href="#userDetail-tab-4" aria-expanded="false">用户日志</a>
        </li>
      </ul>
      <div class="tab-content">
        <div id="userDetail-tab-1" class="tab-pane active">
          <div class="panel-body">

          </div>
        </div>
        <#--<div id="userDetail-tab-2" class="tab-pane">-->
          <#--<div class="panel-body">-->

          <#--</div>-->
        <#--</div>-->
        <#--<div id="userDetail-tab-3" class="tab-pane">-->
          <#--<div class="panel-body">-->
          <#--</div>-->
        <#--</div>-->
        <div id="userDetail-tab-4" class="tab-pane">
          <div class="panel-body">
            <div class="col-xs-4 text-right m-b-sm">
              <b>最后登录时间：</b>
            </div>
            <div class="col-xs-8 m-b-sm min-h">${user.lastLoginTime}</div>
            <div class="col-xs-4 text-right m-b-sm">
              <b>最后登录IP：</b>
            </div>
            <div class="col-xs-8 m-b-sm min-h">${user.lastLoginIp}</div>
          </div>
        </div>
        <div id="userDetail-tab-5" class="tab-pane">
          <div class="panel-body">

          </div>
        </div>
        <div id="userDetail-tab-6" class="tab-pane">
          <div class="panel-body">

          </div>
        </div>
      </div>
    </div>
  </div>
</div>

</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/pub/js/user/manager/detail.js"></script>

  <@fancytree/>
</@htmlJs>