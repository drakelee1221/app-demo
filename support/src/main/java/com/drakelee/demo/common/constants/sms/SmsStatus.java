

package com.drakelee.demo.common.constants.sms;

/**
 * 短信状态
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-08 14:01
 */
public enum SmsStatus {
  UN_SEND(0),
  COMPLETE(1),
  UN_COMPLETE(2);


  private int val;

  public int getVal() {
    return val;
  }


  SmsStatus(int val) {
    this.val = val;
  }
}
