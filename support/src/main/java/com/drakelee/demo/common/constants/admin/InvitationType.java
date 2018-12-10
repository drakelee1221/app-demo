package com.drakelee.demo.common.constants.admin;

/**
 * Marriage 婚姻状况
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/6/13 0013 14:50
 */
public enum InvitationType {

  USER_SERIAL_NUMBER,
  ORG_SERIAL_NUMBER;

  InvitationType() {

  }

  public String getDesc() {
    return desc;
  }

  private String desc;



}
