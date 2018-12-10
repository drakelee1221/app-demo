package com.drakelee.demo.common.constants.service;

/**
 * 后台管理查询服务状态
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/17 0017 10:25
 */
public enum AdminProductServiceStatus {

  /**
   * 未开始
   */
  NOT_STARTED(0),

  /**
   * 服务中
   */
  SERVICE(1),

  /**
   * 已完结
   */
  FINISH(2),

  /**
   * 待续费
   */
  RENEW(3),

  /**
   * 驳回
   */
  REJECT(3);

  private int status;

  AdminProductServiceStatus(int status){
    this.status = status;
  }

  public int getStatus(){
    return status;
  }
}
