<#include "/layout/pagelayout.ftl"/>

<@htmlContent>
 <div class="wrapper wrapper-content">
   <h3>数据仪表盘</h3>
   <hr>
   <div class="row">
     <div class="col-xs-12">
       <div class="row">
         <div class="col-xs-12">
           <div class="row row-sm text-center">
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="h1 text-fff font-thin h1" id="users"></div>
                 <span class="text-fff text-xs">注册用户</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="h1 text-fff font-thin h1" id="companies"></div>
                 <span class="text-fff text-xs">签约企业</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="h1 text-fff font-thin h1" id="orderAmount"></div>
                 <span class="text-fff text-xs">订单金额</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="h1 text-fff font-thin h1" id="todayOrders"></div>
                 <span class="text-fff text-xs">今日订单</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="font-thin h1" id="todayAmount"></div>
                 <span class="text-fff text-xs">今日成交</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="font-thin h1" id="todayRecharge"></div>
                 <span class="text-fff text-xs">今日充值</span>
               </div>
             </div>
           </div>
         </div>
       </div>
       <div class="row">
         <div class="col-xs-12" style="padding-right:0;">
           <div class="ibox float-e-margins">
             <div class="ibox-title" style="border-bottom:none;background:#fff;">
               <h5>用户增长趋势图</h5>
             </div>
             <div class="ibox-content" style="border-top:none;">
               <div id="echarts-line-chart" style="height:217px;">
               </div>
             </div>
           </div>
         </div>
       </div>
       <h3>运营数据</h3>
       <div class="row">
         <div class="col-xs-12">
           <div class="row row-sm text-center">
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="h1 text-fff font-thin h1 cursor-pointer" onclick="parent.index.showNavAnother('/admin/operation/callme/index?status=1', true)" id="callme"></div>
                 <span class="text-fff text-xs">未处理CALLME</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="h1 text-fff font-thin h1 cursor-pointer" onclick="parent.index.showNav('/admin/interactive/complain/index?status=0', true)" id="complains"></div>
                 <span class="text-fff text-xs">未处理投诉</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="h1 text-fff font-thin h1 cursor-pointer" id="consults" onclick="parent.index.showNav('/admin/service/consult/index?status=0', true)"></div>
                 <span class="text-fff text-xs">未回复咨询</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="font-thin h1 cursor-pointer" id="notice" onclick="parent.index.showNav('/admin/message/index?status=0', true)"></div>
                 <span class="text-fff text-xs">未查看通知</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="font-thin h1 cursor-pointer" id="supply" onclick="parent.index.showNav('/admin/operation/cooperation/info/index?status=0&type=1', true)"></div>
                 <span class="text-fff text-xs">未处理供应</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="h1 text-fff font-thin h1 cursor-pointer" id="demand" onclick="parent.index.showNav('/admin/operation/cooperation/info/index?status=0&type=0', true)"></div>
                 <span class="text-fff text-xs">未处理需求</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary" onclick="parent.index.showNav('/admin/order/index?status=1', true)">
                 <div class="h1 text-fff font-thin h1 cursor-pointer" id="unorder"></div>
                 <span class="text-fff text-xs">未处理订单</span>
               </div>
             </div>
           </div>
         </div>
       </div>
       <h3>登录数据</h3>
       <div class="row">
         <div class="col-xs-12">
           <div class="row row-sm text-center">
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="h1 text-fff font-thin h1" id="sevenDaysManager"></div>
                 <span class="text-fff text-xs">7天未登录人员</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="h1 text-fff font-thin h1" id="fifteenDaysManager"></div>
                 <span class="text-fff text-xs">15天未登录人员</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="h1 text-fff font-thin h1" id="thirtyDaysManager"></div>
                 <span class="text-fff text-xs">30天未登录人员</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="h1 text-fff font-thin h1" id="sevenDaysUser"></div>
                 <span class="text-fff text-xs">7天未登录用户</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item bg-primary">
                 <div class="font-thin h1" id="fifteenDaysUser"></div>
                 <span class="text-fff text-xs">15天未登录用户</span>
               </div>
             </div>
             <div class="col-xs-4">
               <div class="panel padder-v item blue-bg">
                 <div class="font-thin h1" id="thirtyDaysUser"></div>
                 <span class="text-fff text-xs">30天未登录用户</span>
               </div>
             </div>
           </div>
         </div>
       </div>
       <hr>
     </div>
   </div>
 </div>

</@htmlContent>

<@htmlJs>
<script src="${ctx!}/admin/js/plugins/echarts/echarts.min.js"></script>
<script src="${ctx!}/admin/pub/js/common/home.js"></script>
<script src="${ctx!}/admin/pub/js/util/numberFormat.js"></script>
<script src="${ctx!}/admin/js/plugins/layer/laydate/laydate.js"></script>

</@htmlJs>