package com.drakelee.demo.common.constants.pay;

/**
 * 交易状态：WAIT_BUYER_PAY（交易创建，等待买家付款）、
 TRADE_CLOSED（未付款交易超时关闭，或支付完成后全额退款）、
 TRADE_SUCCESS（交易支付成功）、
 TRADE_FINISHED（交易结束，不可退款）
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-04-28 14:26
 */
public enum AliPayTradeStatus {
  WAIT_BUYER_PAY("WAIT_BUYER_PAY","交易创建，等待买家付款"),
  TRADE_CLOSED("TRADE_CLOSED","未付款交易超时关闭，或支付完成后全额退款"),
  TRADE_SUCCESS("TRADE_SUCCESS","交易支付成功"),
  TRADE_FINISHED("TRADE_FINISHED","交易结束，不可退款");

  private String code;
  private String desc;
  AliPayTradeStatus(String code, String desc) {
    this.code = code;
    this.desc = desc;
  }

  public String getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }
}
