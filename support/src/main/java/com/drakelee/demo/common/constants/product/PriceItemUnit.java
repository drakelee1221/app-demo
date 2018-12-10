package com.drakelee.demo.common.constants.product;

/**
 * 定价项单位
 *  0、月，1、年，2、次，3、人
 * @author <a href="lijian@xianyunsoft.com">Lijian</a>
 * @version 1.0.0, 2017-12-12
 */
public enum PriceItemUnit {
  none(-1, "无"),
  month(0, "月"),
  year(1, "年"),
  time(2, "次"),
  person(3, "人"),
  individual(4, "个"),
  part(5, "份");
  private int val;
  private String name;
  PriceItemUnit(int val, String desc) {
    this.val = val;
    this.name = desc;

  }

  public int getVal() {
    return val;
  }

  public String getName() {
    return name;
  }

}

