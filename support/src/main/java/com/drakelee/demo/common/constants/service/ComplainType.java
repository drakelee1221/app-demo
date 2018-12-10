package com.drakelee.demo.common.constants.service;

/**
 * 投诉类型
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/17 0017 15:52
 */
public enum ComplainType {

  /**
   * 服务态度
   */
  ATTITUDE(0),

  /**
   * 服务质量
   */
  QUALITY(1),

  /**
   * 意见建议
   */
  OPINION(2),

  /**
   * 其他
   */
  OTHER(3);

  private int val;

  ComplainType(int val){
    this.val = val;
  }

  public int getVal(){
    return this.val;
  }
}
