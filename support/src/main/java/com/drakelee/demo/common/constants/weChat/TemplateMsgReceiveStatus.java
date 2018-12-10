package com.drakelee.demo.common.constants.weChat;

/**
 * TemplateMsgReceiveStatus
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-17 13:55
 */
public enum TemplateMsgReceiveStatus {
  SUCCESS("success",0),
  USER_BLOCK("user block",1),
  SYSTEM_FAILED("system failed",2);

  private Integer val;
  private String weChatVal;
  TemplateMsgReceiveStatus(String wxVal, int val) {
    this.val = val;
    this.weChatVal = wxVal;
  }

  public Integer getVal() {
    return val;
  }

  public String getWeChatVal() {
    return weChatVal;
  }
}
