  <div class="m-t-sm">
    <table id="service_list"></table>
  </div>
  <ul class="nav nav-tabs m-t-md" id="serviceTab">
    <li class="active"><a data-toggle="tab" href="#tab-35" id="info_tab" aria-expanded="true">产品详情</a>
    </li>
    <li class=""><a data-toggle="tab" href="#tab-31" aria-expanded="false">服务日志</a>
    </li>
    <li class=""><a data-toggle="tab" href="#tab-32" aria-expanded="false">服务人员</a>
    </li>
    <li class=""><a data-toggle="tab" href="#tab-33" aria-expanded="false">投诉记录</a>
    </li>
    <li class=""><a data-toggle="tab" href="#tab-34" aria-expanded="false">签约记录</a>
    </li>
  </ul>
  <div class="tab-content">
    <div id="tab-35" class="tab-pane active">
      <div class="panel-body">
        <table id="info_list"></table>
      </div>
    </div>
    <div id="tab-31" class="tab-pane ">
      <div class="panel-body">
        <table id="log_list"></table>
      </div>
    </div>
    <div id="tab-32" class="tab-pane">
      <div class="panel-body">
        <table id="servicer_list"></table>
      </div>
    </div>
    <div id="tab-33" class="tab-pane">
      <div class="panel-body">
        <table id="complain_list"></table>
      </div>
    </div>
    <div id="tab-34" class="tab-pane">
      <div class="panel-body">
        <table id="sign_list"></table>
      </div>
    </div>
  </div>
<script src="${ctx!}/admin/pub/js/user/manager/serviceDetail.js"></script>
<script src="${ctx!}/admin/pub/js/util/numberFormat.js"></script>