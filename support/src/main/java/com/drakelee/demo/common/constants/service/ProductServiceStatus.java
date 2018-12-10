package com.drakelee.demo.common.constants.service;

/**
 * 服务状态
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/17 0017 10:25
 */
public enum ProductServiceStatus {

  /**
   * 未开始
   */
  NOT_STARTED(0),

  /**
   * 服务中
   */
  SERVICE(1),

  /**
   * 已完结，非周期性服务结束之后为已完结，周期性服务结束以后为已过期
   */
  FINISH(2),

  /**
   * 待续费
   */
  RENEW(3),

  /**
   * 驳回
   */
  REJECT(4),

  /**
   * 已过期，非周期性服务结束之后为已完结，周期性服务结束以后为已过期
   */
  EXPIRED(5),
  /**
   * 作废
   */
  INVALID(6),
  /**
   * 冻结
   */
  FREEZE(7),
  /**
   * 已退款
   */
  REFUNDED(8),
  ;

  private int status;

  ProductServiceStatus(int status){
    this.status = status;
  }

  public int getStatus(){
    return status;
  }
}
