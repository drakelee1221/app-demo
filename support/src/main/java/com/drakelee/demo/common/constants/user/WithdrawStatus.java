package com.drakelee.demo.common.constants.user;

/**
 * 提现状态
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-19 15:02
 */
public enum WithdrawStatus {
  un_audit("待审核",0),
  audited("已审核",1),
  payed("已打款",2),
  reject("已驳回",3);
  private String desc;
  private int val;

  WithdrawStatus(String desc, int val) {
    this.desc = desc;
    this.val = val;
  }

  public String getDesc() {
    return desc;
  }

  public int getVal() {
    return val;
  }
}
