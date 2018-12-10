package com.drakelee.demo.common.constants.product;

/**
 * 支付状态
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-19 13:52
 */
public enum PayStatus {
  pay_success("支付成功",1),
  un_pay("待支付",0),
  pay_fail("支付失败",2),
  paying("支付中",3);
  private String desc;
  private Integer val;
  PayStatus(String desc, int val) {
    this.desc = desc;
    this.val = val;
  }

  public String getDesc() {
    return desc;
  }

  public Integer getVal() {
    return val;
  }
}
