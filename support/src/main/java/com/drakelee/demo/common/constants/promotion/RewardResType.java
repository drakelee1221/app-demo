package com.drakelee.demo.common.constants.promotion;

/**
 * RewardLotteryType 奖品结果类型
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/5/17 0017 10:19
 */
public enum RewardResType {

  NOTHING(0, "无奖励"),
  FORM(1, "服务填表"),
  AMOUNT(2, "余额"),
  COUPONS(3, "优惠券");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  RewardResType(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }

}
