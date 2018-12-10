package com.drakelee.demo.common.constants.sms;

/**
 * SmsType
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-04-03 16:20
 */
public enum SmsType {
  SYSTEMSMS(0),
  ADMINSMS(1);

  private int val;
  SmsType(int val) {
    this.val = val;
  }

  public int getVal() {
    return val;
  }
}
