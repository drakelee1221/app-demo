package com.drakelee.demo.common.constants.information;

/**
 * ReplyQuickType
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/6/19 0019 16:32
 */
public enum ReplyQuickType {
  CONSULT(1, "咨询"),
  REFUND(2, "退款"),
  REJECT(3, "驳回");


  public int getCode() {
    return code;
  }


  private int code;
  private String desc;



  ReplyQuickType(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }


}
