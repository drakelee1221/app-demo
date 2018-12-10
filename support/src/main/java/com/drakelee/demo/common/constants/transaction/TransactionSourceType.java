package com.drakelee.demo.common.constants.transaction;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/11/23 0023 09:37
 */
public enum TransactionSourceType {
  /**
   * 订单
   */
  ORDER(0, "订单编码"),
  /**
   * 推荐用户订购
   */
  REFERRER(1, "推荐用户订购"),
  /**
   * 分享注册
   */
  SHARE_REGIST(2, "分享注册"),
  /**
   * 提现
   */
  WITHDRAW(3, "提现号码"),
  /**
   * 线下充值
   */
  RECHARGE_OFFLINE(4, "线下充值"),
  /**
   * 线下充值
   */
  RECHARGE_OFFLINE_GIFT(5, "线下充值赠送"),
  /**
   * 线上充值
   */
  RECHARGE_ONLINE(5, "线上充值"),
  /**
   * 线上退款
   */
  REFUND_ONLINE(6, "线上退款"),
  /**
   * 订单中途退款失败
   */
  PROCESSING_REFUND_FAILD(7, "退款失败"),
  /**
   * 订单中途退款成功
   */
  PROCESSING_REFUND_SUCCESS(8, "退款成功"),
  /**
   * 活动获得
   */
  PROMOTION(9, "活动获得"),

  ;

  private int val;

  private String decs;

  public int getVal() {
    return val;
  }

  public String getDecs() {
    return decs;
  }

  TransactionSourceType(int val, String desc){
    this.val = val;
    this.decs = desc;
  }
}
