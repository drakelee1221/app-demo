package com.drakelee.demo.common.constants;

/**
 * 已读标志
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/17 0017 14:16
 */
public enum KnowStatus {

  /**
   * 未读
   */
  UNREAD(0),

  /**
   * 已读
   */
  READ(1);

  private int status;

  KnowStatus(int status){
    this.status = status;
  }

  public int getStatus(){
    return status;
  }
}
