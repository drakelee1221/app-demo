package com.drakelee.demo.common.constants;

/**
 * 支付宝预下单类型
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-23 14:21
 */
public enum PreCreateType {
  ORDER(1),
  RECHARGE(2);
  private int val;
  PreCreateType(int i) {
    this.val = i;
  }

  public int getVal() {
    return val;
  }
}
