package com.drakelee.demo.common.constants.supplyDemand;

/**
 * 供需类型
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/16 0016 10:04
 */
public enum SupplyDemandType {

  /**
   * 供应
   */
  SUPPLY(1,"供应"),

  /**
   * 需求
   */
  DEMAND(0,"需求");

  private int type;
  private String desc;
  SupplyDemandType(int type,String desc){
    this.type = type;
    this.desc = desc;
  }

  public int getType(){
    return type;
  }

  public String getDesc() {
    return desc;
  }
}
