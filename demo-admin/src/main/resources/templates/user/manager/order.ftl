<div class="panel panel-default">
  <div class="panel-heading">
    <form id="orderSearchForm" name="orderSearchForm">
      <div class="form-inline">
        <div class="form-group">
          <select id="p_type" name="productType" class="form-control">
            <option value="">产品类别</option>
          </select>
        </div>
        <div class="form-group">
          <select id="product" name="product" class="form-control">
            <option value="">产品</option>
          </select>
        </div>
        <div class="form-group">
          <select id="status" name="status" class="form-control">
            <option value="">全部状态</option>
            <option value="1">下单</option>
            <option value="2">客服回访</option>
            <option value="3">待支付</option>
            <option value="4">已确认</option>
            <option value="5">取消订单</option>
            <option value="6">已退款</option>
            <option value="7">已收集资料</option>
            <option value="8">已开发票</option>
            <option value="9">准备开始服务</option>
            <option value="10">未评价</option>
            <option value="11">已评价</option>
            <option value="12">未确认服务</option>
            <option value="13">驳回</option>
            <option value="14">开始服务</option>
          </select>
        </div>
        <div class="form-group">
          <input type="text" placeholder="请选择开始时间" id="startTime" name="startTime" class="form-control layer-date">
        </div>
        <div class="form-group">
          <input type="text" placeholder="请选择结束时间" id="endTime" name="endTime" class="form-control layer-date">
        </div>
        <div class="form-group">
          <input type="hidden" name="userId" id="userId" value="${userId}" class="form-control">
          <input type="hidden" name="managerId" id="managerId" value="${managerId}" class="form-control">
        </div>
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

<#include "/order/orderinfo.ftl">
<script src="${ctx!}/admin/pub/js/order/orderinfo.js"></script>
<script src="${ctx!}/admin/pub/js/util/numberFormat.js"></script>
<script src="${ctx!}/admin/pub/js/order/index.js"></script>
