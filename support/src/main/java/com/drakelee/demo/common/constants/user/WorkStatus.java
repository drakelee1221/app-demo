package com.drakelee.demo.common.constants.user;

/**
 * WorkStatus
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-26 15:03
 */
public enum WorkStatus {
  unworking(0),
  working(1);

  private int val;
  WorkStatus(int val) {
    this.val = val;
  }

  public int getVal() {
    return val;
  }
}
