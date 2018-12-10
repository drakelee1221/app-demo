package com.drakelee.demo.common.constants.product;

/**
 * 订单数据来源,用户数据来源
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/6/15 0015 13:45
 */
public enum DataSource {
  PC(0),
  MOBILE(1),
  /**
   * 通过存量订单数据导入的用户
   */
  HISTORICAL(2),
  ;

  private int val;

  DataSource(int val){
    this.val = val;
  }

  public int getVal() {
    return val;
  }
}
