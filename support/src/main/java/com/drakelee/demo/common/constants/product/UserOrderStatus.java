package com.drakelee.demo.common.constants.product;

/**
 * 前台客户端订单状态
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/19 0019 14:43
 */
public enum UserOrderStatus {

  /**
   * 未支付
   */
  UNPAID(0),

  /**
   * 待确认
   */
  NOT_CONFIRM(1),

  /**
   * 已确认
   */
  CONFIRM(2),

  /**
   * 已取消
   */
  CANCEL(3),

  /**
   * 已退款
   */
  REFUND(4),

  /**
   * 收集资料，准备服务
   */
  COLLECT(5),

  /**
   * 创建服务，转移给专业人员，订单完成
   */
  FINISH(6),

  /**
   * 已评价
   */
  EVALUATE(7);

  private int val;

  UserOrderStatus(int val){
    this.val = val;
  }

  public int getVal(){
    return val;
  }

}
