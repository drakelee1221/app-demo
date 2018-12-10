package com.drakelee.demo.common.constants.product;

/**
 * RefundStatus
 * 退款状态
 * @author <a href="929592332@qq.com">wangXin</a>
 * @version v1.0.0
 * @date 2018-11-09 11:00
 */
public enum RefundStatus {
  pending_refund("待退款",0),
  refunded("已退款",1),
  refuse_refund("拒绝退款",2);
  private String desc;
  private Integer val;

  RefundStatus(String desc, int val) {
    this.desc = desc;
    this.val = val;
  }

  public String getDesc() {
    return desc;
  }

  public Integer getVal() {
    return val;
  }
}
