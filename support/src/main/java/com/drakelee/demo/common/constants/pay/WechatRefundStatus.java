package com.drakelee.demo.common.constants.pay;

/**
 * WechatRefundStatus
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-05-14 15:23
 */
public enum WechatRefundStatus {
  SUCCESS("SUCCESS","退款成功"),
  CHANGE("CHANGE","退款异常"),
  REFUNDCLOSE("REFUNDCLOSE","退款关闭");

  private String code;
  private String desc;
  WechatRefundStatus(String code, String desc) {
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
