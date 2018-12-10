package com.drakelee.demo.common.constants.supplyDemand;

/**
 * 供需单状态
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/16 0016 11:31
 */
public enum SupplyDemandStatus {

  /**
   * 未审核
   */
  NOT_AUDIT(0),

  /**
   * 已审核
   */
  AUDIT(1),

  /**
   * 上线
   */
  ONLINE(2),

  /**
   * 过期
   */
  EXPIRE(3),

  /**
   * 下线
   */
  OFFLINE(4),

  /**
   * 驳回
   */
  REJECT(5);

  private int status;

  SupplyDemandStatus(int status){
    this.status = status;
  }

  public int getStatus(){
    return status;
  }

}
