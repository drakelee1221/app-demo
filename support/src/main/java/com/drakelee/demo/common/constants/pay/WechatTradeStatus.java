package com.drakelee.demo.common.constants.pay;

/**
 *SUCCESS—支付成功
 REFUND—转入退款
 NOTPAY—未支付
 CLOSED—已关闭
 REVOKED—已撤销（刷卡支付）
 USERPAYING--用户支付中
 PAYERROR--支付失败(其他原因，如银行返回失败)
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-04-28 14:26
 */
public enum WechatTradeStatus {
  SUCCESS("SUCCESS","支付成功"),
  REFUND("REFUND","转入退款"),
  NOTPAY("NOTPAY","未支付"),
  REVOKED("REVOKED","已撤销（刷卡支付）"),
  USERPAYING("USERPAYING","用户支付中"),
  PAYERROR("PAYERROR","支付失败(其他原因，如银行返回失败)");

  private String code;
  private String desc;
  WechatTradeStatus(String code, String desc) {
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
