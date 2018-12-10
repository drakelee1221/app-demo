package com.drakelee.demo.common.constants.product;

import com.google.common.collect.Sets;

import java.util.HashSet;
import java.util.Set;

/**
 * 后台系统订单状态
 *
 * @author <a href="lijian@xianyunsoft.com">Lijian</a>
 * @version 1.0.0, 2017-12-12
 */
public enum OrderStatus {
  PLACE_ORDER(1, "下单"),
  CALLBACK(2, "客服回访"),
  UNPAID(3, "待确认"),
  CONFIRM(4, "已确认"),
  CANCEL(5, "取消订单"),
  REFUND(6, "已退款"),
  COLLECT_DATA(7, "已收集资料"),
  INVOICE(8, "已开发票"),
  PLAN_SERVICE(9, "准备开始服务"),
  NOT_EVALUATE(10, "未评价"),
  EVALUATE(11, "已评价"),
  TRANSFER_SERVICE(12, "未确认服务"),
  REJECT(13, "驳回"),
  SERVICING(14, "开始服务"),
  REFUND_ING(15, "退款中"),
  REFUND_FAIL(16, "退款失败"),
  INVALID(17, "作废");
  private int val;
  private String name;
  OrderStatus(int val, String desc) {
    this.val = val;
    this.name = desc;

  }

  public int getVal() {
    return val;
  }

  public String getName() {
    return name;
  }

  /** 分销模式中，失效的订单状态集合 */
  private static final Set<OrderStatus> DISTRIBUTION_INVALID_STATUS =
    Sets.immutableEnumSet(CANCEL, REFUND, REFUND_ING, REFUND_FAIL, INVALID);

  /** 分销模式中，有效的订单状态集合 */
  public static Set<Integer> getDistributionEffectiveStatus(){
    Set<Integer> status = new HashSet<>();
    for (OrderStatus os : values()) {
      if(!DISTRIBUTION_INVALID_STATUS.contains(os)){
        status.add(os.val);
      }
    }
    return status;
  }

  /**
   * 通过后台订单状态获取前台客户的订单状态
   *
   * @return
   */
  public UserOrderStatus getUserOrderStatus(){
    switch (this){
      case PLACE_ORDER:
        return UserOrderStatus.UNPAID;
      case CALLBACK: case UNPAID:
        return UserOrderStatus.NOT_CONFIRM;
      case CONFIRM:
        return UserOrderStatus.CONFIRM;
      case CANCEL:
        return UserOrderStatus.CANCEL;
      case REFUND:
        return UserOrderStatus.REFUND;
      case COLLECT_DATA: case INVOICE:
        return UserOrderStatus.COLLECT;
      case EVALUATE:
        return UserOrderStatus.EVALUATE;
      default:
        return UserOrderStatus.FINISH;
    }
  }

  /**
   * 通过后台订单状态获取前台客户经理的订单状态
   *
   * @return
   */
  public ManagerOrderStatus getManagerOrderStatus(){
    switch (this){
      case PLACE_ORDER:
        return ManagerOrderStatus.UNPAID;
      case CALLBACK: case UNPAID:
        return ManagerOrderStatus.NOT_CONFIRM;
      case CONFIRM:
        return ManagerOrderStatus.CONFIRM;
      case CANCEL:
        return ManagerOrderStatus.CANCEL;
      case REFUND:
        return ManagerOrderStatus.REFUND;
      case COLLECT_DATA: case INVOICE:
        return ManagerOrderStatus.COLLECT;
      case EVALUATE:
        return ManagerOrderStatus.EVALUATE;
      case TRANSFER_SERVICE:
        return ManagerOrderStatus.TRANSFORM;
      case REJECT:
        return ManagerOrderStatus.REJECT;
      case SERVICING:
        return ManagerOrderStatus.SERVICING;
      default:
        return ManagerOrderStatus.SERVICING;
    }
  }
}

