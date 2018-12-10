package com.drakelee.demo.common.constants.user;

/**
 * PayCachePrefix
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-04-02 11:34
 */
public enum PayCachePrefix {
  ORDER_PAY_PREFIX("order_pay_prefix_"),
  RECHARGE_PAY_PREFIX("recharge_pay_prefix_");

  private String name;
  PayCachePrefix(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }
}
