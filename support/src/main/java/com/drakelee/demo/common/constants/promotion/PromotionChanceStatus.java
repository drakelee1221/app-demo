package com.drakelee.demo.common.constants.promotion;

/**
 * PromotionChanceStatus 获奖机会状态
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/5/17 0017 11:14
 */
public enum PromotionChanceStatus {

  USED(1, "已使用"),
  UNUSED(0, "未使用");

  private int code;

  private String desc;

  public int getCode() {
    return code;
  }


  PromotionChanceStatus(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }

}
