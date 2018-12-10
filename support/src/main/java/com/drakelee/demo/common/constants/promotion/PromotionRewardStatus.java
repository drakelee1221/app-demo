package com.drakelee.demo.common.constants.promotion;

/**
 * PromotionRewardStatus 获奖记录状态
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/5/17 0017 11:21
 */
public enum PromotionRewardStatus {
  RECEIVED(1, "已领取"),
  RECEIVING(0, "未领取");

  private int code;

  private String desc;

  public int getCode() {
    return code;
  }


  PromotionRewardStatus(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }

}
