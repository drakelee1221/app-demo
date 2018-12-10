package com.drakelee.demo.common.constants.product;

/**
 * RefundLogOperType
 *
 * @author <a href="929592332@qq.com">wangXin</a>
 * @version v1.0.0
 * @date 2018-11-14 15:10
 */
public enum RefundLogOperType {
  request_refund("申请退款",0),
  refuse_refund("拒绝退款",1),
  confirm_refund("同意退款",2);

  private String desc;
  private Integer val;

  RefundLogOperType(String desc, int val) {
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
