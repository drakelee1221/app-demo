package com.drakelee.demo.common.constants.supplyDemand;

/**
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/30 0030 15:04
 */
public enum SupplyDemandExpire {

  THREE(3),
  SEVEN(7),
  FIFTEEN(15),
  THIRTY(30),
  ;
  private int val;

  SupplyDemandExpire(int val){
    this.val = val;
  }
  public int getVal(){
    return val;
  }
}
