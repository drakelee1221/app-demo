package com.drakelee.demo.common.constants.promotion;

/**
 * RewardLotteryType 奖品抽奖类型
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/5/17 0017 10:19
 */
public enum RewardLotteryType {

  NOT_LOTTERY(0, "不抽奖"),
  AUTO(1, "自动抽奖"),
  MANUAL(2, "手动抽奖");

  private int code;
  private String desc;

  public int getCode() {
    return code;
  }

  RewardLotteryType(int code, String desc) {
    this.code = code;
    this.desc = desc;
  }

}
