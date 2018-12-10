package com.drakelee.demo.common.constants.callme;

/**
 * PlatformType
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/5/28 0028 17:22
 */
public enum PlatformType {

  PC(1, "PC端"),
  MOBILE(2, "移动端");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }

  PlatformType(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }


}
