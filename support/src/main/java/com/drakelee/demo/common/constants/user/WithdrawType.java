package com.drakelee.demo.common.constants.user;

/**
 * 提现方式
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-19 14:21
 */
public enum WithdrawType {
  alipay("支付宝",0),
  bank("银行卡",1);


  private String desc;
  private Integer val;
  WithdrawType(String desc, int val) {
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
