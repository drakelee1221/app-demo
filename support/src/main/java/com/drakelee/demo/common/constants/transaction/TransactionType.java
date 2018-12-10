package com.drakelee.demo.common.constants.transaction;

import java.math.BigDecimal;

/**
 * 交易流水表交易类型
 *
 * @author <a href="tecyun@foxmail.com">Huangyunyang</a>
 * @version 1.0.0, 2018/3/19 0019 17:05
 */
public enum TransactionType {

  /**
   * 充值
   */
  RECHARGE(0, "+"),

  /**
   * 提现
   */
  WITHDRAW(1, "-"),

  /**
   * 线上消费
   */
  ONLINE_CONSUME(2, "-"),

  /**
   * 线下消费
   */
  OFFLINE_CONSUME(3, "-"),

  /**
   * 线上退款
   */
  ONLINE_REFUND(4, "-"),

  /**
   * 线下退款
   */
  OFFLINE_REFUND(5, "-"),

  /**
   * 活动
   */
  PROMOTION(6, "+"),
  /**
   * 分享
   */
  SHARE(7, "+"),
  /**
   * 用户申请退款时，冻结该笔订单赠送用户金额，实际交易流水减去余额
   */
  USER_REFUND_FREEZE_ORDER_GIFT_AMOUNT(8, "-"),
  /**
   * 用户申请退款时，冻结该笔订单赠送该用户推送用户金额，实际交易流水减去余额
   */
  REFERRER_USER_REFUND_FREEZE_ORDER_GIFT_AMOUNT(9, "-"),
  /**
   * 后端管理人员拒绝退款时，解冻下单用户赠送金额，实际交易流水增加金额
   */
  USER_REFUND_THAW_ORDER_GIFT_AMOUNT(10, "+"),
  /**
   * 后端管理人员拒绝退款时，解冻其下单用户的推荐用户赠送金额，实际交易流水增加金额
   */
  REFERRER_USER_REFUND_THAW_ORDER_GIFT_AMOUNT(11, "+"),
  /**
   * 后端管理人员同意退款状态，实际交易流水状态有冻结状态改为用户退款状态
   */
  USER_REFUND_ORDER_GIFT_AMOUNT(12, "-"),
  /**
   * 后端管理人员同意退款状态，实际交易流水状态有冻结状态改为推荐用户退款状态
   */
  REFERRER_USER_REFUND_ORDER_GIFT_AMOUNT(13, "-"),
  /**
   * 渠道分销分成收益
   */
  DISTRIBUTION_AMOUNT(14, "+"),
  ;

  private int val;

  private String symbol;

  TransactionType(int val, String symbol) {
    this.val = val;
    this.symbol = symbol;
  }

  public int getVal() {
    return val;
  }

  public String getSymbol() {
    return symbol;
  }

  public BigDecimal getAfterBanlance(BigDecimal amount, BigDecimal beforeBanlance) {
    switch (this) {
      case RECHARGE:
      case ONLINE_REFUND:
        return beforeBanlance.add(amount);
      case WITHDRAW:
      case ONLINE_CONSUME:
        return beforeBanlance.subtract(amount);
      default:
        return beforeBanlance;
    }
  }

}
