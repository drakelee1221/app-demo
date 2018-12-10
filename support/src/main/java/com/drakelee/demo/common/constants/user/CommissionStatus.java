package com.drakelee.demo.common.constants.user;

/**
 * 用户下级的状态
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/11/6 0006 14:47
 */
public enum CommissionStatus {
  NOT_REGIST(0, "未注册"),
  REGIST(1, "已注册"),
  COMSUME(2, "已消费"),
  OTHER(3, "其他人推荐成功"),
  REFUND(4, "已退款"),
  ;

  private Integer val;

  private String desc;

  CommissionStatus(Integer val, String desc){
    this.val = val;
    this.desc = desc;
  }

  public Integer getVal() {
    return val;
  }

  public String getDesc() {
    return desc;
  }
}
