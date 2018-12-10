

package com.drakelee.demo.common.constants.sys;

/**
 * 优惠卷使用范围
 */
public enum CouponsScope {
  ALL(1,"所有人"),

  OWN(2,"本人"),

  OTHERS(3,"非本人");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }


  CouponsScope(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }

}
