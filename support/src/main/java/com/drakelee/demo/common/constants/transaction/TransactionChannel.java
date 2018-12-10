package com.drakelee.demo.common.constants.transaction;

/**
 * 交易流水表交易渠道
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/19 0019 17:06
 */
public enum TransactionChannel {

  /**
   * 线下
   */
  OFFLINE(0,"线下"),

  /**
   * 支付宝
   */
  ALIPAY(1,"支付宝"),

  /**
   * 微信
   */
  WECHAT(2,"微信"),
  /**
   * 线上（余额支付）
   */
  ONLINE(3,"余额支付"),

  ALIPAY_BALANCE(4,"支付宝-余额"),

  WECHAT_BALANCE(5,"微信-余额"),

  PROMOTION_BALANCE(6,"活动-余额"),
  COUPONS(7,"优惠卷"),
  PLATFORM(8,"平台");

  private int val;
  private String desc;
  TransactionChannel(int val,String desc){
    this.val = val;
    this.desc = desc;
  }

  public int getVal() {
    return val;
  }

  public String getDesc() {
    return desc;
  }
}
