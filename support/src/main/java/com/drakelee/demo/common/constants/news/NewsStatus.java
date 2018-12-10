package com.drakelee.demo.common.constants.news;

/**
 * NewsStatus
 *
 * @author <a href="lijian_jie@163.com">LiJian</a>
 * @version 1.0.0, 2018-03-27 14:08
 */
public enum NewsStatus {
  /**
   * 草稿
   */
  draft(0),
  /**
   * 发布
   */
  issue(1),
  /**
   * 删除
   */
  delete(2);

  private int val;
  NewsStatus(int val) {
    this.val = val;
  }

  public int getVal() {
    return val;
  }
}
