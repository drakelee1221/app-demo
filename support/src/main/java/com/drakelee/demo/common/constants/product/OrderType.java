package com.drakelee.demo.common.constants.product;

/**
 * OrderType
 *
 * @author <a href="morse.jiang@foxmail.com">JiangWen</a>
 * @version 1.0.0, 2018/4/10 0010 11:31
 */
public enum OrderType {

  NEW_ORDER("新订单", 1),
  RENEW_ORDER("续签订单", 2),
  HISTORY_ORDER("历史订单",3);

  private String desc;
  private int type;

  OrderType(String desc, int type) {
    this.desc = desc;
    this.type = type;
  }

  public String getDesc() {
    return desc;
  }

  public int getType() {
    return type;
  }

}
