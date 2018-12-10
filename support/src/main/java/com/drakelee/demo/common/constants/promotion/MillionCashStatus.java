package com.drakelee.demo.common.constants.promotion;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/5/22 0022 14:47
 */
public enum MillionCashStatus {

  APPLY(0),
  FIRST_TRIAL(1),
  FINAL_JUDGMENT(2),
  SERVICE_START(3),
  REWARD(4),
  REJECT(9);

  private int val;

  MillionCashStatus(int val){
    this.val = val;
  }

  public int getVal(){
    return val;
  }
}
