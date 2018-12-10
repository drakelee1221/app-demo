package com.drakelee.demo.common.constants.product;

/**
 * OrderLogName 订单操作日志名称枚举值
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/4/26 0026 15:38
 */
public enum OrderLogName {

  PLACE("下单"),
  PAY_ONLINE("线上付款"),
  PAY_OFFLINE("线下付款"),
  MANAGER_CALL_BACK("客服回访"),
  CANCEL("取消订单"),
  REFUND_OFFLINE("线下退款"),
  REFUND_ONLINE("线上退款"),
  EDIT("修改订单"),
  CONFIRM("确认订单"),
  PREPARE("服务准备"),
  RESOURCE_PREPARE("资料收集"),
  INVOICE("开具发票"),
  FINISH("订单完成/开始服务"),
  EVALUATE("评价"),
  REJECT("驳回"),
  TRAN("转移服务"),
  RENEW("续签"),
  COUPONS("发放优惠券"),
  REQUEST_REFUND("申请退款"),
  REFUSE_REFUND("拒绝退款"),
  CONFIRM_REFUND("确认退款"),
  ;



  private String name;

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  OrderLogName(String name) {
    this.name = name;
  }




}
