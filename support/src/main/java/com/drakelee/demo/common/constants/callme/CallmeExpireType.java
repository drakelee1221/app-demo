package com.drakelee.demo.common.constants.callme;

/**
 * CallmeExpireType 联系时间类型枚举
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/17 0017 09:39
 */
public enum CallmeExpireType {

  RIGHNOW(0, "立即"),
  FREETIME(1, "非工作时间"),
  ANYTIME(2, "随时");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }

  public static CallmeExpireType getByCode(int code) {
    for (CallmeExpireType item : CallmeExpireType.values()) {
      if (item.code == code) {
        return item;
      }
    }
    return null;
  }

  CallmeExpireType(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }



}
