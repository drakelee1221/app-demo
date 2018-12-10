package com.drakelee.demo.common.constants.callme;

/**
 * CallMeStatus
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/3/28 0028 10:54
 */
public enum CallMeStatus {


  DEALING(0, "未分配"),
  DISTRIBUTED(1, "未处理"),
  DEALED(2, "已处理");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  public String getDesc() {
    return desc;
  }

  public static CallMeStatus getByCode(int code) {
    for (CallMeStatus item : CallMeStatus.values()) {
      if (item.code == code) {
        return item;
      }
    }
    return null;
  }

  CallMeStatus(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }

}
