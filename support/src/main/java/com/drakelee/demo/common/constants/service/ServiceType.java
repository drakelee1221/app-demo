package com.drakelee.demo.common.constants.service;

/**
 * 服务类型
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-22 16:02
 */
public enum ServiceType{
  /**
   * 一次性服务
   */
  ONCE(0),
  /**
   * 周期性服务
   */
  CYCLE(1);
  private int val;
  ServiceType(int i) {
    this.val = i;
  }

  public int getVal() {
    return val;
  }
}
