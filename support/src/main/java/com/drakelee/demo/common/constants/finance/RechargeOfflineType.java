package com.drakelee.demo.common.constants.finance;

/**
 * RechargeOfflineType
 *
 * @author < a href=" ">zhangyang</ a>
 * @version v1.0.01
 * @date 2018-06-26 12:46
 */
public enum  RechargeOfflineType {

  /**
   * 0.支付宝
   */
  TYPE_ALI(0,""),
  /**
   * 微信
   */
  TYPE_WECHAT(1,""),
  /**
   *  2.银行转账
   */
  TYPE_BANK(2,""),
  /**
   *  3.现金
   */
  TYPE_CASH(3,""),
  /**
   *  4.刷卡
   */
  TYPE_PAY(4,""),
  /**
   *  5.其他）
   */
  TYPE_OTHER(5,""),
  /**
   *（0.审核中
   */
  STATUS_INFO(0,"提交了线下充值申请"),
  /**
   * 0.审核失败重新提交
   */
  STATUS_FAIL_AGAIN(0,"重新提交线下充值入账申请"),
  /**
   * 0.撤销重新提交
   */
  STATUS_UNDO_AGAIN(0,"撤销后重新提交线下充值入账申请"),
  /**
   * 1.审核通过
   */
  STATUS_SUCCESS(1,"审核通过了该条线下充值入账申请"),
  /**
   * 2.审核失败
   */
  STATUS_FAIL(2,"线下充值入账申请审核失败"),

  /**
   * 3.入账完成
   */
  STATUS_COMPLETE(3,"线下充值入账申请入账成功"),
  /**
   * 4.撤销
   */
  STATUS_UNDO(4,"线下充值入账申请被申请人撤销"),
  /**
   *  5.作废）
   */
  STATUS_INVALID(5,"线下充值入账申请被申请人作废");

  private int status;
  private String message;

  RechargeOfflineType(int status,String message){
    this.status = status;
    this.message = message;
  }

  public int getStatus(){
    return status;
  }
  public String getMessage(){
    return message;
  }
}
