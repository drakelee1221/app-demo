package com.drakelee.demo.common.constants.service;

/**
 * 投诉状态
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/17 0017 16:04
 */
public enum ComplainStatus {

  /**
   * 待处理
   */
  UNTREATED(0),

  /**
   * 已回复
   */
  REPLY(1),

  /**
   * 完结
   */
  FINISH(2);

  private int val;

  ComplainStatus(int val){
    this.val = val;
  }

  public int getVal(){
    return this.val;
  }
}
