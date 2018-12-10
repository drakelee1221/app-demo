

package com.drakelee.demo.common.constants.sms;

/**
 * 短信发送状态
 *
 * @author <a href="drakelee1221@gmail.com">LiGeng</a>
 * @version 1.0.0, 2017-07-08 14:01
 */
public enum SmsSendStatus {
  UN_SEND(0),
  SEND(1),
  SEND_FAIL(2);


  private int val;

  public int getVal() {
    return val;
  }


  SmsSendStatus(int val) {
    this.val = val;
  }
}
